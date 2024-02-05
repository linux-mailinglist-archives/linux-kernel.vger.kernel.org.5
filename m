Return-Path: <linux-kernel+bounces-53273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA22C84A2FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57F16B268CC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7624878F;
	Mon,  5 Feb 2024 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEtdUvhm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1548A48CC1;
	Mon,  5 Feb 2024 19:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159697; cv=none; b=V5ygstYHT5PElL75cOVOoNEvuebOX6VqLCQhLiIVn79FnCRD09QHwtnsIsiaG/jY+aXHADOjSdcZV4MK3vq+sERVSiaLcYFzVbDftxyjuXbtXr+ibm5o10jsDDG3O+ly0AAarWfKTmYpTqogz8J+7N3c3izDDxJd6b1S/awEjeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159697; c=relaxed/simple;
	bh=qXT6n/Xz8TGqf2KpHYW4visUF18bBDgbINzKQ8xLz0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=teUpLMaG8odHKBDXA8rfRhIhnXo8/2kYNTC8Zrog6Ys6MsEPEliD2gzwqVABAR5laelnu+qC6mXs0Rd7HbDRXq39QdhM+fcAJFQ0q5U7oPTatSHcNnOA+Lt9qqiWySWjRL34raQI66EITgxueo+beLEkD+2WwSeVeSIP7Jts28k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEtdUvhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA939C4166B;
	Mon,  5 Feb 2024 19:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707159696;
	bh=qXT6n/Xz8TGqf2KpHYW4visUF18bBDgbINzKQ8xLz0s=;
	h=From:To:Cc:Subject:Date:From;
	b=AEtdUvhmlT6Q4z2ceE1S+VpZHbA1rQEw8LO+Bf9ETCZgbd5ufIs6vM741g/Q1erY3
	 iMGw6ItvBEer3EgK3/IjPwBqeUyC0wFxJKJi0BEDpfeCs7dT2SMFjBkmzKcYwnUthQ
	 WhFfz5iTvetNX+ZxtVlfj7t4egZ8PyHbQmkHyLVeII7nobppWisVcBQOZMDByw/Jkb
	 qPLCTlbjBlSBSTy4ss5xYgKC3b5E0kaXBuKNu5cwCBpZKrs4crm/8AR/BZQl4XTORR
	 p7Sxw9/iybUH35eJgPdaYL+6/igMauYf/6XDG8mUy/tmLL8nCpYXoYbE3WM8+Id2o6
	 MaepARhHxl+og==
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
Subject: [PATCH v3 0/3] Fix double allocation in swiotlb_alloc()
Date: Mon,  5 Feb 2024 19:01:24 +0000
Message-Id: <20240205190127.20685-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This is version three of the patches I posted recently:

v1: https://lore.kernel.org/r/20240126151956.10014-1-will@kernel.org
v2: https://lore.kernel.org/r/20240131122543.14791-1-will@kernel.org

Thanks to Robin for the comments on the most recent version.

Changes since v2 include:

  - Restore missing 'continue' statement that got accidentally dropped
    while addressing the initial round of review feedback.

  - Reword the commit message in patch #1

  - Add a Fixes: tag to the last patch

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
  swiotlb: Fix double-allocation of slots due to broken alignment
    handling
  swiotlb: Enforce page alignment in swiotlb_alloc()
  swiotlb: Honour dma_alloc_coherent() alignment in swiotlb_alloc()

 kernel/dma/swiotlb.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


