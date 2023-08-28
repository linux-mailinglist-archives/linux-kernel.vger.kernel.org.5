Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6260A78B66E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjH1R2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjH1R2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:28:17 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3984012A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:28:15 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8EF175AA;
        Mon, 28 Aug 2023 19:26:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693243612;
        bh=eJNgE5A2Oc+9HepIe/SpnMELLL/klKBosOpPUS0JGNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j5wqfKislpr+uUXmhUgG/zFj+1evrnIt2E54qcPYPhXFYYyNxpd1eR3UbVvd325Ab
         ofJMbso5w/WwdRX20NwtygidpX44Pv2TkqPym+vbda1IaniriWZt7aTQPe0lyn23xC
         e1zevjRQw8hiWufyUsPvL6PeEY+MmZw/opni4d30=
Date:   Mon, 28 Aug 2023 20:28:22 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     victor.liu@nxp.com, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: imx: fix potential NULL pointer dereference
 in imx8qxp_ldb_parse_dt_companion()
Message-ID: <20230828172822.GE14596@pendragon.ideasonboard.com>
References: <tencent_026E4B04ACDCE341411EF54862F8C6AB1605@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tencent_026E4B04ACDCE341411EF54862F8C6AB1605@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhang,

Thank you for the patch.

On Tue, Aug 29, 2023 at 12:55:01AM +0800, Zhang Shurong wrote:
> of_match_device() may fail and returns a NULL pointer.

How can it return a NULL pointer here ?

> Fix this by checking the return value of of_match_device().
> 
> Fixes: 3818715f62b4 ("drm/bridge: imx: Add LDB support for i.MX8qxp")
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---
>  drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c b/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
> index 7984da9c0a35..d272f35c8eac 100644
> --- a/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
> +++ b/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
> @@ -488,6 +488,8 @@ static int imx8qxp_ldb_parse_dt_companion(struct imx8qxp_ldb *imx8qxp_ldb)
>  	 * string.
>  	 */
>  	match = of_match_device(dev->driver->of_match_table, dev);
> +	if (!match)
> +		return -ENODEV;
>  	if (!of_device_is_compatible(companion, match->compatible)) {
>  		DRM_DEV_ERROR(dev, "companion LDB is incompatible\n");
>  		ret = -ENXIO;

-- 
Regards,

Laurent Pinchart
