Return-Path: <linux-kernel+bounces-88874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFEF86E7D8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B6D2850C0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC27182B9;
	Fri,  1 Mar 2024 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LpcrB3wv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04BB1170B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315807; cv=none; b=dknMGHslK8pOuXH2pZVJAgjm2X8ysovt5epM/nn+X7/q+s2JmPq/kxO5NaIHHSmrb3tTyGTqa5xZyLsqY6H9maSns9/FENCIFqd4tkXDF8qhHqUupO+HA9ukKaUMjW0GOZKllAaZHfp4h4nPz8HexthiKyYqB9ORtfSma3QVnJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315807; c=relaxed/simple;
	bh=h0960NSguWrPaEycEOjNIABQvoLMiDK9fkMLb1z/Dyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEA7/pA8CuiC5GD28p97pw6nqbAbgJUkGbp1LYpttpLBFgIzgb50GrKVRHwoUB2SK0yp96kFduDnO2ImiEYpHhl8RgC0gFH/eO4lq1n/YWF1l+Df/htItHEYs/1gTTmVBx0IoYNT9+5fyyA5aXGtDszRVqkThL3TSoK5v7s5Gnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LpcrB3wv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709315806; x=1740851806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h0960NSguWrPaEycEOjNIABQvoLMiDK9fkMLb1z/Dyw=;
  b=LpcrB3wvqAxuxA3D3HMdXhBLKlPO0+Ff++Sc/n4wfPmBcebbCaucAgXh
   J6+w3/aNTz3nj/3E8+tsbAkGX0o+05LC3HEpHVaEHzq0MIDhR69iiF/MR
   k0oqNCw6nd3f3qfbj0Yizje3zFpBBDQ3y9mCkO88D7n7AWF0TiaOpqNOg
   6irsj1mxvSpeRgo6Q34f69vtnAPwJDs0D99mtx6QKBBRCNEsyeMxzU/Bg
   o44K5Q2TNJN15mbdysNse4Sjxezi5UcKhQtiGYxgGwIXcF3/iCFa0Ghp7
   askLe3QEaHG3j9VT+4WGg4ndkFMMKAGL0ijdWkyLhztzAauM2imBvxH6U
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7684219"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="7684219"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 09:56:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="937037840"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="937037840"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2024 09:56:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E38075F5; Fri,  1 Mar 2024 19:56:42 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 2/2] devres: Don't use "proxy" headers
Date: Fri,  1 Mar 2024 19:55:37 +0200
Message-ID: <20240301175641.270020-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240301175641.270020-1-andriy.shevchenko@linux.intel.com>
References: <20240301175641.270020-1-andriy.shevchenko@linux.intel.com>
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
 lib/devres.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/devres.c b/lib/devres.c
index f38e8297ad5a..f4b72ad812b5 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -1,10 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/err.h>
-#include <linux/pci.h>
-#include <linux/io.h>
-#include <linux/gfp.h>
+#include <linux/bug.h>
+#include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/gfp_types.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
 #include <linux/of_address.h>
+#include <linux/types.h>
 
 enum devm_ioremap_type {
 	DEVM_IOREMAP = 0,
-- 
2.43.0.rc1.1.gbec44491f096


