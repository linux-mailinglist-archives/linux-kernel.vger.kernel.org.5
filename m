Return-Path: <linux-kernel+bounces-154139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892378AD81D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C352829C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA9415B150;
	Mon, 22 Apr 2024 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g1NeCzY+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31625154BF7;
	Mon, 22 Apr 2024 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826208; cv=none; b=SG6FPx0mIiE4QVej/Av4fGDnOPlnZEqcYrZbdDVkUnoLAtWW9lK49nBd1DQ9hWPjeE4SmK4jAL1z8Z+1Cvulhv4y9KpRWzkPh5+e7I9XMwXBMmGno55T4LCjkZlyDDdFzJcLajfV6BKkuhcZTylzWJw+53+cN66IOJ5Mp9Qghv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826208; c=relaxed/simple;
	bh=IQZWERZG+85eUZHZ4qNMhcg3Lt1vXI3rCcAPxn3UFc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aMJ3tQ10gr4/ti8XrsYozt7lBFTEZIgeHCnsmGAgJz5u2u63yLIPTT0VMLME4OU0mDGogz+zqR4oT8/CqCqtzpmSnSzqn1F4ZMPRk84O9Su4z7I+Y8KR7G/6WFvos/zaw1C/xhyeSqVK3MhHWsFWHyRw+ChItaVVZm8T+lHt44s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g1NeCzY+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MLwYEf023308;
	Mon, 22 Apr 2024 22:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=uxQbOrCLKFSBlEbrW7J9
	0CdIysG93sYR5VFMrTIX9B0=; b=g1NeCzY+WW4airexzzqOa2rsSoxOmt3L9298
	U0Uyb2b/QjxSIg7mMQe6TOHaOSXhFdIIzefEFzbKPB53+IqrlN29Zx0xPvWWy0Zn
	fE4332f2zBw4fIH13815BIRws9ux1apC1hk5vASEez2UykhBubBZbT3jO9Y9nUeD
	JCT4MPmJ7k+yltuUGL4Fg5zxWkn1N41NtVj6Fsa7XXh9xAf3oujfKR1oXTARWODl
	WqqfXuz7LYiduwaVAbm3wAEvO+qz1EEZ5INa57QIpDQWetgFvK0ooVh0vCCeRUoN
	hcu0YZ/j8v16lrOhMOay/UzHSMI7xicDTfY8hcEKhvs7rQKrvg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnr0mha56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 22:49:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MMnMR7022887
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 22:49:22 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 15:49:22 -0700
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
Subject: [PATCH v19 21/41] ALSA: usb-audio: Check for support for requested audio format
Date: Mon, 22 Apr 2024 15:48:46 -0700
Message-ID: <20240422224906.15868-22-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: HQoC6wkU6s5X3dF5TVRp_7qkHyr_HLtJ
X-Proofpoint-ORIG-GUID: HQoC6wkU6s5X3dF5TVRp_7qkHyr_HLtJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_16,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220096

Allow for checks on a specific USB audio device to see if a requested PCM
format is supported.  This is needed for support when playback is
initiated by the ASoC USB backend path.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/usb/card.c | 31 +++++++++++++++++++++++++++++++
 sound/usb/card.h |  3 +++
 2 files changed, 34 insertions(+)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 7dc8007ba839..1ad99a462038 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -155,6 +155,37 @@ int snd_usb_unregister_platform_ops(void)
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
+	struct snd_usb_substream *subs;
+	struct snd_usb_stream *as;
+
+	/*
+	 * Register mutex is held when populating and clearing usb_chip
+	 * array.
+	 */
+	guard(mutex)(&register_mutex);
+	chip = usb_chip[card_idx];
+
+	if (chip && enable[card_idx]) {
+		list_for_each_entry(as, &chip->pcm_list, list) {
+			subs = &as->substream[direction];
+			if (snd_usb_find_substream_format(subs, params))
+				return as;
+		}
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(snd_usb_find_suppported_substream);
+
 /*
  * disconnect streams
  * called from usb_audio_disconnect()
diff --git a/sound/usb/card.h b/sound/usb/card.h
index 02e4ea898db5..d66cc0b139af 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -217,4 +217,7 @@ struct snd_usb_platform_ops {
 
 int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops);
 int snd_usb_unregister_platform_ops(void);
+
+struct snd_usb_stream *snd_usb_find_suppported_substream(int card_idx,
+				struct snd_pcm_hw_params *params, int direction);
 #endif /* __USBAUDIO_CARD_H */

