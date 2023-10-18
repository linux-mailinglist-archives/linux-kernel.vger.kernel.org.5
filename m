Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE7F7CDA0F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjJRLNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjJRLNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:13:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA7B113
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:13:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D4091FD6F;
        Wed, 18 Oct 2023 11:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697627607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XvayeaWIBXD/TbklYtBLy+ocs1W3g7QMUZRRnl/IW6A=;
        b=tvXVPT2fU8cdIZZ5PVqS+oONkUT5BgOIQTKI20cJHtwHddG4iR+Kjusrp0rp1UhtbxexS4
        8yIbj5D1MvC0cbiKXos0K/UDGct4TTomnt/ox2tBuAOA1mnT6cB/8jVuN1j4mvYRFkuBXd
        N6k5PylA7ETC2CnpkLVGBzYlpV6gbIc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2712E13915;
        Wed, 18 Oct 2023 11:13:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hbmbB9e9L2VHZwAAMHmgww
        (envelope-from <aporta@suse.de>); Wed, 18 Oct 2023 11:13:27 +0000
From:   Andrea della Porta <andrea.porta@suse.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nik.borisov@suse.com, Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH 1/4] arm64: Introduce aarch32_enabled()
Date:   Wed, 18 Oct 2023 13:13:19 +0200
Message-ID: <5621e481f1640782c649c8fb9145310339022540.1697614386.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697614386.git.andrea.porta@suse.com>
References: <cover.1697614386.git.andrea.porta@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
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

Aarch32 bit support on 64bit kernels depends on whether CONFIG_COMPAT
is selected or not. As it is a compile time option it doesn't
provide the flexibility to have distributions set their own policy for
Aarch32 support and give the user the flexibility to override it.

As a first step introduce aarch32_enabled() which abstracts whether 32
bit compat is turned on or off. Upcoming patches will implement
the ability to set Aarch32 compat state at boot time.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm64/include/asm/compat.h  | 12 ++++++++++++
 arch/arm64/kernel/entry-common.c |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index ae904a1ad529..f5ef71bd0024 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -98,6 +98,13 @@ static inline int is_compat_thread(struct thread_info *thread)
 
 long compat_arm_syscall(struct pt_regs *regs, int scno);
 
+extern bool __aarch32_enabled;
+
+static inline bool aarch32_enabled(void)
+{
+	return __aarch32_enabled;
+}
+
 #else /* !CONFIG_COMPAT */
 
 static inline int is_compat_thread(struct thread_info *thread)
@@ -105,5 +112,10 @@ static inline int is_compat_thread(struct thread_info *thread)
 	return 0;
 }
 
+static inline bool aarch32_enabled(void)
+{
+	return false;
+}
+
 #endif /* CONFIG_COMPAT */
 #endif /* __ASM_COMPAT_H */
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

