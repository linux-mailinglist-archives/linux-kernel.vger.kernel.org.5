Return-Path: <linux-kernel+bounces-110711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673628862C6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25DC02831C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4384136980;
	Thu, 21 Mar 2024 21:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ew0zOPv3"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966A713664F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058211; cv=none; b=k1IBcF/06D43T+zA/+xRx01+sL6jVBsaZLikIc0Wo4hJsPIf4mup+yTcQ+7jeWMN5FlrBoAsh/BfzmhPBghVOBRDpy8rbHDmSgaHQLWCE9rC+WLWAYrTiRWHnuZgHD3NMjrN+wA6gmd6FMATvMdJMghmL4TzhXoT2fDWEx1uop4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058211; c=relaxed/simple;
	bh=9dV/2VnrfFZf8SrYKWVgJZIDNLKyUpVLM0EYAntlz/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B84btnSk419le+Eu/MX1ERV8pfhbr/DalNLPbKyaG7xH/RNimrbQJL7c5ICejm7HNn/7zv9GnFve1dy+f3qbVettkOsKLg3Bw6o7niy+Bv01kPE3zW1GfimSw16vAPNWOWT8ElPbdcQWw8vCL2gtKecJptuA3TKKVdrBkdb+HWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ew0zOPv3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42LKYbSh015365;
	Thu, 21 Mar 2024 21:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=+dpK94TgpscLQ1q9mkoSacMojrhp9OYqAy5i/VykGQA=;
 b=ew0zOPv3kFoRIePZSlGf0fFgeb58QO0zpIFzlJghi3DroDjuh+Viev1ZrzC6RbBui0g9
 LbiiaVmsvbKuS0ly0WqRaCZG69s04rSRdDS6bAVPZ96ue5lPZjwtitRKFwS21Uq6Outi
 oYDwCwO0q8Ato1gAHqMSpM3ioXPI7pREluskbEJd+gbjherbAUcAgNA/2BhZYihwmx8A
 yGFSntY/NLguw1rP9nCQQ1vnMaSio8YK9tWkXIuGgvUU2X+1LyoapV2DXlBy/pDOIwXc
 LaErjLrhcjrd3N8gfBMtpnUo/AGwTfZhthHqLJWFlyxgw0uvmDUFwl5nYabwanxSGvNl 7Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww3aakeer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 21:56:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42LKxTuq007556;
	Thu, 21 Mar 2024 21:56:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1vahekd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 21:56:25 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42LLt1fk038093;
	Thu, 21 Mar 2024 21:56:25 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ww1vahej4-2;
	Thu, 21 Mar 2024 21:56:25 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        matthias.neugschwandtner@oracle.com, andrew.brownsword@oracle.com
Subject: [RFC PATCH v2 1/1] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
Date: Thu, 21 Mar 2024 21:56:22 +0000
Message-Id: <20240321215622.3396410-2-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240321215622.3396410-1-aruna.ramakrishna@oracle.com>
References: <20240321215622.3396410-1-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210165
X-Proofpoint-ORIG-GUID: kzlr5BCTyNxnDpgWGwLR_TesKbRDNFV8
X-Proofpoint-GUID: kzlr5BCTyNxnDpgWGwLR_TesKbRDNFV8

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
alternate signal stack (that uses pkey zero), to prevent the return
address of a function from being changed. The expectation is that kernel
should be able to set up the alternate signal stack and deliver the
signal to the application even if pkey zero is explicitly disabled by
the application. The signal handler accessibility should not be dictated
by the PKRU value that the thread sets up.

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

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Helped-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Helped-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 arch/x86/include/asm/fpu/signal.h  |  3 +-
 arch/x86/include/asm/sighandling.h | 10 +++----
 arch/x86/kernel/fpu/signal.c       | 44 ++++++++++++++++++++++++++----
 arch/x86/kernel/fpu/xstate.c       | 13 +++++++++
 arch/x86/kernel/fpu/xstate.h       |  1 +
 arch/x86/kernel/signal.c           | 40 +++++++++++++++++++++------
 arch/x86/kernel/signal_32.c        |  8 +++---
 arch/x86/kernel/signal_64.c        |  9 +++---
 8 files changed, 101 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index 611fa41711af..deaa81f44c2a 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -29,7 +29,8 @@ fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 
 unsigned long fpu__get_fpstate_size(void);
 
-extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
+extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size,
+				     u32 pkru);
 extern void fpu__clear_user_states(struct fpu *fpu);
 extern bool fpu__restore_sig(void __user *buf, int ia32_frame);
 
diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighandling.h
index e770c4fc47f4..de458354a3ea 100644
--- a/arch/x86/include/asm/sighandling.h
+++ b/arch/x86/include/asm/sighandling.h
@@ -17,11 +17,11 @@ void signal_fault(struct pt_regs *regs, void __user *frame, char *where);
 
 void __user *
 get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
-	     void __user **fpstate);
+	     void __user **fpstate, u32 pkru);
 
-int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs);
-int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
-int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
-int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
+int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru);
+int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru);
+int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru);
+int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru);
 
 #endif /* _ASM_X86_SIGHANDLING_H */
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 247f2225aa9f..1abbb6551992 100644
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
@@ -156,10 +182,17 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 	return !err;
 }
 
-static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
+static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf,
+					  u32 pkru)
 {
-	if (use_xsave())
-		return xsave_to_user_sigframe(buf);
+	int err = 0;
+
+	if (use_xsave()) {
+		err = xsave_to_user_sigframe(buf);
+		if (!err && cpu_feature_enabled(X86_FEATURE_OSPKE))
+			err = __update_pkru_in_sigframe(buf, pkru);
+		return err;
+	}
 	if (use_fxsr())
 		return fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
 	else
@@ -185,7 +218,8 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
  * For [f]xsave state, update the SW reserved fields in the [f]xsave frame
  * indicating the absence/presence of the extended state to the user.
  */
-bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
+bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size,
+			      u32 pkru)
 {
 	struct task_struct *tsk = current;
 	struct fpstate *fpstate = tsk->thread.fpu.fpstate;
@@ -228,7 +262,7 @@ bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int size)
 		fpregs_restore_userregs();
 
 	pagefault_disable();
-	ret = copy_fpregs_to_sigframe(buf_fx);
+	ret = copy_fpregs_to_sigframe(buf_fx, pkru);
 	pagefault_enable();
 	fpregs_unlock();
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 117e74c44e75..22623abf32b6 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -991,6 +991,19 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 	return __raw_xsave_addr(xsave, xfeature_nr);
 }
 
+/*
+ * Given an xstate feature nr, calculate where in the xsave
+ * buffer the state is. The xsave buffer should be in standard
+ * format, not compacted (e.g. user mode signal frames).
+ */
+void *get_xsave_addr_user(struct xregs_state *xsave, int xfeature_nr)
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
index 3518fb26d06b..ade07e78fd26 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -55,6 +55,7 @@ extern void fpu__init_cpu_xstate(void);
 extern void fpu__init_system_xstate(unsigned int legacy_size);
 
 extern void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
+extern void *get_xsave_addr_user(struct xregs_state *xsave, int xfeature_nr);
 
 static inline u64 xfeatures_mask_supervisor(void)
 {
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 31b6f5dddfc2..36134931df68 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -74,7 +74,7 @@ static inline int is_x32_frame(struct ksignal *ksig)
  */
 void __user *
 get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
-	     void __user **fpstate)
+	     void __user **fpstate, u32 pkru)
 {
 	struct k_sigaction *ka = &ksig->ka;
 	int ia32_frame = is_ia32_frame(ksig);
@@ -139,7 +139,8 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 	}
 
 	/* save i387 and extended state */
-	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size))
+	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx,
+				      math_size, pkru))
 		return (void __user *)-1L;
 
 	return (void __user *)sp;
@@ -206,7 +207,7 @@ unsigned long get_sigframe_size(void)
 }
 
 static int
-setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
+setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru)
 {
 	/* Perform fixup for the pre-signal frame. */
 	rseq_signal_deliver(ksig, regs);
@@ -214,21 +215,41 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	/* Set up the stack frame */
 	if (is_ia32_frame(ksig)) {
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO)
-			return ia32_setup_rt_frame(ksig, regs);
+			return ia32_setup_rt_frame(ksig, regs, pkru);
 		else
-			return ia32_setup_frame(ksig, regs);
+			return ia32_setup_frame(ksig, regs, pkru);
 	} else if (is_x32_frame(ksig)) {
-		return x32_setup_rt_frame(ksig, regs);
+		return x32_setup_rt_frame(ksig, regs, pkru);
 	} else {
-		return x64_setup_rt_frame(ksig, regs);
+		return x64_setup_rt_frame(ksig, regs, pkru);
 	}
 }
 
+/*
+ * Ensure that the both the current stack and the alternate signal
+ * stack is writeable. The alternate stack must be accessible by the
+ * init PKRU value.
+ */
+static inline u32 sig_prepare_pkru(void)
+{
+	u32 current_pkru = read_pkru();
+	u32 init_pkru_snapshot = pkru_get_init_value();
+
+	write_pkru(current_pkru & init_pkru_snapshot);
+	return current_pkru;
+}
+
+static inline void sig_restore_pkru(u32 pkru)
+{
+	write_pkru(pkru);
+}
+
 static void
 handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
 	bool stepping, failed;
 	struct fpu *fpu = &current->thread.fpu;
+	u32 pkru;
 
 	if (v8086_mode(regs))
 		save_v86_state((struct kernel_vm86_regs *) regs, VM86_SIGNAL);
@@ -264,7 +285,8 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	if (stepping)
 		user_disable_single_step(current);
 
-	failed = (setup_rt_frame(ksig, regs) < 0);
+	pkru = sig_prepare_pkru();
+	failed = (setup_rt_frame(ksig, regs, pkru) < 0);
 	if (!failed) {
 		/*
 		 * Clear the direction flag as per the ABI for function entry.
@@ -281,6 +303,8 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 		 * Ensure the signal handler starts with the new fpu state.
 		 */
 		fpu__clear_user_states(fpu);
+	} else {
+		sig_restore_pkru(pkru);
 	}
 	signal_setup_done(failed, ksig, stepping);
 }
diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index c12624bc82a3..68f2bfd7d6e7 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -228,7 +228,7 @@ do {									\
 		goto label;						\
 } while(0)
 
-int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
+int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru)
 {
 	sigset32_t *set = (sigset32_t *) sigmask_to_save();
 	struct sigframe_ia32 __user *frame;
@@ -246,7 +246,7 @@ int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
 		0x80cd,		/* int $0x80 */
 	};
 
-	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
+	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp, pkru);
 
 	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
 		restorer = ksig->ka.sa.sa_restorer;
@@ -299,7 +299,7 @@ int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
 	return -EFAULT;
 }
 
-int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
+int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru)
 {
 	sigset32_t *set = (sigset32_t *) sigmask_to_save();
 	struct rt_sigframe_ia32 __user *frame;
@@ -319,7 +319,7 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 		0,
 	};
 
-	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
+	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp, pkru);
 
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 23d8aaf8d9fd..b5c9535ff08b 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -161,7 +161,7 @@ static unsigned long frame_uc_flags(struct pt_regs *regs)
 	return flags;
 }
 
-int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
+int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru)
 {
 	sigset_t *set = sigmask_to_save();
 	struct rt_sigframe __user *frame;
@@ -172,7 +172,8 @@ int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
 		return -EFAULT;
 
-	frame = get_sigframe(ksig, regs, sizeof(struct rt_sigframe), &fp);
+	frame = get_sigframe(ksig, regs, sizeof(struct rt_sigframe), &fp,
+			     pkru);
 	uc_flags = frame_uc_flags(regs);
 
 	if (!user_access_begin(frame, sizeof(*frame)))
@@ -300,7 +301,7 @@ int copy_siginfo_to_user32(struct compat_siginfo __user *to,
 	return __copy_siginfo_to_user32(to, from);
 }
 
-int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
+int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru)
 {
 	compat_sigset_t *set = (compat_sigset_t *) sigmask_to_save();
 	struct rt_sigframe_x32 __user *frame;
@@ -311,7 +312,7 @@ int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
 		return -EFAULT;
 
-	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
+	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp, pkru);
 
 	uc_flags = frame_uc_flags(regs);
 
-- 
2.39.3


