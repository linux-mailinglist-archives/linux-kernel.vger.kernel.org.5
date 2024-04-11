Return-Path: <linux-kernel+bounces-141614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DA08A20B4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E03288D3A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC773B182;
	Thu, 11 Apr 2024 21:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkTWIp7q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288961E86C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869931; cv=none; b=LxF1bwCUL6/7vuU3bt2yFVRqjDROmVmAUEAsMFTj1xtScRMzKqdtbGUk/Yx316c4bdWy2wrPWj1gkwtJvN8/l7fIYTSZt6sXi4A61o9qYbgre55rLL2wBCj3trxlFUGUClt7etkQV5HFrp9JzgnOF0jPQz5XiPerlb/BCakrLK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869931; c=relaxed/simple;
	bh=HLUt01dpujFD5Zm/bcFagcCd1Bjz7kbWy8bUEjkQOTo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZWOMjN7gc//YA0uS64P7x0uEZvVahcwOgoGLBkxF5kf6cuEqtXReovHLGNryYZlRL+Vh7jncoCwzy3scWHove8ypjYZ+eVVpJfone3uPZDW9yL/7dlCjaeu4Z8iDPvWsj6JO8epd6FWH0mTdXqnK5uFXibaIPubUKTX/tmZoF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkTWIp7q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712869927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KD10ErDcqiA3oY/5LADddUIUOe6QeTWo+ixtSrVoYkU=;
	b=bkTWIp7qf7CxiPxVRiSebYM1yAaasjessxM/52H8XMBuUZ568uyn4iQnsayBRbNuhTP8uS
	dIRPYyBkY3g3bZUfpstFbUC5XFrhx5Du2Pm5PEFqs+eGvJgqAKGu07SdsyPkg6HmlU/P/r
	OEWaKbq7pRb2TU/GJznSCflu0430iHQ=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-3JnmxPlXNk6u7vnVj_Qv_Q-1; Thu, 11 Apr 2024 17:12:06 -0400
X-MC-Unique: 3JnmxPlXNk6u7vnVj_Qv_Q-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-61853333c00so668417b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712869926; x=1713474726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KD10ErDcqiA3oY/5LADddUIUOe6QeTWo+ixtSrVoYkU=;
        b=ExZYIMazsv3fqpFnMrM+uK4GKSO3YJGQnoVUlO8dQLQ8o2Glz2v1OfHdQbjO1ypZFe
         gijqaTBv/6pi+7oseToF5/ahtfihf2RO9CB2zI8XYp7DH7jA+FvLmlGUNixoUkSNn/kR
         3EA8Upe9mKTFAXU+UFH6l8TMB4twZ3s4XvBjP6Q+wceSY4qbBm9EguWcIUJ6TaUSukS6
         h4gVfwMpKMxKitqg2R+0cqHkjH3G4YfAbvQRzYQur/nlS+iJcMrVDUr55Tkb97x94A30
         1IDrf8/dj8ztyD29kJvBxJB6TuRm31JdRxaz+2fm7UY4YwhsyLouN4UnFtTKhb8g+YDr
         CqxA==
X-Forwarded-Encrypted: i=1; AJvYcCVErkrXscyQQdC24u9hpRPY6vKFN5PxLXIyNpaJ5CZHHf3+0PjMXtqMJMR5C7h/Utzb1UmZSgMPgxBjpejfjcxynkwnQvqMoBSBR9Fb
X-Gm-Message-State: AOJu0YwTvG7GmtbuH78YDhc7mchGpiPOM4iL32MMqjE10lbMvkpVaBtI
	h1/XbsRGG59h4fdi0RdDBTqrjmUuxI3cQr5Z/T7c0SK/v4TQKsYkX9eYdvuaqDpbb1SwJm4FO0k
	AzJgKpDWziz2onnMrKNB4TRYrwQA5SIUxuFLd1UVgYZz2tUklmm6Re7c6bpcyOA==
X-Received: by 2002:a0d:d817:0:b0:60a:55b7:8e6b with SMTP id a23-20020a0dd817000000b0060a55b78e6bmr583849ywe.1.1712869925458;
        Thu, 11 Apr 2024 14:12:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhhBRL4tuZTHXE186N6T2CHnBWNzkbnZImnEEjATs4knvQ7ufekChnMuHJEj55Ref52L4bPQ==
