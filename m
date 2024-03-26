Return-Path: <linux-kernel+bounces-118603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8B788BD24
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E191F3CC2A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15A066B50;
	Tue, 26 Mar 2024 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jlWm+p6m"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D51B5675F;
	Tue, 26 Mar 2024 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443695; cv=none; b=GoHlw1gZqn5wEigdgvZ5ILeUSkew/xuiUV4I6s8BpdR1Mhh7vdGNpok+uw4H/X6BTVY2ksiwMoxyciYd5zkddegoude+jXax07aiLhKZz/c21uo3uD9X3k1bqg4GHceE5tCFZDGgIHnB0RABhXHVEexEXybI6nkSccvAkoDOgcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443695; c=relaxed/simple;
	bh=0ViGQ0x4cfpTSNNXyftIofu25iFpyc+bDlW5a9KUFgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DZd7Z1tAbYMkdkS/2eMDg0f+4AIsqv0szNFfc4yDPampjnjLCg0BNGvCzWagaGZPuM0RCw/CjCQ4o12NCIE75X+X7Wsbah6iY0NzKzfTZ4aNamPUXqrQGDWbocmtRVjjvGm4dc+u25IyGyJfETHr6XSOZtL8LYeOsXireeg2Itw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jlWm+p6m; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711443693; x=1742979693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0ViGQ0x4cfpTSNNXyftIofu25iFpyc+bDlW5a9KUFgE=;
  b=jlWm+p6mxIGstpR3W9eSgI1E30cEPbuid1KhwzqUX1gx2u8KAumyIN4T
   OrV0kFFnlIRftz3I1yYlqeF0Z3n6UPB6vyk+XFehFrPJ5SmZWV0/zQ87H
   aAFoeKtgS3YTQEyUihFJG4GlEd10gTpbfUEb51dM68VEOiWcsGRGWKrfF
   9RrE/mLI6CwR/1+JD3ti1nbLYLRYo3sDnmsbHRXu3YbHUpyrTGU1rwAdn
   2+rHGmloHq6SEtBkqpsRKrjMTi5UPAgLUUDV+aTeSbxiPYHymkCOT5Bei
   4FOIrFdOrS28ck+5P2EJrxLDkg/90DV+FRn+fk+AL+uqDR0ddZSGVHKHw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6343353"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="6343353"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; 
   d="scan'208";a="20614512"
Received: from yungchua-ws.ostc.intel.com (HELO yungchua-ws.intel.com) ([10.54.69.90])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 02:01:28 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 3/7] soundwire: remove unused sdw_bus_conf structure
Date: Tue, 26 Mar 2024 09:01:18 +0000
Message-Id: <20240326090122.1051806-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326090122.1051806-1-yung-chuan.liao@linux.intel.com>
References: <20240326090122.1051806-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

This is redundant with sdw_bus_params, and was never used.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 66f814b63a43..e5d0aa58e7f6 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -542,21 +542,6 @@ enum sdw_reg_bank {
 	SDW_BANK1,
 };
 
-/**
- * struct sdw_bus_conf: Bus configuration
- *
- * @clk_freq: Clock frequency, in Hz
- * @num_rows: Number of rows in frame
- * @num_cols: Number of columns in frame
- * @bank: Next register bank
- */
-struct sdw_bus_conf {
-	unsigned int clk_freq;
-	unsigned int num_rows;
-	unsigned int num_cols;
-	unsigned int bank;
-};
-
 /**
  * struct sdw_prepare_ch: Prepare/De-prepare Data Port channel
  *
-- 
2.34.1


