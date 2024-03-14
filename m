Return-Path: <linux-kernel+bounces-103627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD1987C220
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EB01C2109C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A83745F0;
	Thu, 14 Mar 2024 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WJRRaSQh"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1FD74434
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710437379; cv=none; b=ncoUAD84/D7X782QmjmBV3cJsS3TXTfycSJOzGDi3kQJM8/9+J3vNsQqwIlddKswHnjQNMpL8AGlrFHq7FBVLsyUeZSB3rEKQTNajQrIRreo2Xxhi9yq8nrXooYqyznTFTE3apytRSwMDi+x7OQXFfrZfvHgeaGLCIW/Xy5MULQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710437379; c=relaxed/simple;
	bh=0Ww33Wg5UIYOL9Ip6goVVOU6IiOqT8o4/ZhFKm6gan8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MnA1HPzCFh1oXmP0Nss7wTDmzbmtUSPXqXIAFSwJlKTlDFVPOHe/CHE55qFrENLH+We/0BuYS7M1zaumF7qqO6XH+hvgHelgsC3z0joMGqzntK6C6t0Vp2GqQ3o339o55njpV2d3cwuR5AF7zRa96n+DkArht6ZY+q5L0UCDNQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WJRRaSQh; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42ECMMug028834;
	Thu, 14 Mar 2024 17:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=CPDM30FZpONOuIQhJosU5sR1ZP3akaT93IpgmhOaJYc=;
 b=WJRRaSQhpu4uPpPLrwJepAdkwU7B/Z9/Xp+37QOxawg09LnZFU5xcf2HM9g5vlH7EgE0
 PzpHg2eOaNFy4ZRbbnJGpT+28MGCpma9xO9V+rTpO7RbCWA4vN0iUCpN+t+MpfC4Hvvl
 b74ir2hvNKLYrn7xZbnYVw+0OuAcwe2OIx05Ebq6zmnVnfOh2qvma9qTuoS1LXSffKaJ
 XECDPVddUWoOiA9cNM/M2EuKAWYIOEp6oIm7ylssXISlzOvtgxwEEXGvZ/FHHeIueG4G
 edVbNMODv1NESu85P3j6P1Cy+r4fkdI3VzZVoqxSM4QWABHtNp6GWZ0GWW3eFMBKBvjy gA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wv0acgv25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 17:29:23 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42EHIk4F004834;
	Thu, 14 Mar 2024 17:29:21 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3wre7b3eus-1;
	Thu, 14 Mar 2024 17:29:21 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de
Subject: [RFC PATCH] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
Date: Thu, 14 Mar 2024 17:29:20 +0000
Message-Id: <20240314172920.2708810-1-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140133
X-Proofpoint-GUID: pd_fm6EhVUkZflrZi0vJMEATails-4aF
X-Proofpoint-ORIG-GUID: pd_fm6EhVUkZflrZi0vJMEATails-4aF

This patch is a workaround for a bug where the PKRU value is not
restored to the init value before the signal handler is invoked.

Problem description:
Let's assume there's a multithreaded application that runs untrusted
user code. Each thread has its stack/code protected by a non-zero pkey,
and the PKRU register is set up such that only that particular non-zero
pkey is enabled. Each thread also sets up an alternate signal stack to
handle signals, which is protected by pkey zero. The pkeys man page
documents that the PKRU will be reset to init_pkru when the signal
handler is invoked, which means that pkey zero access will be enabled.
But this reset happens after the kernel attempts to push fpu state
to the alternate stack, which is not (yet) accessible by the kernel,
which leads to a new SIGSEGV being sent to the application, terminating
it.

Enabling both the non-zero pkey (for the thread) and pkey zero (in
userspace) will not work for us. We cannot have the alt stack writeable
by all - the rationale here is that the code running in that thread
(using a non-zero pkey) is untrusted and should not have access to the
alternate signal stack (that uses pkey zero), to prevent the return address
of a function from being changed. The expectation is that kernel should be
able to set up the alternate signal stack and deliver the signal to the
application even if pkey zero is explicitly disabled by the application
(as documented in the pkeys man page). The signal handler accessibility
should not be dictated by whatever PKRU value the thread sets up.

Solution:
The PKRU register is managed by XSAVE, which means the sigframe contents
must match the register contents - which is not the case here. We want
the sigframe to contain the user-defined PKRU value (so that it is
restored correctly from sigcontext) but the actual register must be
reset to init_pkru so that the alt stack is accessible and the signal
can be delivered to the application. It seems that the proper fix here
would be to remove PKRU from the XSAVE framework and manage it
separately, which is quite complicated. As a workaround, this patch does
something like this:

        orig_pkru = rdpkru();
        wrpkru(init_pkru & orig_pkru);
        xsave_to_user_sigframe();
        put_user(pkru_sigframe_addr, orig_pkru)

Note:
I think the use_xsave() check in __update_pkru_in_sigframe() is redundant,
but I'm not 100% sure.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Helped-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Helped-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 arch/x86/include/asm/fpu/xstate.h |  8 ++++
 arch/x86/kernel/fpu/internal.h    |  7 +---
 arch/x86/kernel/fpu/signal.c      |  4 +-
 arch/x86/kernel/fpu/xstate.c      | 13 +++++++
 arch/x86/kernel/signal.c          | 65 ++++++++++++++++++++++++++++++-
 5 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index d4427b88ee12..681d4bb5939c 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -112,6 +112,14 @@ void xsaves(struct xregs_state *xsave, u64 mask);
 void xrstors(struct xregs_state *xsave, u64 mask);
 
 int xfd_enable_feature(u64 xfd_err);
