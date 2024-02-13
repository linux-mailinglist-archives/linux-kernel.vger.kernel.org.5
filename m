Return-Path: <linux-kernel+bounces-63858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E398C85359A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F68828919F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12615FDA5;
	Tue, 13 Feb 2024 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eCa/zNsB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC2E5FB8D;
	Tue, 13 Feb 2024 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840355; cv=none; b=hoqOC2BvyDi7oNPb8agV95yGDQfWNx9zjgFOIE2+iDtqZb2S5/dnDUmCzuhQ7Isw/fhFX9wfhTOurqGhNEDwLE1+8nD9KVQTxHzth2oJk6qVGotJp8ExPGO/TqHtMCXCz2dkuaT1a/IoFsdeS6ZbSmGSddFyrsJMvQRiCKj7dn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840355; c=relaxed/simple;
	bh=uMcRI6AGrJm0s+87WXTb7ztcpujligYNic9LZD/J/g4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AoaffuiZYVZekQS1EYLObkhBk5cW1Oeim4tjGfS1ggCBNoEkT76qv70sAYD4vMus/rO6BYLClXLcqySdqKMMsDHNVau9Va/1AV/FlXhUcgE/jDrJX5UhO7vDMjaP6IbB82Ek7Fcbxr+l6rSyX2SPuISyWVnOUUx9Dd/yIaS7CSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eCa/zNsB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41DEMYMk017977;
	Tue, 13 Feb 2024 16:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=Rnm9gaj
	as+B3WYbpQ/+ZSa+PKnnpl5dm6jgMymLFYeE=; b=eCa/zNsBdqaRB5yXu2oq6HU
	tljn5Azx3CZm5z9w1KhOkt/d4ZmdS3ov4zwN48xOJHmb3NAfFiD9EgTvU6BRPZrS
	S6vLNz+QZ9uogV10Twm3F8LnQcRrfxySO9bQ/2NWY58YIMTofMBAONzVXxN/kY6V
	/oUEdQJ5ykjhhFeNV1Hw+00uXZjPrAxwEFAuFerkTbWxEX6r7XMZBZWQ6pEXqsD3
	nLaO/GCAevctXKHtkJOeKkTDCL8p3FmeOREwVTO/EbfQ/qeb8bRWwdUWATbi8CgH
	yE3MSWmQq6EYwT9QCBbMleNFOhuxPW/vtoWJH2xoFI8mLsKvMh860WnzRMNA5Gg=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7ww5sjvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 16:05:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41DG5XVv000924
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 16:05:33 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 13 Feb 2024 08:05:32 -0800
From: Mao Jinlong <quic_jinlmao@quicinc.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Mao
 Jinlong" <quic_jinlmao@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/2] coresight: tpdm: Change qcom,dsb-element-size to qcom,dsb-elem-bits
Date: Tue, 13 Feb 2024 08:05:16 -0800
Message-ID: <20240213160521.15925-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Az3vrLrOb0HTvj_a8-1BlTtjlurCfDSq
X-Proofpoint-ORIG-GUID: Az3vrLrOb0HTvj_a8-1BlTtjlurCfDSq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_08,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=749 bulkscore=0
 spamscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130126

As unit of dsb element size is bit, change qcom,dsb-element-size to
qcom,dsb-elem-bits.

Mao Jinlong (2):
  dt-bindings: arm: qcom,coresight-tpdm: Rename qcom,dsb-element-size
  coresight-tpda: Change qcom,dsb-element-size to qcom,dsb-elem-bits

 .../devicetree/bindings/arm/qcom,coresight-tpdm.yaml          | 4 ++--
 drivers/hwtracing/coresight/coresight-tpda.c                  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.41.0


