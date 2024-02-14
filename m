Return-Path: <linux-kernel+bounces-66007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB9E855527
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E421F2BEF4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92438141983;
	Wed, 14 Feb 2024 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gw98g07M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA17612EB
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707947252; cv=none; b=D2gvaoUmtVC6+dEWqG+8D81TTbBC+lFwV8D9+GwaN3ccZ3bcZY+3G1SJ3ITuZmLLWwHs7UP13coT8qaNJBMTxeF/qj4cDbAweUkdeANXWEK7Fg/w+JVjDjz9JrszqNEDywejr1hH2SRDQIAVRIBzxtbM9D+b2FQfErbyODqGcSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707947252; c=relaxed/simple;
	bh=6XaV0/TrdVyOdwiVu+94yfFg+0tQa+h6v1Ux4vv2N3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aOUL7futdD2Jw+YQE8DzlArNNrFt55IsLIzAvEDUHz7VQiW3Ekb8Vfcz8zjtwKGNpun9FX3+KlfVdWVOg9IK9qSLFy5BX8U0rcKDnJaPGB/MTYCOtOnDQoIdsNEG84X3u+vP3LjYxjkFUyNGLfP6+twtcxI3kmwdAalI8Ep+x5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gw98g07M; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707947251; x=1739483251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6XaV0/TrdVyOdwiVu+94yfFg+0tQa+h6v1Ux4vv2N3w=;
  b=Gw98g07MPycTgnYDkympml7BZlgAGj2DEj7Q53oT+okd+ZCtct6S21/E
   48DbOpMlS/89z31qIg90bunp9ayoJt6WNTHllZuXOOX9knv/cs7NKLM2v
   zgTi2yLcdifmRBN1dH7bWMsATXLmrFcrh540Ca66PpYkVzP1MNTpfCq0U
   HpzN+wvTRPB2Uqbfy5iBG/h7/JKXBn2l/WAbc8o+sJGU/HYVUhQazDd4E
   993SETIVp5SVOQgnCMQBX3IW5xcMvyphG0yph03j2pnYSI0OCN8kBMfSU
   TkrRbhV19IYrod4QvyunkItqQHHFUlfieLcZmJw6HBpLf4nn04ACNoIT2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1895080"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="1895080"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 13:47:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="7932111"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.249.138.241])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 13:47:29 -0800
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kernel@vger.kernel.org
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 2/2] drm/xe: Prefer make_u64_from_u32() over local macro
Date: Wed, 14 Feb 2024 22:46:54 +0100
Message-Id: <20240214214654.1700-2-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240214214654.1700-1-michal.wajdeczko@intel.com>
References: <20240214214654.1700-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stop using private make_u64() macro if there is a generic one.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
---
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/xe/xe_gt_pagefault.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_pagefault.c b/drivers/gpu/drm/xe/xe_gt_pagefault.c
index 59a70d2e0a7a..ac90eda39ceb 100644
--- a/drivers/gpu/drm/xe/xe_gt_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_gt_pagefault.c
@@ -7,6 +7,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/circ_buf.h>
+#include <linux/wordpart.h>
 
 #include <drm/drm_exec.h>
 #include <drm/drm_managed.h>
@@ -549,8 +550,6 @@ static int handle_acc(struct xe_gt *gt, struct acc *acc)
 	return ret;
 }
 
-#define make_u64(hi__, low__)  ((u64)(hi__) << 32 | (u64)(low__))
-
 #define ACC_MSG_LEN_DW        4
 
 static bool get_acc(struct acc_queue *acc_queue, struct acc *acc)
@@ -571,8 +570,8 @@ static bool get_acc(struct acc_queue *acc_queue, struct acc *acc)
 		acc->asid =  FIELD_GET(ACC_ASID, desc->dw1);
 		acc->vfid =  FIELD_GET(ACC_VFID, desc->dw2);
 		acc->access_type = FIELD_GET(ACC_TYPE, desc->dw0);
-		acc->va_range_base = make_u64(desc->dw3 & ACC_VIRTUAL_ADDR_RANGE_HI,
-					      desc->dw2 & ACC_VIRTUAL_ADDR_RANGE_LO);
+		acc->va_range_base = make_u64_from_u32(desc->dw3 & ACC_VIRTUAL_ADDR_RANGE_HI,
+						       desc->dw2 & ACC_VIRTUAL_ADDR_RANGE_LO);
 
 		acc_queue->head = (acc_queue->head + ACC_MSG_LEN_DW) %
 				  ACC_QUEUE_NUM_DW;
-- 
2.43.0


