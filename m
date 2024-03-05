Return-Path: <linux-kernel+bounces-91499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B58871263
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4E91F22EE6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10DD17C7F;
	Tue,  5 Mar 2024 01:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PerJ+l1z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FB617C6A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 01:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709602759; cv=none; b=jEMMnIVkMv4aCozcuodnQ/ezYMLxBtTtbDrB2D2qZFZodxQFyP3Eq+8Of70OyeUV8FIWyqIxrTZh/CMG8ws/9cywzs3zBZgyQys6JvalOqVfrS0Zcp8jIa2FYTJVohDN+iBLohw41HPMeNgrsGWfeeJW3j1FXDHUGe2m8Wtsxjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709602759; c=relaxed/simple;
	bh=eiU/1NcIOJEtkEHiA5OyoXSA8xSvI1Z67moJ09F+JIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BgmXDjgLj5y2ExVvGKWm6jRUIsVlt3wlpFW3TeO4KrS7aRa1d77NBuKr+M+rPG+n3ozK0LGj90Bsq28jgZoq3L2WsRuvrFEkwvRqHhIek5xAd1P9WpUVy4vPA/v8lHRT4X/a6/R/jaPfA0b3QQFfpPZdtT0VS+hlXTL46DYJt4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PerJ+l1z; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709602758; x=1741138758;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eiU/1NcIOJEtkEHiA5OyoXSA8xSvI1Z67moJ09F+JIc=;
  b=PerJ+l1zz/QQE0AO1UB9d2Vxtvmd910J279dlUWvvcQNOP5iR9prdAPx
   J+C3SG2IJpoYGCtG2W4VVypmUWtoR5uLf20O05bmeQisVMPVUw4wmDJJG
   nyRuq7jZyzO8UQ5rZmWN2+OwZSHcD72mB8/rFOfJH9P/OU3WJI8/wgUn7
   F7+2ZCAxvuzzGcaINvujXcvGTeASLMHlaLJiYyZyrzgTDgluBo/E1ht2m
   mpVUokH+GLapC+C8IIVFZC1o2fyspZXcFaNSshs965L7nY9esES0OE4zW
   Cso/NUbPn7rWG1WT/ZeXODQbeOKLYU3PPGPPUJGGdTAtkRtnRzFTx62re
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4286682"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4286682"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 17:39:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="13865421"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 04 Mar 2024 17:39:14 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Eric Badger <ebadger@purestorage.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 0/5] iommu: Fix domain check on release
Date: Tue,  5 Mar 2024 09:33:00 +0800
Message-Id: <20240305013305.204605-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up to the discussion thread here:

https://lore.kernel.org/linux-iommu/20240221154012.GC13491@ziepe.ca/

It fixes a NULL pointer dereference issue in the Intel iommu driver and
strengthens the iommu core to possibly prevent similar failures in other
iommu drivers.

There are two parts of this topic:
[x] Introduce release_domain and fix a kernel NULL pointer dereference
    issue in the intel iommu driver.
[x] Follow-up patches to cleanup intel iommu driver.

Best regards,
baolu

Change log:
v3:
 - Avoid global IOTLB and PASID cache invalidation in normal release
   path to mitigate the impact on other devices.
 - Comment and code refinements.

v2:
 - https://lore.kernel.org/linux-iommu/20240229094613.121575-1-baolu.lu@linux.intel.com/
 - https://lore.kernel.org/linux-iommu/20240229094804.121610-1-baolu.lu@linux.intel.com/
 - The scalable mode context entry should be removed in the release path
   as it's not part of the blocking domain.

v1: https://lore.kernel.org/linux-iommu/20240223051302.177596-1-baolu.lu@linux.intel.com/

Lu Baolu (5):
  iommu: Add static iommu_ops->release_domain
  iommu/vt-d: Fix NULL domain on device release
  iommu/vt-d: Setup scalable mode context entry in probe path
  iommu/vt-d: Remove scalable mode context entry setup from attach_dev
  iommu/vt-d: Remove scalabe mode in domain_context_clear_one()

 include/linux/iommu.h       |   1 +
 drivers/iommu/intel/pasid.h |   2 +
 drivers/iommu/intel/iommu.c | 214 +++++++++++-------------------------
 drivers/iommu/intel/pasid.c | 202 ++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c       |  19 +++-
 5 files changed, 283 insertions(+), 155 deletions(-)

-- 
2.34.1


