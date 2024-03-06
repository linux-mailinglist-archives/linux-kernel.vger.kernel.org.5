Return-Path: <linux-kernel+bounces-93159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530ED872BA8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 01:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0676D28200E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 00:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4B0EC4;
	Wed,  6 Mar 2024 00:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KLRvMa9y"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7E6173
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709684124; cv=none; b=LTjwtQOf1ddyjbL0p9pR0nPR58MZ4t2t6j/eNKpkWuStm35tjZtrhRMdhtdTccpRSXIVO5EOVwwsf65s5yysKp7Og7bTTaEhso+DMUjYxhAci8dMmeOV3RD7WfSJaGPMDQJpiPuQQiwDfNCBSeT4nh7mebXWD5WtV19vjPqE6jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709684124; c=relaxed/simple;
	bh=Ery4zifMCCuUuZyzrIBlY0WEBPD7CQi0y3uIJntdw9E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=R4t9HNNw90V4Sj7CpRWhIuRDhSZi6DKWB79mfp+j3IPWfLolndXm5OQAEms66VvaG/qB4x11ecev0NDP+anOYIgE/KVB/B/CXbZMBuW6AAhamhpKh4CWFKZNrdJ1vaen9Kr7jRvCpd9MyZqOk1VzCST0rrRJebqDcz4Oug2xKR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KLRvMa9y; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6096c745c33so117360597b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 16:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709684122; x=1710288922; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ChgiPj0kYltLQzZMIn6xeFnYbJXLFSJLwKxQczKImDM=;
        b=KLRvMa9yTvD44rFz7ov1LtSm3goSqRD7dkILYh94flF9Gk8dgH9EH9dImsMh2JLaMt
         BCq9aNtWuoYilr4ZdK/rtYewdfkza1iHP2ENOXIaFCTzBIR8pG+BS9Y6k6BFS2U19OqA
         9BZy84caM8NMk0+2WGpU6rNUeUDBCtmvuAGJyjIaLJcpJOSNgMQEu2DMok0W8CMShuR1
         hNruRRY3+FXilIoW0X0A/mN+ZOohiZrsPSvP8z5NSQ+78SY4G49Ib7GzshtbE/4vRi72
         U9iqBn2RSxfqstp3kkeXAQUyG2Sl8aoEeO5ajS8MlnUkIZGxq4gOOB4XP2SQ71AzDRSD
         z6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709684122; x=1710288922;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ChgiPj0kYltLQzZMIn6xeFnYbJXLFSJLwKxQczKImDM=;
        b=tW4Or4VGESm+QSE9n7iP2HvnrJmc08QeGnT+68pP3Gxo5zt2ATUPJGHgLouBoXGXc1
         jKYj+iU79BFrMPpAz4Qb3AOjBkT2jUF8Zd5reRJxvo7hEVgx+aQLK7cqa+i4jInILFgm
         qxBiJYfQ2Jjk6z8+/pAbmxdmREkr1xduw84Ycq3HzL+x2L7EHqGEHVnLn1VzIwz1vCHG
         0bHRXW2zEupcu9k9ESbWuVNychC75xDFC4C9X8q/4RAiaZpn3pydeXG74NNXLkk3p3FC
         5IRPBZa2QJSaubtzYGyoveNjrm0T9sZh8t40eVQhtNdTUgdsm8UN1+a2eJvQwH98i5dO
         71oA==
X-Forwarded-Encrypted: i=1; AJvYcCWmzQJ6pVAlG5SWYP5wGJY4YCftIW5XntbdL8835KaeG9zjpJNjGjPuK5wG6fgpITlMTPYZfOrVpEN4nzbTlxhC2oUqUF6Dc7fhhSe8
X-Gm-Message-State: AOJu0YwK/untwWvtJwr6i5DQ5wixe1PZ8gRifP6dvh5Ep6nqB/q03zPc
	ZNhP6nE6aVYnJf3nnwIljbichHzFsWqWQXUHw4TFXTOBdrzw9RFKvpj8yzvI7B+AHGyp76m1cwh
	kuHWiqhQTUvX79z+j7w==
