Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1240D766E03
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbjG1NW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbjG1NWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:22:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4303B1FC8;
        Fri, 28 Jul 2023 06:22:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE2AF62139;
        Fri, 28 Jul 2023 13:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD2BC433C8;
        Fri, 28 Jul 2023 13:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690550543;
        bh=W/bcRxC7HKPq+WV1f0L7wqNL6qKipJr/pW8p28YHdiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WRfiWNezqz7bKg30pZXD9X14kxEezE9wiYwkdXSnfB9e+W2dalsxwO+Ip8ZQuQ4kI
         49CdbPIsyF8p+LM4O80t51G+DEGUm8blJxgq8PTJsh/LGn/lN28HdcE3PM/U9TfJ2+
         dBcI+nCVLbcN38q9DDzvYOcCcjUxVlp77CpntqV8yxVWTBgozAzX/YpQLpCPnrJlz5
         cMzM2yTUOo47ItovedppYQM4XN6YXyRNnihXTUxD2QNB2Mh5/SWATuzDw/pLSEijwL
         CQaZuhmta93WbqOlceD4iFd6vElUnKsoNOdEJI1vw9Qh263vGKqEH3r6rFufzRUtQw
         MII83kK+lAC3g==
Date:   Fri, 28 Jul 2023 14:22:17 +0100
From:   Will Deacon <will@kernel.org>
To:     Besar Wicaksono <bwicaksono@nvidia.com>, suzuki.poulose@arm.com
Cc:     robin.murphy@arm.com, ilkka@os.amperecomputing.com,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, vsethi@nvidia.com, rwiley@nvidia.com,
        efunsten@nvidia.com
Subject: Re: [PATCH v5] perf: arm_cspmu: Separate Arm and vendor module
Message-ID: <20230728132216.GA21394@willie-the-truck>
References: <20230705104745.52255-1-bwicaksono@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705104745.52255-1-bwicaksono@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 05:47:45AM -0500, Besar Wicaksono wrote:
> Arm Coresight PMU driver consists of main standard code and
> vendor backend code. Both are currently built as a single module.
> This patch adds vendor registration API to separate the two to
> keep things modular. The main driver requests each known backend
> module during initialization and defer device binding process.
> The backend module then registers an init callback to the main
> driver and continue the device driver binding process.
> 
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> ---
> 
> Changes from v4:
>  * Fix warning reported by kernel test robot
> v4: https://lore.kernel.org/linux-arm-kernel/20230620041438.32514-1-bwicaksono@nvidia.com/T/#u

One minor comment below, but this mostly looks good to me. I'd like Suzuki's
Ack before I queue it, though.

> +	/* Load implementer module and initialize the callbacks. */
> +	if (match) {
> +		mutex_lock(&arm_cspmu_lock);
> +
> +		if (match->impl_init_ops) {
> +			if (try_module_get(match->module)) {
> +				cspmu->impl.match = match;
> +				ret = match->impl_init_ops(cspmu);
> +				module_put(match->module);

Why is it safe to drop the module reference here? If I'm understanding the
flow correctly, ->impl_init_ops() will populate more function pointers
in the cspmu->impl.ops structure, and we don't appear to take a module
reference when calling those.

What happens if the backend module is unloaded while the core module
is executed those functions?

Cheers,

Will
