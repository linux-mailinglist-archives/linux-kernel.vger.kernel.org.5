Return-Path: <linux-kernel+bounces-75687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C4D85ED67
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96CD7B22C2C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74FF132470;
	Wed, 21 Feb 2024 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgC/KyMo"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5C212EBD8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559407; cv=none; b=j1DPKqpwaddOGIBGj7pnEjLbOSGcGqOUbeiCpg1ABDhB1WuH/afIcO7w9ifRucsoh5I9iWiJXNkTnvtS/xTrvlHv0tCPYPNJF2tHICn6x/iGL1Cq4NQEphE8XT0ht1sbuuX3WZrX80hyqNPDwvADpXcLk00lPuWMgHBB6jrE+jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559407; c=relaxed/simple;
	bh=kuCilgvuAIh9xQxA9Yc9QbjSc9LNo4S0L3J7arnWxXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Seg8a6UIDeQeh06BjSFN32p+W2NDCB8JseJo2CyFa8ftKV+U3zZOPO/gHHL7KdRiCE7T9kRIkOZh78PH+u6ASfheQsQloZLZGWmMbjkCQ5qqopxoFww14X4K4HswgvIdv28nUIozDD8ipnb1YbFHez3D2O1qeq/RPYm3Yb2Db+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgC/KyMo; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dbf1fe91fcso34096775ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708559405; x=1709164205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSphF0hTHN6hhmxhntDhI8RCYH5xfOdNqWBCuNfZ/qQ=;
        b=LgC/KyMoozmyO4oXLVBr62ZbpCIIufqufHT80D2orEwyE/eaXu+Eqa5/u1RMMyDnu+
         yDKe/MHODT98BV+umht4rYfU1ZrLXUToA6enMfzs7oDUizM7NMZmmA70VSmGsjDPTLcr
         pcQVut8HoYojsUDmM2Pi7RAFYLm/iNrHF5xVCofWzS4YkCvgJ3kbenrLT7PkUlWaehP7
         FsCQbIcqNg4R1PtTeWNwj2J7GwfEh9zaKGn7UmYTsiRt5AM51gUlwuPTJzp/84I/QMr6
         rILRVI3h1uRdaGtwaPRVe2rieVPSEg0SVYDPCqIyosexkVHdCbTw69jncE7dTEf6Slxb
         NTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708559405; x=1709164205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSphF0hTHN6hhmxhntDhI8RCYH5xfOdNqWBCuNfZ/qQ=;
        b=glN/j6rgmzPLezkraJkl6YPtVeuk603d4wL69smOCMZARXUrRnoIwjrRTmgPtAO625
         0FDX62A8J4mqBTZPNuCRuhnhAy7wxsrUNH9da7jhGF+C78oXkZiFdXxy5LURlC7rRL86
         SsrELBPE8q3C8YLBjOrw7tvFTn1w1Ngon2lupOkYWcm53Ku6aBqf3QmjRafYuOYUJJ3H
         QGzZEfYonpcXnMC0UMKjynRWqHu2SVtGeZucYsjHrdg3dMVhJq2OfypPrndNHZmleyU4
         bqsBUp81OV25hDbjv8Rg1PgpaibeW7qtYPOdR5EmMRTiQm6D/QQXJDl9eZXEJ4e0Mqf7
         wBSQ==
X-Gm-Message-State: AOJu0YxQDHpQBTVsuyc4Krl5BZxs/0f6ZpESlALZwhHUevfyD1SkC9JX
	5enRBdsL3OqzGBNMiSeV2kps0SjkQMPdSlL8LN0gSVsB8sRwYhsM
X-Google-Smtp-Source: AGHT+IFFqAzicIYgkaaVMs06g/rAMIBEgY7J+qJJESuWeEScuRMjcUmETWIKG0itACQICVY/8H3/VQ==
X-Received: by 2002:a17:903:110c:b0:1da:1e60:f9fe with SMTP id n12-20020a170903110c00b001da1e60f9femr22926959plh.54.1708559405036;
        Wed, 21 Feb 2024 15:50:05 -0800 (PST)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id jx3-20020a170903138300b001d752c4f36asm8657794plb.78.2024.02.21.15.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 15:50:04 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	willy@infradead.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 5/5] hugetlb: Allow faults to be handled under the VMA lock
Date: Wed, 21 Feb 2024 15:47:32 -0800
Message-ID: <20240221234732.187629-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221234732.187629-1-vishal.moola@gmail.com>
References: <20240221234732.187629-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hugetlb can now safely handle faults under the VMA lock, so allow it to
do so.

This patch may cause ltp hugemmap10 to "fail". Hugemmap10 tests hugetlb
counters, and expects the counters to remain unchanged on failure to
handle a fault.

In hugetlb_no_page(), vmf_anon_prepare() may bailout with no anon_vma
under the VMA lock after allocating a folio for the hugepage. In
free_huge_folio(), this folio is completely freed on bailout iff there
is a surplus of hugetlb pages. This will remove a folio off the freelist
and decrement the number of hugepages while ltp expects these counters
to remain unchanged on failure.

Originally this could only happen due to OOM failures, but now it may
also occur after we allocate a hugetlb folio without a suitable anon_vma
under the VMA lock. This should only happen for the first freshly
allocated hugepage in this vma.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/hugetlb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ae8c8b3da981..688017ca0cc2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6354,12 +6354,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		 */
 	};
 
-	/* TODO: Handle faults under the VMA lock */
-	if (flags & FAULT_FLAG_VMA_LOCK) {
-		vma_end_read(vma);
-		return VM_FAULT_RETRY;
-	}
-
 	/*
 	 * Serialize hugepage allocation and instantiation, so that we don't
 	 * get spurious allocation failures if two CPUs race to instantiate
-- 
2.43.0


