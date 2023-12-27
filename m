Return-Path: <linux-kernel+bounces-12076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F8A81EFAF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23CCC1C218A6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E8245BF9;
	Wed, 27 Dec 2023 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="hnJQS6E5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.tkos.co.il (hours.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC2A45959;
	Wed, 27 Dec 2023 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id D227F440EEA;
	Wed, 27 Dec 2023 17:02:42 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1703689363;
	bh=y8Nqn3nQCHk0ZkaLekGkm1wv2WHjXjHEQwYVdlqYNw4=;
	h=From:To:Cc:Subject:Date:From;
	b=hnJQS6E5gkFfPmVbn1G49jTHXsTmr28HHzApegH3Nh9uekRNg9Nbx84gIjPyM3meI
	 B8aDIqGf/Cr0ZojHC7jU8qFTXNPe1NRx/vx/d9LhZ3tWMp5ciEu2nvUHwI6e7bhxza
	 xO5ybfJWayCkTVkJEUz7SGOFZ13gv3Hq/0ZSAJl/oEJ9L5n5lcsdhrhAZr4Vb04R6Z
	 Ho0ve/unVDMr1V8ygeQNTlk1OsaVmZse2wMAEBJBfWzOh7D/3p6mJCX8cqvXFRKrF0
	 hOKP8FT6xS/ukTmxy1iYpucdb2Cus5fLrSV3LUfP9lILR0YnojWWhRtCNqttY+Ez7K
	 Ut+N1A26VCJhQ==
From: Baruch Siach <baruch@tkos.co.il>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Baruch Siach <baruch@tkos.co.il>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Petr=20Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>
Subject: [PATCH RFC 0/4] arm64: support DMA zone starting above 4GB
Date: Wed, 27 Dec 2023 17:04:24 +0200
Message-ID: <cover.1703683642.git.baruch@tkos.co.il>
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

[0] See commit 791ab8b2e3db ("arm64: Ignore any DMA offsets in the 
    max_zone_phys() calculation")

[1] https://lore.kernel.org/all/9af8a19c3398e7dc09cfc1fbafed98d795d9f83e.1699464622.git.baruch@tkos.co.il/

Baruch Siach (4):
  of: get dma area lower limit
  of: unittest: add test for of_dma_get_cpu_limits() 'min' param
  dma-direct: add offset to zone_dma_bits
  arm64: mm: take DMA zone offset into account

 arch/arm64/mm/init.c       | 18 +++++++++++++-----
 drivers/of/address.c       | 38 +++++++++++++++++++++++++++-----------
 drivers/of/unittest.c      | 17 ++++++++++-------
 include/linux/dma-direct.h |  1 +
 include/linux/of.h         | 11 ++++++++---
 kernel/dma/direct.c        | 10 ++++++----
 kernel/dma/pool.c          |  2 +-
 kernel/dma/swiotlb.c       |  5 +++--
 8 files changed, 69 insertions(+), 33 deletions(-)

-- 
2.43.0


