Return-Path: <linux-kernel+bounces-70079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B748592D8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82BE1C20ECC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060F58003A;
	Sat, 17 Feb 2024 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VeSQMZda"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42BB7C083;
	Sat, 17 Feb 2024 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708202860; cv=none; b=MxQhyrlDh2lkHHZLj2Bl2XGkaLvnS2T2BOcS3/pkTENWPlahpPwBw1tXajl2a/xKDNzg3A6msY8m4mGalKuxOI2041VjNBacpcEgkme31LcnEuqOj+MlIVBcaBTYmNX9lhY2KW4f6f+9JdG07lYM4UG9Il1n2wn3ZoBSUweXoOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708202860; c=relaxed/simple;
	bh=HnKx9iPuE4IPN64zmX/kH8me8NFDT3rJUm33jInlFlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pVKecgoTuh50Mki5n45GwICLx2rmwOrANRQrpGBsf0Ds3nGca9fP+yMBcfCVW8LL9VJ9awSQ+jzVWzHuswfdF7O5b1BW3T3hP+ujavlTzAJ0MCJlqKESlOdMYS2Vb8Rl9BWuNqo7X2N7X+DUTbk30dM+x+ih72O2JyY1SpKbgw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VeSQMZda; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41HKfqdI008951;
	Sat, 17 Feb 2024 20:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=4uQJLlCZzY6JP7PobQj8G3jZIyuyBP1oXAdYdvWkLZk
	=; b=VeSQMZdaPe8JMKldDyVCYaRSv01N2couLH8DkCI6dckDCP1C7eA3OsK8oGj
	M0jTCEmDftBWAQLVRtrtJvwvblLk9yVrhD+eUiATTsVoJnPc7Vqnubfr/jC/Jzww
	tfl+jH/XZ02d+fb/nBlRTC/2gAuAvImZ1HD3WBfn1ATPcAiQXiZDFHfpsCofifXX
	/O0iCYARx+YSGorLNS6kBcGlSDc20ocJeoI3VIZYBwtY5z5ubDjkvrHDrp+Rp611
	89cytHMvZ13JiI/DQu82bVPp6VY45gZzc/c7z8MjBzdQkgZt8lCcJVVGh9V2pJc4
	T3G7OjIgvZl/daseEAfu0h0m0ew==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3waj5s963v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 20:47:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41HKlVG3014329
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Feb 2024 20:47:31 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sat, 17 Feb
 2024 12:47:31 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 17 Feb 2024 12:47:01 -0800
Subject: [PATCH 1/2] MAINTAINERS: update Jeff Johnson e-mail address
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240217-update-maintainer-v1-1-1426cf7a8bb1@quicinc.com>
References: <20240217-update-maintainer-v1-0-1426cf7a8bb1@quicinc.com>
In-Reply-To: <20240217-update-maintainer-v1-0-1426cf7a8bb1@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>
CC: <ath10k@lists.infradead.org>, <ath11k@lists.infradead.org>,
        <ath12k@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KaLcL7MSXEXejgbXwDYTJWt2hxdbSIrL
X-Proofpoint-ORIG-GUID: KaLcL7MSXEXejgbXwDYTJWt2hxdbSIrL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-17_19,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=539 bulkscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402170172

I now have a @kernel.org e-mail address, so use that for my
maintenance activities.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92152ac346c8..77289fef78d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17974,7 +17974,7 @@ F:	drivers/media/tuners/qt1010*
 
 QUALCOMM ATH12K WIRELESS DRIVER
 M:	Kalle Valo <kvalo@kernel.org>
-M:	Jeff Johnson <quic_jjohnson@quicinc.com>
+M:	Jeff Johnson <jjohnson@kernel.org>
 L:	ath12k@lists.infradead.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath12k
@@ -17983,7 +17983,7 @@ F:	drivers/net/wireless/ath/ath12k/
 
 QUALCOMM ATHEROS ATH10K WIRELESS DRIVER
 M:	Kalle Valo <kvalo@kernel.org>
-M:	Jeff Johnson <quic_jjohnson@quicinc.com>
+M:	Jeff Johnson <jjohnson@kernel.org>
 L:	ath10k@lists.infradead.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath10k
@@ -17993,7 +17993,7 @@ F:	drivers/net/wireless/ath/ath10k/
 
 QUALCOMM ATHEROS ATH11K WIRELESS DRIVER
 M:	Kalle Valo <kvalo@kernel.org>
-M:	Jeff Johnson <quic_jjohnson@quicinc.com>
+M:	Jeff Johnson <jjohnson@kernel.org>
 L:	ath11k@lists.infradead.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath11k

-- 
2.42.0


