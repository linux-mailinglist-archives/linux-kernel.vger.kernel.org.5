Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C7F7C41F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 22:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343829AbjJJU5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 16:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbjJJU5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 16:57:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6299D9E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 13:57:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D46C433C7;
        Tue, 10 Oct 2023 20:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696971428;
        bh=u8+kackalOuLDc7cWB4DvuqMcg0D1zYet7blRkIR7GM=;
        h=From:To:Cc:Subject:Date:From;
        b=bycelGIK6oapVcld+LF/xHL1B9RKon3S9cXRELxn56mgTejM95A+wgLTLmsGabcW0
         3FNgwKwAgY3jsXWJ3T/TOLRAeNLmh7S57h4nzz1z5f1t8wdBFxWSEcc0Pk5iCZr03f
         nS+HG33aMaslZYYYO3xGMF/Fyjo4Y6kqRhWi4Mtojwwn9hUqDpS5Wuzc2fMASIItt8
         1HdYL32T0us63BTkltpc1g1Iqm6y+0H2oPDktpP7A0tI7Q5BVc8nxt5d7xd7nklr9U
         xTryQOeIN6iqIkl+gfTWteS/+5YfukTJUYlqO6MXuRkysZTfztPcQY5ZOR4ZqngLoZ
         ug9k1Y57x3Huw==
Received: (nullmailer pid 1585181 invoked by uid 1000);
        Tue, 10 Oct 2023 20:57:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: realtek: Replace of_device.h with explicit includes
Date:   Tue, 10 Oct 2023 15:57:00 -0500
Message-ID: <20231010205701.1585026-1-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
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

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other and pull in various other headers. In
preparation to fix this, adjust the includes for what is actually needed.

of_device.h isn't needed, but platform_device.h was implicitly included by
it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
Note these were added in the merge window and missed the last round.
---
 drivers/phy/realtek/phy-rtk-usb2.c | 2 +-
 drivers/phy/realtek/phy-rtk-usb3.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/realtek/phy-rtk-usb2.c b/drivers/phy/realtek/phy-rtk-usb2.c
index aedc78bd37f7..0a6426285c67 100644
--- a/drivers/phy/realtek/phy-rtk-usb2.c
+++ b/drivers/phy/realtek/phy-rtk-usb2.c
@@ -8,8 +8,8 @@
 
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
 #include <linux/uaccess.h>
 #include <linux/debugfs.h>
 #include <linux/nvmem-consumer.h>
diff --git a/drivers/phy/realtek/phy-rtk-usb3.c b/drivers/phy/realtek/phy-rtk-usb3.c
index dfb3122f3f11..67446a85e968 100644
--- a/drivers/phy/realtek/phy-rtk-usb3.c
+++ b/drivers/phy/realtek/phy-rtk-usb3.c
@@ -8,8 +8,8 @@
 
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
 #include <linux/uaccess.h>
 #include <linux/debugfs.h>
 #include <linux/nvmem-consumer.h>
-- 
2.42.0

