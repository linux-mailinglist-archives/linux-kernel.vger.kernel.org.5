Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4517EF65D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346158AbjKQQkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346121AbjKQQj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:39:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530A4D4F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700239193; x=1731775193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ChsYotRgZWrgxZBj399NXM536QOR/xp1weCcE08gaRg=;
  b=TVNGTle8ml/1JuzBwz6qckpCiYx+ofih9mp0KfvIdbmQlNs8mQJdQq9R
   jCZ/zOUjVVac7m/Fqlhj4dvaOjA/WI6VIoipq+OXkAXsBIe3WSDSHPQtp
   BPAjsKoHVcoNebrdOoIUg8uRbs+5R1+NxQaYi+LYAZCW+Kn8WiHL9bkgT
   oLaOJL1QorqXBxqvvkEcUL/H2EXlzZ9vj+P6k+iGqkup3e6UTGdzj4+gN
   NaEaEMtgnHEucVciGY6L3m7Ivg5GgKtyMq/f8H21h40OqJ3Xgo5tfwYw3
   jfUVamc2fkV6AKf+RTimJXFaZIInD2emEWYcDErVMHjFHt7RTZyFMNhK1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="390185892"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="390185892"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 08:39:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="1097146208"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="1097146208"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga005.fm.intel.com with ESMTP; 17 Nov 2023 08:39:50 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Ammy Yi <ammy.yi@intel.com>
Subject: [PATCH V2 4/5] perf/x86/intel/uncore: Support IIO free-running counters on GNR
Date:   Fri, 17 Nov 2023 08:39:38 -0800
Message-Id: <20231117163939.2468007-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231117163939.2468007-1-kan.liang@linux.intel.com>
References: <20231117163939.2468007-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The free-running counters for IIO uncore blocks on Granite Rapids are
similar to Sapphire Rapids. The key difference is the offset of the
registers. The number of the IIO uncore blocks can also be retrieved
from the discovery table.
 
Tested-by: Ammy Yi <ammy.yi@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Add Tested-by tag

 arch/x86/events/intel/uncore_snbep.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index ab31cda797df..aeaa8efe3c62 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6648,11 +6648,21 @@ static struct intel_uncore_type *gnr_uncores[UNCORE_GNR_NUM_UNCORE_TYPES] = {
 	NULL,
 };
 
+static struct freerunning_counters gnr_iio_freerunning[] = {
+	[SPR_IIO_MSR_IOCLK]	= { 0x290e, 0x01, 0x10, 1, 48 },
+	[SPR_IIO_MSR_BW_IN]	= { 0x360e, 0x10, 0x80, 8, 48 },
+	[SPR_IIO_MSR_BW_OUT]	= { 0x2e0e, 0x10, 0x80, 8, 48 },
+};
+
 void gnr_uncore_cpu_init(void)
 {
-	uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR, 0, NULL,
+	uncore_msr_uncores = uncore_get_uncores(UNCORE_ACCESS_MSR,
+						UNCORE_SPR_MSR_EXTRA_UNCORES,
+						spr_msr_uncores,
 						UNCORE_GNR_NUM_UNCORE_TYPES,
 						gnr_uncores);
+	spr_uncore_iio_free_running.num_boxes = uncore_type_max_boxes(uncore_msr_uncores, UNCORE_SPR_IIO);
+	spr_uncore_iio_free_running.freerunning = gnr_iio_freerunning;
 }
 
 int gnr_uncore_pci_init(void)
-- 
2.35.1

