Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601B5792BBD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243287AbjIEQ6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350915AbjIEFFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 01:05:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00656CC5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 22:05:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68ACE61337
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496F3C433D9;
        Tue,  5 Sep 2023 05:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693890308;
        bh=Z5cFb/PG3XBG7sxm5WtAR9w0XWnaL/PfZDokR8Evq3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYc4CIP5Ps9zjmAgsSFmUA4HGBKo1EAUyafEYK7hgibrrBXdjxGjVVdV0mV9SNRqG
         KhGIWawtqy9wi+P4fOK8MAGAR4tkNcjbGBsWjemyqVZT3rzi94g6oBkBPtQr+cR3GA
         dtX5x3p+Z9mUQgkdTpu78J5Jd6tMstDNtrVridl0mVOxyH0eYzL3PPY3NigbNMbgOf
         QYExAqADDgelqqf+bKpKH5QQZaoKtQoT59RiLrfjHKg0GYJ0NgWSQ47K4A+qSUL6pu
         AaypwTaERtQvZAwk4yJBsjfvC5WXAmGP221Bnl7aNFqWXVV0gmczO9zUTSB9z3Nkx1
         ppaTc1eTE+ktA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 03/20] x86/srso: Don't probe microcode in a guest
Date:   Mon,  4 Sep 2023 22:04:47 -0700
Message-ID: <3938a7209606c045a3f50305d201d840e8c834c7.1693889988.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693889988.git.jpoimboe@kernel.org>
References: <cover.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support live migration, the hypervisor sets the "lowest common
denominator" of features.  Probing the microcode isn't allowed because
any detected features might go away after a migration.

As Andy Cooper states:

  "Linux must not probe microcode when virtualised.  What it may see
  instantaneously on boot (owing to MSR_PRED_CMD being fully passed
  through) is not accurate for the lifetime of the VM."

Rely on the hypervisor to set the needed IBPB_BRTYPE and SBPB bits.

Fixes: 1b5277c0ea0b ("x86/srso: Add SRSO_NO support")
Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/kernel/cpu/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index b08af929135d..28e77c5d6484 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -767,7 +767,7 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_TOPOEXT))
 		smp_num_siblings = ((cpuid_ebx(0x8000001e) >> 8) & 0xff) + 1;
 
-	if (!cpu_has(c, X86_FEATURE_IBPB_BRTYPE)) {
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) && !cpu_has(c, X86_FEATURE_IBPB_BRTYPE)) {
 		if (c->x86 == 0x17 && boot_cpu_has(X86_FEATURE_AMD_IBPB))
 			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
 		else if (c->x86 >= 0x19 && !wrmsrl_safe(MSR_IA32_PRED_CMD, PRED_CMD_SBPB)) {
-- 
2.41.0

