Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2767F1097
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjKTKmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjKTKmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:42:17 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE2ACA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:42:14 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DAE3740E0191;
        Mon, 20 Nov 2023 10:42:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zQK2PZAC1s1k; Mon, 20 Nov 2023 10:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700476929; bh=dv3r8X4PHcRGZmkccWpMHrdFrdRvuJJOngRouvfj1cI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kvheRbZgGhDZDztAyWLdFiT2cZuMpgLvBcqrYW+D7vobax6NfFD0mf/Cpnx3X17+6
         pzxJxMNRT/hPi7F+/ErWPgJNFtne/BCNWqu5q9qbiaBrOOGGohLtq95IQtcf2rzicB
         LPCY2kFEreePjhWkvyH+wJDhSO+HioKRw4HGT6Vpi8+Mn53Q4oY2vAXg7MF4UAftRu
         O3xkCwTHFrAdjrG+t+muI2kNdjmJtdejZwjpvYsZ15ttZ+xhOj8v/bmhwxZDaP+pf5
         z+BD4WfkEWHiWWBPN0b1TarApXOOI8X/l0OTuFKjzE1ZqQmafdd0QdB+nJRSvZnOBx
         RRQiTURetORNbTlVcH8DQzXeYr4c1KH2eg4oa8GauobXA1YA9iHVldq5PNaWOMDkMc
         SlPyiV1A4Vc0uR3HFVNjFnxQA3A+mmy6heAqz6nA7+m/QPZXjRBC5QcWiW9+ZwipVa
         kzA7n+5FwGbOQ7Kl+DPb3EzgHO77hkvqlJGqi7JcMlzz3xBmQNWVtbVXm/K3C6TjiI
         Zi8ramvdJP9MXKxLcYruG6uOQrzlb8b5qELG3aUETUIk/oJQ5sr8Dz4iLmuNoP75MD
         tAXxh1lxG0LTOFxNsGCPnmesd4Yd4KZFM4jq7A3sTJ7fyFjxSuDVeOnRflRvvkhzLO
         DNHSqYGJorxQpvRy00rJedDw=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6283440E0030;
        Mon, 20 Nov 2023 10:42:07 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/13] x86/CPU/AMD: Carve out the erratum 1386 fix
Date:   Mon, 20 Nov 2023 11:41:41 +0100
Message-ID: <20231120104152.13740-3-bp@alien8.de>
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

Call it on the affected CPU generations.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/amd.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index fa6ba63ca7e2..b3f939101368 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -984,6 +984,19 @@ static void init_amd_bd(struct cpuinfo_x86 *c)
 	clear_rdrand_cpuid_bit(c);
 }
=20
+static void fix_erratum_1386(struct cpuinfo_x86 *c)
+{
+	/*
+	 * Work around Erratum 1386.  The XSAVES instruction malfunctions in
+	 * certain circumstances on Zen1/2 uarch, and not all parts have had
+	 * updated microcode at the time of writing (March 2023).
+	 *
+	 * Affected parts all have no supervisor XSAVE states, meaning that
+	 * the XSAVEC instruction (which works fine) is equivalent.
+	 */
+	clear_cpu_cap(c, X86_FEATURE_XSAVES);
+}
+
 void init_spectral_chicken(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_CPU_UNRET_ENTRY
@@ -1004,15 +1017,6 @@ void init_spectral_chicken(struct cpuinfo_x86 *c)
 		}
 	}
 #endif
-	/*
-	 * Work around Erratum 1386.  The XSAVES instruction malfunctions in
-	 * certain circumstances on Zen1/2 uarch, and not all parts have had
-	 * updated microcode at the time of writing (March 2023).
-	 *
-	 * Affected parts all have no supervisor XSAVE states, meaning that
-	 * the XSAVEC instruction (which works fine) is equivalent.
-	 */
-	clear_cpu_cap(c, X86_FEATURE_XSAVES);
 }
=20
 static void init_amd_zn(struct cpuinfo_x86 *c)
@@ -1040,10 +1044,12 @@ static void init_amd_zn(struct cpuinfo_x86 *c)
=20
 static void init_amd_zen(struct cpuinfo_x86 *c)
 {
+	fix_erratum_1386(c);
 }
=20
 static void init_amd_zen2(struct cpuinfo_x86 *c)
 {
+	fix_erratum_1386(c);
 }
=20
 static void init_amd_zen3(struct cpuinfo_x86 *c)
--=20
2.42.0.rc0.25.ga82fb66fed25

