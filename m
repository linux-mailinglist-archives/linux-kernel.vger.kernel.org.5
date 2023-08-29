Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793D578BDE2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbjH2FYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbjH2FYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:24:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B61F19A;
        Mon, 28 Aug 2023 22:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693286643; x=1724822643;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CRtmUhD14GT5Q6ZjiafnJto9DQ4XwPEExp4RUj6Mt6k=;
  b=QL6VJ5Z6TEfOdCmsbyLW8f9O/yReNTz1zHH4hLYBQsGU/nZOf027Qwpr
   EH8H/rnOktPNMNlmXyvIfYWeJL4HVgGpE67j8/sDtsz/QdqH+XRS0ljAF
   tVD7VBllCmmvAFocbXvlWBGOjyh4xlketTmGhkpmf3xMd7O+zyHRbb8Rg
   o7EMXffojOfWYGF22/krkdj+YV+kj2l+0eap32XOaRQVBtB7N5n2E1G4M
   BikAHZJRBDkeSSRjjHp1vk6C+/lT0nb2nFxzJ5dve8u+HPzgimArcjVgL
   eZ/Nk/3juPH8mFirlrni5WJWmmlSVQKIeRyXhmlyz0wr2SoLaYf3ee97X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="441625190"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="441625190"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="738556335"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="738556335"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.37.183])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:36 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Mon, 28 Aug 2023 22:20:56 -0700
Subject: [PATCH RFC v2 05/18] cxl/port: Add Dynamic Capacity mode support
 to endpoint decoders
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230604-dcd-type2-upstream-v2-5-f740c47e7916@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693286607; l=4798;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=CRtmUhD14GT5Q6ZjiafnJto9DQ4XwPEExp4RUj6Mt6k=;
 b=RilpG+uu7lsmLcHfusjl1xkPACJJMfXQ69OmjoYc9afp5P/uj+9qxbjGxqbmUOLMSXihiz0RB
 dawlgwbXYxlBZbWujCu07iw8OHRgAf76AewYhBFQOQKSIBT8yZMDuTR
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

Endpoint decoders used to map Dynamic Capacity must be configured to
point to the correct Dynamic Capacity (DC) Region.  The decoder mode
currently represents the partition the decoder points to such as ram or
pmem.

Expand the mode to include DC Regions.

Co-developed-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v2:
[iweiny: split from region creation patch]
---
 Documentation/ABI/testing/sysfs-bus-cxl | 19 ++++++++++---------
 drivers/cxl/core/hdm.c                  | 24 ++++++++++++++++++++++++
 drivers/cxl/core/port.c                 | 16 ++++++++++++++++
 3 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 6350dd82b9a9..2268ffcdb604 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -257,22 +257,23 @@ Description:
 
 What:		/sys/bus/cxl/devices/decoderX.Y/mode
 Date:		May, 2022
-KernelVersion:	v6.0
+KernelVersion:	v6.0, v6.6 (dcY)
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
 		translates from a host physical address range, to a device local
 		address range. Device-local address ranges are further split
-		into a 'ram' (volatile memory) range and 'pmem' (persistent
-		memory) range. The 'mode' attribute emits one of 'ram', 'pmem',
-		'mixed', or 'none'. The 'mixed' indication is for error cases
-		when a decoder straddles the volatile/persistent partition
-		boundary, and 'none' indicates the decoder is not actively
-		decoding, or no DPA allocation policy has been set.
+		into a 'ram' (volatile memory) range, 'pmem' (persistent
+		memory) range, or Dynamic Capacity (DC) range. The 'mode'
+		attribute emits one of 'ram', 'pmem', 'dcY', 'mixed', or
+		'none'. The 'mixed' indication is for error cases when a
+		decoder straddles the volatile/persistent partition boundary,
+		and 'none' indicates the decoder is not actively decoding, or
+		no DPA allocation policy has been set.
 
 		'mode' can be written, when the decoder is in the 'disabled'
-		state, with either 'ram' or 'pmem' to set the boundaries for the
-		next allocation.
+		state, with 'ram', 'pmem', or 'dcY' to set the boundaries for
+		the next allocation.
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index a254f79dd4e8..3f4af1f5fac8 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -267,6 +267,19 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 	__cxl_dpa_release(cxled);
 }
 
+static int dc_mode_to_region_index(enum cxl_decoder_mode mode)
+{
+	int index = 0;
+
+	for (int i = CXL_DECODER_DC0; i <= CXL_DECODER_DC7; i++) {
+		if (mode == i)
+			return index;
+		index++;
+	}
+
+	return -EINVAL;
+}
+
 static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			     resource_size_t base, resource_size_t len,
 			     resource_size_t skipped)
@@ -429,6 +442,7 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 	switch (mode) {
 	case CXL_DECODER_RAM:
 	case CXL_DECODER_PMEM:
+	case CXL_DECODER_DC0 ... CXL_DECODER_DC7:
 		break;
 	default:
 		dev_dbg(dev, "unsupported mode: %d\n", mode);
@@ -456,6 +470,16 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
 		goto out;
 	}
 
+	for (int i = CXL_DECODER_DC0; i <= CXL_DECODER_DC7; i++) {
+		int index = dc_mode_to_region_index(i);
+
+		if (mode == i && !resource_size(&cxlds->dc_res[index])) {
+			dev_dbg(dev, "no available dynamic capacity\n");
+			rc = -ENXIO;
+			goto out;
+		}
+	}
+
 	cxled->mode = mode;
 	rc = 0;
 out:
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f58cf01f8d2c..ce4a66865db3 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -197,6 +197,22 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
 		mode = CXL_DECODER_PMEM;
 	else if (sysfs_streq(buf, "ram"))
 		mode = CXL_DECODER_RAM;
+	else if (sysfs_streq(buf, "dc0"))
+		mode = CXL_DECODER_DC0;
+	else if (sysfs_streq(buf, "dc1"))
+		mode = CXL_DECODER_DC1;
+	else if (sysfs_streq(buf, "dc2"))
+		mode = CXL_DECODER_DC2;
+	else if (sysfs_streq(buf, "dc3"))
+		mode = CXL_DECODER_DC3;
+	else if (sysfs_streq(buf, "dc4"))
+		mode = CXL_DECODER_DC4;
+	else if (sysfs_streq(buf, "dc5"))
+		mode = CXL_DECODER_DC5;
+	else if (sysfs_streq(buf, "dc6"))
+		mode = CXL_DECODER_DC6;
+	else if (sysfs_streq(buf, "dc7"))
+		mode = CXL_DECODER_DC7;
 	else
 		return -EINVAL;
 

-- 
2.41.0

