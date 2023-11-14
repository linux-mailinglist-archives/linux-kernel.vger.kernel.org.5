Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811537EB73C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbjKNUGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjKNUG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:06:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0534F1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 12:06:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A1EC433CA;
        Tue, 14 Nov 2023 20:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699992383;
        bh=lxd13UVpNwg8UFzzUvQutHFWJR+9mMSrYBkm92AXfbg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=dAMoMn4nNDlizf2/5z9VG8WyGtBPtE6lm9Abat7J8MCuT7mYLcNqy+5PWwFXhN3Cn
         ahAQfAKNrKm5TsjIWPt3gYWO45IuogBzP7Ym4g9AIOz6V7OOvgAaBf5o1eCdmp32zs
         EWhnikRE5T3P4zZmSzb+Swd91p4M6EJUH4oX4gHKfDmo9eo6fmX4tCPW4To3c5p1WN
         EOyWpwDOQt+8dMYMaP2VxYSlGvGUk/PUc/2Ojup99XCsww/AP8uCSMT//OFXnw19xm
         AFByJVckql0Abr2C86rW5OBvrMEmnMCxmymjLXFJe6JXc0XPf02LhD8NVmoi1IlWmO
         Q+fgsK5R52yIQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 14 Nov 2023 20:05:54 +0000
Subject: [PATCH RFC RFT v2 1/5] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-clone3-shadow-stack-v2-1-b613f8681155@kernel.org>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
In-Reply-To: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
To:     "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>, jannh@google.com,
        bsegall@google.com, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        David Hildenbrand <david@redhat.com>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2302; i=broonie@kernel.org;
 h=from:subject:message-id; bh=lxd13UVpNwg8UFzzUvQutHFWJR+9mMSrYBkm92AXfbg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU9MtYr4nXcSuu//z+nY9j0Y0mgC9AkOYwlDq5caW
 zt8MhVuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVPTLQAKCRAk1otyXVSH0Aj8B/
 9la80H2PcjfOgN4C5wr529/loi/SZ84kdt4QTtOSvLd0X53U2CTQjQ4ZMpe8YL0gDJUIH5ccPxGSpW
 15Vih60XT79JDpTwH4t2ba0uaUbllDr7eKm6xpS54oW1PTQA+/p7MhJPk27S0A3c6kNfbgFkwEjG14
 8+Ol0aF8Dq11mH5Tbe9FuAEC5oyoW7sFz/XCZRFBLMI1AXqiHhVRGRaFHb7o02dLvclx1djz0/1N+1
 u5QI35aEncQdw1Uly9SYNODV3yxxabFLuM2K76XGfELwUs3Jtjcv0Nmpp5yPj+bKihx/ppD6C0ElIr
 cCjUSwb35ozMMV089NLdvJA5S0iap3
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since multiple architectures have support for shadow stacks and we need to
select support for this feature in several places in the generic code
provide a generic config option that the architectures can select.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/x86/Kconfig   | 1 +
 fs/proc/task_mmu.c | 2 +-
 include/linux/mm.h | 2 +-
 mm/Kconfig         | 6 ++++++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3762f41bb092..14b7703a9a2b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1952,6 +1952,7 @@ config X86_USER_SHADOW_STACK
 	depends on AS_WRUSS
 	depends on X86_64
 	select ARCH_USES_HIGH_VMA_FLAGS
+	select ARCH_HAS_USER_SHADOW_STACK
 	select X86_CET
 	help
 	  Shadow stack protection is a hardware feature that detects function
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ef2eb12906da..f0a904aeee8e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -699,7 +699,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 		[ilog2(VM_UFFD_MINOR)]	= "ui",
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
-#ifdef CONFIG_X86_USER_SHADOW_STACK
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
 		[ilog2(VM_SHADOW_STACK)] = "ss",
 #endif
 	};
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 418d26608ece..10462f354614 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -341,7 +341,7 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
-#ifdef CONFIG_X86_USER_SHADOW_STACK
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
 /*
  * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
  * support core mm.
diff --git a/mm/Kconfig b/mm/Kconfig
index 89971a894b60..b8638da636e1 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1270,6 +1270,12 @@ config LOCK_MM_AND_FIND_VMA
 	bool
 	depends on !STACK_GROWSUP
 
+config ARCH_HAS_USER_SHADOW_STACK
+	bool
+	help
+	  The architecture has hardware support for userspace shadow call
+          stacks (eg, x86 CET, arm64 GCS, RISC-V Zisslpcfi).
+
 source "mm/damon/Kconfig"
 
 endmenu

-- 
2.30.2

