Return-Path: <linux-kernel+bounces-97507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF92876B2D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8561C20CB0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440865A785;
	Fri,  8 Mar 2024 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E67n0Hjj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C1F2A8C1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709925798; cv=none; b=e7aP1mdK1KLC8o7C1/0VZqn793aU7WjSI/XaLJPHNnYCBU/q96s5u/uh3z/oxB7ratynHtkoxeGLL4SHC5Ynpbjpn9Ao3WCeuIRq71OUoMe2LcH4o7M+gf6WEzmEyz51bcZnvUfalEsPOS+TRS6qyX/BI+bPObyENvRibIxUe2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709925798; c=relaxed/simple;
	bh=a6lRYeFSEWwJIvgNJiuCEmtmp39uUP1nfwTccUdadkI=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=aeHICi/0bnjRstoCVdK2Nv2BSrJOkVROmh95t8s0UjqLFMXVfxy0+IEEFObd3KEVUqORu2eaDQV2AFYGguIZkDY10APW9Sx9ra1Xr0mu/nqHbrDJU3l2ttyqD/QhfYd9QoluikqIAltI63O2gIK5lmT2lP3t+xKA1mkSgnuVDwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E67n0Hjj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428GvBQm029115;
	Fri, 8 Mar 2024 19:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:to:cc:from:subject:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=a6lRYeFSEWwJIvgNJiuC
	Emtmp39uUP1nfwTccUdadkI=; b=E67n0Hjj+bjNP9BgWip48IvnsDdVpFciw68T
	Ubgm7sJNZ+1wnuaEy6QyKB2YXUx/9kFXaNkz+FLrQjBE+EW0MS2IkmlzJJBLrryg
	sJwg1aqZa42K3q8QswzCJ+al+EljnrT4+8ZqIzy5Tx84e+fuoti9GQrQ9kkY06GJ
	wrZIuIn3Ws8+Sql2lAfnwufn5jAq35UqKv7lkSjmKcJcWyBPHd8CKsKZMZgAyuiU
	tgpxrtNpwnJHLcGF5B+2x/NN6u+DOO+6qxpZvXA12vHkrEpoM0CK2yFI4Wc1ktNd
	cqPxn4Vb88s5BMReoLR+vy3kzwHAMnc3q8Rec2FpUdT6plXvJQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wr2v28uu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 19:23:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 428JN5NB009522
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 19:23:05 GMT
Received: from [10.110.115.232] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 8 Mar
 2024 11:23:04 -0800
Message-ID: <4b60941b-d0c0-4483-aed8-efd40a3f3d76@quicinc.com>
Date: Fri, 8 Mar 2024 11:23:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
        Boqun Feng
	<boqun.feng@gmail.com>
CC: open list <linux-kernel@vger.kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: cleanup guard for spin_lock_bh?
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RBbUkSxjkQW2Jg7SPEWKJurzAqGljw5g
X-Proofpoint-ORIG-GUID: RBbUkSxjkQW2Jg7SPEWKJurzAqGljw5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=527 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080153

Is there a reason there isn't a cleanup guard for spin_lock_bh? Or am I overlooking it?
I tried to search lore for any discussion on this point, but didn't see a clear match.

/jeff

