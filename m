Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B166B79F265
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjIMTyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjIMTyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:54:13 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9E99E;
        Wed, 13 Sep 2023 12:54:09 -0700 (PDT)
Received: from umang.jainideasonboard.com (unknown [103.86.18.170])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8B4CA755;
        Wed, 13 Sep 2023 21:52:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694634755;
        bh=dZQYIYhd8wtDU67jQTMB8G2epHTfgZbmOFawwvBWHRw=;
        h=From:To:Cc:Subject:Date:From;
        b=XszMOHbWPsFIBRT1kXxrTff9DznD6g3PRD6GPRe0lEe2KDA7CN18WF/Tteogaywxg
         mzcYCwr3e06DVsU5j83i5VzxBomxEoMuY90hiwpfcGuaa8NZYHwR+DlYHD9VF4d09s
         8u2EOtD7sgEH4tWCEbVRJ2g8D5v8tEukwlQ99gxo=
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
Subject: [PATCH v11 0/5] staging: vc04_services: vchiq: Register devices with a custom bus_type
Date:   Thu, 14 Sep 2023 01:23:49 +0530
Message-Id: <20230913195354.835884-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Umang Jain (5):
  staging: vc04_services: vchiq_arm: Add new bus type and device type
  staging: vc04_services: vchiq_arm: Register vchiq_bus_type
  staging: bcm2835-camera: Register bcm2835-camera with vchiq_bus_type
  staging: bcm2835-audio: Register bcm2835-audio with vchiq_bus_type
  staging: vc04_services: vchiq_arm: Remove vchiq_register_child()

 drivers/staging/vc04_services/Makefile        |   1 +
 .../vc04_services/bcm2835-audio/bcm2835.c     |  29 +++--
 .../bcm2835-camera/bcm2835-camera.c           |  26 +++--
 .../interface/vchiq_arm/vchiq_arm.c           |  52 ++++-----
 .../interface/vchiq_arm/vchiq_device.c        | 104 ++++++++++++++++++
 .../interface/vchiq_arm/vchiq_device.h        |  54 +++++++++
 6 files changed, 219 insertions(+), 47 deletions(-)
 create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.c
 create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_device.h


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.40.1

