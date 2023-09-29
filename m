Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BBF7B3B88
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjI2Upu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjI2Up2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:45:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C0A1AB;
        Fri, 29 Sep 2023 13:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696020325; x=1727556325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c8ofPZQg6aJ0kE1jG7f82ai6elYHrz7FK0oJN2MLVaE=;
  b=LnuOF7vQThmb+sMqmYLKQrUB0uve3SgmgQiyGiPmeyT/IUun61I+FYIy
   QRyLZ/Pt3dKhI8mf/c5TBfalCy6VSbRFlUSjEUwLnRT5r9qmnLqpJzVl7
   D51ciHADPxphMCOJagFa+Y9A8JIN4fWXargxLXTmPJ6fWdtu3hKJYIGL9
   iQokc0DeZpbYCGtNnqyVIPPZvAF3HRpmH3tdZKyOcjVgIEoH1TBxbD8NW
   n0rHCxr5ONGpDSJfj/ui7EGASZj093lhc6m/k5zI+kThAoZA0Nmes8P6q
   O4OPKVt8Wm3J+DeiG5n1rPAEFxTrC/5D9baKWBC835G+LCrApKx9DcEmH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="468654487"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="468654487"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 13:28:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="893539262"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="893539262"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 13:27:30 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, jithu.joseph@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v3 8/9] platform/x86/intel/ifs: Add new error code
Date:   Fri, 29 Sep 2023 13:24:35 -0700
Message-Id: <20230929202436.2850388-9-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230929202436.2850388-1-jithu.joseph@intel.com>
References: <20230922232606.1928026-1-jithu.joseph@intel.com>
 <20230929202436.2850388-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Make driver aware of a newly added error code so that it can provide a
more appropriate error message.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
---
 drivers/platform/x86/intel/ifs/runtest.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index 925c30c79011..4fe544d79946 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -40,6 +40,8 @@ enum ifs_status_err_code {
 	IFS_UNASSIGNED_ERROR_CODE		= 7,
 	IFS_EXCEED_NUMBER_OF_THREADS_CONCURRENT	= 8,
 	IFS_INTERRUPTED_DURING_EXECUTION	= 9,
+	IFS_UNASSIGNED_ERROR_CODE_0xA		= 0xA,
+	IFS_CORRUPTED_CHUNK		= 0xB,
 };
 
 static const char * const scan_test_status[] = {
@@ -55,6 +57,8 @@ static const char * const scan_test_status[] = {
 	[IFS_EXCEED_NUMBER_OF_THREADS_CONCURRENT] =
 	"Exceeded number of Logical Processors (LP) allowed to run Scan-At-Field concurrently",
 	[IFS_INTERRUPTED_DURING_EXECUTION] = "Interrupt occurred prior to SCAN start",
+	[IFS_UNASSIGNED_ERROR_CODE_0xA] = "Unassigned error code 0xA",
+	[IFS_CORRUPTED_CHUNK] = "Scan operation aborted due to corrupted image. Try reloading",
 };
 
 static void message_not_tested(struct device *dev, int cpu, union ifs_status status)
@@ -123,6 +127,8 @@ static bool can_restart(union ifs_status status)
 	case IFS_MISMATCH_ARGUMENTS_BETWEEN_THREADS:
 	case IFS_CORE_NOT_CAPABLE_CURRENTLY:
 	case IFS_UNASSIGNED_ERROR_CODE:
+	case IFS_UNASSIGNED_ERROR_CODE_0xA:
+	case IFS_CORRUPTED_CHUNK:
 		break;
 	}
 	return false;
-- 
2.25.1