X-Received: by 2002:a0d:d817:0:b0:60a:55b7:8e6b with SMTP id a23-20020a0dd817000000b0060a55b78e6bmr583820ywe.1.1712869924795;
        Thu, 11 Apr 2024 14:12:04 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id q18-20020a0cfa12000000b0069b2392fe65sm1402954qvn.83.2024.04.11.14.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 14:12:04 -0700 (PDT)
Date: Thu, 11 Apr 2024 17:12:02 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH] mm: Always sanity check anon_vma first for per-vma locks
Message-ID: <ZhhSItiyLYBEdAX3@x1n>
References: <20240410170621.2011171-1-peterx@redhat.com>
 <20240411171319.almhz23xulg4f7op@revolver>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240411171319.almhz23xulg4f7op@revolver>

Hey, Liam,

Thanks a lot for the comments.

On Thu, Apr 11, 2024 at 01:13:19PM -0400, Liam R. Howlett wrote:
> * Peter Xu <peterx@redhat.com> [240410 13:06]:
> > anon_vma is a tricky object in the context of per-vma lock, because it's
> > racy to modify it in that context and mmap lock is needed if it's not
> > stable yet.
> 
> How is it racy in your view?  There isn't a way to get in a situation
> where its state isn't certain, is there?

My apologies on these confusing wordings.  AFAICT we're on the same page
all over the place on this matter, so I will amend these wordings if I'll
repost, and skip many of below comments if I'm confident we're aligned on
the understandings.

And actually, I'll already attach one new version that should remove all
bad side effects, but hopefully only bring good ones, see below.

> 
> > 
> > So far there are three places that sanity checks anon_vma for that:
> > 
> >   - lock_vma_under_rcu(): this is the major entrance of per-vma lock, where
> >     we have taken care of anon memory v.s. potential anon_vma allocations.
> 
> Well, not exactly.  Single vma faults vs potential modifications beyond
> one vma (including uses of adjacent vmas with anon_vmas)

