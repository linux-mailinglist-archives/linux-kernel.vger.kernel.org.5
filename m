Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62CC7B2F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjI2Jbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjI2Jbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:31:43 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0609195
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 02:31:39 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:e207:8adb:af22:7f1e])
        by andre.telenet-ops.be with bizsmtp
        id rlXd2A00H3w8i7m01lXdHu; Fri, 29 Sep 2023 11:31:37 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qm9q4-004qHj-7y;
        Fri, 29 Sep 2023 11:31:37 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qm9qT-001eU7-65;
        Fri, 29 Sep 2023 11:31:37 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Wentong Wu <wentong.wu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] media: ipu-bridge: Add missing acpi_dev_put() in ipu_bridge_get_ivsc_acpi_dev()
Date:   Fri, 29 Sep 2023 11:31:33 +0200
Message-Id: <0e8fa862e2d3da5897d0f895322d469e7d5aa052.1695979848.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ipu_bridge_get_ivsc_acpi_dev(), the "ivsc_adev" acpi_device pointer
from the outer loop is handed over to the caller, which takes proper
care of its reference count.
However, the "consumer" acpi_device pointer from the inner loop is lost,
without decrementing its reference count.

Fix this by adding the missing call to acpi_dev_put().

Fixes: c66821f381aed2c7 ("media: pci: intel: Add IVSC support for IPU bridge driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.

This driver really likes nesting loops: the above inner loop is actually
5 levels deep, of which 3 levels use for_each_acpi_*().  And all of that
is done twice:

ipu_bridge_init
    ipu_bridge_ivsc_is_ready
        for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++)
            for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1)
                for (i = 0; i < ARRAY_SIZE(ivsc_acpi_ids); i++)
                    for_each_acpi_dev_match(ivsc_adev, acpi_id->id, NULL, -1)
                        for_each_acpi_consumer_dev(ivsc_adev, consumer)

    ipu_bridge_connect_sensors
        for (i = 0; i < ARRAY_SIZE(ipu_supported_sensors); i++)
                for_each_acpi_dev_match(adev, cfg->hid, NULL, -1)
                    for (i = 0; i < ARRAY_SIZE(ivsc_acpi_ids); i++)
                        for_each_acpi_dev_match(ivsc_adev, acpi_id->id, NULL, -1)
                            for_each_acpi_consumer_dev(ivsc_adev, consumer)
---
 drivers/media/pci/intel/ipu-bridge.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 1bde8b6e0b1121a8..e38198e259c03ce9 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -107,8 +107,10 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi_dev(struct acpi_device *adev
 		for_each_acpi_dev_match(ivsc_adev, acpi_id->id, NULL, -1)
 			/* camera sensor depends on IVSC in DSDT if exist */
 			for_each_acpi_consumer_dev(ivsc_adev, consumer)
-				if (consumer->handle == handle)
+				if (consumer->handle == handle) {
+					acpi_dev_put(consumer);
 					return ivsc_adev;
+				}
 	}
 
 	return NULL;
-- 
2.34.1

