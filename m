Return-Path: <linux-kernel+bounces-136296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D1689D259
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463D11F23D92
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B11762DA;
	Tue,  9 Apr 2024 06:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="a4c9OXqG"
Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CA56E5EC;
	Tue,  9 Apr 2024 06:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643940; cv=none; b=gyjOFi6dtkRW7iBG0PeZYhAb2RYdax/8B3SuAjp9BQfMriCmYPLXNFer8SN6MMQ0kie4G2CBvOYq/rah67yXDMn+8xfKR/z02XEGaDETFJhviEnYp9geu+jbwxqjLto+Wl23LezK9eo73aWZHfHf0HkEtdZ8xDqd4CZBu0SY8hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643940; c=relaxed/simple;
	bh=bnuGCfoRD/GHBH5oPlzJgRbdryYdtuyyryw5PvMST3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DQIZqvm3X8KeZr+pY139s7hOL35L147hYAECCtNDAT6cf67S+Ps56K1tBYN0aG05droJK0UKWQ1xte3X9dBv1zckpOjXAdEJShlQD5Ths5oWivFvB/LdtHNuGfJdggOOmzvylvCnSUHglrZarUSqlAt5Asfcy3sr8JEpgR/D8OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=a4c9OXqG; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 5C128440209;
	Tue,  9 Apr 2024 09:17:42 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1712643462;
	bh=bnuGCfoRD/GHBH5oPlzJgRbdryYdtuyyryw5PvMST3k=;
	h=From:To:Cc:Subject:Date:From;
	b=a4c9OXqGbWvMqcGamtbGvNOylokFOW+P/K6pK1HJUkwAsoEkr11JAJ94N9DueCzUL
	 Sh9pTDCYg72vzxXwwgo7aoVROdIbGvzuaSAzdizDy/f66CdkraK47/FHVX0aLnAylz
	 bgZYDCW9qIt0nfbBWhnvW9LIjltl/WjI8PVkpsVa1LcktqpmDJo4MwsQO93eEn4bkp
	 pD3oGKocfvAQF8y7xcMH/10bUZEagZl00KRqDBhV8dfGmtr7MUP90ka7K3D46nD30L
	 t9hnstbzUOSxvqVeJL72Jv475/gjlo0tBTgGxCv2+6SrIF50HZzI/hnozSsPuc56BP
	 1euAVmAgJnV3w==
From: Baruch Siach <baruch@tkos.co.il>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Baruch Siach <baruch@tkos.co.il>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: [PATCH RFC v2 0/5] arm64: support DMA zone starting above 4GB
Date: Tue,  9 Apr 2024 09:17:53 +0300
Message-ID: <cover.1712642324.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DMA zones code assumes that DMA lower limit is zero. When there is no RAM 
below 4GB, arm64 platform code sets DMA/DMA32 zone limits to cover the entire 
RAM[0].

The platform I have has RAM starting at 32GB. Devices with 30-bit DMA mask are 
mapped to 1GB at the bottom of RAM, between 32GB - 33GB. A DMA zone over the 
entire RAM breaks DMA allocation for these devices.

In response to a previous RFC hack[1] Catalin Marinas suggested to add a
separate offset value as base address for the DMA zone. This RFC series 
attempts to implement that suggestion.

With this series applied, the DMA zone covers the right RAM range for my 
platform.

RFC v2:

  * Add patch from Catalin[2] changing zone_dma_bits to zone_dma_limit to 
    simplify subsequent patches

  * Test on real hardware

RFC v1: https://lore.kernel.org/all/cover.1703683642.git.baruch@tkos.co.il/

[0] See commit 791ab8b2e3db ("arm64: Ignore any DMA offsets in the 
    max_zone_phys() calculation")

[1] https://lore.kernel.org/all/9af8a19c3398e7dc09cfc1fbafed98d795d9f83e.1699464622.git.baruch@tkos.co.il/

[2] https://lore.kernel.org/all/ZZ2HnHJV3gdzu1Aj@arm.com/

Baruch Siach (4):
  of: get dma area lower limit
  of: unittest: add test for of_dma_get_cpu_limits() 'min' param
  dma-direct: add base offset to zone_dma_bits
  arm64: mm: take DMA zone offset into account

Catalin Marinas (1):
  dma-mapping: replace zone_dma_bits by zone_dma_limit

 arch/arm64/mm/init.c       | 34 ++++++++++++----------------------
 arch/powerpc/mm/mem.c      |  9 ++++-----
 arch/s390/mm/init.c        |  2 +-
 drivers/of/address.c       | 38 +++++++++++++++++++++++++++-----------
 drivers/of/unittest.c      | 17 ++++++++++-------
 include/linux/dma-direct.h |  3 ++-
 include/linux/of.h         | 11 ++++++++---
 kernel/dma/direct.c        | 11 ++++++-----
 kernel/dma/pool.c          |  2 +-
 kernel/dma/swiotlb.c       |  4 ++--
 10 files changed, 73 insertions(+), 58 deletions(-)

-- 
2.43.0


