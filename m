Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FE67D487A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjJXHZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjJXHZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:25:48 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1302FB7;
        Tue, 24 Oct 2023 00:25:47 -0700 (PDT)
Received: from ideasonboard.com (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CBF7DB53;
        Tue, 24 Oct 2023 09:25:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698132334;
        bh=4n5YPDRKUKpP21ebpJDoR3ei0XoBIXxtELRuhpW0Ly4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hphYbLp1Dl8TW9QvF4/7qRviM6nvZoBlEyPON3PD/gF16WKqlsWNFi4Vxdx9IqAAx
         xe81B3LKqN2H1uKaKWNwXbFhqMzmtPMAMJ8tkY3um+HufG72w7luR1ChLtKWgLwdMU
         S6pMzifMDsaw4zBnC+/6wTWjSbZGCC80JCndsjIY=
Date:   Tue, 24 Oct 2023 09:25:43 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     =?utf-8?B?QW5kcsOp?= Apitzsch <git@apitzsch.eu>
Cc:     Ricardo Ribalda <ribalda@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 3/4] media: i2c: imx214: Read orientation and rotation
 from system firmware
Message-ID: <f5473dfqqvk4icxjyw6svyho4k7cnlhctuhbjpoilcqexywnsx@drpzog3q7doy>
References: <20231023-imx214-v1-0-b33f1bbd1fcf@apitzsch.eu>
 <20231023-imx214-v1-3-b33f1bbd1fcf@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231023-imx214-v1-3-b33f1bbd1fcf@apitzsch.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre'

On Mon, Oct 23, 2023 at 11:47:52PM +0200, André Apitzsch wrote:
> Obtain rotation and orientation information from system firmware and
> register the appropriate controls.
>
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
>  drivers/media/i2c/imx214.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
> index 554fc4733128..bef8dc36e2d0 100644
> --- a/drivers/media/i2c/imx214.c
> +++ b/drivers/media/i2c/imx214.c
> @@ -704,9 +704,14 @@ static int imx214_ctrls_init(struct imx214 *imx214)
>  		.width = 1120,
>  		.height = 1120,
>  	};
> +	struct v4l2_fwnode_device_properties props;
>  	struct v4l2_ctrl_handler *ctrl_hdlr;
>  	int ret;
>
> +	ret = v4l2_fwnode_device_parse(imx214->dev, &props);
> +	if (ret < 0)
> +		return ret;
> +
>  	ctrl_hdlr = &imx214->ctrls;
>  	ret = v4l2_ctrl_handler_init(&imx214->ctrls, 3);
>  	if (ret)
> @@ -746,6 +751,8 @@ static int imx214_ctrls_init(struct imx214 *imx214)
>  				V4L2_CID_UNIT_CELL_SIZE,
>  				v4l2_ctrl_ptr_create((void *)&unit_size));
>
> +	v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &imx214_ctrl_ops, &props);
> +

I think it's fine not checking the return value of
v4l2_ctrl_new_fwnode_properties() if you inspect ctrl_hdlr->error just
after

Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>

Thanks
  j

>  	ret = ctrl_hdlr->error;
>  	if (ret) {
>  		v4l2_ctrl_handler_free(ctrl_hdlr);
>
> --
> 2.42.0
>
