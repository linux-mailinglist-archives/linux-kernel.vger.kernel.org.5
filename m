Return-Path: <linux-kernel+bounces-118282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E06AA88B73E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17CE91C30B41
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F8484D34;
	Tue, 26 Mar 2024 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UoMGkBH0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DAF524D8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419439; cv=none; b=uA6WZkFgQMiBk6SqKSb6vtzxN+4xbc6xaY2MBnfBwyH6YWqAUadUBTPB6gBCkgleTjs504Ffzg993ZSjYTRWrPyBUbMle4mhxK17pSY5jIRw6UUbJbIKbJu9/KImxRDDwwExE2qCSa+f7daZVi+3dCP/MCYiVvQhc+3l2iqAWsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419439; c=relaxed/simple;
	bh=naXFIdNU33tz38vUXdohRFxUFMIrzK3pZH6Hd6XFg2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q1w2wThnCnExK4gxAQqOQu4IE10br4wKfCy0F2uPXoxNDSxK+ATur/qwrUZyPa+Bn5StpA4et8VDDAeH+0cKnm8e0RuECI2f6G4hrsT17mdHOxl+vaf9P/E3+G4r/1W2lE+2TRuI7MJGSjBC2vDWHB7aKiXB40naYZBT84iECPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UoMGkBH0; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711419438; x=1742955438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=naXFIdNU33tz38vUXdohRFxUFMIrzK3pZH6Hd6XFg2c=;
  b=UoMGkBH0uyS2VTPaOfQNePoojtX6b6tOhiPrnTlyKTpqQyxJAct16hjC
   UxqOxwDvuxRkqQJaKtjDmfOzUYBwjkUZcvH8rxAjGl5T30Q0cZ7B4ieAf
   F7tzGnXLtoPMJndRVMQgvleUfHLAg2GmFzevk+1LKXLz1RTYag4ZKmuks
   dyCLCMj/J0HexByKOFa6funmPMKnTvEIodD7T1nty9P8PQX9dmK4EPFY6
   HVnzcX3fB9HPwOW7wpIQAadRJlfUZrPpkDdpheUjE2FKUaemcoWifNFKu
   sFYq/fDhLppEL4r4wOZhNISaagNc/q+HLe5x8rj6HjcVVWvSU2xgbGKrk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6564244"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="6564244"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:17:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="20489877"
Received: from rpwilson-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.11.187])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:17:15 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	broonie@kernel.org,
	christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com,
	debug@rivosinc.com,
	hpa@zytor.com,
	keescook@chromium.org,
	kirill.shutemov@linux.intel.com,
	luto@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	x86@kernel.org
Cc: rick.p.edgecombe@intel.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v4 04/14] mm: Remove export for get_unmapped_area()
Date: Mon, 25 Mar 2024 19:16:46 -0700
Message-Id: <20240326021656.202649-5-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326021656.202649-1-rick.p.edgecombe@intel.com>
References: <20240326021656.202649-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mm/mmap.c function get_unmapped_area() is not used from any modules,
so it doesn't need to be exported. Remove the export.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v4:
 - New patch split from "mm: Use get_unmapped_area_vmflags()"
   (Christophe Leroy)
---
 mm/mmap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2bd7580b8f0b..d160e88b1b1e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1887,8 +1887,6 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 	return error ? error : addr;
 }
 
-EXPORT_SYMBOL(get_unmapped_area);
-
 unsigned long
 mm_get_unmapped_area(struct mm_struct *mm, struct file *file,
 		     unsigned long addr, unsigned long len,
-- 
2.34.1