+void *get_xsave_standard_addr(struct xregs_state *xsave, int xfeature_nr);
+bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
+			      struct _fpx_sw_bytes *fx_sw);
+
+static __always_inline __pure bool use_xsave(void)
+{
+	return cpu_feature_enabled(X86_FEATURE_XSAVE);
+}
 
 #ifdef CONFIG_X86_64
 DECLARE_STATIC_KEY_FALSE(__fpu_state_size_dynamic);
diff --git a/arch/x86/kernel/fpu/internal.h b/arch/x86/kernel/fpu/internal.h
index dbdb31f55fc7..ab838c9625dd 100644
--- a/arch/x86/kernel/fpu/internal.h
+++ b/arch/x86/kernel/fpu/internal.h
@@ -4,12 +4,7 @@
 
 extern struct fpstate init_fpstate;
 
-/* CPU feature check wrappers */
-static __always_inline __pure bool use_xsave(void)
-{
-	return cpu_feature_enabled(X86_FEATURE_XSAVE);
-}
-
+/* CPU feature check wrapper */
 static __always_inline __pure bool use_fxsr(void)
 {
 	return cpu_feature_enabled(X86_FEATURE_FXSR);
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 247f2225aa9f..86fcae8ea141 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -24,8 +24,8 @@
  * Check for the presence of extended state information in the
  * user fpstate pointer in the sigcontext.
  */
-static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
-					    struct _fpx_sw_bytes *fx_sw)
+bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
+			      struct _fpx_sw_bytes *fx_sw)
 {
 	int min_xstate_size = sizeof(struct fxregs_state) +
 			      sizeof(struct xstate_header);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 117e74c44e75..81de5759a71a 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -941,6 +941,19 @@ static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 	return (void *)xsave + xfeature_get_offset(xcomp_bv, xfeature_nr);
 }
 
+/*
+ * Given an xstate feature nr, calculate where in the xsave
+ * buffer the state is. The xsave buffer should be in standard
+ * format, not compacted (e.g. user mode signal frames).
+ */
+void *get_xsave_standard_addr(struct xregs_state *xsave, int xfeature_nr)
+{
+	if (WARN_ON_ONCE(!xfeature_enabled(xfeature_nr)))
+		return NULL;
+
+	return (void *)xsave + xstate_offsets[xfeature_nr];
+}
+
 /*
  * Given the xsave area and a state inside, this function returns the
  * address of the state.
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 31b6f5dddfc2..b52edf9c29e8 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -224,11 +224,52 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	}
 }
 
+static inline int
+__update_pkru_in_sigframe(struct rt_sigframe __user *frame, u32 new_pkru)
+{
+	int err = -EFAULT;
+	struct _fpx_sw_bytes fx_sw;
+	struct pkru_state *pk = NULL;
+	struct sigcontext __user *sc;
+	unsigned long buf;
+
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE) || !use_xsave())
+		return 0;
+
+	if (!user_read_access_begin(frame, sizeof(*frame)))
+		goto out;
+	sc = (struct sigcontext __user *) &frame->uc.uc_mcontext;
+	unsafe_get_user(buf,
+			(unsigned long __user *)&sc->fpstate,
+			uaccess_end);
+	user_access_end();
+
+	if (unlikely(!check_xstate_in_sigframe((void __user *) buf, &fx_sw)))
+		goto out;
+
+	pk = get_xsave_standard_addr((struct xregs_state __user *) buf,
+			XFEATURE_PKRU);
+	if (!pk || !user_write_access_begin((struct xregs_state __user *) buf,
+				sizeof(struct xregs_state)))
+		goto out;
+	unsafe_put_user(new_pkru, (unsigned int __user *) pk, uaccess_end);
+
+	err = 0;
+
+uaccess_end:
+	user_access_end();
+out:
+	return err;
+}
+
 static void
 handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
 	bool stepping, failed;
 	struct fpu *fpu = &current->thread.fpu;
+	u32 orig_pkru;
+	u32 init_pkru_snapshot;
+	struct rt_sigframe __user *frame = NULL;
 
 	if (v8086_mode(regs))
 		save_v86_state((struct kernel_vm86_regs *) regs, VM86_SIGNAL);
@@ -264,8 +305,30 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	if (stepping)
 		user_disable_single_step(current);
 
+	/*
+	 * We must have access to both the current stack and the exception
+	 * stack. The exception stack must be accessible by the init PKRU
+	 * value. Temporarily set the PKRU to access both. It will be set
+	 * properly in fpu__clear_user_states().
+	 */
+	orig_pkru = read_pkru();
+	init_pkru_snapshot = pkru_get_init_value();
+	write_pkru(orig_pkru & init_pkru_snapshot);
+
 	failed = (setup_rt_frame(ksig, regs) < 0);
-	if (!failed) {
+	if (failed)
+		write_pkru(orig_pkru);
+	else {
+		/*
+		 * Overwrite the PKRU value on the signal frame with the
+		 * user-defined value so that it gets restored correctly
+		 * from sigcontext.
+		 */
+		frame = (struct rt_sigframe __force __user *)(regs->sp);
+		if (__update_pkru_in_sigframe(frame, orig_pkru))
+			pr_info("Failed to reset PKRU value to 0x%x on "
+				"the signal frame\n", orig_pkru);
+
 		/*
 		 * Clear the direction flag as per the ABI for function entry.
 		 *
-- 
2.39.3


