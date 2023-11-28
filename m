Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F897FC23E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346192AbjK1OJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346011AbjK1OJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:09:42 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD291727
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:09:11 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54b7ef7f4d5so2560546a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1701180550; x=1701785350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BjV3ZpluMSAVGQFB9cPNT2RxzFgFRhSQqvx9TZHEPH4=;
        b=bY4tmeELKQ7HC6ZxG7RuOdPC8er3GV/EIvKCm7d5mGKDvjhES7zQOgMh8/o5GFZISf
         fPwhZXU8s3PbMf8JV5wtkG98vuK/zB/lrLBs4sV8iakPrI4vZianGFOb6SKnjembcUcs
         oU5OHT/m0K8mYcfS1ihZsNNPa2MyPFUKXkzFClfIqc7YppbBWVwbFYYO3x5u/gyNv/DO
         S6jD8ZlOdDVDjz6vTb6R8dR26Q4gDATR/mYN/H/J7WSDZ68GYdsEKKEflpfQeB9qyFKn
         caW/MF39mxusVsdTgQX9hOuOk1zl4k8YkUdCwK/sEu6b01TmMwVHns6DowFm+ko/Bk2z
         n81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701180550; x=1701785350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjV3ZpluMSAVGQFB9cPNT2RxzFgFRhSQqvx9TZHEPH4=;
        b=K4bocTcQkVtnr2Udz02sAUSk8ln7BSn7GaXa8A7mFCBWOLHF7N+U4IpxmjO9+JBW1C
         EVVCWvSyd2+7pa0wku0W2g67FMoCNh7pbyL1Y0a5GLPmAd6ONDHdyFSlJt4Jjo2WdiLY
         qyydz5hPL6+RFlYStyYG4dhJkRqah7G9wMnc2/glRlmWKVVjOfXZxnZEEyEQBZ9q/IGR
         qktvK8BZk3d0MhtAnnDIRX6twD379IBQl15EYcPd9KDvOEdISo8xBNFGFNOcuM00UvCj
         JGTf/BH0a30xMgGSumT1Xl8J7la5UFCtVbTYHtx7XYOARqr0ZuhKi1D7L/nmLZC3ThmQ
         Pk3Q==
X-Gm-Message-State: AOJu0YyvFf+JhSf5gxJzy5hmWP8PjnIHAz0WB/LuwG15DV3HvOkDbas/
        7pCvlIOqssUk3qliU+V4cAJrDg==
X-Google-Smtp-Source: AGHT+IEAXchVtZYdjscX++YPGPNJsZu1H+5r0Dds70g5pOXcok4pxS/G993mwo5cEZ3zkwh2WBNWFQ==
X-Received: by 2002:a50:baee:0:b0:54b:29f4:e22c with SMTP id x101-20020a50baee000000b0054b29f4e22cmr7107952ede.20.1701180549956;
        Tue, 28 Nov 2023 06:09:09 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id c70-20020a509fcc000000b0054b3ead7c5dsm3262226edf.76.2023.11.28.06.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:09:09 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] regulator: event: Add regulator netlink event support
Date:   Tue, 28 Nov 2023 14:07:16 +0000
Message-ID: <20231128140718.3866978-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces netlink event support to the regulator subsystem.

Changes:
- Introduce event.c and regnl.h for netlink event handling.
- Implement reg_generate_netlink_event to broadcast regulator events.
- Update Makefile to include the new event.c file.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

---
Chagnes in V3:
- Add Kconfig option REGULATOR_NETLINK_EVENTS for regulator netlink
  support
- Add mechanism to avoid regulator name duplication
- Add UAPI header for regulator with define's for regulator events &
  netlink.
---
 drivers/regulator/Kconfig          | 10 ++++
 drivers/regulator/Makefile         |  1 +
 drivers/regulator/core.c           | 19 ++++++-
 drivers/regulator/event.c          | 86 ++++++++++++++++++++++++++++++
 drivers/regulator/regnl.h          |  8 +++
 include/linux/regulator/consumer.h | 47 +---------------
 include/uapi/regulator/regulator.h | 85 +++++++++++++++++++++++++++++
 7 files changed, 209 insertions(+), 47 deletions(-)
 create mode 100644 drivers/regulator/event.c
 create mode 100644 drivers/regulator/regnl.h
 create mode 100644 include/uapi/regulator/regulator.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index f3ec24691378..00d3898ee599 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -56,6 +56,16 @@ config REGULATOR_USERSPACE_CONSUMER
 
 	  If unsure, say no.
 
