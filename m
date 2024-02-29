Return-Path: <linux-kernel+bounces-86482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DA686C613
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B6228A39F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F275062805;
	Thu, 29 Feb 2024 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2AqZ5L1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137C662154
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709200451; cv=none; b=WPuh253q/WGid+j/a0AEfT/8M73Ue9ZAP2reu7bdzran677/SSuttm40U0gTskZeuXm6a1JdvHOKewgrYefW/5uV/a32Ua0+IHeR5UbubA5lcA2bytCn441XFJiA0FFkkz9JGGbOcy6Uaj37Xykty3LDvnvoDojbBqvcAVtP/Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709200451; c=relaxed/simple;
	bh=2wXxdGYUOltk7Lzm5DmMsD3Q83xGW/4pr62gkHYUHlA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sQ1jLKTE2AJSYdXFmFg2tPT+3MUTaUNxdCEeWN4E504bJRChd9B7k9n73afhbPx5qctwgV1+gxkAGbwk7njm+7WEP3oFNetZWbRs8OO4N8dWjjSLSOwaKFOTlEDnmTQM2y5gCKgqwDDGgZD0SsY326Bxcz4aZ6K4kkRbsWvgyLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2AqZ5L1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709200450; x=1740736450;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2wXxdGYUOltk7Lzm5DmMsD3Q83xGW/4pr62gkHYUHlA=;
  b=E2AqZ5L13IQyJ1zgjzDn27I/QSs8Z2XMiXvDNxV9rUnb3nToJak+ev06
   SMxI+oDUGxnzZC9k7kArs6JItQGmvVfEkjYSpjQfO6lsgWNKY4jS0njp8
   wiuRCqlLq7kQMsLQfe9TCKqNpRTdCcOMLhqyykX9YtvoZrrwvq/ckwGl6
   y/41lCqQrKgCT/hmGp/FyiSLgowHRiiGSdxVVS1E66ElWc/ldr+Lo79iJ
   IoptBtp5USL9ROEMWpo4YXk7VJ3AINHYkO6fGtDiR8t/wLr2c09NwVtJW
   /t/Z4cGcpkgrTrvAmwXqJRbllgUZt6Y7B5PB6yE5ZaE87cBD4QO2nLUKw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="7480761"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7480761"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 01:54:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7695758"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 29 Feb 2024 01:54:07 -0800
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
Subject: [PATCH 0/3] iommu: Fix domain check on release (part 2/2)
Date: Thu, 29 Feb 2024 17:48:01 +0800
Message-Id: <20240229094804.121610-1-baolu.lu@linux.intel.com>
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

This change includes cleanups and refactoring in the Intel iommu driver
related to the use of the iommu_ops->release_domain.

There are two parts of this topic:
[ ] Introduce release_domain and fix a kernel NULL pointer dereference
    issue in the intel iommu driver.
[x] A follow-up series to cleanup intel iommu driver.

Best regards,
baolu

Lu Baolu (3):
  iommu/vt-d: Setup scalable mode context entry in probe path
  iommu/vt-d: Remove scalable mode context entry setup from attach_dev
  iommu/vt-d: Remove scalabe mode in domain_context_clear_one()

 drivers/iommu/intel/pasid.h |   1 +
 drivers/iommu/intel/iommu.c | 183 +++++++++++-------------------------
 drivers/iommu/intel/pasid.c | 116 +++++++++++++++++++++++
 3 files changed, 174 insertions(+), 126 deletions(-)

-- 
2.34.1


