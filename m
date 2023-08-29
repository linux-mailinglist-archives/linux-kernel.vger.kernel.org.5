Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4424978CE89
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240992AbjH2VIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbjH2VHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:07:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60A01A2;
        Tue, 29 Aug 2023 14:07:39 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TKTb9U012240;
        Tue, 29 Aug 2023 21:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=MUHE0pwz8elxP1d1ocdw5bD+H2ChU6AxcRGnDZb5p0g=;
 b=PHqx/BLdOUTJAhyMAe/jp8nntyG/ksrfQkaevd1ulHy9u/46evuJAncIUonycXGc9pXE
 lPdxipEebRSV1acwM9Nt2kzLZ+ndK3t3GfibpkqgKfcPYuqs7I2cSzhKkXBiriKnCh0O
 48rSAX7OJ+axykL71zORwD51Ytez/Vx453AmlNX8fjziHtTB7wdJIosCVCPgvl/SU3iq
 yt2twjubL4HohXBGGQXcx/I0jMyg+2JblaVHgnFbUqet5QBFrZ42cOh7enLTGwoF5hTl
 ozUDG8LPaAOsTgyogAY61HN34+JhSvUtUkR7ctVJR6j7ICSUm+OYqAYkBlfxksEn45ga Ow== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3srybqbe6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 21:07:17 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37TL7Hdh016241
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 21:07:17 GMT
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
Subject: [PATCH v5 31/32] sound: usb: card: Allow for rediscovery of connected USB SND devices
Date:   Tue, 29 Aug 2023 14:06:56 -0700
Message-ID: <20230829210657.9904-32-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Lwuvpq6w_IzhISogYx3hxbh1JzX_wjI_
X-Proofpoint-GUID: Lwuvpq6w_IzhISogYx3hxbh1JzX_wjI_
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
index bbcb22166d85..007cf5ef7671 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -187,6 +187,25 @@ struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
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
