Return-Path: <linux-kernel+bounces-58564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2190A84E821
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8BC31F2DCFF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43D636135;
	Thu,  8 Feb 2024 18:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FqlpNeW+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9CB25601;
	Thu,  8 Feb 2024 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418171; cv=none; b=Tr4XC4ayyRsooRnXg0RQf0uRA4OO/RjE9o/jtFDsy+BsKLZFW9gc2GWb7PmWj/iJsJRPpqPHkGbwB4h5dOoTjE8rHzW/wfBSJgyaS2iouCeDeceQrgpjPIzqBFmmFQ7OkmsNRDwH/pmw15nS/CKD1tWEcLFGGy2RC0EmRVLTt68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418171; c=relaxed/simple;
	bh=FC1cjzT0133HljBbHlbObVyjHCu4QTG/1Zt/QXNpVSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oii71mtQF7otWjCl095G9BOgsNd+1q0LVWTrEpweatq+gS1ZZV3rKAU2afAGzSDgPWiqU53sKWHIIs3hHYeunbFxJU6pwRaAv8khDIwX/i7kBY9sPXRvTt7AzOWPk2jkCK1uejl5NUk8L704iA8mY4ie8urJORYlLrJQA6wSMSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FqlpNeW+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707418169; x=1738954169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FC1cjzT0133HljBbHlbObVyjHCu4QTG/1Zt/QXNpVSA=;
  b=FqlpNeW+lbDvHeHIE022F/CyRT2UJymtasBjmTiV9RexkxAsXSUrATip
   ClDAAIX3IApnW+lSoszuXKLNaxBRinehiVkr3yEXw+Hjvf9Z4YU8EQnxB
   dD5NnQXzzyd/dbfRTTLg4SKOBKoH1E5NKoOICpxWGkCYVkPcFAdRc67yo
   wHT5ZUcKYMxgXJVKN8N+0j0IdBrUfW5HKFeBba3P+X1coxKFLLarq2hQh
   8xAl+ZIXtZ5a8viPOt/ASiu2myqIVuZxoiTXIfzlL40XcHtuhg6ukfAuX
   T/CqAzSA/Xm9hU/9lqLY3WfNjQmkIbCrHuL/cJ5pu0mIdx2YPU64GGcrl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1186112"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1186112"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:49:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="934215530"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="934215530"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 10:49:25 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5E3254C4; Thu,  8 Feb 2024 20:49:21 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin van der Gracht <robin@protonic.nl>,
	Paul Burton <paulburton@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v1 05/15] auxdisplay: linedisp: Add missing header(s)
Date: Thu,  8 Feb 2024 20:48:03 +0200
Message-ID: <20240208184919.2224986-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
References: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not imply that some of the generic headers may be always included.
Instead, include explicitly what we are direct user of.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/line-display.c | 3 +++
 drivers/auxdisplay/line-display.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index 4b92ae7781f1..6b3d25e20eeb 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -10,8 +10,11 @@
 
 #include <generated/utsrelease.h>
 
+#include <linux/container_of.h>
 #include <linux/device.h>
+#include <linux/export.h>
 #include <linux/idr.h>
+#include <linux/jiffies.h>
 #include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/slab.h>
diff --git a/drivers/auxdisplay/line-display.h b/drivers/auxdisplay/line-display.h
index 1fbe57fdc4cb..d72c1899dc50 100644
--- a/drivers/auxdisplay/line-display.h
+++ b/drivers/auxdisplay/line-display.h
@@ -11,6 +11,9 @@
 #ifndef _LINEDISP_H
 #define _LINEDISP_H
 
+#include <linux/device.h>
+#include <linux/timer_types.h>
+
 /**
  * struct linedisp - character line display private data structure
  * @dev: the line display device
-- 
2.43.0.rc1.1.gbec44491f096


