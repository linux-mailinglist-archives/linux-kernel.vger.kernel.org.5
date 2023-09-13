Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114B979E980
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240991AbjIMNjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjIMNjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:39:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7305619BB;
        Wed, 13 Sep 2023 06:39:10 -0700 (PDT)
Received: from mercury (dyndsl-091-248-208-175.ewe-ip-backbone.de [91.248.208.175])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DEF8E6607334;
        Wed, 13 Sep 2023 14:39:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694612349;
        bh=g/6AAX2qsSOtUeY2OFLzRXe7QB5YC9OFRSj/utRayGI=;
        h=From:To:Cc:Subject:Date:From;
        b=XPMyMsccAR+nlUXWhdIjmHQhl9vIdbLJ9zdmgIcG7HQihkpESbc6RHBoij/o2mOKi
         2S93o2X0NkIFSXB+bfhJ3pqVLqWkkgOgwHVegv+/rXPfbhYe6TikwCRsqvtL99mG0K
         10Hd1v/x/mpdPPmvIeqYIy5Dw0n3yET1IsKszSuBPY57QEjJjRmW+SXfa4Jy74KhTZ
         Bqmrc23Xe3n+NclRb5P6/LgABRikA3C8syhVoprhCfgt0+HrabceGk9d62/E8vsCVZ
         X5ysH4SjoFZ36ybeMAHWBkJDQgT/hwwRpzUjiVRqcyREaTFOxJhVokkI8JKIr9OKhr
         vVnExyntMqFyg==
Received: by mercury (Postfix, from userid 1000)
        id 227EE106098B; Wed, 13 Sep 2023 15:39:03 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH] power: supply: core: Don't export power_supply_notifier
Date:   Wed, 13 Sep 2023 15:39:00 +0200
Message-Id: <20230913133900.591637-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

power_supply_notifier can be internal, since all users are going
through power_supply_reg_notifier()/power_supply_unreg_notifier().

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/power/supply/power_supply_core.c | 3 +--
 include/linux/power_supply.h             | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 416409e2fd6d..96941a0eee03 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -29,8 +29,7 @@
 struct class *power_supply_class;
 EXPORT_SYMBOL_GPL(power_supply_class);
 
-BLOCKING_NOTIFIER_HEAD(power_supply_notifier);
-EXPORT_SYMBOL_GPL(power_supply_notifier);
+static BLOCKING_NOTIFIER_HEAD(power_supply_notifier);
 
 static struct device_type power_supply_dev_type;
 
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 85b86768c0b9..c0992a77feea 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -767,7 +767,6 @@ struct power_supply_battery_info {
 	int bti_resistance_tolerance;
 };
 
-extern struct blocking_notifier_head power_supply_notifier;
 extern int power_supply_reg_notifier(struct notifier_block *nb);
 extern void power_supply_unreg_notifier(struct notifier_block *nb);
 #if IS_ENABLED(CONFIG_POWER_SUPPLY)
-- 
2.40.1

