Return-Path: <linux-kernel+bounces-46415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2E0843F59
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7A71C28163
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9EA78B6B;
	Wed, 31 Jan 2024 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+6Cycw+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC3E762E1;
	Wed, 31 Jan 2024 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706703949; cv=none; b=GnCSCiOlJdrPxgNCM8Qo6JBeEcbpFxPAOOirJ4LydnB261vLFcEy3kASTHewylvEhOmDTH+XVAr7c0oi/Xxoj2upE2fzATdCxUEIoP1yjKDQtkksPpWT/UqYgs5cj/anPKP+RzCJ3/6hWfiudT50Vr96E05GdN1rAS0N+InY0Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706703949; c=relaxed/simple;
	bh=oSiwiqXjL3MXtK5womb3xjmKXeDs/dPHMKiXnUsL/VQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PgAkPG24+ntY8NodKydJJts+aMsMqc6rzxwvIwC9tj5nLiUM6ivTIemu9mJqSauIutQyIphpVTZyvpH5Gscwr6aKd5uiDxFC3x9f4MkVAQOid+dq5CJ48LqwHVSdT+fZ9DINYVHANJmMfk1lpIL/n3KO2lq+aFS8bKkz5SwkBLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+6Cycw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A068C433C7;
	Wed, 31 Jan 2024 12:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706703949;
	bh=oSiwiqXjL3MXtK5womb3xjmKXeDs/dPHMKiXnUsL/VQ=;
	h=From:To:Cc:Subject:Date:From;
	b=P+6Cycw+R2y+foOUIi6lj8KA+YlmZZniSey1FCiFahbTZbMOi3YSbaYg8avprIhJ8
	 IGoc3ejn/SmgQFNGGoyodvqxqLzDIRJCvh2gKYSxFpK+mAyyK7cF3Zf9BW/NYCJ9+N
	 S+Sxl5w9Ha/xlpWPM9Hv5LDt+EQagHkqi0FUtm/Lf20lMX16J+Kgiv+JU9K8eMtcq3
	 n5mA8M5lRBjfDhGcWk3f3sqA3V7km1rzvH0wOkukzFrz4BJ1bv4NBz4CX6N/9MvuAO
	 QfdiE212OqdXX32Flh8o1EngKW7uMCBKafD1GQr49ax09X2hDOZdVs2UMsnMYzE7zf
	 FGQbN8LdAg8Fw==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2 0/3] Fix double allocation in swiotlb_alloc()
Date: Wed, 31 Jan 2024 12:25:40 +0000
Message-Id: <20240131122543.14791-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is version two of the patches I posted last week:

https://lore.kernel.org/r/20240126151956.10014-1-will@kernel.org

Many thanks to Petr and Christoph for the discussion on that.

Changes since v1 include:

  - Fix swiotlb_alloc() to honour the alignment requirements of
    dma_alloc_coherent(). This is a new patch, and I think it's been
    broken forever (practically stopping at page alignment). I've left
    swiotlb_map() alone, so that doesn't necessarily return page-aligned
    DMA addresses, but I think that's ok.

  - Avoid updating 'alloc_align_mask' and instead just compute the
    'stride' directly to avoid a superfluous alignment requirement
    for mapping requests greater than a page.

  - Use get_max_slots() instead of open-coding the same logic.

  - Remove the extra 'goto' in swiotlb_search_pool_area() and collapse
    the conditionals instead.

  - Reword warning message when swiotlb_alloc() receives non page-aligned
    allocation.

  - Annotate non page-aligned case with unlikely().

Cheers,

Will

Cc: iommu@lists.linux.dev
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Petr Tesarik <petr.tesarik1@huawei-partners.com>
Cc: Dexuan Cui <decui@microsoft.com>

--->8

Will Deacon (3):
  swiotlb: Fix allocation alignment requirement when searching slots
  swiotlb: Enforce page alignment in swiotlb_alloc()
  swiotlb: Honour dma_alloc_coherent() alignment in swiotlb_alloc()

 kernel/dma/swiotlb.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


