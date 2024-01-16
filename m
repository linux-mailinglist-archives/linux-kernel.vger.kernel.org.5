Return-Path: <linux-kernel+bounces-27123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6EE82EAD5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D5D1F2410C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C6D11CA9;
	Tue, 16 Jan 2024 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TcGROJY1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5D011713;
	Tue, 16 Jan 2024 08:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G7cIYE014536;
	Tue, 16 Jan 2024 08:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=FL4
	8iBa/xVcNymrl9/scuXQ7SEn9fK0L2qjW48jo/4c=; b=TcGROJY121C660nL0lR
	waW4SCxdKMtImdlQhleWRoBabJ+MZT6dLIrbl02K7ri7kTpdGSKwVwl9JNyJnAPs
	5zNOyEst+elHW7sPCyI9jNodKhAO+BwM7kB4AMO6WLshF1OeIdhnok5NXBts7VMJ
	YlYaU2UH9ZA6llTJkm7I/ons4UdJDQNcivHq2lxjySPrlsLqrv3zuYBFi/mJy6HD
	cRvf6SWMronkzGZ+NNbR+/Xo8WgnYbyIpiNv9d7FhxF0hmmJTxrUNljyBRNhadPV
	bXxix9YNhUJc2PIzYy/3TmAZVDcgrqkzzOhPUuljE0a2u/FFlAO+HrJbnwV2kWTs
	nig==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vn02ctgkc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 08:22:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40G8MrPI032168
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 08:22:53 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 16 Jan 2024 00:22:50 -0800
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date: Tue, 16 Jan 2024 13:52:43 +0530
Subject: [PATCH v2] watchdog: qcom: fine tune the max timeout value
 calculation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240116-wdt-v2-1-501c7694c3f0@quicinc.com>
X-B4-Tracking: v=1; b=H4sIANI8pmUC/1WMMRLCIBBFr5LZWhyWRI1W3sNJIQuYLYQIEXUy3
 F1MZ/n+/PcWSDayTXBqFog2c+LgK6hNAzRe/c0KNpVBSdVJRBQvM4udNvJwtOSwM1CfU7SO32v
 lMlQeOc0hftZoxt/672cUKFRP+67XrUbXnh9PJva0pXCHoZTyBdAndvWYAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705393370; l=2953;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=0E/oeE5cR5fOcIhs2f0ENHP4k2jRmTCCFZ4ckVyUzCo=;
 b=jJsT3SUMzzIJiY3mc3+LXbHSqbqXrxsEy5VzZ2SUxNzIz1JQGLO9hIpaNFcTJRPTtTyYqiVNH
 vB1R2eJHZmzB4ztdvZkovFAoa3EoOtiEyawb8+ooaEOY2H0K372Lv9p
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RA0-pmIoHGiVuqWsaSev1jzvoI9L16_p
X-Proofpoint-GUID: RA0-pmIoHGiVuqWsaSev1jzvoI9L16_p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160066

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
Changes in v2:
- drop the minimum timeout change from 30s to 32s
- Link to v1: https://lore.kernel.org/r/20240111-wdt-v1-1-28c648b3b1f3@quicinc.com
---
 drivers/watchdog/qcom-wdt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 9e790f0c2096..006f9c61aa64 100644
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
 

---
base-commit: 9e21984d62c56a0f6d1fc6f76b646212cfd7fe88
change-id: 20240111-wdt-5bd079ecf14d

Best regards,
-- 
Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>


