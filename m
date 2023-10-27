Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F39B7D8CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 03:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345092AbjJ0BO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 21:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0BOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 21:14:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04371BC;
        Thu, 26 Oct 2023 18:14:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40FAC433CA;
        Fri, 27 Oct 2023 01:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698369261;
        bh=jyK9XMtPWsaT4FQrOBuiO6PcqdC1YHVnaagZqHZXO2k=;
        h=From:To:Cc:Subject:Date:From;
        b=q+3GG61vCp+3gEbDSZ/PtoSW04hHLXz8BGqdVw9WBlxIINoxt+hTD5QuD8i2cLKTg
         NaUFonXvSB601rNQVlL2U0b62EszxG51y1KTXdKxxRrVKc/euenF3yHgJap6b2npGz
         fp4UlobLjNYJkmBkMIw/9e6F2g42tC4oyBe6Py1tYeIysz9wWmQELEJfNDiGGLLuzS
         tgK9wmApfmxnrW27zjfJGOcgsBjwiEGeq/gw/mNsJV5k5kp1tgYRiaYPSnw/9PJZyf
         7W/5QEiwFjIO4Fu4RAryYHcuv1R9b4+JaoeA1xcOOQNz22WLgIxWYTc9sLJl+/YYYo
         74KIfhMvSQypA==
Received: by mercury (Postfix, from userid 1000)
        id 3F8E6106057B; Fri, 27 Oct 2023 03:14:18 +0200 (CEST)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] GC0308 Camera Sensor
Date:   Fri, 27 Oct 2023 03:12:00 +0200
Message-ID: <20231027011417.2174658-1-sre@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I did the following tests done by me on an i.MX6ULL based system [0]:

 * v4l2-compliance -u /dev/v4l-subdev1
   - v4l2-compliance 1.24.1, 32 bits, 32-bit time_t
     (from Debian testing)
   - Total for device /dev/v4l-subdev1: 44, Succeeded: 44
 * Using gstreamer + v4l2-ctl
   - Tried 640x480, 320x240, 160x120 YUYV8_2X8 formats
   - Tested effect of all exposed user controls
 * checkpatch does not report any driver issues
 * dt_binding_check does not report anything

Note, that there is another patchset adding GC2145, which
adds the same vendor prefix. I just included it for completeness,
since it's needed to avoid checkpatch and dt_binding_check
warnings.

[0] https://embedded-recipes.org/2023/schedule/running-foss-thermal-camera/

Changes since PATCHv2:
 * https://lore.kernel.org/all/20231024010355.1877523-1-sre@kernel.org/
 * Simplify Kconfig dependencies
 * Do not store code/resolution; which is available from subdev state
 * Store register values for mode settings to avoid second lookup in
   s_stream
 * Reduce power_on sleep times
 * remove debug dev_err() print, that I accidently added in v2
 * add missing format check in gc0308_enum_frame_size()
 * do not PM resume in gc0308_s_ctrl()
 * enable and use runtime PM autosuspend
 * add .init_cfg() PAD op
 * use CCI helper instead of raw regmap
 * cluster both flip controls
   (that's not just a performance optimization, but fixes an issue,
   that register update is slow, so fast sequential setting of VFLIP/HFLIP
   override each other without this)
 * simplify gc0308_set_power_line_freq
 * free control handler on probe error
 * use first format by default
 * expose V4L2_CID_HBLANK, V4L2_CID_VBLANK, V4L2_CID_PIXEL_RATE
 * remove incorrect support for framerate and instead add a comment

Changes since PATCHv1:
 * https://lore.kernel.org/all/20231023002547.1754190-1-sre@kernel.org/
 * Update binding: i2c0 -> i2c
 * Update binding: make GC0309 use GC0308 as fallback compatible
 * Add regulator handling in power_on/power_off
 * Fix alignment of regmap_multi_reg_write arguments
 * Fix useless extra return
 * Do not check for pad in gc0308_enum_frame_size()
 * Drop get_mbus_config implementation
 * Use V4L2_CID_AUTO_EXPOSURE_BIAS instead of V4L2_CID_EXPOSURE
 * Drop gc0308_get_format in favour of v4l2_subdev_get_fmt
 * Replace open-coded v4l2_find_nearest_size() logic
 * check clock rate instead of setting it
 * use fwnode_graph_get_endpoint_by_id()
 * power off device when probe errors out after power on
 * replace mutex with sub-device state
 * add Galaxycore to generic camera sensors section in MAINTAINERS
 * add GC0308 entry in MAINTAINERS

Greetings,

-- Sebastian

Sebastian Reichel (4):
  dt-bindings: vendor-prefixes: add GalaxyCore
  media: dt-bindings: gc0308: add binding
  media: MAINTAINERS: Add GalaxyCore in camera sensor section
  media: i2c: gc0308: new driver

 .../bindings/media/i2c/galaxycore,gc0308.yaml |  108 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    8 +
 drivers/media/i2c/Kconfig                     |   10 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/gc0308.c                    | 1437 +++++++++++++++++
 6 files changed, 1566 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,gc0308.yaml
 create mode 100644 drivers/media/i2c/gc0308.c

-- 
2.42.0

