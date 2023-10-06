Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0834E7BC25D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjJFWqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbjJFWqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:46:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93AFCE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 15:46:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BB7C433C7;
        Fri,  6 Oct 2023 22:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696632404;
        bh=++louF5zar/N7pGJEhjOVXx7naXu/aElGi4NS4dLdJs=;
        h=From:To:Cc:Subject:Date:From;
        b=AWYuR7fSyxHedykT0mdgRFTtMgQ6N3hsjmaI9JoqFPM6wd609MqD8cAtlv2Muy6jc
         ijTHCeA2vNr8b8KLqcrxWBkciYjX/ERhKovSQMWjBlA02RmM53ySiZ+kysd0TIRpwZ
         C3FMsibEdglvlCVjh4gDyk44ROO/rSdtrhI/PAQC79YgQpU3ocHHGmbYTIQJWcOJL3
         zzuECx3i2Pp5QZ6XofhgTb5joIuFDwepdy/vxNC4hIeFPBM7DSYpfK0W2k4nLhDB98
         TbEUt7wSTH0uv9TnW5sNABWwTlC55r0xzmyJdxCzetFIu3CC3JkNIs/EUfM5sAgNUM
         +ESXzN/cTU9ZQ==
Received: (nullmailer pid 445257 invoked by uid 1000);
        Fri, 06 Oct 2023 22:46:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: ti_sci: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 17:46:38 -0500
Message-Id: <20231006224638.445168-1-robh@kernel.org>
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
 drivers/firmware/ti_sci.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index ffca636cc13f..7041befc756a 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -16,7 +16,10 @@
 #include <linux/kernel.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/semaphore.h>
 #include <linux/slab.h>
 #include <linux/soc/ti/ti-msgmgr.h>
@@ -3293,7 +3296,6 @@ MODULE_DEVICE_TABLE(of, ti_sci_of_match);
 static int ti_sci_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *of_id;
 	const struct ti_sci_desc *desc;
 	struct ti_sci_xfer *xfer;
 	struct ti_sci_info *info = NULL;
@@ -3304,12 +3306,7 @@ static int ti_sci_probe(struct platform_device *pdev)
 	int reboot = 0;
 	u32 h_id;
 
-	of_id = of_match_device(ti_sci_of_match, dev);
-	if (!of_id) {
-		dev_err(dev, "OF data missing\n");
-		return -EINVAL;
-	}
-	desc = of_id->data;
+	desc = device_get_match_data(dev);
 
 	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
-- 
2.40.1

