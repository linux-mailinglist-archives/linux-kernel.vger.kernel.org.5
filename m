Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E60A77A5FD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 12:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjHMKp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 06:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHMKpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 06:45:25 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7711709
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 03:45:26 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 10E1340E0196;
        Sun, 13 Aug 2023 10:45:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WqiI0bQmSuBk; Sun, 13 Aug 2023 10:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691923522; bh=qVnzDGNq3+H6zNvRihhqRbRt0S9chv07HAXr7d9v75U=;
        h=From:To:Cc:Subject:Date:From;
        b=OBAHQWv2Di5wVFVoDKhrWpf5Xr0OeZLMrsViu+Ly9d2fchsPbiuVY8JHHHktz6eNE
         TxVYTTQhc3BG3zY9Cy5iIfQohQQhl6vbNvGR5Sc74j32lgjCDzCknm1IDzefA5IbuO
         esKBPEZhkjTDgpvnH5tZpw6CiEZxinJtvS0TwCcaAIOui2wiNEE1ZRzqBD6Tkt3HET
         KE+imenDRPLN2nlZ1mU7Dn+Ib0M3qiI8PQk0+fdPvnniWepNU9dGP0gFEP4+gpui+R
         +3aOUhFRH82oLjaVaQIGo2d566PhD6Ny8GE98uIWvbTRcRQi3BcrvHYlP8/r1Aj+e7
         RxU75XNNPVmr8/tymZ4ORU6lXnKKXgAb9hELEsdPMvBwxD8ekzBDgOCdo0wAPDs+37
         DLFP1kmNcbNw3gQ3FRhrfvr4wZjaURXhuX9A06WxInZLrSn8kzetFtzclwJod77rw3
         pHcI6ynj9EK5L8vq+FwBOJ+8AlHgiNg8f6TiCdSPWTsTP8k/XHaQ++tbtaGr5+VCkN
         TxEGif8+cxdwPb5zVLeXjL0PixF89RG/6v8oEf9oUUjDoRstMzXX2oK2GNdYaEoCH4
         aVWxxH9mM+OMZypom2G6418w3C4GzL6ZPiN4NyPkHU8Y56uy7rtjGyqSEOwynJ5xE7
         /OECq7MLJWRQNeduoOq/0yX8=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4FA2E40E0195;
        Sun, 13 Aug 2023 10:45:19 +0000 (UTC)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/srso: Disable the mitigation on unaffected configurations
Date:   Sun, 13 Aug 2023 12:45:17 +0200
Message-ID: <20230813104517.3346-1-bp@alien8.de>
X-Mailer: git-send-email 2.42.0.rc0.25.ga82fb66fed25
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Skip the srso cmd line parsing which is not needed on Zen1/2 with SMT
disabled and with the proper microcode applied (latter should be the
case anyway) as those are not affected.

Fixes: 5a15d8348881 ("x86/srso: Tie SBPB bit setting to microcode patch d=
etection")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/bugs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d02f73c5339d..8959a1b9fb80 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2418,8 +2418,10 @@ static void __init srso_select_mitigation(void)
 		 * IBPB microcode has been applied.
 		 */
 		if ((boot_cpu_data.x86 < 0x19) &&
-		    (!cpu_smt_possible() || (cpu_smt_control =3D=3D CPU_SMT_DISABLED))=
)
+		    (!cpu_smt_possible() || (cpu_smt_control =3D=3D CPU_SMT_DISABLED))=
) {
 			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
+			goto pred_cmd;
+		}
 	}
=20
 	if (retbleed_mitigation =3D=3D RETBLEED_MITIGATION_IBPB) {
@@ -2696,6 +2698,9 @@ static ssize_t retbleed_show_state(char *buf)
=20
 static ssize_t srso_show_state(char *buf)
 {
+	if (boot_cpu_has(X86_FEATURE_SRSO_NO))
+		return sysfs_emit(buf, "Not affected\n");
+
 	return sysfs_emit(buf, "%s%s\n",
 			  srso_strings[srso_mitigation],
 			  (cpu_has_ibpb_brtype_microcode() ? "" : ", no microcode"));
--=20
2.42.0.rc0.25.ga82fb66fed25

