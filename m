Return-Path: <linux-kernel+bounces-23338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B1782AB43
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222D41F22AEE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A50312E70;
	Thu, 11 Jan 2024 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OcMUachO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3124125D2;
	Thu, 11 Jan 2024 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B8qwGc028566;
	Thu, 11 Jan 2024 09:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=wC0
	jU+h2FFEGXb51foOIPFw9J+XLtOLQWqH9N+guCa4=; b=OcMUachOKsf+uHghX1R
	Ylj1Kddtq0YlRyVerPMtkImVfvFeqiwUxpjj5ZIzxLmRuPfvTRyYhTS/FITGQbY/
	GLWC8h5C4M7I64Oed+KplqxQyHpDqwR4Rl1d+84HPCIKbdNJ1HTgtOVa79WVVCun
	Ci6fPe+S7TBNWJD5OBc4uOfrPmtiwj7bkHzR+TdhuqXF5PEoYY39HgWVpngJGsTD
	iKOrx8yel3Hn3OrZ9jOkjHw/+hnqcEwh95ToOyw9C5/Pp8cSTuUKSb0nREE6IiG5
	Uzow3Mw5lZ8nninMrvlGCEJX/BzP4tUjY8Eb/YYDdLog1ZAnnShH0taXSDxYfrcr
	s2w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vj7w20vg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 09:49:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40B9nuWV011339
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 09:49:56 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 11 Jan 2024 01:49:53 -0800
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date: Thu, 11 Jan 2024 15:19:45 +0530
Subject: [PATCH] watchdog: qcom: fine tune the max timeout value
 calculation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240111-wdt-v1-1-28c648b3b1f3@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALi5n2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQ0ND3fKUEl3TpBQDc8vU5DRDkxQloMqCotS0zAqwKdGxtbUAMCD9TVU
 AAAA=
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
CC: <linux-arm-msm@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kathiravan Thirumoorthy
	<quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704966593; l=3409;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=FZVjRTru12XWhGOth+NnAciNx+yWDLDhEJF3aKh2TzI=;
 b=fBWLblzF5TwlY0BQev3wRG7d+ACWWc6NEj2K0kzY/PhkcVf4AB1hUDxh/FOAk7+x2uKtKfwsq
 BrgDAS7wx+nCSNsdIkMwmE7ef8jNLQ5Bg4JsdcTDgvikcusw1p0sDWW
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WLryOy_DSVnvrN0x2NG9GY6I1lhshUtK
X-Proofpoint-ORIG-GUID: WLryOy_DSVnvrN0x2NG9GY6I1lhshUtK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110079

To determine the max_timeout value, the below calculation is used.

	max_timeout = 0x10000000 / clk_rate

cat /sys/devices/platform/soc@0/b017000.watchdog/watchdog/watchdog0/max_timeout
8388

However, this is not valid for all the platforms. IPQ SoCs starting from
IPQ40xx and recent Snapdragron SoCs also has the bark and bite time field
length of 20bits, which can hold max up to 32 seconds if the clk_rate is
32KHz.

If the user tries to configure the timeout more than 32s, then the value
will be truncated and the actual value will not be reflected in the HW.

To avoid this, lets add a variable called max_tick_count in the device data,
which defines max counter value of the WDT controller. Using this, max-timeout
will be calculated in runtime for various WDT contorllers.

With this change, we get the proper max_timeout as below and restricts
the user from configuring the timeout higher than this.

cat /sys/devices/platform/soc@0/b017000.watchdog/watchdog/watchdog0/max_timeout
32

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 drivers/watchdog/qcom-wdt.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 9e790f0c2096..83fc3e3abb03 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -41,6 +41,7 @@ static const u32 reg_offset_data_kpss[] = {
 struct qcom_wdt_match_data {
 	const u32 *offset;
 	bool pretimeout;
+	u32 max_tick_count;
 };
 
 struct qcom_wdt {
@@ -177,11 +178,13 @@ static const struct watchdog_info qcom_wdt_pt_info = {
 static const struct qcom_wdt_match_data match_data_apcs_tmr = {
 	.offset = reg_offset_data_apcs_tmr,
 	.pretimeout = false,
+	.max_tick_count = 0x10000000U,
 };
 
 static const struct qcom_wdt_match_data match_data_kpss = {
 	.offset = reg_offset_data_kpss,
 	.pretimeout = true,
+	.max_tick_count = 0xFFFFFU,
 };
 
 static int qcom_wdt_probe(struct platform_device *pdev)
@@ -236,7 +239,7 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	 */
 	wdt->rate = clk_get_rate(clk);
 	if (wdt->rate == 0 ||
-	    wdt->rate > 0x10000000U) {
+	    wdt->rate > data->max_tick_count) {
 		dev_err(dev, "invalid clock rate\n");
 		return -EINVAL;
 	}
@@ -260,7 +263,7 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 
 	wdt->wdd.ops = &qcom_wdt_ops;
 	wdt->wdd.min_timeout = 1;
-	wdt->wdd.max_timeout = 0x10000000U / wdt->rate;
+	wdt->wdd.max_timeout = data->max_tick_count / wdt->rate;
 	wdt->wdd.parent = dev;
 	wdt->layout = data->offset;
 
@@ -268,11 +271,11 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 		wdt->wdd.bootstatus = WDIOF_CARDRESET;
 
 	/*
-	 * If 'timeout-sec' unspecified in devicetree, assume a 30 second
-	 * default, unless the max timeout is less than 30 seconds, then use
+	 * If 'timeout-sec' unspecified in devicetree, assume a 32 second
+	 * default, unless the max timeout is less than 32 seconds, then use
 	 * the max instead.
 	 */
-	wdt->wdd.timeout = min(wdt->wdd.max_timeout, 30U);
+	wdt->wdd.timeout = min(wdt->wdd.max_timeout, 32U);
 	watchdog_init_timeout(&wdt->wdd, 0, dev);
 
 	/*

---
base-commit: 9e21984d62c56a0f6d1fc6f76b646212cfd7fe88
change-id: 20240111-wdt-5bd079ecf14d

Best regards,
-- 
Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>


