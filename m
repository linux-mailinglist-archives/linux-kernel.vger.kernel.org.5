Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D14678DB8E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbjH3Sjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242383AbjH3IUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:20:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5790E113;
        Wed, 30 Aug 2023 01:20:41 -0700 (PDT)
Date:   Wed, 30 Aug 2023 08:20:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693383640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LgpB6lUy9BBrNA13ykHRK7OS54efrRlg6fHBFykZhA=;
        b=NiZYEZMD1KZun+Q2GuG3pIZL9sVLKbmxif2PcdN4iw5sbrAweBh32DWgVGKeo3Se2ludjE
        D8UAf1CVRRtFfxqgCsJetG3n3Sa6OUMlxBWtrZGyb6g7/h83l4B+VQQAFuBXNbKpnfQMpP
        UknmKUz7h5esQhI2CXtdDbsFIfoD2H/dLSuZTdePUUIGCqZDz5Xiak+z4177irYdo8lDXG
        qcPTUIiWQEu7ERZrgz6kiKVmAfBtEc2OOpbllt/D1g8MACDSwe0Zze8xORML1PlCnLxcHM
        m4F0c1k43MM1Py53IG1hXxPj1dvALlvNZFYTrD9toUrTyg1jQ2Sc3mIqsaAyog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693383640;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1LgpB6lUy9BBrNA13ykHRK7OS54efrRlg6fHBFykZhA=;
        b=70fYGegJyfZrxco/lHJbxV2Aj66jlbD+ko2dK1odHK+08/ChMEyWcw06EVYCOt2AicDBcM
        NoOf2ZgP3cCVcvAQ==
From:   "tip-bot2 for Justin Stitt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/audit: Fix -Wmissing-variable-declarations
 warning for ia32_xyz_class
Cc:     Justin Stitt <justinstitt@google.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230829-missingvardecl-audit-v1-1-34efeb7f3539@google.com>
References: <20230829-missingvardecl-audit-v1-1-34efeb7f3539@google.com>
MIME-Version: 1.0
Message-ID: <169338363913.27769.13139550857281132494.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e8f13e061d75ed0eeaaf599532a6b197f195d5f3
Gitweb:        https://git.kernel.org/tip/e8f13e061d75ed0eeaaf599532a6b197f195d5f3
Author:        Justin Stitt <justinstitt@google.com>
AuthorDate:    Tue, 29 Aug 2023 22:33:16 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 30 Aug 2023 10:11:16 +02:00

x86/audit: Fix -Wmissing-variable-declarations warning for ia32_xyz_class

When building x86 defconfig with Clang-18 I get the following warnings:

  | arch/x86/ia32/audit.c:6:10: warning: no previous extern declaration for non-static variable 'ia32_dir_class' [-Wmissing-variable-declarations]
  |     6 | unsigned ia32_dir_class[] = {
  | arch/x86/ia32/audit.c:11:10: warning: no previous extern declaration for non-static variable 'ia32_chattr_class' [-Wmissing-variable-declarations]
  |    11 | unsigned ia32_chattr_class[] = {
  | arch/x86/ia32/audit.c:16:10: warning: no previous extern declaration for non-static variable 'ia32_write_class' [-Wmissing-variable-declarations]
  |    16 | unsigned ia32_write_class[] = {
  | arch/x86/ia32/audit.c:21:10: warning: no previous extern declaration for non-static variable 'ia32_read_class' [-Wmissing-variable-declarations]
  |    21 | unsigned ia32_read_class[] = {
  | arch/x86/ia32/audit.c:26:10: warning: no previous extern declaration for non-static variable 'ia32_signal_class' [-Wmissing-variable-declarations]
  |    26 | unsigned ia32_signal_class[] = {

These warnings occur due to their respective extern declarations being
scoped inside of audit_classes_init as well as only being enabled with
`CONFIG_IA32_EMULATION=y`:

  | static int __init audit_classes_init(void)
  | {
  | #ifdef CONFIG_IA32_EMULATION
  |	extern __u32 ia32_dir_class[];
  |	extern __u32 ia32_write_class[];
  |	extern __u32 ia32_read_class[];
  |	extern __u32 ia32_chattr_class[];
  |	audit_register_class(AUDIT_CLASS_WRITE_32, ia32_write_class);
  |	audit_register_class(AUDIT_CLASS_READ_32, ia32_read_class);
  |	audit_register_class(AUDIT_CLASS_DIR_WRITE_32, ia32_dir_class);
  |	audit_register_class(AUDIT_CLASS_CHATTR_32, ia32_chattr_class);
  | #endif
  |	audit_register_class(AUDIT_CLASS_WRITE, write_class);
  |	audit_register_class(AUDIT_CLASS_READ, read_class);
  |	audit_register_class(AUDIT_CLASS_DIR_WRITE, dir_class);
  |	audit_register_class(AUDIT_CLASS_CHATTR, chattr_class);
  |	return 0;
  | }

Lift the extern declarations to their own header and resolve scoping
issues (and thus fix the warnings).

Moreover, change __u32 to unsigned so that we match the definitions:

  | unsigned ia32_dir_class[] = {
  | #include <asm-generic/audit_dir_write.h>
  | ~0U
  | };
  |
  | unsigned ia32_chattr_class[] = {
  | #include <asm-generic/audit_change_attr.h>
  | ~0U
  | };
  | ...

This patch is similar to commit:

  0e5e3d4461a22d73 ("x86/audit: Fix a -Wmissing-prototypes warning for ia32_classify_syscall()") [1]

Signed-off-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/all/20200516123816.2680-1-b.thiel@posteo.de/ [1]
Link: https://github.com/ClangBuiltLinux/linux/issues/1920
Link: https://lore.kernel.org/r/20230829-missingvardecl-audit-v1-1-34efeb7f3539@google.com
---
 arch/x86/include/asm/audit.h | 7 +++++++
 arch/x86/kernel/audit_64.c   | 5 -----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/audit.h b/arch/x86/include/asm/audit.h
index 36aec57..fa918f0 100644
--- a/arch/x86/include/asm/audit.h
+++ b/arch/x86/include/asm/audit.h
@@ -4,4 +4,11 @@
 
 int ia32_classify_syscall(unsigned int syscall);
 
+extern unsigned ia32_dir_class[];
+extern unsigned ia32_write_class[];
+extern unsigned ia32_read_class[];
+extern unsigned ia32_chattr_class[];
+extern unsigned ia32_signal_class[];
+
+
 #endif /* _ASM_X86_AUDIT_H */
diff --git a/arch/x86/kernel/audit_64.c b/arch/x86/kernel/audit_64.c
index 44c3601..190c120 100644
--- a/arch/x86/kernel/audit_64.c
+++ b/arch/x86/kernel/audit_64.c
@@ -63,11 +63,6 @@ int audit_classify_syscall(int abi, unsigned syscall)
 static int __init audit_classes_init(void)
 {
 #ifdef CONFIG_IA32_EMULATION
-	extern __u32 ia32_dir_class[];
-	extern __u32 ia32_write_class[];
-	extern __u32 ia32_read_class[];
-	extern __u32 ia32_chattr_class[];
-	extern __u32 ia32_signal_class[];
 	audit_register_class(AUDIT_CLASS_WRITE_32, ia32_write_class);
 	audit_register_class(AUDIT_CLASS_READ_32, ia32_read_class);
 	audit_register_class(AUDIT_CLASS_DIR_WRITE_32, ia32_dir_class);
