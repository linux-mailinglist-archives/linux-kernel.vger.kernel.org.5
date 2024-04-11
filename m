Return-Path: <linux-kernel+bounces-139594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6878A04EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5AE1C23366
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8582AD2E6;
	Thu, 11 Apr 2024 00:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="NBMYzbZr"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCF88F58
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712796700; cv=none; b=kMMJ69cydwtAlVW22d4sPFQp8xasyDPmaeuVykeUnuvUxYcfQuaEBRXXS1awGFwxIuMJ30aS+9biWkJ8e/ipyHUc1pX9tTWOvIXGDOPufEO8gRJ3i3bAj5qyJ5SsppqfuIRotH5mNYufh8OHZWUQG8OobfDr3FQPC6CsQtbzhG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712796700; c=relaxed/simple;
	bh=m9CLW62XS8hN2CqVX6w4Wd1xurxuFzqdfTlLrD+lanE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A+9Q94SXGAlugcmR797qguwuEQYnB24k91O7cejx2R7KOwwOsqcW+FGC8hKzXSQjInseCOKpYuMh8kwbOqfI75pdguE1CCL1lENYHalZpz5cJLYpxOrP49m9S47xH/qIH6f9SWNcuMWcB+0H4A1iDGz7XJ/E5eC34aJow1b2zWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=NBMYzbZr; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id CAE1A425BC;
	Thu, 11 Apr 2024 00:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1712796695; bh=m9CLW62XS8hN2CqVX6w4Wd1xurxuFzqdfTlLrD+lanE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NBMYzbZr6/k0E9id/N48LMb1DAGMmEgWK38+ilVhdJFsyslsW1Tjk9IfslGPpUn7q
	 Lg5GAjyQ1tYLfPHKPVqfXMpLKHKjAo/DuUiJGBF23PdSc+8cQVo3FuXShADgAl9vkl
	 7xqq+QsdyROsylR3WQ1mM3ssN97T827ZPpX/6tzvWc1BiC1gvuCdoEEomncL2yNVS5
	 ZN6SMg4ZfdAAUlRtE7nKvRaElMu6aHxAp/Q7+1zuGbGbhxIieMmNZ2SMmFBnY8cJ/7
	 n97H3yNBzArs88UBgUzokbGAso06IslmxjNIthfQCu+YxV6WJxOvuk91d6V9PXsl3Y
	 6fpS3HLqyZKFQ==
From: Hector Martin <marcan@marcan.st>
Date: Thu, 11 Apr 2024 09:51:20 +0900
Subject: [PATCH 1/4] prctl: Introduce PR_{SET,GET}_MEM_MODEL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-tso-v1-1-754f11abfbff@marcan.st>
References: <20240411-tso-v1-0-754f11abfbff@marcan.st>
In-Reply-To: <20240411-tso-v1-0-754f11abfbff@marcan.st>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>
Cc: Zayd Qumsieh <zayd_qumsieh@apple.com>, Justin Lu <ih_justin@apple.com>, 
 Ryan Houdek <Houdek.Ryan@fex-emu.org>, Mark Brown <broonie@kernel.org>, 
 Ard Biesheuvel <ardb@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Oliver Upton <oliver.upton@linux.dev>, Miguel Luis <miguel.luis@oracle.com>, 
 Joey Gouly <joey.gouly@arm.com>, Christoph Paasch <cpaasch@apple.com>, 
 Kees Cook <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Baoquan He <bhe@redhat.com>, Joel Granados <j.granados@samsung.com>, 
 Dawei Li <dawei.li@shingroup.cn>, Andrew Morton <akpm@linux-foundation.org>, 
 Florent Revest <revest@chromium.org>, David Hildenbrand <david@redhat.com>, 
 Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>, 
 Josh Triplett <josh@joshtriplett.org>, Oleg Nesterov <oleg@redhat.com>, 
 Helge Deller <deller@gmx.de>, Zev Weiss <zev@bewilderbeest.net>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Asahi Linux <asahi@lists.linux.dev>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4103; i=marcan@marcan.st;
 h=from:subject:message-id; bh=m9CLW62XS8hN2CqVX6w4Wd1xurxuFzqdfTlLrD+lanE=;
 b=owGbwMvMwCUm+yP4NEe/cRLjabUkhjRxE56vn3UL3add4zzFreKy5N7SuRskrXwvmNXGz/jVH
 /2GVbaso5SFQYyLQVZMkaXxRO+pbs/p59RVU6bDzGFlAhnCwMUpABOZK8TI0J7+dcND45wuhinf
 Zx1+a/UjQUFU0VD3o+HhBZcD/88+Y8jw34Xlnt6TrOcad6wXtJX9/L6x58CWeotVixma9sh2fYx
 w4wAA
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5

