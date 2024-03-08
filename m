Return-Path: <linux-kernel+bounces-96744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9FD8760E8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8210D2830E7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FEF53399;
	Fri,  8 Mar 2024 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRYIluMh"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0808C537E1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890060; cv=none; b=oQMWklJ8sAcHJk+X0llvUYsEH2kTzucOSybmACHwi++48Xky+YB2ZG7JhpoDA5V5GZkAKnRC55T17KOE+27tcGWLZuuJGai1Z27c37OJuzbFf/OeqErVU5VcEHwy6UQO5+M1HjuxXkvBlKpPYjF5V7CZ3jLIrQvm6fimrp/0QBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890060; c=relaxed/simple;
	bh=48kGOhkbhAoYFgvTIPEDicphWR/Yw55TT4SEVhbfH18=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lwP5L0ojWriVT3vFBJXQBDRK0jtC/z/YLv3pPYKrxruwif+/fhonDSXT9D2jNX7abxLHZk3gSDZPjVgLursVF8UhbzWArPBdGhzCB4vTkrlsFUNnDZZp7LFZ2E51FIrwbnGJOhN65rsxzZoJ7iVOYH0rg2zRX7W0QNAujlJX8AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRYIluMh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dcd6a3da83so12872815ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 01:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709890058; x=1710494858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ROBScL3zNq1ROLO+Gfcm3K4UycGbv1h+36uGZvQyywk=;
        b=WRYIluMhTOa8cGTEWLA+1NFpNa4MYNWZMJk0jxiqZSOg9LmWQeuUwQh8tnsUg1XYLX
         4epLdh+JY9G3SRUSomqO0OYWUE2j9A4zvMAGZJcW1A9wtwhS5XZAATXzxzdqJF6NJ0so
         05EnS1xZU4ckG1hb7ZSxIRDSR8KfvD6G6cfG8gDROSqdAzt0gylbRnt1oSzqfARUEQsM
         g3O5oSZoadVdQxPaA2x2nwoTqk1D7f+sItBPs1mFCIge6VVB3YDVrckkcirHv4JldnhY
         MU2G6A6p83aafYxfKIxhHJGbjqxHKxM/oUIsmoxTZYXFLWbapJjTEYNFnbsfQc2qupX3
         FbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709890058; x=1710494858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ROBScL3zNq1ROLO+Gfcm3K4UycGbv1h+36uGZvQyywk=;
        b=U9sigpqh7ligwDSUxWP3z1uitiVu9ANbS3HefDx8x4BKbgmzwuGIxIhOakR2p5E0ng
         vNUdlF2OD/1248z2yz2gloOTMqeFGYw7fqB5F8QyNL/gk77LQFtUkicc4ukLnNcofvHE
         1vTQB4rQfaDhl77kBmsSEI8n4InrA9fkfambA2daQXQ4bqXKz1ip5yJVTuQAVlAPu6EJ
         Qmp9wAMwshCsdTjaeGEeUQjEQ0tQBTrJQnbfM3tRBFFrcKwbvEUcc/obHZ6hDRj3OnQN
         /hTkWRmpb9b+VzoQP3CXGP7VjRQ+5kEt2YYzyfyzHOxdOTVc/OizujQ28jHJbuu3g2DE
         J6rQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8woFXDRALTSk7rdDb3msEriJFVQd/tKm8yv7YUvx7aBa9QhEpKZaIdm6mWZ3YcIbQKyZD5G68VRg3ZL2JZp2VBjXEY599hfg6U+i4
X-Gm-Message-State: AOJu0Yw6A1ADV/SZJ4GVY2D+r+dMHxlVA4aeWhZmlR5gEyN+8dp5+9DE
	QWGYs9idXAp9x/GfEisSZ3BbaYtEGVwY41dpNHgSsvBweItJoP83
X-Google-Smtp-Source: AGHT+IGHwvDaRFM6AdGoHqI0EnKeNjpmwOATRfsUIVKV0DDSC98WZUboWqg2XZop7gHcvnNI7NdvbA==
X-Received: by 2002:a17:903:2309:b0:1dc:cc01:7488 with SMTP id d9-20020a170903230900b001dccc017488mr13902041plh.25.1709890058085;
        Fri, 08 Mar 2024 01:27:38 -0800 (PST)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b001dccff4287csm16129557pln.202.2024.03.08.01.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 01:27:37 -0800 (PST)
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
Subject: [PATCH v2] mm: prohibit the last subpage from reusing the entire large folio
Date: Fri,  8 Mar 2024 22:27:21 +1300
Message-Id: <20240308092721.144735-1-21cnbao@gmail.com>
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
 -v2:
  * return at the 1st beginning for a large folio according to David's comment,
    thanks!
 -v1:
 https://lore.kernel.org/linux-mm/20240308085653.124180-1-21cnbao@gmail.com/

 mm/memory.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index e17669d4f72f..f2bc6dd15eb8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3498,6 +3498,16 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf, struct folio *folio)
 static bool wp_can_reuse_anon_folio(struct folio *folio,
 				    struct vm_area_struct *vma)
 {
+	/*
+	 * We could currently only reuse a subpage of a large folio if no
+	 * other subpages of the large folios are still mapped. However,
+	 * let's just consistently not reuse subpages even if we could
+	 * reuse in that scenario, and give back a large folio a bit
+	 * sooner.
+	 */
+	if (folio_test_large(folio))
+		return false;
+
 	/*
 	 * We have to verify under folio lock: these early checks are
 	 * just an optimization to avoid locking the folio and freeing
-- 
2.34.1


