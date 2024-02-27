Return-Path: <linux-kernel+bounces-83882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA4E869FBE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05701C28685
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7FB51009;
	Tue, 27 Feb 2024 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BYpMobqR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E661E894;
	Tue, 27 Feb 2024 19:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060501; cv=none; b=Yki7BDVrnxoGPKHLrZxdhoZfFw7oOIaQixIWP28p+rHTTYVt5Z21K/wsMKpJvVejFZF5V3dHOQeHbQbzwg+vSB/WXW/1C/NhElf+6o7K/i5htLyYMhH6mn/OYFEohGkPtM+lMKrZXMpF/0jkKFd9+rqAnmho5WZYPplIDBWIPAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060501; c=relaxed/simple;
	bh=1jD16RvjY0XylQTcKSUd8r17c2C6yBRNbcx+ZdpItzc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HaTKWq3Lj/A/23hpiYsEkmnH7ey+lvQqYpKRs8PCVD2Psc7C7SyxxDAJAGjSHoT78F5xyl0sQ2pfKfmL3Xnby5XzO0ibfnAOB+WMSBhAFOoUsm4v5zYYlMFXJOAxP4TF3cz1Y4HkebPDS/z4CSTj4YL2qZyUm8+WRnHP3CWAQyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BYpMobqR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709060499; x=1740596499;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1jD16RvjY0XylQTcKSUd8r17c2C6yBRNbcx+ZdpItzc=;
  b=BYpMobqRBb8lTbnwTMiSVDLSo6H6dQyGfgaagka6JGMELGzHxNzH22t5
   2eGVQ4gUS0jKBui0wI8PpW8I00GCAaw6VFJuE+SNWi3hDf+fwhH/1vhfC
   sqBAMZyqvFn+h1FVK6lnPHu9w6atapLo19CPrbFz9vG/hHpluR6FhCcVE
   44KfYzIj7Ax1frEZSZUH0KCaOWLrJGJl8RcgEMxAhR1IfzEI8RS1lBicI
   peb98Ig8d30+4m2iUpOtz4KjC+g6AdPMm141H/R0OqfaqWedrIr4Ac1cF
   0vYc7YDaQw5zmL22dfeY5WDQ8R2kGSxEX3b/2P+n7tNJyKOinqq1vrM2g
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3293079"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3293079"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 11:01:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="11725838"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 11:01:37 -0800
Received: from debox1-desk4.lan (unknown [10.251.6.149])
	by linux.intel.com (Postfix) with ESMTP id D5D41580DEF;
	Tue, 27 Feb 2024 11:01:36 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH V2 1/3] platform/x86/intel/vsec: Remove nuisance message
Date: Tue, 27 Feb 2024 11:01:32 -0800
Message-Id: <20240227190134.1592072-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

intel_vsec_walk_header() is used to configure features from devices that
don't provide a PCI VSEC or DVSEC structure. Some of these features may
be unsupported and fail to load. Ignore them silently as we do for
unsupported features described by VSEC/DVSEC.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

V2 - no changes

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


