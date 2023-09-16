Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF1A7A2B84
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbjIPAMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 20:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238377AbjIPAL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:11:58 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09F3273E;
        Fri, 15 Sep 2023 17:11:46 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FMqPIu014934;
        Sat, 16 Sep 2023 00:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=dH3EZ3Jzl3/12IrSu0jI4GH3HGQtq5+vzpa4GA8M+f0=;
 b=asKJklUzoojslpw6103Ov/roexW4wg66ZyvE5nIZphbZc3wi2vcqj314xAg0fKnBsBfK
 O7muSLl3n4Ak9AIbVbj+Cc6fMGXaGO1yyterPg9AuyVF/ZaKXHE17Jqiz+0vfWDvs8vw
 f3SqEnT1ZmMuUM/2li0jsw3TS99aS/Lb50UXc4mEManDQPRBSURgOsZ5e+i+8hVQUr7Q
 SSD1Sx2wi/HG//5ZC36ym92fsYWJ76/ScaBe3JBNlZHQoSMinbsC6u5pgyn9H4DfYYR/
 SGmoTfvzr5nE8IN49MRBlfz36X9rOAKr2urCPs7K7ZrRXy68JDyUpOXMEgyWW7FSD+3l wQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t4g3naedp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Sep 2023 00:11:04 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38G0AgGO018246
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Sep 2023 00:10:42 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 15 Sep 2023 17:10:42 -0700
From:   Wesley Cheng <quic_wcheng@quicinc.com>
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v6 19/33] ALSA: usb-audio: Check for support for requested audio format
Date:   Fri, 15 Sep 2023 17:10:12 -0700
Message-ID: <20230916001026.315-20-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230916001026.315-1-quic_wcheng@quicinc.com>
References: <20230916001026.315-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pMholkgIZEAsT4BdMDFe-SbvcZcjjhU7
X-Proofpoint-ORIG-GUID: pMholkgIZEAsT4BdMDFe-SbvcZcjjhU7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309160000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow for checks on a specific USB audio device to see if a requested PCM
format is supported.  This is needed for support for when playback is
initiated by the ASoC USB backend path.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/usb/card.c | 40 ++++++++++++++++++++++++++++++++++++++++
 sound/usb/card.h | 11 +++++++++++
 2 files changed, 51 insertions(+)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index c0b312e264bf..88f431917c15 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -162,6 +162,46 @@ int snd_usb_unregister_platform_ops(void)
 }
 EXPORT_SYMBOL_GPL(snd_usb_unregister_platform_ops);
 
+/*
+ * Checks to see if requested audio profile, i.e sample rate, # of
+ * channels, etc... is supported by the substream associated to the
+ * USB audio device.
+ */
+struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
+			struct snd_pcm_hw_params *params, int direction)
+{
+	struct snd_usb_audio *chip;
+	struct snd_usb_substream *subs = NULL;
+	struct snd_usb_stream *as;
+	const struct audioformat *fmt;
+
+	/*
+	 * Register mutex is held when populating and clearing usb_chip
+	 * array.
+	 */
+	mutex_lock(&register_mutex);
+	chip = usb_chip[card_idx];
+	if (!chip) {
+		mutex_unlock(&register_mutex);
+		return NULL;
+	}
+
+	if (enable[card_idx]) {
+		list_for_each_entry(as, &chip->pcm_list, list) {
+			subs = &as->substream[direction];
+			fmt = snd_usb_find_substream_format(subs, params);
+			if (fmt) {
+				mutex_unlock(&register_mutex);
+				return as;
+			}
+		}
+	}
+	mutex_unlock(&register_mutex);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(snd_usb_find_suppported_substream);
+
 /*
  * disconnect streams
  * called from usb_audio_disconnect()
diff --git a/sound/usb/card.h b/sound/usb/card.h
index 2884912adc96..e26292363cf0 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -216,4 +216,15 @@ struct snd_usb_platform_ops {
 
 int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops);
 int snd_usb_unregister_platform_ops(void);
+
+#if IS_ENABLED(CONFIG_SND_USB_AUDIO)
+struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
+			struct snd_pcm_hw_params *params, int direction);
+#else
+static struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
+			struct snd_pcm_hw_params *params, int direction)
+{
+	return NULL;
+}
+#endif /* IS_ENABLED(CONFIG_SND_USB_AUDIO) */
 #endif /* __USBAUDIO_CARD_H */
