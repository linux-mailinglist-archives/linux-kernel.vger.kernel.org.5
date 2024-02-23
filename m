Return-Path: <linux-kernel+bounces-77781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26C6860A2B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5177B287D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A401173A;
	Fri, 23 Feb 2024 05:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BU23r05Q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C828101C1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708665543; cv=none; b=N4rXu38PNIzjaxC4Fa4eoW0H5BYZQeKGn9nWgCLFo312QX2BVKljM4JJ633dv+IjcuQN5K4I1SDZWqP8cQi1Bwv0W493gLYFw9AO9wOQ4QCz7BnsrSVJTKs7ghjStTsCh2uKtPQUfEYCA4MOhuCkbNAxlczXrHCjBKhkMyHuxIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708665543; c=relaxed/simple;
	bh=H2XeO8lmUCg3AbvczavG13/6CA2n5O1kZYTojrAKZco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q7jb8eYllITkpyB3+BqgxIa1IEsxV1ALfuE7iyrYCCTufNTrlxpDs40TVITH2TXsaV4gU/o49L6gerFuOAAB0HE8ipiZbAzFSuMnZXlsQECrwcHsmG5CIDw+HXFRJcu1jvrYnCjn2Kr7D52UGjF9OHgAFjYyju4Rj7Dg1WOeN9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BU23r05Q; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708665542; x=1740201542;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H2XeO8lmUCg3AbvczavG13/6CA2n5O1kZYTojrAKZco=;
  b=BU23r05QaL7dyECVIrKCXF2p3b3k3eY0vwr5C2jKshAWOgGvQVMsm3HS
   B6lnTAR8oXCKrrka1SidiqJpsr2ATld+KTYZHDmPPGPnVcNEOV9/DAWID
   W65x71gaHkYj09TRXQUv1BOmuiH5CHh8nqtJLO0CSCxXux+BhUTn1E3o2
   UsmgH0hyE1C2k2U0F5cfxgblshifk/mIigALEd5IZrAKTW84q3zWiCndL
   tEblw0Gzad0U4wV1SzK+Y3kjQq4B2gOYVCa7GITVl6f+721jMkT7lDoh8
   eyuuKoSuMSoBWxFauQAIATpcj5R0Tn/ZZtDnuCjQ4sxoJkEcb8VAsreGu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="28395427"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="28395427"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 21:19:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5999886"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa006.fm.intel.com with ESMTP; 22 Feb 2024 21:18:59 -0800
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
Subject: [PATCH 0/2] iommu: Fix domain check on device release
Date: Fri, 23 Feb 2024 13:13:00 +0800
Message-Id: <20240223051302.177596-1-baolu.lu@linux.intel.com>
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

It fixes a NULL pointer reference in the Intel iommu driver and
strengthens the iommu core to possibly prevent similar failures in other
iommu drivers.

Best regards,
baolu

Lu Baolu (2):
  iommu: Add static iommu_ops->release_domain
  iommu/vt-d: Fix NULL domain on device release

 include/linux/iommu.h       |  1 +
 drivers/iommu/intel/iommu.c | 26 +-------------------------
 drivers/iommu/iommu.c       | 12 ++++++++++++
 3 files changed, 14 insertions(+), 25 deletions(-)

-- 
2.34.1


