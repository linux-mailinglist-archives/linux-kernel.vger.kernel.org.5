Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5AA8012F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379363AbjLASmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjLASmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:42:37 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A9EEE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:42:43 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5A82840E025A;
        Fri,  1 Dec 2023 18:42:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dPMV77SPVAIt; Fri,  1 Dec 2023 18:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701456157; bh=nphy73heotHESjgWYM7KNLZwEMvJWDEfBY+tKnZJzkc=;
        h=From:To:Cc:Subject:Date:From;
        b=gT2RpaCJ5K7cFl2aIaYaf+m/zXF2vNijONCjCXJOexroeNDMI8OzTa5Hl4sTemOQz
         MhwLBCGOA4JbZyO+BSHzSQ3MrX9zNTKUTHJv01DvPhx/PDyEMdT8YgD6Gi0a0ii8kX
         q3a2J/JYSOeS5vScTsz8J95LgCR/IItx5KhpzcTTT45IjfT1abuSF8wyeqgbI8OTEy
         jAy0vPhKOOZoFhtTSDjHwfCPDBpYOP+2MPbImjUlwbIz3jQ/oAQRCWSBM1C/0CnxiP
         pWDuPY0TY2E7VPWwB7HOASLxpOSafrI6esniJ/WhPff6kSxfFm6EWBST81zCuqUhM2
         9sn18TwqqfMPpd6LDrr283AUKX6EpcUSJjIS3Hc4nRCAMS1A2OPODP9UY2Tv89KLQe
         +Qpo6YvS4sODkpiTJ7qSdj77jlEpinvNT96NaRFi9uLTx5DTwytQuVEJ6/l2AjnDHo
         t08EU2SNoeZKxmCFltSBqPCZIcAqcSLqFQszaNN14nh6Pk/ppB6lTp3lJZBAfoWN5e
         bJgInyTcJNo5DhX397Al06wPZPv11a627UHKci6O2dRoDWKLI2DC/nhf8QHqsS8KCj
         1Y0DIp5FyOhn30vJtU6JiMU7WPqr58G32jfuMsaPKWeJVvZ49hAy3lsZg+ITrd94r9
         X08Xz2KmjtZNQCe8iwIkrm4I=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D7FB40E0030;
        Fri,  1 Dec 2023 18:42:35 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/CPU/AMD: Check vendor in the AMD microcode callback
Date:   Fri,  1 Dec 2023 19:42:26 +0100
Message-ID: <20231201184226.16749-1-bp@alien8.de>
X-Mailer: git-send-email 2.42.0.rc0.25.ga82fb66fed25
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

Commit in Fixes added an AMD-specific microcode callback. However, it
didn't check the CPU vendor the kernel runs on explicitly.

The only reason the Zenbleed check in it didn't run on other x86 vendors
hardware was pure coincidental luck:

  if (!cpu_has_amd_erratum(c, amd_zenbleed))

gives true on other vendors because they don't have those families and
models.

However, with the removal of the cpu_has_amd_erratum() in

  05f5f73936fa ("x86/CPU/AMD: Drop now unused CPU erratum checking functi=
on")

that coincidental condition is gone, leading to the zenbleed check
getting executed on other vendors too.

Add the explicit vendor check for the whole callback as it should've
been done in the first place.

Fixes: 522b1d69219d ("x86/cpu/amd: Add a Zenbleed fix")
Cc: <stable@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/amd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index a7eab05e5f29..f322ebd053a9 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1320,6 +1320,9 @@ static void zenbleed_check_cpu(void *unused)
=20
 void amd_check_microcode(void)
 {
+	if (boot_cpu_data.x86_vendor !=3D X86_VENDOR_AMD)
+		return;
+
 	on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }
=20
--=20
2.42.0.rc0.25.ga82fb66fed25

