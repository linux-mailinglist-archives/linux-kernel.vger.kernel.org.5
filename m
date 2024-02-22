Return-Path: <linux-kernel+bounces-77482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4EE86062D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165F51C21E61
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918AA1B7F1;
	Thu, 22 Feb 2024 23:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UI0A8Wt+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D9F18032;
	Thu, 22 Feb 2024 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643170; cv=none; b=manzboi7WtAwP4cBPcRS5AQVnZ78hpTsscJNj/IfLukSyZAQNBS26P/2XwDXjrH7/6TX5qFUXc0COKSVj4HHFhzkmYoktXKDDHREdX3n/9bZHqntyI3R7o6fb2yB+/87lBhOj8pwyPw1rB14VLc7n430KyweS6dh3QaOJFh2AO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643170; c=relaxed/simple;
	bh=hYrpPsLRcrNhzOLOLhn2V6Z7Ec9eAWm7xV/uL9PKg4k=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=rFLUtkKIoZJ3U2xyPLZtyImdYRAn1giljtACnduFmmD+Kqo/2+tWLogbWKiUKAY1u3Bzcijhrca5mwL/x9Xz4YLZKT5XM/YsrGEQo0bVmvHigwCQZueQpv6qcPvWBQWwX3cbyfB4CvDoZOW2JOQRl7x9XI7PG3Qy6z6WMJ1AZnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UI0A8Wt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870C1C433F1;
	Thu, 22 Feb 2024 23:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708643169;
	bh=hYrpPsLRcrNhzOLOLhn2V6Z7Ec9eAWm7xV/uL9PKg4k=;
	h=Date:From:To:Cc:Subject:From;
	b=UI0A8Wt+vdtYj5x/lR7GPqNZ7hObkZgqPUCpbEOu943jvyiTpexpjItEwXKqcqo9H
	 r2I6y4+edA3q+8RWW8OJJK1jMkYYrfxYOTfIwCCCxZnJP769dArAy7Q81Zdx14AzZs
	 miym5YJ781HBJuhO2DgNJuL41ywJzH63swZGbMjY=
Date: Thu, 22 Feb 2024 15:06:09 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.8-rc6
Message-Id: <20240222150609.61c32cf2ababec81509bf5fc@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus, please merge this batch of MM (and one non-MM) hotfixes, thanks.


The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-02-22-15-02

for you to fetch changes up to 2597c9947b0174fcc71bdd7ab6cb49c2b4291e95:

  kasan: guard release_free_meta() shadow access with kasan_arch_is_ready() (2024-02-20 14:20:50 -0800)

----------------------------------------------------------------
14 hotfixes.  10 are cc:stable and the remainder address post-6.7 issues
or aren't considered appropriate for backporting.

----------------------------------------------------------------
Anshuman Khandual (1):
      mm/memblock: add MEMBLOCK_RSRV_NOINIT into flagname[] array

Benjamin Gray (1):
      kasan: guard release_free_meta() shadow access with kasan_arch_is_ready()

Chengming Zhou (1):
      mm/zswap: invalidate duplicate entry when !zswap_enabled

Guenter Roeck (1):
      lib/Kconfig.debug: TEST_IOV_ITER depends on MMU

Johannes Weiner (1):
      mm: memcontrol: clarify swapaccount=0 deprecation warning

Kairui Song (1):
      mm/swap: fix race when skipping swapcache

Nhat Pham (1):
      mm/swap_state: update zswap LRU's protection range with the folio locked

SeongJae Park (4):
      mm/damon/core: check apply interval in damon_do_apply_schemes()
      mm/damon/sysfs-schemes: handle schemes sysfs dir removal before commit_schemes_quota_goals
      mm/damon/reclaim: fix quota stauts loss due to online tunings
      mm/damon/lru_sort: fix quota status loss due to online tunings

Shakeel Butt (1):
      MAINTAINERS: mailmap: update Shakeel's email address

Terry Tritton (1):
      selftests/mm: uffd-unit-test check if huge page size is 0

Yosry Ahmed (1):
      mm: zswap: fix missing folio cleanup in writeback race path

 .mailmap                                     |  1 +
 MAINTAINERS                                  |  2 +-
 include/linux/swap.h                         |  5 ++++
 lib/Kconfig.debug                            |  1 +
 mm/damon/core.c                              | 15 +++++++---
 mm/damon/lru_sort.c                          | 43 +++++++++++++++++++++++-----
 mm/damon/reclaim.c                           | 18 +++++++++++-
 mm/damon/sysfs-schemes.c                     |  4 +++
 mm/kasan/generic.c                           |  3 ++
 mm/memblock.c                                |  1 +
 mm/memcontrol.c                              | 10 +++++--
 mm/memory.c                                  | 20 +++++++++++++
 mm/swap.h                                    |  5 ++++
 mm/swap_state.c                              | 10 ++++---
 mm/swapfile.c                                | 13 +++++++++
 mm/zswap.c                                   | 15 ++++++----
 tools/testing/selftests/mm/uffd-unit-tests.c |  6 ++++
 17 files changed, 147 insertions(+), 25 deletions(-)


