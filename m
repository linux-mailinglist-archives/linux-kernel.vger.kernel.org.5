Return-Path: <linux-kernel+bounces-131512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DBB8988E3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF16D1F22855
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2446512836B;
	Thu,  4 Apr 2024 13:37:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC968127B4E;
	Thu,  4 Apr 2024 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237830; cv=none; b=c4CZr+PkHkRDaqQT+rPg/zMlisxeuBHn9USZrmlR+ZQ+ZLrMWpJ/k5yod4QQ4PA3T/NrTq4CclwSLII2X+wd4hT3FJO/F3cGqXT7t4SHNVR067Q1tNp4tYgnSdujAdv2oYopYj3DOsI0wBZCt0kTCKUh3oTds3NtmdPNnqs/RR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237830; c=relaxed/simple;
	bh=jxLpmh8VTKLl4QE0vKweacztjDkwg/HfKpebb5mL/xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcsXnwKZ3RC0BD769sgm3mngKCnmqEr+AVDG5kbnzx48kOuBindMnhQNrTa+KDXWmq6kf/S+l2aELcE4QebiEVUoU/MXW48x/mdg+EF6jEmyN4g7wBzn5qoFLrSNdAvN6jQEClPw+JAWMvQgS51ms8kSRW0b3YFxiOPAjUFJPr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A4AC433C7;
	Thu,  4 Apr 2024 13:37:07 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Andrew Morton <akpm@linux-foundation.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-mm@kvack.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 1/3] mm: Move lowmem_page_address() a little later
Date: Thu,  4 Apr 2024 21:36:34 +0800
Message-ID: <20240404133642.971583-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240404133642.971583-1-chenhuacai@loongson.cn>
References: <20240404133642.971583-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

LoongArch will override page_to_virt() which use page_address() in the
KFENCE case (by defining WANT_PAGE_VIRTUAL/HASHED_PAGE_VIRTUAL). So move
lowmem_page_address() a little later to avoid such build errors:

error: implicit declaration of function 'page_address'.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 include/linux/mm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0436b919f1c7..7b0ee64225de 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2207,11 +2207,6 @@ static inline int arch_make_folio_accessible(struct folio *folio)
  */
 #include <linux/vmstat.h>
 
-static __always_inline void *lowmem_page_address(const struct page *page)
-{
-	return page_to_virt(page);
-}
-
 #if defined(CONFIG_HIGHMEM) && !defined(WANT_PAGE_VIRTUAL)
 #define HASHED_PAGE_VIRTUAL
 #endif
@@ -2234,6 +2229,11 @@ void set_page_address(struct page *page, void *virtual);
 void page_address_init(void);
 #endif
 
+static __always_inline void *lowmem_page_address(const struct page *page)
+{
+	return page_to_virt(page);
+}
+
 #if !defined(HASHED_PAGE_VIRTUAL) && !defined(WANT_PAGE_VIRTUAL)
 #define page_address(page) lowmem_page_address(page)
 #define set_page_address(page, address)  do { } while(0)
-- 
2.43.0


