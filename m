Return-Path: <linux-kernel+bounces-46270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2D7843D4F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF4629B772
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCB479DC0;
	Wed, 31 Jan 2024 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LDO5e3RP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE3A79DA0;
	Wed, 31 Jan 2024 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698489; cv=none; b=R1CyNhRpBohhEFKYr7Fi5uICSCUxhlDh2MvzzTt8MV8wpKY2ZYGC4x2nCOOJAHYj0tEnV5r71CYfnJirXslrnHV3msyu+oeO+kF6NDX86tNFSrd7W4E7N16tXqc+dbg3Shk9dAy5KHWu9VTR5VIipzAEestnSF56BWRXkBab/rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698489; c=relaxed/simple;
	bh=YLkcq6jiBnvYDa/H00/UfL/H4AabT4B9uq79/aSn2cQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=supa2JgRIsINRtECXiwRznI0zpK+wezmWFRZAgCwhGijhQKd7ykXrrDepGGJKTZKAm1S7dpQHby7NITDD2HZ6PgG4JPim4ufXp/aR0GO+Dz9310RxO+6k6k6N6r2Fqp2O6o3IjQD1o4hDfJ61sAYhwpttNKhuusZvdgDqdTUh6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LDO5e3RP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V8OBJZ000684;
	Wed, 31 Jan 2024 10:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=HToiBbo
	TPz8qsLgu36/sThc02qvHG2OfSEjYxlrcBnw=; b=LDO5e3RPzTGvYEuIrO+4827
	PYqSPdd20WrhpOgydVFzeAdGUrtUx8SvCP4AuNBQ1qOogX0O+d3yx2Rtm45IQaWf
	lbygjix/2IHvxW7PwT8Loa9PTN+pBxv1l8TyqW+qwIobNg/EDSjTOvbqRvptsYqb
	Qn6jUxHXVZPx4vqatjWCNynrMnFaRrCog3bbMmT8bypBf3cbKFjPkp/LsUmCZk0a
	ayTHdVVssbVGxy8R+eJB8FR68x5azkcjDND9RKaoslb4Bw6g0xuEjWBSKupIY8FT
	PddkNBCtLivNy/KJO61AGqcENp5xtIdexFStfPbQTHcGH3vzBihZebls2k0YO3w=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyj148e2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 10:54:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VAsYZO025666
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 10:54:34 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 31 Jan 2024 02:54:33 -0800
From: Mao Jinlong <quic_jinlmao@quicinc.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
        "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>
CC: Mao Jinlong <quic_jinlmao@quicinc.com>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH] coresight: etm4x: Set skip_power_up in etm4_init_arch_data function
Date: Wed, 31 Jan 2024 02:54:19 -0800
Message-ID: <20240131105423.9519-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _SGaNrBWGboyoFvlHVjteLMJt-EAtZ3R
X-Proofpoint-ORIG-GUID: _SGaNrBWGboyoFvlHVjteLMJt-EAtZ3R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310081

skip_power_up is used in etm4_init_arch_data when set lpoverride. So
need to set the value of it before calling using it.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index c5ea808ea662..8afc07d1dd23 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1200,6 +1200,7 @@ static void etm4_init_arch_data(void *info)
 	struct etm4_init_arg *init_arg = info;
 	struct etmv4_drvdata *drvdata;
 	struct csdev_access *csa;
+	struct device *dev = init_arg->dev;
 	int i;
 
 	drvdata = dev_get_drvdata(init_arg->dev);
@@ -1213,6 +1214,10 @@ static void etm4_init_arch_data(void *info)
 	if (!etm4_init_csdev_access(drvdata, csa))
 		return;
 
+	if (!csa->io_mem ||
+	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
+		drvdata->skip_power_up = true;
+
 	/* Detect the support for OS Lock before we actually use it */
 	etm_detect_os_lock(drvdata, csa);
 
@@ -2040,11 +2045,6 @@ static int etm4_add_coresight_dev(struct etm4_init_arg *init_arg)
 	if (!drvdata->arch)
 		return -EINVAL;
 
-	/* TRCPDCR is not accessible with system instructions. */
-	if (!desc.access.io_mem ||
-	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
-		drvdata->skip_power_up = true;
-
 	major = ETM_ARCH_MAJOR_VERSION(drvdata->arch);
 	minor = ETM_ARCH_MINOR_VERSION(drvdata->arch);
 
-- 
2.41.0


