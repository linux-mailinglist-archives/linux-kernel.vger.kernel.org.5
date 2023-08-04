Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAACD7706A1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjHDREc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjHDREa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:04:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A54C4C0C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691168660; x=1722704660;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r5vvWnhAKMNRDesD6dMnGnajRQ3f1kuJ6oQW1WRN+NE=;
  b=Z43Cs7mvsttM04SgdrDIthFuV/ja928qiTydXTTh6MmNDZJo7YUQiLyr
   KNQhNVBbCr+ae1Y2TyDa9YVku/zAEvAjNpMu85Yw5mEKsyWG7eEgIpxV2
   d/Gd5iOH9pZz0dsOSj6tp/I4oH0+MJVF/ua9S+HKVT8UjnTrHM1D2PIm9
   64c8UYRxLs25vL7mGsUjgMYvpcjqFCa0qZwK/iVTchaRujpWK2MkBVp7a
   apIHQ6wukAp/mFJHxETyXVC3Hu541Ab2wOFJfq3CwJtbIxOLEnu2Cx+fD
   Dfe4wZY4m7RL4e9EmbCiTYxpwi/I7Q69P5EXpPOn9nSRZnXRRXY/Cu0Dk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="373850164"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="373850164"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 10:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="795481508"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="795481508"
Received: from jfdev013vml03.jf.intel.com ([10.165.161.32])
  by fmsmga008.fm.intel.com with ESMTP; 04 Aug 2023 10:04:00 -0700
From:   alexander.antonov@linux.intel.com
To:     peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     colin.i.king@gmail.com, alexander.antonov@linux.intel.com
Subject: [PATCH] perf/x86/intel/uncore: Fix uninitialized variable in skx_upi_topology_cb()
Date:   Fri,  4 Aug 2023 10:03:54 -0700
Message-Id: <20230804170354.3560038-1-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Antonov <alexander.antonov@linux.intel.com>

Fix a potential return of an uninitialized 'ret' variable in
skx_upi_topology_cb() function.

Fixes: c1c1942b49ea ("perf/x86/intel/uncore: Enable UPI topology discovery for Skylake Server")
Reported-by: Colin King <colin.i.king@gmail.com>
Closes: https://lore.kernel.org/lkml/21e2ea66-9524-8e34-a2f0-8e16b9617d68@gmail.com/
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index d49e90dc04a4..d857fc00511b 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4330,7 +4330,7 @@ static int upi_fill_topology(struct pci_dev *dev, struct intel_uncore_topology *
 static int skx_upi_topology_cb(struct intel_uncore_type *type, int segment,
 				int die, u64 cpu_bus_msr)
 {
-	int idx, ret;
+	int idx, ret = -ENODEV;
 	struct intel_uncore_topology *upi;
 	unsigned int devfn;
 	struct pci_dev *dev = NULL;

base-commit: c1a515d3c0270628df8ae5f5118ba859b85464a2
-- 
2.25.1

