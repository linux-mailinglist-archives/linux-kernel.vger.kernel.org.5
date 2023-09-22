Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E247AA4DA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjIUWVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjIUWVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:21:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF240269E;
        Thu, 21 Sep 2023 14:49:31 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LLkGvV024475;
        Thu, 21 Sep 2023 21:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=CL3FVM1qBZnRnbh0US8YjFD3CDy8ri2rtoQ7u0QpjGc=;
 b=aASXP1CRFPXmTtiLeI+Rn/0NcGH/688lUbhc1GWeWnomme3cxVY0ZSZ7hCvui8c4Zx4h
 ECd+8v/AoaqqCx+bV21BA/R5ChzMACFFRVyJDcn2yJRmdvnM2sK8MeE+jPZ3vWxbZgsF
 aLXkYcqrsx/hR0spGGAb/E3h6j4ATNmQOrp8Qw9jq3AwTcvEqzXrB+l0hVmAXd49B1LC
 OfsN7vmOlANLTXQdCSJblb7Q/ELghKtMFBJzBxSLWmejvLtFwDQCY3wHUpa4v/RyF0b2
 Ga8BMB08c7zT3BKESw4Ay1jxGx9w8Tomnz3ubGmCjCmMJSi+b2neHJ91SxP8tchx86hj uA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8uf2g9pp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 21:49:03 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38LLn2Xw031173
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 21:49:02 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 21 Sep 2023 14:49:02 -0700
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
Subject: [PATCH v7 32/33] ALSA: usb-audio: Allow for rediscovery of connected USB SND devices
Date:   Thu, 21 Sep 2023 14:48:42 -0700
Message-ID: <20230921214843.18450-33-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230921214843.18450-1-quic_wcheng@quicinc.com>
References: <20230921214843.18450-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RoeeOnwb49JI3NqfV2kxyqmPbxKTjn-9
X-Proofpoint-ORIG-GUID: RoeeOnwb49JI3NqfV2kxyqmPbxKTjn-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_18,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309210188
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of notifying SND platform drivers of connection events, some of
these use cases, such as offloading, require an ASoC USB backend device to
be initialized before the events can be handled.  If the USB backend device
has not yet been probed, this leads to missing initial USB audio device
connection events.

Expose an API that traverses the usb_chip array for connected devices, and
to call the respective connection callback registered to the SND platform
driver.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/usb/card.c | 19 +++++++++++++++++++
 sound/usb/card.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 88f431917c15..7d3f470754ca 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -202,6 +202,25 @@ struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
 }
 EXPORT_SYMBOL_GPL(snd_usb_find_suppported_substream);
 
+/*
+ * in case the platform driver was not ready at the time of USB SND
+ * device connect, expose an API to discover all connected USB devices
+ * so it can populate any dependent resources/structures.
+ */
+void snd_usb_rediscover_devices(void)
+{
+	int i;
+
+	mutex_lock(&register_mutex);
+	for (i = 0; i < SNDRV_CARDS; i++) {
+		if (usb_chip[i])
+			if (platform_ops && platform_ops->connect_cb)
+				platform_ops->connect_cb(usb_chip[i]);
+	}
+	mutex_unlock(&register_mutex);
+}
+EXPORT_SYMBOL_GPL(snd_usb_rediscover_devices);
+
 /*
  * disconnect streams
  * called from usb_audio_disconnect()
diff --git a/sound/usb/card.h b/sound/usb/card.h
index 01f7e10f30f4..c0aeda17ed69 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -221,11 +221,13 @@ int snd_usb_unregister_platform_ops(void);
 #if IS_ENABLED(CONFIG_SND_USB_AUDIO)
 struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
 			struct snd_pcm_hw_params *params, int direction);
+void snd_usb_rediscover_devices(void);
 #else
 static struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
 			struct snd_pcm_hw_params *params, int direction)
 {
 	return NULL;
 }
+static void snd_usb_rediscover_devices(void) { }
 #endif /* IS_ENABLED(CONFIG_SND_USB_AUDIO) */
 #endif /* __USBAUDIO_CARD_H */
