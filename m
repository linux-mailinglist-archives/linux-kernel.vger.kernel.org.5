Return-Path: <linux-kernel+bounces-58854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0618D84ED90
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6784B1F21561
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FF863130;
	Thu,  8 Feb 2024 23:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JACMIod4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E7B55C02;
	Thu,  8 Feb 2024 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434094; cv=none; b=MI3yjQ/4WoLgmnLOcD/aGKxisohbvQ7LphlfSUU/wp+DJOkgwjJxQrXS1cPVibzlaDUI7Wf70U3PvKvvl6z2CA39l8XJrI7nJXC/4Hr/HsGE7vl97GwiykajNWCMIcY1Ak++YQzX0iDhmdp3A2yYC1cQLFReWmTZZ5lcRHZhnl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434094; c=relaxed/simple;
	bh=1bLwLr0EX/0lvwIzLyQnWS6s7hCSGP8YBc8NPNbcw8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BfRiFcfbJria6X34GCQ0gH2cCJMEsFkM5egbpUPQ5sD/3IMUWHPiq0l33bRazm9QWvtJh6laZBNRtKihABo/yH0WlKupcoq6Y/4mePV24NAfrUhfFQx8jd9fJyILn2hRq35Li2TBzv28tCQAGalUP2iHy4JhsGHJmcA5Cq0cBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JACMIod4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418N3G8k027491;
	Thu, 8 Feb 2024 23:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=6MDZdz79HYTo4EmUJtI2
	TotOggbgYgDt+zthz34wuRw=; b=JACMIod45ACt+XoJzYnI8bXHgWPxrf/ThDRz
	ZfZUnIbQJsMhewume4mpPeGOit2aWSUm/DlFpu38qJ2frf75qXjAIcXFsWTQVpKQ
	vfAIbIU/gYd0Rkx8/8QYirW2A4jHrEi5Bs8uoU8WIsx16ntJ9ZyHx14ceYd53AT3
	FyySG7/LBZeGLUpMEKZfv0Q3qEZkIrKwbdNUupbqh9VXJzYmn3WXuonBAzIhwKy7
	nlvMNHCwK7bss17QdYL/pvJKfAvlcgL/dphvjWwVoswKs/9XhnG7sb3u+otgGFnt
	NeOyXVU368TCTUOcT81yB/fqZ6qxrOeLhijUFeobuHC/xsZDwg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4sns2ab3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 23:14:30 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 418NETpo005648
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 23:14:29 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 8 Feb 2024 15:14:28 -0800
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
Subject: [PATCH v14 48/53] ALSA: usb-audio: mixer: Add USB offloading mixer control
Date: Thu, 8 Feb 2024 15:14:01 -0800
Message-ID: <20240208231406.27397-49-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240208231406.27397-1-quic_wcheng@quicinc.com>
References: <20240208231406.27397-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: a5yJ6nA3VQT2S0mNjM3lD1FT4BtXQGer
X-Proofpoint-GUID: a5yJ6nA3VQT2S0mNjM3lD1FT4BtXQGer
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402080131

In order to allow userspace/applications know about USB offloading status,
expose a sound kcontrol that fetches information about which sound card
index is associated with the ASoC platform card supporting offloading.  In
the USB audio offloading framework, the ASoC BE DAI link is the entity
responsible for registering to the SOC USB layer.  SOC USB will expose more
details about the current offloading status, which includes the USB sound
card and USB PCM device indexes currently being used.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/usb/Kconfig             |  4 ++
 sound/usb/Makefile            |  1 +
 sound/usb/mixer.c             |  5 +++
 sound/usb/mixer_usb_offload.c | 72 +++++++++++++++++++++++++++++++++++
 sound/usb/mixer_usb_offload.h | 17 +++++++++
 5 files changed, 99 insertions(+)
 create mode 100644 sound/usb/mixer_usb_offload.c
 create mode 100644 sound/usb/mixer_usb_offload.h

diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index 4c842fbe6365..3e7be258d0e3 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -176,10 +176,14 @@ config SND_BCD2000
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-bcd2000.
 
+config SND_USB_OFFLOAD_MIXER
+	bool
+
 config SND_USB_AUDIO_QMI
 	tristate "Qualcomm Audio Offload driver"
 	depends on QCOM_QMI_HELPERS && SND_USB_AUDIO && USB_XHCI_SIDEBAND
 	select SND_PCM
+	select SND_USB_OFFLOAD_MIXER
 	help
 	  Say Y here to enable the Qualcomm USB audio offloading feature.
 
diff --git a/sound/usb/Makefile b/sound/usb/Makefile
index 246788268ddd..8c54660a11b0 100644
--- a/sound/usb/Makefile
+++ b/sound/usb/Makefile
@@ -22,6 +22,7 @@ snd-usb-audio-objs := 	card.o \
 			stream.o \
 			validate.o
 
+snd-usb-audio-$(CONFIG_SND_USB_OFFLOAD_MIXER) += mixer_usb_offload.o
 snd-usb-audio-$(CONFIG_SND_USB_AUDIO_MIDI_V2) += midi2.o
 snd-usb-audio-$(CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER) += media.o
 
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 409fc1164694..09229e623469 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -48,6 +48,7 @@
 #include "mixer.h"
 #include "helper.h"
 #include "mixer_quirks.h"
+#include "mixer_usb_offload.h"
 #include "power.h"
 
 #define MAX_ID_ELEMS	256
@@ -3609,6 +3610,10 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif)
 	if (err < 0)
 		goto _error;
 
+	err = snd_usb_offload_init_mixer(mixer);
+	if (err < 0)
+		goto _error;
+
 	err = snd_device_new(chip->card, SNDRV_DEV_CODEC, mixer, &dev_ops);
 	if (err < 0)
 		goto _error;
diff --git a/sound/usb/mixer_usb_offload.c b/sound/usb/mixer_usb_offload.c
new file mode 100644
index 000000000000..61b17359b987
--- /dev/null
+++ b/sound/usb/mixer_usb_offload.c
@@ -0,0 +1,72 @@
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
+#include "card.h"
+#include "mixer.h"
+#include "mixer_usb_offload.h"
+#include "usbaudio.h"
+
+static int
+snd_usb_offload_create_mixer(struct usb_mixer_interface *mixer,
+		       const struct snd_kcontrol_new *new_kctl)
+{
+	struct snd_usb_audio *chip = mixer->chip;
+	struct usb_device *udev = chip->dev;
+
+	return snd_ctl_add(chip->card,
+			   snd_ctl_new1(new_kctl, udev->bus->sysdev));
+}
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
+ * snd_usb_offload_init_mixer() - Add USB offload bounded mixer
+ * @mixer - USB mixer
+ *
+ * Creates a sound control for a USB audio device, so that applications can
+ * query for if there is an available USB audio offload path, and which
+ * card is managing it.
+ */
+int snd_usb_offload_init_mixer(struct usb_mixer_interface *mixer)
+{
+	return snd_usb_offload_create_mixer(mixer, &snd_usb_offload_available_ctl);
+}
+EXPORT_SYMBOL_GPL(snd_usb_offload_init_mixer);
diff --git a/sound/usb/mixer_usb_offload.h b/sound/usb/mixer_usb_offload.h
new file mode 100644
index 000000000000..fb88e872d8fa
--- /dev/null
+++ b/sound/usb/mixer_usb_offload.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __USB_OFFLOAD_MIXER_H
+#define __USB_OFFLOAD_MIXER_H
+
+#if IS_ENABLED(CONFIG_SND_USB_OFFLOAD_MIXER)
+int snd_usb_offload_init_mixer(struct usb_mixer_interface *mixer);
+#else
+static int snd_usb_offload_init_mixer(struct usb_mixer_interface *mixer)
+{
+	return 0;
+}
+#endif
+#endif /* __USB_OFFLOAD_MIXER_H */

