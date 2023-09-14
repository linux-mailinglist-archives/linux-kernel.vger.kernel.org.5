Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238FF7A028B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbjINL1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjINL1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:27:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43321A5;
        Thu, 14 Sep 2023 04:27:04 -0700 (PDT)
Date:   Thu, 14 Sep 2023 11:27:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694690822;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmZehBGumWU33PaAzE7WjuGvYBCGLX0/2JNBi7w45LE=;
        b=ZAzOahBQ+toQEjwcNs6/beWjCTrGxXKA+JdjiQjUb6wUcSj4NuCSsK31d+6MUGua5knDKJ
        jjQoWYd5cTi8l7ALcJ171TLK7PPXl9LuMqxZAX+HhfQ4RleSQ2WNjAR5rPVgN5ffDOnLVj
        h0ip3WgJDikMtbQeMKqy2IReQ1WJ5UwlRo+kI8AhG/FIWnf61VnOrUk/na8mCRhhTZOJnR
        VqiCNkkhp8pgzriXPnjULp8ZDYGKfwZpX3tCg5lKUtKR8KEJZOo5JphZf5dHAS1quPb8Ps
        ZMfwgNew9IBAHmIqwH7hS3qhY9X6mv1R+ufPH1I+r5pLQ0em9Dl4fwMCYVfMUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694690822;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmZehBGumWU33PaAzE7WjuGvYBCGLX0/2JNBi7w45LE=;
        b=8SDh91sBC922LdVauVh5sYMK+Refw68zEwupPACMSePEcw6oqnrqAzSWbazminFdeXmauq
        Xd8WSyE7vThMYsDA==
From:   "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86: Make IA32_EMULATION boot time configurable
Cc:     Nikolay Borisov <nik.borisov@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230623111409.3047467-7-nik.borisov@suse.com>
References: <20230623111409.3047467-7-nik.borisov@suse.com>
MIME-Version: 1.0
Message-ID: <169469082201.27769.12035132996797296127.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     a11e097504ac1889b35b6858f495565838325f88
Gitweb:        https://git.kernel.org/tip/a11e097504ac1889b35b6858f495565838325f88
Author:        Nikolay Borisov <nik.borisov@suse.com>
AuthorDate:    Fri, 23 Jun 2023 14:14:09 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 14 Sep 2023 13:19:53 +02:00

x86: Make IA32_EMULATION boot time configurable

Distributions would like to reduce their attack surface as much as
possible but at the same time they'd want to retain flexibility to cater
to a variety of legacy software. This stems from the conjecture that
compat layer is likely rarely tested and could have latent security
bugs. Ideally distributions will set their default policy and also
give users the ability to override it as appropriate.

To enable this use case, introduce CONFIG_IA32_EMULATION_DEFAULT_DISABLED
compile time option, which controls whether 32bit processes/syscalls
should be allowed or not. This option is aimed mainly at distributions
to set their preferred default behavior in their kernels.

To allow users to override the distro's policy, introduce the 'ia32_emulation'
parameter which allows overriding CONFIG_IA32_EMULATION_DEFAULT_DISABLED
state at boot time.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230623111409.3047467-7-nik.borisov@suse.com

---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 arch/x86/Kconfig                                |  9 +++++++++
 arch/x86/entry/common.c                         |  9 ++++++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a1731a..45e34be 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1893,6 +1893,12 @@
 			 0 -- machine default
 			 1 -- force brightness inversion
 
+	ia32_emulation=	[X86-64]
+			Format: <bool>
+			When true, allows loading 32-bit programs and executing 32-bit
+			syscalls, essentially overriding IA32_EMULATION_DEFAULT_DISABLED at
+			boot time. When false, unconditionally disables IA32 emulation.
+
 	icn=		[HW,ISDN]
 			Format: <io>[,<membase>[,<icn_id>[,<icn_id2>]]]
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 982b777..c130bf3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2954,6 +2954,15 @@ config IA32_EMULATION
 	  64-bit kernel. You should likely turn this on, unless you're
 	  100% sure that you don't have any 32-bit programs left.
 
+config IA32_EMULATION_DEFAULT_DISABLED
+	bool "IA32 emulation disabled by default"
+	default n
+	depends on IA32_EMULATION
+	help
+	  Make IA32 emulation disabled by default. This prevents loading 32-bit
+	  processes and access to 32-bit syscalls. If unsure, leave it to its
+	  default value.
+
 config X86_X32_ABI
 	bool "x32 ABI for 64-bit mode"
 	depends on X86_64
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index cfbd3ae..a34e1a1 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -19,6 +19,7 @@
 #include <linux/nospec.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
+#include <linux/init.h>
 
 #ifdef CONFIG_XEN_PV
 #include <xen/xen-ops.h>
@@ -97,7 +98,13 @@ static __always_inline int syscall_32_enter(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_IA32_EMULATION
-bool __ia32_enabled __ro_after_init = true;
+bool __ia32_enabled __ro_after_init = !IS_ENABLED(CONFIG_IA32_EMULATION_DEFAULT_DISABLED);
+
+static int ia32_emulation_override_cmdline(char *arg)
+{
+	return kstrtobool(arg, &__ia32_enabled);
+}
+early_param("ia32_emulation", ia32_emulation_override_cmdline);
 #endif
 
 /*
