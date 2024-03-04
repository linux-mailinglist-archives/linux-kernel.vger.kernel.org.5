Return-Path: <linux-kernel+bounces-90479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BFC86FFCF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CBD1C21E44
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ADD39AE4;
	Mon,  4 Mar 2024 11:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HUJMnwTC"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E990E381D0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550498; cv=none; b=nw5AQqMwBKAfS3HnlqlBra3xUWDGPhIY5LfAnbr/giY/IfvLFeCkm4t/1qgU6VDMv9Vi4dLgw/ZjLaLgofc6IgOQWsfGoBzFKwC9ancF/XTDxE2xvlkDOuDzuSXUg3GvU2/1WzoywQ4/hTbCBm6kB2q7uYo6hA7zqcSyJ//9jA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550498; c=relaxed/simple;
	bh=iQTB6iQcjXpyDrCxjESHbO+MDvnl4uA6D+rBQbS5g3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TGJnldvhYEX/71UCphqYn7o02vi+YPtdKp8Y3K2ag1qf6eUnqFJQ6AOUz58TUxGhpjxQkHJefdid1MICNt1cxklIRW1/o2wxrPJSP44OcZ+UEhNqWpkNX6oEZG6ypCMsy7pXJVMKmiB9MhP4XC+P3J0MQiyvPlGgI/0jpF9wzAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HUJMnwTC; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29ae0d292d4so470999a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 03:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709550496; x=1710155296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVpQb6gnXjWzSd7/4z2SbTtHslRCQp5WpZHkGdzmg3w=;
        b=HUJMnwTCyumRywqDrU5UBrgdmEZUoBETQ/jS3HvXCWvNXm+urLZZ5E8d0rDDZKaK2P
         W2EpwvVboehbvIaxs9ekD3IV+FTds5/PhGN5sn7eBC7j5DSl4Qu3hdumRETNIsnhJpSZ
         z3yZobtifa9TR32NaTqs/GXYHGQGh0zgqxUZmz1CAVOYhcQ6UEhJAcE0m0CDDkEjEznr
         QUwAIJrrzG/C/rab2H+xN+KJ9MShN5vWyqjI9bQEc1DZloBvgv81S8GRQyUnKAQZWZXI
         oYhbF+7bNQoj3xGwaYbjjf28ysg2MzGCy5UZdxcPekmLApGHyj2GboVF0SS1fEd5kTTa
         +M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709550496; x=1710155296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVpQb6gnXjWzSd7/4z2SbTtHslRCQp5WpZHkGdzmg3w=;
        b=dv2P5T2sQ7Y0T3pFEjbbI405EHqgtG2DbCVmagblCg2o54v19OBxvmKkfNZdIOGFVP
         L2SYIfhLLILOLYeXKvwOTK8YWjOtEpsGCAQW4J+XB3IqUJxX+TwarIbaL07rHvX/+z70
         sVsQYjTFZ9RBQElhxsroNHyKmgZlU9siNcPFopIrl6OuLZ6Ro9++rz3xYiC+vxpRP8MX
         0PdsiwsM8a7kBhJdY1XvUCgiGl46yH7y7eESyhbJ6rup+pHECuWnnOhpulBr9m2xztel
         OtXidDMyuVCBUk2vaWK0QmfCoM9+vmiHOSoEBy+MePMDVVutQkAH9i8Jr5kuQm42GTqQ
         IbCA==
X-Forwarded-Encrypted: i=1; AJvYcCV4axub0CbitOoTJjg/cE8yNrrj5MCHBjhPTv9DYPILhnaj1+eUd6SS8T+udNIVVbzXtWVN/WfU4FwGIXDDLmIdqcS2z54KjN3y9azp
X-Gm-Message-State: AOJu0YyUrEKwu60O1ruoWoq2JXVSG+rB0ct9hUi+jn62RvDyCp8ajwOJ
	h0Clf2R8OrNHHpzetbPq4r3zDnHFb+xoshMomDTWLMW18JAtaeSysHeTqM8K7Hg=
X-Google-Smtp-Source: AGHT+IFSfl5xFUSoidYT+0L1kpEdhILm//TZZr/lpxpdHBQlvBKsRDyghgFJOAi+dVG4ZEhfPEedDw==
X-Received: by 2002:a17:90a:804c:b0:299:dddb:3a92 with SMTP id e12-20020a17090a804c00b00299dddb3a92mr6941943pjw.1.1709550496198;
        Mon, 04 Mar 2024 03:08:16 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.154])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090aca8500b0029b59bf77b4sm587410pjt.42.2024.03.04.03.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 03:08:15 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: akpm@linux-foundation.org,
	vishal.moola@gmail.com,
	hughd@google.com,
	david@redhat.com,
	rppt@kernel.org,
	willy@infradead.org,
	muchun.song@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 2/3] mm: pgtable: add missing pt_index to struct ptdesc
Date: Mon,  4 Mar 2024 19:07:19 +0800
Message-Id: <283624c2af45fb2090b41a6b1b5481bb0a45bad7.1709541697.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1709541697.git.zhengqi.arch@bytedance.com>
References: <cover.1709541697.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In s390, the page->index field is used for gmap (see gmap_shadow_pgt()),
so add the corresponding pt_index to struct ptdesc and add a comment to
clarify this.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm_types.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5ea77969daae..5240bd7bca33 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -425,6 +425,7 @@ FOLIO_MATCH(compound_head, _head_2a);
  * @_pt_pad_1:        Padding that aliases with page's compound head.
  * @pmd_huge_pte:     Protected by ptdesc->ptl, used for THPs.
  * @__page_mapping:   Aliases with page->mapping. Unused for page tables.
+ * @pt_index:         Used for s390 gmap.
  * @pt_mm:            Used for x86 pgds.
  * @pt_frag_refcount: For fragmented page table tracking. Powerpc only.
  * @_pt_pad_2:        Padding to ensure proper alignment.
@@ -450,6 +451,7 @@ struct ptdesc {
 	unsigned long __page_mapping;
 
 	union {
+		pgoff_t pt_index;
 		struct mm_struct *pt_mm;
 		atomic_t pt_frag_refcount;
 	};
@@ -475,6 +477,7 @@ TABLE_MATCH(flags, __page_flags);
 TABLE_MATCH(compound_head, pt_list);
 TABLE_MATCH(compound_head, _pt_pad_1);
 TABLE_MATCH(mapping, __page_mapping);
+TABLE_MATCH(index, pt_index);
 TABLE_MATCH(rcu_head, pt_rcu_head);
 TABLE_MATCH(page_type, __page_type);
 TABLE_MATCH(_refcount, __page_refcount);
-- 
2.30.2


