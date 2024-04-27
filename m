Return-Path: <linux-kernel+bounces-160906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 143BD8B4460
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 07:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378571C22572
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 05:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7316140850;
	Sat, 27 Apr 2024 05:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IxL2+X0w"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674AB41C64
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 05:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714195822; cv=none; b=IeHPEuqhJ/ZPyelTrckjNFj+uXeEQhE1vUYwlKSdjmtjgPHO+bHS8YFassO+GZ8CFYgBhZmrn+Bb7nSdSvMyg3BXbIbkprt/g3iBCjQoSxD3QQpFltRdl6Xubu6N4MKsE7uZMY+rbXhHHQtE4b9C7oMukQvOrrKK7oBg5oM9+C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714195822; c=relaxed/simple;
	bh=2rXCF1cjT+QHm8WnliQ61ZmiTsOPl4xRY1+aGo+jg1A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=erfJZNVy8kwCfdOW0dxzpkxCh8BKgrrw5q7EOf75Jr/k8/wLLSQwnpa++nQtHdBaTY4S8fv9gzHlHfhEIKLsSd4a/yAZ7L8o7hJLbqAqCNMtohZoIkZTn9W3YnSuXK4F1NaRHtwnFSzMc+GqIDEtK0FWYkH4p60KdAvtWEThf94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IxL2+X0w; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43R5T8jx127815;
	Sat, 27 Apr 2024 00:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714195748;
	bh=0O40gQDPXgpzSv3czKXsh1hPTkc4wVRxlVY7EIyxO5Y=;
	h=From:To:CC:Subject:Date;
	b=IxL2+X0woi90tEOAKXfc1+3yy3RvEtj3SskMATuQX5OplDbEolHg0R5SbuxSrUA3f
	 oz57aFk2elSt89dGF+TsauBwStgjLh+S/OvzK3B1ktC1DJKi+3VUcfv+BtfdpMAGEf
	 pTQR7KjDsmU7TQuJAFnc7CTMkKFWT1/ZWY14xZKE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43R5T8OE109822
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 27 Apr 2024 00:29:08 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 27
 Apr 2024 00:29:07 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 27 Apr 2024 00:29:07 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.109])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43R5T2bc035757;
	Sat, 27 Apr 2024 00:29:02 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13916275206@139.com>, <mimperial@lenovo.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <liam.r.girdwood@intel.com>, <bard.liao@intel.com>,
        <yung-chuan.liao@linux.intel.com>, <kevin-lu@ti.com>,
        <cameron.berkenpas@gmail.com>, <tiwai@suse.de>, <baojun.xu@ti.com>,
        <soyer@irl.hu>, <Baojun.Xu@fpt.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] ALSA: ASoc/tas2781: fixed wrong loading calibrated data sequence
Date: Sat, 27 Apr 2024 13:28:57 +0800
Message-ID: <20240427052858.265-1-shenghao-ding@ti.com>
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

Calibrated data will be set to default after loading dsp config params,
which will cause speaker protection work abnormally. Reload calibrated
data after loading dsp config params.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Change in v1:
 - Download calibrated data after loading the new dsp config params
 - call tasdevice_prmg_load instead of tasdevice_prmg_calibdata_load, it
   is unnecessary to load calibrated data after loading dsp program. Load
   it after loading dsp config params.
 - Remove tasdevice_prmg_calibdata_load, because it is unnecessary to load
   calibrated data after loading dsp program.
 - work in bypass-dsp mode even if no dsp fw loaded.
---
 include/sound/tas2781-dsp.h       |  3 +-
 sound/soc/codecs/tas2781-fmwlib.c | 96 +++++++------------------------
 sound/soc/codecs/tas2781-i2c.c    |  4 +-
 3 files changed, 23 insertions(+), 80 deletions(-)

diff --git a/include/sound/tas2781-dsp.h b/include/sound/tas2781-dsp.h
index ea9af2726a53..14a4a254ad2a 100644
--- a/include/sound/tas2781-dsp.h
+++ b/include/sound/tas2781-dsp.h
@@ -2,7 +2,7 @@
 //
 // ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
 //
-// Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+// Copyright (C) 2022 - 2024 Texas Instruments Incorporated
 // https://www.ti.com
 //
 // The TAS2781 driver implements a flexible and configurable
@@ -180,7 +180,6 @@ void tasdevice_calbin_remove(void *context);
 int tasdevice_select_tuningprm_cfg(void *context, int prm,
 	int cfg_no, int rca_conf_no);
 int tasdevice_prmg_load(void *context, int prm_no);
-int tasdevice_prmg_calibdata_load(void *context, int prm_no);
 void tasdevice_tuning_switch(void *context, int state);
 int tas2781_load_calibration(void *context, char *file_name,
 	unsigned short i);
diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
index 45760fe19523..c21bce6f09d6 100644
--- a/sound/soc/codecs/tas2781-fmwlib.c
+++ b/sound/soc/codecs/tas2781-fmwlib.c
@@ -2,7 +2,7 @@
 //
 // tasdevice-fmw.c -- TASDEVICE firmware support
 //
-// Copyright 2023 Texas Instruments, Inc.
+// Copyright 2023 - 2024 Texas Instruments, Inc.
 //
 // Author: Shenghao Ding <shenghao-ding@ti.com>
 
