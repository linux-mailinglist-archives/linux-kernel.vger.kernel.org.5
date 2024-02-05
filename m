Return-Path: <linux-kernel+bounces-52945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7F9849EB8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1171F22597
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13D4374F5;
	Mon,  5 Feb 2024 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qs7V20L5"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2275E2E417;
	Mon,  5 Feb 2024 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148136; cv=none; b=LYac9AoGj/D+/rZFbTA6ygq/TkOVoqvTRlmM0k+Mvgl/koydAA8tJB9EqRGd6OY9fyy4l9YYM1NlZPdbw1k2D0b2vWBy2Bl0iUCDIhGZrERY4W2CQabM1/jnIgZFdQzTB6YhE2OHmelngMTxfil5TiFTpyuCAaDxeFqSVVyEBBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148136; c=relaxed/simple;
	bh=4GpfbZ2TFsq7JnL4hPEixlhDO6oCAPgBkfULLDcsLwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aogNPK3gWX6Ri6q88/BtVndk2w2aKlYIY7XbOHiDRF3e7MlWx85+du0ZhfxFiYZqmmWU5GABcF2WFK17ZkE1Fzv+UUjLAHHYpdIIqMnLUFMr7TDrNLzu9klv1JhpX3Pe+c4yu1zo/yWYgQQ+J0S69b8YZ0KbR2y+vQvkoADoyuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qs7V20L5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415FgDbt019713;
	Mon, 5 Feb 2024 15:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=PIj80zllNqkfH4CbEH1UNiL5y7/XAz4sdfYcehyLvwE=;
 b=Qs7V20L59VisxoGY3PYfmiXZadLKg6xTxv2iVhmOHAqc3EZjrK7rEHy0UNP1qPvWEk8S
 mzTLTa9Bu+3IEkp3b02dIMGS5MEuWn5rp0hr3xvr1w2dguVDS8I2wDCbt7Dfl59UIM8u
 EIouK7NQ0PClJMJmgWtpcFE0g7ZWog+e7G+TWK6r9GiB+iji7FJzg0fp8iuYoiuyuvrv
 uvC1Ytm7oKlrXevHRWnO0SniQ1Ls3UeM3w3KOIZ8FvDFslWwvaV2cjuJWDgJNswKsm6b
 4TuI0HbJuTm1MYOJJQKMfscwrPU8cfN7Xs4zOqEwRGUHsPo6UUq615bH3xaOMKzENvry Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w32j007vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 15:48:50 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415FgOmc020637;
	Mon, 5 Feb 2024 15:48:50 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w32j007uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 15:48:50 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415DDCDW008758;
	Mon, 5 Feb 2024 15:48:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w206y9he0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 15:48:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415Fmjp919661162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 15:48:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CFAF20043;
	Mon,  5 Feb 2024 15:48:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56A4C2004B;
	Mon,  5 Feb 2024 15:48:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Feb 2024 15:48:45 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Kees Cook <keescook@chromium.org>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 1/2] Compiler Attributes: Add __uninitialized macro
Date: Mon,  5 Feb 2024 16:48:43 +0100
Message-Id: <20240205154844.3757121-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205154844.3757121-1-hca@linux.ibm.com>
References: <20240205154844.3757121-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wi9a64xAkzuDakLO5HAnrDh7zXf2ZXid
X-Proofpoint-ORIG-GUID: MZexhMpaL87nb2c4TOhf222vS46Rr41A
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 suspectscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050119

With INIT_STACK_ALL_PATTERN or INIT_STACK_ALL_ZERO enabled the kernel will
be compiled with -ftrivial-auto-var-init=<...> which causes initialization
of stack variables at function entry time.

In order to avoid the performance impact that comes with this users can use
the "uninitialized" attribute to prevent such initialization.

Therefore provide the __uninitialized macro which can be used for cases
where INIT_STACK_ALL_PATTERN or INIT_STACK_ALL_ZERO is enabled, but only
selected variables should not be initialized.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 include/linux/compiler_attributes.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 28566624f008..f5859b8c68b4 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -333,6 +333,18 @@
  */
 #define __section(section)              __attribute__((__section__(section)))
 
+/*
+ * Optional: only supported since gcc >= 12
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-uninitialized-variable-attribute
+ * clang: https://clang.llvm.org/docs/AttributeReference.html#uninitialized
+ */
+#if __has_attribute(__uninitialized__)
+# define __uninitialized		__attribute__((__uninitialized__))
+#else
+# define __uninitialized
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-unused-function-attribute
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Type-Attributes.html#index-unused-type-attribute
-- 
2.40.1


