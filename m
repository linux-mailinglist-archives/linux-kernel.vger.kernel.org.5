Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52CA7B5668
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbjJBPDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbjJBPDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:03:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92376B7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696259003; x=1727795003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nx7GNempp8UMyeQf3iZp0vdzB5eXlrq5zLmg/MI/cX8=;
  b=QBIQCiwQCo4cEd7CA6oybkbzbzBY0eBZRB8s2Br2WCIgGos/c5O8vqa1
   pRj8exudUBDyUt6oPp0AP3lxqydDw9yg+g3mW3YUjKYBfC5cuJI7GowQy
   Ls0OYcClXnNlT8s3zo8WParQbKylVs3x2TtryIZhHim2IIRi6H93yXfad
   OlupFd66z60boK5STce6pKxznILAjvaLXy53UTYpi7O5e/4BKIONZiku2
   IKabC6dyyEIXN1dRuD2bGPG/nk/3q0QhxMmQhmJB5/6miNFDsOudrQzK5
   +Wux3dWB9879L3ZWM1eCUYbd2xbzGPNpzCbO++GCNu2w9/v8QV6jiz8AJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="362033052"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="362033052"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 08:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="820904664"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="820904664"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga004.fm.intel.com with ESMTP; 02 Oct 2023 08:03:19 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 4/5] perf/x86/intel/uncore: Support IIO free-running counters on GNR
Date:   Mon,  2 Oct 2023 08:03:24 -0700
Message-Id: <20231002150325.2025749-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231002150325.2025749-1-kan.liang@linux.intel.com>
References: <20231002150325.2025749-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index e2ce97d73a31..60334026141a 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -6632,11 +6632,21 @@ static struct intel_uncore_type *gnr_uncores[UNCORE_GNR_NUM_UNCORE_TYPES] = {
 	&gnr_uncore_mdf_sbo,
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

