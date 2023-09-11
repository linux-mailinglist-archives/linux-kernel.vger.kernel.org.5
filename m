Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EC379C206
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbjILB5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbjILB4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:56:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34111B3124
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:27:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62466C116A1;
        Mon, 11 Sep 2023 23:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694473244;
        bh=4t1Rotwjd0kPAr8x16QEIpXqAf/qksX10Q+H2SVT2F4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dEgLYmxbB/d6gCzzPDBlBwEKakUUj6SQeXdRGz+a5eRXIaYlxifcvZjtAeyWax4HC
         RW06DzV4t51ouN59aehj4AteyKLpAYlCGhASP5QJzy2hjWDMWZgJhOMHVbfHQUv2B9
         btdZ+7p+8IgQFQzRyae6vuKPBYvuM/R5lkDoBaG3y8aGtumwRSdYjW0W4RgaKnmwTc
         nM9tX19DQolDcnXGNMQgHEFC0xwP/BdEEjpYpo6m8ynTosKZhm6wrSs2HbHwaT01qu
         UZJkGF75nKHYhEt6J2hiSaqeq0VGuNspQwFnef8iolMWSV9E0a9zq/xRdfUtfpJsiM
         hnzxJ2QjnXjIQ==
Date:   Mon, 11 Sep 2023 16:00:42 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Felix Yan <felixonmars@archlinux.org>
Cc:     highenthalpyh@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, xuwd1@hotmail.com
Subject: Re: [PATCH] nvme-pci: ignore bogus CRTO according to NVME 2.0 spec
Message-ID: <ZP-cGgPzIX7WkNRb@kbusch-mbp.dhcp.thefacebook.com>
References: <20230908155442.31423-1-felixonmars@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908155442.31423-1-felixonmars@archlinux.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 06:54:42PM +0300, Felix Yan wrote:
> NVME 2.0 spec section 3.1.3 suggests that "Software should not rely on
> 0h being returned". Here we should safeguard timeout reads when CRTO is 0 and
> fallback to the old NVME 1.4 compatible field.
> 
> Fixes 4TB SSD initialization issues with MAXIO MAP1602 controller, including
> Lexar NM790, AIGO P7000Z, Fanxiang S790, Acer Predator GM7, etc.
> 
> ----------
> nvme nvme1: Device not ready; aborting initialisation, CSTS=0x0
> ----------
> 
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

What do you think about this change instead? We don't need to print a
warning on every device reset, but we should probably add a comment
explaining why this is happening.

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37b6fa7466620..b4577a860e677 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2245,6 +2245,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	else
 		ctrl->ctrl_config = NVME_CC_CSS_NVM;
 
+	timeout = NVME_CAP_TIMEOUT(ctrl->cap);
 	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
 		u32 crto;
 
@@ -2257,12 +2258,15 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 
 		if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
 			ctrl->ctrl_config |= NVME_CC_CRIME;
-			timeout = NVME_CRTO_CRIMT(crto);
+			/*
+			 * CRIMT should always be greater or equal to CAP.TO,
+			 * but some devices are known to get this wrong. Use
+			 * the larger of the two values.
+			 */
+			timeout = max(timeout, NVME_CRTO_CRIMT(crto));
 		} else {
 			timeout = NVME_CRTO_CRWMT(crto);
 		}
-	} else {
-		timeout = NVME_CAP_TIMEOUT(ctrl->cap);
 	}
 
 	ctrl->ctrl_config |= (NVME_CTRL_PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
--
