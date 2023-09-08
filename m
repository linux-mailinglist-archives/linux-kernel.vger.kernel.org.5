Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1999798AE1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245149AbjIHQvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjIHQvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:51:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206961FCD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 09:51:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB10C433C9;
        Fri,  8 Sep 2023 16:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694191894;
        bh=Duyo9FbZWxq7tBrxKIe2GHDyyGZ8g2IY2MZ87INA3J0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jde24srM6yC8I6fKDgAj8ljWmlARTIcpi7LTLk0eE8NeRHQogoFRsNy0XeFIn6POQ
         9nBvTh03iFiiHJEvhtronhWrmB8Mxi52olv3u9bRovDoLRos2OGyUF6piasXiHWDO3
         2KpuFyWtsgkqwNJfCu+bEbBk4Si2oi3p+TnErrS3kx2rxzWUR87jc4vrVr4w3QMv4I
         K9eyf/UFEXAf/SKTOaHNznp1Y3w6TEWMZzZw6jU68AJIoz3fvqcu98mUAudyI97jwM
         EALfu8srBpKZkDzyqiGiUscPcJGxFvpnzJosK+sl2IbrkxWyk4fCp4xgZExX/dj48t
         YgoKXvTFCr0TA==
Date:   Fri, 8 Sep 2023 10:51:30 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Felix Yan <felixonmars@archlinux.org>
Cc:     highenthalpyh@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, xuwd1@hotmail.com
Subject: Re: [PATCH] nvme-pci: ignore bogus CRTO according to NVME 2.0 spec
Message-ID: <ZPtREsG8XGGEFgg4@kbusch-mbp.dhcp.thefacebook.com>
References: <20230908155442.31423-1-felixonmars@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908155442.31423-1-felixonmars@archlinux.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 06:54:42PM +0300, Felix Yan wrote:
> NVME 2.0 spec section 3.1.3 suggests that "Software should not rely on
> 0h being returned". Here we should safeguard timeout reads when CRTO is 0 and
> fallback to the old NVME 1.4 compatible field.

Not sure I follow what you're saying here. We're not really relying on
CRTO being 0. It was a non-zero capability bit that told the driver to
use CRTO, and 0 is potentially a valid value a controller could report.

> Fixes 4TB SSD initialization issues with MAXIO MAP1602 controller, including
> Lexar NM790, AIGO P7000Z, Fanxiang S790, Acer Predator GM7, etc.

This patch makes more sense, thanks for getting to the bottom of it.

So the device reports CRWMS capability. The host is supposed to use the
CRTO.CRWMT in that case, and 0 could be legit. But spec also says CAP.TO
must match CTRO.CRWMT if it's less than 0xff. This obviously doesn't, so
your patch looks like a reasonable fallback to me. Maybe always just set
timeout to the bigger of the two values since CRWMT isn't reliable if
it's ever smaller than CAP.TO.

	timeout = max(NVME_CRTO_CRWMT(crto), NVME_CAP_TIMEOUT(ctrl->cap));

I'll add the Cc: stable when apply so they are sure to pick this up.
I'll just wait for next Monday to apply in case there any other reviewer
comments.

> Signed-off-by: Felix Yan <felixonmars@archlinux.org>
> ---
>  drivers/nvme/host/core.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f3a01b79148c..8ec28b1016ca 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2255,11 +2255,17 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>  			return ret;
>  		}
>  
> -		if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
> -			ctrl->ctrl_config |= NVME_CC_CRIME;
> -			timeout = NVME_CRTO_CRIMT(crto);
> +		if (crto == 0) {
> +			timeout = NVME_CAP_TIMEOUT(ctrl->cap);
> +			dev_warn(ctrl->device, "Ignoring bogus CRTO (0), falling back to NVME_CAP_TIMEOUT (%u)\n",
> +				timeout);
>  		} else {
> -			timeout = NVME_CRTO_CRWMT(crto);
> +			if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
> +				ctrl->ctrl_config |= NVME_CC_CRIME;
> +				timeout = NVME_CRTO_CRIMT(crto);
> +			} else {
> +				timeout = NVME_CRTO_CRWMT(crto);
> +			}
>  		}
>  	} else {
>  		timeout = NVME_CAP_TIMEOUT(ctrl->cap);
> -- 
> 2.42.0
> 
