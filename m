Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3274D80F198
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376716AbjLLPzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjLLPzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:55:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 001F0100
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:55:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22DEA143D;
        Tue, 12 Dec 2023 07:55:59 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4E8F43F738;
        Tue, 12 Dec 2023 07:55:11 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, suzuki.poulose@arm.com
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/8] coresight: Make language around "activated" sinks consistent
Date:   Tue, 12 Dec 2023 15:53:59 +0000
Message-Id: <20231212155407.1429121-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212155407.1429121-1-james.clark@arm.com>
References: <20231212155407.1429121-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Activated has the specific meaning of a sink that's selected for use by
the user via sysfs. But comments in some code that's shared by Perf use
the same word, so in those cases change them to just say "selected"
instead. With selected implying either via Perf or "activated" via
sysfs.

coresight_get_enabled_sink() doesn't actually get an enabled sink, it
only gets an activated one, so change that too.

And change the activated variable name to include "sysfs" so it can't
be confused as a general status.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 51 ++++++++------------
 drivers/hwtracing/coresight/coresight-priv.h |  2 -
 include/linux/coresight.h                    | 14 +++---
 3 files changed, 27 insertions(+), 40 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 965bb6d4e1bf..f79aa9ff9b64 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -500,7 +500,7 @@ static void coresight_disable_path_from(struct list_head *path,
 		/*
 		 * ETF devices are tricky... They can be a link or a sink,
 		 * depending on how they are configured.  If an ETF has been
-		 * "activated" it will be configured as a sink, otherwise
+		 * selected as a sink it will be configured as a sink, otherwise
 		 * go ahead with the link configuration.
 		 */
 		if (type == CORESIGHT_DEV_TYPE_LINKSINK)
@@ -578,7 +578,7 @@ int coresight_enable_path(struct list_head *path, enum cs_mode mode,
 		/*
 		 * ETF devices are tricky... They can be a link or a sink,
 		 * depending on how they are configured.  If an ETF has been
-		 * "activated" it will be configured as a sink, otherwise
+		 * selected as a sink it will be configured as a sink, otherwise
 		 * go ahead with the link configuration.
 		 */
 		if (type == CORESIGHT_DEV_TYPE_LINKSINK)
@@ -635,15 +635,21 @@ struct coresight_device *coresight_get_sink(struct list_head *path)
 	return csdev;
 }
 
+/**
+ * coresight_find_activated_sysfs_sink - returns the first sink activated via
+ * sysfs using connection based search starting from the source reference.
+ *
+ * @csdev: Coresight source device reference
+ */
 static struct coresight_device *
-coresight_find_enabled_sink(struct coresight_device *csdev)
+coresight_find_activated_sysfs_sink(struct coresight_device *csdev)
 {
 	int i;
 	struct coresight_device *sink = NULL;
 
 	if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
 	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) &&
-	     csdev->activated)
+	     csdev->sysfs_sink_activated)
 		return csdev;
 
 	/*
@@ -654,7 +660,7 @@ coresight_find_enabled_sink(struct coresight_device *csdev)
 
 		child_dev = csdev->pdata->out_conns[i]->dest_dev;
 		if (child_dev)
-			sink = coresight_find_enabled_sink(child_dev);
+			sink = coresight_find_activated_sysfs_sink(child_dev);
 		if (sink)
 			return sink;
 	}
@@ -662,21 +668,6 @@ coresight_find_enabled_sink(struct coresight_device *csdev)
 	return NULL;
 }
 
-/**
- * coresight_get_enabled_sink - returns the first enabled sink using
- * connection based search starting from the source reference
- *
- * @source: Coresight source device reference
- */
-struct coresight_device *
-coresight_get_enabled_sink(struct coresight_device *source)
-{
-	if (!source)
-		return NULL;
-
-	return coresight_find_enabled_sink(source);
-}
-
 static int coresight_sink_by_id(struct device *dev, const void *data)
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
@@ -810,11 +801,10 @@ static void coresight_drop_device(struct coresight_device *csdev)
  * @sink:	The final sink we want in this path.
  * @path:	The list to add devices to.
  *
