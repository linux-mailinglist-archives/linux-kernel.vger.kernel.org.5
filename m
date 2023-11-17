Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1B77EF1B7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 12:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345808AbjKQL3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 06:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjKQL3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 06:29:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FD8C2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 03:29:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C83C433C8;
        Fri, 17 Nov 2023 11:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700220582;
        bh=89KndrKS5WwsB8Pvxs+BPPiLG9GvCOcLklC/ispQ7n8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fuQhizcehIzwmjzCARahKhxQIzi/xWaj7fVh0xV5qF8d4h3otKYdQMAhqfIDtDAYy
         Iej4CBvmbWgbx+5OezzGmY0FiNXVzjeLwbr42Lqdpji/R8BRKb4s9aSf4CPismpUkT
         zKyn6++uiuvPj+OT2FHykbdGlbB93GrOdfXUQ6mEauJ8GuvuBnn8oXqHODSeJ9Bn2o
         U3pp/9ww+UgKvg6yd8k4yfZOxzGvEBa+cyohNUTN6/prxkfJYHPMFhVFVS0JWB8R2e
         bqa59mXhBhsG0rZIliZgf/ju443aag/v19TbknQDCT4wf5qkSEnitirQQ8Kd3uG3OL
         N2G528SydufnQ==
Date:   Fri, 17 Nov 2023 11:29:37 +0000
From:   Will Deacon <will@kernel.org>
To:     Enlin Mu <enlin.mu@outlook.com>
Cc:     catalin.marinas@arm.com, enlin.mu@unisoc.com, enlinmu@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: remove kaslr-seed node when it had used
Message-ID: <20231117112936.GA28997@willie-the-truck>
References: <TYSPR04MB7084AFDB414AA7AE49A02D608AB2A@TYSPR04MB7084.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYSPR04MB7084AFDB414AA7AE49A02D608AB2A@TYSPR04MB7084.apcprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 09:55:51PM +0800, Enlin Mu wrote:
> From: Enlin Mu <enlin.mu@unisoc.com>
> 
> If this node value is zero,it means that kaslr is enabled.
> Removing it for the system safe,nobody knows if this feature is
> enable or not.
> 
> Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
> ---
>  arch/arm64/kernel/pi/kaslr_early.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/pi/kaslr_early.c b/arch/arm64/kernel/pi/kaslr_early.c
> index 17bff6e399e4..bc35d4ed84b7 100644
> --- a/arch/arm64/kernel/pi/kaslr_early.c
> +++ b/arch/arm64/kernel/pi/kaslr_early.c
> @@ -81,7 +81,7 @@ static u64 get_kaslr_seed(void *fdt)
>  		return 0;
>  
>  	ret = fdt64_to_cpu(*prop);
> -	*prop = 0;
> +	fdt_nop_property(fdt, node, "kaslr-seed");
>  	return ret;
>  }

Why is it a problem to know that KASLR is enabled? Wouldn't the presence
of the FDT_NOPs also give a pretty good hint?

Will
