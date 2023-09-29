Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74C77B3B86
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjI2Upn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjI2Up1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:45:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D561B9;
        Fri, 29 Sep 2023 13:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696020324; x=1727556324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5hK8PYdSqpMVTtIO5x+qGkBJOJzZIeEW/a5RmMzipn4=;
  b=WI1idGjnod0AUE7lht+lm/cl6rHSrXvVhrchdAyIJ3rfsXaA2/MJQRDB
   CmBDUj/EChSjvTWBUuvbs7AAo/cfPBeV0E8Aj23EP3qbKVyUpsKmjHM9S
   bgnJfgoN2i5jrAuAqj/Rz6GZDItkaP3bWiNXouH0wbEYxM4mw1ON3Wp9f
   g04FFXzryt+504ToSgYMAvwIwvSVeyq7nKlRoxaSqyMvWBvKutHDI9Xjz
   ZJXj5g9Eh2JRBk7MgT/5xh/tZ/JmkmROs4Z0qRstbMOW9X1b9xQc/9goT
   po6S/peTMa6wLYS60909d9gHXEWoAf4npkoMZr+JrvgOIrktaIUPmg1Ik
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="468654460"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="468654460"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 13:28:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="893539240"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="893539240"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 13:27:29 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, jithu.joseph@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v3 5/9] platform/x86/intel/ifs: Validate image size
Date:   Fri, 29 Sep 2023 13:24:32 -0700
Message-Id: <20230929202436.2850388-6-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230929202436.2850388-1-jithu.joseph@intel.com>
References: <20230922232606.1928026-1-jithu.joseph@intel.com>
 <20230929202436.2850388-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
---
 drivers/platform/x86/intel/ifs/load.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 6b827247945b..da54fd060878 100644
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
+		dev_err(dev, "File size mismatch (expected %d, actual %ld). Corrupted IFS image.\n",
+			expected_size, fw->size);
+		return -EINVAL;
+	}
+
 	ret = image_sanity_check(dev, (struct microcode_header_intel *)fw->data);
 	if (ret)
 		goto release;
-- 
2.25.1

