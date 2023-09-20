Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C71B7A8C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjITTMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjITTM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:12:29 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9F7E49;
        Wed, 20 Sep 2023 12:12:05 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c022ce8114so2366681fa.1;
        Wed, 20 Sep 2023 12:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237123; x=1695841923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imtUzm6BSk9S5Zn88Nu5Ur68x7dQT0fyS8OcYR+/2Ug=;
        b=GafjPM1YcXam5tMJgQnryglufHjb0ziG1snZNgpSG74G3Ckf8Gic6gWgwEmQk9S/s1
         hu5aID8WK9lClCDAZNH4fStH1h76sdB3DSvfKRk0JwyT4FFsR8ByqRmXopcogPq5ZHFN
         /OCUtn0uoeSlKfAQ/i3nMq+KB4Pda3FpuZMvErbLWUo6HcKmVw45SoiMxJiruXaSWxwL
         gYPCzp/WEOldg9lEiN5NIAeDaq6Lch95/UeoBTRrCS37j6UllX4S6eVyw4/784pWUrEw
         AHBhLZ8Xao7+LkqR0B8WbtCgo6o0G1jympe8QrYP5NprVnjHUFvyy4siZqZAMX6t/LGL
         CTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237123; x=1695841923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imtUzm6BSk9S5Zn88Nu5Ur68x7dQT0fyS8OcYR+/2Ug=;
        b=B208ZLeqvXvA6DOc9ZYevwW4+EHDK5sHWQW7nsuWI77C7N3Fl57TYX9zmZ/5ojgdyf
         rYplLx+lvSbOF01u/G/vGQFsbEOW2rwQnH1oeQQ7SZwdmlVI+vTBNcVyo0D4crewpIeH
         OBHjsLjUcOD3AJS3OnUoFmwi7koRTTHFvafGOqJAMCyWKC0+klu16z0609vbIG7keeQo
         X/upITM0Hbqb26tgZstrntjPcZ8AKBV40Kf8s7wDOHOTkap1u6Kwdwt7EddIwt/rjhQi
         VBveuN/dwJBf/wVDXZYhTsbvTNtyWR7mA5PLuZrgIGJDWtYbZvvSCtlsQbK0aIt+++Tf
         ACEg==
X-Gm-Message-State: AOJu0YyIwI4U/UlpfLCyjKCQLDkvFKogc9O8Mo8iouMctt7LYkGvuU+r
        +L9y6JPEigiK2YX3oQXAy4g=
X-Google-Smtp-Source: AGHT+IH55TK3fYViAn0fIAyWU0dqJK/nxiZCcmqkmnqPzaRAllRta14VHtmEoUidOTSod6DuI4QozA==
X-Received: by 2002:a2e:9cd4:0:b0:2c0:32a1:71dd with SMTP id g20-20020a2e9cd4000000b002c032a171ddmr3057022ljj.28.1695237123544;
        Wed, 20 Sep 2023 12:12:03 -0700 (PDT)
Received: from localhost ([85.26.234.178])
        by smtp.gmail.com with ESMTPSA id g20-20020a2eb5d4000000b002bff8ed8e2bsm2108019ljn.9.2023.09.20.12.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:12:02 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 14/20] EDAC/mc: Add generic unique MC index allocation procedure
Date:   Wed, 20 Sep 2023 22:10:38 +0300
Message-ID: <20230920191059.28395-15-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920191059.28395-1-fancer.lancer@gmail.com>
References: <20230920191059.28395-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the EDAC subsystem relies on the low-level device drivers to
select an unique index for each memory controller available in the system.
Here are the already implemented approaches:
1. Fixed zero id. The vast majority of the drivers expect to have a single
memory controller in the system.
2. Calculate based on a platform-specific way (Pre-defined devices order,
PCIe-bus address, Numa node ID + PCIe-function number, etc).
3. Use platform_device->id.
4. Use custom ACPI/OF property value.
5. Use locally maintained static MC counter.

