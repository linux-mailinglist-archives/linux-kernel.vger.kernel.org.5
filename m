Return-Path: <linux-kernel+bounces-122601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B241D88FA44
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0A46B250C4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B617954BE2;
	Thu, 28 Mar 2024 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ET/DejbS"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E724219
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615732; cv=none; b=A6JNcSNL3Mjsx3zZpvIkCpGCWamM+jFUR0zeLBxbz+Jb7doqvET0toLKlk3axxHIY5LCCi3XI+J2jOdD873MDPtYMnVmM2xW28t/+zcndVJy5et2Q0L+XBZnPMuRLTNbpOViPRkO5sQs8JZ+HwSb0r8IVef8M99trS6dXkskB7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615732; c=relaxed/simple;
	bh=o8c7YIBOcbt1WkBAgCD2X25MFi4EJfZ1Tk0WWpnt0OU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qrhxc85L2itp+bO5Nz1JNERSRStTuzrvimbeDWVrMzad5vI4Ylm3lEdRDMzUm0HFrdKuDDAUS2WcwgFVRqkxgR9XT15YjHpNm9x1ycDkJ6hApdC6b5JLJSeD4pUfZgD2XYPggYmkzvLrgMCsHk9nbH9tumUBrRM0de5ap2VTIzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ET/DejbS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zCMkSV4PVRH89Jt8fxqtR3Up+Mt14DI0nqtbUS1nECo=; b=ET/DejbSEnvL9TypvQUKRjgSAP
	rusSwaRWwkT3oXxeZW04CS+fs3PJ+86x/ZlvhrIhFetkIGOLOTwSCCn8sapkA6kIb55vOrplpjkjJ
	GbDgrrFv3zf7nnZTXEYW7a6hiLju7f9KYJC07kFko8T+0ZX90xz909Va51SzTz2diVEsu2CspUIc3
	QlGesSXoC4YW3kF37FepszRKId3YpNOJgS27/t2tDhMXFI5y3862ezsyMZf/OdyiyhVCPBcIt6N00
	fmPBUyXBDKsJS5kO22QYq6Q7nYGxScsz681++QgVFEEgiyuaS7t+cmvbByyK0WliylST0Nmvvz64Z
	kK+C/x+Q==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rplRA-0000000D981-0YMr;
	Thu, 28 Mar 2024 08:48:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm: unexport get_mem_type
Date: Thu, 28 Mar 2024 09:48:31 +0100
Message-Id: <20240328084831.2955605-3-hch@lst.de>
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

get_mem_type is only used pci_remap_iospace and ioremap, no need to
export it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/mach/map.h | 2 --
 arch/arm/mm/mmu.c               | 1 -
 2 files changed, 3 deletions(-)

diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index 03f456cb53644f..30de16b65297e2 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -50,8 +50,6 @@ extern void debug_ll_io_init(void);
 static inline void debug_ll_io_init(void) {}
 #endif
 
-struct mem_type;
-extern const struct mem_type *get_mem_type(unsigned int type);
 #else
 #define iotable_init(map,num)	do { } while (0)
 #define vm_reserve_area_early(a,s,c)	do { } while (0)
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index c24e29c0b9a48e..ed43f7b79b5a47 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -350,7 +350,6 @@ const struct mem_type *get_mem_type(unsigned int type)
 {
 	return type < ARRAY_SIZE(mem_types) ? &mem_types[type] : NULL;
 }
-EXPORT_SYMBOL(get_mem_type);
 
 static pte_t *(*pte_offset_fixmap)(pmd_t *dir, unsigned long addr);
 
-- 
2.39.2


