Return-Path: <linux-kernel+bounces-155386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F468AE9AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1DD289585
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B7D7F499;
	Tue, 23 Apr 2024 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NsfKqWoP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3973313BAC3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713883077; cv=none; b=JHKDpRc/9dhKwsVNBx4ZxHrrKjRm+UcILDXR/scoJ3RzJlIj/PVsRpL+PWR8Zpi82diOb8DWg7btzux1sGZ0RBjBdVu80Fgl30alLGMyVvlSqUSiOf+a2ajRMb6kh3DKCFxj5GP5If8zwAYxPO89TSvJZXzqvgbQbpjTZKhWezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713883077; c=relaxed/simple;
	bh=djonfho/R/jyeCS8Y9idO2dg/3sauTPDxmqFop0x9d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UMMEKniyO99z+0MteZLH0E72Z1uqRMU2/uWUih2Sr9UcQVHAPKgOq0t9j8pRs/wa9iPf8D7c+SCLQL4vROxKPbtKwYHjzKqaeYvHlw9hQiSo18vf5uwccNqzLB03mDaWKAepxGtJdHi2BxVXIUBqXCBBESY0ARDA2fet26MK3G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NsfKqWoP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713883076; x=1745419076;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=djonfho/R/jyeCS8Y9idO2dg/3sauTPDxmqFop0x9d0=;
  b=NsfKqWoPLVxUUe7oa8/d5aXWTxwI/tA2iGNTqckc6R/z/DEM3uCwrZwM
   Nl5S7C/fWnIw3hHSCdL+lVerNKdPafq53q9X7RDEBQQfMbOMZx3hd9gWZ
   2WjURXUvJAPZpgB2+J6iuuCHyQJDVcD65Rnkvwfssjf1dWQttwgQXhErq
   USW5pfk4A/VrUR0OA0YggA585fDD8ko2yZDUdXNnY3sgikJV/1CG7gJyh
   MhtG0eY6/rAsCI3WmPaOamULFNEXf9W7vDsqodj8kRVh4LLkbmkdZluPD
   syNutmU7gQWRPClTmET6aGvunO6n7euPT4RLD69ozjuMSZTuyDL1KH7RX
   w==;
X-CSE-ConnectionGUID: k1ocTXG9TUSL/73SuNRR1w==
X-CSE-MsgGUID: xaKGnx4PSJiny3vJliScOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="9689343"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9689343"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 07:37:56 -0700
X-CSE-ConnectionGUID: Eel+Iw+tTjqCQrXcwsZB5A==
X-CSE-MsgGUID: O2lJ0iAYTveU/wyW7as1xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24425144"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa007.fm.intel.com with ESMTP; 23 Apr 2024 07:37:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EDA1244E; Tue, 23 Apr 2024 17:37:52 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Stefani Seibold <stefani@seibold.net>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] kfifo: Don't use "proxy" headers
Date: Tue, 23 Apr 2024 17:37:50 +0300
Message-ID: <20240423143750.2480181-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
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
 include/linux/kfifo.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/kfifo.h b/include/linux/kfifo.h
index d613748de7ff..564868bdce89 100644
--- a/include/linux/kfifo.h
+++ b/include/linux/kfifo.h
@@ -36,11 +36,16 @@
  * to lock the reader.
  */
 
+#include <linux/array_size.h>
 #include <linux/dma-mapping.h>
-#include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
-#include <linux/scatterlist.h>
+#include <linux/types.h>
+
+#include <asm/barrier.h>
+#include <asm/errno.h>
+
+struct scatterlist;
 
 struct __kfifo {
 	unsigned int	in;
-- 
2.43.0.rc1.1336.g36b5255a03ac


