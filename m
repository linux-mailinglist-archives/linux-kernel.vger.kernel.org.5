Return-Path: <linux-kernel+bounces-116943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABFD88A560
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C392E4C16
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9701CB31F;
	Mon, 25 Mar 2024 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XPUzT90z"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791771C5AAF;
	Mon, 25 Mar 2024 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711366311; cv=none; b=gL8xmisPk7rFP/5xmpkrdX+A1y/bk6CG2oJqwMzFGu64CssZ0ZyNNLChcT2H5oCn0mcNP8KVzdFb1JHVmwDEw95ASFy8MsKawDeCQijOPUplfCum2H2VALQAplYRotz/vW6OLHfUs+rasDaZ0LKR4WIXEcmvCVHk1qxpbusL1as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711366311; c=relaxed/simple;
	bh=icR7OHWR6JquUBWLnsXFZ4wZBk0R1ldLo6TRqTFJlQI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KoYIL7PW9CwvpxIZWkNxeBcjCSmlsUTpTdJB0VLQDc034ngv4wgaxc2SReZdPSCstsjxH4PNkurbIwDv42AmvNb1oKRdHpXFJsW8EM0RFdoQR8rLwKwC9HKICv7bkXXOHF5e13h4A3XFk7A+JpFyo8typhH/t70yei8Yr2QyOo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=XPUzT90z; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42P3P0Pm021761;
	Mon, 25 Mar 2024 06:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=BmoExtKFAN5u65MmJlIEn9jHB6pkbaLrjdksSjCZXAo=; b=
	XPUzT90ziie8P3UpHwidJ8F+M42nrVaSSgstdx5YSlqVnA0g6QvoO7kIfSH+r0G5
	XpDZPbkKlIvz28hvgPhsRhuJ5PnWavxRyrKVJcpFv51/z81ref6cEsALbirzK/Lv
	elmKGi09yAxsJ578DNMjSwHZ8K+UfBG7wt8oR66fTiyaVZy/hO/uDBoDZMZjRYqF
	Bi6P/3mxWt40owyWO/tDyQ94WIU0ksjGMIN9/cGMc1DxX5+ZoNwBWNiU4giLe5bf
	S/sKnJrUL/C79TtM3WqfjvatfGBlT9wE64VA/UKsYk74k31OSub613dMpMiyfTxU
	mhPiBXmNZzbbDQk8p4f7vQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x1vfyb6v1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 06:31:30 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 25 Mar
 2024 11:31:27 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Mon, 25 Mar 2024 11:31:27 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 4559E820257;
	Mon, 25 Mar 2024 11:31:27 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: [PATCH 3/5] ALSA: hda: hda_cs_dsp_ctl: Use cs_dsp_coeff_lock_and_[read|write]_ctrl()
Date: Mon, 25 Mar 2024 11:31:25 +0000
Message-ID: <20240325113127.112783-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325113127.112783-1-rf@opensource.cirrus.com>
References: <20240325113127.112783-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: TKkn3GQ3V7LBpnkd5hqcKvTKUDr4AgaY
X-Proofpoint-GUID: TKkn3GQ3V7LBpnkd5hqcKvTKUDr4AgaY
X-Proofpoint-Spam-Reason: safe

From: Simon Trimmer <simont@opensource.cirrus.com>

Using the cs_dsp_coeff_lock_and_[read|write]_ctrl() wrappers tidies
the calling functions as it does not need to manage the DSP pwr_lock.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/hda_cs_dsp_ctl.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/hda_cs_dsp_ctl.c b/sound/pci/hda/hda_cs_dsp_ctl.c
index 463ca06036bf..725544d81941 100644
--- a/sound/pci/hda/hda_cs_dsp_ctl.c
+++ b/sound/pci/hda/hda_cs_dsp_ctl.c
@@ -51,13 +51,8 @@ static int hda_cs_dsp_coeff_put(struct snd_kcontrol *kctl, struct snd_ctl_elem_v
 	struct hda_cs_dsp_coeff_ctl *ctl = (struct hda_cs_dsp_coeff_ctl *)snd_kcontrol_chip(kctl);
 	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
 	char *p = ucontrol->value.bytes.data;
-	int ret = 0;
-
-	mutex_lock(&cs_ctl->dsp->pwr_lock);
-	ret = cs_dsp_coeff_write_ctrl(cs_ctl, 0, p, cs_ctl->len);
-	mutex_unlock(&cs_ctl->dsp->pwr_lock);
 
-	return ret;
+	return cs_dsp_coeff_lock_and_write_ctrl(cs_ctl, 0, p, cs_ctl->len);
 }
 
 static int hda_cs_dsp_coeff_get(struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
@@ -65,13 +60,8 @@ static int hda_cs_dsp_coeff_get(struct snd_kcontrol *kctl, struct snd_ctl_elem_v
 	struct hda_cs_dsp_coeff_ctl *ctl = (struct hda_cs_dsp_coeff_ctl *)snd_kcontrol_chip(kctl);
 	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
 	char *p = ucontrol->value.bytes.data;
-	int ret;
-
-	mutex_lock(&cs_ctl->dsp->pwr_lock);
-	ret = cs_dsp_coeff_read_ctrl(cs_ctl, 0, p, cs_ctl->len);
-	mutex_unlock(&cs_ctl->dsp->pwr_lock);
 
-	return ret;
+	return cs_dsp_coeff_lock_and_read_ctrl(cs_ctl, 0, p, cs_ctl->len);
 }
 
 static unsigned int wmfw_convert_flags(unsigned int in)
-- 
2.39.2


