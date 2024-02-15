Return-Path: <linux-kernel+bounces-66362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAD0855BAB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1341C21362
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C41DDDF;
	Thu, 15 Feb 2024 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUB9eZGz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4C712B7C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707982132; cv=none; b=jF3d92kiyVgZs5zyioEcGBa37mNzCPo6a1JP5kP0OUfDGtqIqmTM3h/ZqdVuLWq6pJpxav0AcvLLDdkWxs7DAmNfu2luReJMAlSagfX/KwQMTq3qR9rPZ/rYaHSEwgT6BKj2QYDIZ2LSgqYVTU8aUJNMmCMl07rq7zF9KdH1Bo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707982132; c=relaxed/simple;
	bh=BGali8YR19f9ZRyzTwoqv3iiNG9oSUbGHt1wVtsRN2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MF1YcbiVepPy/1SFK7gw/0JzHP9v52M8TEzzqLS4cb4KgK4LjQZtHRH4lx2xuX6pqO84bIgqKXayeAFRrtRaBHVlDUYvL38D0xRCiKf45EEhgxjKFKwPs05g4DNCKxc8b3Uph9xtl090yy35CGXPkf/ckTEteXFYycKtcsijzm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hUB9eZGz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707982129; x=1739518129;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BGali8YR19f9ZRyzTwoqv3iiNG9oSUbGHt1wVtsRN2w=;
  b=hUB9eZGzHlHudCoJR/sKTeOEveQbLp+dZ9ObgosQppQYcmPV/pAv7Xle
   trezkfH9lqeS/EmmaHw/7a9ydjM4luIm3GJWRlJXeSz5CdgY6u9XwTFWR
   ROXmM8nxh4gnjWUuJuznMz3O+geXmRDjJpPj8bFAOIwUc/DJHZ61qG+ZN
   IBbfS3flJQChuYIkz8KkxSBNbHJnpOlQeC4EhYI7MEw44tiUo4EzQ5RX6
   uqJqXZLZP+jlc1jjn/zp+kSF57JED+uUww+Bi4WFqLDjYG7Sa3+Nvm0Mx
   kugyyurpUvN2F/cOdD0OvwOty6kR86d+Jkzeawd+7yVWK5h+icAkhoFDU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2182705"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="2182705"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 23:28:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912113130"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="912113130"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga002.fm.intel.com with ESMTP; 14 Feb 2024 23:28:45 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Huang Jiaqing <jiaqing.huang@intel.com>,
	Ethan Zhao <haifeng.zhao@linux.intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/2] iommu/vt-d: Introduce rbtree for probed devices
Date: Thu, 15 Feb 2024 15:22:47 +0800
Message-Id: <20240215072249.4465-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up to the discussion thread here:

https://lore.kernel.org/linux-iommu/20240201193427.GQ50608@ziepe.ca/

This proposes a per-IOMMU red-black tree for iommu probed devices. It
benefits fault handling paths, where the VT-d hardware reports the
Source ID of the related device, and software needs to retrieve the
corresponding device pointer based on this ID.

Lu Baolu (2):
  iommu/vt-d: Use rbtree to track iommu probed devices
  iommu/vt-d: Use device rbtree in iopf reporting path

 drivers/iommu/intel/iommu.h |  8 ++++
 drivers/iommu/intel/dmar.c  |  3 +-
 drivers/iommu/intel/iommu.c | 91 ++++++++++++++++++++++++++++++++++++-
 drivers/iommu/intel/svm.c   | 14 +++---
 4 files changed, 105 insertions(+), 11 deletions(-)

-- 
2.34.1


