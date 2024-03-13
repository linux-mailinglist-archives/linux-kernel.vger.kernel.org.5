Return-Path: <linux-kernel+bounces-102275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4927287B01A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044792861FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9025512CD9B;
	Wed, 13 Mar 2024 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAK6WNBb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C53912CD94
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351282; cv=none; b=lrn/HVW7OAhD8w9snm8NGf83BRvyVkSlc58U0TgrEf+Z/eoNm5me46nKnITUQFIux+A2oR8h4n/MDanOk625gFE8sXALURcs8pGr8lbixOJ+QwOmewXfAcigZvVaIWlWcqhQcLPRX9GHHyfEvo9Bxf01zDMOMS3WD02ty6xp/rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351282; c=relaxed/simple;
	bh=hcmCNGQf3LZVFWDeyJ0vaw/0Q23MVCylFqJOi+YXmTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5cMoz8YxHDasJ3zoscT5dtSO6F5tdWOyz60tBqu1r+TuNc5hAkh79VnMAZdqz3BkIE4GbCaS/ph5JDPS/bQz/3XcnXnMrPBsn326FKLKqkegm9lQ8p8ItHXRdAOoSuMgsGG7KKTh67KoQHPFmWAQ5ls6Tqc7Kh5gSfDhffTjr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dAK6WNBb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710351281; x=1741887281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hcmCNGQf3LZVFWDeyJ0vaw/0Q23MVCylFqJOi+YXmTE=;
  b=dAK6WNBbFdoR5EE8Vm/tR2cC/bcLVZJnSUEiMpzVSOwskksMj2yNU91V
   DQBrqnXk2+xPnyYRJg2XUJq29lxW5rAOvG/6X5Tc2qvnuukpYpitWWR+g
   zQ6ZEMXBC0NX7zr27atA17F7YHmee/dV2Bmi7+ryH9X/evj51su2Htdt3
   QuHHtEkvlG3aorQ4ZNVF4iVs5Nhm7oXUiU+jS6qL3shA+hOgovLoHsO5U
   ZJMqHaOKSfs+1dGj5B6glJbVxQHpAzxRm4BdJ9ZLizfLYyK38CzQDCOzB
   ekx+qe/T8hZE2NLgCnsG3bM7tEURXHPjMNqLxH5J1ezmnLVKEShdKEV2r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="15772894"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="15772894"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 10:34:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="35132868"
Received: from unknown (HELO localhost) ([10.237.72.159])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 10:34:39 -0700
From: Aapo Vienamo <aapo.vienamo@linux.intel.com>
To: mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: mika.westerberg@linux.intel.com,
	Aapo Vienamo <aapo.vienamo@linux.intel.com>
Subject: [PATCH v2 2/2] mtd: core: Don't fail mtd_otp_nvmem_add() if OTP is unsupported
Date: Wed, 13 Mar 2024 19:34:25 +0200
Message-ID: <20240313173425.1325790-3-aapo.vienamo@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240313173425.1325790-1-aapo.vienamo@linux.intel.com>
References: <20240313173425.1325790-1-aapo.vienamo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle the case where -EOPNOTSUPP is returned from OTP driver.

This addresses an issue that occurs with the Intel SPI flash controller,
which has a limited supported opcode set. Whilst the OTP functionality
is not available due to this restriction, other parts of the MTD
functionality of the device are intact. This change allows the driver
to gracefully handle the restriction by allowing the supported
functionality to remain available instead of failing the probe
altogether.

Signed-off-by: Aapo Vienamo <aapo.vienamo@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/mtd/mtdcore.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index c365c97e7232..9e18422fdc77 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1014,7 +1014,11 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 
 err:
 	nvmem_unregister(mtd->otp_user_nvmem);
-	return dev_err_probe(dev, err, "Failed to register OTP NVMEM device\n");
+	/* Don't report error if OTP is not supported. */
+	if (err != -EOPNOTSUPP)
+		return dev_err_probe(dev, err,
+				     "Failed to register OTP NVMEM device\n");
+	return 0;
 }
 
 /**
-- 
2.41.0


