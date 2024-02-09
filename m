Return-Path: <linux-kernel+bounces-59593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C82B84F978
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367C72892B4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC81D768FA;
	Fri,  9 Feb 2024 16:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o9Du5kxk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7E674E2B;
	Fri,  9 Feb 2024 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707495516; cv=none; b=tDb3FB7IgFtbZMS6YFXkqN/+CmuuXKNQsckn7EYRwZS6vUa9KZmSl6irkA8RnC/21kwXfJAWkD4Er8QbDB83jrYLFNacL53hW96gYGsyioC7Z9vDVQc1dbdVfzHlg02iFiYj2Ibne5LuHfc3TRPoWkxJKJwn8ut32YCuoqtOa+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707495516; c=relaxed/simple;
	bh=T2AfydLIYm7P7v0jVs0AD6Xigpk5QM18sacEyvHtS9o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FgHgqAUk8g5KCM8Vu2ji/LPGp+Q4ivDIY2VPG9pfSWklhIiNuo+p0foDeUrP3tTmhu0pbwGE3xQ7Qv3bjP2tgV0rx57QFaSLvzx4/dDt7gRhr+YKEqJHL5tAVU+94rSlMbF0z4zcVnRyI+TygY8wd+V/AkaJSqvU0qv0wP+hYoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o9Du5kxk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419FQ6VM012051;
	Fri, 9 Feb 2024 16:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=FDudMkc
	BnrHHsBx06brnVBQgTQBahGVuiHXHp0oAYrA=; b=o9Du5kxkPcRqsTsLIKOX+aA
	GYIvfoZ/6XGKFlsb7vn9D6iWDJqEaDoyFbDwgroqODuFKOJD2RI6GFn9aY1SQUh0
	o+qW8S95xjeEZfvFT77BQzZaQcj5RHEepRsU2ACjXnOwo/1WFiocXWvnqnJYC78m
	XlbAlU+QaY0vAp3hgM6D1PRRmQnXct/p6LM3RjaSc3byh1O2DxGV7nI/zi6bcXvP
	U6jfu5i2RFEL5LQ7TQ26inyRXvueLS1/g15+4rT1Y4lt159nKMPY4dtxeAjDfEaJ
	1I1wFWy8289QhoOLrr3xu7wIoOdn7iHt0F1RHUstAUKVtBZKw+wpRQ6RuE+QGTw=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4wbvkhqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 16:18:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 419GIFoj027267
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 16:18:15 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 9 Feb 2024 08:18:14 -0800
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <wim@linux-watchdog.org>, <linux@roeck-us.net>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <quic_rjendra@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo
	<quic_jhugo@quicinc.com>
Subject: [PATCH] dt-bindings: watchdog: qcom-wdt: Update maintainer to Rajendra Nayak
Date: Fri, 9 Feb 2024 09:18:00 -0700
Message-ID: <20240209161800.3872964-1-quic_jhugo@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nw2lAVp0wTIXFXzoSZxk-MU6i4UY9kmc
X-Proofpoint-ORIG-GUID: nw2lAVp0wTIXFXzoSZxk-MU6i4UY9kmc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_14,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxlogscore=775
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090120

The servers for the @codeaurora domain are long retired and any messages
sent there will bounce. Sai has left the company and appears no longer
active in the community which leaves this binding orphaned. Rajendra Nayak
has volunteered to take over as maintainer.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index a4f35c598cdb..47587971fb0b 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Qualcomm Krait Processor Sub-system (KPSS) Watchdog timer
 
 maintainers:
-  - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
+  - Rajendra Nayak <quic_rjendra@quicinc.com>
 
 properties:
   $nodename:
-- 
2.34.1


