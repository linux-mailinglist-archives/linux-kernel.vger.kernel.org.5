Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A9C79C2B0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbjILCXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbjILCXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:23:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B402213B51E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:47:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6860C116AF;
        Mon, 11 Sep 2023 23:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694474171;
        bh=Oleg9TJC+AKMIQSbLWxgrU0AxqMUMBEa9ZbYFKCkri0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kSdaMriAlU8GQInb0AOV1OrCTNMMt2tUj6Cx9/LGyQUdzT8afM7Ti40wvIH9oaIGY
         cNydm7/eRwDhhL4viT0P+BazWi/jWTtwGBivEI0xbPvCG17l9J5DM+tIT3fU/NE1e3
         tlHVzOgLTRg0fVPlhOVudi7e6cjNoiUbqFjoXJGaQFr+WFyX1a6+Jvut+OIEh49Ld3
         ffyf6OjObXsHY1Mg0qm79IEf8cvVn72HwlLxiVKLFM9ovckbFiLnCbHQ3L+fLtT/4l
         IuxIyBbJBTLwyboUGIS7o5z8xc3c/LMp4HxPnvI6fRBC0Lr2DtcleWHaUaZNau9Srz
         xRAleNAf8q0Hg==
Date:   Mon, 11 Sep 2023 16:16:09 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Felix Yan <felixonmars@archlinux.org>
Cc:     highenthalpyh@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, xuwd1@hotmail.com
Subject: Re: [PATCH] nvme-pci: ignore bogus CRTO according to NVME 2.0 spec
Message-ID: <ZP-fuXyCZvnUbt8K@kbusch-mbp.dhcp.thefacebook.com>
References: <20230908155442.31423-1-felixonmars@archlinux.org>
 <ZP-cGgPzIX7WkNRb@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP-cGgPzIX7WkNRb@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 04:00:42PM -0700, Keith Busch wrote:
> @@ -2257,12 +2258,15 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>  
>  		if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
>  			ctrl->ctrl_config |= NVME_CC_CRIME;
> -			timeout = NVME_CRTO_CRIMT(crto);
> +			/*
> +			 * CRIMT should always be greater or equal to CAP.TO,
> +			 * but some devices are known to get this wrong. Use
> +			 * the larger of the two values.
> +			 */
> +			timeout = max(timeout, NVME_CRTO_CRIMT(crto));
>  		} else {
>  			timeout = NVME_CRTO_CRWMT(crto);
>  		}

Er... please pretend I added the "max()" handling in the 'else' case
instead of the CRIMS case.

-- >8 --
@@ -2259,10 +2260,13 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 			ctrl->ctrl_config |= NVME_CC_CRIME;
 			timeout = NVME_CRTO_CRIMT(crto);
 		} else {
-			timeout = NVME_CRTO_CRWMT(crto);
+			/*
+			 * CRWMT should always be greater or equal to CAP.TO,
+			 * but some devices are known to get this wrong. Use
+			 * the larger of the two values.
+			 */
+			timeout = max(timeout, NVME_CRTO_CRWMT(crto));
 		}
