Return-Path: <linux-kernel+bounces-123867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34255890F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B92D5B216CD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE2324B33;
	Fri, 29 Mar 2024 00:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QypkNz3K"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3294222F0A;
	Fri, 29 Mar 2024 00:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671379; cv=none; b=qCVpt/ss5xyk/ol0TCgx0sWCaATTiBZZQxMcOUS3EgDYsN1tERMGqvAaKFH302iUq2MuSd4qL7ywN99b4K4sId2DINARKraN8taaQHmdJvQUzNsRAlpprVWoQctFh0niKTsaOZIFa3kMsKC0Ul/abQs+Z22yNjLLDpEXCfLvVVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671379; c=relaxed/simple;
	bh=8/4VlWP8EU8J4WP6IAOfUM/N7VC8BLu0hjzTJ6eRtKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jb1DZrUBCorqEuzehPLw3v9dWT3/aLK9b4N9rXpj9lkEu0RQfJHZwwLN1MHVPI7UEtRRygM+dM1g9ZG4KpHc2DnkDcTDCFrtOyxKsQjpFqWc9f9i/zJh3GFf1jYtyHihnqQoF+Uyi1fCiyhUM+aWGtPYx+NfxqgX3N7MRw300fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QypkNz3K; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711671378; x=1743207378;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8/4VlWP8EU8J4WP6IAOfUM/N7VC8BLu0hjzTJ6eRtKE=;
  b=QypkNz3KhWsXdtq10v8KhjN0RCq0S3+wIx3dXPMxbXHmItEt5VGeX9ab
   fOVkmJYJ0jRq+Jj+Xy3dw9Ry9Aooq/t2XCVdV+2rkD/n0UZwsG7qA7T/M
   aVuleeW62YuICCCZ+v3Zi1xdkNOSYYuqS/qp3xV0t7Zqwkk8a9epX2jd3
   OMFf/VHWlgz9b4oinPS4OpQUuGmHz8fedkeaW7CDt5XEdu6QyyFsQPN/v
   zFtRWq/p8rjsjTjl/t3+PTjJmHw+/Bvf5xpLlQbR7xXjsy/LI2o/oZwkR
   xVbsKDI9fwIwzk8KAakksLwDgxe2sL6wYn22TILi4VdgQmm1jj6Xq+HQv
   A==;
X-CSE-ConnectionGUID: rA5AXqzJSeORxQN26yqbYA==
X-CSE-MsgGUID: eTcNOIPFT2CdjdWlWFvGJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="7050389"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="7050389"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 17:16:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17451476"
Received: from sj-4150-psse-sw-opae-dev3.sj.intel.com ([10.233.115.74])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 17:16:02 -0700
From: Peter Colberg <peter.colberg@intel.com>
To: Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Alan Tull <atull@kernel.org>,
	Shiva Rao <shiva.rao@intel.com>,
	Kang Luwei <luwei.kang@intel.com>,
	Enno Luebbers <enno.luebbers@intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	kernel test robot <lkp@intel.com>,
	Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH] fpga: dfl: fme: fix kernel-doc comments for some functions
Date: Thu, 28 Mar 2024 20:15:42 -0400
Message-ID: <20240329001542.8099-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Yilun <yilun.xu@intel.com>

lkp reported 2 build warnings:

   drivers/fpga/dfl/dfl-fme-pr.c:175: warning: Function parameter or member 'feature' not described in 'dfl_fme_create_mgr'

>> drivers/fpga/dfl/dfl-fme-pr.c:280: warning: expecting prototype for
>> dfl_fme_destroy_bridge(). Prototype was for dfl_fme_destroy_bridges()
>> instead

Fixes: 29de76240e86 ("fpga: dfl: fme: add partial reconfiguration sub feature support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Peter Colberg <peter.colberg@intel.com>
---
 drivers/fpga/dfl-fme-pr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index cdcf6dea4cc9..96cb24787ab1 100644
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -166,6 +166,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
  * dfl_fme_create_mgr - create fpga mgr platform device as child device
  * @feature: sub feature info
  * @pdata: fme platform_device's pdata
+ * @feature: the dfl fme PR sub feature
  *
  * Return: mgr platform device if successful, and error code otherwise.
  */
@@ -273,7 +274,7 @@ static void dfl_fme_destroy_bridge(struct dfl_fme_bridge *fme_br)
 }
 
 /**
- * dfl_fme_destroy_bridges - destroy all fpga bridge platform device
+ * dfl_fme_destroy_bridges - destroy all fpga bridge platform devices
  * @pdata: fme platform device's pdata
  */
 static void dfl_fme_destroy_bridges(struct dfl_feature_platform_data *pdata)
-- 
2.44.0


