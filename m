Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACC37F10A9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbjKTKoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjKTKoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:44:07 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1221BE1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:43:15 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7F94F40E0191;
        Mon, 20 Nov 2023 10:43:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zrEdcRAkvAu4; Mon, 20 Nov 2023 10:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700476962; bh=CeuqZVKZSFZbymJVdmtPdEsvanTHXzAKwND3+dNFkVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eLjyU6l56F/aLBvzxQzl+i2e/rrASbVV/iVxLK/+b/NK3GMYtSAvaCFbbhx1zfhFL
         JB2ABi8mgPCxC/zckKwLZoR0GE+rbxmNWYjufLOLRG4g1CN/L81kgt/lH/hCRaT+dH
         B5g6q4pt2kW4x6OV649xUxKPmHSSXDh9qabjOiRG//KMYoHxTbMUF9lIzl/I2LWZK8
         i08OKH8QtFsdiG9raXWBWRjxP35/qx07diUE4iNf+MfCyf40vAJfxSy6R7HeBtJJUv
         +a/9t2D89eniLEWy0tMqQQM94E/aAVH+Fv0gVc6+oD5rOIif4JEzL3ajlhKVgyhN95
         HJFd1ZChvi8RF0p5QJz/Fao4zELxcXrXYeeGWck7cW/uJYh+ztWVmQrWDeLgDXav/s
         VgcO/27oyQmBBvP2liL5Cdjq7WTwkhxQkkJx6LTE3I7GjehBhaBIYvIizjN/i+NPXq
         dQUMO19xX/xr+oPzjUyxi+AnC7wvneucndbqHwVF6SAJTOoJdP8GIzEGozPxq0Xo1D
         6n4yHHAikpCc+8fkZKwT/Fl8IgJj71SGOWncEW5gM5pxCeZT3zyLJzU4EetQmF4WsB
         xip2lZr3c2xW0u2HDzFicRRW/66W9hYx0o/97MQAwWx3D6KozIJFQDktrCw3am1ZwD
         j4wIhaPBzz0T7UZWhoQ+OZ+g=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 42D5C40E0031;
        Mon, 20 Nov 2023 10:42:40 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/13] x86/CPU/AMD: Get rid of amd_erratum_400[]
Date:   Mon, 20 Nov 2023 11:41:50 +0100
Message-ID: <20231120104152.13740-12-bp@alien8.de>
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

Setting X86_BUG_AMD_E400 in init_amd() is early enough.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/amd.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 3e25fa9c5275..f913ca245639 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -59,10 +59,6 @@ static u32 nodes_per_socket =3D 1;
 #define AMD_MODEL_RANGE_START(range)	(((range) >> 12) & 0xfff)
 #define AMD_MODEL_RANGE_END(range)	((range) & 0xfff)
=20
-static const int amd_erratum_400[] =3D
-	AMD_OSVW_ERRATUM(1, AMD_MODEL_RANGE(0xf, 0x41, 0x2, 0xff, 0xf),
-			    AMD_MODEL_RANGE(0x10, 0x2, 0x1, 0xff, 0xf));
-
 static const int amd_erratum_1485[] =3D
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x19, 0x10, 0x0, 0x1f, 0xf),
 			   AMD_MODEL_RANGE(0x19, 0x60, 0x0, 0xaf, 0xf));
@@ -765,15 +761,6 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 	if (c->x86 =3D=3D 0x16 && c->x86_model <=3D 0xf)
 		msr_set_bit(MSR_AMD64_LS_CFG, 15);
=20
-	/*
-	 * Check whether the machine is affected by erratum 400. This is
-	 * used to select the proper idle routine and to enable the check
-	 * whether the machine is affected in arch_post_acpi_init(), which
-	 * sets the X86_BUG_AMD_APIC_C1E bug depending on the MSR check.
-	 */
-	if (cpu_has_amd_erratum(c, amd_erratum_400))
-		set_cpu_bug(c, X86_BUG_AMD_E400);
-
 	early_detect_mem_encrypt(c);
=20
 	/* Re-enable TopologyExtensions if switched off by BIOS */
@@ -840,6 +827,16 @@ static void init_amd_k8(struct cpuinfo_x86 *c)
 	msr_set_bit(MSR_K7_HWCR, 6);
 #endif
 	set_cpu_bug(c, X86_BUG_SWAPGS_FENCE);
+
+	/*
+	 * Check models and steppings affected by erratum 400. This is
+	 * used to select the proper idle routine and to enable the
+	 * check whether the machine is affected in arch_post_acpi_subsys_init(=
)
+	 * which sets the X86_BUG_AMD_APIC_C1E bug depending on the MSR check.
+	 */
+	if (c->x86_model > 0x41 ||
+	    (c->x86_model =3D=3D 0x41 && c->x86_stepping >=3D 0x2))
+		setup_force_cpu_bug(X86_BUG_AMD_E400);
 }
=20
 static void init_amd_gh(struct cpuinfo_x86 *c)
@@ -874,6 +871,16 @@ static void init_amd_gh(struct cpuinfo_x86 *c)
 	msr_clear_bit(MSR_AMD64_BU_CFG2, 24);
=20
 	set_cpu_bug(c, X86_BUG_AMD_TLB_MMATCH);
+
+	/*
+	 * Check models and steppings affected by erratum 400. This is
+	 * used to select the proper idle routine and to enable the
+	 * check whether the machine is affected in arch_post_acpi_subsys_init(=
)
+	 * which sets the X86_BUG_AMD_APIC_C1E bug depending on the MSR check.
+	 */
+	if (c->x86_model > 0x2 ||
+	    (c->x86_model =3D=3D 0x2 && c->x86_stepping >=3D 0x1))
+		setup_force_cpu_bug(X86_BUG_AMD_E400);
 }
=20
 static void init_amd_ln(struct cpuinfo_x86 *c)
--=20
2.42.0.rc0.25.ga82fb66fed25

