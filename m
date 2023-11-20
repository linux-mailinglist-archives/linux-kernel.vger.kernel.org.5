Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CC47F10A6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjKTKoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjKTKnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:43:32 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC581989
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:42:54 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D158E40E01AF;
        Mon, 20 Nov 2023 10:42:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4zufFcqVaxxJ; Mon, 20 Nov 2023 10:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700476958; bh=3REK8cjilB4gave8JLXkaKTmlF3e5GW/wMP1cCyHtis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FHO2qSO3VMNY9RwxREiTRprM+KxzgGwsdIz6n7JCC0w7d8MUF2ciaRsiS3ver3ZMq
         RK6SaECmLOi7SEX3OYwoqLEonArd4Egw/th2cPWB7EA38l3NkdOkQaLZ+JBzi2k/tr
         lAGV0PkQ3gubQQZzzgId+RckqDAKwYNtWGOla+pcYnQLSSpxxPcaOzyjahR8SATB8N
         msswRbdN5V1rmTVX4lJ6A9npB14wUjVX3QBw3oUHb9MvG3aJulSEmlUD6A6t6Z6Eth
         WMZpdSZYeK9fn62BLE1P8z+VnbY9ZmVTHmPMViRXo4J7GxNlwkILScGpUupbGGJFIW
         pk7p9uGMn0R9M8hKBUNmCDRfWdYgJty0Jaa6PhzHBQw5cOUWw8UNdBPNNXOb0QtDsH
         aKZzuxTQYgITxwum6ZN4vu5XkaJgbURZ4nccwhsbOglueh4QmFGNdY1vV1E8HwA2dw
         qLQ4KVeyixUvt+1hdHLTcktVJjXrs9QZ5vtUK7CUdsnpH5WDs1D3tcvQmEilmny3lP
         H9h37QyeCxVxWah8G/jlq8VDoljMz1o733e3VHp0NnVzPO8exFiDiTXra2/0R4DoWq
         jB/Yb06Gg5opd1KR20t7Jn63f+0p6AqSyX+UpXl/eaI34MZJU7VHRCvhALKZl9IX+b
         nOIS2To+RYV8h9iSnsShLM6M=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AB7F140E01AA;
        Mon, 20 Nov 2023 10:42:36 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/13] x86/CPU/AMD: Get rid of amd_erratum_383[]
Date:   Mon, 20 Nov 2023 11:41:49 +0100
Message-ID: <20231120104152.13740-11-bp@alien8.de>
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

Set it in init_amd_gh() unconditionally as that is the F10h init
function.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/amd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 62aa99b5d6c8..3e25fa9c5275 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -63,9 +63,6 @@ static const int amd_erratum_400[] =3D
 	AMD_OSVW_ERRATUM(1, AMD_MODEL_RANGE(0xf, 0x41, 0x2, 0xff, 0xf),
 			    AMD_MODEL_RANGE(0x10, 0x2, 0x1, 0xff, 0xf));
=20
-static const int amd_erratum_383[] =3D
-	AMD_OSVW_ERRATUM(3, AMD_MODEL_RANGE(0x10, 0, 0, 0xff, 0xf));
-
 static const int amd_erratum_1485[] =3D
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x19, 0x10, 0x0, 0x1f, 0xf),
 			   AMD_MODEL_RANGE(0x19, 0x60, 0x0, 0xaf, 0xf));
@@ -876,8 +873,7 @@ static void init_amd_gh(struct cpuinfo_x86 *c)
 	 */
 	msr_clear_bit(MSR_AMD64_BU_CFG2, 24);
=20
-	if (cpu_has_amd_erratum(c, amd_erratum_383))
-		set_cpu_bug(c, X86_BUG_AMD_TLB_MMATCH);
+	set_cpu_bug(c, X86_BUG_AMD_TLB_MMATCH);
 }
=20
 static void init_amd_ln(struct cpuinfo_x86 *c)
--=20
2.42.0.rc0.25.ga82fb66fed25

