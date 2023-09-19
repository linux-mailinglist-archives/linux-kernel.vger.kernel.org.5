Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03457A62F3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjISMaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjISMaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:30:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CFBE3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:30:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C486C433C8;
        Tue, 19 Sep 2023 12:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695126603;
        bh=EtFa5rvshidZO96hC+OAr46glLz8FAGtkJNpTV8OXYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V2DJIatknYNoZV5FKgknMq5dWC1kMJ8jrAmzHkYCKGWdd6OB5JGpHKm+plcn20V3m
         0Xor9hZDxJSUdBt0J/Y6w4Z88Rd2IRsAnf0EctwWShWIX1xT5GaDu88OJmfStxfmWI
         VGhWsJimvfd6cG6nxoUkSFolmkKEhp0eJJZiTE3uOoXuZF8Xs9o0khdyZeYjUPu6op
         XwTECoP1+iEgM75AfedkO9Wnk76tf/0StLOGqHaCoVdDPuNG9Nzk7E2w5Oc9+HvwUJ
         GPsrSjTsWT76ZwQZofRxLpUu6+XWFhGDFIlFSgk5T/+XCz041sscP0tX984hM8JtQ5
         50JY72XIuu1lA==
Date:   Tue, 19 Sep 2023 14:29:57 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: add imx8mp-venice-gw74xx-imx219
 overlay for rpi v2 camera
Message-ID: <20230919122956.GD11740@T480>
References: <20230711221518.2127861-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711221518.2127861-1-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 03:15:18PM -0700, Tim Harvey wrote:
> Add support for the RaspberryPi Camera v2 which is an IMX219 8MP module:
>  - https://datasheets.raspberrypi.com/camera/camera-v2-schematics.pdf
>  - has its own on-board 24MHz osc so no clock required from baseboard
>  - pin 11 enables 1.8V and 2.8V LDO which is connected to
>    GW74xx MIPI_GPIO4 (IMX8MP GPIO1_IO4) so we use this as a gpio
> 
> Support is added via a device-tree overlay.
> 
> The IMX219 supports RAW8/RAW10 image formats.
> 
> Example configuration:
> media-ctl -l "'imx219 3-0010':0->'csis-32e40000.csi':0[1]"
> media-ctl -v -V "'imx219 3-0010':0 [fmt:SRGGB8/640x480 field:none]"
> media-ctl -v -V "'crossbar':0 [fmt:SRGGB8/640x480 field:none]"
> media-ctl -v -V "'mxc_isi.0':0 [fmt:SRGGB8/640x480 field:none]"
> v4l2-ctl --set-fmt-video=width=640,height=480,pixelformat=RGGB
> v4l2-ctl --stream-mmap --stream-to=frame.raw --stream-count=1
> convert -size 640x480 -depth 8 gray:frame.raw frame.png
> gst-launch-1.0 v4l2src ! \
>   video/x-bayer,format=rggb,width=640,height=480,framerate=10/1 ! \
>   bayer2rgb ! fbdevsink
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
