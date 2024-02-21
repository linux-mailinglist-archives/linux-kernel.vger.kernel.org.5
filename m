Return-Path: <linux-kernel+bounces-75502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B5C85E9AB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3D11F22E7A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E66C127B57;
	Wed, 21 Feb 2024 21:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lU4/mMVe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA49A86AD5;
	Wed, 21 Feb 2024 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549926; cv=none; b=SDL40+OzzDUOjiXk0RzFPo8nOcgEorXjN8/tSdklmMSLEME3lYUkkxNYq/QOYwzaBPAOV7Qe7PwWQbkoi3UxBJ7AraaAjtI+rkwUyBbtL6i2oNXRW07RDPCo2icATSVQFMtPuYtHzg4TVDprHkJOBJzEImOs5laAwcb+7lH0Bis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549926; c=relaxed/simple;
	bh=iu4KbvHGlcFRRSdY9K/Jk/Zeck2ywiKqKuPQgDf0Gjo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Xai7F4mDyFWICEO78MWovEfMWzmDuTjLVHXAQsaf3nGf2PWdd01FO8yYZMRZhiryp9MBB6iHQUG8u9MOOHmi8AL27fSzgxJLfsrUgcbiad6v7wdp/ZKq4FlD8byRGYvPRnQZpVp+0wCoTh7aZDAFr/ph2AJ/+Sxj60duaUctuR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lU4/mMVe; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708549925; x=1740085925;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iu4KbvHGlcFRRSdY9K/Jk/Zeck2ywiKqKuPQgDf0Gjo=;
  b=lU4/mMVeWQKC+WhF9G+shO4BAsY9DbnbiSc/u+JQ51B/pGZ1rIJZKB94
   cH04ZEpp1Yp3e0mrxMYoPRAflnJdmONT8KZ+LI5YSIdyGevSsx7xzwxt4
   yY489DeM7zguEE2pGUFn9AtgdECKMJsMuHH/1v+G26NGgarI3ryUdahiq
   4fQEFDxPJ0M/Sv+qPNbgQVHUKtg4vFO8iXkTM1fMtvjc2dZYej5xP1Mcu
   K/QzpLgg/bs+nu2l6SeDUEvuJHjbs+lZd1rsixEYGwAiem2fMZXXhCrH0
   2z1cZrwgOy27NY5vH28wOWGrqDm9acSMMt2GbpL75BkwqTXLVjTFZkNsO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13865875"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="13865875"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 13:12:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="9934209"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 13:12:04 -0800
Received: from debox1-desk4.lan (unknown [10.209.70.184])
	by linux.intel.com (Postfix) with ESMTP id 31027580DB4;
	Wed, 21 Feb 2024 13:12:04 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH 1/3] platform/x86/intel/vsec: Remove nuisance message
Date: Wed, 21 Feb 2024 13:12:01 -0800
Message-Id: <20240221211204.515159-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_vsec_walk_header() is used to configure features from devices that
don't provide a PCI VSEC or DVSEC structure. Some of these features may
be unsupported and fail to load. Ignore them silently as we do for
unsupported features described by VSEC/DVSEC.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/vsec.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 778eb0aa3479..0fdfaf3a4f5c 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -236,10 +236,7 @@ static bool intel_vsec_walk_header(struct pci_dev *pdev,
 
 	for ( ; *header; header++) {
 		ret = intel_vsec_add_dev(pdev, *header, info);
-		if (ret)
-			dev_info(&pdev->dev, "Could not add device for VSEC id %d\n",
-				 (*header)->id);
-		else
+		if (!ret)
 			have_devices = true;
 	}
 

base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de
-- 
2.34.1


