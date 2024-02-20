Return-Path: <linux-kernel+bounces-73813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC1685CBED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF21282A96
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A9B154C1C;
	Tue, 20 Feb 2024 23:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pbi/t48x"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA1815444C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471078; cv=none; b=if3UVPJ4+cQhAnaRthMNEyhCpWXsbw3nDHGIG6YZHE+o0x4XvJAnekcbfd/LaZAdp65XO+bmj64p6tuTZSrgx4q+ymvwwWJTKsWHMnXUH0KJfpFlNfkiQceB1IiTOOXj6MOvw0ISFljFFTFlvt5xPDLLMUkxYiuPSlkpYqXvNd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471078; c=relaxed/simple;
	bh=w7NO52HmHL+q505Dn92pUra8VAi/sS5VxGl78ixbv18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slq6lrHXF80RodGhoUqjroGtbte+EHfKmREKE8nCrT7xwv/caxcqM5R1XONCFgAHjml115TT3onnGFhRg97YSjdFFHEgofnMYZbvxiAmJRFH3I4rBrISsY14cO29ZvAEl2oNW8+yMZzF98YM07DS94iai0Cfl2FOvzQ/+0lneTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pbi/t48x; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e457fab0e2so1536511b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708471077; x=1709075877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aW/E5QzrtW5KWaWO1KQggPctJlLZibTAzJ7k8sLAf4k=;
        b=Pbi/t48xqQCHKW13C4tTZh/OP3qT5u3iOaG6k0Qm5Ho0fVgcXYliPuyFLH8FbVtsV4
         x1hItszsOiQR8so6DA7x8+m0o1/2tcBxIryO8q3rF91gOaaUCt0BTmq/+NxMli4atCh0
         TbwV05Tb/QesMv7vIE/lo0W3r3zTqGUk+gCfu2U57Yk2IlEwpCxQdMq0pqaOmrgO4fTB
         ET8WY2Jip92xHMiXEQhRE3ompz5osbsXCdKqbWFNeAGGF/4E6GH/kAeuyw9HnkqFUb33
         Wukqp0vlj28EfOO1lmMM+6b+ZxZ8O35P/DJnTQoM4bWTvU73eruq6mu7IlEs3vfrK3Kr
         qV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708471077; x=1709075877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aW/E5QzrtW5KWaWO1KQggPctJlLZibTAzJ7k8sLAf4k=;
        b=c25HMmBXmiLirADfHuBaXXtYOWLIGbP/ZEl+56uvP6Gz6WYIiq+s4RmR4PtviGm2gp
         5cWQxRTLPOyVWF9m6l6Z4Ev7SP+B6mRCYR65KWIKEDnpjy1WVF2ApHYJCu63q4G3SSK5
         4mU8ZrDGLizcIygpFcOPJJleMjqr8sk72fRxGy58hy4pnH8xCX8qRRT7l8Duqsn3HLgD
         lEDSiuDzmRX8R+mFMqIU0Mf+eaz3v9SFLTw+qlC8/ux1ZrpvpxWTjdd/W4yKf0Sz4hBn
         rETosFYa7k4nIwL8EDNgwq2d/E/Tdv4VF+AtuvthjjMg85M/YB9JiVoHUwG9txH+xsd1
         REdA==
X-Gm-Message-State: AOJu0YzD3uqBhUrHZmLQCfZFWSwnvKXY+FP6FKv/fb3SrUlc0XQ5y7j6
	Aq+D9oNPFIiPTJXqckPnaBiiyN97cpZEsv8E3ngDDg66lOyzvaMo
X-Google-Smtp-Source: AGHT+IFPXuxHXTsoKb+rhglPR7fJPhGLbyzZMpYsYJF/K2X4fA7iFxHEPv599+mEA0511+dKVVlSEA==
X-Received: by 2002:a05:6a00:4c98:b0:6e4:66a5:2870 with SMTP id eb24-20020a056a004c9800b006e466a52870mr7967423pfb.8.1708471076681;
        Tue, 20 Feb 2024 15:17:56 -0800 (PST)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id x16-20020aa784d0000000b006e13a5ab1e5sm5317803pfn.73.2024.02.20.15.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 15:17:56 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 2/3] hugetlb: Use vmf_anon_prepare() instead of anon_vma_prepare()
Date: Tue, 20 Feb 2024 15:14:23 -0800
Message-ID: <20240220231424.126600-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220231424.126600-1-vishal.moola@gmail.com>
References: <20240220231424.126600-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hugetlb_no_page() and hugetlb_wp() call anon_vma_prepare(). In
preparation for hugetlb to safely handle faults under the VMA lock,
use vmf_anon_prepare() here instead.

Additionally, define a struct vm_fault at the top of each function.
These can later be used to convert hugetlb to use struct vm_fault -
similar to mm/memory.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/hugetlb.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ed1581b670d4..10f57306e1f0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5834,9 +5834,15 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct folio *old_folio;
 	struct folio *new_folio;
 	int outside_reserve = 0;
-	vm_fault_t ret = 0;
+	vm_fault_t ret = 0, anon_ret = 0;
 	unsigned long haddr = address & huge_page_mask(h);
 	struct mmu_notifier_range range;
+	struct vm_fault vmf = {
+				.vma = vma,
+				.address = haddr,
+				.real_address = address,
+				.flags = flags,
+	};
 
 	/*
 	 * Never handle CoW for uffd-wp protected pages.  It should be only
@@ -5960,8 +5966,9 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * When the original hugepage is shared one, it does not have
 	 * anon_vma prepared.
 	 */
-	if (unlikely(anon_vma_prepare(vma))) {
-		ret = VM_FAULT_OOM;
+	anon_ret = vmf_anon_prepare(&vmf);
+	if (unlikely(anon_ret)) {
+		ret = anon_ret;
 		goto out_release_all;
 	}
 
@@ -6119,7 +6126,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			pte_t old_pte, unsigned int flags)
 {
 	struct hstate *h = hstate_vma(vma);
-	vm_fault_t ret = VM_FAULT_SIGBUS;
+	vm_fault_t ret = VM_FAULT_SIGBUS, anon_ret = 0;
 	int anon_rmap = 0;
 	unsigned long size;
 	struct folio *folio;
@@ -6128,6 +6135,12 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	unsigned long haddr = address & huge_page_mask(h);
 	bool new_folio, new_pagecache_folio = false;
 	u32 hash = hugetlb_fault_mutex_hash(mapping, idx);
+	struct vm_fault vmf = {
+				.vma = vma,
+				.address = haddr,
+				.real_address = address,
+				.flags = flags,
+	};
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -6221,8 +6234,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			new_pagecache_folio = true;
 		} else {
 			folio_lock(folio);
-			if (unlikely(anon_vma_prepare(vma))) {
-				ret = VM_FAULT_OOM;
+
+			anon_ret = vmf_anon_prepare(&vmf);
+			if (unlikely(anon_ret)) {
+				ret = anon_ret;
 				goto backout_unlocked;
 			}
 			anon_rmap = 1;
-- 
2.43.0


