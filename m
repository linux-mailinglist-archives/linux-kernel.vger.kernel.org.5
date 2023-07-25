Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410E176054D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 04:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjGYCfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 22:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjGYCfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:35:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E898173D;
        Mon, 24 Jul 2023 19:35:05 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P1J370017775;
        Tue, 25 Jul 2023 02:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=+ivONrHd6ApM4gkgXNS9zys1I5ujVjebwmA/a7dIsa8=;
 b=XUvr2UCrys2vMYpUgqHdnEue+q8SdYu47aeVJnki+A1rQuqNVq0Kepv38x3IymYZyVe0
 vdQ7P2ZeuBqFqe+ye57IYDUBkrPmmNRGJF+lKHumhVh+KCTncJQFvbBG0ArxDqT6iTK2
 m5c5AvlXbu2T3TJQ2VDimGri3+awB/jrsrp7NuoIKALNKET5RM6wwkfhCM/pR+f0q6vz
 GG6QrjXXIanCCd4zHdIaas0H1F3j2uUaDP9xEpGQtAn7ENfUdQeo6fwsNCze6Tb4lMNj
 4yzhpBFcSJki/D7VYYpMTT9yI9Msu89BtTMrybYEaUJR+Ef4isQMLDFhB3XgtgImqEXN +w== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1vh8h4bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 02:34:41 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P2YeXI012515
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 02:34:40 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 19:34:39 -0700
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
Subject: [PATCH v4 16/32] sound: usb: pcm: Export fixed rate check USB SND API
Date:   Mon, 24 Jul 2023 19:34:00 -0700
Message-ID: <20230725023416.11205-17-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 9tSdnVYVN6dKF-lBzI-ge-UNJRXBVede
X-Proofpoint-GUID: 9tSdnVYVN6dKF-lBzI-ge-UNJRXBVede
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

Some modules will handle calling snd_usb_endpoint_open() instead of the USB
SND framework.  The USB SND endpoint open function added a new argument to
determine if the connect USB device can support multiple sampling rates.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/usb/pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index b6fb6d84d9eb..955c6fea3bfa 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -186,6 +186,7 @@ bool snd_usb_pcm_has_fixed_rate(struct snd_usb_substream *subs)
 	}
 	return true;
 }
+EXPORT_SYMBOL_GPL(snd_usb_pcm_has_fixed_rate);
 
 static int init_pitch_v1(struct snd_usb_audio *chip, int ep)
 {
