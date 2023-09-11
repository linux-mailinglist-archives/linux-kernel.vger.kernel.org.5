Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB05C79B0F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358185AbjIKWIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238894AbjIKOHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:07:31 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDEFCF0;
        Mon, 11 Sep 2023 07:07:25 -0700 (PDT)
Received: from www.ideasonboard.com (unknown [103.238.109.17])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 74296D51;
        Mon, 11 Sep 2023 16:05:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694441152;
        bh=r1n7/4lPzB2GT8jcfXBHIKcAzHyqSpSu9d7J76LCGrQ=;
        h=From:To:Cc:Subject:Date:From;
        b=S32Xd4x5wQmnD5utvcQjihwTjgSPWnEEqHBdEcqHIbSBnFTvtJs5OfsCQnWKkuLQJ
         oKUtix42m1bLL+FR4sYZ8H5Ky8Ll7NZSCwSUe1IbNJioNmXF60oWheC9gJfUyHnisb
         KxbNyAdPTv3xGgp3hJxpgdTdE9HN/+vfgACd1OmI=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stefan.wahren@i2se.com, gregkh@linuxfoundation.org,
        f.fainelli@gmail.com, athierry@redhat.com, error27@gmail.com,
        kieran.bingham@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        dave.stevenson@raspberrypi.com,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v10 0/5] staging: vc04_services: vchiq: Register devices with a custom bus_type
Date:   Mon, 11 Sep 2023 10:07:07 -0400
Message-ID: <20230911140712.180751-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series added a new bus type vchiq_bus_type and registers
child devices in order to move them away from using platform
device/driver.

Tested on RPi-3-b with media tree master branch.

Patch 1/5 and 2/5 adds a new bus_type and registers them to vchiq
interface

Patch 3/5 and 4/5 moves the bcm2835-camera and bcm2835-audio
to the new bus respectively

Patch 5/5 removes a platform registeration helper which is no
longer required.

Changes in v10:
- fix dma_attr WARN issue with bcm2835-audio module loading
- Unregister bus on parent platform device fails to register
- Reword commit to highlight bcm2835_audio to bcm2835-audio name change

Changes in v9:
- Fix module autoloading
- Implement bus_type's probe() callback to load drivers
- Implement bus_type's uevent() to make sure appropriate drivers are
  loaded when device are registed from vchiq.

Changes in v8:
- Drop dual licensing. Instead use GPL-2.0 only for patch 1/5

Changes in v7:
(5 out of 6 patches from v6 merged)
- Split the main patch (6/6) as requested.
- Use struct vchiq_device * instead of struct device * in
  all bus functions.
- Drop additional name attribute displayed in sysfs (redundant info)
- Document vchiq_interface doesn't enumerate device discovery
- remove EXPORT_SYMBOL_GPL(vchiq_bus_type)

Changes in v6:
- Split struct device and struct driver wrappers in vchiq_device.[ch]
- Move vchiq_bus_type definition to vchiq_device.[ch] as well
- return error on bus_register() failure
- drop dma_set_mask_and_coherent
- trivial variable name change

Changes in v5:
- Fixup missing "staging: " in commits' subject line
- No code changes from v4

Changes in v4:
- Introduce patches to drop include directives from Makefile

Changes in v3:
- Rework entirely to replace platform devices/driver model

-v2:
https://lore.kernel.org/all/20221222191500.515795-1-umang.jain@ideasonboard.com/

-v1:
https://lore.kernel.org/all/20221220084404.19280-1-umang.jain@ideasonboard.com/

Umang Jain (5):
  staging: vc04_services: vchiq_arm: Add new bus type and device type
  staging: vc04_services: vchiq_arm: Register vchiq_bus_type
  staging: bcm2835-camera: Register bcm2835-camera with vchiq_bus_type
  staging: bcm2835-audio: Register bcm2835-audio with vchiq_bus_type
  staging: vc04_services: vchiq_arm: Remove vchiq_register_child()

 drivers/staging/vc04_services/Makefile        |   1 +
 .../vc04_services/bcm2835-audio/bcm2835.c     |  20 ++--
 .../bcm2835-camera/bcm2835-camera.c           |  17 +--
 .../interface/vchiq_arm/vchiq_arm.c           |  52 ++++----
 .../interface/vchiq_arm/vchiq_device.c        | 111 ++++++++++++++++++
 .../interface/vchiq_arm/vchiq_device.h        |  54 +++++++++
 6 files changed, 208 insertions(+), 47 deletions(-)
 create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
 create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h


base-commit: 9a5d660fdb25d20748d7f9e9559c86073c3bb368
-- 
2.41.0

