Return-Path: <linux-kernel+bounces-122517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E552E88F8F8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E46EB2442E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B5B53E01;
	Thu, 28 Mar 2024 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PFABM+hT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7438539FC6;
	Thu, 28 Mar 2024 07:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611729; cv=none; b=gq+CIyHQouuIti9SyumavGeKCk7nJCn4XjKN+a7MKLMaWB8+t4FU22RUBEjwQ04I7BSlXp8dmOnYG5EK5JEhPdVOZNGVaaZ4bTI3vkm/dswX+XKfM4GvU8r36oZDsOM+mgtkbruZmo7k9XWZLFtd4CmfAM0KGlBdvJfZtbEly3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611729; c=relaxed/simple;
	bh=tlBx7oOqUrm6s7zx5qxSN4ESXP0GXtbpOII01LQ6YoU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uvMkYkyLnJptT+i1mu0kwS1rxkSoj+Pg4i/ZhtQPj4BTADBfhv6rrcV6OYaXxerDgWTb0B4916MNfCulaMXqMJ+oCwaPSZdgs1vK/ed7wjw4oQpGTaOF5GwoPZQCuPvppEafoegDGhwLF/6uxtzN12MBRoBIdpYgEl+/MyK9Nfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PFABM+hT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42S3U83w010787;
	Thu, 28 Mar 2024 07:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=j5/0Tgv
	Z9oj4MRbW5a+JRH6ZrJo2P0+/KiPu6FyC9iA=; b=PFABM+hT5Q9ndqJJZaUHFdv
	U3htXfXbzxPCdKfwnWUBTfQg9Sxtzx59sXcjQWCNVp16nNanUDPj+4OU3hf9yoFQ
	uTa8GDjZ/ZiyXwOWqzw2D0BQRTK2IuIKlFtRRvAKwxwqGKf3VinJ/QITEwVyG31u
	+Jl5euwjKLOeBNef3T8LkegKWTIsr9dMA9fyAf4JnHcpOMcN24GANxULFx4IQMlH
	VeTc+u9OoXlktEiBK3yhu6pwAi2E8D9Y6IYippziRQgFbzJYh+w1m2unzEa5iTOx
	eiIcFfUVTyzdE2Rms3c/EaRa+INWKfMyY5hkU7VwbUkYltVBSECLHNN+fi0G3YA=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4u20jeby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:41:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42S7foO7027051
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 07:41:50 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 00:41:46 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <morten.rasmussen@arm.com>,
        <dietmar.eggemann@arm.com>, <lukasz.luba@arm.com>,
        <pierre.gondois@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mdtipton@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V4 0/2] firmware: arm_scmi: Register and handle limits change notification
Date: Thu, 28 Mar 2024 13:11:29 +0530
Message-ID: <20240328074131.2839871-1-quic_sibis@quicinc.com>
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
X-Proofpoint-ORIG-GUID: MfLWL6HP5CzjxEvD9iCv1dDq1Ldn5LZG
X-Proofpoint-GUID: MfLWL6HP5CzjxEvD9iCv1dDq1Ldn5LZG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_06,2024-03-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=799 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403280048

This series registers for scmi limits change notifications to determine
the throttled frequency and apply HW pressure.

V4:
* Use EXPORT_SYMBOL_GPL instead. [Trilok]
* Use a interim variable to show the khz calc. [Lukasz]
* Use driver_data to pass on the handle and scmi_dev instead of using
  global variables. Dropped Lukasz's Rb due to adding these minor
  changes.

V3:
* Sanitize range_max received from the notifier. [Pierre]
* Drop patches 1/2 from v2. [Cristian]
* Update commit message in patch 2.

V2:
* Rename opp_xlate -> freq_xlate [Viresh]
* Export cpufreq_update_pressure and use it directly [Lukasz]

Depends on:
HW pressure v6: https://patchwork.kernel.org/project/linux-arm-msm/cover/20240326091616.3696851-1-vincent.guittot@linaro.org/

Sibi Sankar (2):
  cpufreq: Export cpufreq_update_pressure
  cpufreq: scmi: Register for limit change notifications

 drivers/cpufreq/cpufreq.c      |  3 ++-
 drivers/cpufreq/scmi-cpufreq.c | 44 ++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h        |  2 ++
 3 files changed, 48 insertions(+), 1 deletion(-)

-- 
2.34.1