X-Google-Smtp-Source: AGHT+IFfsY8LjMQNkNxTJ0rSe20ZUdfR3+FzZIQB2yeaN8wmwfvRIu02vM39uiLYIz0MeSq9L6HZCKPA8Bw8F9cK
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:9a92:0:b0:607:fd67:b946 with SMTP
 id r140-20020a819a92000000b00607fd67b946mr3796447ywg.10.1709684121991; Tue,
 05 Mar 2024 16:15:21 -0800 (PST)
Date: Wed,  6 Mar 2024 00:15:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306001511.932348-1-jthoughton@google.com>
Subject: [PATCH] mm: Add an explicit smp_wmb() to UFFDIO_CONTINUE
From: James Houghton <jthoughton@google.com>
To: Peter Xu <peterx@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Users of UFFDIO_CONTINUE may reasonably assume that a write memory
barrier is included as part of UFFDIO_CONTINUE. That is, a user may
(mistakenly) believe that all writes it has done to a page that it is
now UFFDIO_CONTINUE'ing are guaranteed to be visible to anyone
subsequently reading the page through the newly mapped virtual memory
region.

Include only a single smp_wmb() for each UFFDIO_CONTINUE, as that is all
that is necessary. While we're at it, optimize the smp_wmb() that is
already incidentally present for the HugeTLB case.

Documentation doesn't specify if the kernel does a wmb(), so it's not
wrong not to include it. But by not including it, we are making is easy
for a user to have a very hard-to-detect bug. Include it now to be safe.

A user that decides to update the contents of the page in one thread and
UFFDIO_CONTINUE that page in another must already take additional steps
to synchronize properly.

Signed-off-by: James Houghton <jthoughton@google.com>
---

I'm not sure if this patch should be merged. I think it's the right
thing to do, as it is very easy for a user to get this wrong. (I have
been using UFFDIO_CONTINUE for >2 years and only realized this problem
recently.) Given that it's not a "bug" strictly speaking, even if this
patch is a good idea, I'm unsure if it needs to be backported.

This quirk has existed since minor fault support was added for shmem[1].

I've tried to see if I can legitimately get a user to read stale data,
and a few attempts with this test[2] have been unsuccessful.

[1]: commit 153132571f02 ("userfaultfd/shmem: support UFFDIO_CONTINUE for shmem")
[2]: https://gist.github.com/48ca/38d0665b0f1a6319a56507dc73a173f9

 mm/hugetlb.c     | 15 +++++++++------
 mm/userfaultfd.c | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bb17e5c22759..533bf6b2d94d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6779,12 +6779,15 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 		}
 	}
 
-	/*
-	 * The memory barrier inside __folio_mark_uptodate makes sure that
-	 * preceding stores to the page contents become visible before
-	 * the set_pte_at() write.
-	 */
-	__folio_mark_uptodate(folio);
+	if (!is_continue) {
+		/*
+		 * The memory barrier inside __folio_mark_uptodate makes sure
+		 * that preceding stores to the page contents become visible
+		 * before the set_pte_at() write.
+		 */
+		__folio_mark_uptodate(folio);
+	} else
+		WARN_ON_ONCE(!folio_test_uptodate(folio));
 
 	/* Add shared, newly allocated pages to the page cache. */
 	if (vm_shared && !is_continue) {
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 503ea77c81aa..d515b640ca48 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -531,6 +531,10 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 			goto out_unlock;
 	}
 
+	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
+		/* See the comment in mfill_atomic. */
+		smp_wmb();
+
 	while (src_addr < src_start + len) {
 		BUG_ON(dst_addr >= dst_start + len);
 
@@ -743,6 +747,20 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
 		goto out_unlock;
 
+	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
+		/*
+		 * A caller might reasonably assume that UFFDIO_CONTINUE
+		 * contains a wmb() to ensure that any writes to the
+		 * about-to-be-mapped page by the thread doing the
+		 * UFFDIO_CONTINUE are guaranteed to be visible to subsequent
+		 * reads of the page through the newly mapped address.
+		 *
+		 * For MFILL_ATOMIC_COPY, the wmb() is done for each COPYed
+		 * page. We can do the wmb() now for CONTINUE as the user has
+		 * already prepared the page contents.
+		 */
+		smp_wmb();
+
 	while (src_addr < src_start + len) {
 		pmd_t dst_pmdval;
 

base-commit: a7f399ae964e1d2a11d88d863a1d64392678ccaf
-- 
2.44.0.278.ge034bb2e1d-goog


