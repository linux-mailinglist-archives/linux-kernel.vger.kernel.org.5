Return-Path: <linux-kernel+bounces-125390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A40892547
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70ADA285D62
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAC413D53E;
	Fri, 29 Mar 2024 20:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L8gRcOX1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B013BC2E;
	Fri, 29 Mar 2024 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711744056; cv=none; b=OPBSKjFrF2w/aKYgriC1IBh2znuljYTNiT01Z6mT0viLFA0xBB0ZYLJKG0/Ja3AuvXXN3wyyLOWWizWI/LJB4m56eONH9Fs28ZZNQefAgtAR63FeTt2IwSXkMwnxCu7rdDXMaGwIjmA9yGcoljmpDmd4NMz0hf0UBlOke9h/Y3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711744056; c=relaxed/simple;
	bh=DmN7SbvHc83v86CT34JrU35maYPW9TcbhqkpKuMp20Y=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=H/bY0uIMvO9080riphCTnhAJyyCLI/j/xGw61vVnuhIf7UMYCAOMxUcSIrHrvlWPiv59BL8WxrWA+6dtvpp45DjpWY7lhZGjRcLAOYIhydsxyb6gcgixbZN+lKkPbHC6Bno7TVZ3mSTh8PNNJ1quw8AW/mJ6yUBnWhvyBiZFqkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L8gRcOX1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TKODvm021226;
	Fri, 29 Mar 2024 20:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding:to:cc; s=qcppdkim1; bh=FA9/ZSidqDsn9N
	VYFrPdU6Qa0ODwOHndzWtzGX+s/uM=; b=L8gRcOX1nJQyvvw8Is1dU9SwHRjpR0
	rSAud7fuaXBCp2r/JHEPiVUfVmakPG2ntQupOiXnKxe8UVQSCcTKIhwuF6+6W4D1
	Sj9oMXYgCSxQs5AhJTUBFMKU/zXNdecykatd68XTV40/GOyC602wi6KWaFMFMbC+
	6LJ/91HDbxvcwffFVI+IsgByH2lkll+uAPVJOfFFLhq3/DPLI4IPZK2KJ0G1W7Ve
	pkTtSorFBxyknvra0hSbVx/pbszz69FMudR+QoaTZq2LBMlQb67T9BS77JFq42FX
	ZR7Hr1kyoAiegRhT9wfWOd5v6GqLqrEmEafEkKU4NMOvyfoq1fEBkiIw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5dkykc05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 20:27:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TKRIYp018570
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 20:27:18 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 13:27:18 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/2] wifi: mac80211: Fix mac80211.h kernel-doc issues
Date: Fri, 29 Mar 2024 13:27:16 -0700
Message-ID: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACQkB2YC/x3MTQrCQAxA4auUrA3MjEKnXkVczE+0wTqVpFSh9
 O5Gl9/ivQ2UhEnh3G0gtLLy3Az+0EEZU7sTcjVDcOHkjmHAZyrRBe/xUeeCQsuaJqzkY46ur30
 ewNKX0I0//+3las5JCbOkVsbf7M1CE6najBvs+xeSJLS4hgAAAA==
To: Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Randy Dunlap
	<rdunlap@infradead.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cxJzS-vHLDcJd2RlKp36N6LAAiQgnjHC
X-Proofpoint-GUID: cxJzS-vHLDcJd2RlKp36N6LAAiQgnjHC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=367 mlxscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290183

Once again my process to validate a Qualcomm Innovation Center patch
has exposed pre-existing kernel-doc issues in mac80211.h. I think I
had previously fixed all of the issues here, but that was before Randy
made me aware that I was missing some warnings which I'm now seeing
using -Wall.

One of the issues was for a function which has a prototype but which
doesn't have an implementation, so just delete that one.

---
Jeff Johnson (2):
      wifi: mac80211: remove ieee80211_set_hw_80211_encap()
      wifi: mac80211: Add missing return value documentation

 include/net/mac80211.h | 50 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 20 deletions(-)
---
base-commit: 8ea3f4f1a1b4242d5fc273f41aa7c86f6b40178c
change-id: 20240329-mac80211-kdoc-retval-de18b807d7b9


