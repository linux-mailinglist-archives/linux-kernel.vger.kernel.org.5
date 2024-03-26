Return-Path: <linux-kernel+bounces-118652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7FA88BDD0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3ED8B24892
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46387128817;
	Tue, 26 Mar 2024 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QjVknL2b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE2B524BA;
	Tue, 26 Mar 2024 09:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444842; cv=none; b=TqL+/5Ic5yuxbzuHjAOoYyao0CMxWUyVu/trst+RH6m0nyzkZ2mQBVdPqqdyPPsZUrebTftdIzJXPdzNmiOB+z23/9hcWEnBQguT/o1aR8LkaN9clYXJNJKvFrMrjFQKKYVm7D08AuF/Lm3jiKm/4WUGa5OFC/4ylXcW9ITPzZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444842; c=relaxed/simple;
	bh=IMs8UHVx4/A40f0KUrXcDBw0aT02Q0zAJAjjhOWtVWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sa9aScXVyWRAp7htJYuJ1XMmIVWjTmq3fQIbWRAB9UzGaCAGXOCIr1g3WBb08VSLinVYolGUNAJRefEIEaDl23YFPzCS61VNPE99gHzBg1j3aNQBZzpXtj3zLBf/P5BoIRWDrdyN24XoakPWVi56kQ/0Henq8m5qEd0omi0HLh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QjVknL2b; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711444841; x=1742980841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IMs8UHVx4/A40f0KUrXcDBw0aT02Q0zAJAjjhOWtVWA=;
  b=QjVknL2bLx4RAwj1+i08/lLqCTeFHCCh9IUQlaArDtJFhxRRb8pjmhfW
   TyhHCZBJjfr+AN9ZPs0obg10cqqZifhBR07ossGfhDvDxzNXEMMKNGGTj
   dMncuspSBZlH8ZbjP/3e+8uRjrW/MjvRxvgdz2MnKZXhUOnzGTZ1ACPil
   DVFUZXXFo1z2WSsDxCrdWMaRCQQW12PAnS5IoyQk7K73x92tSluxfoHtl
   qdKBnHAJSxFFs74SuWbFMIsw/ExfmFoZrWz8XRG+iEYdSKW2yS/9Vw9dI
   JuBCrPILoNwmgSOLoxjniNv8D3VLOjtGYsxRTMyqKuoE/JJ7nQFnyM+Yw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6350343"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6350343"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:20:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="16293266"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:20:36 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 3/7] soundwire: intel: add more values for SYNCPRD
Date: Tue, 26 Mar 2024 09:20:26 +0000
Message-Id: <20240326092030.1062802-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326092030.1062802-1-yung-chuan.liao@linux.intel.com>
References: <20240326092030.1062802-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Starting with MeteorLake, the input to the SoundWire IP can be 24.576
MHz (aka Audio Cardinal Clock) or 96 MHz (Audio PLL).

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw_intel.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 00bb22d96ae5..fa40b85d5019 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -34,8 +34,10 @@
 /* SYNC */
 #define SDW_SHIM_SYNC			0xC
 
-#define SDW_SHIM_SYNC_SYNCPRD_VAL_24	(24000 / SDW_CADENCE_GSYNC_KHZ - 1)
-#define SDW_SHIM_SYNC_SYNCPRD_VAL_38_4	(38400 / SDW_CADENCE_GSYNC_KHZ - 1)
+#define SDW_SHIM_SYNC_SYNCPRD_VAL_24		(24000 / SDW_CADENCE_GSYNC_KHZ - 1)
+#define SDW_SHIM_SYNC_SYNCPRD_VAL_24_576	(24576 / SDW_CADENCE_GSYNC_KHZ - 1)
+#define SDW_SHIM_SYNC_SYNCPRD_VAL_38_4		(38400 / SDW_CADENCE_GSYNC_KHZ - 1)
+#define SDW_SHIM_SYNC_SYNCPRD_VAL_96		(96000 / SDW_CADENCE_GSYNC_KHZ - 1)
 #define SDW_SHIM_SYNC_SYNCPRD		GENMASK(14, 0)
 #define SDW_SHIM_SYNC_SYNCCPU		BIT(15)
 #define SDW_SHIM_SYNC_CMDSYNC_MASK	GENMASK(19, 16)
-- 
2.34.1


