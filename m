Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ABB760586
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 04:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjGYCg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 22:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjGYCf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:35:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5BB19AF;
        Mon, 24 Jul 2023 19:35:15 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P1t49w027915;
        Tue, 25 Jul 2023 02:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=iaVCk/chy30rh62yowY7DrEsgB4OaHkXkFlSvMrBeKg=;
 b=AaNY9OvMnsqvdKkFQiweWN9wtMPTKw6nJGwHUoCgpTW2hCJ3+riMXvRPxcxlLwJfDbzD
 iP1G1cBjaJvtD5i3qWNlFshbHo+YiznBSyRpb96XhEmZPz44Jmgc/L3sYHdbvL91FMZ4
 QueIh241oLwEsmcLrifNXg7KP7Li4JIJX3H/m/wiSQcNiHDAu0DplxPLPPiXl6w2nwYT
 WQlN7+xSOXJmBbzTG3nZ8iEN31kvNyAcIfL64KXpLDTvHTr/McEj0O7yY5I+3Zq/ouX/
 f55XieCzHGQ2jZfK8wZQy7DD5EfSrsFrn7fLPF7LXD+f68OusBSlXOnYOrOzCNocFZ/i WQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1vh8h4cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 02:34:51 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P2YoJ9020408
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 02:34:50 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 19:34:49 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <bgoswami@quicinc.com>, <Thinh.Nguyen@synopsys.com>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <quic_jackp@quicinc.com>, <pierre-louis.bossart@linux.intel.com>,
        <oneukum@suse.com>, <albertccwang@google.com>,
        <o-takashi@sakamocchi.jp>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v4 29/32] sound: soc: qcom: q6usb: Add headphone jack for offload connection status
Date:   Mon, 24 Jul 2023 19:34:13 -0700
Message-ID: <20230725023416.11205-30-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230725023416.11205-1-quic_wcheng@quicinc.com>
References: <20230725023416.11205-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UndFFRLDaCQ5MTFL2GQMa5sB2Eb_eCOL
X-Proofpoint-GUID: UndFFRLDaCQ5MTFL2GQMa5sB2Eb_eCOL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_18,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The headphone jack framework has a well defined intrastructure for
notifying userspace entities through input devices.  Expose a jack device
that carries information about if an offload capable device is connected.
Applications can further identify specific offloading information through
other SND kcontrols.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/soc/qcom/qdsp6/q6usb.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
index e4ccb9d912b0..860dff8c1438 100644
--- a/sound/soc/qcom/qdsp6/q6usb.c
+++ b/sound/soc/qcom/qdsp6/q6usb.c
@@ -20,6 +20,7 @@
 #include <sound/pcm_params.h>
 #include <sound/asound.h>
 #include <sound/q6usboffload.h>
+#include <sound/jack.h>
 
 #include "q6dsp-lpass-ports.h"
 #include "q6afe.h"
@@ -37,6 +38,7 @@ struct q6usb_status {
 struct q6usb_port_data {
 	struct q6afe_usb_cfg usb_cfg;
 	struct snd_soc_usb *usb;
+	struct snd_soc_jack hs_jack;
 	struct q6usb_offload priv;
 	struct mutex mutex;
 	unsigned long available_card_slot;
@@ -279,6 +281,7 @@ static const struct snd_kcontrol_new q6usb_offload_control = {
 /* Build a mixer control for a UAC connector control (jack-detect) */
 static void q6usb_connector_control_init(struct snd_soc_component *component)
 {
+	struct q6usb_port_data *data = dev_get_drvdata(component->dev);
 	int ret;
 
 	ret = snd_ctl_add(component->card->snd_card,
@@ -290,6 +293,11 @@ static void q6usb_connector_control_init(struct snd_soc_component *component)
 				snd_ctl_new1(&q6usb_offload_dev_ctrl, component));
 	if (ret < 0)
 		return;
+
+	ret = snd_soc_card_jack_new(component->card, "USB offload",
+					SND_JACK_HEADSET, &data->hs_jack);
+	if (ret)
+		return;
 }
 
 static int q6usb_audio_ports_of_xlate_dai_name(struct snd_soc_component *component,
@@ -322,7 +330,10 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
 
 	mutex_lock(&data->mutex);
 	if (connected) {
-		snd_soc_dapm_enable_pin(dapm, "USB_RX_BE");
+		if (!data->available_card_slot) {
+			snd_soc_dapm_enable_pin(dapm, "USB_RX_BE");
+			snd_jack_report(data->hs_jack.jack, 1);
+		}
 		/*
 		 * Update the latest USB headset plugged in, if session is
 		 * idle.
@@ -338,8 +349,10 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb, int card_idx,
 		clear_bit(card_idx, &data->available_card_slot);
 		data->status[card_idx].num_pcm = 0;
 		data->status[card_idx].chip_index = 0;
-		if (!data->available_card_slot)
+		if (!data->available_card_slot) {
 			snd_soc_dapm_disable_pin(dapm, "USB_RX_BE");
+			snd_jack_report(data->hs_jack.jack, 0);
+		}
 	}
 	snd_soc_dapm_sync(dapm);
 	mutex_unlock(&data->mutex);