(this is also the wording issue; I'll fix it)

> 
> > 
> >   - lock_vma(): even if it looks so generic as an API, it's only used in
> >     userfaultfd context to leverage per-vma locks.  It does extra check
> >     over MAP_PRIVATE file mappings for the same anon_vma issue.
> 
> This static function is in mm/userfaultfd so, yes, it's not generic -
> the name is generic, but I didn't see a reason to hold up the patch for
> a static name that is descriptive.  It's static so I'm not concerned
> about usage growing.
> 
> I would expect such a check will eventually need to be moved to common
> code, and then potentially change the name to something more
> descriptive.  This seems premature with a single user though.
> 
> > 
> >   - vmf_anon_prepare(): it works for private file mapping faults just like
> >     what lock_vma() wanted to cover above.  One trivial difference is in
> >     some extremely corner case, the fault handler will still allow per-vma
> >     fault to happen, like a READ on a privately mapped file.
> 
> What is happening here is that we are detecting when the virtual memory
> space is stable vs when the vma is stable.  In some cases, when we need
> to check prev/next, then we need to make sure the virtual memory space
> is stable.  In other cases, the vma is all that matters to the operation
> and so we can continue without stopping anyone else from modifying the
> virtual memory space - that is, we are allowing writes in other areas.
> 
> > 
> > The question is whether that's intended to make it as complicated.  Per my
> > question in the thread, it is not intended, and Suren also seems to agree [1].
> > 
> > So the trivial side effect of such patch is:
> > 
> >   - We may do slightly better on the first WRITE of a private file mapping,
> >   because we can retry earlier (in lock_vma_under_rcu(), rather than
> >   vmf_anon_prepare() later).
> > 
> >   - We may always use mmap lock for the initial READs on a private file
> >   mappings, while before this patch it _can_ (only when no WRITE ever
> >   happened... but it doesn't make much sense for a MAP_PRIVATE..) do the
> >   read fault with per-vma lock.
> > 
> > Then noted that right after any WRITE the anon_vma will be stablized, then
> > there will be no difference.
> 
> In my view, the anon_vma is always stable.  During a write it is
> initialised.
> 
> >And I believe that should be the majority
> > cases too; I also did try to run a program, writting to MAP_PRIVATE file
> > memory (that I pre-headed in the page cache) and I can hardly measure a
> > difference in performance.
> > 
> > Let's simply ignore all those trivial corner cases and unify the anon_vma
> > check from three places into one.  I also didn't check the rest users of
> > lock_vma_under_rcu(), where in a !fault context it could even fix something
> > that used to race with private file mappings but I didn't check further.
> 
> This change will increase mmap semaphore contention.  I'd like to move
> to a more common structured layout, but I think we need to find a way to
> do this without failing the lock_vma_under_rcu() more frequently.  In
> fact, we need to be looking for ways to make it fail less.
> 
> The UFFD code is more strict on what is acceptable for a per-vma lock
> [1].  This user has a restriction that will decrease the benefits of the
> per-vma lock, but we shouldn't make this case the common one.
> 
> As I'm sure you are aware, the page fault path is the most common path
> for using per-vma locks and should minimize taking the mmap lock as much
> as possible.
> 
> I don't think we should increase the lock contention to simplify the
> code.

Right.  I believe the major issue right now with this patch is that it can
reduce some performance, I didn't worry on that, but it seems that's a
concern to many already.  It could be that I am just too bold on such
attempt.

However note that what I want to do (put all anon_vma magic together)
should be orthogonal issue v.s. above perf degrade.  So please feel free to
have a look at below, I believe it won't degrade anything, but afaiu it
should speed up two things even if only trivially:

  - The WRITE on private file mapping will now retry earlier than before
  - The READ on anon zero pages will now allow per-vma lock

Neither of above will be allowed without below patch.  And below patch
should also put all anon_vma checks together.

I didn't even compile test it yet, but let me send it out first to see
whether any of you has any comments, so take it as super-rfc versions.

Note that I attached patch 1 on a hugetlb change, that'll be needed by
patch 2 otherwise we can hit issue with hugetlb private mappings.  However
patch 1 alone will need some justifications too, but IMHO we can ignore it
for now and just look at patch 2.  I attached patch 1 just in case it's
good to reference.

Thanks,

===8<===
From fed3c10ef87a9614a328edbfd7d4b7047d3f5e57 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 11 Apr 2024 16:23:50 -0400
Subject: [PATCH 1/2] mm/hugetlb: Match behavior on read-only private mappings

The default behavior for reading a private file mapping should fill in the
page cache and map the page read-only.  Hugetlb didn't do like it.  Make it
behave the same.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a8536349de13..bc3c97c476d2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6199,6 +6199,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	struct folio *folio;
 	pte_t new_pte;
 	bool new_folio, new_pagecache_folio = false;
+	bool is_write = vmf->flags & FAULT_FLAG_WRITE;
 	u32 hash = hugetlb_fault_mutex_hash(mapping, vmf->pgoff);
 
 	/*
@@ -6276,7 +6277,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 		__folio_mark_uptodate(folio);
 		new_folio = true;
 
-		if (vma->vm_flags & VM_MAYSHARE) {
+		if (!is_write || vma->vm_flags & VM_MAYSHARE) {
 			int err = hugetlb_add_to_page_cache(folio, mapping,
 							vmf->pgoff);
 			if (err) {
@@ -6294,6 +6295,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 			}
 			new_pagecache_folio = true;
 		} else {
+			/* Write on a private mapping */
 			folio_lock(folio);
 
 			ret = vmf_anon_prepare(vmf);
@@ -6333,7 +6335,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	 * any allocations necessary to record that reservation occur outside
 	 * the spinlock.
 	 */
-	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
+	if (is_write && !(vma->vm_flags & VM_SHARED)) {
 		if (vma_needs_reservation(h, vma, vmf->address) < 0) {
 			ret = VM_FAULT_OOM;
 			goto backout_unlocked;
-- 
2.44.0

From b9b57fb580992115ae1258fc1ecd8586a5bd70d2 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 4 Apr 2024 16:05:55 -0400
Subject: [PATCH 2/2] mm: Always sanity check anon_vma first for per-vma locks

anon_vma is a tricky object in the context of per-vma lock, because
sometimes it is required later for mapping the pages, while it's not safe
to prepare anon_vma with per-vma lock due to the fact that we can try to
access anon_vma of adjacent VMAs, which we don't yet hold any lock.

So far there are three places that per-vma lock will check against the
existance of anon_vma for that:

  1) lock_vma_under_rcu(): this is the major entrance of per-vma lock,
  where we have taken care of anon memory.

  2) lock_vma(): even if it looks so generic as an API, it's only used in
  userfaultfd context to leverage per-vma locks.  It does extra check over
  MAP_PRIVATE file mappings for the same anon_vma issue.  Note that this
  only applies to the dest vma not src vma, as we don't ask for src vma's
  anon_vma even if it should just present regardless.

  3) vmf_anon_prepare(): it works for private file mapping faults just like
  what lock_vma() wanted to cover above.  However this check is done only
  afterwards deeper in the fault stack.

The question is whether that's intended to make it as complicated.  For
example, why don't we check anon_vma for anonymous too later when prepare
anon_vma, however we do it late for file memory.  AFAICT there's nothing
special with file memory in this case.

To unify anon_vma checks, do it always right after we get the per-vma lock.
We should have enough information already at this point, and it doesn't
need to be postponed for file-only.  The only missing information here is
whether the caller of the per-vma rcu lock will install a writable mapping
or not.  That info is passed into lock_vma_under_rcu() with a boolean now.

So the trivial (all good) side effect of such patch is:

  - We may do slightly better on the first WRITE of a private file mapping,
  because we can retry earlier (in lock_vma_under_rcu(), rather than
  vmf_anon_prepare() later).

  - We may start to allow per-vma page faults on zero pages even for
  anonymous.  While prior to this patch we don't allow that to happen even
  if installation of zero page does not require anon_vma's existance.

I still left a WARN_ON_ONCE() in vmf_anon_prepare() to double check we're
all good.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm/mm/fault.c     |  2 +-
 arch/arm64/mm/fault.c   |  2 +-
 arch/powerpc/mm/fault.c |  2 +-
 arch/riscv/mm/fault.c   |  2 +-
 arch/s390/mm/fault.c    |  2 +-
 arch/x86/mm/fault.c     |  2 +-
 include/linux/mm.h      |  7 ++++---
 mm/memory.c             | 46 +++++++++++++++++++++++++++++++----------
 mm/userfaultfd.c        | 21 +++++++------------
 net/ipv4/tcp.c          |  3 ++-
 10 files changed, 55 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 5c4b417e24f9..20c21ecec25c 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -288,7 +288,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
-	vma = lock_vma_under_rcu(mm, addr);
+	vma = lock_vma_under_rcu(mm, addr, flags & FAULT_FLAG_WRITE);
 	if (!vma)
 		goto lock_mmap;
 
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 405f9aa831bd..4be946ca80bd 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -566,7 +566,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	if (!(mm_flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
-	vma = lock_vma_under_rcu(mm, addr);
+	vma = lock_vma_under_rcu(mm, addr, flags & FAULT_FLAG_WRITE);
 	if (!vma)
 		goto lock_mmap;
 
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 215690452495..7a2adf40d65d 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -480,7 +480,7 @@ static int ___do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
-	vma = lock_vma_under_rcu(mm, address);
+	vma = lock_vma_under_rcu(mm, addrress, is_write);
 	if (!vma)
 		goto lock_mmap;
 
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 5224f3733802..17d8b011105e 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -286,7 +286,7 @@ void handle_page_fault(struct pt_regs *regs)
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
-	vma = lock_vma_under_rcu(mm, addr);
+	vma = lock_vma_under_rcu(mm, addr, flags & FAULT_FLAG_WRITE);
 	if (!vma)
 		goto lock_mmap;
 
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 162ca2576fd4..8b53eefb947a 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -320,7 +320,7 @@ static void do_exception(struct pt_regs *regs, int access)
 		flags |= FAULT_FLAG_WRITE;
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
-	vma = lock_vma_under_rcu(mm, address);
+	vma = lock_vma_under_rcu(mm, address, is_write);
 	if (!vma)
 		goto lock_mmap;
 	if (!(vma->vm_flags & access)) {
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 67b18adc75dd..2cf38befaf45 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1356,7 +1356,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 	if (!(flags & FAULT_FLAG_USER))
 		goto lock_mmap;
 
-	vma = lock_vma_under_rcu(mm, address);
+	vma = lock_vma_under_rcu(mm, address, flags & FAULT_FLAG_WRITE);
 	if (!vma)
 		goto lock_mmap;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 07c73451d42f..b3a088ce584d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -777,7 +777,8 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
 }
 
 struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
-					  unsigned long address);
+					  unsigned long address,
+					  bool writable);
 
 #else /* CONFIG_PER_VMA_LOCK */
 
@@ -790,8 +791,8 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 static inline void vma_mark_detached(struct vm_area_struct *vma,
 				     bool detached) {}
 
-static inline struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
-		unsigned long address)
+static inline struct vm_area_struct *lock_vma_under_rcu(
+    struct mm_struct *mm, unsigned long address, bool writable)
 {
 	return NULL;
 }
