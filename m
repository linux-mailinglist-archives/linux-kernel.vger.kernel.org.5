Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B203079F139
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjIMSiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjIMSh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:37:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DB7A3;
        Wed, 13 Sep 2023 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694630275; x=1726166275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xCxH2O4NnZUcc0zAWHVPgXZ+7sRheSRlMJvoqoWVMlQ=;
  b=aDY70ni7Dq5ZnccNDiJSseOcbPRryo1PJ8obR1wrVz1j70JoofuRBCUO
   qBLE+RlfezZVpvc9ctHT+JTtSw/Ub4gWWU4ogSDJRCYCkDChdvZroThVV
   pzw0VEz1XZp+GZCc2HoOIobk1/ntcqjLfrWy9aFL9Dkbjzr9VTXcQ8cef
   Dj3T0PXpCNczgMHEIISg4QBSODfFKmEQXrpTTmgJHo4Cj3VRdhr6F01ln
   6BefbbxxjazaUU2+rp/Tq8oNMSHDC/5Pv18utw/TNvHW7GyGjBnaSWbEr
   IHqhteh9XDxh+TaKDwqlikAg+8Xsu8wR2j1lDKv9lFyP/Iep5nRBQ7hvY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="369019122"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="369019122"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 11:37:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="744238578"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="744238578"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 11:37:54 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, jithu.joseph@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com
Subject: [PATCH 02/10] platform/x86/intel/ifs: Refactor image loading code
Date:   Wed, 13 Sep 2023 11:33:40 -0700
Message-Id: <20230913183348.1349409-3-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230913183348.1349409-1-jithu.joseph@intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IFS image loading flow is slightly different for newer IFS
generations.

In preparation for adding support for newer IFS generations,
refactor portions of existing image loading code for reuse.

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

