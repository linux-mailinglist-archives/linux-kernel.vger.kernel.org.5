Return-Path: <linux-kernel+bounces-75910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F80385F08D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD3F284AC9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EE81C16;
	Thu, 22 Feb 2024 04:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YsffpbUn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB361FA2;
	Thu, 22 Feb 2024 04:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708577553; cv=none; b=gC1TLVfHhsqvbvl4xuAIK914aVDqWuOaCR/2v2e9noQoQnBCbUyiC230Ti2/MVd+TXpfDn23kFY5r2Z96TbkHgAkXydzvbSkb8F4HlaepSnsS4QjmM1DSsOwaqQJZL6La6By98m8cuINO24IvjOd5s9EnP8SLpvW2RK/diVRqxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708577553; c=relaxed/simple;
	bh=pQDavo0/qfgT4mK+oZdue8z5IvBKGB8rgGt+xY5dgJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GEBT4TWLxm2a90Plmh8PULgxSSRTinlpPtpKnoz6VJC6kqN4oj5S67To+ZsDUwQe/R9XhvQyGPvC0ifUK4U6gdpQrb0KsRstW2ESLHeBTv8N5fO8cjrJZzpxMuFm1kwVIEn7T/H62fS8HaEQ4hm4ywaAtiYUlqnbnsW204M8nQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YsffpbUn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708577551; x=1740113551;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=pQDavo0/qfgT4mK+oZdue8z5IvBKGB8rgGt+xY5dgJE=;
  b=YsffpbUnQBfBRli1ZaYLIIDtnIJXGyGC9H9L8kkOmdKlnW8pTPseGceU
   kkKlIaEg/FHiMFubDDG4OdBQSUIpqqfQggpPOfnKdUFHdqlaDDKOAE8ku
   xiGS8J3+bhQ0NdXHl2oWgtJrYThb1ppnQvOq/AHXqj7N6M0Cc+STI76wn
   VS4YdjQ7l0LFQJWQXHHjinqqWJ6/+tWDPozcQ6q/GznZzVUhD39vvINZ7
   XGIkAz4qgZMpw0OmEte6YnqUxYKQmmE30FxWPGW+EWf/1P5uY6ccJKO4w
   EzIQaeurM9E0ERhCfFfZ0kaCg6kPzyh0MPkantum/gzVX9OX4IJWmvPmk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13478886"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="13478886"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 20:52:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="9959521"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.97.198])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 20:52:30 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Wed, 21 Feb 2024 20:52:28 -0800
Subject: [PATCH] cxl/trace: Fix uncorrectable macro spelling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-fix-correctable-macro-v1-1-6e6ab8b8aa39@intel.com>
X-B4-Tracking: v=1; b=H4sIAAvT1mUC/x2M0QrCMAwAf6XkeYE2DrT+iuyhi1ED2ko6hlD67
 5Y9HtxdgyqmUuHqGpjsWrXkAWFywK+Un4J6HwzkafbBEz70h1zMhLe0vgU/ia0gXeYzSzwRR4b
 Rfk2GeHxvS+9/QTz9SGcAAAA=
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708577550; l=1906;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=pQDavo0/qfgT4mK+oZdue8z5IvBKGB8rgGt+xY5dgJE=;
 b=MGaIpc+mfRs0nTItBluY7d341NQ21ww/sWFGQ3Q2KymOKHb6P0FDkkaV8BdslePQi+XwcVjYN
 46izd2PCEbODDV/P2E2oMJ2qtW/7zHviAI0rvijtYQR/CCt9APCHw+D
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

Uncorrectable is spelled with two r's.

Fix the macro spelling.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/core/trace.h     | 4 ++--
 tools/testing/cxl/test/mem.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index bdf117a33744..577a01954f71 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -267,11 +267,11 @@ TRACE_EVENT(cxl_generic_event,
  * General Media Event Record - GMER
  * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
  */
-#define CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT		BIT(0)
+#define CXL_GMER_EVT_DESC_UNCORRECTABLE_EVENT		BIT(0)
 #define CXL_GMER_EVT_DESC_THRESHOLD_EVENT		BIT(1)
 #define CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW		BIT(2)
 #define show_event_desc_flags(flags)	__print_flags(flags, "|",		   \
-	{ CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,		"UNCORRECTABLE_EVENT"	}, \
+	{ CXL_GMER_EVT_DESC_UNCORRECTABLE_EVENT,	"UNCORRECTABLE_EVENT"	}, \
 	{ CXL_GMER_EVT_DESC_THRESHOLD_EVENT,		"THRESHOLD_EVENT"	}, \
 	{ CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW,	"POISON_LIST_OVERFLOW"	}  \
 )
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 35ee41e435ab..c0c1e6b4db75 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -380,7 +380,7 @@ struct cxl_test_gen_media gen_media = {
 			.related_handle = cpu_to_le16(0),
 		},
 		.phys_addr = cpu_to_le64(0x2000),
-		.descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
+		.descriptor = CXL_GMER_EVT_DESC_UNCORRECTABLE_EVENT,
 		.type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
 		.transaction_type = CXL_GMER_TRANS_HOST_WRITE,
 		/* .validity_flags = <set below> */

---
base-commit: a2cd3520e6085b0f9145d9c5e3d1bfa9cce4c3be
change-id: 20240102-fix-correctable-macro-2847ce932c9c

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


