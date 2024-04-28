Return-Path: <linux-kernel+bounces-161344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ABD8B4AFA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5382F2818A4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8D956B70;
	Sun, 28 Apr 2024 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fG1z85dd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD12B55E44;
	Sun, 28 Apr 2024 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714296285; cv=none; b=n5ZI5+lnne5keSflFkCpA0kvrOlDj7EMZyjXb/5DqhOsvEg8MKy6wdDvmTjBILR88FRtVabN3EvLVLNMDn8Vr+mPlIPkl832+yo8Y38tafveHXdi5v2Mgk2tfOJ2Vb0X0D+6jSsoPQtvQy/byra/ZpVo2nfTneIVzrGGG11tptU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714296285; c=relaxed/simple;
	bh=b99iJg1A5bvxRUOumWSxLIxtvCLHK+sA+lw4WRmUyxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pck/d82gxnCiDszHJfmR/liSsgk9gZavNjGQP/7gyyLp/ZZC88OGoOKaG0e+w1ksd8jcD01Ch2A9jLelfeGyRG2/ayxaq4+kmyZ33JmzJoExOUipZULao5p7K/piNtEEZ8NQ1SiReQXZXroelcUgCfcljhVyMYcXkF4rqAffQxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fG1z85dd; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714296284; x=1745832284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b99iJg1A5bvxRUOumWSxLIxtvCLHK+sA+lw4WRmUyxA=;
  b=fG1z85ddBL60eGRQfQ75jPadQjp71JFtKVAtzyCZFIOZX0S7q7cT8lZ1
   pu8s3YRZ1CCkz2vJxeyfYBBcfyoLa5aHJajpgLvOFJQtEc5StLGroUH/W
   SrDrSVR3pKu6IddQv5C27LzdHfyjstk8c2769pBCm598W1cn/oc+O7ZVQ
   d4TICgMNpcIcG5+gQCxxfdObyjBbxtU0MtBuuPSotz/2vklRAUdhMzauI
   e9D4VKC7Ihwq1BtRWhTVr27i2ckEtUgTqjxhXMVvWoodwaqoVDvZ93Lgz
   FL0yJy4wEpd8LIwvvmNtMQ+Dl12q3hebf1w94dNAlUV1cqWYcNRmzx8wg
   w==;
X-CSE-ConnectionGUID: mAYSY7uLTWiVYKJ+BoppCg==
X-CSE-MsgGUID: K4hRrW0VRDyL1wecwcdQdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="21127808"
X-IronPort-AV: E=Sophos;i="6.07,237,1708416000"; 
   d="scan'208";a="21127808"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 02:24:43 -0700
X-CSE-ConnectionGUID: fMNH5MR1Tnq19pG9plIG+g==
X-CSE-MsgGUID: LXgfmWeETViRf/KcoJgHFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,237,1708416000"; 
   d="scan'208";a="63303784"
Received: from xingyeyu-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.249.169.4])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 02:24:41 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@intel.com
Subject: [PATCH V4 2/2] powercap: intel_rapl_tpmi: Enable PMU support
Date: Sun, 28 Apr 2024 17:24:27 +0800
Message-Id: <20240428092427.24959-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240428092427.24959-1-rui.zhang@intel.com>
References: <20240428092427.24959-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable RAPL PMU support for TPMI RAPL driver.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/powercap/intel_rapl_tpmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/powercap/intel_rapl_tpmi.c b/drivers/powercap/intel_rapl_tpmi.c
index f6b7f085977c..947544e4d229 100644
--- a/drivers/powercap/intel_rapl_tpmi.c
+++ b/drivers/powercap/intel_rapl_tpmi.c
@@ -302,6 +302,8 @@ static int intel_rapl_tpmi_probe(struct auxiliary_device *auxdev,
 		goto err;
 	}
 
+	rapl_package_add_pmu(trp->rp);
+
 	auxiliary_set_drvdata(auxdev, trp);
 
 	return 0;
@@ -314,6 +316,7 @@ static void intel_rapl_tpmi_remove(struct auxiliary_device *auxdev)
 {
 	struct tpmi_rapl_package *trp = auxiliary_get_drvdata(auxdev);
 
+	rapl_package_remove_pmu(trp->rp);
 	rapl_remove_package(trp->rp);
 	trp_release(trp);
 }
-- 
2.34.1


