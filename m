Return-Path: <linux-kernel+bounces-155425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EED8AEA2E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A5A2883C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F3813BC34;
	Tue, 23 Apr 2024 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xb6dZHCa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E8D13BAF6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713884789; cv=none; b=WBYqJRBuxFcWrSxU1KFr+VgT0xdzLN6aJyXtRKmCk3M9rbd9vMKCzuZIRKZMNVCcO5gO2Soz55im+ZbX0a3jtKnlxrGJrQgmS/A0h5qAMAemLn5Bqulg01WlhRTefziUa9GU0vJ1tqMUu3L+dlEt6l579IGbKC2qNx67RIEm+50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713884789; c=relaxed/simple;
	bh=o6CKy0NYPP8jGkzivA4Wvp8QxKf+uzrSJVajbqU9mko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ceq9XDsVBFVspAUHjoUXeAV0epp3mFC0aqr0zeajX2qXPrHCnmsA6EcwyA6r0cZ4ztY554wG3qXbapMxHIKer62QR0XTT0GBYbG3l2AZwf37I6Y+whi2VPTlHjpnaoUfOQQhrSjmZI7USrwt/+HEF9EhZoOuHGZSZver+1UtZbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xb6dZHCa; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713884787; x=1745420787;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o6CKy0NYPP8jGkzivA4Wvp8QxKf+uzrSJVajbqU9mko=;
  b=Xb6dZHCa37659PcbUF1KQagFpitqTNS9TJYLTq38fqqKKU6l2yZR/ZgK
   pq3ycdxpAStuH4rmFEReT+bDFa6wJHzIcyCg9u4JtKe7nQ2oKRW0C3/QA
   6wnMV2smIXaUP2mjrsP22kAtdpVTzgMju3E11FHVZjmEf0mUWOYI9IFDh
   1vkSeV2S5raV5upkUUxO1Vt0FZ09i70wYggHoDJa2L5iue6DFxWs2Zqdp
   PmCp1WUp5x95y9IoG70/lP5M6VeZRPnvpieHboK5z34G5tcMU64Pre6GZ
   YXH0ckNUCp1EIa3E0CD3jrNL6lgsDTMk1I9pff1wSd3laGSyJ3rN5g8iv
   A==;
X-CSE-ConnectionGUID: hD6osGthT/+T+mnw+pmk4w==
X-CSE-MsgGUID: k6sjZC/tTyaCRD5gYXJ5jA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20085333"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20085333"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 08:06:26 -0700
X-CSE-ConnectionGUID: 0hrMKSD0RlGvTGF21MX/3Q==
X-CSE-MsgGUID: Xo9vBO6dS1ylJ7ufOa3/Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28895349"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 23 Apr 2024 08:06:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 22341192; Tue, 23 Apr 2024 18:06:23 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mm: page_alloc: Avoid defining unused function
Date: Tue, 23 Apr 2024 18:06:22 +0300
Message-ID: <20240423150622.2526825-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some configurations I got
mm/page_alloc.c:656:20: warning: unused function 'add_to_free_list' [-Wunused-function]
Becuase the only user is guarged with a certain ifdeffery,
do the same for add_to_free_list().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 33d4a1be927b..0fb796b700a4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -653,6 +653,7 @@ static inline void __add_to_free_list(struct page *page, struct zone *zone,
 	area->nr_free++;
 }
 
+#ifdef CONFIG_MEMORY_FAILURE
 static inline void add_to_free_list(struct page *page, struct zone *zone,
 				    unsigned int order, int migratetype,
 				    bool tail)
@@ -660,6 +661,7 @@ static inline void add_to_free_list(struct page *page, struct zone *zone,
 	__add_to_free_list(page, zone, order, migratetype, tail);
 	account_freepages(zone, 1 << order, migratetype);
 }
+#endif
 
 /*
  * Used for pages which are on another list. Move the pages to the tail
-- 
2.43.0.rc1.1336.g36b5255a03ac


