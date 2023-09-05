Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1984792B31
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243645AbjIEQtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354206AbjIEKJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:09:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0F890;
        Tue,  5 Sep 2023 03:09:41 -0700 (PDT)
Date:   Tue, 05 Sep 2023 10:09:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693908580;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8hmkCxff92AMLHFPiC6CiYR0LLeax6KR0R+GFpKZ0yg=;
        b=Jle9HAQHtuRsA4rQRXKxMes0nSZaD0ZHKrW/WaT72yyTYf9NRrArwiP9vFVfL7sIFxJp9Z
        tJfbC3mRSIXVTu8o4M8UmGl4uzM5xygFE+1rV5ePi091NU5FaYJ552W1GVwsyphGx8Qpvf
        q5hci0MqJUUsYt69uebQnaUWwrqFLxzMFojk3wfl/h+EiX9r3P09dOZz7bxelD2sD2so51
        4Vd2jBSiTYoVktDi/aVo/h6CD4TSPZLQI9j/Q5cXQeqV6H92p8eiz3/vstr0uUgF8tuEi5
        22jSm1wx1DZ3/35IQhbEq51+JcDQbixrKFYtYxt+BdgQ5A1Uzotie3cd9SgVZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693908580;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8hmkCxff92AMLHFPiC6CiYR0LLeax6KR0R+GFpKZ0yg=;
        b=dZoQgEXJgjEiM3vCOsf24EsKdUTdbhEXYrJfHpX20913EREEf1gJB3waVF0Vn+xzdpMa3g
        FY+gLcJfey/8V7DA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/srso: Don't probe microcode in a guest
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <3938a7209606c045a3f50305d201d840e8c834c7.1693889988.git.jpoimboe@kernel.org>
References: <3938a7209606c045a3f50305d201d840e8c834c7.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169390858010.27769.15150522813348003311.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     7e0a668e6a292d4b47e638078a21736bb3a73ffb
Gitweb:        https://git.kernel.org/tip/7e0a668e6a292d4b47e638078a21736bb3a=
73ffb
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:04:47 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 05 Sep 2023 12:05:06 +02:00

x86/srso: Don't probe microcode in a guest

To support live migration, the hypervisor sets the "lowest common
denominator" of features.  Probing the microcode isn't allowed because
any detected features might go away after a migration.

As Andy Cooper states:

  "Linux must not probe microcode when virtualised.=C2=A0 What it may see
  instantaneously on boot (owing to MSR_PRED_CMD being fully passed
  through) is not accurate for the lifetime of the VM."

Rely on the hypervisor to set the needed IBPB_BRTYPE and SBPB bits.

Fixes: 1b5277c0ea0b ("x86/srso: Add SRSO_NO support")
Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/3938a7209606c045a3f50305d201d840e8c834c7.1693=
889988.git.jpoimboe@kernel.org
---
 arch/x86/kernel/cpu/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index afacc48..03ef962 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -767,7 +767,7 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_TOPOEXT))
 		smp_num_siblings =3D ((cpuid_ebx(0x8000001e) >> 8) & 0xff) + 1;
=20
-	if (!cpu_has(c, X86_FEATURE_IBPB_BRTYPE)) {
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR) && !cpu_has(c, X86_FEATURE_IBPB_BRT=
YPE)) {
 		if (c->x86 =3D=3D 0x17 && boot_cpu_has(X86_FEATURE_AMD_IBPB))
 			setup_force_cpu_cap(X86_FEATURE_IBPB_BRTYPE);
 		else if (c->x86 >=3D 0x19 && !wrmsrl_safe(MSR_IA32_PRED_CMD, PRED_CMD_SBPB=
)) {
