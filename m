Return-Path: <linux-kernel+bounces-83664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081F4869CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A7E0B284F5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B8233993;
	Tue, 27 Feb 2024 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WEu5AY+5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E124520314;
	Tue, 27 Feb 2024 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053152; cv=none; b=mxe0up6Gv8U45heQvjnmNTvRz1Ec0TQ1gK6VroZtbJtunZZXOaGcD1kt0aDh9u+AE5qieS4YZLx2B88xXovNyZ+uuXcJugEkurMklWjXhRuUcQX6zxW53i5HSPV4olhpTbDSyzGhjASJLX8WNPqJOYdmQkJWmZ7lUGT4z5f6WRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053152; c=relaxed/simple;
	bh=tJQntz2HimOxkDqUs3Bko8vXdwa/USReYFCaj0wua9k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QVWywIJICPZAj+my0xtqnVQPjwsHD0JCPtJcx3F5guCTLJwsyt9DwMneoPOTbDD23CodPZDktg03Vc2/PfIBAPgPjoWmH7rhB7IAqbdNUH44D9FhXPk0PlX3MO8CJH2QWITC4jqSmwQexFcLEZnOL4oGhdPjbqM2+XoxfcFUo2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WEu5AY+5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RGZhh2017175;
	Tue, 27 Feb 2024 16:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=ztHPw0M
	rfKKaicbtEazrwB1M2B9Fp4OILHUWsSe9udU=; b=WEu5AY+57LnL/IpI6MiAriw
	6iDTsue2QPCh/O7mGZaBzttuCgbE0AfnmrIBaHw+kUSaO9E/pRI4msUsm7m90yw+
	aQf5bbF0FkFIMaGCN362hYkibzBGeyZz623ta1XFAs/J20zHBm68pcJF1J2hzdEX
	B57xrbK1PV4X7IqQk/+vedX/A1Lqf/YxSWr6XamYejOn7sny8Hajn4nCwJU+QGxj
	1zqBj5BSiWbmHjMQimTV2vT9l99slejGx61havMnmYtGGH1+7ZYulK3LW/adOkzp
	JOIiVhOA1Vw42xAeeBGNN7Z+yCu/Kg++A6wbsJiztD/vDW8BGPXw7wbyaf4wwiw=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whkd5g1dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 16:53:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RGrdw6027315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 16:53:39 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 08:53:34 -0800
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <dietmar.eggemann@arm.com>, <marcan@marcan.st>, <sven@svenpeter.dev>,
        <alyssa@rosenzweig.io>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <xuwei5@hisilicon.com>, <zhanjie9@hisilicon.com>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_rgottimu@quicinc.com>, <linux-arm-kernel@lists.infradead.org>,
        <asahi@lists.linux.dev>, <linux-pm@vger.kernel.org>,
        Sibi Sankar
	<quic_sibis@quicinc.com>
Subject: [PATCH 0/2] Fix per-policy boost behavior 
Date: Tue, 27 Feb 2024 22:23:07 +0530
Message-ID: <20240227165309.620422-1-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: o0L9HL1enTUEY6zBTZhXckawndGtb3Bg
X-Proofpoint-ORIG-GUID: o0L9HL1enTUEY6zBTZhXckawndGtb3Bg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_03,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=903 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270130

Fix per-policy boost behavior by incorporating per-policy boost flag
in the policy->max calculation and setting the correct per-policy
boost_enabled value on devices that use cpufreq_enable_boost_support().

Logs reported-by Dietmar Eggemann [1]:

[1] https://lore.kernel.org/lkml/265e5f2c-9b45-420f-89b1-44369aeb8418@arm.com/

Sibi Sankar (2):
  cpufreq: Fix per-policy boost behavior on SoCs using
    cpufreq_boost_set_sw
  cpufreq: apple-soc: Align per-policy and global boost flags

 drivers/cpufreq/apple-soc-cpufreq.c |  1 +
 drivers/cpufreq/cpufreq.c           | 15 +++++++++------
 drivers/cpufreq/freq_table.c        |  2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.34.1


