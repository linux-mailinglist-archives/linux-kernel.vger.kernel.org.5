Return-Path: <linux-kernel+bounces-156456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E2E8B02F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5351AB2209E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CA5360;
	Wed, 24 Apr 2024 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aj1eIAiL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DA3157A55
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943093; cv=none; b=Pn/Xd97PTv2LrGA+TqSqRrm/Y7VYuNSbkkL0d10PQCYu4Kw5k71QL8vGwfop1T66H7ox4tI0bZ0GhsRPelgwvcJT58XZwPsn+pq4UfrZrRRIYOXkc5r8GYI0BUX3vwdu2euzDo6OGYDlllOqHzlYOe6iuLlo3ucaDruLCBgK44M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943093; c=relaxed/simple;
	bh=rHvTSou8/1tjMflgd49XX0brDYVz5e086lRWrdYfOqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KD2FXzJ2egOZbY75xE1HNViUPBBKII2J5xSVPSKKFAfj3H0RoEIcc1MWCBGw7kv1a9xsB9SNSxVpCwPigrAdkFpooQi4a+ZCbcyVJ216+9kGNBLJC9SefTfjCTzh7SH9rXoAXtCQhtjBkg12u35DpF2B5pNBSUR04H3+eMIyRaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aj1eIAiL; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713943092; x=1745479092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rHvTSou8/1tjMflgd49XX0brDYVz5e086lRWrdYfOqU=;
  b=aj1eIAiLlCMhFMsGJ/ElQQ60l63sWJ4LLJQtL9cYVfNNEAfng/+daKLL
   ifxfq5Cc3iUZOu0Qu9Tai2bNzZzyb2KsSQil4qxtl2YWIYZ0Oyqi+ORWd
   X1CorPlpxrW+U2soxUB3sjXPXeQHiXEBGTJQnuRDtPUvVmgIvZh99rW4i
   zVxgqQmrYC9d5Q5FW7n/VR6L2K39ju80YKE0iwMnfaTLLuCxxfHVkuLn1
   bC4XZ1AOqRGcd534efLySlU0pEk25ACV16uVxMlF+THHKij8+mw2behSh
   O8YMS6I835woHXBXdhlJEUOqOpGBXokiKGS/fU9H7cqeY7AsWQkT3MNyf
   g==;
X-CSE-ConnectionGUID: LIj3PxRNT6uGqvJVwbOdwA==
X-CSE-MsgGUID: rbOOBUq2SpyTLmpElw/KPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27073083"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27073083"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 00:18:12 -0700
X-CSE-ConnectionGUID: dBBdC8bbSQiYj5zuD91yuw==
X-CSE-MsgGUID: GfVKluqPRAaPI5u/XhXE0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="24664637"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 24 Apr 2024 00:18:09 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jingqi Liu <Jingqi.liu@intel.com>,
	Dimitri Sivanich <sivanich@hpe.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/18] iommu/vt-d: Remove redundant assignment to variable err
Date: Wed, 24 Apr 2024 15:16:27 +0800
Message-Id: <20240424071644.178250-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424071644.178250-1-baolu.lu@linux.intel.com>
References: <20240424071644.178250-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Colin Ian King <colin.i.king@gmail.com>

Variable err is being assigned a value that is never read. It is
either being re-assigned later on error exit paths, or never referenced
on the non-error path.

Cleans up clang scan build warning:
drivers/iommu/intel/dmar.c:1070:2: warning: Value stored to 'err' is
never read [deadcode.DeadStores]`

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Link: https://lore.kernel.org/r/20240411090535.306326-1-colin.i.king@gmail.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/dmar.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 36d7427b1202..351be9455214 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1067,7 +1067,6 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 		goto error_free_seq_id;
 	}
 
-	err = -EINVAL;
 	if (!cap_sagaw(iommu->cap) &&
 	    (!ecap_smts(iommu->ecap) || ecap_slts(iommu->ecap))) {
 		pr_info("%s: No supported address widths. Not attempting DMA translation.\n",
-- 
2.34.1


