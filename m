Return-Path: <linux-kernel+bounces-94802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC7D87456A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C311C21A01
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC96546AF;
	Thu,  7 Mar 2024 01:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPRNaMaE"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAB917F0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 01:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709773380; cv=none; b=cs/ZK2Exxl7ZYybixXCagY/QLed0L6qzq5zazAdJUE7hI4nbK5pB0D7IQNNLBTMKXpPIxml/Dvero8M45wXx+BzFXmLi3QjiG/rtYYIGrYxzf2r+5+MSjHSoLJtI3axpGv8M6koJb2MpjoZU9BvhKpqK2DwGq5mJtky7AFWMl84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709773380; c=relaxed/simple;
	bh=Pr76ost3Jm9M+SgANKLruqF/WkmiFPWvpAj+gqM7hs0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HzbcXzY/0mgjaWn2uVVpqBQOd+XM5XoasAvxRsjLBSgx2UP3MTfQ+WAe32KPVWo2qDU8bqySNFlczBIIr4D4KsnK2Sr/MBcdmrkgS2Xf9hnwrfMo+f5e0FuPL+1cmgg4WHetdUE/YjS3zUcIym51/5nB/5a4NIbzu1xYgkH6LB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XPRNaMaE; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so438667276.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 17:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709773377; x=1710378177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EeijRANHOrxfrX3k4EnadZJQGC1/GCLM0wv9ckDJZjk=;
        b=XPRNaMaEA9sYKW6tDY4o3MyTAWtYN2+EYLRQv5Adie4lvLIX8e66KHxa9are/MM+s6
         DsMMJ1jr0gFUC7h5gL5bEdmYG60YBakf7HjN9MV1ls4swJG7fVNynqNVewFB0lUexLQY
         HpkwIaJnbrcTORVVnWBkh3WhadprIRQtCP6sRD8MfGxf7HrMXqGt0etIpq0YxyfoyiP2
         wIQR+BrxWzuBWYOHSC5T80MVOrUi4+jDHRq06j4Kw5uwWU+56GAHiwjjL6y45PjhT/p/
         DhmdEk8zH05tRWpEDPMcw0mwiOzVOVuE/52tJLvGioNiBzwBiujrIzFK5P2qyY+sey20
         WUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709773377; x=1710378177;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EeijRANHOrxfrX3k4EnadZJQGC1/GCLM0wv9ckDJZjk=;
        b=rM0hvExghFWou1Nvy4pIr5sHMLT4uuvwvYBuYV6ZaknTvIyAVX8O9f3gwiybB+Vhnp
         14HZN9Q00bTzwdvHVQwD6A3m1fofxqAq8ubPDZEHbR4WU2rvN7G0n7cOi26U9U5PQTLR
         k5y8frkpe4yhvRskP5+IavJpGRw3XTguP17T7F9MJyhZnfmlolsXx9xcss/W0RoY1jVD
         0YzOYJL0YIfMEwghzwv2Vva7iouUHTZe9MEsEB7LVWd5syZU39QuVRfA3CTVyD4EWDyr
         j51a+I9uQfZW1IPhHF7T4OHMIl4dfinZfV1fn838ClQsxJZgTxdAsZ7XCzmB4rM7IRYB
         LFSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm73br+PrEnftD39YaL7YIBAv3cU4ZK9uA/H/BUeOocpq2EQ9bBtr+7CzUzhDfD39C886t08A8XUHiIfXAnuIHUooqJL1KoqkUJv5+
X-Gm-Message-State: AOJu0YxchH8x34ZJ7QfswZ0wq1kGd7uUIdN4pa/fVVSmbdoPf+7ZC8sY
	5ppV+u4ISyCmW4/kbWWHtBqiZwnLtBrBYWZdDJd3tsffTsTEUGko4hRnKlRjeSJXSp0q0tq8M1m
	D3cKnhGCcU74ZJxEPhw==
X-Google-Smtp-Source: AGHT+IFZ8DADJ7M68KA1PQljW8T0FB6a9j/RVD47/RG11udI58JqzGCUYlva3YcLanF4It0jZKeiEEgevI6/RKY6
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:70d:b0:dc6:c94e:fb85 with SMTP
 id k13-20020a056902070d00b00dc6c94efb85mr559337ybt.2.1709773377534; Wed, 06
 Mar 2024 17:02:57 -0800 (PST)
Date: Thu,  7 Mar 2024 01:02:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307010250.3847179-1-jthoughton@google.com>
Subject: [PATCH v2] mm: Add an explicit smp_wmb() to UFFDIO_CONTINUE
From: James Houghton <jthoughton@google.com>
To: Peter Xu <peterx@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Users of UFFDIO_CONTINUE may reasonably assume that a write memory
barrier is included as part of UFFDIO_CONTINUE. That is, a user may
believe that all writes it has done to a page that it is now
UFFDIO_CONTINUE'ing are guaranteed to be visible to anyone subsequently
reading the page through the newly mapped virtual memory region.

Today, such a user happens to be correct. mmget_not_zero(), for example,
is called as part of UFFDIO_CONTINUE (and comes before any PTE updates),
and it implicitly gives us a write barrier.

To be resilient against future changes, include an explicit smp_wmb().
While we're at it, optimize the smp_wmb() that is already incidentally
present for the HugeTLB case.

Merely making a syscall does not generally imply the memory ordering
constraints that we need (including on x86).

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c     | 17 +++++++++++++----
 mm/userfaultfd.c |  9 +++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bb17e5c22759..23ef240ba48a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6780,11 +6780,20 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	}
 
 	/*
-	 * The memory barrier inside __folio_mark_uptodate makes sure that
-	 * preceding stores to the page contents become visible before
-	 * the set_pte_at() write.
+	 * If we just allocated a new page, we need a memory barrier to ensure
+	 * that preceding stores to the page become visible before the
+	 * set_pte_at() write. The memory barrier inside __folio_mark_uptodate
+	 * is what we need.
+	 *
+	 * In the case where we have not allocated a new page (is_continue),
+	 * the page must already be uptodate. UFFDIO_CONTINUE already includes
+	 * an earlier smp_wmb() to ensure that prior stores will be visible
+	 * before the set_pte_at() write.
 	 */
-	__folio_mark_uptodate(folio);
+	if (!is_continue)
+		__folio_mark_uptodate(folio);
+	else
+		WARN_ON_ONCE(!folio_test_uptodate(folio));
 
 	/* Add shared, newly allocated pages to the page cache. */
 	if (vm_shared && !is_continue) {
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 503ea77c81aa..712160cd41ec 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -845,6 +845,15 @@ ssize_t mfill_atomic_zeropage(struct userfaultfd_ctx *ctx,
 ssize_t mfill_atomic_continue(struct userfaultfd_ctx *ctx, unsigned long start,
 			      unsigned long len, uffd_flags_t flags)
 {
+
+	/*
+	 * A caller might reasonably assume that UFFDIO_CONTINUE contains an
+	 * smp_wmb() to ensure that any writes to the about-to-be-mapped page by
+	 * the thread doing the UFFDIO_CONTINUE are guaranteed to be visible to
+	 * subsequent loads from the page through the newly mapped address range.
+	 */
+	smp_wmb();
+
 	return mfill_atomic(ctx, start, 0, len,
 			    uffd_flags_set_mode(flags, MFILL_ATOMIC_CONTINUE));
 }

base-commit: f4239a5d7acc1b5ff9bac4d5471000b952279ef0
-- 
2.44.0.278.ge034bb2e1d-goog


