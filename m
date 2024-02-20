Return-Path: <linux-kernel+bounces-73814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB3E85CBEE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6015F1C21ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D2C1552FC;
	Tue, 20 Feb 2024 23:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyUW6FvG"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48542154BF1
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471079; cv=none; b=t9GYgbezbF2gcRMBeLhZBCWtfTQP/fxeOCgmXMgxhfnCrHxwu0GloA9Zo1VBLkkIbgruf5fWpIm+8IK7iQbe7Yfk+fmCHvSitw+RbpA0mlAU3NoUtah7zsyk4qz+J8IPrNF7Csrjl6XUiseJvXIn2zgV9kEPpvouP6ifvtBdO2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471079; c=relaxed/simple;
	bh=qFlaAcGU6Y1uDzxqv2LE52Sqg0304QiZAIx8ki9By54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNqCUFfytrrmk3hBMV9qy0hSlZTg5Y+mJa4Pp5HVsHYTQJ7L4udXGSp17ly2gCPJfWcTTO6z7xrQrNzNDjg2nSM+m0it6/cXEbsg3O+QiHhtW2l5Dx+QGYAkughaucy4ESvBWP3ww6CLduEbjWSN/VuirDpU7Mdng5hr3/vwBKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyUW6FvG; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso4686334a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708471077; x=1709075877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrT4PFTPEBdVnQtB3JqEnMTnzuYVsnDN94ufDiP3ix8=;
        b=jyUW6FvGBy5kzzZpjgyjsgXwi/pGHdx+T5eDb221Qxkhu3WyofLjjuF9GVJ5LkRPMg
         +v5LgT7v/4S8PCWOot5dIZIyLx1e61yAvWEqzhSkk+J1Tt2/Hl43HpxgxQOc1YRYxkfr
         Tyzd5snsUkgzv3+5KYymgdUZrevd/eMoN64C0LlB5eVegoY09Fb6KE7iPsB7HLB4Rv1Z
         daLjBaIX5rlzMu2voAQZCLsCrbfxLLI/gjY1O3XwtXTyZ9LS5faTaWLtIKwP5j73PQIJ
         iDl2kFNXBq9JErHiQSfIjVA30eAYKreW0/CbUvIXfq5EG7P2vu//KxNaIBCgl4gNNPYr
         qGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708471077; x=1709075877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrT4PFTPEBdVnQtB3JqEnMTnzuYVsnDN94ufDiP3ix8=;
        b=tz+ykf9/7BeaTkrL2D//GQ+VqOiubOufBg8BhP9F/LXPr/e7StHQuJ027XgJElaknJ
         pnPRlaaZxNfy6vWGU5U6m1OnizAVWvFzoxI3e+RN8LHbqTEiOcv9xkpzCylog0/hfxyy
         Jy+VCbjBIwmP3iMFr37lKGibPJ+aLaxYNxwFCTsvrvpe7uUeI9A+fy+OOrYHGy6//T+c
         B7GEAGIBDVmZkOI3ltA7SbTAV2fwMMT6ZvIIfkWhnv7Opdz7+3d6XxSts04A/sMbdOHA
         b5T42sYqZ+Gqki7PHqM7Pvduf5HRVaqdYku/v4inN2S8j9IiojTf4BidDKZn7yix1bM/
         mH4A==
X-Gm-Message-State: AOJu0Yw2qKkCFnZZ9DmgGnWSe0BvQQ3Z6eetJuTeCCMH/goYjezkUlS0
	/wWmJxBw95A+/f4SiUtRkl/MPz2bB8+jYBO5BS/EQ5p6qRmtOTch78Zlqa+V
X-Google-Smtp-Source: AGHT+IFKKyG86+3BcYGfCtYk4B+BIzlGb+TUrCSTONtmVN/+s7J3gVwj8UxkSRj+/w/58I5OyBVGAw==
X-Received: by 2002:a05:6a21:6315:b0:1a0:785c:58c2 with SMTP id wu21-20020a056a21631500b001a0785c58c2mr13278203pzb.61.1708471077457;
        Tue, 20 Feb 2024 15:17:57 -0800 (PST)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id x16-20020aa784d0000000b006e13a5ab1e5sm5317803pfn.73.2024.02.20.15.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 15:17:57 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 3/3] hugetlb: Allow faults to be handled under the VMA lock
Date: Tue, 20 Feb 2024 15:14:24 -0800
Message-ID: <20240220231424.126600-4-vishal.moola@gmail.com>
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
index 10f57306e1f0..ed472510699d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6376,12 +6376,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	int need_wait_lock = 0;
 	unsigned long haddr = address & huge_page_mask(h);
 
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


