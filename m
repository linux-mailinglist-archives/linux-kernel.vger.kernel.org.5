Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2363C7F4B5B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344544AbjKVPou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbjKVPo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:44:29 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9C44493;
        Wed, 22 Nov 2023 07:42:27 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5B9FE276;
        Wed, 22 Nov 2023 16:41:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1700667714;
        bh=bn0nJ8Ndl9lU9tfsNi9BaoIDkaD6hNR0oaXanoGoHA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WsSYv/Wt9RtbEjCqnVDlohKNe7Oy5LK1lfPrHMFxE/+WMWbfeIlcOSYqt7lnZ/oXV
         E6fWt1qJ5io4vjj3tztrcNK9CkNjfZR1dxWs9ToXW2+RqV0L7pd1X19fHiCPwrUz0s
         lDwOFvs9iOoHS4QLrZOX7Fb3+STspsr4diN26pFM=
Date:   Wed, 22 Nov 2023 17:42:31 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jacob Chen <jacob2.chen@rock-chips.com>,
        Yichong Zhong <zyc@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eddie Cai <eddie.cai.linux@gmail.com>,
        Allon Huang <allon.huang@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] media: rkisp1: Fix media device memory leak
Message-ID: <20231122154231.GH3909@pendragon.ideasonboard.com>
References: <20231122-rkisp-fixes-v1-0-1958af371e39@ideasonboard.com>
 <20231122-rkisp-fixes-v1-1-1958af371e39@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122-rkisp-fixes-v1-1-1958af371e39@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

Thank you for the patch.

On Wed, Nov 22, 2023 at 04:42:22PM +0200, Tomi Valkeinen wrote:
> Add missing calls to media_device_cleanup() to fix memory leak.
> 
> Fixes: d65dd85281fb ("media: staging: rkisp1: add Rockchip ISP1 base driver")
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> index c41abd2833f1..e10cc2881757 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> @@ -617,6 +617,7 @@ static int rkisp1_probe(struct platform_device *pdev)
>  	media_device_unregister(&rkisp1->media_dev);
>  err_unreg_v4l2_dev:
>  	v4l2_device_unregister(&rkisp1->v4l2_dev);
> +	media_device_cleanup(&rkisp1->media_dev);

As media_device_cleanup() cleans up for media_device_init(), shouldn't
it go to the err_pm_runtime_disable label ? The label may need to be
renamed to err_media_cleanup then.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  err_pm_runtime_disable:
>  	pm_runtime_disable(&pdev->dev);
>  	return ret;
> @@ -637,6 +638,8 @@ static void rkisp1_remove(struct platform_device *pdev)
>  	media_device_unregister(&rkisp1->media_dev);
>  	v4l2_device_unregister(&rkisp1->v4l2_dev);
>  
> +	media_device_cleanup(&rkisp1->media_dev);
> +
>  	pm_runtime_disable(&pdev->dev);
>  }
>  

-- 
Regards,

Laurent Pinchart
