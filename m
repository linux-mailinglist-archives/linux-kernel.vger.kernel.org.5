Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908BB7E9D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjKMNaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKMNax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:30:53 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43627D7E;
        Mon, 13 Nov 2023 05:30:49 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id 19D1AC0005;
        Mon, 13 Nov 2023 13:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699882247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ii8+etSPHzTAe8bcWFf2RWURPKpC4OnFERtK3d3IciM=;
        b=fR+ULvXqo6//waqmCqREZxa/7vwOQ8eUTpiQRwdogv0NjGQvN0cjQWy2zM5EYQONGVnYhb
        d4xAkj94uHYrxWZuNeiaqKhukFIMx4T3jaKH9aBmClx6KuFs0OSXZX/YtHaGIaVQFlV54B
        pU8PmuTpcSWqc7tiiLVGWzC2C6yc4urbYNn6pZ5K07Dw2uijkEs+f44nljE0UB2MKOZwqg
        e2jTxa/V7hsDzpDy1rPVXnUAOv6di2oR1LyYVmw9ZGLjFU3vEZQKT6RY/qQvwuDywbB07Y
        wULgHhYPKjA93troZkRyir3ilPFoADmdLS0tGXv3zgbJtPJu4EhWAu2K6wGJBA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>, stable@vger.kernel.org
Subject: [PATCH v2 1/1] driver core: Keep the supplier fwnode consistent with the device
Date:   Mon, 13 Nov 2023 14:30:44 +0100
Message-ID: <20231113133044.55257-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child
fwnode's consumer links") introduces the possibility to use the
supplier's parent device instead of the supplier itself.
In that case the supplier fwnode used is not updated and is no more
consistent with the supplier device used.

Update the fwnode used to be consistent with the supplier device used.

Fixes: 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child fwnode's consumer links")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
Changes v1 -> v2:
  Remove sup_handle check and related pr_debug() call as sup_handle cannot be
  invalid if sup_dev is valid.

 drivers/base/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4d8b315c48a1..2f6a21b908ec 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2076,6 +2076,13 @@ static int fw_devlink_create_devlink(struct device *con,
 		sup_dev = get_dev_from_fwnode(sup_handle);
 
 	if (sup_dev) {
+		/*
+		 * The supplier device may have changed and so, the supplier
+		 * fwnode maybe inconsistent.
+		 * Update the supplier fwnode
+		 */
+		sup_handle = sup_dev->fwnode;
+
 		/*
 		 * If it's one of those drivers that don't actually bind to
 		 * their device using driver core, then don't wait on this
-- 
2.41.0

