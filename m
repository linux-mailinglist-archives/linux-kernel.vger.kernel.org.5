Return-Path: <linux-kernel+bounces-108010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DF28804C9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538F21C20E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31513383A0;
	Tue, 19 Mar 2024 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W61U+Teq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F692D046;
	Tue, 19 Mar 2024 18:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872797; cv=none; b=Ut5iaV+ygWkc8mbH4HUmWz1i61F8VXswytScnyy9w3mKaelruifMDr/CJV+FrJ7ZFik0yDpN2yCITsBhKBgHJQIb8CQYRwhM1XXy+NAg5BoIAKxg4fPyk9hccSZQojD17CRltqs3lnODodch1h0b4C/nLCnAdzjitmnSJn/EoBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872797; c=relaxed/simple;
	bh=Xo7bm4la7SjcUjbSchajON2M4uDLJxLLgwpXKGnmfzM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=gOcVuid4pvQoUHSMIkx6HwHieRzksX3ex+tRXucUEgZb7UtQbWtHfm9JpMKi4s4lT2iiEnL8m7V9UqE24iWUfSYb62zw0oWaYYSbN6sOKxZC71zTykOSOul59bzLF5H4zpfHY+sKDWWF/510zGVkZMOWF1e5UMheC9Dw0v/dDtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W61U+Teq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JHGnEY031152;
	Tue, 19 Mar 2024 18:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=z2dHYiuKerUtQ1
	J02m7ksMx8MzEV91XQ+wqADPY2Wa4=; b=W61U+TeqJHWlEuwjKSoyan3WOlJH6c
	ILejal9yev/WuV+b+YbyIiaFkxBVn1HL9sKg1fXG5DmPvhUz/zihTZSqa72qyg3X
	687o9TC/ugVUvphxYUrFje4aK3vAqoqxbUInRNTMvBlBCX621m0FxJsaRxsP3gcv
	gckKw2RXKXL9ggkPQEUrzvSxINWTpH4Mpw4PvhuZZVuS8KPLqWo9QzDrR3k5oTm9
	eklhbQAzuwnlkkSOeYtlkoD7JbF3EeKK6lObh48/EWhk/UCu/hBRMLUN4BiJxqRO
	3HfuvmECgQmYQVl691uH4V1fXDN+GHS3ejvdiR06essuN2sabPQFD7xQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy2e9j3k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 18:26:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JIQT6t017756
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 18:26:29 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 11:26:29 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/3] wifi: nl80211: fix nl80211 UAPI kernel-doc
Date: Tue, 19 Mar 2024 11:26:22 -0700
Message-ID: <20240319-kdoc-nl80211-v1-0-549e09d52866@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM7Y+WUC/3WNyw7CIBBFf6Vh7RigD1tX/ofpgtJBJioo1Kam4
 d+l3bs8yb3nrCxiIIzsXKws4EyRvMsgDgXTVrkbAo2ZmeSy4qVo4T56De7RcikEmEYMaJq643X
 N8uUV0NCy66595kFFhCEop+0mUZMFh8u0TS3FyYfvHp7FdvjTmAVwkHgqZccNNhVe3h/S5PRR+
 yfrU0o/cwj/v8UAAAA=
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ex8s8V_b3j7D6lEKz7mN23sD6o-uf8v0
X-Proofpoint-ORIG-GUID: ex8s8V_b3j7D6lEKz7mN23sD6o-uf8v0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxlogscore=580 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190138

As part of my review of patches coming from the Qualcomm Innovation
Center I check to make sure that no checkpatch or kernel-doc issues
are introduced. An upcoming patch will propose a modification to
include/uapi/linux/nl80211.h. My review process flagged both
checkpatch and kernel-doc issues in the file, but these are
pre-existing issues. So this series fixes those pre-existing issues.

---
Jeff Johnson (3):
      wifi: nl80211: rename enum plink_actions
      wifi: nl80211: fix nl80211 uapi comment style issues
      wifi: nl80211: cleanup nl80211.h kernel-doc

 include/uapi/linux/nl80211.h | 236 +++++++++++++++++++++++--------------------
 1 file changed, 124 insertions(+), 112 deletions(-)
---
base-commit: f8c0799b2428a2599a540b0ba1e180a6e3460699
change-id: 20240318-kdoc-nl80211-f61bef659055