+config REGULATOR_NETLINK_EVENTS
+	tristate "Enable support for receiving regulator events via netlink"
+	depends on NET
+	help
+	  Enabling this option allows the kernel to broadcast regulator events using
+	  the netlink mechanism. User-space applications can subscribe to these events
+	  for real-time updates on various regulator events.
+
+	  If unsure, say no.
+
 config REGULATOR_88PG86X
 	tristate "Marvell 88PG86X voltage regulators"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index b2b059b5ee56..46fb569e6be8 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -5,6 +5,7 @@
 
 
 obj-$(CONFIG_REGULATOR) += core.o dummy.o fixed-helper.o helpers.o devres.o irq_helpers.o
+obj-$(CONFIG_REGULATOR_NETLINK_EVENTS) += event.o
 obj-$(CONFIG_OF) += of_regulator.o
 obj-$(CONFIG_REGULATOR_FIXED_VOLTAGE) += fixed.o
 obj-$(CONFIG_REGULATOR_VIRTUAL_CONSUMER) += virtual.o
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4aa9ec8c22f3..a968dabb48f5 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -33,6 +33,7 @@
 
 #include "dummy.h"
 #include "internal.h"
+#include "regnl.h"
 
 static DEFINE_WW_CLASS(regulator_ww_class);
 static DEFINE_MUTEX(regulator_nesting_mutex);
