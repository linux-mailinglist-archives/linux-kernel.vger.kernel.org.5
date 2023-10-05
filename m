Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9F67BAACB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjJETzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjJETzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:55:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C13FE4;
        Thu,  5 Oct 2023 12:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696535746; x=1728071746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GtDY6ML84SF+F8nWzdP67B1CzR7rZUd3wkHRxH1boOQ=;
  b=lJyE0zkWQ6UACLH42cKtaBn5t6X10PnobOilhU40OwgHkOtPNhhK68eK
   F+9g9CJ0xvGCxUlMjLGt30cHLaLj8IE7bddKa3ksAcCA9fTuHiogVwuV7
   z9COADMulfesnJiU73SVS4Xhovr5eY3KDSWqzOdHTBP6P0/znyP0ZDWDG
   bFIR25PIH/HxETG6+Tl9KTIB1N3jaYndaK16qEIf/Nas+pDbHCdsL3++G
   XHHc70D3gTReCXC/RtrCPK148Ljwxd8KcVJmgGULn5VrQXIanlMtLEf6e
   cWZ5y2XunmNu9rNIvcixPds3eFzvh5hfO+kyzBNgRp3EhU317cABbR1MT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="386432554"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="386432554"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 12:55:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="755600118"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="755600118"
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
Subject: [PATCH v4 2/9] platform/x86/intel/ifs: Refactor image loading code
Date:   Thu,  5 Oct 2023 12:51:30 -0700
Message-Id: <20231005195137.3117166-3-jithu.joseph@intel.com>
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

IFS image loading flow is slightly different for newer IFS generations.

In preparation for adding support for newer IFS generations, refactor
portions of existing image loading code for reuse.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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

