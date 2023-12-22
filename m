Return-Path: <linux-kernel+bounces-9329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A329B81C432
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964591C2315C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F876C8E4;
	Fri, 22 Dec 2023 04:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Nc4tVtWy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FA04680;
	Fri, 22 Dec 2023 04:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BM2xWB2005082;
	Fri, 22 Dec 2023 04:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=idbO0IDbhwHN5Nc8Ui6tzsV8qsXFGcurQZi1An+1gEk
	=; b=Nc4tVtWyujNhBpnIN5WfQYsiPi/cNu3o72fVi25xoLb89QBHtHzv4Dz79XX
	FLZlBXwsR3WJgrH+t7fql+DuF4aYlEcjDoHy4bZ7+qzlwZKzRSb9AfjvHrzKJGlB
	42yyoxK/oAlbTovKDCbYc3exNpsPwC3914e70qvld3Ckm7+0htUvcex7GENAO7VQ
	d+yjTXZwdkc5qQoUXe299SkNg4CREIJIjvu40YxqHPK+PNmbqdDs6aXb3pBqIt1/
	7WtG68ZpJuOML6GdW3G54yMMjJ/DKRnjh1/kATFWS+6yWYKJmLZKli6VCwYQzl51
	qbHcfAypdQ9jzBnTVPe/awZ69Zw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4pq39x3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 04:39:25 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BM4dOel020644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 04:39:24 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 20:39:24 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Thu, 21 Dec 2023 20:39:23 -0800
Subject: [PATCH v2 2/8] clk: qcom: gdsc: Enable supply reglator in GPU GX
 handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231220-sa8295p-gpu-v2-2-4763246b72c0@quicinc.com>
References: <20231220-sa8295p-gpu-v2-0-4763246b72c0@quicinc.com>
In-Reply-To: <20231220-sa8295p-gpu-v2-0-4763246b72c0@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Ulf Hansson
	<ulf.hansson@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        "Catalin
 Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703219963; l=1305;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=hI4RUTgV6aNzXUBxuGbSe9M7DeXfj/xuciegClCNtSQ=;
 b=jbbgB4Mx9WR5STGXdvl2Kk3SCiNdNHOSbRdZyZ+r8LUBHAGchWnczQGMl0C4Tdn3SUzqcNQtWVzK
 6WQpWmbiDXnEt8ki78lnVB+XItr/FWew2Ma8c3ucXO4A+AE6mnvh
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _52n_NWp3ItObmWPSyKpHQItf4crynnb
X-Proofpoint-ORIG-GUID: _52n_NWp3ItObmWPSyKpHQItf4crynnb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 mlxlogscore=903 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312220028

The GX GDSC is modelled to aid the GMU in powering down the GPU in the
event that the GPU crashes, so that it can be restarted again. But in
the event that the power-domain is supplied through a dedicated
regulator (in contrast to being a subdomin of another power-domain),
something needs to turn that regulator on, both to make sure things are
powered and to match the operation in gdsc_disable().

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 drivers/clk/qcom/gdsc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 5358e28122ab..e7a4068b9f39 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -557,7 +557,15 @@ void gdsc_unregister(struct gdsc_desc *desc)
  */
 int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain)
 {
-	/* Do nothing but give genpd the impression that we were successful */
-	return 0;
+	struct gdsc *sc = domain_to_gdsc(domain);
+	int ret = 0;
+
+	/* Enable the parent supply, when controlled through the regulator framework. */
+	if (sc->rsupply)
+		ret = regulator_enable(sc->rsupply);
+
+	/* Do nothing with the GDSC itself */
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(gdsc_gx_do_nothing_enable);

-- 
2.25.1