@@ -4854,7 +4855,23 @@ static int _notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data)
 {
 	/* call rdev chain first */
-	return blocking_notifier_call_chain(&rdev->notifier, event, data);
+	int ret =  blocking_notifier_call_chain(&rdev->notifier, event, data);
+
+	if (IS_REACHABLE(CONFIG_REGULATOR_NETLINK_EVENTS)) {
+		struct device *parent = rdev->dev.parent;
+		const char *rname = rdev_get_name(rdev);
+		char name[32];
+
+		/* Avoid duplicate debugfs directory names */
+		if (parent && rname == rdev->desc->name) {
+			snprintf(name, sizeof(name), "%s-%s", dev_name(parent),
+				 rname);
+			rname = name;
+		}
+		reg_generate_netlink_event(rname, event);
+	}
+
+	return ret;
 }
 
 int _regulator_bulk_get(struct device *dev, int num_consumers,
diff --git a/drivers/regulator/event.c b/drivers/regulator/event.c
new file mode 100644
index 000000000000..77286b419f71
--- /dev/null
+++ b/drivers/regulator/event.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <regulator/regulator.h>
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "regnl.h"
+
+static unsigned int reg_event_seqnum;
+
+static const struct genl_multicast_group reg_event_mcgrps[] = {
+	{ .name = REG_GENL_MCAST_GROUP_NAME, },
+};
+
+static struct genl_family reg_event_genl_family __ro_after_init = {
+	.module = THIS_MODULE,
+	.name = REG_GENL_FAMILY_NAME,
+	.version = REG_GENL_VERSION,
+	.maxattr = REG_GENL_ATTR_MAX,
+	.mcgrps = reg_event_mcgrps,
+	.n_mcgrps = ARRAY_SIZE(reg_event_mcgrps),
+};
+
+int reg_generate_netlink_event(const char *reg_name, u64 event)
+{
+	struct sk_buff *skb;
+	struct nlattr *attr;
+	struct reg_genl_event *edata;
+	void *msg_header;
+	int size;
+
+	/* allocate memory */
+	size = nla_total_size(sizeof(struct reg_genl_event)) +
+	    nla_total_size(0);
+
+	skb = genlmsg_new(size, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+
+	/* add the genetlink message header */
+	msg_header = genlmsg_put(skb, 0, reg_event_seqnum++,
+				 &reg_event_genl_family, 0,
+				 REG_GENL_CMD_EVENT);
+	if (!msg_header) {
+		nlmsg_free(skb);
+		return -ENOMEM;
+	}
+
+	/* fill the data */
+	attr = nla_reserve(skb, REG_GENL_ATTR_EVENT, sizeof(struct reg_genl_event));
+	if (!attr) {
+		nlmsg_free(skb);
+		return -EINVAL;
+	}
+
+	edata = nla_data(attr);
+	memset(edata, 0, sizeof(struct reg_genl_event));
+
+	strscpy(edata->reg_name, reg_name, sizeof(edata->reg_name));
+	edata->event = event;
+
+	/* send multicast genetlink message */
+	genlmsg_end(skb, msg_header);
+	size = genlmsg_multicast(&reg_event_genl_family, skb, 0, 0, GFP_ATOMIC);
+
+	return size;
+}
+
+static int __init reg_event_genetlink_init(void)
+{
+	return genl_register_family(&reg_event_genl_family);
+}
+
+static int __init reg_event_init(void)
+{
+	int error;
+
+	/* create genetlink for acpi event */
+	error = reg_event_genetlink_init();
+	if (error)
+		pr_warn("Failed to create genetlink family for reg event\n");
+
+	return 0;
+}
+
+fs_initcall(reg_event_init);
diff --git a/drivers/regulator/regnl.h b/drivers/regulator/regnl.h
new file mode 100644
index 000000000000..0b27972bd523
--- /dev/null
+++ b/drivers/regulator/regnl.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __REGULATOR_EVENT_H
+#define __REGULATOR_EVENT_H
+
+int reg_generate_netlink_event(const char *reg_name, u64 event);
+
+#endif
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 39b666b40ea6..4660582a3302 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -33,6 +33,7 @@
 
 #include <linux/err.h>
 #include <linux/suspend.h>
+#include <regulator/regulator.h>
 
 struct device;
 struct notifier_block;
@@ -84,52 +85,6 @@ struct regulator_dev;
 #define REGULATOR_MODE_IDLE			0x4
 #define REGULATOR_MODE_STANDBY			0x8
 
-/*
- * Regulator notifier events.
- *
- * UNDER_VOLTAGE  Regulator output is under voltage.
- * OVER_CURRENT   Regulator output current is too high.
- * REGULATION_OUT Regulator output is out of regulation.
- * FAIL           Regulator output has failed.
- * OVER_TEMP      Regulator over temp.
- * FORCE_DISABLE  Regulator forcibly shut down by software.
- * VOLTAGE_CHANGE Regulator voltage changed.
- *                Data passed is old voltage cast to (void *).
- * DISABLE        Regulator was disabled.
- * PRE_VOLTAGE_CHANGE   Regulator is about to have voltage changed.
- *                      Data passed is "struct pre_voltage_change_data"
- * ABORT_VOLTAGE_CHANGE Regulator voltage change failed for some reason.
- *                      Data passed is old voltage cast to (void *).
- * PRE_DISABLE    Regulator is about to be disabled
- * ABORT_DISABLE  Regulator disable failed for some reason
- *
- * NOTE: These events can be OR'ed together when passed into handler.
- */
-
-#define REGULATOR_EVENT_UNDER_VOLTAGE		0x01
-#define REGULATOR_EVENT_OVER_CURRENT		0x02
-#define REGULATOR_EVENT_REGULATION_OUT		0x04
-#define REGULATOR_EVENT_FAIL			0x08
-#define REGULATOR_EVENT_OVER_TEMP		0x10
-#define REGULATOR_EVENT_FORCE_DISABLE		0x20
-#define REGULATOR_EVENT_VOLTAGE_CHANGE		0x40
-#define REGULATOR_EVENT_DISABLE			0x80
-#define REGULATOR_EVENT_PRE_VOLTAGE_CHANGE	0x100
-#define REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE	0x200
-#define REGULATOR_EVENT_PRE_DISABLE		0x400
-#define REGULATOR_EVENT_ABORT_DISABLE		0x800
-#define REGULATOR_EVENT_ENABLE			0x1000
-/*
- * Following notifications should be emitted only if detected condition
- * is such that the HW is likely to still be working but consumers should
- * take a recovery action to prevent problems esacalating into errors.
- */
-#define REGULATOR_EVENT_UNDER_VOLTAGE_WARN	0x2000
-#define REGULATOR_EVENT_OVER_CURRENT_WARN	0x4000
-#define REGULATOR_EVENT_OVER_VOLTAGE_WARN	0x8000
-#define REGULATOR_EVENT_OVER_TEMP_WARN		0x10000
-#define REGULATOR_EVENT_WARN_MASK		0x1E000
-
 /*
  * Regulator errors that can be queried using regulator_get_error_flags
  *
diff --git a/include/uapi/regulator/regulator.h b/include/uapi/regulator/regulator.h
new file mode 100644
index 000000000000..8f6b78a6fa26
--- /dev/null
+++ b/include/uapi/regulator/regulator.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _UAPI_REGULATOR_H
+#define _UAPI_REGULATOR_H
+
+#ifdef __KERNEL__
+#include <linux/types.h>
+#else
+#include <stdint.h>
+#endif
+
+/*
+ * Regulator notifier events.
+ *
+ * UNDER_VOLTAGE  Regulator output is under voltage.
+ * OVER_CURRENT   Regulator output current is too high.
+ * REGULATION_OUT Regulator output is out of regulation.
+ * FAIL           Regulator output has failed.
+ * OVER_TEMP      Regulator over temp.
+ * FORCE_DISABLE  Regulator forcibly shut down by software.
+ * VOLTAGE_CHANGE Regulator voltage changed.
+ *                Data passed is old voltage cast to (void *).
+ * DISABLE        Regulator was disabled.
+ * PRE_VOLTAGE_CHANGE   Regulator is about to have voltage changed.
+ *                      Data passed is "struct pre_voltage_change_data"
+ * ABORT_VOLTAGE_CHANGE Regulator voltage change failed for some reason.
+ *                      Data passed is old voltage cast to (void *).
+ * PRE_DISABLE    Regulator is about to be disabled
+ * ABORT_DISABLE  Regulator disable failed for some reason
+ *
+ * NOTE: These events can be OR'ed together when passed into handler.
+ */
+
+#define REGULATOR_EVENT_UNDER_VOLTAGE		0x01
+#define REGULATOR_EVENT_OVER_CURRENT		0x02
+#define REGULATOR_EVENT_REGULATION_OUT		0x04
+#define REGULATOR_EVENT_FAIL			0x08
+#define REGULATOR_EVENT_OVER_TEMP		0x10
+#define REGULATOR_EVENT_FORCE_DISABLE		0x20
+#define REGULATOR_EVENT_VOLTAGE_CHANGE		0x40
+#define REGULATOR_EVENT_DISABLE			0x80
+#define REGULATOR_EVENT_PRE_VOLTAGE_CHANGE	0x100
+#define REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE	0x200
+#define REGULATOR_EVENT_PRE_DISABLE		0x400
+#define REGULATOR_EVENT_ABORT_DISABLE		0x800
+#define REGULATOR_EVENT_ENABLE			0x1000
+/*
+ * Following notifications should be emitted only if detected condition
+ * is such that the HW is likely to still be working but consumers should
+ * take a recovery action to prevent problems esacalating into errors.
+ */
+#define REGULATOR_EVENT_UNDER_VOLTAGE_WARN	0x2000
+#define REGULATOR_EVENT_OVER_CURRENT_WARN	0x4000
+#define REGULATOR_EVENT_OVER_VOLTAGE_WARN	0x8000
+#define REGULATOR_EVENT_OVER_TEMP_WARN		0x10000
+#define REGULATOR_EVENT_WARN_MASK		0x1E000
+
+struct reg_genl_event {
+	char reg_name[32];
+	uint64_t event;
+};
+
+/* attributes of reg_genl_family */
+enum {
+	REG_GENL_ATTR_UNSPEC,
+	REG_GENL_ATTR_EVENT,	/* reg event info needed by user space */
+	__REG_GENL_ATTR_MAX,
+};
+
+#define REG_GENL_ATTR_MAX (__REG_GENL_ATTR_MAX - 1)
+
+/* commands supported by the reg_genl_family */
+enum {
+	REG_GENL_CMD_UNSPEC,
+	REG_GENL_CMD_EVENT,	/* kernel->user notifications for reg events */
+	__REG_GENL_CMD_MAX,
+};
+
+#define REG_GENL_CMD_MAX (__REG_GENL_CMD_MAX - 1)
+
+#define REG_GENL_FAMILY_NAME		"reg_event"
+#define REG_GENL_VERSION		0x01
+#define REG_GENL_MCAST_GROUP_NAME	"reg_mc_group"
+
+#endif /* _UAPI_REGULATOR_H */

base-commit: 753e4d5c433da57da75dd4c3e1aececc8e874a62
-- 
2.41.0

