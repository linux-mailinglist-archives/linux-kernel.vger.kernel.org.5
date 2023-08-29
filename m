Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56E078CE68
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbjH2VIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239925AbjH2VHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:07:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366F491;
        Tue, 29 Aug 2023 14:07:40 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TL6K8V030723;
        Tue, 29 Aug 2023 21:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=p/G/TK2qypuPuacwuzEQ9GHgTK7jW0G6IFELS8kOck4=;
 b=m9Jeg9nYzHG5yYjjn8OenvD7VAkJOdOZH4+TlbT6i3Ih0o/DKITiaE/xlxkktpU3sCtE
 iH4a6FQ8eKk9DiAe/GdkidtIlRwR/eBuqkMW5jzVoIsx1eDuYadljAZJTIFwb8llZnTg
 tBbwHd7RskV8v9Sf59ZGr56Ssecry3OQFmlgmNCnOk5CSq8ZZosZQhoJqd5kKSPyjb1r
 Y7+l7Gmic8EzJ+3b8mHwnqLYYAw85cXQng3hWPjq3xqm3td1gMOM4hO/MTsLdW53Wi7v
 CCCsj2QRSWBB+5yYVZg8vy6i8UIL+EmMKJI3RBZekRXDO1dvnoC2Y013wuHh6wa3BrRD cA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3srybqbe6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 21:07:17 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37TL7GTD005899
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 21:07:16 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 29 Aug 2023 14:07:16 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v5 29/32] sound: soc: qcom: q6usb: Add headphone jack for offload connection status
Date:   Tue, 29 Aug 2023 14:06:54 -0700
Message-ID: <20230829210657.9904-30-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230829210657.9904-1-quic_wcheng@quicinc.com>
References: <20230829210657.9904-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ELAFceZYPIM_iDDolM0CO0pW0YyvKhJd
X-Proofpoint-GUID: ELAFceZYPIM_iDDolM0CO0pW0YyvKhJd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_15,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290182
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The headphone jack framework has a well defined infrastructure for
notifying userspace entities through input devices.  Expose a jack device
that carries information about if an offload capable device is connected.
Applications can further identify specific offloading information through
other SND kcontrols.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/soc/qcom/qdsp6/q6usb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
index b67bf7cfc3ea..531d6c7700df 100644
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
@@ -323,6 +331,9 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb,
 
 	mutex_lock(&data->mutex);
 	if (connected) {
+		if (!data->available_card_slot)
+			snd_jack_report(data->hs_jack.jack, 1);
+
 		/*
 		 * Update the latest USB headset plugged in, if session is
 		 * idle.
@@ -338,6 +349,9 @@ static int q6usb_alsa_connection_cb(struct snd_soc_usb *usb,
 		clear_bit(sdev->card_idx, &data->available_card_slot);
 		data->status[sdev->card_idx].num_pcm = 0;
 		data->status[sdev->card_idx].chip_index = 0;
+
+		if (!data->available_card_slot)
+			snd_jack_report(data->hs_jack.jack, 0);
 	}
 	mutex_unlock(&data->mutex);
 
