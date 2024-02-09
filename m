Return-Path: <linux-kernel+bounces-58960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526FA84EF34
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5BCD1F2630B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F93DDD3;
	Fri,  9 Feb 2024 03:09:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBD0CA78
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 03:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448168; cv=none; b=tu29c3YDGfaiW5yAbZU1B9UeKfypjlEXpqvMoBUfyQ3uNkAhT9YLVkyWWTCeTn0KvqOGaI2OgQg/3yqL/MMawPyNggRFxsGfJut2AvlEi9zEUcf8INsuAh+qOr05ZJ/wwXBrULsP2RavtONyeJb5C5VENCOY5Vhg6XZPsCxqZKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448168; c=relaxed/simple;
	bh=Tvfhrnd/qJQsIwr8/LWxA/6cpoYuITkSDM79LVABnY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jxnR/VbQdAYP91ShEPRV8m31xVKHF/Kh4/1MKiFgUESxHjoT2a5AUqIJ9dhywxbSOhBvukdNYZVN5xMgMOqZ1FKAsg2i8Vgd69plU7LCK8Hc6fHzZaE6irRrI8sRwyVCzzDau2f5Rnj3PVXPFvlrHasKaOrlwtMvIVjZMLjlXKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE67ADA7;
	Thu,  8 Feb 2024 19:10:07 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5262F3F64C;
	Thu,  8 Feb 2024 19:09:23 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memblock: Add MEMBLOCK_RSRV_NOINIT into flagname[] array
Date: Fri,  9 Feb 2024 08:39:12 +0530
Message-Id: <20240209030912.1382251-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 77e6c43e137c ("memblock: introduce MEMBLOCK_RSRV_NOINIT flag")
skipped adding this newly introduced memblock flag into flagname[] array,
thus preventing a correct memblock flags output for applicable memblock
regions.

Cc: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.8-rc3

 mm/memblock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 4dcb2ee35eca..d9f4b82cbffe 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2249,6 +2249,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_MIRROR)] = "MIRROR",
 	[ilog2(MEMBLOCK_NOMAP)] = "NOMAP",
 	[ilog2(MEMBLOCK_DRIVER_MANAGED)] = "DRV_MNG",
+	[ilog2(MEMBLOCK_RSRV_NOINIT)] = "RSV_NIT",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
-- 
2.25.1


