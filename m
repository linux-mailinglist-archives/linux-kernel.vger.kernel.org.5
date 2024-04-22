Return-Path: <linux-kernel+bounces-153529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCA48ACF37
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A75A1C215E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8B91514CC;
	Mon, 22 Apr 2024 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ms1kULvc"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0E815099A;
	Mon, 22 Apr 2024 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713795665; cv=none; b=bD6jSYtho7n4LQfdCU8fvG/I3mWU7tWvtWq9qrAWU/qnKTE95qN/iycdh+igo5KCjyfVru0cwk/2CZGLmaoOa4G5bJwhxMmv/08HLuTwD747j6LBvAnqCynQrfaLUED9mPNbO7UP51ZS/5dFHitZFuhYt5oWVSISdCEcBxcJNxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713795665; c=relaxed/simple;
	bh=kRCc2qB+QRN81Y9A6rydtQv4DOylAlEkQPIWVCVxyh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=omt2vBPGM4NY/OIK4mlDFeY5XcVqGq2Q72wF/tcfcT2FB5dDviMR+1hJMWArD97CHRY/KzyeX3v86OvEqHkl/oMB1O9d6T0ddoNO/ARWdln+Ot0k5Csee2szE/34b6GRCV7EFwGxNkizHy2iaNkQ9OyzChJrpw7nabAmZzkvi7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ms1kULvc; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gDB1GmbLM1RgLFgDDRHYfTCreFTNn/hu28SEK8oaIj0=; b=ms1kULvct7a4ce6WyMgmW1r7nl
	cfRnf6+dSPUkoWok5LeTV6xdjjUPDGIGDB65WOhPGGg3lxvqSkuQYCTyvJu8//VZ1Qs2oOHHbm+7O
	9sYNCsJu1RGwd/R8LJNK+uoGdC+OYuNjgvYWjlEgLW4+rQ/xYbmhnqED72RkJM/pNA2bYrpjMJJ+O
	HdgrA5HBqJ0w1tctOJsEo1XDl1L8LcrPMWlFT6sbv4lPo6MaYy92wuvSxC1XCqkFYhQAxc5whQHBn
	Lf+ydJ1HccDQRkx+zjZe0BQpTaPSz2xGS75VAzXB5gk8zW0a3cOeCfB5Gh0p8HCil2iEGY4y82TzM
	lf52I8CA==;
Received: from [179.234.232.152] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ryuWz-007HEu-GN; Mon, 22 Apr 2024 16:20:30 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Wei Yang <richard.weiyang@linux.alibaba.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Minchan Kim <minchan@kernel.org>,
	Huang Ying <ying.huang@intel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH] mm: Update shuffle documentation to match its current state
Date: Mon, 22 Apr 2024 11:18:40 -0300
Message-ID: <20240422142007.1062231-1-mcanal@igalia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 839195352d82 ("mm/shuffle: remove dynamic reconfiguration")
removed the dynamic reconfiguration capabilities from the shuffle page
allocator. This means that, now, we don't have any perspective of an
"autodetection of memory-side-cache" that triggers the enablement of the
shuffle page allocator.

Therefore, let the documentation reflect that the only way to enable
the shuffle page allocator is by setting `page_alloc.shuffle=1`.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 10 ++++------
 mm/Kconfig                                      |  7 +++----
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 902ecd92a29f..924bb8ddd8a8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4170,13 +4170,11 @@
 
 	page_alloc.shuffle=
 			[KNL] Boolean flag to control whether the page allocator
-			should randomize its free lists. The randomization may
-			be automatically enabled if the kernel detects it is
-			running on a platform with a direct-mapped memory-side
-			cache, and this parameter can be used to
-			override/disable that behavior. The state of the flag
-			can be read from sysfs at:
+			should randomize its free lists. This parameter can be
+			used to enable/disable page randomization. The state of
+			the flag can be read from sysfs at:
 			/sys/module/page_alloc/parameters/shuffle.
+			This parameter is only available if CONFIG_SHUFFLE_PAGE_ALLOCATOR=y.
 
 	page_owner=	[KNL,EARLY] Boot-time page_owner enabling option.
 			Storage of the information about who allocated
diff --git a/mm/Kconfig b/mm/Kconfig
index b1448aa81e15..f30a18a0e37d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -333,10 +333,9 @@ config SHUFFLE_PAGE_ALLOCATOR
 
 	  While the randomization improves cache utilization it may
 	  negatively impact workloads on platforms without a cache. For
-	  this reason, by default, the randomization is enabled only
-	  after runtime detection of a direct-mapped memory-side-cache.
-	  Otherwise, the randomization may be force enabled with the
-	  'page_alloc.shuffle' kernel command line parameter.
+	  this reason, by default, the randomization is not enabled even
+	  if SHUFFLE_PAGE_ALLOCATOR=y. The randomization may be force enabled
+	  with the 'page_alloc.shuffle' kernel command line parameter.
 
 	  Say Y if unsure.
 
-- 
2.44.0


