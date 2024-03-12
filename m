Return-Path: <linux-kernel+bounces-99936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E022D878F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9711C20B85
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C7369DE8;
	Tue, 12 Mar 2024 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nzZN5mtv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3239D69D01;
	Tue, 12 Mar 2024 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230729; cv=none; b=Ar1wNXfJexzNVgSmUqmKN4Kyqd92aMatGToeAwCd88Vs+yzDxCp6s5rBxVX7j6WyaWZIKzpvHwqYR3R0PGuUfwTo9sYZlUf9W2jY/rnK5AQNEMx9WS28Dh+DLY4I48hfMxFL7x5Uap/NEZmET6fHlTP+BVveMArtbFNF/nl87zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230729; c=relaxed/simple;
	bh=ZGEVlJ/kaJVd0E8jYAG2DeF+zHotxbyxow0UORgWJEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GF0hUMxQeFfIyz2djOibgGlFp43b20llN+oa1idX28hCo+zqcahS7YFqjcrsSNK+qKJmyWz2FvK9fzUGqpSMTt5pjo7YrQSWSdzmxGtwhA9wJDmsX1UglA/h22urcIXB/7DURip3b3UhMDh1QtzRVqD7C9M593OWzLkSr3X5zAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nzZN5mtv; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710230728; x=1741766728;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZGEVlJ/kaJVd0E8jYAG2DeF+zHotxbyxow0UORgWJEs=;
  b=nzZN5mtvVWMMfEjLfqLh5rSSt61Sk3cMw76OFkZLauotveCBa84RELz3
   8x/n01blZAK2tgxVrGPfLMdBViiCj3Vl3BPlEkTiSEO9J4nIAeoZvaGCg
   /dDABe5qoDiWt4GwkS5WtC9shD/s4+hXOqqbUshj2ZQxSLhx6QP/4KNYo
   4Fe2um9ctgKQWJc1wsSXxDQ7tM+9MQ3RpsbuDY3RIKcZ1bvbjH5kqA1NF
   lFr1WDqCy49QKP3Ni7kqfOo6rjx4Y1JfEDX3mB+5hC+qigQ+kC3MeFQVq
   iTAfROEgHxbrynoz4sihMlMuy+OH7YqOjwHfPc7H8CplsG1OTnzlHobqG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="5112973"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="5112973"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 01:05:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="34631465"
Received: from qzhang4-desk.sh.intel.com (HELO localhost) ([10.239.147.49])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 01:05:24 -0700
From: Qiang Zhang <qiang4.zhang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Qiang Zhang <qiang4.zhang@intel.com>,
	Stable@vger.kernel.org
Subject: [PATCH] memtest: use {READ,WRITE}_ONCE in memory scanning
Date: Tue, 12 Mar 2024 16:04:23 +0800
Message-Id: <20240312080422.691222-1-qiang4.zhang@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memtest failed to find bad memory when compiled with clang. So use
{WRITE,READ}_ONCE  to access memory to avoid compiler over optimization.

Cc: <Stable@vger.kernel.org>
Signed-off-by: Qiang Zhang <qiang4.zhang@intel.com>
---
 mm/memtest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memtest.c b/mm/memtest.c
index 32f3e9dda837..c2c609c39119 100644
--- a/mm/memtest.c
+++ b/mm/memtest.c
@@ -51,10 +51,10 @@ static void __init memtest(u64 pattern, phys_addr_t start_phys, phys_addr_t size
 	last_bad = 0;
 
 	for (p = start; p < end; p++)
-		*p = pattern;
+		WRITE_ONCE(*p, pattern);
 
 	for (p = start; p < end; p++, start_phys_aligned += incr) {
-		if (*p == pattern)
+		if (READ_ONCE(*p) == pattern)
 			continue;
 		if (start_phys_aligned == last_bad + incr) {
 			last_bad += incr;
-- 
2.39.2