Create a generic method of the MC index allocation which could be utilized
for the case 5 (it doesn't imply any strict memory controller order) and
which would prevent the new MC EDAC drivers re-implementing the approaches
3 and 4. Moreover it will be useful for the cases when a platform is
equipped with memory-controllers of different types [1] and which are
probed by different drivers [2].

[1] Link: https://lore.kernel.org/all/9dc2a947-d2ab-4f00-8ed3-d2499cb6fdfd@BN1BFFO11FD002.protection.gbl/
[2] Link: https://lore.kernel.org/linux-edac/BY5PR12MB4258CB67B70D71F107EC1E9DDB3E9@BY5PR12MB4258.namprd12.prod.outlook.com

The suggested implementation is based on the IDA kernel API and implies
the next semantics:
1. If a particular MC index is specified it will be registered in the
IDR pool unless the specified ID has already been reserved.
2. If a special MC index is specified (EDAC_AUTO_MC_NUM) the EDAC
core will check whether there is a "mcID" alias is defined in the device
tree and use the ID from there if it's found.
3. Otherwise a next free index will be allocated and assigned to the
registered memory controller.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Note the approach implemented here has been partly ported from the SPI
core driver using IDA to track/allocate SPI bus numbers.
Link: https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L2957
---
 drivers/edac/edac_mc.c | 89 +++++++++++++++++++++++++++++++++++++++---
 drivers/edac/edac_mc.h |  4 ++
 2 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 24814839d885..634c41ea7804 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -29,6 +29,9 @@
 #include <linux/edac.h>
 #include <linux/bitops.h>
 #include <linux/uaccess.h>
+#include <linux/idr.h>
+#include <linux/of.h>
+
 #include <asm/page.h>
 #include "edac_mc.h"
 #include "edac_module.h"
@@ -46,6 +49,7 @@ EXPORT_SYMBOL_GPL(edac_op_state);
 /* lock to memory controller's control array */
 static DEFINE_MUTEX(mem_ctls_mutex);
 static LIST_HEAD(mc_devices);
+static DEFINE_IDR(mc_idr);
 
 /*
  * Used to lock EDAC MC to just one module, avoiding two drivers e. g.
@@ -493,7 +497,64 @@ void edac_mc_reset_delay_period(unsigned long value)
 	mutex_unlock(&mem_ctls_mutex);
 }
 
+/**
+ * edac_mc_alloc_id() - Allocate unique Memory Controller identifier
+ *
+ * @mci: pointer to the mci structure to allocate ID for
+ *
+ * Use edac_mc_free_id() to coherently free the MC identifier.
+ *
+ * .. note::
+ *	locking model: must be called with the mem_ctls_mutex lock held
+ *
+ * Returns:
+ *	0 on Success, or an error code on failure
+ */
+static int edac_mc_alloc_id(struct mem_ctl_info *mci)
+{
+	struct device_node *np = dev_of_node(mci->pdev);
+	int ret, min, max;
+
+	if (mci->mc_idx == EDAC_AUTO_MC_NUM) {
+		ret = of_alias_get_id(np, "mc");
+		if (ret >= 0) {
+			min = ret;
+			max = ret + 1;
+		} else {
+			min = of_alias_get_highest_id("mc");
+			if (min >= 0)
+				min++;
+			else
+				min = 0;
+
+			max = 0;
+		}
+	} else {
+		min = mci->mc_idx;
+		max = mci->mc_idx + 1;
+	}
+
+	ret = idr_alloc(&mc_idr, mci, min, max, GFP_KERNEL);
+	if (ret < 0)
+		return ret == -ENOSPC ? -EBUSY : ret;
+
+	mci->mc_idx = ret;
+
+	return 0;
+}
 
+/**
+ * edac_mc_free_id() - Free Memory Controller identifier
+ *
+ * @mci: pointer to the mci structure to free ID from
+ *
+ * .. note::
+ *	locking model: must be called with the mem_ctls_mutex lock held
+ */
+static void edac_mc_free_id(struct mem_ctl_info *mci)
+{
+	idr_remove(&mc_idr, mci->mc_idx);
+}
 
 /**
  * edac_mc_init_labels() - Initialize DIMM labels
@@ -612,7 +673,8 @@ EXPORT_SYMBOL_GPL(edac_get_owner);
 int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 			       const struct attribute_group **groups)
 {
-	int ret = -EINVAL;
+	int ret;
+
 	edac_dbg(0, "\n");
 
 #ifdef CONFIG_EDAC_DEBUG
@@ -649,20 +711,30 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 		goto fail0;
 	}
 
+	ret = edac_mc_alloc_id(mci);
+	if (ret) {
+		edac_printk(KERN_ERR, EDAC_MC, "failed to allocate MC idx %u\n",
+			    mci->mc_idx);
+		goto fail0;
+	}
+
 	edac_mc_init_labels(mci);
 
-	if (add_mc_to_global_list(mci))
-		goto fail0;
+	if (add_mc_to_global_list(mci)) {
+		ret = -EINVAL;
+		goto fail1;
+	}
 
 	/* set load time so that error rate can be tracked */
 	mci->start_time = jiffies;
 
 	mci->bus = edac_get_sysfs_subsys();
 
-	if (edac_create_sysfs_mci_device(mci, groups)) {
+	ret = edac_create_sysfs_mci_device(mci, groups);
+	if (ret) {
 		edac_mc_printk(mci, KERN_WARNING,
 			"failed to create sysfs device\n");
-		goto fail1;
+		goto fail2;
 	}
 
 	if (mci->edac_check) {
@@ -686,9 +758,12 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
 	mutex_unlock(&mem_ctls_mutex);
 	return 0;
 
-fail1:
+fail2:
 	del_mc_from_global_list(mci);
 
+fail1:
+	edac_mc_free_id(mci);
+
 fail0:
 	mutex_unlock(&mem_ctls_mutex);
 	return ret;
@@ -716,6 +791,8 @@ struct mem_ctl_info *edac_mc_del_mc(struct device *dev)
 	if (del_mc_from_global_list(mci))
 		edac_mc_owner = NULL;
 
+	edac_mc_free_id(mci);
+
 	mutex_unlock(&mem_ctls_mutex);
 
 	if (mci->edac_check)
diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index 881b00eadf7a..4b6676235b1b 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -23,6 +23,7 @@
 #define _EDAC_MC_H_
 
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
@@ -37,6 +38,9 @@
 #include <linux/workqueue.h>
 #include <linux/edac.h>
 
+/* Generate MC identifier automatically */
+#define EDAC_AUTO_MC_NUM	UINT_MAX
+
 #if PAGE_SHIFT < 20
 #define PAGES_TO_MiB(pages)	((pages) >> (20 - PAGE_SHIFT))
 #define MiB_TO_PAGES(mb)	((mb) << (20 - PAGE_SHIFT))
-- 
2.41.0