diff --git a/mm/memory.c b/mm/memory.c
index b6fa5146b260..e8168ebc8095 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3218,10 +3218,8 @@ vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
 
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
@@ -5842,13 +5840,38 @@ struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
 #endif
 
 #ifdef CONFIG_PER_VMA_LOCK
-/*
- * Lookup and lock a VMA under RCU protection. Returned VMA is guaranteed to be
- * stable and not isolated. If the VMA is not found or is being modified the
- * function returns NULL.
+
+bool vma_needs_stable_anon_vma(struct vm_area_struct *vma, bool writable)
+{
+	/*
+	 * If to install a read-only mapping, we should never need an
+	 * anon_vma later.  For anon, it should be the zero page.  For
+	 * file, it normally should be a page cache except special mappings
+	 * (e.g. tcp zerocopy provides its own read-only pages).
+	 */
+	if (!writable)
+		return false;
+
+	/* Anonymous writable mappings always will ask for anon_vma */
+	if (vma_is_anonymous(vma))
+		return true;
+
+	/* For file memory, only need anon_vma if it's private */
+	return !(vma->vm_flags & VM_SHARED);
+}
+
+/**
+ * @lock_vma_under_rcu() - Lookup and lock a VMA under RCU protection.
+ * @mm: target mm struct
+ * @address: target virtual address
+ * @writable: whether we may inject a writable mapping with the VMA
+ *
+ * Returned VMA is guaranteed to be stable and not isolated. If the VMA is
+ * not found or is being modified the function returns NULL.
  */
 struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
