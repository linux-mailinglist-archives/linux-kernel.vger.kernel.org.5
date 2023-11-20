Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D107F10A4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjKTKnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjKTKnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:43:06 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B911704
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:42:43 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9466E40E01BF;
        Mon, 20 Nov 2023 10:42:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FkM5rZcHIeIX; Mon, 20 Nov 2023 10:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700476951; bh=Ai/81xa1PmMbh8PDFy1HNfT8wal2Kj9G4K1sJJ+j/1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MHmkJR561JRO5EFxWvGUcPpCt/Td0n0L4xwqHkt2ivnALHtY0aOZ9F6NlAr4UcRVl
         21z+Z0HBnA9gqiaBefkoWqwjPQPVmTUk3jiGio73nFXjxbJfbMcahrK/XEIp7fAnTU
         33rwO0RGG/TZIy5V5j5xH1T9JO1EnasThcDfpXH8IGvGMMWsqzZ57oDODe8UexwG/h
         HzDRk7PKaMiTbcVMQs4kPYVs4Tmv5XF54ZaFe4/I5EjrfCIoZAe7viEXSg0/CIe2zS
         bGHI0eadkREGOJLuZ+bHoCtt9ZyrxaPcGXp3XHOlBFFm4Dt9oUStmMGmC4vXMHMEst
         N6KnE2sYO82noJrlQotkHczXmyfvkwFVZJ1qiG62alOFWFNnAMsD75GJmn6Y/0YWRY
         qtS/uRXOrH6yyMGnduwVfwHrea8LGKz0H4QatQhUJ4szdSpqJTV1y9UQplaGgPTkNO
         0vtAuX4/96PnkjGqMX4p8o0HO/Vrt6Fgi6P68zelj5Ap3cDlGqWBzh0Ot+p+uKOPmW
         oOK2kRaps2t9wIi8fL/DQolVAste9dlsBSGwyDYbf/V+jVFba7izNqBq6/+XwbnUSC
         27tYr0Nhc4CPgiuoazxXmxevXqdVMOGRX8I3w7/p0w0ggyx2pR8lRJ6xiPrGLOGbtg
         wp3X00QHqmtC8YV7+3yJ/QMc=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A72D340E0030;
        Mon, 20 Nov 2023 10:42:29 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/13] x86/CPU/AMD: Move the DIV0 bug detection to the Zen1 init function
Date:   Mon, 20 Nov 2023 11:41:47 +0100
Message-ID: <20231120104152.13740-9-bp@alien8.de>
X-Mailer: git-send-email 2.42.0.rc0.25.ga82fb66fed25
In-Reply-To: <20231120104152.13740-1-bp@alien8.de>
References: <20231120104152.13740-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/amd.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 7cbb108afaf4..43d6a6da7591 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -70,10 +70,6 @@ static const int amd_erratum_383[] =3D
 static const int amd_erratum_1054[] =3D
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0, 0, 0x2f, 0xf));
=20
-static const int amd_div0[] =3D
-	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0x00, 0x0, 0x2f, 0xf),
-			   AMD_MODEL_RANGE(0x17, 0x50, 0x0, 0x5f, 0xf));
-
 static const int amd_erratum_1485[] =3D
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x19, 0x10, 0x0, 0x1f, 0xf),
 			   AMD_MODEL_RANGE(0x19, 0x60, 0x0, 0xaf, 0xf));
@@ -1031,6 +1027,8 @@ static void init_amd_zen(struct cpuinfo_x86 *c)
 			set_cpu_cap(c, X86_FEATURE_CPB);
 	}
=20
+	pr_notice_once("AMD Zen1 DIV0 bug detected. Disable SMT for full protec=
tion.\n");
+	setup_force_cpu_bug(X86_BUG_DIV0);
 }
=20
 static bool cpu_has_zenbleed_microcode(void)
@@ -1219,11 +1217,6 @@ static void init_amd(struct cpuinfo_x86 *c)
 	    cpu_has(c, X86_FEATURE_AUTOIBRS))
 		WARN_ON_ONCE(msr_set_bit(MSR_EFER, _EFER_AUTOIBRS));
=20
-	if (cpu_has_amd_erratum(c, amd_div0)) {
-		pr_notice_once("AMD Zen1 DIV0 bug detected. Disable SMT for full prote=
ction.\n");
-		setup_force_cpu_bug(X86_BUG_DIV0);
-	}
-
 	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
 	     cpu_has_amd_erratum(c, amd_erratum_1485))
 		msr_set_bit(MSR_ZEN4_BP_CFG, MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT);
--=20
2.42.0.rc0.25.ga82fb66fed25

