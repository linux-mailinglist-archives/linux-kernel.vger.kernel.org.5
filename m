Return-Path: <linux-kernel+bounces-122600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B461D88FA43
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16AA1C2648A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3A05786B;
	Thu, 28 Mar 2024 08:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QAmnmRZW"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF35057879
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615720; cv=none; b=bkX/HquvT6U7wznUTvZWeQQPJiE+i1Kwz2h0vQepU06eC0ScfXfJnepEoGu443spzXXMUCUm/3CgYRM9Dt/oAl5ZWFhxH2137DK9lhvGrvwHcyHh8qGv07SrdwzkvreQ2LYC9v+1eyGlEuwjgMlAUsmPjWXxdzS/+BI1T2HB4PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615720; c=relaxed/simple;
	bh=wKl1EhMAgTYoLL5qMZeILF4kEZl1cRkLkSd7gUAuKkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q3wemfNuxyQ7MqHG5vtifySWi9AkANElg5YJNXHBxSEW1JNTBu1GIeiOykg+MSg11U2DqEIT8s5+ezKfj55gW7DFfMtvp0/5jk+5aT+RxReOwuYtGp5v5/dTWvbtJSUrgJ+oU/UHjqSg966wC5VozFkxOprV+0YzYyhpqvtl45c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QAmnmRZW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EwZPBKDXyyK0mG2Ycz9ZnM3Ar7Wly4gtS0tpc4qRluA=; b=QAmnmRZWEQAxM8c6AP4IiB9tAN
	Hwfvs3n+a9bpVOdMwPV7eH5dRs6N7fDAf1FH17iw+0azrkZHddxchYEG/XTPQuYXGbRTigkBG45i5
	P/a65tpO2mmPMN0cwdoIUJKRs6QtE9lJTRaCpEOkuwy8YzBYx0wKLQTz8Pzdv84nmDo47o1c21IEw
	fC9tH4UbqTCegOVUUbg9dX4n1KgBCgYvppKFvzh4wDD7lR+QihMhzsjO+O2z4fic1NhD+OC2rknaJ
	oqX6poFLqpPfo0kpLkcTMEfWWHyowUKlG442mAde8mboPCLPsnGSr2d7IKJ34IumjxjHj6cvBHQhM
	OJome+ew==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplR7-0000000D96v-1zDk;
	Thu, 28 Mar 2024 08:48:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm: remove ioremap_page
Date: Thu, 28 Mar 2024 09:48:30 +0100
Message-Id: <20240328084831.2955605-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328084831.2955605-1-hch@lst.de>
References: <20240328084831.2955605-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

ioremap_page isn't used anywhere, remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/mach/map.h | 5 -----
 arch/arm/mm/ioremap.c           | 8 --------
 2 files changed, 13 deletions(-)

diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index 2b8970d8e5a2ff..03f456cb53644f 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -52,11 +52,6 @@ static inline void debug_ll_io_init(void) {}
 
 struct mem_type;
 extern const struct mem_type *get_mem_type(unsigned int type);
-/*
- * external interface to remap single page with appropriate type
- */
-extern int ioremap_page(unsigned long virt, unsigned long phys,
-			const struct mem_type *mtype);
 #else
 #define iotable_init(map,num)	do { } while (0)
 #define vm_reserve_area_early(a,s,c)	do { } while (0)
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 794cfea9f9d4c8..6debe27b3a72fb 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -107,14 +107,6 @@ void __init add_static_vm_early(struct static_vm *svm)
 	list_add_tail(&svm->list, &curr_svm->list);
 }
 
-int ioremap_page(unsigned long virt, unsigned long phys,
-		 const struct mem_type *mtype)
-{
-	return vmap_page_range(virt, virt + PAGE_SIZE, phys,
-			       __pgprot(mtype->prot_pte));
-}
-EXPORT_SYMBOL(ioremap_page);
-
 void __check_vmalloc_seq(struct mm_struct *mm)
 {
 	int seq;
-- 
2.39.2