On some architectures, it is possible to query and/or change the CPU
memory model. This allows userspace to switch to a stricter memory model
for performance reasons, such as when emulating code for another
architecture where that model is the default.

Introduce two prctls to allow userspace to query and set the memory
model for a thread. Two models are initially defined:

- PR_SET_MEM_MODEL_DEFAULT requests the default memory model for the
  architecture.
- PR_SET_MEM_MODEL_TSO requests the x86 TSO memory model.

PR_SET_MEM_MODEL is allowed to set a stricter memory model than
requested if available, in which case it will return successfully. If
the requested memory model cannot be fulfilled, it will return an error.
The memory model that was actually set can be queried by a subsequent
call to PR_GET_MEM_MODEL.

Examples:
- On a CPU with not support for a memory model at least as strong as
  TSO, PR_SET_MEM_MODEL(PR_SET_MEM_MODEL_TSO) fails.
- On a CPU with runtime-configurable TSO support, PR_SET_MEM_MODEL can
  toggle the memory model between DEFAULT and TSO at will.
- On a CPU where the only memory model is at least as strict as TSO,
  PR_GET_MEM_MODEL will return PR_SET_MEM_MODEL_DEFAULT, and
  PR_SET_MEM_MODEL(PR_SET_MEM_MODEL_TSO) will return success but leave
  the memory model at PR_SET_MEM_MODEL_DEFAULT. This implies that the
  default is in fact at least as strict as TSO.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 include/linux/memory_ordering_model.h | 11 +++++++++++
 include/uapi/linux/prctl.h            |  5 +++++
 kernel/sys.c                          | 21 +++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/linux/memory_ordering_model.h b/include/linux/memory_ordering_model.h
new file mode 100644
index 000000000000..267a12ca6630
--- /dev/null
+++ b/include/linux/memory_ordering_model.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_MEMORY_ORDERING_MODEL_H
+#define __ASM_MEMORY_ORDERING_MODEL_H
+
+/* Arch hooks to implement the PR_{GET_SET}_MEM_MODEL prctls */
+
+struct task_struct;
+int arch_prctl_mem_model_get(struct task_struct *t);
+int arch_prctl_mem_model_set(struct task_struct *t, unsigned long val);
+
+#endif
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 370ed14b1ae0..961216093f11 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -306,4 +306,9 @@ struct prctl_mm_map {
 # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xc
 # define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
 
+#define PR_GET_MEM_MODEL	0x6d4d444c
+#define PR_SET_MEM_MODEL	0x4d4d444c
+# define PR_SET_MEM_MODEL_DEFAULT	0
+# define PR_SET_MEM_MODEL_TSO		1
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index f8e543f1e38a..6af659a9f826 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -45,6 +45,7 @@
 #include <linux/version.h>
 #include <linux/ctype.h>
 #include <linux/syscall_user_dispatch.h>
+#include <linux/memory_ordering_model.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
@@ -2442,6 +2443,16 @@ static int prctl_get_auxv(void __user *addr, unsigned long len)
 	return sizeof(mm->saved_auxv);
 }
 
+int __weak arch_prctl_mem_model_get(struct task_struct *t)
+{
+	return -EINVAL;
+}
+
+int __weak arch_prctl_mem_model_set(struct task_struct *t, unsigned long val)
+{
+	return -EINVAL;
+}
+
 SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		unsigned long, arg4, unsigned long, arg5)
 {
@@ -2757,6 +2768,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_RISCV_V_GET_CONTROL:
 		error = RISCV_V_GET_CONTROL();
 		break;
+	case PR_GET_MEM_MODEL:
+		if (arg2 || arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_prctl_mem_model_get(me);
+		break;
+	case PR_SET_MEM_MODEL:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_prctl_mem_model_set(me, arg2);
+		break;
 	default:
 		error = -EINVAL;
 		break;

-- 
2.44.0


