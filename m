Return-Path: <linux-kernel+bounces-59052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584B484F067
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9B78B22B1D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D7F657B8;
	Fri,  9 Feb 2024 06:50:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EE3657A8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 06:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707461448; cv=none; b=Fik+lK+SkywyjP/g4HKRjIEn2Q6CG9cjASqLPN928IgC9w0eyQH9Anuzd/jEF6OuouJpr2XkNXeijNNlCzmZhWRf3m8+edhlzqtl27Kp07+WEOFeIU3ZzVxky8DZX8bEbWdYti2C7WZxklzlIivFDhkzKo3gHbvI6zMyULSyRvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707461448; c=relaxed/simple;
	bh=X13LNehSr2CruPi/AbTdAYcrrlKfmxUrjQpFactaPIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dAwSBv4ODDqCTe2RvDTHlzjxWGPVjZPqzXqE5K/EVGzC1cbwNjNBuVWZOdbV8at5QE/a0Sy+ISsvMGExFWgg4n9Mbmm6OEyB/RNmKNHTjYvFP7rWHUmJQlwiIrCPLHgYig5bHBa3hHGzAlMuOqbFVZ5qbaIql4y0vqwZQsEid6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B027CDA7;
	Thu,  8 Feb 2024 22:51:26 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5D4F93F762;
	Thu,  8 Feb 2024 22:50:42 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/hugetlb: Ensure adequate CMA areas available for hugetlb_cma[]
Date: Fri,  9 Feb 2024 12:20:36 +0530
Message-Id: <20240209065036.1412670-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HugeTLB CMA area array is being created for possible MAX_NUMNODES without
ensuring corresponding MAX_CMA_AREAS support in CMA. Let's just warn for
such scenarios indicating need for CONFIG_CMA_AREAS adjustment.

Cc: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.8-rc3

 mm/hugetlb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a188b7c60f4f..fda8ced69832 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -7750,6 +7750,13 @@ void __init hugetlb_cma_reserve(int order)
 	}
 
 	reserved = 0;
+
+	/*
+	 * There needs to be enough MAX_CMA_AREAS to accommodate
+	 * MAX_NUMNODES heap areas being created here. Otherwise
+	 * adjust CONFIG_CMA_AREAS as required.
+	 */
+	VM_WARN_ON(MAX_CMA_AREAS < MAX_NUMNODES);
 	for_each_online_node(nid) {
 		int res;
 		char name[CMA_MAX_NAME];
-- 
2.25.1


