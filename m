Return-Path: <linux-kernel+bounces-154157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A848AD84B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D282A1C20F24
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E1F16C6A6;
	Mon, 22 Apr 2024 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CgRhgnCm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B989C159212;
	Mon, 22 Apr 2024 22:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826213; cv=none; b=fGFv4wServ8EmRWTzwRrbcIwMIPTENujvmxK4kqEvN86fmq0ZIXaKvmeVO6rumDY/wZE3qKSoRS9An4iWYDIBblcgscrSVAZBL8c0tEJHzXT0xmWVAlqpQ8Qe+BsDIgUKfwkB6B4o+BwonUfnYSGGJB7XPV1+57tciD6KIPai+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826213; c=relaxed/simple;
	bh=AN/XgXmoDQDKQCkIKxg7LAaiRm5YSKCvNyan7MC6Bmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFmFXkc9aRKNqOFYRvWVDG9djJm+qo0m4W6pUtpG1haFlkzp6Frv1JEXeXD4yM/37pkpdiQAI24NGtIqUBq/mqZFC9CVC1n1MGNrwnr8qB0bbFwh4aWKf4WmeMOHi4beD/Oy7c5wnhFqCvHYDhwoEGm+hwDQP3fH62N/AQSa/vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CgRhgnCm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MMiDH2030729;
	Mon, 22 Apr 2024 22:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=+gRV719uqSc7oMUSU9Bc
	8q0Q3IEefQWBi7497D++R6I=; b=CgRhgnCm7CR+/MReNZySuRY6wQtcvUCndCT7
	ZSeiyeVB9zFrmRQxAadDBzuNxQzfXUjLvpIT/VGX32Yfu5lz0VGaezKQytNhMJ1y
	T/BFqeah9AZ+WsFNd53NUT+U4GSsCFC1tj15C3vm35zqcmx53LhvEQGCFiA6kZHa
	hEnNh1cw/XgwgdfumNj2uIr1HJcprNFyz3iAQFMm9qByeN48vJOE48ew53trsHGm
	tvq6g8mMG/kfbcX7kqdH015+WMZ1ishnfTg0ceIlHDRPioSCQ3XDQteFpNBSXJIl
	PI9Fb8Oug49gHpRado1foqWmEhMX5yye8SENcZvfbBSIngzHnA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnr0mha5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 22:49:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MMnQm1021933
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 22:49:26 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 15:49:26 -0700
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v19 36/41] ALSA: usb-audio: Add USB offloading capable kcontrol
Date: Mon, 22 Apr 2024 15:49:01 -0700
Message-ID: <20240422224906.15868-37-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240422224906.15868-1-quic_wcheng@quicinc.com>
References: <20240422224906.15868-1-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: 3PnqY6MYjqW3zEpV5nZ-QMxHqq2qDAlm
X-Proofpoint-ORIG-GUID: 3PnqY6MYjqW3zEpV5nZ-QMxHqq2qDAlm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_16,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220096

In order to allow userspace/applications know about USB offloading status,
expose a sound kcontrol that fetches information about which sound card
index is associated with the ASoC platform card supporting offloading.  In
the USB audio offloading framework, the ASoC BE DAI link is the entity
responsible for registering to the SOC USB layer.  SOC USB will expose more
details about the current offloading status, which includes the USB sound
card and USB PCM device indexes currently being used.

It is expected for the USB offloading driver to add the kcontrol to the
sound card associated with the USB audio device.  An example output would
look like:

tinymix -D 1 get 'USB Offload Playback Capable Card'
0 (range -1->32)

Ths example signifies that card#0 has an USB offload capable path
available.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/usb/Kconfig                  | 10 +++++
 sound/usb/qcom/Makefile            |  6 ++-
 sound/usb/qcom/mixer_usb_offload.c | 65 ++++++++++++++++++++++++++++++
 sound/usb/qcom/mixer_usb_offload.h | 17 ++++++++
 sound/usb/qcom/qc_audio_offload.c  |  3 ++
 5 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 sound/usb/qcom/mixer_usb_offload.c
 create mode 100644 sound/usb/qcom/mixer_usb_offload.h

diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index 5cc3eaf53e6b..1228be3c1f83 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -176,6 +176,16 @@ config SND_BCD2000
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-bcd2000.
 
+config SND_USB_QC_OFFLOAD_MIXER
+	bool "Qualcomm USB Audio Offload mixer control"
+	help
+	 Say Y to enable the Qualcomm USB audio offloading mixer controls.
+	 This exposes an USB offload capable kcontrol to signal to
+	 applications about which platform sound card can support USB
+	 audio offload.  This can potentially be used to fetch further
+	 information about the offloading status from the platform sound
+	 card.
+
 config SND_USB_AUDIO_QMI
 	tristate "Qualcomm Audio Offload driver"
 	depends on QCOM_QMI_HELPERS && SND_USB_AUDIO && USB_XHCI_SIDEBAND && SND_SOC_USB