@@ -2210,21 +2210,9 @@ int tasdevice_select_tuningprm_cfg(void *context, int prm_no,
 		for (i = 0; i < tas_priv->ndev; i++) {
 			if (tas_priv->tasdevice[i].is_loaderr == true)
 				continue;
-			else if (tas_priv->tasdevice[i].is_loaderr == false
-				&& tas_priv->tasdevice[i].is_loading == true) {
-				struct tasdevice_fw *cal_fmw =
-					tas_priv->tasdevice[i].cali_data_fmw;
-
-				if (cal_fmw) {
-					struct tasdevice_calibration
-						*cal = cal_fmw->calibrations;
-
-					if (cal)
-						load_calib_data(tas_priv,
-							&(cal->dev_data));
-				}
+			if (tas_priv->tasdevice[i].is_loaderr == false
+				&& tas_priv->tasdevice[i].is_loading == true)
 				tas_priv->tasdevice[i].cur_prog = prm_no;
-			}
 		}
 	}
 
@@ -2247,9 +2235,24 @@ int tasdevice_select_tuningprm_cfg(void *context, int prm_no,
 			if (tas_priv->tasdevice[i].is_loaderr == true) {
 				status |= 1 << (i + 4);
 				continue;
-			} else if (tas_priv->tasdevice[i].is_loaderr == false
-				&& tas_priv->tasdevice[i].is_loading == true)
+			}
+
+			if (tas_priv->tasdevice[i].is_loaderr == false
+				&& tas_priv->tasdevice[i].is_loading == true) {
+				struct tasdevice_fw *cal_fmw =
+					tas_priv->tasdevice[i].cali_data_fmw;
+
+				if (cal_fmw) {
+					struct tasdevice_calibration
+						*cal = cal_fmw->calibrations;
+
+					if (cal)
+						load_calib_data(tas_priv,
+							&(cal->dev_data));
+				}
+
 				tas_priv->tasdevice[i].cur_conf = cfg_no;
+			}
 		}
 	} else
 		dev_dbg(tas_priv->dev, "%s: Unneeded loading dsp conf %d\n",
@@ -2308,65 +2311,6 @@ int tasdevice_prmg_load(void *context, int prm_no)
 }
 EXPORT_SYMBOL_NS_GPL(tasdevice_prmg_load, SND_SOC_TAS2781_FMWLIB);
 
-int tasdevice_prmg_calibdata_load(void *context, int prm_no)
-{
-	struct tasdevice_priv *tas_priv = (struct tasdevice_priv *) context;
-	struct tasdevice_fw *tas_fmw = tas_priv->fmw;
-	struct tasdevice_prog *program;
-	int prog_status = 0;
-	int i;
-
-	if (!tas_fmw) {
-		dev_err(tas_priv->dev, "%s: Firmware is NULL\n", __func__);
-		goto out;
-	}
-
-	if (prm_no >= tas_fmw->nr_programs) {
-		dev_err(tas_priv->dev,
-			"%s: prm(%d) is not in range of Programs %u\n",
-			__func__, prm_no, tas_fmw->nr_programs);
-		goto out;
-	}
-
-	for (i = 0, prog_status = 0; i < tas_priv->ndev; i++) {
-		if (prm_no >= 0 && tas_priv->tasdevice[i].cur_prog != prm_no) {
-			tas_priv->tasdevice[i].cur_conf = -1;
-			tas_priv->tasdevice[i].is_loading = true;
-			prog_status++;
-		}
-		tas_priv->tasdevice[i].is_loaderr = false;
-	}
-
-	if (prog_status) {
-		program = &(tas_fmw->programs[prm_no]);
-		tasdevice_load_data(tas_priv, &(program->dev_data));
-		for (i = 0; i < tas_priv->ndev; i++) {
-			if (tas_priv->tasdevice[i].is_loaderr == true)
-				continue;
-			else if (tas_priv->tasdevice[i].is_loaderr == false
-				&& tas_priv->tasdevice[i].is_loading == true) {
-				struct tasdevice_fw *cal_fmw =
-					tas_priv->tasdevice[i].cali_data_fmw;
-
-				if (cal_fmw) {
-					struct tasdevice_calibration *cal =
-						cal_fmw->calibrations;
-
-					if (cal)
-						load_calib_data(tas_priv,
-							&(cal->dev_data));
-				}
-				tas_priv->tasdevice[i].cur_prog = prm_no;
-			}
-		}
-	}
-
-out:
-	return prog_status;
-}
-EXPORT_SYMBOL_NS_GPL(tasdevice_prmg_calibdata_load,
-	SND_SOC_TAS2781_FMWLIB);
-
 void tasdevice_tuning_switch(void *context, int state)
 {
 	struct tasdevice_priv *tas_priv = (struct tasdevice_priv *) context;
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index b5abff230e43..9350972dfefe 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -2,7 +2,7 @@
 //
 // ALSA SoC Texas Instruments TAS2563/TAS2781 Audio Smart Amplifier
 //
-// Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+// Copyright (C) 2022 - 2024 Texas Instruments Incorporated
 // https://www.ti.com
 //
 // The TAS2563/TAS2781 driver implements a flexible and configurable
@@ -414,7 +414,7 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
 				__func__, tas_priv->cal_binaryname[i]);
 	}
 
-	tasdevice_prmg_calibdata_load(tas_priv, 0);
+	tasdevice_prmg_load(tas_priv, 0);
 	tas_priv->cur_prog = 0;
 out:
 	if (tas_priv->fw_state == TASDEVICE_DSP_FW_FAIL) {
-- 
2.34.1


