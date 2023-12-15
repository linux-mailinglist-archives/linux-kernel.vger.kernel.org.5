Return-Path: <linux-kernel+bounces-1526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6824D814FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077C11F2444C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA463FE5F;
	Fri, 15 Dec 2023 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WDql3P5U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180403FE40;
	Fri, 15 Dec 2023 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFIDXRU018255;
	Fri, 15 Dec 2023 18:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=t6s
	jwTTEMurBtYFGKNA1rJneCPYBdA2fvAB/fMn1cDk=; b=WDql3P5Uu4yoQSjEmkp
	jvL2HXRLgC0lbOC0inGuRz0rKgUYswXgtJWhEmSv5NwRllAyFlN0tAt0TlUC1qw/
	2J4J9qEMN439hpHYG+RYY608nTR5GgJyUHEIwQPHG6y3WBoAh4OAMbu2zpxpD2Z0
	ALCVo9bYrjnEAWQlGb7rqgKQOoodMVKP77T/A8LK3Uz67p5HGNqosVeH8XkpCzUT
	vf1CNfiJBgiKj8EmFHtQBvdZqOWtq76Dzq9GJurkJhF67upf9twp9HnudegCDVZk
	Y085iGCaVahUFmy7snP/XS22dUjK2F7DwQXT8WVUQXT2AFZw/Bsx65IFugh7FvVU
	usQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0up201sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 18:26:55 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFIQtrd001897
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 18:26:55 GMT
Received: from [169.254.0.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 10:26:54 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Fri, 15 Dec 2023 10:26:40 -0800
Subject: [PATCH] scripts/decode_stacktrace.sh: Use LLVM environment
 variable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231215-llvm-decode-stacktrace-v1-1-201cb86f4879@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAF+afGUC/4WNTQ6CMBBGr0JmbU1/VKgr72FY4HSUidBqi42Gc
 HcrF3D5XvK9b4ZEkSnBsZohUubEwRdQmwqw7/yNBLvCoKU2SqudGIY8CkcYHIk0dXifYockpN2
 bxtZWyoODMn5EuvJ7DZ/bwj2nKcTP+pPVz/5NZiWUaKy+1Abrxhp9er4Y2eMWwwjtsixfUfICO
 L4AAAA=
To: Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers
	<ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt
	<justinstitt@google.com>,
        Manuel Traut <manut@linutronix.de>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, Elliot Berman <quic_eberman@quicinc.com>
X-Mailer: b4 0.13-dev
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 63bvn7dcg4qWbRItjJ2-hdFyotm5vUcs
X-Proofpoint-ORIG-GUID: 63bvn7dcg4qWbRItjJ2-hdFyotm5vUcs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=427
 impostorscore=0 priorityscore=1501 clxscore=1011 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150129

When using LLVM as the compiler, decode_stacktrace should also use
llvm-addr2line. Check if LLVM is set and add the appropriate
suffix/prefix.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 scripts/decode_stacktrace.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 564c5632e1a2..189b00f4e120 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -16,6 +16,16 @@ elif type c++filt >/dev/null 2>&1 ; then
 	cppfilt_opts=-i
 fi
 
+if [[ "${LLVM}" == "1" ]] ; then
+	addr2line="llvm-addr2line"
+elif [[ "${LLVM}" == */ ]] ; then
+	addr2line="${LLVM}llvm-addr2line"
+elif [[ "${LLVM}" == -* ]] ; then
+	addr2line="llvm-addr2line${LLVM}"
+else
+	addr2line="${CROSS_COMPILE}addr2line"
+fi
+
 if [[ $1 == "-r" ]] ; then
 	vmlinux=""
 	basepath="auto"
@@ -169,7 +179,7 @@ parse_symbol() {
 	if [[ $aarray_support == true && "${cache[$module,$address]+isset}" == "isset" ]]; then
 		local code=${cache[$module,$address]}
 	else
-		local code=$(${CROSS_COMPILE}addr2line -i -e "$objfile" "$address" 2>/dev/null)
+		local code=$(${addr2line} -i -e "$objfile" "$address" 2>/dev/null)
 		if [[ $aarray_support == true ]]; then
 			cache[$module,$address]=$code
 		fi

---
base-commit: 3f7168591ebf7bbdb91797d02b1afaf00a4289b1
change-id: 20231214-llvm-decode-stacktrace-09538979006d

Best regards,
-- 
Elliot Berman <quic_eberman@quicinc.com>


