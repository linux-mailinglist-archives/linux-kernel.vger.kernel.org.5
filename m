Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A9B78B754
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjH1SiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjH1Shv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:37:51 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFCA1A5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:37:40 -0700 (PDT)
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D77CB2D8;
        Mon, 28 Aug 2023 20:36:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693247778;
        bh=vQIOl5TrRlEiCDa3NnrA7tdFPfjvz0tpmDMx1JbNVeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HwFkXUXbuyv2H+/Gua71GCyAGbIKfSHLr9P+aDwm8V9GhNutDxMoX95M66bzhbmVD
         bIcH5wUcGToby/5RwI+zdSKlRinKotknQpoPPwTJuIKHPt1B7GD/bCfNPUhdWo+AeP
         o3KQK3/gnYzHqjVstKbfELgBQzd8cqPw9iYpdUJw=
Date:   Mon, 28 Aug 2023 21:37:48 +0300
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
Message-ID: <20230828183748.GK14596@pendragon.ideasonboard.com>
References: <tencent_026E4B04ACDCE341411EF54862F8C6AB1605@qq.com>
 <20230828172822.GE14596@pendragon.ideasonboard.com>
 <tencent_2E893742B5115B5260081E410A34A89E1208@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_2E893742B5115B5260081E410A34A89E1208@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 02:01:25AM +0800, Zhang Shurong wrote:
> 在 2023年8月29日星期二 CST 上午1:28:22，Laurent Pinchart 写道：
> > Hi Zhang,
> > 
> > Thank you for the patch.
> > 
> > On Tue, Aug 29, 2023 at 12:55:01AM +0800, Zhang Shurong wrote:
> > > of_match_device() may fail and returns a NULL pointer.
> > 
> > How can it return a NULL pointer here ?
> > 
> > > Fix this by checking the return value of of_match_device().
> > > 
> > > Fixes: 3818715f62b4 ("drm/bridge: imx: Add LDB support for i.MX8qxp")
> > > Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> > > ---
> > > 
> > >  drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
> > > b/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c index
> > > 7984da9c0a35..d272f35c8eac 100644
> > > --- a/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
> > > +++ b/drivers/gpu/drm/bridge/imx/imx8qxp-ldb.c
> > > @@ -488,6 +488,8 @@ static int imx8qxp_ldb_parse_dt_companion(struct imx8qxp_ldb *imx8qxp_ldb)
> > >  	 * string.
> > >  	 */
> > >  	match = of_match_device(dev->driver->of_match_table, dev);
> > > +	if (!match)
> > > +		return -ENODEV;
> > >  	if (!of_device_is_compatible(companion, match->compatible)) {
> > >  		DRM_DEV_ERROR(dev, "companion LDB is incompatible\n");
> > >  		ret = -ENXIO;
>
> I think we can make it happen by designing the platform device in a way that 
> its name aligns with that of the driver. In such a scenario, when the driver 
> is probed, the of_match_device function will return null. You can verify this 
> functionality by reviewing the following function:
> 
> static int platform_match(struct device *dev, struct device_driver *drv)

This particular device is found in OF-based systems only, and only
instantiated through DT. You can create a platform_device manually that
may match this driver, but that would be a made-up situation, not
something that can happen in practice.

-- 
Regards,

Laurent Pinchart
