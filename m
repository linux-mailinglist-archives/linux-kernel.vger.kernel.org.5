Return-Path: <linux-kernel+bounces-72286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2C985B1A0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CBF1F226C1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC9A53819;
	Tue, 20 Feb 2024 03:48:46 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AA247A4C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708400926; cv=none; b=h/58vaSPM2kRei1xqkKb+iZzbYRXsT3mWk9guyi/sN+JeUBevyCtG3ENdQ7RyFy5bIBvFj5dr/MVIbIE6v8dqKlor0sLu8pR4/IcfHYJhTYiIehRupbFWthrpYYiFUNUTdcrSso0HHW+ilz3I/QybBdnRlNq9ESid+DvMTDisgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708400926; c=relaxed/simple;
	bh=Z6elAPMbAM6XrnscquSpysia9b+peWJJ+5rOVH2M9ds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2Vr7OWMf7P73mKSKAoU9Kz3tjc9KQK+NMCFXB79p0zviYVU05y3lI7oAME+JpdPKHo9A5ECf90VUMNw6Ba/tWSfMeEQFshRwsP1zEOMNVuVYX8iF+OYn/+8boEdbAkOyW6hPNR93reSH9mlTwf2dCxTXb0UfuxHhCKPDj9x6Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tf52J35Gtz1xnMy;
	Tue, 20 Feb 2024 11:47:20 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id A29B0140120;
	Tue, 20 Feb 2024 11:48:41 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 20 Feb 2024 11:48:40 +0800
From: Wupeng Ma <mawupeng1@huawei.com>
To: <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
	<luto@kernel.org>, <tglx@linutronix.de>, <peterz@infradead.org>,
	<hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <mawupeng1@huawei.com>,
	<bp@suse.de>, <mingo@redhat.com>, <rdunlap@infradead.org>,
	<bhelgaas@google.com>, <linux-mm@kvack.org>
Subject: [PATCH v4 3/3] x86/mm/pat: Remove WARN_ON_ONCE if follow_phys fails
Date: Tue, 20 Feb 2024 11:48:35 +0800
Message-ID: <20240220034835.507022-4-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240220034835.507022-1-mawupeng1@huawei.com>
References: <20240220034835.507022-1-mawupeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd200001.china.huawei.com (7.185.36.224)

From: Ma Wupeng <mawupeng1@huawei.com>

Since there is no obvious reason to keep this WARN_ON_ONCE if follow_phys
fails in track_pfn_copy/untrack_pfn, Drop it.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 arch/x86/mm/pat/memtype.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 5b56f08f8ce6..5b3a7a2b21e3 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -992,10 +992,9 @@ int track_pfn_copy(struct vm_area_struct *vma)
 		 * reserve the whole chunk covered by vma. We need the
 		 * starting address and protection from pte.
 		 */
-		if (follow_phys(vma, vma->vm_start, &prot, &paddr)) {
-			WARN_ON_ONCE(1);
+		if (follow_phys(vma, vma->vm_start, &prot, &paddr))
 			return -EINVAL;
-		}
+
 		pgprot = __pgprot(prot);
 		return reserve_pfn_range(paddr, vma_size, &pgprot, 1);
 	}
@@ -1079,10 +1078,8 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 	/* free the chunk starting from pfn or the whole chunk */
 	paddr = (resource_size_t)pfn << PAGE_SHIFT;
 	if (!paddr && !size) {
-		if (follow_phys(vma, vma->vm_start, &prot, &paddr)) {
-			WARN_ON_ONCE(1);
+		if (follow_phys(vma, vma->vm_start, &prot, &paddr))
 			return;
-		}
 
 		size = vma->vm_end - vma->vm_start;
 	}
-- 
2.25.1


