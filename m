Return-Path: <linux-kernel+bounces-84363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC5986A5E6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C991C22EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E0C535DF;
	Wed, 28 Feb 2024 01:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cTsEOo36"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145D523777;
	Wed, 28 Feb 2024 01:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709084219; cv=none; b=Lq0JWOe50SXFPu8mHvU1w1ICUP7xN7KRuFzaBf2+42u8E8ZNPgqquxuy+ml4AYgpOsd/5g3ltJZMEnJ6tPNUfwyByiapxiqOfwZuj0V7LSXlGwuIhsZ7YRz5KyLjNaOC55BGcyGHLJ6YpsgVl0h+6fM25JrZCBcfvgbRmM620Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709084219; c=relaxed/simple;
	bh=NFb5KrutHq3DEtEEDYwpfG5twPMjHvzujusJINVO7hw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFQ6NaFhF6fBtDS/7YvYlqEkqtq7ZqWHkr52jKuljhynRtOPBGOOi6aIxG4EdrQlrfIl2LkUi0paWtELQScDOmCmNPwwVUx5hRZbWkEM86wrhE5HcY+EyZqVWECxIEWqpaaVq5WrhbSJXRhPsO085EnmdFd0pqtxitDdo+RC7iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cTsEOo36; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S0VFqW016701;
	Wed, 28 Feb 2024 01:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=S9VTWxSz7x4qq1AeYZyZ
	G+OFcZ7lvmr3A4Wyz4IN404=; b=cTsEOo36OVL6tBKDKvJOME/EiZ54QdTSikaJ
	SPQA1U2rF15sZT2hraKdfN0zSeZQT6vjvYs2Tayhg+0SzASiOKNDkiTiUZwBeFr4
	kgX1onsgCyFECRps2YvEvqrkboyY+DQvh77CBeYHWsP2rwOBZhdbmLhBiPcu7SG4
	m6m1nCUGlg/wyuQ9xx+kVUDqBIXlEa5x3RX//GmGVLgC46rZ0Ml/6M1htky91ved
	pGIUonrch+2+0AvzHRXXfDklKmh/Ngd2DNEg7K0d/7t2Q7gTEWYYipDsuz9txyBY
	UMYDJgPqiUGxetiQ33E01i0EGYOp2dIKERZ3Opc6gLZAJ9D8AQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whtbw836w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 01:36:33 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41S1aXnj029848
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 01:36:33 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 17:36:32 -0800
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v18 14/41] ALSA: usb-audio: Introduce USB SND platform op callbacks
Date: Tue, 27 Feb 2024 17:35:52 -0800
Message-ID: <20240228013619.29758-15-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240228013619.29758-1-quic_wcheng@quicinc.com>
References: <20240228013619.29758-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CwA1gYqsTDfVmIlDogeRBx4E2FDuuFC6
X-Proofpoint-ORIG-GUID: CwA1gYqsTDfVmIlDogeRBx4E2FDuuFC6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280010

Allow for different platforms to be notified on USB SND connect/disconnect
seqeunces.  This allows for platform USB SND modules to properly initialize
and populate internal structures with references to the USB SND chip
device.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/usb/card.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/card.h |  9 ++++++++
 2 files changed, 62 insertions(+)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 1b2edc0fd2e9..ca4f3bc1b42d 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -118,6 +118,42 @@ MODULE_PARM_DESC(skip_validation, "Skip unit descriptor validation (default: no)
 static DEFINE_MUTEX(register_mutex);
 static struct snd_usb_audio *usb_chip[SNDRV_CARDS];
 static struct usb_driver usb_audio_driver;
+static struct snd_usb_platform_ops *platform_ops;
+
+/*
+ * Register platform specific operations that will be notified on events
+ * which occur in USB SND.  The platform driver can utilize this path to
+ * enable features, such as USB audio offloading, which allows for audio data
+ * to be queued by an audio DSP.
+ *
+ * Only one set of platform operations can be registered to USB SND.  The
+ * platform register operation is protected by the register_mutex.
+ */
+int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops)
+{
+	guard(mutex)(&register_mutex);
+	if (platform_ops)
+		return -EEXIST;
+
+	platform_ops = ops;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_usb_register_platform_ops);
+
+/*
+ * Unregisters the current set of platform operations.  This allows for
+ * a new set to be registered if required.
+ *
+ * The platform unregister operation is protected by the register_mutex.
+ */
+int snd_usb_unregister_platform_ops(void)
+{
+	guard(mutex)(&register_mutex);
+	platform_ops = NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_usb_unregister_platform_ops);
 
 /*
  * disconnect streams
@@ -910,7 +946,11 @@ static int usb_audio_probe(struct usb_interface *intf,
 	chip->num_interfaces++;
 	usb_set_intfdata(intf, chip);
 	atomic_dec(&chip->active);
+
+	if (platform_ops && platform_ops->connect_cb)
+		platform_ops->connect_cb(chip);
 	mutex_unlock(&register_mutex);
+
 	return 0;
 
  __error:
@@ -947,6 +987,9 @@ static void usb_audio_disconnect(struct usb_interface *intf)
 	card = chip->card;
 
 	mutex_lock(&register_mutex);
+	if (platform_ops && platform_ops->disconnect_cb)
+		platform_ops->disconnect_cb(chip);
+
 	if (atomic_inc_return(&chip->shutdown) == 1) {
 		struct snd_usb_stream *as;
 		struct snd_usb_endpoint *ep;
@@ -1090,6 +1133,11 @@ static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 		chip->system_suspend = chip->num_suspended_intf;
 	}
 
+	mutex_lock(&register_mutex);
+	if (platform_ops && platform_ops->suspend_cb)
+		platform_ops->suspend_cb(intf, message);
+	mutex_unlock(&register_mutex);
+
 	return 0;
 }
 
@@ -1130,6 +1178,11 @@ static int usb_audio_resume(struct usb_interface *intf)
 
 	snd_usb_midi_v2_resume_all(chip);
 
+	mutex_lock(&register_mutex);
+	if (platform_ops && platform_ops->resume_cb)
+		platform_ops->resume_cb(intf);
+	mutex_unlock(&register_mutex);
+
  out:
 	if (chip->num_suspended_intf == chip->system_suspend) {
 		snd_power_change_state(chip->card, SNDRV_CTL_POWER_D0);
diff --git a/sound/usb/card.h b/sound/usb/card.h
index 6ec95b2edf86..2884912adc96 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -207,4 +207,13 @@ struct snd_usb_stream {
 	struct list_head list;
 };
 
+struct snd_usb_platform_ops {
+	void (*connect_cb)(struct snd_usb_audio *chip);
+	void (*disconnect_cb)(struct snd_usb_audio *chip);
+	void (*suspend_cb)(struct usb_interface *intf, pm_message_t message);
+	void (*resume_cb)(struct usb_interface *intf);
+};
+
+int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops);
+int snd_usb_unregister_platform_ops(void);
 #endif /* __USBAUDIO_CARD_H */

