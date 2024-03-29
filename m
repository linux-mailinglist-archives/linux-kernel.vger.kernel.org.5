Return-Path: <linux-kernel+bounces-124252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2086B89146A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD551F22ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676DB41215;
	Fri, 29 Mar 2024 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKCxx4XL"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1B8405C6
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697894; cv=none; b=iryFtbKJKZ36xbuee027JopvXRCKhSsNP+rGvk5/aQew+bFx3BvkdfStYUHFDJOAD2sOkEDdx6JqH/c7WrZ8jxkB3rtGCZJ6kZ1mj8fsTMzdsczqq2QudDdmffgPFgVS9ctct70haEyItNvQTy2cTBMGpS7nSXQ0iI/Nlrxosq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697894; c=relaxed/simple;
	bh=FUlOMVV+kz2YMNGT63W3yd2gzTWaCE9vrvtG+jeCVEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A3GHlXmo81KYtOa0kFar3effNCeRTVnXyz7T03Xt0AUlbxead8xgGGVsCVMPDzHvyK76PSd95kvoqNAk73w7AmxJr6+zd43SBke5IhnmbxFnXirDdG8MmB8wV4A87sHprXiqTR02+SnTXf5pWtJHFDnJWolDFznRFMjkg2v1KsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKCxx4XL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e0bec01232so15430285ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 00:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711697892; x=1712302692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UH6LjJfXkA91u7B+LxuK1VjYI0jSAUD0s0KZGUYpa9s=;
        b=MKCxx4XLK8W5kJuZ7i2UBXqUzb3sk6xRwzuhZ8kgqZCGJXyaajPQiTYMewkAgYD+zT
         EIpeDyGsR5FS8n8IHFgyRpNqq0SKfj3hjuNETvFm0V2LJay2cC7X9j4abuANzJF9yl07
         lgvTeY3nBFtJZFQQVsvAqYwhmXoEC/qxNu/zZsy+QSgNZeqFwicbusx48iZQ8hnj1Lh4
         tSZsnDXySGj3ae7tQry06vNP79y0xSdEV/VFfgIirnf5Dys13BC4ozKoPOD8wlkitBUk
         bg6heR09KM9gvCN0pL24KpeWpQOD54n/IUOHSKy3zT/3sPHbBMVmeo+wwQDCU0h+eBR6
         qMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711697892; x=1712302692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UH6LjJfXkA91u7B+LxuK1VjYI0jSAUD0s0KZGUYpa9s=;
        b=ZHdS6F6l9NUeL+IvTsqarXlmjQ/AQwkLu2XMpM58yTvqZVd1N8dKcxCeZQUTGJb07W
         KR/fDoz1lUb0GdZ7vYMAzWNhcjvuy6dwqOsRSk+drYjr5HFV5s4RFE/iEim3/zdaJIbA
         KIJWub+ZWo/Z2CtljVDgN6Ow5Vk/22TPwhCU3ggjAfW1X5NFgQ6x1KkIjc9pqBOCp9ue
         qsCkhQ6dPUHKyhol382kQrLIHO0vl5Y6tclPOcndIR48RKkJxWNpZ3SSn4TUEVKv3bzw
         zpPULOlavDzvsYT7ksYsBqmhBp1aVcXVUkGSuqaUOZ9mxe4OuXvdQQuQeKzzP/HR9ScR
         y8Ww==
X-Gm-Message-State: AOJu0YwHH2utqJDplh3leJWLnJxdVUABdYv/IgxrSSkTMjA4Yse6cs8/
	NvfXwTMpUQsggXG5O47Zf435EfDmObw9yZp6DSItucw72Dt1Ctep44uCDEwWCpo=
X-Google-Smtp-Source: AGHT+IEHulJckipKHW1jh4cvk4Vt+Pdv4pdpJpi4h6lIXpXVb/IaR9agZUhqfR979Q95p2x2DSl7ug==
X-Received: by 2002:a17:902:f790:b0:1e0:93a:e681 with SMTP id q16-20020a170902f79000b001e0093ae681mr1833427pln.58.1711697892361;
        Fri, 29 Mar 2024 00:38:12 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f7c600b001e0b60dfe1bsm2844821plw.197.2024.03.29.00.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:38:12 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Rientjes <rientjes@google.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Itaru Kitayama <itaru.kitayama@gmail.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yang Shi <shy828301@gmail.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Yu Zhao <yuzhao@google.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH] mm: alloc_anon_folio: avoid doing vma_thp_gfp_mask in fallback cases
Date: Fri, 29 Mar 2024 20:37:50 +1300
Message-Id: <20240329073750.20012-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Fallback rates surpassing 90% have been observed on phones utilizing 64KiB
CONT-PTE mTHP. In these scenarios, when one out of every 16 PTEs fails
to allocate large folios, the remaining 15 PTEs fallback. Consequently,
invoking vma_thp_gfp_mask seems redundant in such cases. Furthermore,
abstaining from its use can also contribute to improved code readability.

Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Rientjes <rientjes@google.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Itaru Kitayama <itaru.kitayama@gmail.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index c9c1031c2ecb..010e7bb20d2b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4353,6 +4353,9 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 
 	pte_unmap(pte);
 
+	if (!orders)
+		goto fallback;
+
 	/* Try allocating the highest of the remaining orders. */
 	gfp = vma_thp_gfp_mask(vma);
 	while (orders) {
-- 
2.34.1