diff --git a/sound/usb/qcom/Makefile b/sound/usb/qcom/Makefile
index a81c9b28d484..eada5cd7b71f 100644
--- a/sound/usb/qcom/Makefile
+++ b/sound/usb/qcom/Makefile
@@ -1,2 +1,6 @@
 snd-usb-audio-qmi-objs := usb_audio_qmi_v01.o qc_audio_offload.o
-obj-$(CONFIG_SND_USB_AUDIO_QMI) += snd-usb-audio-qmi.o
\ No newline at end of file
+obj-$(CONFIG_SND_USB_AUDIO_QMI) += snd-usb-audio-qmi.o
+
+ifneq ($(CONFIG_SND_USB_QC_OFFLOAD_MIXER),)
+snd-usb-audio-qmi-objs += mixer_usb_offload.o
+endif
\ No newline at end of file
diff --git a/sound/usb/qcom/mixer_usb_offload.c b/sound/usb/qcom/mixer_usb_offload.c
new file mode 100644
index 000000000000..cd6e5600e795
--- /dev/null
+++ b/sound/usb/qcom/mixer_usb_offload.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/usb.h>
+
+#include <sound/core.h>
+#include <sound/control.h>
+#include <sound/soc-usb.h>
+
+#include "../card.h"
+#include "../mixer.h"
+#include "../usbaudio.h"
+
+#include "mixer_usb_offload.h"
+
+static int
+snd_usb_offload_available_get(struct snd_kcontrol *kcontrol,
+		      struct snd_ctl_elem_value *ucontrol)
+{
+	struct device *sysdev = snd_kcontrol_chip(kcontrol);
+	int ret;
+
+	ret = snd_soc_usb_device_offload_available(sysdev);
+	ucontrol->value.integer.value[0] = ret < 0 ? -1 : ret;
+
+	return ret < 0 ? ret : 0;
+}
+
+static int snd_usb_offload_available_info(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = -1;
+	uinfo->value.integer.max = SNDRV_CARDS;
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new snd_usb_offload_available_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_CARD,
+	.access = SNDRV_CTL_ELEM_ACCESS_READ,
+	.name = "USB Offload Playback Capable Card",
+	.info = snd_usb_offload_available_info,
+	.get = snd_usb_offload_available_get,
+};
+
+/**
+ * snd_usb_offload_create_ctl() - Add USB offload bounded mixer
+ * @chip - USB SND chip device
+ *
+ * Creates a sound control for a USB audio device, so that applications can
+ * query for if there is an available USB audio offload path, and which
+ * card is managing it.
+ */
+int snd_usb_offload_create_ctl(struct snd_usb_audio *chip)
+{
+	struct usb_device *udev = chip->dev;
+
+	return snd_ctl_add(chip->card,
+			   snd_ctl_new1(&snd_usb_offload_available_ctl,
+					udev->bus->sysdev));
+}
diff --git a/sound/usb/qcom/mixer_usb_offload.h b/sound/usb/qcom/mixer_usb_offload.h
new file mode 100644
index 000000000000..0efda52e92b6
--- /dev/null
+++ b/sound/usb/qcom/mixer_usb_offload.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __USB_OFFLOAD_MIXER_H
+#define __USB_OFFLOAD_MIXER_H
+
+#if IS_ENABLED(CONFIG_SND_USB_QC_OFFLOAD_MIXER)
+int snd_usb_offload_create_ctl(struct snd_usb_audio *chip);
+#else
+static inline int snd_usb_offload_create_ctl(struct snd_usb_audio *chip)
+{
+	return -ENODEV;
+}
+#endif
+#endif /* __USB_OFFLOAD_MIXER_H */
diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index 4deec0b6fc08..6a25a390f8ae 100644
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -37,6 +37,7 @@
 #include "../pcm.h"
 #include "../power.h"
 
+#include "mixer_usb_offload.h"
 #include "usb_audio_qmi_v01.h"
 
 /* Stream disable request timeout during USB device disconnect */
@@ -1660,6 +1661,8 @@ static void qc_usb_audio_offload_probe(struct snd_usb_audio *chip)
 	uaudio_qdev->last_card_num = chip->card->number;
 	snd_soc_usb_connect(usb_get_usb_backend(udev), sdev);
 
+	snd_usb_offload_create_ctl(chip);
+
 	mutex_unlock(&chip->mutex);
 	mutex_unlock(&qdev_mutex);
 

