Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077E77AC2AF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjIWOcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjIWOcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:32:13 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA7C113;
        Sat, 23 Sep 2023 07:32:07 -0700 (PDT)
Received: from umang.lan (unknown [IPv6:2001:818:e7d2:8300:2412:6733:7e63:fb46])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CF687DE2;
        Sat, 23 Sep 2023 16:30:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1695479426;
        bh=bxWVw8EW1+W8KgrEDRuKz0AmWsn/M3h+CZ8KlUIwVbg=;
        h=From:To:Cc:Subject:Date:From;
        b=fGX3rgVbAP0RYWUm8TZ+PELGogVVXTADwIdpC/NhibEjVMuQD7TFrOlEjdL5fZOl3
         BnhPtPSPC5Ss2nGmFu3lahnEmkYEl6S6apZOczbbT2lIr39q8p482Ff72B+4HpnCwy
         GpCETpicU/579FmYN+DQTucpj64W9wmomg+78AAM=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v12 0/6] staging: vc04_services: vchiq: Register devices with a custom bus_type
Date:   Sat, 23 Sep 2023 20:01:54 +0530
Message-Id: <20230923143200.268063-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series added a new bus type vchiq_bus_type and registers
child devices in order to move them away from using platform
device/driver.

Tested on RPi-3-b with media tree master branch.

Patch 1/6 and 2/6 adds explicit DMA mask to bcm2835-camera
and bcm2835-audio respectively to avoid regression when moving
to away from platform device/driver model.

Patch 3/6 and 4/6 adds a new bus_type and registers them to vchiq
interface

Patch 5/6 and 6/6 moves the bcm2835-camera and bcm2835-audio
to the new bus respectively

Patch 5/5 removes a platform registeration helper which is no
longer required.

Changes in v12:
- Add initial two patches to set DMA Mask explicitly to avoid regression
- fixup vchiq_device.c bad squash in v11
- Rename vchiq_device.[ch] to vchiq_bus.[ch]
- Fix memory leak if device cannot be registered
- Make vchiq_bus_type_match() use bool values
- vchiq_register_child() helper removal folded in 6/6
  instead of creating extra patch.

Changes in v11:
- Move setting of DMA mask in child devices (3/5 and 4/5)
- Fixes "DMA mask not set issue" reported in v10.

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

Umang Jain (6):
  staging: vc04_services: bcm2835-camera: Explicitly set DMA mask
  staging: vc04_services: bcm2835-audio: Explicitly set DMA mask
  staging: vc04_services: vchiq_arm: Add new bus type and device type
  staging: vc04_services: vchiq_arm: Register vchiq_bus_type
  staging: bcm2835-camera: Register bcm2835-camera with vchiq_bus_type
  staging: bcm2835-audio: Register bcm2835-audio with vchiq_bus_type

 drivers/staging/vc04_services/Makefile        |   1 +
 .../vc04_services/bcm2835-audio/bcm2835.c     |  26 +++--
 .../bcm2835-camera/bcm2835-camera.c           |  23 ++--
 .../interface/vchiq_arm/vchiq_arm.c           |  52 ++++-----
 .../interface/vchiq_arm/vchiq_bus.c           | 100 ++++++++++++++++++
 .../interface/vchiq_arm/vchiq_bus.h           |  54 ++++++++++
 6 files changed, 209 insertions(+), 47 deletions(-)
 create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
 create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.40.1

