Return-Path: <linux-kernel+bounces-11145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B8B81E20A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 19:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AA08B21719
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 18:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A97537FA;
	Mon, 25 Dec 2023 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AQoXN31n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F8C52F77;
	Mon, 25 Dec 2023 18:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BPInQnJ010630;
	Mon, 25 Dec 2023 18:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=ftp
	HYL73P0PMwcf3vm6rL6xXEEG/VlZNKCFd75Qx88M=; b=AQoXN31nsRXM+bWTSC9
	AT/dKG5dko7Cw0WYc3z4om1PipbitdlYYQ0Q/expTtMhUgcrearW3Chk12WKrFFj
	p3He9K/lOFndAZBDn3zH+xGyE90VaI/mwF5fk6IxSZ12X0/ZqMznZOGg+ONYtpwF
	C/047i0DsKtx9/s+ACtzGYbP/9NJKIYlQmol809v8z/SVjrFBIEErlbkAEpC2ixX
	ifUbOF9FHfwxou30ZT7h0CwF6iBEI72qDct6GwFoCBlbTl99YAKFMr9QUPUIXgkH
	SA2qRIX7ywpsPECo0up7CsK1rrUqRK3NdiBpVI13Mfz4Fg2c5pG5uKEUz27M/f9u
	daQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v5pgvc5cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Dec 2023 18:52:58 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BPIqwfk022033
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Dec 2023 18:52:58 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Dec
 2023 10:52:57 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Mon, 25 Dec 2023 10:52:57 -0800
Subject: [PATCH] scripts/decode_stacktrace.sh: Support LLVM addr2line
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231225-decode-stacktrace-llvm-v1-1-abb9aa220cbf@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIjPiWUC/x2NQQrCQAwAv1JyNtBsdQ9+RTyk2dQurlvZ1CKU/
 t3gcQaG2cG0ZTW4djs03bLlpTrQqQOZuT4Uc3KG0IeBQrhgUlmSoq0sz7WxKJayvXAKsWeKdB4
 igccjm+LYuMrsef2U4vLddMrf/+12P44fVyVADX0AAAA=
To: Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers
	<ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt
	<justinstitt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703530377; l=2236;
 i=quic_bjorande@quicinc.com; s=20230915; h=from:subject:message-id;
 bh=oJebOxoPeoTym3cgqwcxkxFxxmZ7qB8J295Bv1j1YBg=;
 b=97Upa7nXp3PiuUtOwM3kJionIy4dQgtXEXbbwd+uM7nAkgxJxyOYhxsUf27He321eLdJXgJ7gxYL
 nBKfsPEdDaPG+ME4g8l0bJE1n6GSYPkNtXYkTqxNnjZsNzI35egZ
X-Developer-Key: i=quic_bjorande@quicinc.com; a=ed25519;
 pk=VkhObtljigy9k0ZUIE1Mvr0Y+E1dgBEH9WoLQnUtbIM=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0Q6qqyDAQf7p6PPC7zDFoVfT5vqx8IGS
X-Proofpoint-ORIG-GUID: 0Q6qqyDAQf7p6PPC7zDFoVfT5vqx8IGS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0 mlxlogscore=752
 malwarescore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312250149

The kernel build system adhere to the LLVM environment variable, to
select building the kernel using clang/llvm. In combination with the
ARCH environment variable the kernel can be cross-compiled without the
user specifying the CROSS_COMPILE variable.

The LLVM environment variable is used to specify the suffix of the llvm
executables (such as LLVM=-12 for llvm-addr2line-12), or to omit the
suffix when set to "1" (e.g. llvm-addr2line).

decode_stacktrace.sh allows invoking a specific addr2line executable by
prefixing the command with CROSS_COMPILE. At best allows the user to
trick decode_stacktrace.sh into invoking llvm-addr2line, and it does not
support specifying an alternative version based on the suffix.

Teach decode_stacktrace.sh about the two cases of the LLVM environment
variable, and use this to determine which addr2line to use. The current
behavior is maintained when the LLVM variable is not set.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
 scripts/decode_stacktrace.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 564c5632e1a2..adf1d64477a1 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -16,6 +16,13 @@ elif type c++filt >/dev/null 2>&1 ; then
 	cppfilt_opts=-i
 fi
 
+# Determine which addr2line to use
+case "$LLVM" in
+	""	) addr2line="${CROSS_COMPILE}addr2line";;
+	"1"	) addr2line="llvm-addr2line";;
+	*	) addr2line="llvm-addr2line${LLVM}";;
+esac
+
 if [[ $1 == "-r" ]] ; then
 	vmlinux=""
 	basepath="auto"
@@ -169,7 +176,7 @@ parse_symbol() {
 	if [[ $aarray_support == true && "${cache[$module,$address]+isset}" == "isset" ]]; then
 		local code=${cache[$module,$address]}
 	else
-		local code=$(${CROSS_COMPILE}addr2line -i -e "$objfile" "$address" 2>/dev/null)
+		local code=$(${addr2line} -i -e "$objfile" "$address" 2>/dev/null)
 		if [[ $aarray_support == true ]]; then
 			cache[$module,$address]=$code
 		fi

---
base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
change-id: 20231225-decode-stacktrace-llvm-f260a1614361

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


