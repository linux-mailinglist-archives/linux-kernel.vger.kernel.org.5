Return-Path: <linux-kernel+bounces-12302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A8D81F2E9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 00:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F541F231AE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 23:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0000E498A2;
	Wed, 27 Dec 2023 23:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X6lQ9rRb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3344F49890;
	Wed, 27 Dec 2023 23:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 769D0C433C8;
	Wed, 27 Dec 2023 23:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703718235;
	bh=LMCnPQNEAm1eJkpB/BPhB/Kmv2yP8E0Iiks2kfeTjaM=;
	h=Date:From:To:Cc:Subject:From;
	b=X6lQ9rRbmqoaDCHd556ftK8Cd5/WiccS63GCldlTvAuiEs7Y728adWRv4h3acxxyp
	 RDLdWfccakM/tG0ilH+w5cSkx5iDvZJ4LLr5/118MkwsxxnybrdkSA9d8CsA5piGqv
	 jKFZZwYOYAEBcyFoLwOF3RHpmgLGh68DdRzLrl7I=
Date: Wed, 27 Dec 2023 15:03:54 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.7
Message-Id: <20231227150354.9437b5c792000b8eb22758e9@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus, please merge this batch of hotfixes, thanks.


The following changes since commit 4376807bf2d5371c3e00080c972be568c3f8a7d1:

  mm/mglru: reclaim offlined memcgs harder (2023-12-12 17:20:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-12-27-15-00

for you to fetch changes up to 1803d0c5ee1a3bbee23db2336e21add067824f02:

  mailmap: add an old address for Naoya Horiguchi (2023-12-20 13:46:20 -0800)

----------------------------------------------------------------
11 hotfixes.  7 are cc:stable and the other 4 address post-6.6 issues or
are not considered backporting material.

----------------------------------------------------------------
Arnd Bergmann (2):
      kexec: fix KEXEC_FILE dependencies
      kexec: select CRYPTO from KEXEC_FILE instead of depending on it

Baokun Li (1):
      mm/filemap: avoid buffered read/write race to read inconsistent data

Charan Teja Kalla (1):
      mm: migrate high-order folios in swap cache correctly

Matthew Wilcox (Oracle) (4):
      mm/memory-failure: pass the folio and the page to collect_procs()
      mm/memory-failure: check the mapcount of the precise page
      mm/memory-failure: cast index to loff_t before shifting it
      mailmap: add an old address for Naoya Horiguchi

Muhammad Usama Anjum (1):
      selftests: secretmem: floor the memory size to the multiple of page_size

Nico Pache (1):
      kunit: kasan_test: disable fortify string checker on kmalloc_oob_memset

Sidhartha Kumar (1):
      maple_tree: do not preallocate nodes for slot stores

 .mailmap                                  |  1 +
 arch/powerpc/Kconfig                      |  4 ++--
 arch/riscv/Kconfig                        |  4 +---
 arch/s390/Kconfig                         |  4 ++--
 arch/x86/Kconfig                          |  4 ++--
 kernel/Kconfig.kexec                      |  2 ++
 lib/maple_tree.c                          | 11 +++++++++++
 mm/filemap.c                              |  9 +++++++++
 mm/kasan/kasan_test.c                     | 20 +++++++++++++++----
 mm/memory-failure.c                       | 33 +++++++++++++++----------------
 mm/migrate.c                              |  9 ++++++++-
 tools/testing/radix-tree/maple.c          |  2 +-
 tools/testing/selftests/mm/memfd_secret.c |  3 +++
 13 files changed, 74 insertions(+), 32 deletions(-)


