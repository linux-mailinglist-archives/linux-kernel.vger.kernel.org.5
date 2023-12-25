Return-Path: <linux-kernel+bounces-11134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6F881E1DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 18:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA994B216F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 17:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBDE53803;
	Mon, 25 Dec 2023 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lkpaX9Hg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3DB537FB;
	Mon, 25 Dec 2023 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BPHdLd5001550;
	Mon, 25 Dec 2023 17:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=H1m
	7EdXOp3XE9uXDUxzf5EPHgYuqg/AyUCZ1zDiRrCM=; b=lkpaX9Hgx/3z+dywrH1
	Ig/OCPJfKggv5xTjUtG1VZGw9wV2UOlm7iI2YrskOPapy9MM7+5UuKJ6ijDJHha7
	w0M35txQ/8VofpDsmr4hbdIPvjnqDVbxX/VgvtTP0pP19q2uy8j7kwYkKNojUqcG
	qnHb4cBwsvjOfHh+nxbCvWn/k/tGhstKiRjalPNWdbXtKB+tJvT5BBjcRaYQc+qL
	nUbAFBhe9rH3/CG6v6K0hYZ+TMDMuQVd5dN8GrSJGZuwadUzThanajukZxnL/lty
	BChuGKQB4WpT1hTvobbWgn/g76wvzlG+172eboaksd+3RPJI7DHQKEIT4EKlJwOL
	dqA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v5pvnm0ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Dec 2023 17:44:45 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BPHiipI008884
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Dec 2023 17:44:44 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Dec
 2023 09:44:44 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Mon, 25 Dec 2023 09:40:35 -0800
Subject: [PATCH] scripts/decode_stacktrace.sh: Strip unexpected CR from
 lines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231225-decode-stacktrace-cr-v1-1-9f306f38cdde@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJK+iWUC/x2N0QrCMAwAf2Xk2YBtUZi/Ij6kaeqCo5N0E2Hs3
 w0+3sFxO3QxlQ63YQeTj3ZdmkM4DcATtaegFmeI55hCjBcswksR7CvxazViQTZMNY8SElUer+B
 ppi6YjRpPHrdtnl2+Tap+/6/74zh+SP+3lHsAAAA=
To: Andrew Morton <akpm@linux-foundation.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703526284; l=1550;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=Y7SC2X3LfD2fZj8ETm1az70ZeJOt1T61E7890gEJ8JQ=;
 b=5ys5nezc7ifnaiTKu0XGpWpT1QfhDKEDErMKCPeJHiyahReyFPcdW38q0NG1NaX4Sgm428iBZYe6
 raxWYSNnCbBnegHH75QpSVAmAb0TzHxVJnjD9WraL8GAM4fSWNYz
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sSrVI96a6k5LK26x7ISbRAlt1hqtBezy
X-Proofpoint-ORIG-GUID: sSrVI96a6k5LK26x7ISbRAlt1hqtBezy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 mlxlogscore=487 spamscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312250140

When the kernel log is acquired over a serial cable it is not uncommon
for the log to contain carriage return characters, in addition to the
expected line feeds.

When this output is feed into decode_stacktrace.sh, handle_line() fails
to strip the trailing ']' off the module name, which results in
find_module() not being able to find the referred to kernel module. This
is reported to the user as:

  WARNING! Modules path isn't set, but is needed to parse this symbol

The solution is to reconfigure the serial port, or to strip the carriage
returns from the log, but this isn't obvious from the error reported by
the script.

Instead, make decode_stacktrace.sh more user friendly by stripping the
trailing carriage return.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 scripts/decode_stacktrace.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 564c5632e1a2..cb980b144ca1 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -291,6 +291,9 @@ handle_line() {
 }
 
 while read line; do
+	# Strip unexpected carriage return at end of line
+	line=${line%$'\r'}
+
 	# Let's see if we have an address in the line
 	if [[ $line =~ \[\<([^]]+)\>\] ]] ||
 	   [[ $line =~ [^+\ ]+\+0x[0-9a-f]+/0x[0-9a-f]+ ]]; then

---
base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
change-id: 20231225-decode-stacktrace-cr-3fb9e13afc96

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


