Return-Path: <linux-kernel+bounces-92367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D14871F24
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9352876B5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0D95A783;
	Tue,  5 Mar 2024 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iMEw791Q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9600059B5E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641648; cv=none; b=t2hzj/zEG+plgXd3mHebz5fFoCGUuoNXf4CkMKpWmbOMZ3Q3liCL3FR5W8bXZmz9nJMwwl/WCzaZPJsIYI+VD0wglgpKneBoIfedaqzOsBNBPXjmj+5S/c8mMm8NulAMNWNoZCf2luMI6lThCSQvLmLNpz5cUucnKIXNIGbk3FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641648; c=relaxed/simple;
	bh=tHGSzpNgFAnQLpcHyJJSFp9ntY6zZ4loKg8cLSXThnw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jO13lUPfA3q2aEHmAyV4JTLVxex0Qy2oUguyOmnp7yY3aye1UePv2aKTcH41YJtWu26Q301QhT/g8j/lq0cfKR9XiYKH/sG+iUKUHMn+b18k7YdV1Ij/Ykzl4hbxVUHEuUQ9NTXL6q47yV6/cuMhgdt3fkpEj4yonReg0k7YcqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iMEw791Q; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709641646; x=1741177646;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tHGSzpNgFAnQLpcHyJJSFp9ntY6zZ4loKg8cLSXThnw=;
  b=iMEw791Q9WQrHTMuhD7chskcVVkAe+XTF0qJKHrsB+UoxvywBcfc2tNJ
   ICTb+SWd2Pj08CKDpCFcopYLatY0uKbBzEeJCH65X2whwWmu2WGX/xlYM
   wdpilx7UHij+E/Herfb51nQKuFiOvOCR1iCLcZpFnw48v2WWnDlg/Zuue
   ghR7XhejbsVFiX83dWTIi5m9Q2e9odv7jGnJpj/xuKNNNCsJsr+kDd2kd
   uac8lduwH8V1yXEJ/iQDZhCtVn3YXQYBtZ42pKrumelVQWgy+BQVbPTE3
   pr6yBryM3hNx5N+i4X+oytmxQeNBuFOFovA+OO2tM+1rnfybXQ3nji15T
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="21648428"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="21648428"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 04:27:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9330063"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 05 Mar 2024 04:27:24 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>,
	Eric Badger <ebadger@purestorage.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] [PULL REQUEST] iommu/vt-d: Fixes for iommu next
Date: Tue,  5 Mar 2024 20:21:13 +0800
Message-Id: <20240305122121.211482-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following fixes have been queued for iommu next:

 - Fix hard lockup on hotplug of an ATS-capable device
 - Fix NULL domain pointer dereference on device release

These changes are not critical for v6.8, so can you please consider them
for iommu next?

Best regards,
baolu

Ethan Zhao (3):
  PCI: Make pci_dev_is_disconnected() helper public for other drivers
  iommu/vt-d: Don't issue ATS Invalidation request when device is
    disconnected
  iommu/vt-d: Improve ITE fault handling if target device isn't present

Lu Baolu (5):
  iommu: Add static iommu_ops->release_domain
  iommu/vt-d: Fix NULL domain on device release
  iommu/vt-d: Setup scalable mode context entry in probe path
  iommu/vt-d: Remove scalable mode context entry setup from attach_dev
  iommu/vt-d: Remove scalabe mode in domain_context_clear_one()

 include/linux/iommu.h       |   1 +
 include/linux/pci.h         |   5 +
 drivers/iommu/intel/pasid.h |   2 +
 drivers/pci/pci.h           |   5 -
 drivers/iommu/intel/dmar.c  |  22 ++++
 drivers/iommu/intel/iommu.c | 214 +++++++++++-------------------------
 drivers/iommu/intel/pasid.c | 205 ++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c       |  19 +++-
 8 files changed, 313 insertions(+), 160 deletions(-)

-- 
2.34.1


