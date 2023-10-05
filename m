Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FA37BAACF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjJET4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjJETzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:55:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28743DB;
        Thu,  5 Oct 2023 12:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696535747; x=1728071747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GOHBkM4E1xt6ifRLwPO4brJgQO1Uu7WIe/PQmNjPNOU=;
  b=aIKcgTcF/3ctJ0qwKnY/ghJbdOJe9m2e4KUMHgZQ5EIAol5M8lYWdwks
   dbhCrkIdf1ra4b06le+0tA9BXk2gQ2v7mljluIXY5VhYh/m1BUCWP18ip
   F+ZqOumWBcgNS1Bg044ek1Ut6GiG3GRKUJbwo5FiWpE9bEc5Z79GQsWQf
   1AktpU/Cuw128YRP4iHBBWm42MsBlXFQGXqPXE9PbPp2JFUEU+JisqEFx
   TFjA8xRBzSm6pQ83aVG8LJI5gNYuSFp/4R733uGiMmXBVLMs5oNXbYBHq
   +d9CY8WJ6KsqFhpc3rkMqwi98bJPGyaxTriRYjtHaJs37qFQ20w9vrf2G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="386432558"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="386432558"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:55:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="755600129"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="755600129"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:55:44 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, jithu.joseph@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com
Subject: [PATCH v4 5/9] platform/x86/intel/ifs: Validate image size
Date:   Thu,  5 Oct 2023 12:51:33 -0700
Message-Id: <20231005195137.3117166-6-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231005195137.3117166-1-jithu.joseph@intel.com>
References: <20230929202436.2850388-1-jithu.joseph@intel.com>
 <20231005195137.3117166-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perform additional validation prior to loading IFS image.

Error out if the size of the file being loaded doesn't match the size
specified in the header.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
---
 drivers/platform/x86/intel/ifs/load.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 6b827247945b..582f1801aaaa 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -375,6 +375,7 @@ int ifs_load_firmware(struct device *dev)
 {
 	const struct ifs_test_caps *test = ifs_get_test_caps(dev);
 	struct ifs_data *ifsd = ifs_get_data(dev);
+	unsigned int expected_size;
 	const struct firmware *fw;
 	char scan_path[64];
 	int ret = -EINVAL;
@@ -389,6 +390,13 @@ int ifs_load_firmware(struct device *dev)
 		goto done;
 	}
 
+	expected_size = ((struct microcode_header_intel *)fw->data)->totalsize;
+	if (fw->size != expected_size) {
+		dev_err(dev, "File size mismatch (expected %u, actual %zu). Corrupted IFS image.\n",
+			expected_size, fw->size);
+		return -EINVAL;
+	}
+
 	ret = image_sanity_check(dev, (struct microcode_header_intel *)fw->data);
 	if (ret)
 		goto release;
-- 
2.25.1

