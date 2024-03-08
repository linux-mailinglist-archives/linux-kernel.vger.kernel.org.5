Return-Path: <linux-kernel+bounces-96712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6402B87606A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CB31F24D4B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A570A52F6C;
	Fri,  8 Mar 2024 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZRpJ57s"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8255E225CF
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888228; cv=none; b=dDYumPcVlihvmaudHq8Za1rlNktop6Lvl4Q8HTrkhdvQW+ltTu1Z0SHvbtKCUSXVtI5d21RwG+5iqpSNqIsamVbkxODHoh5CDVKnUNtqb08nNM70z+ehiygptbYWl4goxHAxnptY3gqQzFl2xf7QplhgKZg36XWl8SGfv60H3kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888228; c=relaxed/simple;
	bh=PTJpqC36VIMAwhGjnaDPMxDA1KBBwil+aT1625574lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IUh+46oBEVcfKuSWQ8v80ut3Pp2UxcTLv7Bn9ootWEUgNzgJOCOgJE2bVg+IQ+R3Vo3oo425ry305reRb7Wd7mrIk96Akk4jZ1q599+C65CpQVBq/l3AiIf3xqPLVjBLHm+wjzPrRTRJUco7XYqNWhYbPnGcsLMRetWY1FV5pVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZRpJ57s; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d944e8f367so15526795ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 00:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709888227; x=1710493027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HnD0cp4DmVlF6OCB17KJ6M5uy70a7zM7SvCAKQx/WIc=;
        b=PZRpJ57sosjAFeNmMd8xgwOPnPa9qrJkQp6E0zFVM+1/Sb+qIVfFPpGKCkMIJAJuLW
         As4bBK0kiSd6hmlyeTyFOh0lJncnkyInViA5zue0mVHKyJWFnW7MrhKum2Q9mRlHSfht
         Qv2IwNRWiv8imFmhBfLRxogMu+fsyHtsAW4nBM46Bk7fBmGpBkUu4eJRliJNNyRln2Qg
         mcq+MD/QeTtTvreTaJKw6ZvsgLCwckuEOOAkrPpANrEJxx/6dwrdjXGygUqu5JiGZBnh
         25eRNu0jZvPnlt1bAFr+DtA7709xvlu42oTBVNr8qPML8d5Ryp/LlK2+O5msCjYjp3+p
         4BTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709888227; x=1710493027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnD0cp4DmVlF6OCB17KJ6M5uy70a7zM7SvCAKQx/WIc=;
        b=aolji7LBB4s82mlRgELMJuZPaQN08mZyuZCrpgqOuXhp5ycBt4Wahu48bjQxjjd0MQ
         rd1jjaADaamkO27fzhWbNUzZVru/dZrR8XSHjS3lAHTb6eYgvmRwe3JbIxnV4UFaqGVy
         19yWchfqQBJr6QRYMvXkwGyOA3ITf3syxVT8pZwiiaiuFDw+7Ds0yKyElRk1S8SQpmCj
         kq5vkv8k/Tf0lp5MqtllrCQIyLXXxg8P2pD+sp8Nq6C3V75lb14ArYVBW73B526AklDE
         3lMT+Epwi+jAVmJmwLD9mpYqZRyjubq6dQH4Dyaqj1m2uIMI3XaNLv4KoUqVUeZQsphi
         GeZw==
X-Forwarded-Encrypted: i=1; AJvYcCVT+biCh+il7IJgSh9V7h0rBOvCkYjcwC7lFQSmGaEd7SoZ1FpeVbSCrG4ME/Eh+rKZR3eiWsuUbWo0lLafGrpnoYnS4Z44Do7LDShJ
X-Gm-Message-State: AOJu0Yx1IMqP79yeB3JzPA9m6iXWSexn0AgwJE4lTcl/NVSRXEbUwEg7
	IH1fi3vbPbSZJx10ytcWTBEHQwnNblJQlFoTVl/za1fqAO7HLaOP
X-Google-Smtp-Source: AGHT+IHnYnGsKBEXeRr6fqKiSG7wnA+FFNHNLSUhzlakvHjpSLfIXu5EBe7jE+OUdYg937Eosmm8uw==
X-Received: by 2002:a17:902:eec6:b0:1dd:6211:e26 with SMTP id h6-20020a170902eec600b001dd62110e26mr2748179plb.15.1709888226610;
        Fri, 08 Mar 2024 00:57:06 -0800 (PST)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id z9-20020a170903018900b001dba2e99a9esm15867890plg.90.2024.03.08.00.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 00:57:06 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: minchan@kernel.org,
	fengwei.yin@intel.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	songmuchun@bytedance.com,
	wangkefeng.wang@huawei.com,
	xiehuan09@gmail.com,
	zokeefe@google.com,
	chrisl@kernel.org,
	yuzhao@google.com,
	Barry Song <v-songbaohua@oppo.com>,
	David Hildenbrand <david@redhat.com>,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH] mm: prohibit the last subpage from reusing the entire large folio
Date: Fri,  8 Mar 2024 21:56:53 +1300
Message-Id: <20240308085653.124180-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

In a Copy-on-Write (CoW) scenario, the last subpage will reuse the entire
large folio, resulting in the waste of (nr_pages - 1) pages. This wasted
memory remains allocated until it is either unmapped or memory
reclamation occurs.

The following small program can serve as evidence of this behavior

 main()
 {
 #define SIZE 1024 * 1024 * 1024UL
         void *p = malloc(SIZE);
         memset(p, 0x11, SIZE);
         if (fork() == 0)
                 _exit(0);
         memset(p, 0x12, SIZE);
         printf("done\n");
         while(1);
 }

For example, using a 1024KiB mTHP by:
 echo always > /sys/kernel/mm/transparent_hugepage/hugepages-1024kB/enabled

(1) w/o the patch, it takes 2GiB,

Before running the test program,
 / # free -m
                total        used        free      shared  buff/cache   available
 Mem:            5754          84        5692           0          17        5669
 Swap:              0           0           0

 / # /a.out &
 / # done

After running the test program,
 / # free -m
                 total        used        free      shared  buff/cache   available
 Mem:            5754        2149        3627           0          19        3605
 Swap:              0           0           0

(2) w/ the patch, it takes 1GiB only,

Before running the test program,
 / # free -m
                 total        used        free      shared  buff/cache   available
 Mem:            5754          89        5687           0          17        5664
 Swap:              0           0           0

 / # /a.out &
 / # done

After running the test program,
 / # free -m
                total        used        free      shared  buff/cache   available
 Mem:            5754        1122        4655           0          17        4632
 Swap:              0           0           0

This patch migrates the last subpage to a small folio and immediately
returns the large folio to the system. It benefits both memory availability
and anti-fragmentation.

Cc: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Lance Yang <ioworker0@gmail.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index e17669d4f72f..0200bfc15f94 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3523,6 +3523,14 @@ static bool wp_can_reuse_anon_folio(struct folio *folio,
 		folio_unlock(folio);
 		return false;
 	}
+	/*
+	 * If the last subpage reuses the entire large folio, it would
+	 * result in a waste of (nr_pages - 1) pages
+	 */
+	if (folio_ref_count(folio) == 1 && folio_test_large(folio)) {
+		folio_unlock(folio);
+		return false;
+	}
 	/*
 	 * Ok, we've got the only folio reference from our mapping
 	 * and the folio is locked, it's dark out, and we're wearing
-- 
2.34.1


