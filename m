Return-Path: <linux-kernel+bounces-132984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D739899CDA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6CF1C20C35
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6763816C866;
	Fri,  5 Apr 2024 12:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Wgxkv1rQ"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1171C161B43
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319874; cv=none; b=AS3wCGOU6QfsI72DUJWR+R6o2ZpzdsluEPNQ2/7UO19HFwElt1HBCnpHuwUkzjexR/rBgcCvnuFx0yAzwjp2nhSlA1/qdP1q7Qmburd8inu/sMru1lVvcTA0oaPc7WJPRXRUQIQh25YOYTDztYVYFncKRDV6vmCbgzDLqDrKhx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319874; c=relaxed/simple;
	bh=TMV6W+86/NP9K6bri+78PHBBLg88f2DQxrOZVXBrspA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UHfyyfn8TIlEHu+P/fe6CokPBRZ/CwO8zFd2sEOKVFAvN2DqfeL8RD3ZPGAd0zD0Aj7YSmlUAXREYFwiNJvtsYhrUWuAPhQ4rLB8J5phPutwyaqG/E3ZDmUt5qRGkTlw4QoXuVFGdudstT0anvDqeCitVOFy6DNdj19/MGgvrHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Wgxkv1rQ; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712319864; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Xgh9CRUBvGZe+XyUWVoXRS+621S2VeB7U0nxfDSeTKc=;
	b=Wgxkv1rQ78vkZqULUWLyf1lFuFyHrgHZwiATuW110pEgWvUgt0XGUt1k+glpHM0ldw2+LekL0w/tCbWfuIISTgLR8dBwPB60fk1iFJMmZDqzDD6sjUId5MFaLmB6c2djLud02ON9PbR1YzRQhePgkSjnr69A70uVd8fhemEDGts=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W3wypEZ_1712319863;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W3wypEZ_1712319863)
          by smtp.aliyun-inc.com;
          Fri, 05 Apr 2024 20:24:24 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: mgorman@techsingularity.net,
	vbabka@suse.cz,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: set pageblock_order to HPAGE_PMD_ORDER in case with !CONFIG_HUGETLB_PAGE but THP enabled
Date: Fri,  5 Apr 2024 20:24:16 +0800
Message-Id: <3d57d253070035bdc0f6d6e5681ce1ed0e1934f7.1712286863.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Vlastimil suggested in previous discussion[1], it doesn't make sense to set
pageblock_order as MAX_PAGE_ORDER when hugetlbfs is not enabled and THP is enabled.
Instead, it should be set to HPAGE_PMD_ORDER.

[1] https://lore.kernel.org/all/76457ec5-d789-449b-b8ca-dcb6ceb12445@suse.cz/
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/pageblock-flags.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
index 3f2409b968ec..547e82cdc89a 100644
--- a/include/linux/pageblock-flags.h
+++ b/include/linux/pageblock-flags.h
@@ -28,7 +28,7 @@ enum pageblock_bits {
 	NR_PAGEBLOCK_BITS
 };
 
-#ifdef CONFIG_HUGETLB_PAGE
+#if defined(CONFIG_HUGETLB_PAGE)
 
 #ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
 
@@ -45,7 +45,11 @@ extern unsigned int pageblock_order;
 
 #endif /* CONFIG_HUGETLB_PAGE_SIZE_VARIABLE */
 
-#else /* CONFIG_HUGETLB_PAGE */
+#elif defined(CONFIG_TRANSPARENT_HUGEPAGE)
+
+#define pageblock_order		min_t(unsigned int, HPAGE_PMD_ORDER, MAX_PAGE_ORDER)
+
+#else /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 /* If huge pages are not used, group by MAX_ORDER_NR_PAGES */
 #define pageblock_order		MAX_PAGE_ORDER
-- 
2.39.3


