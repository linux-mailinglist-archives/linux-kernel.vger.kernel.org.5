Return-Path: <linux-kernel+bounces-52915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5C6849E4C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22CC0B28093
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF8D2FE2D;
	Mon,  5 Feb 2024 15:32:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A664F3A1CC
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707147168; cv=none; b=uFqlXWXyQR8CeFj0tO/bzlSw4vyAtMeMGZWGylIBdiarBuzgqNxTj7zl/BZdf6baH/vBUVCKCOLIH5ytnn0sRYt/aws8GntIwC9Q0Yz+EqkX2sweHXtWwHSCxYebAB85tR5F0+gYdL87oBKNSb0MBk2hXJjOeirKVY9bN+WeIvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707147168; c=relaxed/simple;
	bh=KmaKj/FrqhODuXe1TaDfgqvAe8TWKw+amUWGmKbLRCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ButnB937uNJqO88QJlmLS+ITrpGqFT3pdMb/36T73MUYGUIAmlXhImOF3zBEaZ3ORR593sewAzx5cQ4cgxlH6Yq/6W1Sv9sMOk+5KE9fPfmZaPRakq5hg5DvPv4U/08oIarFbOWWrh6gRaK4jcSdfl2vnZxLZxcdfEJY1fdP1sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF7771FB;
	Mon,  5 Feb 2024 07:33:28 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 05AD03F5A1;
	Mon,  5 Feb 2024 07:32:44 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Cc: will@kernel.org,
	pasha.tatashin@soleen.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rientjes@google.com,
	yosryahmed@google.com,
	john.g.garry@oracle.com
Subject: [PATCH v3 0/3] iommu/iova: use named kmem_cache for iova magazines
Date: Mon,  5 Feb 2024 15:32:38 +0000
Message-Id: <cover.1707144953.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

I decided that Pasha's patch[1] was a good excuse to tackle a bit more
cleanup of the existing IOVA code, so it can fit in more neatly. Thus
to save time and effort I've taken the liberty of putting together this
mini-series as the version I'd like to merge.

Cheers,
Robin.

[1] https://lore.kernel.org/linux-iommu/20240202192820.536408-1-pasha.tatashin@soleen.com/


Pasha Tatashin (1):
  iommu/iova: use named kmem_cache for iova magazines

Robin Murphy (2):
  iommu/iova: Tidy up iova_cache_get() failure
  iommu/iova: Reorganise some code

 drivers/iommu/iova.c | 143 +++++++++++++++++++++++--------------------
 1 file changed, 76 insertions(+), 67 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty


