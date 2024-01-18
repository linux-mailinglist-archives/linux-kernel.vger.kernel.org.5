Return-Path: <linux-kernel+bounces-29763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500D1831318
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4C3284BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34E5B64C;
	Thu, 18 Jan 2024 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tebdI+Gx"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607008F52;
	Thu, 18 Jan 2024 07:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563051; cv=none; b=gf6dFJUqcZHa3lHgHpV5rpolDooKcpPf7/wB24wRNJl3PArefDMCsQkSLoVUHGe0wZ1pJ/2UoUW8oxc/OhQdy3A7640wXyybGcpYsDu1nt93U2QHLbeWJHSGKtJ1+UH0gNSyVq8lNR0GyeOugEKYlxa7RKiIDMrHJacXV8gKls4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563051; c=relaxed/simple;
	bh=Vt6z/+BrDqdw6Zcsm80Zu+FlwasyqlfO1JB0sq1ZE/k=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:X-SRS-Rewrite; b=J4uY4lYVPRzsbPq5CTKa+XhMZYDvr0G4tGQiyBrdKKUHjbs8eVkiOv+34Lmj8G7AWwN7ru1lSR2xBTnYavXJwXelUXRbpw5d0zzJk57La9p6qqUVxYnom62BuC4n7lm7lbkBgRkM0YexsQn3Y9kUfwsmzfMwxsvys1CY2RcMC9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tebdI+Gx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=p6OfDaVnbO0KtRTgkZAORtoSDsfQNgKFZ2hgvQtI3J4=; b=tebdI+GxXNlKn8vm2S388/New7
	K5QG4Mnrj95+Mw8yw6HgzEWafQ12Tl0LN8+SLWCIq1CerOb0Y07aE8XM3s1HMP1qEB19q2ZiQptGe
	4t3HDHM4aVUXYGq3jmtFHmhcOX8jrNSGIEbPsomh9gtcQEB3/j8hIbUw7i916kt9Xt60KsiuRdcuK
	Uq3P9d+KrWr9Y2cVIISuRyaWgaiECgBV2ZiLCIaKA/rKSo3qvQB2q/5IoUwj+LyYNDdF6VPtEvhG4
	VVF8hOusCIRqhJDhZ9dOUPGq7StXYxZMF56lWEkgG1W04VsnnjKqLfL4quLEOyC0kokufrrGFG17z
	aUO6uLlQ==;
Received: from [213.208.157.36] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rQMrP-001v4l-1J;
	Thu, 18 Jan 2024 07:30:47 +0000
Date: Thu, 18 Jan 2024 08:30:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fixes for Linux 6.8
Message-ID: <ZajTpGRSCJkhPEKk@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit b07bc2347672cc8c7293c64499f1488278c5ca3d:

  dma-mapping: clear dev->dma_mem to NULL after freeing it (2023-12-15 12:32:45 +0100)

are available in the Git repository at:

  git.infradead.org:public_git/dma-mapping.git tags/dma-mapping-6.8-2024-01-18

for you to fetch changes up to 7c65aa3cc072cee76f577262fbe381a111a98774:

  dma-debug: fix kernel-doc warnings (2024-01-15 08:20:39 +0100)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.8

 - fix kerneldoc warnings (Randy Dunlap)
 - better bounds checking in swiotlb (ZhangPeng)

----------------------------------------------------------------
Randy Dunlap (1):
      dma-debug: fix kernel-doc warnings

ZhangPeng (1):
      swiotlb: check alloc_size before the allocation of a new memory pool

 kernel/dma/debug.c   | 3 ++-
 kernel/dma/swiotlb.c | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

