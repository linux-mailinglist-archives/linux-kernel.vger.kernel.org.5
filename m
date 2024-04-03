Return-Path: <linux-kernel+bounces-129607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D825E896D22
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0111F31C4A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7612D146D4A;
	Wed,  3 Apr 2024 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C82RtkyC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CC31465B5
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712141322; cv=none; b=cQ6GDXLKIV5m9JZRnSA5zjZpIGeJD9mXbH+ASHRPVQeTcdDUKYw53BeyeW+Mm6Za8apj3tIVF+3G5vPbkbrA+it38RKrpokWFq+u63ALvIX0hq5URHQVmqFHdsCenr+grNWEcaEao4Imtt2O12Z4jcwgoyaKjp7ftY1qlaLG2aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712141322; c=relaxed/simple;
	bh=qjXLbtPJOtzcFmiEigBlQuXlreS7DVmZQkZxpCejSHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbnt/udkY6Lbs8lQiL/SM5EpnEtextB5Y3jvjjMiKlLXy/NDh/axE5V+ZHDBt3k7siB18uWT0Heqzt0VcozAL4maqg5a9dhlnYIScCRbxcHZKwII/N3bL0p7YuVCPW1C67GhOzCkmcpuWdhIBVlVTC11Jf23/NgmJTUQI/XJ3JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C82RtkyC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712141321; x=1743677321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qjXLbtPJOtzcFmiEigBlQuXlreS7DVmZQkZxpCejSHc=;
  b=C82RtkyCRveP99yXI8LG5avSjCjAxXTPF+88ooYDrhqahqlWF/p/VMD2
   iElwz5sty7J8Z5KcOZv9nf9Gi1eTcTZMykkbcC9tWMLCQHls1OuB401nx
   R8d4NMdnTHm91SLRbp7UHva7wLchbOoWhIzCkRqf4JcdoUvpdhLShTPBj
   gSYLqZoSq2STs6dRlYQw2cukRkmRu/EWnDrvVy5oAUcAornJTMJheGwCK
   P1tRbxAuITdukPDwqPvsLNIu6WZ6aO54ZASmxd/Hg55dgCdZdOyv917OS
   3nZb7h1g0HnbVpVYfV2aJcFBQ7zXfaVkegU9b8d+Ke0YgVQa2gKTdKKXU
   A==;
X-CSE-ConnectionGUID: uVHAjFM4TueN+/Y8bnjKzw==
X-CSE-MsgGUID: 9Vfs6IAlQ7m0XKT92gWDUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="10333448"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="10333448"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 03:48:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="937084885"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="937084885"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2024 03:48:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 418063E5; Wed,  3 Apr 2024 13:48:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 2/2] devres: Don't use "proxy" headers
Date: Wed,  3 Apr 2024 13:46:57 +0300
Message-ID: <20240403104820.557487-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240403104820.557487-1-andriy.shevchenko@linux.intel.com>
References: <20240403104820.557487-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/devres.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/devres.c b/lib/devres.c
index 27f280a39dca..4fc152de6d8b 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/bug.h>
 #include <linux/device.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/gfp.h>
+#include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/gfp_types.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
 #include <linux/of_address.h>
+#include <linux/types.h>
 
 enum devm_ioremap_type {
 	DEVM_IOREMAP = 0,
-- 
2.43.0.rc1.1.gbec44491f096


