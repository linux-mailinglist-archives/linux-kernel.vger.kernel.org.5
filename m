Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84A57AB498
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjIVPSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjIVPSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:18:33 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736F3122;
        Fri, 22 Sep 2023 08:18:27 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 04FE5968;
        Fri, 22 Sep 2023 17:16:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695395808;
        bh=2J9SlBU+ytt0y3KvMFmzHUbWbCAyEXh4/rzIlFpUB0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ct7MuQZ/eQBmDokZWM1/hhuJFkZMWrbUO5xFmdhrmhCaxW1seVYTzX/OLB4sj4aVS
         xIw1Fa8XJ7OYNKIviYH9lf91nEnJk23dfvEDtzC8Gj8gjIlZ2HpCGyFj0YAzDM40jJ
         +Az23dSDP0ZyqhxCsO2maTWGxd2oOT3XWV+RsVVQ=
Date:   Fri, 22 Sep 2023 18:18:38 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Martijn Braam <martijn@brixit.nl>
Cc:     Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: rkisp1: Promote link validation error to dev_err
Message-ID: <20230922151838.GA22696@pendragon.ideasonboard.com>
References: <20230719145534.9812-1-martijn@brixit.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230719145534.9812-1-martijn@brixit.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martijn,

Thank you for the patch.

On Wed, Jul 19, 2023 at 04:55:33PM +0200, Martijn Braam wrote:
> Show an error when the pipeline cannot start due to an invalid link
> instead of hiding it behind the debugging system.

While this can help debugging issues in applications, allowing
unpriviledged applications to control messages being printed to the
kernel log is frowned upon, is it could flood the log. This is why these
messages use dev_dbg() and not dev_err().

> Signed-off-by: Martijn Braam <martijn@brixit.nl>
> ---
>  drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> index 8f3cba319762..9361b9086f6b 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> @@ -1340,7 +1340,7 @@ static int rkisp1_capture_link_validate(struct media_link *link)
>  	if (sd_fmt.format.height != cap->pix.fmt.height ||
>  	    sd_fmt.format.width != cap->pix.fmt.width ||
>  	    sd_fmt.format.code != fmt->mbus) {
> -		dev_dbg(cap->rkisp1->dev,
> +		dev_err(cap->rkisp1->dev,
>  			"link '%s':%u -> '%s':%u not valid: 0x%04x/%ux%u != 0x%04x/%ux%u\n",
>  			link->source->entity->name, link->source->index,
>  			link->sink->entity->name, link->sink->index,

-- 
Regards,

Laurent Pinchart
