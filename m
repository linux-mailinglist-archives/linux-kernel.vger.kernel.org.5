Return-Path: <linux-kernel+bounces-150811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F297A8AA4D1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A34C1C219FC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65231199E89;
	Thu, 18 Apr 2024 21:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BIBCbuqJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773BF16ABFF;
	Thu, 18 Apr 2024 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713476621; cv=none; b=a5T0IjNN9UO+0T//g/gUW5nVyd8uKh4WDIbm3THVNu1UQinTMEq83nLuS62mPjtCrwMi4vqVgvHbqhTBQjXluBQL1Q/hvyD7FGaCbsmFfxjzQEv9zK2qalNGEjKR9NjUX0qDaBgZSP9vPofYWPAiLkm/qGNC2WydZIbV+r896jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713476621; c=relaxed/simple;
	bh=Fvbiac4KfAqz/lNisFNho+Dr/IVLQW3P80lxLzHqAIM=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=UK/mrikZEH6Xa84ElfDkcnWBRP57Ksa5SqjCXy+CCoRg5bTPP1oyuahK9FIKzh/EFQAErKfVJ5SMlHkBmoSbxPn0ERzyTUjSITe9EZHyBEYevOAkc1EHGHRWOyvWP/QiowKsO1w4CSLv/vDgnDIA8SLW8XRtM7DsxD4wsZVSbEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BIBCbuqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC07DC2BD11;
	Thu, 18 Apr 2024 21:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1713476620;
	bh=Fvbiac4KfAqz/lNisFNho+Dr/IVLQW3P80lxLzHqAIM=;
	h=Date:From:To:Cc:Subject:From;
	b=BIBCbuqJm/BtpJc9YWjo0iLcow+B7KIGqI9ikDGop6yezeD/xVF/1iftgB2xMWXSe
	 KbTW0ZGGzOMvb/+6BX2QNWCddqvtn0pfgWCM4di1/6MBBQHIBJHQzjN0Hjbzy6dqZJ
	 8PMoMpiNDcFTExAZCVS4OYSdGhxcvD9zzWLo4NU8=
Date: Thu, 18 Apr 2024 14:43:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.9-rc5
Message-Id: <20240418144340.2f5d96a1c4e0a8fd2dc9cb66@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus, please merge this batch of MM and non-MM hotfixes, thanks.


The following changes since commit 0bbac3facb5d6cc0171c45c9873a2dc96bea9680:

  Linux 6.9-rc4 (2024-04-14 13:38:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-04-18-14-41

for you to fetch changes up to c4a7dc9523b59b3e73fd522c73e95e072f876b16:

  nilfs2: fix OOB in nilfs_set_de_type (2024-04-16 15:39:52 -0700)

----------------------------------------------------------------
15 hotfixes.  9 are cc:stable and the remainder address post-6.8 issues
or aren't considered suitable for backporting.

There are a significant number of fixups for this cycle's page_owner
changes (series "page_owner: print stacks and their outstanding
allocations").  Apart from that, singleton changes all over, mainly in MM.

----------------------------------------------------------------
David Hildenbrand (1):
      mm/madvise: make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY properly

Jeongjun Park (1):
      nilfs2: fix OOB in nilfs_set_de_type

Lokesh Gidra (1):
      userfaultfd: change src_folio after ensuring it's unpinned in UFFDIO_MOVE

Miaohe Lin (2):
      mm/memory-failure: fix deadlock when hugetlb_optimize_vmemmap is enabled
      fork: defer linking file vma until vma is fully initialized

Naoya Horiguchi (1):
      MAINTAINERS: update Naoya Horiguchi's email address

Oscar Salvador (6):
      mm,page_owner: update metadata for tail pages
      mm,page_owner: fix refcount imbalance
      mm,page_owner: fix accounting of pages when migrating
      mm,page_owner: fix printing of stack records
      mm,swapops: update check in is_pfn_swap_entry for hwpoison entries
      mm,page_owner: defer enablement of static branch

Peter Xu (1):
      mm/userfaultfd: allow hugetlb change protection upon poison entry

Phillip Lougher (1):
      Squashfs: check the inode number is not the invalid value of zero

Sumanth Korikkar (1):
      mm/shmem: inline shmem_is_huge() for disabled transparent hugepages

 .mailmap                        |   3 +-
 Documentation/mm/page_owner.rst |  73 +++++++--------
 MAINTAINERS                     |   2 +-
 fs/nilfs2/dir.c                 |   2 +-
 fs/squashfs/inode.c             |   5 +-
 include/linux/shmem_fs.h        |   9 ++
 include/linux/swapops.h         |  65 +++++++-------
 kernel/fork.c                   |  33 +++----
 mm/gup.c                        |  54 +++++++-----
 mm/huge_memory.c                |   6 +-
 mm/hugetlb.c                    |  10 ++-
 mm/internal.h                   |  10 ++-
 mm/madvise.c                    |  17 +---
 mm/memory-failure.c             |  18 +++-
 mm/page_owner.c                 | 190 +++++++++++++++++++++++-----------------
 mm/shmem.c                      |   6 --
 16 files changed, 280 insertions(+), 223 deletions(-)


