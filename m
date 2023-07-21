Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBDC75D008
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjGUQu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGUQuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:50:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D781FD7;
        Fri, 21 Jul 2023 09:50:49 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LEg0gD023476;
        Fri, 21 Jul 2023 16:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=pnZuCWe0TzaC0G7t8LH8mfNujAHiW3TUm2sMlIB6XbA=;
 b=NAlKcApWgp/SokYbKCyF7laL2C1me1lwBGuZh78/Qb0eP5xHXLH18KPjeODR5QWdqjZ7
 VxTJmlPQsIuS7m2VhOfKei6PPVuI5kSt1v4GB05AUSFlE+09WPXiHEwO+Qbf+GZKm/w2
 HNxNF5Ldwg0UT+huSUzT0oFy1t3eDvCNfcSBlw9zoQFwTSu+5Q4txdZSxgU3fukADosi
 f/a8RgnZEIYLAjL2OHYwRlvevVJlcNIy+N36qMDEIPVxhHxPGxGXffKtdCrooiJXbyKt
 Rc0c12vflQTb3LV/DoK5zpqvGvyzELbDes/ytCoaF5Eo01DIoX5X0bT/BevTFU6VUqOA Hw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rytd6rgyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 16:50:34 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36LGoWeY017319
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 16:50:32 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 21 Jul 2023 09:50:32 -0700
From:   Bjorn Andersson <quic_bjorande@quicinc.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH] ASoC: codecs: lpass: Log clk_get() failures
Date:   Fri, 21 Jul 2023 09:50:27 -0700
Message-ID: <20230721165027.2155528-1-quic_bjorande@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BjRP-ZRV_Xm3F67-Fyo3HzjmXu6Dhv_E
X-Proofpoint-GUID: BjRP-ZRV_Xm3F67-Fyo3HzjmXu6Dhv_E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 mlxscore=0 clxscore=1011 impostorscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LPASS macro drivers all acquire a number of clocks, but give no
indication when clk_get() fails, making it hard to identify and debug
system configuration issues.  Make these drivers provide useful debug
information when this happens.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 sound/soc/codecs/lpass-rx-macro.c  | 10 +++++-----
 sound/soc/codecs/lpass-tx-macro.c  | 10 +++++-----
 sound/soc/codecs/lpass-va-macro.c  |  6 +++---
 sound/soc/codecs/lpass-wsa-macro.c | 10 +++++-----
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 685ca95ef4a9..29197d34ec09 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3537,25 +3537,25 @@ static int rx_macro_probe(struct platform_device *pdev)
 
 	rx->macro = devm_clk_get_optional(dev, "macro");
 	if (IS_ERR(rx->macro))
-		return PTR_ERR(rx->macro);
+		return dev_err_probe(dev, PTR_ERR(rx->macro), "unable to get macro clock\n");
 
 	rx->dcodec = devm_clk_get_optional(dev, "dcodec");
 	if (IS_ERR(rx->dcodec))
-		return PTR_ERR(rx->dcodec);
+		return dev_err_probe(dev, PTR_ERR(rx->dcodec), "unable to get dcodec clock\n");
 
 	rx->mclk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(rx->mclk))
-		return PTR_ERR(rx->mclk);
+		return dev_err_probe(dev, PTR_ERR(rx->mclk), "unable to get mclk clock\n");
 
 	if (flags & LPASS_MACRO_FLAG_HAS_NPL_CLOCK) {
 		rx->npl = devm_clk_get(dev, "npl");
 		if (IS_ERR(rx->npl))
-			return PTR_ERR(rx->npl);
+			return dev_err_probe(dev, PTR_ERR(rx->npl), "unable to get npl clock\n");
 	}
 
 	rx->fsgen = devm_clk_get(dev, "fsgen");
 	if (IS_ERR(rx->fsgen))
-		return PTR_ERR(rx->fsgen);
+		return dev_err_probe(dev, PTR_ERR(rx->fsgen), "unable to get fsgen clock\n");
 
 	rx->pds = lpass_macro_pds_init(dev);
 	if (IS_ERR(rx->pds))
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index de978c3d70b7..3e33418898e8 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1967,25 +1967,25 @@ static int tx_macro_probe(struct platform_device *pdev)
 
 	tx->macro = devm_clk_get_optional(dev, "macro");
 	if (IS_ERR(tx->macro))
