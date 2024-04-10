Return-Path: <linux-kernel+bounces-139040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB33C89FDC2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A278E28BEC9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD3B17BB10;
	Wed, 10 Apr 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVGeG/Ex"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD100178CC3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768789; cv=none; b=Cv4/FRWrHpLErHMU/aC2elmxSxd5BlYX8CtLhtc3ruUp4LSrMGPuqUc+H41k2PAoYxafpoOV2yGtwNd/YTaQItdxCfZMu7rY/sDHVvynjJw1obP3N7OlHRHJmFSarWhq8bpDZKgXSwb+ymL+13JHwot6nb0l8Px8uLfcBFmYBXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768789; c=relaxed/simple;
	bh=3nM8zE8UKeAfNYBPcfNp2tnoOKSVOBu4iheL6OKfX1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e1q1lwIYpthzLj6c1go6F6FZJdkAI9wn1VH+XQYB0XomyqmAF5TTlGAKCetAgFokgiag0Kssj4U7kO7lVCCeOIkwC9Hmr+HYfJ8txKxzfQ83f9QM7jA6RRmzUQk4shEt+ZcAYFpiTs9FcnI57/dN1JjJ88DE6Ng/Od1dNAQ3Jgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jVGeG/Ex; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712768786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WEqgvwhAAzls4ErH8/osuK7rTIzstVDebZ900Wgu7zY=;
	b=jVGeG/ExGSyihzPpvYtBcMgz/LXSuap6qzNEhKAjSNUDRGD97O1rFuA0X5n15MmQblQ92x
	QAkyI4usvhTtNZmSwDUFWanLTubCAZxkuEmmMfh4oZ3neVwl8wMQg+IkPi5z42ilLcbofQ
	2x3xz3kSkkQUUudYmjHO5HanDTY6rGA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-j-8baX9-P4mDMm9b9Gu24g-1; Wed, 10 Apr 2024 13:06:25 -0400
X-MC-Unique: j-8baX9-P4mDMm9b9Gu24g-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-69b37bbded3so3545586d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712768785; x=1713373585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEqgvwhAAzls4ErH8/osuK7rTIzstVDebZ900Wgu7zY=;
        b=M+jt9z/gpWqyVY3EOJLrQIUL8J3Yr2bV6PLMdtOcIgKmqlRj+cBXpzKkvNxSTXYyud
         Dj4kMsZSvt1KbAttKgQDIxlpE2/TjbxzVkgfpUXvqtK3+J5KFs4wCzk7ZsU/WNqBKVvY
         ECWDykV+nk76d+t+3CxyjZnbEsCEuNZG9h5sphrwil7erIl7yUIymcYg+8NsfI+d4mR+
         3LedMIqC1lENUxltsnqpd7NzETBSSCQHN4GyDokxyMBmdlqOfrBibjyLAzLIlQWWzFIp
         RYbaVT48x+H+/scMZ8l3YueK3a/Lx7pYz4BgBxK3bXlqVAoq1TiupRb2wV444xxiSTrp
         ar4w==
X-Gm-Message-State: AOJu0YzHRw4netA/4hWYYmzLDECcAABVmJhZNvS2t0xXot/Jbitr6OvB
	E9sXI7QnVWAl8uh/+CmuqOxYTpehNSI6iTvQy6O+q+VpDuGPXZbqnZgw2ja2ESEoPyrP6RMvhQF
	PsnJGDMO4fWdmHl8dilqW0qVZ6/uu/IshlfY1JMXSfPcPTy5ZFG3pBeVFQ5Z7WJDSfPiYULGT73
	Eqq9X8sJw9qrh5tWZlsNG+VJ6j44jaZNXvG5Q07wTALvU=
X-Received: by 2002:a05:6214:d6a:b0:699:1907:7676 with SMTP id 10-20020a0562140d6a00b0069919077676mr3352862qvs.5.1712768784471;
        Wed, 10 Apr 2024 10:06:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRTPN2u1lI3LzFyPnWWbnzQkk1fo+PcFa8nRoXNuHB2BWBkwYg/viSYICcc2wh/uVZXRgS+A==
X-Received: by 2002:a05:6214:d6a:b0:699:1907:7676 with SMTP id 10-20020a0562140d6a00b0069919077676mr3352794qvs.5.1712768783582;
        Wed, 10 Apr 2024 10:06:23 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv15-20020ad44eef000000b0069b1dd6f141sm2956574qvb.137.2024.04.10.10.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 10:06:23 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: peterx@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Date: Wed, 10 Apr 2024 13:06:21 -0400
