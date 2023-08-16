Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421E277E378
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343579AbjHPOWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343585AbjHPOWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:22:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0080B2705
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:22:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A94D61FDA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64D3C433C8;
        Wed, 16 Aug 2023 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692195744;
        bh=zJNWoRzvigLWHBNjpuNAJOa1sNUOYFAS8Jy3IBQ7uac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A+CcO/ap0uyWcawKXLPisbB5Gx59/Y/8qiic+jJYjpbK0vb5wOM2SO+vZgDLMoQx1
         U/IkJ7QsvM/JnFvgOuekucw3oVlHN4XEvX9kwOLDj9S569hTsjXiLIJGrmRDn/V61C
         V3MPnqPxmZ2R7Bm/paAsy2TtsX+AThjpGJLXSIZwfC3n4M3kazF5Kq68EpXL6ghmKS
         EHMGtDy0evB6KmQOxqCOmdrxMKarcTa7fFge2Mx5IBlkQGizCSHprxgStM9E+64qj+
         X2T8OmTqWR7jbMxVXCvyMoW/0pqPYj5uVbmMApLs38920hWD6bRbQK2knUbQbImGh6
         S2h10K1yFnQ0w==
Date:   Wed, 16 Aug 2023 15:22:19 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Spickett <David.Spickett@arm.com>
Subject: Re: [PATCH] arm64/ptrace: Ensure that the task sees ZT writes on
 first use
Message-ID: <20230816142219.GA13526@willie-the-truck>
References: <20230814-arm64-zt-ptrace-first-use-v1-1-fc8e8022140f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814-arm64-zt-ptrace-first-use-v1-1-fc8e8022140f@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 10:27:51PM +0100, Mark Brown wrote:
> When the value of ZT is set via ptrace we don't disable traps for SME.
> This means that when a the task has never used SME before then the value
> set via ptrace will never be seen by the target task since it will
> trigger a SME access trap which will flush the register state.
> 
> Disable SME traps when setting ZT, this means we also need to allocate
> storage for SVE if it is not already allocated, for the benefit of
> streaming SVE.
> 
> Fixes: f90b529bcbe5 ("arm64/sme: Implement ZT0 ptrace support")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kernel/ptrace.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 5b9b4305248b..254eb37e1f07 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -1170,6 +1170,11 @@ static int zt_set(struct task_struct *target,
>  	if (!system_supports_sme2())
>  		return -EINVAL;
>  
> +	/* Ensure SVE storage in case this is first use of SME */
> +	sve_alloc(target, false);
> +	if (!target->thread.sve_state)
> +		return -ENOMEM;
> +
>  	if (!thread_za_enabled(&target->thread)) {
>  		sme_alloc(target);
>  		if (!target->thread.sme_state)
> @@ -1182,6 +1187,8 @@ static int zt_set(struct task_struct *target,
>  	if (ret == 0)
>  		target->thread.svcr |= SVCR_ZA_MASK;
>  
> +	set_tsk_thread_flag(target, TIF_SME);

Hmm, this is now weirdly inconsistent with za_set(), which doesn't touch
the thread flag unless the regset copy succeeds. Is that intentional?

Will
