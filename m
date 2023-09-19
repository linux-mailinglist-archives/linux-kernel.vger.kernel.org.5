Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCA07A5E77
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjISJp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjISJpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:45:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13307F0;
        Tue, 19 Sep 2023 02:45:07 -0700 (PDT)
Date:   Tue, 19 Sep 2023 09:45:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695116706;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3bfNwEv8rwXl1n1xKvOV/RnMdBIU+lyu6K6e055jI3A=;
        b=pekXexCTzkkGRAgcrIwSVIQ32FCMpnkQbrkYQL5eJk8KF0iNnacIXrm7av0puk+pB5fBC5
        kL4Ehj3rfOr1ZU5417dCSP6uDZaj4Xo9hj3TXqzg0c+XXzQDMwoKArIOZ6q/oKz+f1Zyoj
        ZHzLP2J3wEexRG8eM6OcewbQ+K+nSi8T1VodOPNKcDk9sc4YkRnPpSo3p7bFUt2YZQ//nB
        x6qqnjv85uEkqtv25aNTFMqudHybt4dKLzCRm99i7psytCTyQIdKd0iAvn7JuNf8OSlvOs
        EVbAAr+sOV6/VbAPm+6y+6irK+/grFBu0tV/Wlv1fMK2vRzxXqv2mB+SX4gekg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695116706;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3bfNwEv8rwXl1n1xKvOV/RnMdBIU+lyu6K6e055jI3A=;
        b=WPKF5erVqPp/uTkmQuXkKZmaVd2b4CqAnvXlBGjcu58PYoslKY58C0rFCDy8UX0EYNnEgi
        wkxJBuFlj0Y/vKBw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/srso: Don't probe microcode in a guest
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <3938a7209606c045a3f50305d201d840e8c834c7.1693889988.git.jpoimboe@kernel.org>
References: <3938a7209606c045a3f50305d201d840e8c834c7.1693889988.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <169511670568.27769.4434872346573872606.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     02428d0366a27c2f33bc4361eb10467777804f29
Gitweb:        https://git.kernel.org/tip/02428d0366a27c2f33bc4361eb104677778=
04f29
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 04 Sep 2023 22:04:47 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 19 Sep 2023 10:54:23 +02:00

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
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
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
