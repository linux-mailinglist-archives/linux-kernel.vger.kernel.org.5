Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376737D39EF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjJWOoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjJWOnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:43:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C7C1FC6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:42:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CEC842188E;
        Mon, 23 Oct 2023 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698072145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IgkfPdLL0JOTUwZlB8Z82NlYikR+ETv1lCssxJ5dRNw=;
        b=T4ANELya+7eZzKSrlrTqXHdbhHz9Q7GsrHbdikW7vFTLnq1CfFy0SF0z+7K2F8+Mpp9kG7
        Kl73rR2m2g0NHJ+8Oq4BsDeZEZaXxTmmNXSo0+LiD20kd7xG30J2N1jEHs8EEdje2G9C91
        LjNnETkVoyhH+3EPXwA8YMGp32MN7Vk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B673F139C2;
        Mon, 23 Oct 2023 14:42:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GMlnK1GGNmW9dgAAMHmgww
        (envelope-from <aporta@suse.de>); Mon, 23 Oct 2023 14:42:25 +0000
From:   Andrea della Porta <andrea.porta@suse.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nik.borisov@suse.com, arnd@arndb.de, mark.rutland@arm.com,
        Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 1/4] arm64: Introduce aarch32_enabled()
Date:   Mon, 23 Oct 2023 16:42:20 +0200
Message-ID: <1dec05cc8f54d0b85acffce69d929f13e6d81313.1698069331.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1698069331.git.andrea.porta@suse.com>
References: <cover.1698069331.git.andrea.porta@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -3.72
X-Spamd-Result: default: False [-3.72 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-1.02)[87.38%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         REPLY(-4.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[8];
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

Aarch32 bit support on 64bit kernels depends on whether CONFIG_COMPAT
is selected or not. As it is a compile time option it doesn't
provide the flexibility to have distributions set their own policy for
Aarch32 support and give the user the flexibility to override it.

As a first step introduce aarch32_enabled() which abstracts whether 32
bit compat is turned on or off. Upcoming patches will implement
the ability to set Aarch32 compat state at boot time.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm64/include/asm/cpufeature.h | 15 +++++++++++++++
 arch/arm64/kernel/entry-common.c    |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 396af9b9c857..1180d68daaff 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -657,6 +657,21 @@ static inline bool supports_clearbhb(int scope)
 						    ID_AA64ISAR2_EL1_CLRBHB_SHIFT);
 }
 
+#ifdef CONFIG_COMPAT
+extern bool __aarch32_enabled;
+
+static inline bool aarch32_enabled(void)
+{
+	return __aarch32_enabled;
+}
+#else /* !CONFIG_COMPAT */
+
+static inline bool aarch32_enabled(void)
+{
+	return false;
+}
+#endif
+
 const struct cpumask *system_32bit_el0_cpumask(void);
 DECLARE_STATIC_KEY_FALSE(arm64_mismatched_32bit_el0);
 
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 0fc94207e69a..69ff9b8c0bde 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -877,6 +877,8 @@ asmlinkage void noinstr el0t_32_error_handler(struct pt_regs *regs)
 {
 	__el0_error_handler_common(regs);
 }
+
+bool __aarch32_enabled __ro_after_init = true;
 #else /* CONFIG_COMPAT */
 UNHANDLED(el0t, 32, sync)
 UNHANDLED(el0t, 32, irq)
-- 
2.35.3

