Return-Path: <linux-kernel+bounces-148458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 632BB8A82DD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01FE31F21F56
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA0C13D26F;
	Wed, 17 Apr 2024 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L/s35Z4+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFD413D260;
	Wed, 17 Apr 2024 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355797; cv=none; b=aXXETYGE7L+gGNqw9leC/+sua30gkGhCittZf6I2WKy9uxchCNbkIS578rtgbHJEIx72PFoRoCROjGJnSY52VmmAl7EkR8zxeip6E8bpSpZqEY10Ks9o9IqVN/L1MHeoQ0haHkfY081au30G+c361b45Zjqb/YijO/59AQZA0ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355797; c=relaxed/simple;
	bh=5ZCuMbSOx5PzTzG86k0uHA7B5Sds+m43lxgfPjVxcaE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GXdiQ5oQXJ2JxVRJID4vKPdCiq0xPM2huIf3eR4xK2vBw0z6TKtgJxfNkNxOPyZPGeO5xwo5qndibXu39/RYfJ8M/VNnnfjEosH8KnOrNjh7OVrgOPasM4vv+Idn/o0wdsqBnfT2qSDaHoCKeqs2fw3fV1YQwo0vNSRLpw3bNII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L/s35Z4+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H8Lw2p018158;
	Wed, 17 Apr 2024 12:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=IUd6C29
	1tIljlQ1DA+NAWe8phSTzOJc12+ylUffSaB0=; b=L/s35Z4+AP+1eSqiHsF90+H
	ysb3kwtZJwCB+C1nGx7y4/jjC6vfC9GIi4hugXe3R/wIa4niENKKx7uPQNIU48E3
	hHPQQXyM5CQZEMcX65pk/aUst5Ri5S5+Z5Dsz1mMlxMxTBA3llwWplschHeh9f1S
	1UTdBU4zs+Hi1QzbQWZ3JlkrdcfXQmMlLzvUvEFDpMmF8LiWVSK/XQ2IUejyd6Wp
	S+aqtfLYJ/MUYuw7d0UYUSUWej2SYBNcsXlvXZYtdxC3M36FTfsgrfKcwM5YbbwV
	5SAPXOggDdh3kMnvjn8UBy/cOp2e+HiNMTMJWLiQkhzTBBtcKIdJlaZPm5e7RAg=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjauprg6v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 12:09:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HC9nOa031198
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 12:09:49 GMT
Received: from hu-kbajaj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 05:09:45 -0700
From: Komal Bajaj <quic_kbajaj@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>,
        <quic_tsoni@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Komal Bajaj <quic_kbajaj@quicinc.com>
Subject: [PATCH v3 0/2] Enable various remoteprocs for qcm6490-idp and qcs6490-rb3gen2
Date: Wed, 17 Apr 2024 17:39:26 +0530
Message-ID: <20240417120928.32344-1-quic_kbajaj@quicinc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Pcuskxe2QWdddG_0pVf_fr6o0L_XHao_
X-Proofpoint-ORIG-GUID: Pcuskxe2QWdddG_0pVf_fr6o0L_XHao_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_09,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0
 mlxlogscore=424 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170084

Enable various applicable remoteproc nodes for qcm6490-idp
and qcs6490-rb3gen2.

Firmwares are not shared at linux-firmware.git, it is under legal approval process.
Meantime, submitting the DT node changes for FW for review.

--------
Changes in v3:
* Rebased on top of linux-next
* Added firmware path for modem for rb3gen2 board for GPS usecase
* Link to v2: https://lore.kernel.org/all/20240402090349.30172-1-quic_kbajaj@quicinc.com/

Changes in v2:
* Updating the firmware name from mdt to mbn
* Link to v1: https://lore.kernel.org/all/20231220114225.26567-1-quic_kbajaj@quicinc.com/

Komal Bajaj (2):
  arm64: dts: qcom: qcm6490-idp: Enable various remoteprocs
  arm64: dts: qcom: qcs6490-rb3gen2: Enable various remoteprocs

 arch/arm64/boot/dts/qcom/qcm6490-idp.dts     | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 10 ++++++++++
 2 files changed, 30 insertions(+)

--
2.42.0


