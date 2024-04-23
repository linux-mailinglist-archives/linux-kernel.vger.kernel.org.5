Return-Path: <linux-kernel+bounces-154854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370EB8AE200
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67AF28398E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A8E61691;
	Tue, 23 Apr 2024 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="X8rQjt+D"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C286D1A9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867832; cv=none; b=XwHzu3GvMiRVz2W6vHQwbBN/ON4N427nJAS/Nmn6JWPxrAzGBejXvU72TYEsLqabflonG/GzMP/ckNuhLPY/OQ1h6aSdRIO9RNOE2EcvEj3Vua54JO/dO2M9Np4D0hMXj+whhcRa4zYN9JOREZlxm/p6ULATaUbC3m43Nb3qdtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867832; c=relaxed/simple;
	bh=rw+6R+nzVHr2DchNxm7cW1XESdq7NtcMktvw4P66jts=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZVVclPKD2PosXCfW134EgL2LwcKfgxc650DKuj8PgBZ17FA6Vc67/yWeV+6egtQIfezw1BHiFAii0jWg8WILUtdv/us9T7Ah7aBBnLVrR7GrGeYBL1ADuy/rVmejUQ/KHw0a+ink6uSMQ0YjQHO2DBb2E6W7x0+vpA9QFY5Zjc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=X8rQjt+D; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N5qOAr019606;
	Tue, 23 Apr 2024 05:23:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=I
	w6V43y3Cb122Py+ZPFtXAxE8lyjqCSdyyCRpwjHM+k=; b=X8rQjt+DQV28aHGbl
	9zyOv0woxTzTBn2Cg8B+okaVqmPI3vo4mAk31m1oYBOti0OP/8p5CtunbXL31jkb
	sHB1v/w5WVr9I1JhQycFCPwv7JL7t9w9Cfhl8zwetUpVliyOldK33qmAPdDKq4o+
	ltQV+ZEZJXRIbCtnqIzVFAjQUSaSI9avcwwj1SbSPAQiJS9rrzPORV7S0iozu/oG
	6OfUhUhDiZW05yjEYlgugM5S6FuO4LqR9H8oXoMZsZLa2zf1YukK7eINAkgXlAKq
	My3OLwLLNCBSvAtvWea6iDfrHs7dDNvFyLPb+PB6xi7jiQICYi5KnQy9GXAtfb0O
	gx4hw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xmqmh1xu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 05:23:41 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 11:23:39 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Tue, 23 Apr 2024 11:23:39 +0100
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 612B1820242;
	Tue, 23 Apr 2024 10:23:39 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <lee@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH] mfd: cs42l43: Update patching revision check
Date: Tue, 23 Apr 2024 11:23:39 +0100
Message-ID: <20240423102339.2363400-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _Oa1XF70cGf9wqyIqW4Yx0km86vFkBsG
X-Proofpoint-GUID: _Oa1XF70cGf9wqyIqW4Yx0km86vFkBsG
X-Proofpoint-Spam-Reason: safe

The firmware can only be patched once. The current code checks if the
firmware supports the features required by the driver and then patches
if it does not. This could lead to the device being patched twice if
the device was patched before the driver took control, but with a
firmware that doesn't support the features the driver requires. This
would fail but potentially in unpredictable ways.

The check should actually check the device is at the ROM version, and
patch the device if it is. Then a separate later check should error out
if the devices firmware is still too old to be supported. This will at
least fail in a clean way with a nice error message.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/cs42l43.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
index a0fb2dc6c3b2..ae8fd37afb75 100644
--- a/drivers/mfd/cs42l43.c
+++ b/drivers/mfd/cs42l43.c
@@ -43,6 +43,9 @@
 #define CS42L43_MCU_UPDATE_TIMEOUT_US		500000
 #define CS42L43_MCU_UPDATE_RETRIES		5
 
+#define CS42L43_MCU_ROM_REV			0x2001
+#define CS42L43_MCU_ROM_BIOS_REV		0x0000
+
 #define CS42L43_MCU_SUPPORTED_REV		0x2105
 #define CS42L43_MCU_SHADOW_REGS_REQUIRED_REV	0x2200
 #define CS42L43_MCU_SUPPORTED_BIOS_REV		0x0001
@@ -709,6 +712,23 @@ static void cs42l43_mcu_load_firmware(const struct firmware *firmware, void *con
 	complete(&cs42l43->firmware_download);
 }
 
+static int cs42l43_mcu_is_hw_compatible(struct cs42l43 *cs42l43,
+					unsigned int mcu_rev,
+					unsigned int bios_rev)
+{
+	/*
+	 * The firmware has two revision numbers bringing either of them up to a
+	 * supported version will provide the disable the driver requires.
+	 */
+	if (mcu_rev < CS42L43_MCU_SUPPORTED_REV &&
+	    bios_rev < CS42L43_MCU_SUPPORTED_BIOS_REV) {
+		dev_err(cs42l43->dev, "Firmware too old to support disable\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /*
  * The process of updating the firmware is split into a series of steps, at the
  * end of each step a soft reset of the device might be required which will
@@ -745,11 +765,10 @@ static int cs42l43_mcu_update_step(struct cs42l43 *cs42l43)
 		  ((mcu_rev & CS42L43_FW_SUBMINOR_REV_MASK) >> 8);
 
 	/*
-	 * The firmware has two revision numbers bringing either of them up to a
-	 * supported version will provide the features the driver requires.
+	 * The firmware has two revision numbers both of them being at the ROM
+	 * revision indicates no patch has been applied.
 	 */
-	patched = mcu_rev >= CS42L43_MCU_SUPPORTED_REV ||
-		  bios_rev >= CS42L43_MCU_SUPPORTED_BIOS_REV;
+	patched = mcu_rev != CS42L43_MCU_ROM_REV || bios_rev != CS42L43_MCU_ROM_BIOS_REV;
 	/*
 	 * Later versions of the firmwware require the driver to access some
 	 * features through a set of shadow registers.
@@ -794,10 +813,15 @@ static int cs42l43_mcu_update_step(struct cs42l43 *cs42l43)
 			return cs42l43_mcu_stage_2_3(cs42l43, shadow);
 		}
 	case CS42L43_MCU_BOOT_STAGE3:
-		if (patched)
+		if (patched) {
+			ret = cs42l43_mcu_is_hw_compatible(cs42l43, mcu_rev, bios_rev);
+			if (ret)
+				return ret;
+
 			return cs42l43_mcu_disable(cs42l43);
-		else
+		} else {
 			return cs42l43_mcu_stage_3_2(cs42l43);
+		}
 	case CS42L43_MCU_BOOT_STAGE4:
 		return 0;
 	default:
-- 
2.39.2


