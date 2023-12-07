Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22078086EF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378905AbjLGLpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjLGLpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:45:01 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B58D19A;
        Thu,  7 Dec 2023 03:45:08 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A3C61552;
        Thu,  7 Dec 2023 12:44:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701949465;
        bh=NACyl09AvpTrdZ3tNyR3vmOK5XRdr6IgtkAqVWbjgtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TsClYi8HjV965xFtDpO6Jo40j59Fkg4dPlOdu1vHFICbtYuHYx2unsL6Yra6y8vuQ
         zl5D9A+a1lMkGLwQ7fXCK4gnJXFlFQ9xnyz99OVGEN2/Vm1NHZ7nMTbemPeivSKvc/
         KbLxucFyLWA0PcbG9eSjH6+xN4Ahlg1xK90Q7zRo=
Date:   Thu, 7 Dec 2023 13:45:13 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Zhi Mao <zhi.mao@mediatek.com>
Cc:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shengnan.wang@mediatek.com,
        yaya.chang@mediatek.com, 10572168@qq.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        yunkec@chromium.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        jacopo.mondi@ideasonboard.com, sakari.ailus@linux.intel.com,
        hverkuil-cisco@xs4all.nl, heiko@sntech.de,
        jernej.skrabec@gmail.com, macromorgan@hotmail.com,
        linus.walleij@linaro.org, hdegoede@redhat.com,
        tomi.valkeinen@ideasonboard.com, gerald.loacker@wolfvision.net,
        andy.shevchenko@gmail.com, bingbu.cao@intel.com,
        dan.scally@ideasonboard.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 0/2] media: i2c: Add support for GC08A3 sensor
Message-ID: <20231207114513.GB6104@pendragon.ideasonboard.com>
References: <20231207052016.25954-1-zhi.mao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231207052016.25954-1-zhi.mao@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhi Mao,

I have reviewed your v1 before noticing the v2, sorry about that. Most
of the comments I made on v1 are still applicable, so I'll skip v2 and
review v3.

On Thu, Dec 07, 2023 at 01:20:14PM +0800, Zhi Mao wrote:
> This series adds YAML DT binding and V4L2 sub-device driver for Galaxycore's
> GC08A3 8-megapixel 10-bit RAW CMOS 1/4" sensor, with an MIPI CSI-2 image data
> interface and the I2C control bus.
> 
> The driver is implemented with V4L2 framework.
>  - Async registered as a V4L2 sub-device.
>  - As the first component of camera system including Seninf, ISP pipeline.
>  - A media entity that provides one source pad in common.
>  - Used in camera features on ChromeOS application.
> 
> Also this driver supports following features:
>  - manual exposure and analog gain control support
>  - vertical blanking control support
>  - test pattern support
>  - media controller support
>  - runtime PM support
>  - support resolution: 3264x2448@30fps, 1920x1080@60fps
> 
> Previous versions of this patch-set can be found here:
>  v1: https://lore.kernel.org/linux-media/20231123115104.32094-1-zhi.mao@mediatek.com/
> 
> Changes of v2 mainly address comments from Krzysztof/Rob Herring&Conor Dooley.
> Compared to v1:
>   - Fix some review comments  
>   - Add reviewed-by for sensor driver
>   - Fix some build-error and warning message 
>  
> Thanks
> 
> 
> Zhi Mao (2):
>   media: i2c: Add GC08A3 image sensor driver
>   media: dt-bindings: media: i2c: Document GC08A3 bindings
> 
>  .../bindings/media/i2c/galaxycore,gc08a3.yaml |  127 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
>  drivers/media/i2c/Kconfig                     |   14 +
>  drivers/media/i2c/Makefile                    |    1 +
>  drivers/media/i2c/gc08a3.c                    | 1888 +++++++++++++++++
>  5 files changed, 2032 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,gc08a3.yaml
>  create mode 100644 drivers/media/i2c/gc08a3.c

-- 
Regards,

Laurent Pinchart
