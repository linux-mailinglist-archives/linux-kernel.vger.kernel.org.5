Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A817FD57D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjK2LWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjK2LWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:22:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD57E10C2;
        Wed, 29 Nov 2023 03:22:29 -0800 (PST)
Date:   Wed, 29 Nov 2023 11:22:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701256947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ltF6Izhg7GomhCmi/G40+Jhpg0cJILQoZKUjj7bMbO4=;
        b=nNSQnhaKz3OKB/OEol4ntx5kTJDRpIU7i6Pr9EISzkfjf69kSgol7r8p0l+j9tAgXBFet2
        Cf4lVt1n/dn4nGGA+CBfEjjZqlxAzh5+lOG5GHsF7wevL4Qg8UKmsWPZwJUe/Qwzs2pQ9N
        07/g0flb85A/mg5O9lDgCoTf0Lo4GO5+IaTt5vk8lSrNdR7uF+9vSpJLHh9s3/pCwps7qY
        ibCopbt+8aMjA0s8oljEa84KTexqxzuwLvTC0x2JMEAwNf03g0Ae1jKgQLgkij9MEhBczW
        Ct5mEAjeXjAy1TD2liFqe+iEFFlz0sdR+cGhdVQN4SlJGuMt1FOKNEvMdMK06w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701256947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ltF6Izhg7GomhCmi/G40+Jhpg0cJILQoZKUjj7bMbO4=;
        b=PHm3w/b4cS0jBNjZO7gYUqp6zSyvq5ECWsK7/+JJa7Wow15Av77AFP+IiXoNMXlp+SSSVP
        D1mQON7NbDk0MwDQ==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Get rid of amd_erratum_383[]
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231120104152.13740-11-bp@alien8.de>
References: <20231120104152.13740-11-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <170125694727.398.1026941985465358298.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     1709528f73d475d3c9ec514bc0dee0b41cadd871
Gitweb:        https://git.kernel.org/tip/1709528f73d475d3c9ec514bc0dee0b41cadd871
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 03 Nov 2023 19:58:53 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 29 Nov 2023 12:13:08 +01:00

x86/CPU/AMD: Get rid of amd_erratum_383[]

Set it in init_amd_gh() unconditionally as that is the F10h init
function.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: http://lore.kernel.org/r/20231120104152.13740-11-bp@alien8.de
---
 arch/x86/kernel/cpu/amd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 219ae7e..7ab7f98 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -63,9 +63,6 @@ static const int amd_erratum_400[] =
 	AMD_OSVW_ERRATUM(1, AMD_MODEL_RANGE(0xf, 0x41, 0x2, 0xff, 0xf),
 			    AMD_MODEL_RANGE(0x10, 0x2, 0x1, 0xff, 0xf));
 
-static const int amd_erratum_383[] =
-	AMD_OSVW_ERRATUM(3, AMD_MODEL_RANGE(0x10, 0, 0, 0xff, 0xf));
-
 static const int amd_erratum_1485[] =
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x19, 0x10, 0x0, 0x1f, 0xf),
 			   AMD_MODEL_RANGE(0x19, 0x60, 0x0, 0xaf, 0xf));
@@ -876,8 +873,7 @@ static void init_amd_gh(struct cpuinfo_x86 *c)
 	 */
 	msr_clear_bit(MSR_AMD64_BU_CFG2, 24);
 
-	if (cpu_has_amd_erratum(c, amd_erratum_383))
-		set_cpu_bug(c, X86_BUG_AMD_TLB_MMATCH);
+	set_cpu_bug(c, X86_BUG_AMD_TLB_MMATCH);
 }
 
 static void init_amd_ln(struct cpuinfo_x86 *c)
