Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE9C78BDD0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbjH2FYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbjH2FYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:24:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF50E199;
        Mon, 28 Aug 2023 22:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693286652; x=1724822652;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=UjeGgzDfDpxcCqBVnjRJhF3JRUS9A6pPcoh/q1uIkpA=;
  b=nefvNVAoruCClUpFf9ovj1iOQKTyessoBgo8fK2lSfKnl2vhi44iA688
   QzAWEGif3WFOnXwrgXoEZMv1UbvtfH1omuNdo5mvUF/OmBuo8qur1jBnJ
   W2JmrYk2Cs/5P2tIk0jEbz2PMEJxizrhLTGwI98ECBUfIQa5BETITd4eb
   XGKhmKTAJwLURDXS58RD1KUJhNFFpC/RPeX9/fQL6PtpVJBOcguZqn5bK
   AwTOnizRXGFUM6d8HW4VJrShY6Mky+WkUmkW48zEZYf2GGrfn5h36iJGE
   z/ON/775Q+g8qntfgcImLq7d1ejgEJamCDgFZWKuCq25nVKH2PW2fZ593
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="441625271"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="441625271"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="738556469"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="738556469"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.37.183])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:53 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Mon, 28 Aug 2023 22:21:09 -0700
Subject: [PATCH RFC v2 18/18] tools/testing/cxl: Add Dynamic Capacity
 events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230604-dcd-type2-upstream-v2-18-f740c47e7916@intel.com>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693286608; l=3592;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=UjeGgzDfDpxcCqBVnjRJhF3JRUS9A6pPcoh/q1uIkpA=;
 b=+iYL3SbR8ycp8mDueZbDV4zygoUH8KKJqSL7gi3xjOqlj9y2o9BDuTWvxi4DLiIX024QGRss4
 YxpIjiqKZprBoaH4BkGF64eg5LaOrb8Mf6ZlyvNN4GZB0OPanRB82Qs
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OS software needs to be alerted when new extents arrive on a Dynamic
Capacity Device (DCD).  On test DCDs extents are added through sysfs.

Add events on DCD extent injection.  Directly call the event irq
callback to simulate irqs to process the test extents.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 tools/testing/cxl/test/mem.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index d6041a2145c5..20364fee9df9 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -2008,6 +2008,41 @@ static bool new_extent_valid(struct device *dev, size_t new_start,
 	return false;
 }
 
+struct dcd_event_dyn_cap dcd_event_rec_template = {
+	.hdr = {
+		.id = UUID_INIT(0xca95afa7, 0xf183, 0x4018,
+				0x8c, 0x2f, 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
+		.length = sizeof(struct dcd_event_dyn_cap),
+	},
+};
+
+static int send_dc_event(struct mock_event_store *mes, enum dc_event type,
+			 u64 start, u64 length, const char *tag_str)
+{
+	struct device *dev = mes->mds->cxlds.dev;
+	struct dcd_event_dyn_cap *dcd_event_rec;
+
+	dcd_event_rec = devm_kzalloc(dev, sizeof(*dcd_event_rec), GFP_KERNEL);
+	if (!dcd_event_rec)
+		return -ENOMEM;
+
+	memcpy(dcd_event_rec, &dcd_event_rec_template, sizeof(*dcd_event_rec));
+	dcd_event_rec->data.event_type = type;
+	dcd_event_rec->data.extent.start_dpa = cpu_to_le64(start);
+	dcd_event_rec->data.extent.length = cpu_to_le64(length);
+	memcpy(dcd_event_rec->data.extent.tag, tag_str,
+	       min(sizeof(dcd_event_rec->data.extent.tag),
+		   strlen(tag_str)));
+
+	mes_add_event(mes, CXL_EVENT_TYPE_DCD,
+		      (struct cxl_event_record_raw *)dcd_event_rec);
+
+	/* Fake the irq */
+	cxl_mem_get_event_records(mes->mds, CXLDEV_EVENT_STATUS_DCD);
+
+	return 0;
+}
+
 /*
  * Format <start>:<length>:<tag>
  *
@@ -2021,6 +2056,7 @@ static ssize_t dc_inject_extent_store(struct device *dev,
 				      const char *buf, size_t count)
 {
 	char *start_str __free(kfree) = kstrdup(buf, GFP_KERNEL);
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
 	unsigned long long start, length;
 	char *len_str, *tag_str;
 	size_t buf_len = count;
@@ -2063,6 +2099,13 @@ static ssize_t dc_inject_extent_store(struct device *dev,
 	if (rc)
 		return rc;
 
+	rc = send_dc_event(&mdata->mes, DCD_ADD_CAPACITY, start, length,
+			   tag_str);
+	if (rc) {
+		dev_err(dev, "Failed to add event %d\n", rc);
+		return rc;
+	}
+
 	return count;
 }
 static DEVICE_ATTR_WO(dc_inject_extent);
@@ -2071,6 +2114,7 @@ static ssize_t dc_del_extent_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t count)
 {
+	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
 	unsigned long long start;
 	int rc;
 
@@ -2083,6 +2127,12 @@ static ssize_t dc_del_extent_store(struct device *dev,
 	if (rc)
 		return rc;
 
+	rc = send_dc_event(&mdata->mes, DCD_RELEASE_CAPACITY, start, 0, "");
+	if (rc) {
+		dev_err(dev, "Failed to add event %d\n", rc);
+		return rc;
+	}
+
 	return count;
 }
 static DEVICE_ATTR_WO(dc_del_extent);
@@ -2111,6 +2161,13 @@ static ssize_t dc_force_del_extent_store(struct device *dev,
 	if (rc)
 		return rc;
 
+	rc = send_dc_event(&mdata->mes, DCD_FORCED_CAPACITY_RELEASE,
+			      start, 0, "");
+	if (rc) {
+		dev_err(dev, "Failed to add event %d\n", rc);
+		return rc;
+	}
+
 	return count;
 }
 static DEVICE_ATTR_WO(dc_force_del_extent);

-- 
2.41.0

