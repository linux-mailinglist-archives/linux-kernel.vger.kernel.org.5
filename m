Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1747FF3FB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346418AbjK3PwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjK3PwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:52:22 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87347C1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:52:28 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D187D40E025A;
        Thu, 30 Nov 2023 15:52:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id roX7NmhyTv2K; Thu, 30 Nov 2023 15:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701359544; bh=6WfUnJiXA2QiPh24Z3FXnc7gIpfIQPu99AkmUbKS270=;
        h=From:To:Cc:Subject:Date:From;
        b=G6+Y9s9nJtOCY9G7xvc7cKGe4PFI1YTxq46AEbvLIkP8BvJrAVZtNsWHQ41BMMZxf
         dZkLwmIF6M/3tIF1//aivo8WAArNk0hACsKlLjHYmLdyjRFXYaQVg7HjyOPxfMXrhV
         It+NReVcYdleX3//2KKcEx0qvJGb0fiQI88evyidwcp+9+4ThiylmvJJmdfC6qbQ3K
         JE0XjvWAwaHKD9igoGwHIHQSvkhXUHwnbyKUFTn9+nPxhanFdANYaL0E/oBG2zrTmo
         EINGzrtaMF8WPfhJ+h2MpS2u/Kp8FPO48x1jJ/w+1oPHJ50WNwOGnTTaKDzrvPWWdH
         2I9TLcxxyKxMvul8o58dFfK5wSL9EAg5xKrwhEzx5JKYEpwPT/0Or0dZwxQz74Virs
         Yh7XKJkU+aJHp298GuBHpxFvovqmXIUATe/qEhWUMpoHMkd3dg2hjZ1Yvk2EXTrKqH
         nL7oHMbbw82CQPkrN35/9bY62lICP58ZbEE0XxV8v5lEeZg+ZFo8wWxEZYZkPi6FLc
         O0l+qN97IgFnAYDOBKDHvHN1GSuxckIyw1R8Y4KoBy210ORfiY4ES8bFTSrMDEkXja
         tVnQKBcBVoNC2vCroToX2E3vjGnhhWgtUfvXwsFCQ739fY07geYrUtjbI1+u6jPQbM
         aKttNBD1GrzY2ptjYd3tKFwM=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F13D540E0239;
        Thu, 30 Nov 2023 15:52:20 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH] x86/ia32: State that IA32 emulation is disabled
Date:   Thu, 30 Nov 2023 16:52:13 +0100
Message-ID: <20231130155213.1407-1-bp@alien8.de>
X-Mailer: git-send-email 2.42.0.rc0.25.ga82fb66fed25
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Issue a short message once, on the first try to load a 32-bit process to
save people time when wondering why it won't load and says:

  -bash: ./strsep32: cannot execute binary file: Exec format error

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/include/asm/elf.h  | 2 +-
 arch/x86/include/asm/ia32.h | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index a0234dfd1031..1e16bd5ac781 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -150,7 +150,7 @@ do {						\
 	((x)->e_machine =3D=3D EM_X86_64)
=20
 #define compat_elf_check_arch(x)					\
-	((elf_check_arch_ia32(x) && ia32_enabled()) ||			\
+	((elf_check_arch_ia32(x) && ia32_enabled_verbose()) ||		\
 	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine =3D=3D EM_X86_64))
=20
 static inline void elf_common_init(struct thread_struct *t,
diff --git a/arch/x86/include/asm/ia32.h b/arch/x86/include/asm/ia32.h
index 5a2ae24b1204..43e02b52ad19 100644
--- a/arch/x86/include/asm/ia32.h
+++ b/arch/x86/include/asm/ia32.h
@@ -2,7 +2,6 @@
 #ifndef _ASM_X86_IA32_H
 #define _ASM_X86_IA32_H
=20
-
 #ifdef CONFIG_IA32_EMULATION
=20
 #include <linux/compat.h>
@@ -84,4 +83,12 @@ static inline bool ia32_enabled(void)
=20
 #endif
=20
+static inline bool ia32_enabled_verbose(void)
+{
+#ifdef CONFIG_IA32_EMULATION
+	pr_notice_once("32-bit emulation disabled. You can reenable with ia32_e=
mulation=3Don\n");
+#endif
+	return ia32_enabled();
+}
+
 #endif /* _ASM_X86_IA32_H */
--=20
2.42.0.rc0.25.ga82fb66fed25

