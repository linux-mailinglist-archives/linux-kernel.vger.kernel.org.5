Return-Path: <linux-kernel+bounces-90071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8432086F9C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DFD5B21264
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 05:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC34107B6;
	Mon,  4 Mar 2024 05:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GHhPp0lL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00300D2E0;
	Mon,  4 Mar 2024 05:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709531638; cv=none; b=sFn/7MscQZzWVRC0AR5xeeHbXf/sErOU+v4aeEz519/92VFTHSDmIWU4pSNbxv+1hv+wjYcl9Z0RprHFEa1v1xtJavehFO2eFYEtIO3YGDPAYQVOtlO9s9z7+o8NXyMU+Y063FfyUJ/mCcz0hPWxoYaMpG6PH9CZPG2Y/rZZag4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709531638; c=relaxed/simple;
	bh=azEa54rrP1hdavQAhLGWDI3eOFRH68ZRQYBAvQR3tGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vodzy5QWCMmQPuv0jN6HJx89KuJSwZybYK80YAwpVqdCM9lw6LJx3Q6X7w+CfgEqrpa5sOsZe7G9qKS5OIePYi50uDMntcWbidkrjnTci16exiQOPFG49PzYT+JR7g9moeh9Kp5m4xv08LVSIXY3eMVuZeRWbhHU4c87A4hMUmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GHhPp0lL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4244vRUu009163;
	Mon, 4 Mar 2024 05:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=x5COyQJ
	7CScBXtdkv8sImIUxT6G6MPk/BPW0oxCnkl8=; b=GHhPp0lLwY68jsd7L7oKegW
	ww2GdJ8W7gJ4mV60/04UJNZuqr+7jc9tX3nko2lLsJLrg/AAGkJ2Tj1nCJlZijt0
	04ll6GhpTWL8UyWT2WCnlGiX4WJZwC3Igr+eDdm53enLmE/iGkipdUBEKze+gDxn
	aA+gKOJymyP/1BTk97cK/hBdhaOzWWMXexhc9M85v+C7XiRvUF1UDY/m6FET+X54
	OuOioZbxcatv/LlQBanbh8hxTgb1vXsysWDr2bdU9DKF+h3VQUbn7rslKeMNYwji
	b4g3D5H1CC137uC7tIrMN6Cd4f9ZuNVoeD0MuxY4vYLJFg24JntkaUDdXmUENKg=
	=
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wkvvm2mpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 05:53:51 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4245rllI007937;
	Mon, 4 Mar 2024 05:53:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3wkw6kx58y-1;
	Mon, 04 Mar 2024 05:53:47 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4245rlFs007917;
	Mon, 4 Mar 2024 05:53:47 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-wasimn-hyd.qualcomm.com [10.147.242.220])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 4245rkh7007911;
	Mon, 04 Mar 2024 05:53:47 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 3944840)
	id C18B450094C; Mon,  4 Mar 2024 11:23:45 +0530 (+0530)
From: Wasim Nazir <quic_wasimn@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        Wasim Nazir <quic_wasimn@quicinc.com>
Subject: [PATCH v2 1/3] dt-bindings: arm: qcom: Document rb5gen2 board
Date: Mon,  4 Mar 2024 11:23:31 +0530
Message-ID: <20240304055333.15952-2-quic_wasimn@quicinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240304055333.15952-1-quic_wasimn@quicinc.com>
References: <20240304055333.15952-1-quic_wasimn@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SKSZ3yqZF2xtt6zt-Pq4FhaBRS2hR_a8
X-Proofpoint-GUID: SKSZ3yqZF2xtt6zt-Pq4FhaBRS2hR_a8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_02,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=943 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040042

Document board bindings for Rb5gen2.
Rb5gen2 is using Rb5 gen2 SOM which is based on QCS8550 SoC.
RB5gen2 is development kit used for IOT solutions.

Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 0ca4333fa8cf..70b5034c4aa0 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -876,6 +876,13 @@ properties:
           - const: qcom,qcs8550
           - const: qcom,sm8550

+      - items:
+          - enum:
+              - qcom,qcs8550-rb5gen2
+          - const: qcom,qcs8550-rb5gen2-som
+          - const: qcom,qcs8550
+          - const: qcom,sm8550
+
       - items:
           - enum:
               - qcom,sa8155p-adp
--
2.43.2


