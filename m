Return-Path: <linux-kernel+bounces-29384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D9E830D94
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574541F22B72
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4343524A11;
	Wed, 17 Jan 2024 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Mypx634N"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEA2249FE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521595; cv=none; b=HroeNAk305uJNe+903V2RUymInVk/mly0+TcJ2MRgwMCSEqPyRZdvxLzwkxGRZuGqz8kfYGeKW5DDK0zjPeLXtGwcz1XiNxji32bD5yJj26Lvym1n1idjaoL2h/Vb99Hu/ftF5cHuuKWRXUGkANbbfc57VLW+wtSiB2el5R7Iuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521595; c=relaxed/simple;
	bh=+Pta81SYiRfwNxuzxNVy3EkmBMZfAF6F0bWsk98YHZA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=r94cUN7GjJ4ivOH5X1bo8yMdgqGU7DDkxEbVRzqOZlc/iNqBcXxnF8xohTQvMRecNJWm/oZYfT4NrRXFj+igySf8AhyWP3naagCrTDqITaFF9cPir7lDnnRegu5LOS8Zc8McFxSJ1Ag4Tez/AB9paRLJdvSXiur9B5VspNo8ZUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Mypx634N; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33678156e27so9854252f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705521592; x=1706126392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aqDc7wFhUblpWDXInFN43NA3e6m4V27astgceGCPPc=;
        b=Mypx634NcdzTEaOULIugJpe3EZe2ebqIWSbsV8qkPUUhF0rUnsFQlz4zL0ghhG5AJM
         peFT2A+nX3uIL9zcQlfsaMCk6FM/Q+oh8IVNnn9fK0O4X/yokOaSt/1PG7KDgcbiwYCs
         bqc88IJChTMvgonM++wbveF6+MWCK0mNM7kdmqw+QecaNE6zFjwYxCZPE8GebN+jg6JO
         cFoax6IRM1Hi1Q/evyNW+/2PUqNisIduZ/sw/bQfDH0q0S+Z7VbM/ZRTFTRFbTj2emPF
         RAJrZWCeuRajsWVrfH726JLSTceUsFoRHnO1ylpfAhCsJPE17S9tRbYaXfr8gvQq4jZn
         +xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705521592; x=1706126392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aqDc7wFhUblpWDXInFN43NA3e6m4V27astgceGCPPc=;
        b=Zf0Jqcxwit/mfPdviTA2xiGibPIO6fqn/I5X/hpNUTiP3i/uQsDaBbd+9BH1MF6RgO
         C3wWn1rmKftBWEA+dJ8GcWRMc0fP/ZSl/AxMNYX2ylKzFwbCFU40nfv85V4LuVMkZFTN
         NwLAbWzA0mEdZxl6wCDxP2H8Cccufx6UQ0TMEGO284ySxYbc7o2NT5obBA5Vk8Prqr5y
         rCLyRwq+wrYoH9//eP+tqAZqHhwbNbJ4ZjuNOXXR82g2CUFX8X8hl34j7VAmUk4GOKzv
         +F91hhCt4UjrPFbH/KTgvxckuKsQVmyVSbtdqtMwxiwqxOh+cti2GLdjoVAtJhrqbnAb
         Qltw==
X-Gm-Message-State: AOJu0Yzgsjz2Cg+OLxaGekd1l4VWa4dfmMee5YEHVslq/t2rv4f/ObQl
	75yPvRdEycTlqNPxd+TMF9pnpzceOBRhQw==
X-Google-Smtp-Source: AGHT+IH/7y3jh4RsdypLFLgoZFvg4xOYBxfTQlbB2rSxLluKLmi1ibIVgsCqywHLSrX2RjCOL7MVgw==
X-Received: by 2002:adf:eb92:0:b0:337:9f43:93dc with SMTP id t18-20020adfeb92000000b003379f4393dcmr3455303wrn.141.1705521592223;
        Wed, 17 Jan 2024 11:59:52 -0800 (PST)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id i6-20020adfb646000000b00337bc2176f6sm2350294wre.81.2024.01.17.11.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 11:59:52 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Qinglin Pan <panqinglin2020@iscas.ac.cn>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 2/2] riscv: Fix hugetlb_mask_last_page() when NAPOT is enabled
Date: Wed, 17 Jan 2024 20:57:41 +0100
Message-Id: <20240117195741.1926459-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240117195741.1926459-1-alexghiti@rivosinc.com>
References: <20240117195741.1926459-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When NAPOT is enabled, a new hugepage size is available and then we need
to make hugetlb_mask_last_page() aware of that.

Fixes: 82a1a1f3bfb6 ("riscv: mm: support Svnapot in hugetlb page")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/hugetlbpage.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 24c0179565d8..87af75ee7186 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -125,6 +125,26 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 	return pte;
 }
 
+unsigned long hugetlb_mask_last_page(struct hstate *h)
+{
+	unsigned long hp_size = huge_page_size(h);
+
+	switch (hp_size) {
+#ifndef __PAGETABLE_PMD_FOLDED
+	case PUD_SIZE:
+		return P4D_SIZE - PUD_SIZE;
+#endif
+	case PMD_SIZE:
+		return PUD_SIZE - PMD_SIZE;
+	case napot_cont_size(NAPOT_CONT64KB_ORDER):
+		return PMD_SIZE - napot_cont_size(NAPOT_CONT64KB_ORDER);
+	default:
+		break;
+	}
+
+	return 0UL;
+}
+
 static pte_t get_clear_contig(struct mm_struct *mm,
 			      unsigned long addr,
 			      pte_t *ptep,
-- 
2.39.2