- * The tree of Coresight device is traversed until an activated sink is
- * found.  From there the sink is added to the list along with all the
- * devices that led to that point - the end result is a list from source
- * to sink. In that list the source is the first device and the sink the
- * last one.
+ * The tree of Coresight device is traversed until the selected sink is found.
+ * From there the sink is added to the list along with all the devices that led
+ * to that point - the end result is a list from source to sink. In that list
+ * the source is the first device and the sink the last one.
  */
 static int _coresight_build_path(struct coresight_device *csdev,
 				 struct coresight_device *sink,
@@ -824,7 +814,7 @@ static int _coresight_build_path(struct coresight_device *csdev,
 	bool found = false;
 	struct coresight_node *node;
 
-	/* An activated sink has been found.  Enqueue the element */
+	/* The selected sink has been found.  Enqueue the element */
 	if (csdev == sink)
 		goto out;
 
@@ -1145,7 +1135,7 @@ int coresight_enable(struct coresight_device *csdev)
 		goto out;
 	}
 
-	sink = coresight_get_enabled_sink(csdev);
+	sink = coresight_find_activated_sysfs_sink(csdev);
 	if (!sink) {
 		ret = -EINVAL;
 		goto out;
@@ -1259,7 +1249,7 @@ static ssize_t enable_sink_show(struct device *dev,
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", csdev->activated);
+	return scnprintf(buf, PAGE_SIZE, "%u\n", csdev->sysfs_sink_activated);
 }
 
 static ssize_t enable_sink_store(struct device *dev,
@@ -1274,10 +1264,7 @@ static ssize_t enable_sink_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (val)
-		csdev->activated = true;
-	else
-		csdev->activated = false;
+	csdev->sysfs_sink_activated = !!val;
 
 	return size;
 
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 30c051055e54..ced5be05a527 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -130,8 +130,6 @@ void coresight_disable_path(struct list_head *path);
 int coresight_enable_path(struct list_head *path, enum cs_mode mode,
 			  void *sink_data);
 struct coresight_device *coresight_get_sink(struct list_head *path);
-struct coresight_device *
-coresight_get_enabled_sink(struct coresight_device *source);
 struct coresight_device *coresight_get_sink_by_id(u32 id);
 struct coresight_device *
 coresight_find_default_sink(struct coresight_device *csdev);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index a4cb7dd6ca23..65131bfbd904 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -229,10 +229,12 @@ struct coresight_sysfs_link {
  * @refcnt:	keep track of what is in use.
  * @orphan:	true if the component has connections that haven't been linked.
  * @enable:	'true' if component is currently part of an active path.
- * @activated:	'true' only if a _sink_ has been activated.  A sink can be
- *		activated but not yet enabled.  Enabling for a _sink_
- *		happens when a source has been selected and a path is enabled
- *		from source to that sink.
+ * @sysfs_sink_activated: 'true' when a sink has been selected for use via sysfs
+ *		by writing a 1 to the 'enable_sink' file.  A sink can be
+ *		activated but not yet enabled.  Enabling for a _sink_ happens
+ *		when a source has been selected and a path is enabled from
+ *		source to that sink. A sink can also become enabled but not
+ *		activated if it's used via Perf.
  * @ea:		Device attribute for sink representation under PMU directory.
  * @def_sink:	cached reference to default sink found for this device.
  * @nr_links:   number of sysfs links created to other components from this
@@ -252,9 +254,9 @@ struct coresight_device {
 	struct device dev;
 	atomic_t refcnt;
 	bool orphan;
-	bool enable;	/* true only if configured as part of a path */
+	bool enable;
 	/* sink specific fields */
-	bool activated;	/* true only if a sink is part of a path */
+	bool sysfs_sink_activated;
 	struct dev_ext_attribute *ea;
 	struct coresight_device *def_sink;
 	/* sysfs links between components */
-- 
2.34.1

