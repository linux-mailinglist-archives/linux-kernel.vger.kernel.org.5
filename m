Return-Path: <linux-kernel+bounces-86479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90D786C60E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47BC3B26F67
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128A962805;
	Thu, 29 Feb 2024 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="axfXhrnN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9311E6214F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200338; cv=none; b=sEyyqyWvTnBhX1YDDhr9ytn/omoKDwxGM5rSs+kc2yuWOSvTcmiDraN3BwLReecJmfT+yWTaK87WqZOWjE6gtTBcpfeo9qDFhcdMOqLYptpiIMGND3F7MQTbhFH0MfvZeaNiHwaYw2hu2xyyz/MUwJVb/+lHGB2BmJt2Zm5kqQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200338; c=relaxed/simple;
	bh=+9JxLT5TVumyzyybTc6fOlSoFtDJPx48dbrQoi3SRAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UxdqfMQtuJdwyT1PYFQXZzU9N7pe22ZcbL0Yfh4bA0E4nKeBUVwq35W+IJNma7Wy9rJRC9UI3kbpv0bMt9dFDXeHFOFTv7pjkj/NuMtSxKpa46Yn8THN8rL13rlmYljXcN7WdKcUeqrajNsSyJGIFQr3otrXxVIjLwRt1ZqANmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=axfXhrnN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709200335; x=1740736335;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+9JxLT5TVumyzyybTc6fOlSoFtDJPx48dbrQoi3SRAQ=;
  b=axfXhrnNSrATJPlm7k4kIq+nrcQd2+mywqN5Lup1sqKF2pTtnQe+wumz
   9ms818C/cQKikPQ0PeG/R8Ayib8ZEXhwE77bJ7DaXfXvKztSukrVq8IcY
   Pf+6QifLaTt3iuiK9wP0+mCHWbxQSiLju+F9LJRRtN9vYe0n+Cs79F2r+
   G5aJmgPV+tjubCJcEL0f3Jwi9X5woPLfr/Zdi8a5UKlvn2WDJqapF7ssw
   OiGNKNwF7xBTE0c3if66ai8CDLDDaE9RVpQlMOiMAx4DO3Punq9d7hSAT
   x9tEXi9DFwz+HAZPczFzuUfa2km/9yYNHlsDeRWHfXk2SHyiKz+Z08eqZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14366657"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="14366657"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 01:52:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="38811012"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 29 Feb 2024 01:52:13 -0800
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
Subject: [PATCH v2 0/2] iommu: Fix domain check on release (part 1/2)
Date: Thu, 29 Feb 2024 17:46:11 +0800
Message-Id: <20240229094613.121575-1-baolu.lu@linux.intel.com>
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
[ ] A follow-up series to cleanup intel iommu driver.

Best regards,
baolu

Change log:

v2:
 - The scalable mode context entry should be removed in the release path
   as it's not part of the blocking domain.

v1: https://lore.kernel.org/linux-iommu/20240223051302.177596-1-baolu.lu@linux.intel.com/

Lu Baolu (2):
  iommu: Add static iommu_ops->release_domain
  iommu/vt-d: Fix NULL domain on device release

 include/linux/iommu.h       |  1 +
 drivers/iommu/intel/pasid.h |  1 +
 drivers/iommu/intel/iommu.c | 31 +++-----------
 drivers/iommu/intel/pasid.c | 83 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c       | 19 +++++++--
 5 files changed, 106 insertions(+), 29 deletions(-)

-- 
2.34.1


