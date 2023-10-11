Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C6E7C6080
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 00:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376579AbjJKWoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 18:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376578AbjJKWoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 18:44:02 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6848A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:43:58 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-66d0ceba445so2079146d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 15:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697064237; x=1697669037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/e/e5drqChWwuXG6soyxRsu9kSizf72f1McaizEqmY=;
        b=KfG+5kXFwbi8s9e9C9i0A+an/sTrACwJmvaBTGPuzmgCRThBHRdKqutY6cFPvfzVKt
         W2XXslbtzICFNBiY3WwknRYczssYoechEXEDlVgUNazZi5/EYY8yuB+GmyEy6hKd901+
         AL93sIQki1iHyh5WhdecSppakjsHlA806b3PE5WvRVi4bFfP1yuwqlPcmME02kgZU97h
         rG6/WcTmP86s+ETvl2ddh66tXCSSm89NQFyR+KMHmfSToP81Gp3eWpZGIZ30yTyET+07
         zKYuPuluhWl5dhpd4olFLl5+ROmVX/9mHPzXNlFDdku5Uhs2F56xYaILGe7sP8ZRCpJR
         bq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697064237; x=1697669037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/e/e5drqChWwuXG6soyxRsu9kSizf72f1McaizEqmY=;
        b=Yy/xSnYX1SwyR/prMfy/P6xchiq0TjAbzArGEP5MzyPRoL2li/NzkBsvfoj/hELF32
         4tvHdSn7YjvV74N2VPy5MKkGKy3JcE8pTOes2uvvVCFxCS9ZF7z/XENnQMqzVyi5RSlh
         tcP6wSWwxLQu2dQF0/dv6Ivhve/oCoGEOCU+/yPsfX4H4tCu5u7Aj3MvW+ob/TeYUOO1
         byM6b4EMdTTAwbJTX+90WKVxCfsOZWR9ABBzDHDVz2UY3ilb3LCv04nyBacWv5iSCGJh
         0fWI4lmJXA/qRGzxYM5v9G+P4hZH3qW/F2gu/CqFaU6HdU4Wv8+baLUGGthO/W2e6yy9
         Lvvg==
X-Gm-Message-State: AOJu0YyKRRXEmHeSrQPDrtqIliwsNc08BNZG2wyAmJ6Kf1EKbwVPhkgz
        Ti8QjjadDyHWMnMtHRGma8ogOcMzDQ==
X-Google-Smtp-Source: AGHT+IFrc4I5n58/NTdAASVqcxX266gphMt+GTGmOWfYfo5XhT+GjQADGrhfsGOVzMNmmBw/eD88ew==
X-Received: by 2002:a0c:efd4:0:b0:65c:ffb6:11ea with SMTP id a20-20020a0cefd4000000b0065cffb611eamr21865019qvt.33.1697064237533;
        Wed, 11 Oct 2023 15:43:57 -0700 (PDT)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id o10-20020a0cf4ca000000b0065b129ec0e8sm6132871qvm.57.2023.10.11.15.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 15:43:57 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v3 3/3] x86/entry/32: Clean up syscall fast exit tests
Date:   Wed, 11 Oct 2023 18:43:51 -0400
Message-ID: <20231011224351.130935-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011224351.130935-1-brgerst@gmail.com>
References: <20231011224351.130935-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge compat and native code and clarify comments.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/common.c | 48 +++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index e3d6f255379f..0acf35d7fe55 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -255,34 +255,30 @@ __visible noinstr bool do_fast_syscall_32(struct pt_regs *regs)
 	if (!__do_fast_syscall_32(regs))
 		return false;
 
-#ifdef CONFIG_X86_64
 	/*
-	 * Opportunistic SYSRETL: if possible, try to return using SYSRETL.
-	 * SYSRETL is available on all 64-bit CPUs, so we don't need to
-	 * bother with SYSEXIT.
-	 *
-	 * Unlike 64-bit opportunistic SYSRET, we can't check that CX == IP,
-	 * because the ECX fixup above will ensure that this is essentially
-	 * never the case.
+	 * Check that the register state is valid for using SYSRETL/SYSEXIT
+	 * to exit to userspace.  Otherwise use the slower but fully capable
+	 * IRET exit path.
 	 */
-	return regs->cs == __USER32_CS && regs->ss == __USER_DS &&
-		regs->ip == landing_pad &&
-		(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF)) == 0;
-#else
-	/*
-	 * Opportunistic SYSEXIT: if possible, try to return using SYSEXIT.
-	 *
-	 * Unlike 64-bit opportunistic SYSRET, we can't check that CX == IP,
-	 * because the ECX fixup above will ensure that this is essentially
-	 * never the case.
-	 *
-	 * We don't allow syscalls at all from VM86 mode, but we still
-	 * need to check VM, because we might be returning from sys_vm86.
-	 */
-	return regs->cs == __USER_CS && regs->ss == __USER_DS &&
-		regs->ip == landing_pad &&
-		(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF | X86_EFLAGS_VM)) == 0;
-#endif
+
+	/* XEN PV guests always use IRET path */
+	if (cpu_feature_enabled(X86_FEATURE_XENPV))
+		return false;
+
+	/* EIP must point to the VDSO landing pad */
+	if (unlikely(regs->ip != landing_pad))
+		return false;
+
+	/* CS and SS must match the values set in MSR_STAR */
+	if (unlikely(regs->cs != __USER32_CS || regs->ss != __USER_DS))
+		return false;
+
+	/* If the TF, RF, or VM flags are set, use IRET */
+	if (unlikely(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF | X86_EFLAGS_VM)))
+		return false;
+
+	/* Use SYSRETL/SYSEXIT to exit to userspace */
+	return true;
 }
 
 /* Returns true to return using SYSEXIT/SYSRETL, or false to use IRET */
-- 
2.41.0