-					  unsigned long address)
+					  unsigned long address,
+					  bool writable)
 {
 	MA_STATE(mas, &mm->mm_mt, address, address);
 	struct vm_area_struct *vma;
@@ -5866,9 +5889,10 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	 * find_mergeable_anon_vma uses adjacent vmas which are not locked.
 	 * This check must happen after vma_start_read(); otherwise, a
 	 * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the VMA
-	 * from its anon_vma.
+	 * from its anon_vma.  This applies to both anon or private file maps.
 	 */
-	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
+	if (unlikely(vma_needs_stable_anon_vma(vma, writable) &&
+		     !vma->anon_vma))
 		goto inval_end_read;
 
 	/* Check since vm_start/vm_end might change before we lock the VMA */
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index f6267afe65d1..b518c111e37a 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -71,18 +71,10 @@ static struct vm_area_struct *lock_vma(struct mm_struct *mm,
 {
 	struct vm_area_struct *vma;
 
-	vma = lock_vma_under_rcu(mm, address);
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
+	/* This is the dst vma, we always need the anon_vma */
+	vma = lock_vma_under_rcu(mm, address, true);
+	if (vma)
+		return vma;
 
 	mmap_read_lock(mm);
 	vma = find_vma_and_prepare_anon(mm, address);
@@ -1462,8 +1454,11 @@ static int uffd_move_lock(struct mm_struct *mm,
 	 * vma_start_read(src_vma)
 	 * mmap_read_lock(mm)
 	 *					vma_start_write(dst_vma)
+	 *
+	 * Note that here we won't touch src vma's anon_vma.  It should be
+	 * there, but here we don't need to ask for it.
 	 */
-	*src_vmap = lock_vma_under_rcu(mm, src_start);
+	*src_vmap = lock_vma_under_rcu(mm, src_start, false);
 	if (likely(*src_vmap))
 		return 0;
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e767721b3a58..5940847b616c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2053,7 +2053,8 @@ static struct vm_area_struct *find_tcp_vma(struct mm_struct *mm,
 					   unsigned long address,
 					   bool *mmap_locked)
 {
-	struct vm_area_struct *vma = lock_vma_under_rcu(mm, address);
+	/* TCP zerocopy pages are always read-only, see tcp_mmap() */
+	struct vm_area_struct *vma = lock_vma_under_rcu(mm, address, false);
 
 	if (vma) {
 		if (vma->vm_ops != &tcp_vm_ops) {
-- 
2.44.0


-- 
Peter Xu


