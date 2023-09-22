Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7F07ABC4F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 01:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjIVXaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 19:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjIVXaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 19:30:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04B31A2;
        Fri, 22 Sep 2023 16:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695425413; x=1726961413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eBFr+P8r5vNXCcrUFO02naJBuqwBT/yzn6Gswd0MWNo=;
  b=Umv6E5zFNmJNpMgQ3n8HElL4e9N735zfmAhn4dXUZzJf/dhddIseEYFu
   QDi1Z07Vr1+WNI71BgCpgE4urF/fFtbUIEOW7BduQtgQ7ZWRJLHfF80rA
   iK70y1j1pvoeXUoeiM9Q/6mZ6Sjtvj75eCP5/llIHjL912H7F478rUsa3
   mnqMd2I2cQoEh4Kt2fTakXl8v6k8niU2g2rXok0JSX2L2dFjg6DfnVzVl
   VGGU30v9rTQ4tuJ4rkePKRivq0/OGCvJTC327gvuEEDoHd1hqCDi6z6bu
   POA6T0K2RzaDLmwUKFgI77e3Y98IjjovS/GNEU3qk6ysesPH8YvoWdoST
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="411896932"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="411896932"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 16:30:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="921350830"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="921350830"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 16:30:11 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, jithu.joseph@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v2 2/9] platform/x86/intel/ifs: Refactor image loading code
Date:   Fri, 22 Sep 2023 16:25:59 -0700
Message-Id: <20230922232606.1928026-3-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230922232606.1928026-1-jithu.joseph@intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com>
 <20230922232606.1928026-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IFS image loading flow is slightly different for newer IFS generations.

In preparation for adding support for newer IFS generations, refactor
portions of existing image loading code for reuse.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
---
 drivers/platform/x86/intel/ifs/load.c | 31 ++++++++++++++++-----------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index cefd0d886cfd..851c97cc6a6b 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -80,6 +80,23 @@ static struct metadata_header *find_meta_data(void *ucode, unsigned int meta_typ
 	return NULL;
 }
 
+static void hashcopy_err_message(struct device *dev, u32 err_code)
+{
+	if (err_code >= ARRAY_SIZE(scan_hash_status))
+		dev_err(dev, "invalid error code 0x%x for hash copy\n", err_code);
+	else
+		dev_err(dev, "Hash copy error : %s\n", scan_hash_status[err_code]);
+}
+
+static void auth_err_message(struct device *dev, u32 err_code)
+{
+	if (err_code >= ARRAY_SIZE(scan_authentication_status))
+		dev_err(dev, "invalid error code 0x%x for authentication\n", err_code);
+	else
+		dev_err(dev, "Chunk authentication error : %s\n",
+			scan_authentication_status[err_code]);
+}
+
 /*
  * To copy scan hashes and authenticate test chunks, the initiating cpu must point
  * to the EDX:EAX to the test image in linear address.
@@ -109,11 +126,7 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
 
 	if (!hashes_status.valid) {
 		ifsd->loading_error = true;
-		if (err_code >= ARRAY_SIZE(scan_hash_status)) {
-			dev_err(dev, "invalid error code 0x%x for hash copy\n", err_code);
-			goto done;
-		}
-		dev_err(dev, "Hash copy error : %s", scan_hash_status[err_code]);
+		hashcopy_err_message(dev, err_code);
 		goto done;
 	}
 
@@ -133,13 +146,7 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
 
 		if (err_code) {
 			ifsd->loading_error = true;
-			if (err_code >= ARRAY_SIZE(scan_authentication_status)) {
-				dev_err(dev,
-					"invalid error code 0x%x for authentication\n", err_code);
-				goto done;
-			}
-			dev_err(dev, "Chunk authentication error %s\n",
-				scan_authentication_status[err_code]);
+			auth_err_message(dev, err_code);
 			goto done;
 		}
 	}
-- 
2.25.1

