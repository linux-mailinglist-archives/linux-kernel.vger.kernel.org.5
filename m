Return-Path: <linux-kernel+bounces-40011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE0583D8C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E85D1C2682A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66008134A9;
	Fri, 26 Jan 2024 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FcJK4Y4e"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C7F14273
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266766; cv=none; b=W2yTlIbpQa9/CR6IolOwWJSHaxXc1UxIJWJiTOiOIcnwEMPsqxC+mRvYgi/yYSy2f62mwEhf9VvdngUMIA/UEpraFZPgNCI9zlM4LDpJCnzTKfwd0eGbcbZck9lpua3NWsfsPpy1/G9aBa1wbe1GVthQ7eAOCRwHwlrI5PFNwBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266766; c=relaxed/simple;
	bh=Wl5UNtFVk8ZXZ4K+eceGuSpgE0BVMziZ4gm24eGRtS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hqwpcn+sspWdhG+UGPACLfMH0hDqBVbcnMkWAfTozjSt3Rz1YC6Iv5iUIIrlqWO6q6oFIF7FRNUk4Dmrg15PgSr2ErcbF3jtU1eHLo0/K8la0Xkgs3xu8x0X2udUJnOz3svzQRKkZ7cBbSWvT3XvM/62m3szXUrewRMfhERKBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FcJK4Y4e; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706266755; x=1737802755;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wl5UNtFVk8ZXZ4K+eceGuSpgE0BVMziZ4gm24eGRtS0=;
  b=FcJK4Y4eqGYRvbuIzCea3g2dO86nxfMT7gD1VGBZekE2n82eQtqn2FuW
   pPecwkZVgkRHiqXkVSkKjYJrjW7qPRPrp9ur5Ar9VjvGFy1oZd6TqtmNN
   TEvuknhZLKCSOvZabtyOEjQ8ADmS+DMbWW2leraHDTlWCXXCYrGJmehBl
   /2JL37zKFK7c6goK3WrohT7LLoqRfcTfB6NaK7oKJoE3KBMJbKZoEcbfK
   KiNB6D+xEkVxLY/mnS+CJVIM+RBNEIO31N7sXQhFYQG+rSnltxvZsW3lw
   6nwSN9X9cpXK4ahGCgSkWFsrauyqU7fnbEevT0RiwaHoA0JzpNT5sK9th
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9123351"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9123351"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 02:59:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="857367824"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="857367824"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jan 2024 02:59:12 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/2] Use right iommu_ops for mock device
Date: Fri, 26 Jan 2024 18:53:39 +0800
Message-Id: <20240126105341.78086-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the iommu probe device path, __iommu_probe_device() gets the iommu_ops
for the device from dev->iommu->fwspec if this field has been initialized
before probing. Otherwise, it will lookup the global iommu device list
and use the iommu_ops of the first iommu device which has no
dev->iommu->fwspec. This causes the wrong iommu_ops to be used for the mock
device on x86 platforms where dev->iommu->fwspec is not used.

Probe the right iommu_ops for device by iterating over all the global
drivers and calling their probe function to find a match.

Change log:
v2:
 - Iterate over all the global iommu drivers and calling their probe
   function to find a match.

v1: https://lore.kernel.org/linux-iommu/20240111073213.180020-1-baolu.lu@linux.intel.com/

Lu Baolu (2):
  iommu: Use mutex instead of spinlock for iommu_device_list
  iommu: Probe right iommu_ops for device

 drivers/iommu/iommu.c | 98 ++++++++++++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 39 deletions(-)

-- 
2.34.1


