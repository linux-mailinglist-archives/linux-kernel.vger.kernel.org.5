Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392B37BC25F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjJFWrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjJFWrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:47:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2676E9C
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 15:46:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC4FC433A9;
        Fri,  6 Oct 2023 22:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696632415;
        bh=QhfxJqEQ6OJSl5IcILtNokOuYw1e3Q+5kT0sh/iU5Yw=;
        h=From:To:Cc:Subject:Date:From;
        b=BLamJ5PL9kCXURtOMy/xt58EyKrzqixFGNEjB1szGolW99SxpKzX7HN/LfbIjfU1S
         szhS38E7TIMHQ5S7uluKmWdZdixdRQsoqJLz8zUFKRpxBlQLv99LwcEza2AJh87sMX
         N3qfz+oBSuDmv44aFuqvwGWaxZF62bWM+DZo+9Uv5h+wrWsP40dehnz7l+KbFzIwWB
         3XuY8g/qCULly3SXJVYddn4IwIv0aFLIg3HB933+/7nkcZWhrToPi8eDqL6h5gIvSY
         7t+tzIn+HOREOO9EJMamzsRJDt4ebvhDWhFC85fJbzrjc7rdgExmYivaETLmso1NrN
         jd3dPkDP+hMiw==
Received: (nullmailer pid 445513 invoked by uid 1000);
        Fri, 06 Oct 2023 22:46:54 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_scpi: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 17:46:50 -0500
Message-Id: <20231006224650.445424-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/firmware/arm_scpi.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 435d0e2658a4..3f123f592cb4 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -26,9 +26,12 @@
 #include <linux/list.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/printk.h>
+#include <linux/property.h>
 #include <linux/pm_opp.h>
 #include <linux/scpi_protocol.h>
 #include <linux/slab.h>
@@ -894,11 +897,6 @@ static int scpi_alloc_xfer_list(struct device *dev, struct scpi_chan *ch)
 	return 0;
 }
 
-static const struct of_device_id legacy_scpi_of_match[] = {
-	{.compatible = "arm,scpi-pre-1.0"},
-	{},
-};
-
 static const struct of_device_id shmem_of_match[] __maybe_unused = {
 	{ .compatible = "amlogic,meson-gxbb-scp-shmem", },
 	{ .compatible = "amlogic,meson-axg-scp-shmem", },
@@ -919,8 +917,7 @@ static int scpi_probe(struct platform_device *pdev)
 	if (!scpi_drvinfo)
 		return -ENOMEM;
 
-	if (of_match_device(legacy_scpi_of_match, &pdev->dev))
-		scpi_drvinfo->is_legacy = true;
+	scpi_drvinfo->is_legacy = !!device_get_match_data(dev);
 
 	count = of_count_phandle_with_args(np, "mboxes", "#mbox-cells");
 	if (count < 0) {
@@ -1038,7 +1035,7 @@ static int scpi_probe(struct platform_device *pdev)
 
 static const struct of_device_id scpi_of_match[] = {
 	{.compatible = "arm,scpi"},
-	{.compatible = "arm,scpi-pre-1.0"},
+	{.compatible = "arm,scpi-pre-1.0", .data = (void *)1UL },
 	{},
 };
 
-- 
2.40.1

