Return-Path: <linux-kernel+bounces-66293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DC08559DA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B621F296F6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5929D3D9E;
	Thu, 15 Feb 2024 04:34:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321F1625
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 04:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707971656; cv=none; b=n4Gyj2uCoroxxhfCP7rffFkTMWMzz2bAd+WrygjSMUlHI/8wQOefYlMEiFI9+SxtAThsktf6MeRDbb66j6NmGk3Ohkdp0v+TJZFyF/sQ5XHGXDXEoe6ghxRRWRdDwkfE/kgZY1PNQ9qtE/wI8hgHpvz99FJjDScfRVUbaD3IHV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707971656; c=relaxed/simple;
	bh=XX6T+2qLJ1at+tCtwel54WNzbhu3rUFHduoOdIcabBo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JDV5A1aqBY/gqJRnkYBS23OdKRBgAKBzIRI8ncIiGu/AChJzHsgtFkDXJknPMNOrEyy9cf5JNg9ZDk9r3g70J5DTq3+5g6KPTQ69vwrfrj0br4yK0ZgIP0khdzGEnwXA9AbVEbbYmYGLCYK2eTxvK3ORc45cR5EQro8iaiTDVgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06E2A1FB;
	Wed, 14 Feb 2024 20:34:53 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.45.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 201CE3F7B4;
	Wed, 14 Feb 2024 20:34:09 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] mm/hugetlb: Ensure adequate CMA areas available for hugetlb_cma[]
Date: Thu, 15 Feb 2024 10:04:05 +0530
Message-Id: <20240215043405.2379295-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HugeTLB CMA area array is being created for possible MAX_NUMNODES without
ensuring corresponding MAX_CMA_AREAS support in CMA. This fails the build
for such scenarios indicating need for CONFIG_CMA_AREAS adjustment.

Cc: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This patch applies on v6.8-rc4

Changes in V2:

- Replaced VM_WARN_ON() with BUILD_BUG_ON() per Andrew

Changes in V1:

https://lore.kernel.org/all/20240209065036.1412670-1-anshuman.khandual@arm.com/

 mm/hugetlb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ed1581b670d4..30dc02e19616 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7743,6 +7743,13 @@ void __init hugetlb_cma_reserve(int order)
 	}
 
 	reserved = 0;
+
+	/*
+	 * There needs to be enough MAX_CMA_AREAS to accommodate
+	 * MAX_NUMNODES heap areas being created here. Otherwise
+	 * adjust CONFIG_CMA_AREAS as required.
+	 */
+	BUILD_BUG_ON(MAX_CMA_AREAS < MAX_NUMNODES);
 	for_each_online_node(nid) {
 		int res;
 		char name[CMA_MAX_NAME];
-- 
2.25.1


