Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB467D39F1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbjJWOoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjJWOnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:43:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7CA1FD3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:42:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9011B2188F;
        Mon, 23 Oct 2023 14:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698072146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ptLMqv6iaACOOpI3/GceNmmJmtBYsEsFiVZhrERtJcU=;
        b=HpFvhsGRqrkWuoKHGLQpCHaNEeX0hCZU8Ns5O630i2hGaSX8F5c1wRpCrav8t6nLksfcoJ
        6UwowYxJJBXRuTNz7bgCFJuvAzm8bfwtOP5kEueXj2qutCxLwiu8lLt+JXWoyQv5JNT7nd
        +UVGsPwwPFbHAXjdujBBcGqmrw6XfvY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73BD2139C2;
        Mon, 23 Oct 2023 14:42:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WPj+GVKGNmXBdgAAMHmgww
        (envelope-from <aporta@suse.de>); Mon, 23 Oct 2023 14:42:26 +0000
From:   Andrea della Porta <andrea.porta@suse.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nik.borisov@suse.com, arnd@arndb.de, mark.rutland@arm.com,
        Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 2/4] arm64/process: Make loading of 32bit processes depend on aarch32_enabled()
Date:   Mon, 23 Oct 2023 16:42:21 +0200
Message-ID: <2d105c9d8184686fe5aadf646bea7f46ec68ff8b.1698069331.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1698069331.git.andrea.porta@suse.com>
References: <cover.1698069331.git.andrea.porta@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.70
X-Spamd-Result: default: False [-2.70 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
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

Major aspect of Aarch32 support is the ability to load 32bit
processes.
That's currently decided (among others) by compat_elf_check_arch()
and system_supports_32bit_el0().

Make the macro use aarch32_enabled() to decide if Aarch32 compat is
enabled before loading a 32bit process.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm64/include/asm/cpufeature.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 1180d68daaff..778f2f3b2c7d 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -679,8 +679,9 @@ static inline bool system_supports_32bit_el0(void)
 {
 	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
 
-	return static_branch_unlikely(&arm64_mismatched_32bit_el0) ||
-	       id_aa64pfr0_32bit_el0(pfr0);
+	return (static_branch_unlikely(&arm64_mismatched_32bit_el0) ||
+		id_aa64pfr0_32bit_el0(pfr0)) &&
+		aarch32_enabled();
 }
 
 static inline bool system_supports_4kb_granule(void)
-- 
2.35.3

