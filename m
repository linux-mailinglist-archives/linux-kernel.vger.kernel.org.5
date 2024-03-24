Return-Path: <linux-kernel+bounces-112526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCBB887B27
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 01:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0559C281DD1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D237F9;
	Sun, 24 Mar 2024 00:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l+0EGp6d"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BB319E;
	Sun, 24 Mar 2024 00:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711238842; cv=none; b=lSj4xQ/YAisctfn96Oigq8+gk6wFqzM2q6gCg91Qr/bPNmwBVCBEm7e9KHH9IGsHltmB9xTnr+Zk0kawjxie2MIvcm00ApHMDHDJvid4nSwrAnOchx+8b+NeqfRC6P+Okdle/ts3YI62/IClniA9//1fBRoASnLbE0sj+d6uYOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711238842; c=relaxed/simple;
	bh=GS7gNRT7PexvXxuEFt3v2Enrciz6Z+dU+tKwg55TQt8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=olxFCKqZyADIX7mMPGN1lIkHbfuC82Pukl1QUQknRebANmNU5gD2UYySrJ6eNP5IB9pqXXzTA/2wHrf5pj3rQgMIFEXW7ZjQAUrClxBOV7isTPJkunlQfiluCy7P0oD9VgVYe0eNXTaxiVMARd8Qv/Zk4jUe/6VPPDAI54lsQMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l+0EGp6d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=bkNbDv/jXWfri6VlbU+GiesUQ/cf40GorjdK3AmoNuE=; b=l+0EGp6dd8T961i3D1AL/SBR+M
	D/qYWvbGxFHfaOM2ErCVC/ZXlvAKGtohWh8QNPntftHvL0ymS0J2cVtHCqWbHmXI1ZktjHwKru54v
	zJHmg0FtaXIxr8J5fmgLbLB3jGJT4e2ulKotCSS8wjtrRQ3D5axyX/i28f0dS2ebQ+wjMxN2QZC95
	qQqDRAKJNjzzPRG5+z82KS5psnUIuScy+kyLVXmdfV5RPQY7fiXl5SYxyZk6YobgwZIZn737zR5o8
	G8KYRdSrcX+pxQ5TObrL205AleGdwzeyiZcp4RnBiQ3lGtJoVzUYjdW2yZYlin5VquwMtCv1vfX/e
	moT9Nu4w==;
Received: from [111.223.108.129] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roBOP-0000000BRY3-1vUI;
	Sun, 24 Mar 2024 00:07:17 +0000
Date: Sun, 24 Mar 2024 08:07:11 +0800
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fixes for Linux 6.9
Message-ID: <Zf9ur7uQA0JLleTU@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit b9fa16949d18e06bdf728a560f5c8af56d2bdcaf:

  dma-direct: Leak pages on dma_set_decrypted() failure (2024-02-28 05:31:38 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.9-2024-03-24

for you to fetch changes up to 14cebf689a78e8a1c041138af221ef6eac6bc7da:

  swiotlb: Reinstate page-alignment for mappings >= PAGE_SIZE (2024-03-13 11:39:34 -0700)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.9

This has a set of swiotlb alignment fixes for sometimes very long
standing bugs from Will.  We've been discussion them for a while and they
should be solid now.

----------------------------------------------------------------
Nicolin Chen (1):
      iommu/dma: Force swiotlb_max_mapping_size on an untrusted device

Will Deacon (5):
      swiotlb: Fix double-allocation of slots due to broken alignment handling
      swiotlb: Enforce page alignment in swiotlb_alloc()
      swiotlb: Honour dma_alloc_coherent() alignment in swiotlb_alloc()
      swiotlb: Fix alignment checks when both allocation and DMA masks are present
      swiotlb: Reinstate page-alignment for mappings >= PAGE_SIZE

 drivers/iommu/dma-iommu.c |  9 +++++++++
 kernel/dma/swiotlb.c      | 45 +++++++++++++++++++++++++++++++++------------
 2 files changed, 42 insertions(+), 12 deletions(-)

