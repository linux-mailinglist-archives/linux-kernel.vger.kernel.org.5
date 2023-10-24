Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9279F7D4479
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjJXBEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjJXBEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:04:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E557BCC;
        Mon, 23 Oct 2023 18:04:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF3AC433C8;
        Tue, 24 Oct 2023 01:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698109442;
        bh=ZfPl6t59R5Ac+1BPcyB7uDtR1zx5eWUVL7UjAPeXsdc=;
        h=From:To:Cc:Subject:Date:From;
        b=kZxQaMYk0knUAkNwR6rQa2TX+jDYR9tP10iiMOXXkE1xNvuSpyA7wwa1E/oi+PKZ5
         biIpjYew17CALK8u414fhlFf7I/7YeMwgpQZI1mebSWd6/vlffYW1H1ozPMqcLHGZy
         K/vFHRwcpftJWC0N+tA8T9W7Hxb8IMVLbHdsScNnbGHsy6XRT4ASf+wjTKMOWr5fhn
         8t2T3K63Kq2AHZBWYTwq4NxxLwJ2jIMNcIrunOyoKkAbtD1koQmbu0BWy8bCFD0zMR
         9rAUBCuHkhoMTZO/bu5EenaOeAU/fVcaZouLIg1hZoQhHtF3FHHp+sUvCrCdzntwSX
         9FBT2MhQVsuDQ==
Received: by mercury (Postfix, from userid 1000)
        id A76C2106052D; Tue, 24 Oct 2023 03:03:59 +0200 (CEST)
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
Subject: [PATCH v2 0/4] GC0308 Camera Sensor
Date:   Tue, 24 Oct 2023 02:59:49 +0200
Message-ID: <20231024010355.1877523-1-sre@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

[0] https://embedded-recipes.org/2023/schedule/running-foss-thermal-camera/

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
 drivers/media/i2c/Kconfig                     |   14 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/gc0308.c                    | 1418 +++++++++++++++++
 6 files changed, 1551 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/galaxycore,gc0308.yaml
 create mode 100644 drivers/media/i2c/gc0308.c

-- 
2.42.0

