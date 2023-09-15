Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB867A16CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjIOHCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjIOHCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:02:30 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CEBA1;
        Fri, 15 Sep 2023 00:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1694761345;
  x=1726297345;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=0sW0iqIhT6PSVFY4FBnRMJl8mvoqoSyQoxUjCR+YF+k=;
  b=KunYl9tdPHrI3nHqyzLvWb9MKFwOyidQpWBP0KUj3K/CAoodOxjtWBn5
   MLUjMo/nK21n0Cgy4gSwPj/DXGtabU/q8n/zzEN8hcNZcafl0bVl7GwvK
   gb3KrwK/DuKG9B8grYV9eMwyc7BjXM7AYJP3sc4KYy7WdxqPRVYNNcqbe
   bfrJGvNVTSsw9gvtwYmwaMZokvNd7/7hXfbslnkLetreDjU9Fk4FgYV0M
   JUNT0AyQAEBhBMp67r3G/aLV5qyVsbdz7rpdkonNw6EacFdWEa6b326oo
   cJvvReNgM2H51RlT4itA9gOaGb5CkbWxi+JxahTQZJThNrofOeQOCWs4X
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Fri, 15 Sep 2023 09:02:14 +0200
Subject: [PATCH v2] power: supply: Propagate of_node to child device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230915-power-of-v2-1-ca54c441867e@axis.com>
X-B4-Tracking: v=1; b=H4sIAHUBBGUC/22Nyw6CMBBFf4XM2jGlViWu/A/Doo9BZiFDWlMxp
 P9uYe3ynNzHCokiU4Jbs0KkzIllqqAPDfjRTk9CDpVBK31SV2Vwlg9FlAENaeuUc2S6ADXubCJ
 00U5+3AqDiNn0HGngZX949JVHTm+J3/0wt5v9s51bbNH7TgdNwV7O7m4XTkcvL+hLKT+mzNmtt
 gAAAA==
To:     Sebastian Reichel <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that the dynamically created power supply device sets its
->of_node if the driver supplies one.  This brings it in line with
several other subsystems (see git grep 'of_node =.*parent.*of_node') and
allows easier identification of the device from udev rules and similar.

Before this patch:

 /sys/class/power_supply# ls -l bq256xx-battery/of_node
 ls: cannot access 'bq256xx-battery/of_node': No such file or directory
 # ls -l bq256xx-battery/hwmon1/of_node
 ls: cannot access 'bq256xx-battery/hwmon1/of_node': No such file or directory

After:

 /sys/class/power_supply# ls -l bq256xx-battery/of_node
 lrwxrwxrwx 1 root root 0 May 17 09:14 bq256xx-battery/of_node ->
 ../../../../../../../../firmware/devicetree/base/virtio@1/i2c/bq25619@09
 # ls -l bq256xx-battery/hwmon1/of_node
 lrwxrwxrwx 1 root root 0 May 17 09:14 bq256xx-battery/hwmon1/of_node ->
 ../../../../../../../../../firmware/devicetree/base/virtio@1/i2c/bq25619@09

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
Changes in v2:
- Use psy->of_node instead of parent node.
- Link to v1: https://lore.kernel.org/r/20230704-power-of-v1-1-cc82d2eda65b@axis.com
---
 drivers/power/supply/power_supply_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 0b69fb7bafd8..ab20bc660f00 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1380,6 +1380,7 @@ __power_supply_register(struct device *parent,
 		psy->drv_data = cfg->drv_data;
 		psy->of_node =
 			cfg->fwnode ? to_of_node(cfg->fwnode) : cfg->of_node;
+		dev->of_node = psy->of_node;
 		psy->supplied_to = cfg->supplied_to;
 		psy->num_supplicants = cfg->num_supplicants;
 	}

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230704-power-of-4e2ab0bbe48d

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

