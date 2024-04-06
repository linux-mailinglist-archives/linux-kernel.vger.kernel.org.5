Return-Path: <linux-kernel+bounces-133933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380FA89AB0F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24481F215DD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 13:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B63737141;
	Sat,  6 Apr 2024 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rn2nm+5H"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3936364CD
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712409710; cv=none; b=R5SQz2zMqGNZ76hrdGWXN6agCVZvqFEA0Cm5FOJgLkwiSl+uWom9kIe4RuyczgadF4hJO/6T7IcaY60eOAfGKHqEzOfawiSt4HovkDUyfVKSBxQMkZEdrgVEZ875Ia2Z/+8BrGEFUbqSEeT+eRpZ2uyn2C9lXn2p3mHPFaFQH8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712409710; c=relaxed/simple;
	bh=ZMt+t5X0UPIOOA6m/9szrjEDqQbT72VimPT91MbFNiE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PxJcf2sVI3lA5MPIKZa97x1JjtTZHWdJ7yTAljhSE0LqH4OCnz8MD6oOeTTdwEJw41q33F35j12BoySwUTc/Lp9BsavZa08gHH/cC61l4G1cN9YdusPtAYVi0O97FviwCQt5nXKt2miNxuZSvZtFoCXw5I80dJNJGcmeq/q1q8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rn2nm+5H; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 436DKIdt109838;
	Sat, 6 Apr 2024 08:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712409618;
	bh=39x7AmNp8Efzg8sUTGbGQMPThf+ziuu6HzOTHuarGAA=;
	h=From:To:CC:Subject:Date;
	b=rn2nm+5H14g7Dmqw4gH1ylBAQ1ZpdmW28jNIIfOH1ujqg9D9A/A/ll58qLg0L8/c3
	 2COkFVO8l7Mxdj3bjb6OvO6v0hov64YIjoUtKWm06IIPCs8f2xYD5ncPKhiwVSUV0g
	 Nl+eNAYmFDz4m/6zxs4ckXxfd3vP8TBNK0ylxaGk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 436DKIlZ012778
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 6 Apr 2024 08:20:18 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 6
 Apr 2024 08:20:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 6 Apr 2024 08:20:18 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.249])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 436DKCgl087460;
	Sat, 6 Apr 2024 08:20:13 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <bard.liao@intel.com>, <yung-chuan.liao@linux.intel.com>,
        <kevin-lu@ti.com>, <tiwai@suse.de>, <baojun.xu@ti.com>, <soyer@irl.hu>,
        <Baojun.Xu@fpt.com>, <navada@ti.com>, <v-po@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v3] ALSA: hda/tas2781: correct the register for pow calibrated data
Date: Sat, 6 Apr 2024 21:20:09 +0800
Message-ID: <20240406132010.341-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Calibrated data was written into an incorrect register, which cause
speaker protection sometimes malfuctions

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v3:
 - Add a bit more info desciption
 - No blank line between Fixes and Singed-off-by tags
 - https://lore.kernel.org/all/20240404122530.1049-1-shenghao-ding@ti.com/
---
 sound/pci/hda/tas2781_hda_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 48dae3339305..75f7674c66ee 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -514,10 +514,10 @@ static int tas2563_save_calibration(struct tasdevice_priv *tas_priv)
 static void tas2781_apply_calib(struct tasdevice_priv *tas_priv)
 {
 	static const unsigned char page_array[CALIB_MAX] = {
-		0x17, 0x18, 0x18, 0x0d, 0x18
+		0x17, 0x18, 0x18, 0x13, 0x18,
 	};
 	static const unsigned char rgno_array[CALIB_MAX] = {
-		0x74, 0x0c, 0x14, 0x3c, 0x7c
+		0x74, 0x0c, 0x14, 0x70, 0x7c,
 	};
 	unsigned char *data;
 	int i, j, rc;
-- 
2.34.1


