Return-Path: <linux-kernel+bounces-158991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929518B27D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4487B227C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA8D1514ED;
	Thu, 25 Apr 2024 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O8JaT3VO"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5013215099C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714068361; cv=none; b=I32bX+25dw7Wfnaxy2BN3dxNVshfnC7/K6KI6iuF8MYeFB/WsqCNeG/tPNEd2rDNd8SbmSR5pisxH2k0humdUDIMps8wLkGmqBd10iN+O1auvsxqtncanpFkbDlqeJE3zP8kogxiU1RuylfmcFvDzpYIbn76JeWGinVi13fRmq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714068361; c=relaxed/simple;
	bh=K+0J6Bj04zWUE89Vk4cjO0gJ0H8x5e4z1TPRbDqnSTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gW2YKCkGfF8HM4E8cBRslKm6Mi3yDFhfBvFMDvfLZW8WvKy1Wqlzkd82YmynW2JeS4eiy3fsN9RDedtCC5OWkPh6eaBrqANsg5jBXUh8Mbf/PhmLnCGi7JQrhQXjlHMwmtqvH/4B0HMnFCIEU5BGzX8X+OjOa9JMxjphN7y1UYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O8JaT3VO; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PHNso6016494;
	Thu, 25 Apr 2024 18:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=bciJ3qiYRM4s0xTWQzH4AoRR6lKqwLH9mUMl9jleEC0=;
 b=O8JaT3VO87RUURXdZRHkJ+L/vCtr3Pl/w6dH/G3fIyBm2WYG8J5N8iC6nVb6QkeipBtm
 2YCH/Zl5Ndk+5lbH03d+4ugHQNvDiJrcoV8hwQH6Bc1degHBZY+tsgCTU+L5u/ss41PQ
 ayJ91t43b8hAU4e6GzHD0IXRf5y0mbiqwrdyT3OZ8pDEHo7xS3Wva1ZmqGWfG4qHLEXE
 Y9nQTGEcKUUZv92OgvuRssagx/1rTyyEumbgjIvH5DeqXVNXxgnHMfwbWJjVWVC75vwA
 A3KjyxI/5/t95bwLYUk0a6Op0jM6YWxZiIDezEjfhDfgCik8tAk7ootfsMlWqnwnyRkO OQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4g4m1eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 18:05:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43PH6prR001805;
	Thu, 25 Apr 2024 18:05:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45be415-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 18:05:47 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43PI20Kh032785;
	Thu, 25 Apr 2024 18:05:47 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xm45be3wd-3;
	Thu, 25 Apr 2024 18:05:47 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, keith.lucas@oracle.com, aruna.ramakrishna@oracle.com
Subject: [PATCH v3 2/4] x86/pkeys: Add helper functions to update PKRU on sigframe
Date: Thu, 25 Apr 2024 18:05:40 +0000
Message-Id: <20240425180542.1042933-3-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240425180542.1042933-1-aruna.ramakrishna@oracle.com>
References: <20240425180542.1042933-1-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_17,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404250131
X-Proofpoint-GUID: Fynm98EyF-LKuFz2FEJC2tvbUf96H4-Z
X-Proofpoint-ORIG-GUID: Fynm98EyF-LKuFz2FEJC2tvbUf96H4-Z

This patch adds helper functions that will update PKRU value on the
sigframe after XSAVE.

These functions will be called in a later patch; this patch does not
change any behavior as yet.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 arch/x86/kernel/fpu/signal.c | 26 ++++++++++++++++++++++++++
 arch/x86/kernel/fpu/xstate.c | 13 +++++++++++++
 arch/x86/kernel/fpu/xstate.h |  1 +
 arch/x86/kernel/signal.c     | 12 ++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 7654f368accd..dce84cce7cf8 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -63,6 +63,32 @@ static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 	return true;
 }
 
+/*
+ * Update the value of PKRU register that was already pushed
+ * onto the signal frame.
+ */
+static inline int
+__update_pkru_in_sigframe(struct xregs_state __user *buf, u32 pkru)
+{
+	int err = -EFAULT;
+	struct _fpx_sw_bytes fx_sw;
+	struct pkru_state *pk = NULL;
+
+	if (unlikely(!check_xstate_in_sigframe((void __user *) buf, &fx_sw)))
+		goto out;
+
+	pk = get_xsave_addr_user(buf, XFEATURE_PKRU);
+	if (!pk || !user_write_access_begin(buf, sizeof(struct xregs_state)))
+		goto out;
+	unsafe_put_user(pkru, (unsigned int __user *) pk, uaccess_end);
+
+	err = 0;
+uaccess_end:
+	user_access_end();
+out:
+	return err;
+}
+
 /*
  * Signal frame handlers.
  */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 33a214b1a4ce..8395a3633709 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -992,6 +992,19 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 	return __raw_xsave_addr(xsave, xfeature_nr);
 }
 
+/*
+ * Given an xstate feature nr, calculate where in the xsave
+ * buffer the state is. The xsave buffer should be in standard
+ * format, not compacted (e.g. user mode signal frames).
+ */
+void *get_xsave_addr_user(struct xregs_state __user *xsave, int xfeature_nr)
+{
+	if (WARN_ON_ONCE(!xfeature_enabled(xfeature_nr)))
+		return NULL;
+
+	return (void *)xsave + xstate_offsets[xfeature_nr];
+}
+
 #ifdef CONFIG_ARCH_HAS_PKEYS
 
 /*
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 19ca623ffa2a..6511797940ad 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -55,6 +55,7 @@ extern void fpu__init_cpu_xstate(void);
 extern void fpu__init_system_xstate(unsigned int legacy_size);
 
 extern void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
+extern void *get_xsave_addr_user(struct xregs_state *xsave, int xfeature_nr);
 
 static inline u64 xfeatures_mask_supervisor(void)
 {
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index d1c84b7f6852..75dfd05c59aa 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -225,6 +225,18 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru)
 	}
 }
 
+/*
+ * Enable all pkeys to ensure that both the current stack and the alternate
+ * signal stack are always writeable.
+ */
+static inline u32 sig_prepare_pkru(void)
+{
+	u32 orig_pkru = read_pkru();
+
+	write_pkru(0);
+	return orig_pkru;
+}
+
 static void
 handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
-- 
2.39.3


