Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53527CDA11
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjJRLNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjJRLNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:13:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BDBFE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:13:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 876EC21B46;
        Wed, 18 Oct 2023 11:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697627609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wsR/3Y9czckKmpyD5dpakWYoef+ZcRQqjgka+TQ4G38=;
        b=kzK0A7Ah4wF9K5Iz3ITZDsOAS/SGjho+aaOpko47hOx+NTaRPXP0ZMtcHIMS2FReb2c2bs
        muBtEJKJTv8yMqE5ObWfV8BopGL73hobgywMYfmBZDwLdrINoEQRsDWhPxtwH3cYVxuGRP
        jBjEi4n36kW8I4tscrhT0TtVk/ZZBDA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 694DE13915;
        Wed, 18 Oct 2023 11:13:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EpgfF9m9L2VRZwAAMHmgww
        (envelope-from <aporta@suse.de>); Wed, 18 Oct 2023 11:13:29 +0000
From:   Andrea della Porta <andrea.porta@suse.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nik.borisov@suse.com, Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH 4/4] arm64: Make Aarch32 emulation boot time configurable
Date:   Wed, 18 Oct 2023 13:13:22 +0200
Message-ID: <1029761eb218702d4aafa58d83c4bf9d3a760264.1697614386.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697614386.git.andrea.porta@suse.com>
References: <cover.1697614386.git.andrea.porta@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.70
X-Spamd-Result: default: False [-5.70 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_FIVE(0.00)[6];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FORGED_SENDER(0.30)[andrea.porta@suse.com,aporta@suse.de];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         FROM_NEQ_ENVFROM(0.10)[andrea.porta@suse.com,aporta@suse.de];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Distributions would like to reduce their attack surface as much as
possible but at the same time they'd want to retain flexibility to
cater to a variety of legacy software. This stems from the conjecture
that compat layer is likely rarely tested and could have latent
security bugs. Ideally distributions will set their default policy
and also give users the ability to override it as appropriate.

To enable this use case, introduce CONFIG_AARCH32_EMULATION_DEFAULT_DISABLED
compile time option, which controls whether 32bit processes/syscalls
should be allowed or not. This option is aimed mainly at distributions
to set their preferred default behavior in their kernels.

To allow users to override the distro's policy, introduce the
'aarch32_emulation' parameter which allows overriding
CONFIG_AARCH32_EMULATION_DEFAULT_DISABLED state at boot time.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 arch/arm64/Kconfig                              | 9 +++++++++
 arch/arm64/kernel/entry-common.c                | 8 +++++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0a1731a0f0ef..a41c5e6f5d2e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1,3 +1,10 @@
+	aarch32_emulation=	[ARM64]
+			Format: <bool>
+			When true, allows loading 32-bit programs and executing
+			32-bit syscalls, essentially overriding
+			AARCH32_EMULATION_DEFAULT_DISABLED at boot time. when false,
+			unconditionally disables AARCH32 emulation.
+
 	acpi=		[HW,ACPI,X86,ARM64,RISCV64]
 			Advanced Configuration and Power Interface
 			Format: { force | on | off | strict | noirq | rsdt |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b10515c0200b..66c4cb273550 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1725,6 +1725,15 @@ config SETEND_EMULATION
 	  If unsure, say Y
 endif # ARMV8_DEPRECATED
 
+config AARCH32_EMULATION_DEFAULT_DISABLED
+	bool "Aarch32 emulation disabled by default"
+	default n
+	depends on COMPAT
+	help
+	  Make Aarch32 emulation disabled by default. This prevents loading 32-bit
+	  processes and access to 32-bit syscalls.
+
+	  If unsure, leave it to its default value.
 endif # COMPAT
 
 menu "ARMv8.1 architectural features"
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 32761760d9dd..07f2b4e632b8 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -897,7 +897,13 @@ asmlinkage void noinstr el0t_32_error_handler(struct pt_regs *regs)
 		__el0_error_handler_common(regs);
 }
 
-bool __aarch32_enabled __ro_after_init = true;
+bool __aarch32_enabled __ro_after_init = !IS_ENABLED(CONFIG_AARCH32_EMULATION_DEFAULT_DISABLED);
+
+static int aarch32_emulation_override_cmdline(char *arg)
+{
+	return kstrtobool(arg, &__aarch32_enabled);
+}
+early_param("aarch32_emulation", aarch32_emulation_override_cmdline);
 #else /* CONFIG_COMPAT */
 UNHANDLED(el0t, 32, sync)
 UNHANDLED(el0t, 32, irq)
-- 
2.35.3

