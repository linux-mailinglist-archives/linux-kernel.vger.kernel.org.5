Return-Path: <linux-kernel+bounces-78701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2975E861791
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82A7282C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4482128831;
	Fri, 23 Feb 2024 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aCvwFv21"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10F48663D;
	Fri, 23 Feb 2024 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704929; cv=none; b=HXkutJRmhJAxLvYTZ7TqaHDEo+WBm2N0wrt+Y1wkYigpEmmUSO+OUHEsHSDM+lRgygfmnAZ/YJiKYJ91/bsZp9osxCiUhhTwGRqfUcg8tKSqpCTE09ELALjFmH+Hj/CyCyoDxk84oEiWdZ+c4nLqbU2RzhGJsKdZm/hSyQLRdLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704929; c=relaxed/simple;
	bh=VSra52zqMJWH7KipolICK24PTwHPt/FGUYZKU1aK0UA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kfVHxU9+XMbQX/fFmUYWnkDLOHywMa47VQ/gxoHZx3mbOUT0RDX4KwiHOBT4RDoNdquReB6HeR/4PuZacIuNohSHiXKg0O4a//TTj2LXumSZ1FMlG3+0SpNPE4fT1Qr8AOAgT3qtld8Cf/YNBKKdms5PB1aLI7apYgNWGpBO9mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aCvwFv21; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NBZXHU008808;
	Fri, 23 Feb 2024 16:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=DX1+LZJ
	RS0HgO0vf8V4rF3WsGTPxp2gnvPc0W+M9/7Q=; b=aCvwFv21jYCnMLKfJkpZT8V
	1T1AcJhnDzG6/Ph+Omk0+umEH6Pqsb07eyAtm6grFWgwfAXf0XxtozQ70n2b0ygg
	mimuBeQkEFnisjDFx4vy7PxooHmwoMiilo5Pj/kmQZlP34Cp2enlkhLX1ifHlxHk
	uZba0knevGup9dagsPNEsf1JvsOul9HXLN3AVXHQRKgoR/x8gU//J7eHX4XQeRC3
	PXtWOVt93gWyO3f+q4aKnOxW+gX3WXAd6MnWPmmwA8PqQ7+BNDtrVvPaS0m0o+xN
	kytN0ZEKaCfln9/n2NwQH2At5Ejm+JStCi92uZsJj99cfww/iDpGe4gi4nm7jIw=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weqxd10ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 16:15:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NGFApB012261
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 16:15:10 GMT
Received: from jhugo-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 08:15:09 -0800
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <wim@linux-watchdog.org>, <linux@roeck-us.net>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <quic_rjendra@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo
	<quic_jhugo@quicinc.com>
Subject: [PATCH RESEND] dt-bindings: watchdog: qcom-wdt: Update maintainer to Rajendra Nayak
Date: Fri, 23 Feb 2024 09:14:55 -0700
Message-ID: <20240223161455.4009469-1-quic_jhugo@quicinc.com>
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
X-Proofpoint-GUID: AgA-Zzuh_EuwhtnO0KaU0hfY7UhSt7HJ
X-Proofpoint-ORIG-GUID: AgA-Zzuh_EuwhtnO0KaU0hfY7UhSt7HJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_02,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=966 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230118

The servers for the @codeaurora domain are long retired and any messages
sent there will bounce. Sai has left the company and appears no longer
active in the community which leaves this binding orphaned. Rajendra Nayak
has volunteered to take over as maintainer.

Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Rajendra Nayak <quic_rjendra@quicinc.com>
---

Rob, will you take this into your tree for 6.9?

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


