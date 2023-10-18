Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A178B7CDA13
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjJRLNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjJRLNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:13:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A89114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:13:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 047A81FD71;
        Wed, 18 Oct 2023 11:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697627608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AxqPCsVu93zMNlESL0N42GEheOSU7BHbH8/1jpPYl4o=;
        b=HDYzBKjuHW1BbT8KulHbZ4NzqLYCB12U4vKthmGMAi/oYagpeOPykJjM21yUVbm8QFrv4R
        QTlsQmwbDDHJ4lXe7v3VUW0Xgoxb4CBrOa2Z8oMVldrMMvot59pJmdk4+UK/zV8gNPL+Z+
        h8E+CO8OZg9hG9Fr0ZwZ2ORJ8yxcO1E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD3BD13915;
        Wed, 18 Oct 2023 11:13:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HnMLNNe9L2VLZwAAMHmgww
        (envelope-from <aporta@suse.de>); Wed, 18 Oct 2023 11:13:27 +0000
From:   Andrea della Porta <andrea.porta@suse.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nik.borisov@suse.com, Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH 2/4] arm64/process: Make loading of 32bit processes depend on aarch32_enabled()
Date:   Wed, 18 Oct 2023 13:13:20 +0200
Message-ID: <a40565807874c9ca82d60c118225ee65fe668fcd.1697614386.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697614386.git.andrea.porta@suse.com>
References: <cover.1697614386.git.andrea.porta@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -4.17
X-Spamd-Result: default: False [-4.17 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-1.47)[91.46%];
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

Major aspect of Aarch32 emulation is the ability to load 32bit
processes.
That's currently decided (among others) by compat_elf_check_arch().

Make the macro use aarch32_enabled() to decide if Aarch32 compat is
enabled before loading a 32bit process.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm64/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 657ea273c0f9..96832f1ec3ee 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -601,7 +601,7 @@ unsigned long arch_align_stack(unsigned long sp)
 #ifdef CONFIG_COMPAT
 int compat_elf_check_arch(const struct elf32_hdr *hdr)
 {
-	if (!system_supports_32bit_el0())
+	if (!system_supports_32bit_el0() || !aarch32_enabled())
 		return false;
 
 	if ((hdr)->e_machine != EM_ARM)
-- 
2.35.3

