Return-Path: <linux-kernel+bounces-167984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DB68BB1E2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F1B1C210AE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77393157E9F;
	Fri,  3 May 2024 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IL6+94tW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0369C1581E9
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714757929; cv=none; b=gsVeqHkfwwBovOmNYrL/fle2iiBPkszYAaShoVaGoA5bvPZk3UnKUsM/UPv/7YIFDBwdi0favL/D/S194BwKKQIlGUYR8WUj8iqLJ67d/ZXN1HUrC8AbdSiE6sT65356uumVn6PZPkRHn2Vceqso+xO/vl4mojY1014V7SnsXG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714757929; c=relaxed/simple;
	bh=gPrgo34ybBQa+GxToo9au4/nRMI7PXHJBnnD7sVtc0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X0GFbZru8GwbxoYW43GsT9dICjzqE2ChFw3YcTL5KkAAbDAf5AvGbSYPBYyS/K/Kxn54EQsBPUZs0A70LoMftbfpAoUNNJQZgL7BFENS0/P8iklbRnCNhPnMwq0ulfDBO+zu/TQloXvUq7XGQJtQI1BFAgbq1L7rzOEuynEUS2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IL6+94tW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714757928; x=1746293928;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gPrgo34ybBQa+GxToo9au4/nRMI7PXHJBnnD7sVtc0U=;
  b=IL6+94tWDtyd/YZFW9qW+kTA92yiNGb0+kjEY8aLaPWbsqBbkxDiZ4oZ
   lTPY42gn9+vTDfwocZ5EaggOxj8c7WhkUVQ67bJWn1E4GTrAe3k6J6h3Q
   wcy7ji5KvgOH/vBMvKcvtNnWys8AymHyBVo5B68+w8p2nBctayboqdlYF
   wRrpJ0e5j4J+VViLBypJK+2NHEx7PzdVUtjexOJI719CbbGwQy20FXpMG
   ogOnmxQ3xgTDpOoA508Hk0euPFLvkslPavc5+ifJSYK+UTX3/8uUBf727
   PCaxlLbLpXPTVQJzgLfpbcaE8j/xr2KqKypceON+uG16mB3SMsXZW6ZJe
   Q==;
X-CSE-ConnectionGUID: xRMT+JuwTs2A+Zbl3rbPsA==
X-CSE-MsgGUID: mevDLCqqQM22leUWMynfag==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="28104610"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="28104610"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 10:38:47 -0700
X-CSE-ConnectionGUID: 66yvJIZBRBKljdW/ZttY0g==
X-CSE-MsgGUID: eGiHjXmEQWuCCTbAN7Y5sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27488639"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 03 May 2024 10:38:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3883019E; Fri,  3 May 2024 20:38:45 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: [PATCH v1 1/1] devm-helpers: Fix a misspelled cancellation in the comments
Date: Fri,  3 May 2024 20:38:43 +0300
Message-ID: <20240503173843.2922111-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a misspelled cancellation in the comments.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/devm-helpers.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/devm-helpers.h b/include/linux/devm-helpers.h
index 74891802200d..708ca9131402 100644
--- a/include/linux/devm-helpers.h
+++ b/include/linux/devm-helpers.h
@@ -41,7 +41,7 @@ static inline void devm_delayed_work_drop(void *res)
  * detached. A few drivers need delayed work which must be cancelled before
  * driver is detached to avoid accessing removed resources.
  * devm_delayed_work_autocancel() can be used to omit the explicit
- * cancelleation when driver is detached.
+ * cancellation when driver is detached.
  */
 static inline int devm_delayed_work_autocancel(struct device *dev,
 					       struct delayed_work *w,
@@ -66,7 +66,7 @@ static inline void devm_work_drop(void *res)
  * A few drivers need to queue work which must be cancelled before driver
  * is detached to avoid accessing removed resources.
  * devm_work_autocancel() can be used to omit the explicit
- * cancelleation when driver is detached.
+ * cancellation when driver is detached.
  */
 static inline int devm_work_autocancel(struct device *dev,
 				       struct work_struct *w,
-- 
2.43.0.rc1.1336.g36b5255a03ac


