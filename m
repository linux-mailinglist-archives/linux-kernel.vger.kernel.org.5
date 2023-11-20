Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32747F10AE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjKTKom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjKTKoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:44:17 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C0110E0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:43:25 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 48E8940E0030;
        Mon, 20 Nov 2023 10:43:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6MdqnS4uwAxP; Mon, 20 Nov 2023 10:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700476969; bh=/Cy8NatvX/Kmu3ga/aoJptF1EvKLJEj2qDDtcQHYy0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FORQY5GWUhmMqGcviDAUSKl5P0aEjY/jU2Z7LWwHkOafLwm77LW4ydKq9vuswNw9s
         /wquzcAPGkFjxa2EZ0IGhWOmimZnHjXQ34u7Oz2hO8oGySn1CLrwusydPdKUj8jeY1
         uPFWMlf8m9dpgNSOcdp54qJPMe2fs7FpLmQBw3yJRvGBrPwBYJ0ZEJYpDgU3cQsgxt
         maS2VI/3PkYVG/a4ZgF8BtfLpVUZwIu6Vg4yGansAChOt1PdH7q9ISaaMHh3Luunt0
         wKok4HE73I6Q+zSgkwJWB/jWL2i2+cXnDTAKi8CG0Pgo2Fpu+RYB4oTHPcuEZKQHIz
         a0SIjsIVBKN8AR5CZV21KGeKlYv3fhhV9vl7RNnQ6dcGUm05Y95Iq/Uf35SRAMrOCl
         UGiWaanqiU0ppNJy0W6WUJ9OcUk2RK+6d2eD1EyKEVYtKpQmkR2Q4FqQUwHWg2lZsB
         mVfv31vblQaX4cPjdCdMEUYdXLXPn/bv3nIBAAhVkcx8Xbe1O9vrgEuqEEg3i4VnDe
         0qwnRw6kGXFcgnA7A0SmMxRHaCKfnyLoW0XL/KpLrOLNzWEsH1hcN42u9asElStNPT
         gRp4RcGkN3Hi+/fA0wAwqJpQV+bCi/xKkLoIl2+yE8BFz6z4c+9ErK3x4fuVz456E4
         1ayOMHuKdncSJ07tWYAecUts=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 17E6540E01C2;
        Mon, 20 Nov 2023 10:42:47 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 13/13] x86/CPU/AMD: Drop now unused CPU erratum checking function
Date:   Mon, 20 Nov 2023 11:41:52 +0100
Message-ID: <20231120104152.13740-14-bp@alien8.de>
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

Bye bye.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/amd.c | 56 ---------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 54e07c9b1292..a363de80ce28 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -34,62 +34,6 @@
  */
 static u32 nodes_per_socket =3D 1;
=20
-/*
- * AMD errata checking
- *
- * Errata are defined as arrays of ints using the AMD_LEGACY_ERRATUM() o=
r
- * AMD_OSVW_ERRATUM() macros. The latter is intended for newer errata th=
at
- * have an OSVW id assigned, which it takes as first argument. Both take=
 a
- * variable number of family-specific model-stepping ranges created by
- * AMD_MODEL_RANGE().
- *
- * Example:
- *
- * const int amd_erratum_319[] =3D
- *	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x10, 0x2, 0x1, 0x4, 0x2),
- *			   AMD_MODEL_RANGE(0x10, 0x8, 0x0, 0x8, 0x0),
- *			   AMD_MODEL_RANGE(0x10, 0x9, 0x0, 0x9, 0x0));
- */
-
-#define AMD_LEGACY_ERRATUM(...)		{ -1, __VA_ARGS__, 0 }
-#define AMD_OSVW_ERRATUM(osvw_id, ...)	{ osvw_id, __VA_ARGS__, 0 }
-#define AMD_MODEL_RANGE(f, m_start, s_start, m_end, s_end) \
-	((f << 24) | (m_start << 16) | (s_start << 12) | (m_end << 4) | (s_end)=
)
-#define AMD_MODEL_RANGE_FAMILY(range)	(((range) >> 24) & 0xff)
-#define AMD_MODEL_RANGE_START(range)	(((range) >> 12) & 0xfff)
-#define AMD_MODEL_RANGE_END(range)	((range) & 0xfff)
-
-static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erra=
tum)
-{
-	int osvw_id =3D *erratum++;
-	u32 range;
-	u32 ms;
-
-	if (osvw_id >=3D 0 && osvw_id < 65536 &&
-	    cpu_has(cpu, X86_FEATURE_OSVW)) {
-		u64 osvw_len;
-
-		rdmsrl(MSR_AMD64_OSVW_ID_LENGTH, osvw_len);
-		if (osvw_id < osvw_len) {
-			u64 osvw_bits;
-
-			rdmsrl(MSR_AMD64_OSVW_STATUS + (osvw_id >> 6),
-			    osvw_bits);
-			return osvw_bits & (1ULL << (osvw_id & 0x3f));
-		}
-	}
-
-	/* OSVW unavailable or ID unknown, match family-model-stepping range */
-	ms =3D (cpu->x86_model << 4) | cpu->x86_stepping;
-	while ((range =3D *erratum++))
-		if ((cpu->x86 =3D=3D AMD_MODEL_RANGE_FAMILY(range)) &&
-		    (ms >=3D AMD_MODEL_RANGE_START(range)) &&
-		    (ms <=3D AMD_MODEL_RANGE_END(range)))
-			return true;
-
-	return false;
-}
-
 static inline int rdmsrl_amd_safe(unsigned msr, unsigned long long *p)
 {
 	u32 gprs[8] =3D { 0 };
--=20
2.42.0.rc0.25.ga82fb66fed25

