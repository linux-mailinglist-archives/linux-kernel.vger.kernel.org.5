Return-Path: <linux-kernel+bounces-96600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 207BB875ECC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39491F23C1B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 07:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E66851005;
	Fri,  8 Mar 2024 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WFpgjz8y"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243D04F1FB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709883974; cv=none; b=DSFhU2hg1wYqRZ6ugL/zD//aOnacFTGDdZ6ww+af3sdMxsr2214r1tsZ1LPvdb1u1Hie2qR9eyakrLD+Py8PSdQJnr2gELvXwZITbrzSMu/nX6dUiJA3gl3YEYxCrOcBg5EwbtTn8VyfYVOhYjIc91VUkXAvknjuo5ScD0Q1EwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709883974; c=relaxed/simple;
	bh=qYxU7vhVFFHlVFqvJ2Oik7p3vX515hPOju269hebVfc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bvofBmFJgOrjp6/Sl/8+KsjuS5f/SiW8ZM84jSASPrb3Ov4EI0LuCZlpYz0Our/HJGFSIo1KkEOOVYTntv9nkT2ntI1+n0Gq7MUELytaRVDmkubz+3N9zP73RMqFpI77Dm1N+P/BESDgti7yg4XELiIrOmtWL5jteTgam1hhfAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WFpgjz8y; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a449c5411e1so230581366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 23:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1709883969; x=1710488769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=40cCzbisoVSkufWvb0+W2WVn4MdIoueSCxQxubT81k8=;
        b=WFpgjz8ySfrpVIe48XcbICjX1O0k9GAcgbtyqEo0e7j5DxA3zTxFRm7tuT7QyOZHR+
         0ORRhfF8kjdKpS3xRG+xw+RTgOrO5HZUpjwLNVlOpWOkHsj3h+TALRth1tknrF7n4sOv
         6sqdai8CJTYIEr6G93LBC5QqsF07WpNGxyiMJbiFoQdNzhe0oybd3pbdOuuv3WqtF8p3
         OpeJaD0tV+SL0ABLRlVxiY/ON3blKOlR44bqtYyVjf9t+CU2r4PanQDIwLTnD3nBJhDi
         GyEFAUXOhAPqsg+0/CJr6upIlO41ckHQ3eB6ABuUWWs5JzBn4fUzp4wqjX9YSAGIWnOK
         7zuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709883969; x=1710488769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40cCzbisoVSkufWvb0+W2WVn4MdIoueSCxQxubT81k8=;
        b=r7MDCitl4gfwZPDmEmhSaBzkrrbIkiyep+PIxlxoUHZSUdS0WayFOFdpshlZ7WyOhG
         9qoieBtU10K2QXVujD1icgCmzTtVhzJ6m382ITeGgQitw3SxROdnhC5M7K3OSDY/9hVD
         p2tW4tX/rSoyLckl4y71DuVSsJA/tEYGpaibPQrBzjrhXWmptnHttqdDMcobG5QKC0nb
         G/HIHH77SW1qd8Ypmhnr7OJ8iZ/YqkNCuTIfY8rim/gulUifLO9ake4YXaureHe/7iOz
         926Qp+4AtM+AHPjd8EuEvCswnF5lqKN/3IDZymCZyQZAFf1qxM6o8I4iDeTteAsK04JJ
         2mZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdIfAG6AbldxfgvutjUPvD/nUFzsym2iHrQ/5AP9epQ3ziFOCidux0b5dyMYMqME6Kz8qJ+uV+47moxGJDZNws/7+Kq9BDyQqXRQo8
X-Gm-Message-State: AOJu0YwF/D5mh19q2HrVpo0xzP+OnHGlIkvFeJuQ7Paq185lvC4K1Z38
	XNN6Yf7j5AQlD6khSMDKcByyG4ll4UbePgPMakxseXCvz/0wEEYNj37I4dj3i10=
X-Google-Smtp-Source: AGHT+IFxqxzhFl5fls7nuPQ3N6O0+2LnS2lPOt/oJpZRwzM4JKXx8cqtXXb20+EoKTDV9oeuAPfRTQ==
X-Received: by 2002:a17:906:2b52:b0:a45:bdbd:5a1b with SMTP id b18-20020a1709062b5200b00a45bdbd5a1bmr4570721ejg.42.1709883969480;
        Thu, 07 Mar 2024 23:46:09 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id zh14-20020a170906880e00b00a456573f9c5sm4915505ejb.0.2024.03.07.23.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 23:46:09 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	lienze@kylinos.cn,
	yangtiezhu@loongson.cn,
	tglx@linutronix.de,
	arnd@arndb.de,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] loongarch/pgtable.h: move {dmw,tlb}_virt_to_page() to page.h
Date: Fri,  8 Mar 2024 08:46:00 +0100
Message-Id: <20240308074600.3294338-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These functions are implemented in pgtable.c, and they are needed only
by the virt_to_pfn() macro in page.h.  Having the prototypes in
pgtable.h causes a circular dependency between page.h and pgtable.h,
because page.h's virt_to_pfn() needs pgtable.h for these two
functions, and pgtable.h needs various definitions from page.h
(e.g. pte_t and pgt_t).

I suggest avoiding this circular dependency by moving the function
prototypes to page.h, even though that is slightly incorrect, because
they are not implemented in page.c but pgtable.c, but it's the
simplest possible solution to this problem and the functions not used
anywhere else.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/loongarch/include/asm/page.h    | 3 +++
 arch/loongarch/include/asm/pgtable.h | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/include/asm/page.h b/arch/loongarch/include/asm/page.h
index afb6fa16b826..44027060c54a 100644
--- a/arch/loongarch/include/asm/page.h
+++ b/arch/loongarch/include/asm/page.h
@@ -75,6 +75,9 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 #define sym_to_pfn(x)		__phys_to_pfn(__pa_symbol(x))
 
+struct page *dmw_virt_to_page(unsigned long kaddr);
+struct page *tlb_virt_to_page(unsigned long kaddr);
+
 #define virt_to_pfn(kaddr)	PFN_DOWN(PHYSADDR(kaddr))
 
 #define virt_to_page(kaddr)								\
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 8b5df1bbf9e9..af3acdf3481a 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -363,9 +363,6 @@ static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *pt
 extern pgd_t swapper_pg_dir[];
 extern pgd_t invalid_pg_dir[];
 
-struct page *dmw_virt_to_page(unsigned long kaddr);
-struct page *tlb_virt_to_page(unsigned long kaddr);
-
 /*
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
-- 
2.39.2


