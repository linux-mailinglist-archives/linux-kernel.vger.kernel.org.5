Return-Path: <linux-kernel+bounces-19809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BFF82748E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753CC1F224DC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519EB51C5B;
	Mon,  8 Jan 2024 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CtMFkYO/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A3A51C2B;
	Mon,  8 Jan 2024 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=s0/htprykRKnrpQP8d0KAkLnKWEU6crMJZ/aLFqxOxU=; b=CtMFkYO/vJ4SEsAckPC/l+KNHd
	hVdwa/Tyh+B0tDQap+DwD9dq6vF0DorrIRcLCMXWQ36C+dzWvF+l9QKRiuWa8ahiQbpfnW+GPfuj4
	k2NUeJEL8n/OPvYokp8dFAsuV0Fgr8b/Q44ENnjcVLfoWAzgocZC7dSkvT4lQ+IH32GsgnRlKq2/I
	9kCl1z1hm2TGIOUYw4UmD841rmzVCob1wlioGJPfoWZA3Y38EbJhjw09LfPqdyYUH5mXPOZMe+2bE
	1LOjqeaOJ0bg2VPC8FOcHTcchmfJPgenHyCJMnu1esdp2QixFZLATRL+88JPporSdC9ZTzWreTMVc
	liXfHlZw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rMs0j-005ZJF-0T;
	Mon, 08 Jan 2024 15:57:57 +0000
Date: Mon, 8 Jan 2024 16:57:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping updates for Linux 6.8
Message-ID: <ZZwbgB9MRsqR5uE4@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit 3f7168591ebf7bbdb91797d02b1afaf00a4289b1:

  Merge tag '6.7-rc5-smb3-client-fixes' of git://git.samba.org/sfrench/cifs-2.6 (2023-12-14 19:57:42 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.8-2024-01-08

for you to fetch changes up to b07bc2347672cc8c7293c64499f1488278c5ca3d:

  dma-mapping: clear dev->dma_mem to NULL after freeing it (2023-12-15 12:32:45 +0100)

----------------------------------------------------------------
dma-mapping updates for Linux 6.8

 - reduce area lock contention for non-primary IO TLB pools (Petr Tesarik)
 - don't store redundant offsets in the dma_ranges stuctures
   (Robin Murphy)
 - clear dev->dma_mem when freeing per-device pools (Joakim Zhang)

----------------------------------------------------------------
Joakim Zhang (1):
      dma-mapping: clear dev->dma_mem to NULL after freeing it

Petr Tesarik (1):
      swiotlb: reduce area lock contention for non-primary IO TLB pools

Robin Murphy (1):
      dma-mapping: don't store redundant offsets

 drivers/acpi/scan.c        |  1 -
 drivers/of/address.c       |  1 -
 include/linux/dma-direct.h | 19 ++++++----
 kernel/dma/coherent.c      |  4 ++-
 kernel/dma/direct.c        |  1 -
 kernel/dma/swiotlb.c       | 90 ++++++++++++++++++++++++++++------------------
 6 files changed, 70 insertions(+), 46 deletions(-)

