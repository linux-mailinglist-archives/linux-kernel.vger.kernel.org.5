Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12355756689
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjGQOh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjGQOhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:37:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02CCC0;
        Mon, 17 Jul 2023 07:37:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4653A6108C;
        Mon, 17 Jul 2023 14:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514ECC433C7;
        Mon, 17 Jul 2023 14:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689604643;
        bh=3KYO7KtyLAd/pTASmKd5Z6U9SP2SvfsV9oMlmbcorRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X5C7K3P+yB17TMXHQ6ezLU4ZnoSU9iirM5xckLLEsKZduRFTVTUiT5bosFgfa4W1S
         MWKJaSybG9ds/hzk0UBtw+qEaFbDeGtE+/eKQTZwOsq11EBhntRxUsaHVmtEafkKm0
         crn2MreJ1Va6Xzn4pM6mC2mgdGqHlaa2BxyvDZWIii4LTW9sBkZJGGQsePPyyTwlTO
         oYDxg9xUrB0cBT454ea9ftYuX4gb4Zkmq0tJKJon9fHhJ+5Dc76xIRFXq9SwOWLb7M
         4Bt+nZ0hzZndqnqfzoo7/nT5/ZRorercwEHcdjLbNy0BmPhdWszjGTMviTmWW5NyoY
         NYuO2QdxrLNcg==
Received: (nullmailer pid 1715882 invoked by uid 1000);
        Mon, 17 Jul 2023 14:37:20 -0000
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] of: Move of_device_{add,register,unregister} to platform.c
Date:   Mon, 17 Jul 2023 08:37:17 -0600
Message-Id: <20230717143718.1715773-2-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230717143718.1715773-1-robh@kernel.org>
References: <20230717143718.1715773-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The declarations for of_device_{add,register,unregister} were moved into
of_platform.h, so the implementations should be moved to platform.c as
well.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/device.c   | 32 --------------------------------
 drivers/of/platform.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 0f00f1b80708..2319e0e73048 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -32,25 +32,6 @@ const struct of_device_id *of_match_device(const struct of_device_id *matches,
 }
 EXPORT_SYMBOL(of_match_device);
 
-int of_device_add(struct platform_device *ofdev)
-{
-	BUG_ON(ofdev->dev.of_node == NULL);
-
-	/* name and id have to be set so that the platform bus doesn't get
-	 * confused on matching */
-	ofdev->name = dev_name(&ofdev->dev);
-	ofdev->id = PLATFORM_DEVID_NONE;
-
-	/*
-	 * If this device has not binding numa node in devicetree, that is
-	 * of_node_to_nid returns NUMA_NO_NODE. device_add will assume that this
-	 * device is on the same node as the parent.
-	 */
-	set_dev_node(&ofdev->dev, of_node_to_nid(ofdev->dev.of_node));
-
-	return device_add(&ofdev->dev);
-}
-
 static void
 of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
 {
@@ -221,19 +202,6 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(of_dma_configure_id);
 
-int of_device_register(struct platform_device *pdev)
-{
-	device_initialize(&pdev->dev);
-	return of_device_add(pdev);
-}
-EXPORT_SYMBOL(of_device_register);
-
-void of_device_unregister(struct platform_device *ofdev)
-{
-	device_unregister(&ofdev->dev);
-}
-EXPORT_SYMBOL(of_device_unregister);
-
 const void *of_device_get_match_data(const struct device *dev)
 {
 	const struct of_device_id *match;
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index e71adb394b41..8d03d9e65ef9 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -56,6 +56,38 @@ struct platform_device *of_find_device_by_node(struct device_node *np)
 }
 EXPORT_SYMBOL(of_find_device_by_node);
 
+int of_device_add(struct platform_device *ofdev)
+{
+	BUG_ON(ofdev->dev.of_node == NULL);
+
+	/* name and id have to be set so that the platform bus doesn't get
+	 * confused on matching */
+	ofdev->name = dev_name(&ofdev->dev);
+	ofdev->id = PLATFORM_DEVID_NONE;
+
+	/*
+	 * If this device has not binding numa node in devicetree, that is
+	 * of_node_to_nid returns NUMA_NO_NODE. device_add will assume that this
+	 * device is on the same node as the parent.
+	 */
+	set_dev_node(&ofdev->dev, of_node_to_nid(ofdev->dev.of_node));
+
+	return device_add(&ofdev->dev);
+}
+
+int of_device_register(struct platform_device *pdev)
+{
+	device_initialize(&pdev->dev);
+	return of_device_add(pdev);
+}
+EXPORT_SYMBOL(of_device_register);
+
+void of_device_unregister(struct platform_device *ofdev)
+{
+	device_unregister(&ofdev->dev);
+}
+EXPORT_SYMBOL(of_device_unregister);
+
 #ifdef CONFIG_OF_ADDRESS
 /*
  * The following routines scan a subtree and registers a device for
-- 
2.40.1

