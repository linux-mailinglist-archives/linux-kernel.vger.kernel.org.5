Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9C476056B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 04:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjGYCfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 22:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjGYCfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:35:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E48019A2;
        Mon, 24 Jul 2023 19:35:05 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P0LPnj004114;
        Tue, 25 Jul 2023 02:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=qESTLjNotgpRP5wCXSW9tvitIhySXt1EmcaRMKR0lGY=;
 b=cCw1UeggRQJE0ZLWDY3sHlWMbPJRod6RUQBpHcXUQx6TIDORPNiSkSe60a0WKQlQTR6a
 8GGYiTBNNg/2MJsmVqZ64cyyLEJHQEmgIsYdDnS2EzI5KKViv4xXVxvpzNjq/r7OzXzV
 S+9wJX+4o5QQYRFK9HOYvdG1E0aGy0QFq1XdLGNNvHIbcwfHcKomHE1XoCxAOvaSlZlx
 W4woHS746BUsQ9Fn28SiL5lNcsqCdaGEnZq/Gb9tQGUogOGFKUIn30S2uWnLQeTZ35Hk
 NRTgTLmm89yQ6yKgXlYw10WNHsrMRYSNBO+wk8tTqWbFWZ/P9NOKFFbITAaPQfDSn3bb TA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1vh8h4bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 02:34:39 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P2Ycls015169
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 02:34:38 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 19:34:37 -0700
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
Subject: [PATCH v4 12/32] sound: usb: Export USB SND APIs for modules
Date:   Mon, 24 Jul 2023 19:33:56 -0700
Message-ID: <20230725023416.11205-13-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: wLyo_ANT_-r_tWigX_RUN37Xok-sqrXx
X-Proofpoint-GUID: wLyo_ANT_-r_tWigX_RUN37Xok-sqrXx
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

Some vendor modules will utilize useful parsing and endpoint management
APIs to start audio playback/capture.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/core/oss/pcm_oss.c |  4 ++--
 sound/usb/card.c         |  2 ++
 sound/usb/endpoint.c     |  2 ++
 sound/usb/helper.c       |  1 +
 sound/usb/pcm.c          |  9 ++++++---
 sound/usb/pcm.h          | 12 ++++++++++++
 6 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 728c211142d1..7773b5362e1a 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -444,8 +444,8 @@ static int snd_pcm_hw_param_near(struct snd_pcm_substream *pcm,
 }
 
 static int _snd_pcm_hw_param_set(struct snd_pcm_hw_params *params,
-				 snd_pcm_hw_param_t var, unsigned int val,
-				 int dir)
+				snd_pcm_hw_param_t var, unsigned int val,
+				int dir)
 {
 	int changed;
 	if (hw_is_mask(var)) {
diff --git a/sound/usb/card.c b/sound/usb/card.c
index 9365d1e17836..a3fad66a3337 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -1076,6 +1076,7 @@ int snd_usb_autoresume(struct snd_usb_audio *chip)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_usb_autoresume);
 
 void snd_usb_autosuspend(struct snd_usb_audio *chip)
 {
@@ -1089,6 +1090,7 @@ void snd_usb_autosuspend(struct snd_usb_audio *chip)
 	for (i = 0; i < chip->num_interfaces; i++)
 		usb_autopm_put_interface(chip->intf[i]);
 }
+EXPORT_SYMBOL_GPL(snd_usb_autosuspend);
 
 static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
 {
diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index a385e85c4650..0757499599c8 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -866,6 +866,7 @@ snd_usb_endpoint_open(struct snd_usb_audio *chip,
 	mutex_unlock(&chip->mutex);
 	return ep;
 }
+EXPORT_SYMBOL_GPL(snd_usb_endpoint_open);
 
 /*
  * snd_usb_endpoint_set_sync: Link data and sync endpoints
@@ -1503,6 +1504,7 @@ int snd_usb_endpoint_prepare(struct snd_usb_audio *chip,
 	mutex_unlock(&chip->mutex);
 	return err;
 }
+EXPORT_SYMBOL_GPL(snd_usb_endpoint_prepare);
 
 /* get the current rate set to the given clock by any endpoint */
 int snd_usb_endpoint_get_clock_rate(struct snd_usb_audio *chip, int clock)
diff --git a/sound/usb/helper.c b/sound/usb/helper.c
index bf80e55d013a..4322ae3738e6 100644
--- a/sound/usb/helper.c
+++ b/sound/usb/helper.c
@@ -62,6 +62,7 @@ void *snd_usb_find_csint_desc(void *buffer, int buflen, void *after, u8 dsubtype
 	}
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(snd_usb_find_csint_desc);
 
 /*
  * Wrapper for usb_control_msg().
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index eec5232f9fb2..b6fb6d84d9eb 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -87,7 +87,7 @@ static snd_pcm_uframes_t snd_usb_pcm_pointer(struct snd_pcm_substream *substream
 /*
  * find a matching audio format
  */
-static const struct audioformat *
+const struct audioformat *
 find_format(struct list_head *fmt_list_head, snd_pcm_format_t format,
 	    unsigned int rate, unsigned int channels, bool strict_match,
 	    struct snd_usb_substream *subs)
@@ -147,8 +147,9 @@ find_format(struct list_head *fmt_list_head, snd_pcm_format_t format,
 	}
 	return found;
 }
+EXPORT_SYMBOL_GPL(find_format);
 
-static const struct audioformat *
+const struct audioformat *
 find_substream_format(struct snd_usb_substream *subs,
 		      const struct snd_pcm_hw_params *params)
 {
@@ -156,6 +157,7 @@ find_substream_format(struct snd_usb_substream *subs,
 			   params_rate(params), params_channels(params),
 			   true, subs);
 }
+EXPORT_SYMBOL_GPL(find_substream_format);
 
 bool snd_usb_pcm_has_fixed_rate(struct snd_usb_substream *subs)
 {
@@ -446,7 +448,7 @@ int snd_usb_pcm_resume(struct snd_usb_stream *as)
 	return 0;
 }
 
-static void close_endpoints(struct snd_usb_audio *chip,
+void close_endpoints(struct snd_usb_audio *chip,
 			    struct snd_usb_substream *subs)
 {
 	if (subs->data_endpoint) {
@@ -460,6 +462,7 @@ static void close_endpoints(struct snd_usb_audio *chip,
 		subs->sync_endpoint = NULL;
 	}
 }
+EXPORT_SYMBOL(close_endpoints);
 
 /*
  * hw_params callback
diff --git a/sound/usb/pcm.h b/sound/usb/pcm.h
index 388fe2ba346d..b5216cb19e75 100644
--- a/sound/usb/pcm.h
+++ b/sound/usb/pcm.h
@@ -15,4 +15,16 @@ void snd_usb_preallocate_buffer(struct snd_usb_substream *subs);
 int snd_usb_audioformat_set_sync_ep(struct snd_usb_audio *chip,
 				    struct audioformat *fmt);
 
+void close_endpoints(struct snd_usb_audio *chip,
+			    struct snd_usb_substream *subs);
+int configure_endpoints(struct snd_usb_audio *chip,
+			       struct snd_usb_substream *subs);
+
+const struct audioformat *
+find_format(struct list_head *fmt_list_head, snd_pcm_format_t format,
+	    unsigned int rate, unsigned int channels, bool strict_match,
+	    struct snd_usb_substream *subs);
+const struct audioformat *
+find_substream_format(struct snd_usb_substream *subs,
+		      const struct snd_pcm_hw_params *params);
 #endif /* __USBAUDIO_PCM_H */
