Return-Path: <linux-kernel+bounces-103749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4A487C3EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E209B22A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275057603C;
	Thu, 14 Mar 2024 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R/PZ2e/g"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9D571750;
	Thu, 14 Mar 2024 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710446717; cv=none; b=MkEQfGOWEouJwt36PpBBs8bdPa4WR+9Mqi0mldOE1yk1M4HXFNnL1TYgf+vuMD7w0QvXk6UwDu1f4tyxhfXm+3uzDLlpWbbZDKMj8MWosy2r2JYjKQUxw/WB1HOyZU671A5zhBXF/30x8eKLuO47kg4fT4cYCu9aj22+/6jCUfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710446717; c=relaxed/simple;
	bh=AfZNiMuf+aRKSrN9yhoJPnwQSNTUG/o4Bdr+xYUO1nU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gc63JhvzFrac7SeTHxBT8SxPfuwFM0rQRxSSHMFGbSHa2FoY6NGEKGnFq3KCoTjJcRb2JKw4O5IFNu9JZfYqC0OxgCmUAfrxMljFQGFvRjLl57xpgx6bnGMDEJ4JjSitmx6zkdlxhoOhOpizvseysr2njLKcG60t66C6adfPOOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R/PZ2e/g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42ECLWNa027667;
	Thu, 14 Mar 2024 20:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=y6k9BHC
	ta1k7vYaUGdCU6yGFkgTyg1ttSbq9T+xA2iY=; b=R/PZ2e/gYLg65JaxHW41s9+
	R8C8/NpikCERM5KoNktqTYmkVcg/GB805+5eHFvy3V/O8lnhAgrv7VMtqArHT4/+
	17ryinQuit1W1aW/xu4AcgnxLAWFkvJ1CbmItDQfw/vkerms3wPm0wiuJ9pe3y2u
	BQ5MCM2TGdci06nFu859WE14TsvoMEa3CH4lrPDZncd5xV6HCUHHMWCxOxzbxnJw
	rDmhYU3FGcFH6qtTNg6uZkXkTQAOqJRafkPJgw8nhepk10WhLoraimQ1J5z6+vQy
	9NKnsK1AV/jE9SgM/zuHJdkWrlBJnek08O+B+qjH54AF6x2lMWko+9gG99nYjjA=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuujssuqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 20:05:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EK5CTg009411
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 20:05:12 GMT
Received: from hu-amelende-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Mar 2024 13:05:11 -0700
From: Anjelique Melendez <quic_amelende@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: [PATCH 0/5] Add GPIO support for various PMICs
Date: Thu, 14 Mar 2024 13:04:15 -0700
Message-ID: <20240314200419.4733-2-quic_amelende@quicinc.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: j7xGd0AWaWQXiiXllvifo7HQlecg_j4T
X-Proofpoint-GUID: j7xGd0AWaWQXiiXllvifo7HQlecg_j4T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 mlxlogscore=739 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140155

Add GPIO support for PMXR2230, PM6450, PMIH010X and PMD802X

Anjelique Melendez (2):
  dt-bindings: pinctrl: qcom,pmic-gpio: Add PMIH010x and PMD802x binding
  pinctrl: qcom: spmi-gpio: Add support for pmih010x and pmd802x

David Collins (1):
  dt-bindings: pinctrl: qcom-pmic-gpio: add PMXR2230 and PM6450 binding

Jishnu Prakash (2):
  gpio: pinctrl-spmi-gpio: Add support for pmxr2230
  gpio: pinctrl-spmi-gpio: Add support for pm6450

 .../bindings/pinctrl/qcom,pmic-gpio.yaml      | 26 +++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c      |  4 +++
 2 files changed, 30 insertions(+)

-- 
2.41.0