-		return PTR_ERR(tx->macro);
+		return dev_err_probe(dev, PTR_ERR(tx->macro), "unable to get macro clock\n");
 
 	tx->dcodec = devm_clk_get_optional(dev, "dcodec");
 	if (IS_ERR(tx->dcodec))
-		return PTR_ERR(tx->dcodec);
+		return dev_err_probe(dev, PTR_ERR(tx->dcodec), "unable to get dcodec clock\n");
 
 	tx->mclk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(tx->mclk))
-		return PTR_ERR(tx->mclk);
+		return dev_err_probe(dev, PTR_ERR(tx->mclk), "unable to get mclk clock\n");
 
 	if (flags & LPASS_MACRO_FLAG_HAS_NPL_CLOCK) {
 		tx->npl = devm_clk_get(dev, "npl");
 		if (IS_ERR(tx->npl))
-			return PTR_ERR(tx->npl);
+			return dev_err_probe(dev, PTR_ERR(tx->npl), "unable to get npl clock\n");
 	}
 
 	tx->fsgen = devm_clk_get(dev, "fsgen");
 	if (IS_ERR(tx->fsgen))
-		return PTR_ERR(tx->fsgen);
+		return dev_err_probe(dev, PTR_ERR(tx->fsgen), "unable to get fsgen clock\n");
 
 	tx->pds = lpass_macro_pds_init(dev);
 	if (IS_ERR(tx->pds))
diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index 74724448da50..b71ef03c4aef 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -1457,15 +1457,15 @@ static int va_macro_probe(struct platform_device *pdev)
 
 	va->macro = devm_clk_get_optional(dev, "macro");
 	if (IS_ERR(va->macro))
-		return PTR_ERR(va->macro);
+		return dev_err_probe(dev, PTR_ERR(va->macro), "unable to get macro clock\n");
 
 	va->dcodec = devm_clk_get_optional(dev, "dcodec");
 	if (IS_ERR(va->dcodec))
-		return PTR_ERR(va->dcodec);
+		return dev_err_probe(dev, PTR_ERR(va->dcodec), "unable to get dcodec clock\n");
 
 	va->mclk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(va->mclk))
-		return PTR_ERR(va->mclk);
+		return dev_err_probe(dev, PTR_ERR(va->mclk), "unable to get mclk clock\n");
 
 	va->pds = lpass_macro_pds_init(dev);
 	if (IS_ERR(va->pds))
diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index 8ba7dc89daaa..ec6859ec0d38 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -2396,25 +2396,25 @@ static int wsa_macro_probe(struct platform_device *pdev)
 
 	wsa->macro = devm_clk_get_optional(dev, "macro");
 	if (IS_ERR(wsa->macro))
-		return PTR_ERR(wsa->macro);
+		return dev_err_probe(dev, PTR_ERR(wsa->macro), "unable to get macro clock\n");
 
 	wsa->dcodec = devm_clk_get_optional(dev, "dcodec");
 	if (IS_ERR(wsa->dcodec))
-		return PTR_ERR(wsa->dcodec);
+		return dev_err_probe(dev, PTR_ERR(wsa->dcodec), "unable to get dcodec clock\n");
 
 	wsa->mclk = devm_clk_get(dev, "mclk");
 	if (IS_ERR(wsa->mclk))
-		return PTR_ERR(wsa->mclk);
+		return dev_err_probe(dev, PTR_ERR(wsa->mclk), "unable to get mclk clock\n");
 
 	if (flags & LPASS_MACRO_FLAG_HAS_NPL_CLOCK) {
 		wsa->npl = devm_clk_get(dev, "npl");
 		if (IS_ERR(wsa->npl))
-			return PTR_ERR(wsa->npl);
+			return dev_err_probe(dev, PTR_ERR(wsa->npl), "unable to get npl clock\n");
 	}
 
 	wsa->fsgen = devm_clk_get(dev, "fsgen");
 	if (IS_ERR(wsa->fsgen))
-		return PTR_ERR(wsa->fsgen);
+		return dev_err_probe(dev, PTR_ERR(wsa->fsgen), "unable to get fsgen clock\n");
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
-- 
2.25.1

