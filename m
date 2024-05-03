Return-Path: <linux-kernel+bounces-167361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A85F18BA870
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ABF01F2267E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F22914F13D;
	Fri,  3 May 2024 08:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jB5+pj7P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B89149DF6;
	Fri,  3 May 2024 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723950; cv=none; b=TlmK6gZ+fgzhzvm/KA+duMxGRmfL1lWCBkckfQ1C4XQ/+Let939WuHkZXliQZr4YF2WdsX6Nlu2CXLnvWSMBsHy/FpS8bh0MFO8TkB1q/lPeecErhPNG4FawEV2KDtMEVM2vNmF9c96WTyzO3Zef0hpdBPTKkX0GXUXbmR8N6TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723950; c=relaxed/simple;
	bh=9BAn9hUftPS3eYIiTpLzl4khfNyMbi9G7KQSc69tEzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EyzDPNWUnWpAP2w2/LLlCQz8MxLkS6t2OPOzpsyTx6CgzyQVNEwXL5V/vSELZlzvm1kdbHrbdQ4ldFWmUJl2vgtThdnaTJ8I8/VhQhnAyFvOFuh7enR+ujpesP+YtH368RAxWqEuJlx5ZEW3hgajsJv1683o8LIMKYmwg07tzXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jB5+pj7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322FDC116B1;
	Fri,  3 May 2024 08:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714723950;
	bh=9BAn9hUftPS3eYIiTpLzl4khfNyMbi9G7KQSc69tEzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jB5+pj7Pxp2NPdrQlZ6tbBSj2ibqT4eat2lOYfizgPpwpBW4AvNB8vLZvYnAvjmeS
	 bbTtxKQ+A38d8G9q1t/KAN4VuMjpqG7nQ0VBn5boJj2a1U0Tc33fQ2zDFkktwA+t/N
	 8HnRULlDNZmMF3dVk6GO6qNuuGlAxQwMdZR568nwo7ync7zRWblln28/4P7Vo9N8zs
	 gPeP/2EzLvv/KE2mPiKe1Y/T+8PMaxzPNbWbGVRdGuwiTJi1elwPcQYCmRhVODGiNA
	 2OEQRv3OqP87kZPlS37WKaBaiU9NfcroqcKNlcNv/boTzyH8ISZMsgiNFjQvtaxEHJ
	 CFEhhMz7//Ksw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-alpha@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Marc Zyngier <maz@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/14] alpha: trim the unused stuff from asm-offsets.c
Date: Fri,  3 May 2024 10:11:20 +0200
Message-Id: <20240503081125.67990-10-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503081125.67990-1-arnd@kernel.org>
References: <20240503081125.67990-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

Out of 21 constants, only 6 are used...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/kernel/asm-offsets.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/arch/alpha/kernel/asm-offsets.c b/arch/alpha/kernel/asm-offsets.c
index bf1eedd27cf7..4cfeae42c79a 100644
--- a/arch/alpha/kernel/asm-offsets.c
+++ b/arch/alpha/kernel/asm-offsets.c
@@ -10,35 +10,16 @@
 #include <linux/sched.h>
 #include <linux/ptrace.h>
 #include <linux/kbuild.h>
-#include <asm/io.h>
+#include <asm/machvec.h>
 
 static void __used foo(void)
 {
-	DEFINE(TI_TASK, offsetof(struct thread_info, task));
 	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
-	DEFINE(TI_CPU, offsetof(struct thread_info, cpu));
 	DEFINE(TI_FP, offsetof(struct thread_info, fp));
 	DEFINE(TI_STATUS, offsetof(struct thread_info, status));
 	BLANK();
 
-        DEFINE(TASK_BLOCKED, offsetof(struct task_struct, blocked));
-        DEFINE(TASK_CRED, offsetof(struct task_struct, cred));
-        DEFINE(TASK_REAL_PARENT, offsetof(struct task_struct, real_parent));
-        DEFINE(TASK_GROUP_LEADER, offsetof(struct task_struct, group_leader));
-        DEFINE(TASK_TGID, offsetof(struct task_struct, tgid));
-        BLANK();
-
-        DEFINE(CRED_UID,  offsetof(struct cred, uid));
-        DEFINE(CRED_EUID, offsetof(struct cred, euid));
-        DEFINE(CRED_GID,  offsetof(struct cred, gid));
-        DEFINE(CRED_EGID, offsetof(struct cred, egid));
-        BLANK();
-
 	DEFINE(SIZEOF_PT_REGS, sizeof(struct pt_regs));
-	DEFINE(PT_PTRACED, PT_PTRACED);
-	DEFINE(CLONE_VM, CLONE_VM);
-	DEFINE(CLONE_UNTRACED, CLONE_UNTRACED);
-	DEFINE(SIGCHLD, SIGCHLD);
 	BLANK();
 
 	DEFINE(HAE_CACHE, offsetof(struct alpha_machine_vector, hae_cache));
-- 
2.39.2


