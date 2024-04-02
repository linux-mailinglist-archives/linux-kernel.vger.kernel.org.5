Return-Path: <linux-kernel+bounces-128821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCD4895FF9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25704282BF4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A59B3D962;
	Tue,  2 Apr 2024 23:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JlzdbCsY"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915D3224FA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 23:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712099662; cv=none; b=EQzSQqkPLiUZBzCb9oaKxewSe1UGaz+zq4n6VQ1VHys0zl5zUPIHt6fWpug/OZhMv/b2ty7BogGdovmWK0+QMcVjpeTs1R/krev9I3nUWoE8qcvTcpKvoZMDVzUDnT9R0YLoe3i2eLzM6WgBfp86BYppFYhqYnsOHKsXhVQt82U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712099662; c=relaxed/simple;
	bh=ddv8AXcImUc1yJ2JhZqXVMKUk2Ef0WsWS5fYbrV19Js=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TJ5+2ZaVOVSyHn+Ii2w+12EG4CC+BNIMybPbP7QFzIHyAVr8lFUM0YYmicKj/BRoY/bWX+Zt8a+yvai/bYHVC319X4WJSrS2dcNwckZEBp99C2xINMl3UnZjBpHoCJjdbTHRlNdsscHfJBnDDBxyTeAr5wTTzveIDvhYeDaT058=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JlzdbCsY; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 432NDClw016329;
	Tue, 2 Apr 2024 18:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712099592;
	bh=O0oYdII2vD1Cf4f9qF3j7cAB4KhlfaRrH5JemREzMRU=;
	h=From:To:CC:Subject:Date;
	b=JlzdbCsYnt3uA57yrz0qYFV9dAomTlEsHtLG1jLNy8nstiRE7Iv69O/Skjw1lBFFm
	 ygPERUXT8I7RSads5Fcj7+vhJAsUDU7w5IPzqlqmVr/6z++opB9nr6x5UalaiZPfKR
	 nIwYmFZn9qbeGByGKxPakOsBvLd8coT2dz3QGv9w=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 432NDC5F002128
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Apr 2024 18:13:12 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Apr 2024 18:13:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Apr 2024 18:13:12 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.160.249])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 432ND40I019262;
	Tue, 2 Apr 2024 18:13:05 -0500
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
Subject: [PATCH v1] ALSA: hda/tas2781: correct the register for pow calibrated data
Date: Wed, 3 Apr 2024 07:12:59 +0800
Message-ID: <20240402231300.362-1-shenghao-ding@ti.com>
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

fixed tas2781 calibrated data - pow was written into a wrong register.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 sound/pci/hda/tas2781_hda_i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 48dae3339305..116821ae3cb3 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -514,10 +514,10 @@ static int tas2563_save_calibration(struct tasdevice_priv *tas_priv)
 static void tas2781_apply_calib(struct tasdevice_priv *tas_priv)
 {
 	static const unsigned char page_array[CALIB_MAX] = {
-		0x17, 0x18, 0x18, 0x0d, 0x18
+		0x17, 0x18, 0x18, 0x13, 0x18
 	};
 	static const unsigned char rgno_array[CALIB_MAX] = {
-		0x74, 0x0c, 0x14, 0x3c, 0x7c
+		0x74, 0x0c, 0x14, 0x70, 0x7c
 	};
 	unsigned char *data;
 	int i, j, rc;
-- 
2.34.1


