Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D7779F142
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjIMSiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjIMSiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:38:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E763EA3;
        Wed, 13 Sep 2023 11:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694630277; x=1726166277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xI88hAM69WWRoFYmYgNa2YKj3tBz+3B5FzPZW/C4gzc=;
  b=f3fC0vmL1vzgRRu8q2gAd2+/f9HiVV3nbItRn5aKArpYKX7Tw76Q1UAz
   V9diXBYhVt57EQT1X0BYreK5WzGl2EtT2QpTeHMFeXEOB2WnbMH4vgZwW
   sjXGegrxqEz/j2bsaFgWT/nxLHQ8Bgj7gvqW3bzNlN/8DzqG7DUFQMLpH
   D8f9Ys7cODwEX+FJljER66uwf75Bi1I42G+BT5EioKLjAiUX7K7ajnZlK
   DmnQJ1EGH8q6TPyWfk5GhtkpjZX9rz/cBueEWBCdOtFy0lG+4mT2+9elf
   nTaaTX4mZFQviQz57WV/sYdeejCtqNUPm9b1ICbsS9ugkwY+Eb1O1eI8r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="369019203"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="369019203"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 11:37:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="744238603"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="744238603"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 11:37:57 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, jithu.joseph@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com
Subject: [PATCH 09/10] platform/x86/intel/ifs: Add new error code
Date:   Wed, 13 Sep 2023 11:33:47 -0700
Message-Id: <20230913183348.1349409-10-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230913183348.1349409-1-jithu.joseph@intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make driver aware of a newly added error code so that it can
provide a more appropriate error message.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
---
 drivers/platform/x86/intel/ifs/runtest.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index ba3f9ad88a82..997d2f07aa0c 100644
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

