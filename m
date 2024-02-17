Return-Path: <linux-kernel+bounces-70078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 622BB8592D7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A9B1F216A5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781EB7FBCE;
	Sat, 17 Feb 2024 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YpmdmJiK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5E4149DF6;
	Sat, 17 Feb 2024 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708202859; cv=none; b=MCCHJlPkV+Oe/puMKpz6X6hoa/PMAkvsy1Q/5eHdTImctbFpIyyEKl0/utIgZ5TlOWEEUAnZ3SHZH29docd5g8hh6epkNoiuXSUTgyN2szZ8xupu0dx0U6+7f9KCRzhFoIj28DekdTSbbjb+mGljL61rZxVey9QJMmSQFefIpMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708202859; c=relaxed/simple;
	bh=VLAWQJKgpC7eOnZs+bz0cG5pyAkhbQHhV22m9xfvfQc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=LrBXTzPo4D7aUpqPn+f3QUTHTGFjQ4zipTvStAlEHn05i44pyfLe8KYNYOhsBUsNJ1MEKUQlTIDH5HY21mzxtb6KGXSz9X7a0UrUVRVJyM5rOn8ftcZcYEoGOXk87IjizsKq1UnrgL5VaAsF5QNHAvzGgcplCn+SuxSj8itn9hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YpmdmJiK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41HKdKBC018686;
	Sat, 17 Feb 2024 20:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=tGSb+OxlOFLfZg
	DrZvbPGEeFo5YrukPOxyq2xmqLWS4=; b=YpmdmJiKqRPvd6FZFHo2rgnl6ds6I6
	Xg/V0ClPNNCSDtk9FT41NCkGi2JTIst28be5pepIkjlSm25KSdE2JvbbQN08vhcJ
	N2w+Bpqva8YXWMsqEjb9SLr8POvMg+xPLxmtuRWuM9iJZXbJv5tVvbjC5POftMFs
	cw8q9K4FDL6Q+VhlwCRuaDr9/6phE04SSxSUWXuOV8ce7RfvVjkuRsZejIEQ7YHk
	s28h1Gq/aVsiwsbR90q6dKulk+MGvm5joNS+TeYePkYwRY4QywArk2Ua+kpzQ+xp
	NiDnBYoyHn24L5bOqE102RDRVuDfE+ghaKqqcsZjaDxY2gltvHWX2/LA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wanys0v7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 20:47:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41HKlVp7014388
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 20:47:31 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 17 Feb
 2024 12:47:31 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/2] wifi: make several MAINTAINERS updates for
 ath10k/ath11k/ath12k
Date: Sat, 17 Feb 2024 12:47:00 -0800
Message-ID: <20240217-update-maintainer-v1-0-1426cf7a8bb1@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEQb0WUC/x2MQQqAIBAAvyJ7TlCLzL4SHSzX2kMWWhGEf086z
 GEOMy8kjIQJevZCxJsS7aGIrBjMqw0LcnLFQQnVCCU1vw5nT+SbpXAWMHLjTT2ZzohWWyjdEdH
 T8z+HMecPm4udXmMAAAA=
To: Kalle Valo <kvalo@kernel.org>
CC: <ath10k@lists.infradead.org>, <ath11k@lists.infradead.org>,
        <ath12k@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5Azelj6IIp0FVcM-dcRXAL0D1pUO9bgh
X-Proofpoint-GUID: 5Azelj6IIp0FVcM-dcRXAL0D1pUO9bgh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_19,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=274 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402170172


---
Jeff Johnson (2):
      MAINTAINERS: update Jeff Johnson e-mail address
      MAINTAINERS: Add N: ath1*k entries to match .yaml files

 MAINTAINERS | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)
---
base-commit: 3ab6aff5793c3c7bdf6535d9b0024544a4abbdd5
change-id: 20240217-update-maintainer-9f93b989067a