Message-ID: <20240410170621.2011171-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

anon_vma is a tricky object in the context of per-vma lock, because it's
racy to modify it in that context and mmap lock is needed if it's not
stable yet.

So far there are three places that sanity checks anon_vma for that:

  - lock_vma_under_rcu(): this is the major entrance of per-vma lock, where
    we have taken care of anon memory v.s. potential anon_vma allocations.

  - lock_vma(): even if it looks so generic as an API, it's only used in
    userfaultfd context to leverage per-vma locks.  It does extra check
    over MAP_PRIVATE file mappings for the same anon_vma issue.

  - vmf_anon_prepare(): it works for private file mapping faults just like
    what lock_vma() wanted to cover above.  One trivial difference is in
    some extremely corner case, the fault handler will still allow per-vma
    fault to happen, like a READ on a privately mapped file.

The question is whether that's intended to make it as complicated.  Per my
question in the thread, it is not intended, and Suren also seems to agree [1].

So the trivial side effect of such patch is:

  - We may do slightly better on the first WRITE of a private file mapping,
  because we can retry earlier (in lock_vma_under_rcu(), rather than
  vmf_anon_prepare() later).

  - We may always use mmap lock for the initial READs on a private file
  mappings, while before this patch it _can_ (only when no WRITE ever
  happened... but it doesn't make much sense for a MAP_PRIVATE..) do the
  read fault with per-vma lock.

Then noted that right after any WRITE the anon_vma will be stablized, then
there will be no difference.  And I believe that should be the majority
cases too; I also did try to run a program, writting to MAP_PRIVATE file
memory (that I pre-headed in the page cache) and I can hardly measure a
difference in performance.

Let's simply ignore all those trivial corner cases and unify the anon_vma
check from three places into one.  I also didn't check the rest users of
lock_vma_under_rcu(), where in a !fault context it could even fix something
that used to race with private file mappings but I didn't check further.

I still left a WARN_ON_ONCE() in vmf_anon_prepare() to double check we're
all good.

[1] https://lore.kernel.org/r/CAJuCfpGj5xk-NxSwW6Mt8NGZcV9N__8zVPMGXDPAYKMcN9=Oig@mail.gmail.com

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c      | 10 ++++------
 mm/userfaultfd.c | 13 ++-----------
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 78422d1c7381..4e2a9c4d9776 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3219,10 +3219,8 @@ vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
 
 	if (likely(vma->anon_vma))
 		return 0;
-	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
-		vma_end_read(vma);
-		return VM_FAULT_RETRY;
-	}
+	/* We shouldn't try a per-vma fault at all if anon_vma isn't solid */
+	WARN_ON_ONCE(vmf->flags & FAULT_FLAG_VMA_LOCK);
 	if (__anon_vma_prepare(vma))
 		return VM_FAULT_OOM;
 	return 0;
@@ -5826,9 +5824,9 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	 * find_mergeable_anon_vma uses adjacent vmas which are not locked.
 	 * This check must happen after vma_start_read(); otherwise, a
 	 * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the VMA
-	 * from its anon_vma.
+	 * from its anon_vma.  This applies to both anon or private file maps.
 	 */
-	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
+	if (unlikely(!(vma->vm_flags & VM_SHARED) && !vma->anon_vma))
 		goto inval_end_read;
 
 	/* Check since vm_start/vm_end might change before we lock the VMA */
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index f6267afe65d1..61f21da77dcd 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -72,17 +72,8 @@ static struct vm_area_struct *lock_vma(struct mm_struct *mm,
 	struct vm_area_struct *vma;
 
 	vma = lock_vma_under_rcu(mm, address);
-	if (vma) {
-		/*
-		 * lock_vma_under_rcu() only checks anon_vma for private
-		 * anonymous mappings. But we need to ensure it is assigned in
-		 * private file-backed vmas as well.
-		 */
-		if (!(vma->vm_flags & VM_SHARED) && unlikely(!vma->anon_vma))
-			vma_end_read(vma);
-		else
-			return vma;
-	}
+	if (vma)
+		return vma;
 
 	mmap_read_lock(mm);
 	vma = find_vma_and_prepare_anon(mm, address);
-- 
2.44.0


