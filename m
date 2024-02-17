Return-Path: <linux-kernel+bounces-69895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A18BA858FF1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 316C4B21CC8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912207B3C0;
	Sat, 17 Feb 2024 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCcSL3AU"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFA67AE59
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 14:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708178616; cv=none; b=C92IVauKgOVjMEonfiBPxlaSEGNJXy1FTefaQvQlmzbe1TJBueBExHNeDn0RytKGhe4sfACOqDwsrBeqyIxIlZsxmyDow5Mnc5PfaXtyb/Xfn3UK3mzem6rmGefa/BL1QuBktwvgQRDYyQGN6aiWaku7+HkIWvTKZePXWzty5tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708178616; c=relaxed/simple;
	bh=N3kVayaMp3wVwgj+kIB/WmRnuaDXhFcV290FNAS36B8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iHgFm/l6nmVfbe+xo6Znst5wfyb7CqAD1YrrluZctTqvacLyiPDO6KZcad/STIU3z3U5kkJ+0fR4TjqSDRKy3+H0oHsSc8pyi63Clbf4MuXb6nsxkY+fX3byrpC1qwcNI3xK13muCJsE3x4qet9ugQKAONvvs1a8zDyi+QWn6dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCcSL3AU; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so7839105ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 06:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708178615; x=1708783415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6c0Z1DTg0XtAkeLkrVtLodDmYXe6vkXZYPCGkelpqWQ=;
        b=LCcSL3AUyGx/PiFIAPqmDqCmrPgxibJDR7ismyJTe4SA+SywS5u2qw8DScK2hFAdwx
         YbkF+ZWgP+s31jEMbOHP5ET7fFNoVWZJqtVgykHcoOkJLqJ0S/ORW/0NoRZ2tnwoeD3k
         pz/tjCRqv5b/ta9vvFrjvYGZkZKI40YhIeZMqHy+sJj7r4QvMJsGXgcg4fgBg0GijETy
         NUb74oHnupOG5qc3hr8xPs6G5l6xneDGcytzXE1C6B8OxWxAlSPW6EEokmEMgdVbsb5u
         1KO++hPTbvv1OMhuu9OdSxG70n8e3Mr4bn2frZ+DZ2rd/G9bVG11zDEsncG6q4j0dJRl
         0mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708178615; x=1708783415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6c0Z1DTg0XtAkeLkrVtLodDmYXe6vkXZYPCGkelpqWQ=;
        b=NYZJnf5vsk2KKtt4ELUgw5TU6+ZzuI5ALLA4BnErAtADu8/xGnCdLzPrvwMc3ivSBR
         p1EYcI+8cNkoILZVAFLkBm1/YWwlf2rduL1CrJ0L/uio416jD8wtgdTuSXuzvUDL0tbz
         ktMcTtlu5FAX8OYrMJwnTfj5Veosape9tVY8p32PYm3Xnkryg4+eDHXxDDZROYI3XbiT
         flNjD7WafPssyjlG6O9sLQtfKCKnTGJhyaI6BsVYCI9E8znrWEZnU170eDwwPjl9ImBh
         neRlDiqJ9l9LkSJU30lH5ClHm5d2sIm1B1ClOYjOqN66F4EVS0LCbM3EHBcxs5348ztJ
         ye1g==
X-Forwarded-Encrypted: i=1; AJvYcCX1yUzrWX+mA3e6ol1CaUmuGzn/e3Zd+UuqXcvEowJydlC5I6h+MYZ3v27GWlB2XAEgGHI5v2WT7aMhkPBGB3RFxBPwPWLll85AcT9l
X-Gm-Message-State: AOJu0Yz05cW4BjE9hBTdUcXpHl4RTNzLV6OqkgNkZRLgjfac0QtsPcuc
	egQpQoD1+iCY6BzOntyTgJIIhpJ6laENDQuviVDl+ig6He21LGNE
X-Google-Smtp-Source: AGHT+IHUaODZAKT7ah89DecUIkjql9tsAgTSf3wNog6n7JPmzFL5pBBhXnxkxI705VdvnDy6XJJUGQ==
X-Received: by 2002:a17:902:7847:b0:1db:5213:222 with SMTP id e7-20020a170902784700b001db52130222mr6737543pln.5.1708178614392;
        Sat, 17 Feb 2024 06:03:34 -0800 (PST)
Received: from localhost.localdomain ([49.142.40.215])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902748300b001dbcb39dd80sm1032713pll.183.2024.02.17.06.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 06:03:34 -0800 (PST)
From: skseofh@gmail.com
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: ryan.roberts@arm.com,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daero Lee <skseofh@gmail.com>
Subject: [PATCH] arm64: add early fixmap initialization flag
Date: Sat, 17 Feb 2024 23:03:26 +0900
Message-Id: <20240217140326.2367186-1-skseofh@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daero Lee <skseofh@gmail.com>

early_fixmap_init may be called multiple times. Since there is no
change in the page table after early fixmap initialization, an
initialization flag was added.

Signed-off-by: Daero Lee <skseofh@gmail.com>
---
 arch/arm64/mm/fixmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
index c0a3301203bd..fbdd5f30f3a1 100644
--- a/arch/arm64/mm/fixmap.c
+++ b/arch/arm64/mm/fixmap.c
@@ -32,6 +32,8 @@ static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __page_aligned_bss;
 static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
 static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
 
+static int early_fixmap_initialized __initdata;
+
 static inline pte_t *fixmap_pte(unsigned long addr)
 {
 	return &bm_pte[BM_PTE_TABLE_IDX(addr)][pte_index(addr)];
@@ -100,10 +102,15 @@ void __init early_fixmap_init(void)
 	unsigned long addr = FIXADDR_TOT_START;
 	unsigned long end = FIXADDR_TOP;
 
+	if (early_fixmap_initialized)
+		return;
+
 	pgd_t *pgdp = pgd_offset_k(addr);
 	p4d_t *p4dp = p4d_offset(pgdp, addr);
 
 	early_fixmap_init_pud(p4dp, addr, end);
+
+	early_fixmap_initialized = 1;
 }
 
 /*
-- 
2.25.1


