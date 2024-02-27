Return-Path: <linux-kernel+bounces-83788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 523E4869E73
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D963D280E29
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BF04F215;
	Tue, 27 Feb 2024 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lchqZh/X"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206654EB44
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056761; cv=none; b=L8FlJScEWpf02mjEtkAZTbYu46CFHgkZuD/iyJw/XLprYklA9FUkyuOPxmg8xvYXk1znWAfhqSbNlpoDlEvwP3dHuuNWT0viJRCMk/jCg1l37hSO5hqAgCyU47rRI0qm6w2RAihpJx6FnZkQzURyse08fRZYnoT5bWlrFBSz/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056761; c=relaxed/simple;
	bh=qjXLbtPJOtzcFmiEigBlQuXlreS7DVmZQkZxpCejSHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQlqly7BOOSwWH/Y+zBXfJRiA41xL3RTkbeMyQTNftfUzpIooX32n3KsNmfnr/LQGiF47GnO294HfYVz9dIkXclkRk8IGMFU/5KnzR/qTZOuVi2CV1B8zW08s04bpPgEC2bgSY6KD6benzkoxfFLlTl0Oi1qz74u1uohFSzKAk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lchqZh/X; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709056760; x=1740592760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qjXLbtPJOtzcFmiEigBlQuXlreS7DVmZQkZxpCejSHc=;
  b=lchqZh/XcwyLEBax6pc21CyH//qaBlTdVIuAzw5FIozdrH+AYiBXQT5P
   rflwKoz9v8QKqkTg4NG1Tdau/M0k3M2Cpcbc+b0FzAv83gh3JlhGWSIKn
   u/j8COZW0lZLxefejEpvds2iyRdFGjGYNCBIyZ2OQm/gZ0jcfVgwcgp8g
   yOocMVFBKKuschBWnfg4ArEJeABVHOEy9np3fMl8zQIIXO9FEYEWCXfDm
   sPiu/KEaJ/nrCADyYJpCtZfVB8ZKgRXxVmu1ZyS5Xv+6oAvNtQmG8IaXQ
   JnPI49rfhgGvbruEo4ln3mbZiOe66Y793H/4eVX6Zm/ikYRJ6OLEpePQe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20962772"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="20962772"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 09:59:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="937032678"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="937032678"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2024 09:59:17 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 17151426; Tue, 27 Feb 2024 19:59:16 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v1 2/2] devres: Don't use "proxy" headers
Date: Tue, 27 Feb 2024 19:58:35 +0200
Message-ID: <20240227175910.3031342-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240227175910.3031342-1-andriy.shevchenko@linux.intel.com>
References: <20240227175910.3031342-1-andriy.shevchenko@linux.intel.com>
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


