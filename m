Return-Path: <linux-kernel+bounces-117338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B758D88AA28
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226EF2C3D8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4077B1304B8;
	Mon, 25 Mar 2024 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMccrLQD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E243DABF3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379520; cv=none; b=o3Fi8z+F6ODuwE/wLq9qaoesqKqe+dQbmaJ2YE3H77ZtuhySccrA91kKc8PJBHO7koccoI+mCopRIhBK3+1FyKRmm0DvdPEP0JPQs1cyjkFrg1qw+hlJWpaSiwHSXwqteRcYuf298+DqS3kVi/ypveQkUzuUvLyDXRbI1qqZjVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379520; c=relaxed/simple;
	bh=CITzPrsB7IGveTJu7Ocldseg84+Ybt3DqMP9qIhYMac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eA0dOi/HALX+TydYu1eCEcwjA1oF88qGAMgp2X4wc2SRu4aZkapuW/+Zm0B7tJ0f2dfYSGs0JbTzItl/rUa6ShuwjdmKCF0F/sw9PJxqH1LeCKhfoZi9lEkfqdHAN5vN492wdZhZaegiOtYLZwhaOLQFv5yxloaLNeYtRAD1E+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMccrLQD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711379519; x=1742915519;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CITzPrsB7IGveTJu7Ocldseg84+Ybt3DqMP9qIhYMac=;
  b=YMccrLQDoLASemeboJfcm54vhcmqCdDaex3lP6RSiSepEqGFnKEZVuf3
   +CFsFq9UziZXVNuEdKivQ+2S1cqM7cbcKIMP6gDR1dreO1Th/Ww4BZfW7
   crBLzdujsPxP/N0FvUxDVMCXTLavW6ElWB0wzXgqEh4wAK/mq4H6xPOKZ
   Mh/H3TzC47OdsYGi94m8WOFLzkzl7tuQjaeViTEDHRsf4gOVUS1GqkBn4
   2RCloQrxhdolFQxVYtJglvswkIxQzFgyWiNhrqUzIF4HMsJkNxwVZYPZj
   pO6ovY/vKiVGswFKTg6anCKju08FeVFRXlP26xN75X4jdMgJ4X68hAXpX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6983830"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6983830"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 08:11:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070562"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070562"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 08:11:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 44E7A3C5; Mon, 25 Mar 2024 17:11:55 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mtd: core: Align comment with an action in mtd_otp_nvmem_add()
Date: Mon, 25 Mar 2024 17:11:50 +0200
Message-ID: <20240325151150.3368658-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment is related to the non-error case, make it more clear
by inverting the condition. It also makes code neater at the end.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mtd/mtdcore.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 9e18422fdc77..d0c231600f84 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1015,10 +1015,9 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 err:
 	nvmem_unregister(mtd->otp_user_nvmem);
 	/* Don't report error if OTP is not supported. */
-	if (err != -EOPNOTSUPP)
-		return dev_err_probe(dev, err,
-				     "Failed to register OTP NVMEM device\n");
-	return 0;
+	if (err == -EOPNOTSUPP)
+		return 0;
+	return dev_err_probe(dev, err, "Failed to register OTP NVMEM device\n");
 }
 
 /**
-- 
2.43.0.rc1.1.gbec44491f096


