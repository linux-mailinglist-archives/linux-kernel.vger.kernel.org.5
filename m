Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE7E7CCFDC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 00:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344144AbjJQWGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 18:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjJQWGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 18:06:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF5CD3;
        Tue, 17 Oct 2023 15:06:06 -0700 (PDT)
Date:   Tue, 17 Oct 2023 22:06:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697580365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MIA4vCEdr5qmRgfJnFc6gfEBza2FMTeL6jD3+oV9ltA=;
        b=xJdqr3dB92fJy4Ei0yuV7JpqsZLxQGvHpjy0U8TOF8Dxz4YfXdEgPhFlOUKsz2d20AjM8V
        1MCjDyBrucKbfLwqOQEjmZ6Hiu8QWwL47sc4b05MOpB5MIshR7bQzbwACgS7CmSeD3QSRQ
        x6xMztrfVJomhjuy/9qn3GKlMlph6nvQXcxmUsYFby7SK9tv9gPV+qvy2+9xBXHH/I09Ce
        XcRClvqoHhR1ENlHJKzYMk1e263Vue//otgEwznGbK1fztaFIshlct3w5U3dlXRK1zwqq0
        7Ro1hdXtRho1yQ70cT9W4smWIzq8bLbFVdjz+iR5s8/ZknFdDNKr0GYqrZyTnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697580365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MIA4vCEdr5qmRgfJnFc6gfEBza2FMTeL6jD3+oV9ltA=;
        b=jJ8kDqfwX04hThJvuULdItASzP5tOFyeuCPPG/F++1lRae0k4rJI/XHex08OOYLABSEyOd
        Ph5HsHdA4A6wx8Aw==
From:   "tip-bot2 for Paolo Bonzini" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/amd: Fix snprintf() format string
 warning in W=1 build
Cc:     kernel test robot <lkp@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231016224858.2829248-1-pbonzini@redhat.com>
References: <20231016224858.2829248-1-pbonzini@redhat.com>
MIME-Version: 1.0
Message-ID: <169758036182.3135.18264735357124966829.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     2e9064faccd1a5b9de8c6f4b23d9f4948901cbe9
Gitweb:        https://git.kernel.org/tip/2e9064faccd1a5b9de8c6f4b23d9f494890=
1cbe9
Author:        Paolo Bonzini <pbonzini@redhat.com>
AuthorDate:    Mon, 16 Oct 2023 18:48:58 -04:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 17 Oct 2023 23:51:58 +02:00

x86/microcode/amd: Fix snprintf() format string warning in W=3D1 build

Building with GCC 11.x results in the following warning:

  arch/x86/kernel/cpu/microcode/amd.c: In function =E2=80=98find_blobs_in_con=
tainers=E2=80=99:
  arch/x86/kernel/cpu/microcode/amd.c:504:58: error: =E2=80=98h.bin=E2=80=99 =
directive output may be truncated writing 5 bytes into a region of size betwe=
en 1 and 7 [-Werror=3Dformat-truncation=3D]
  arch/x86/kernel/cpu/microcode/amd.c:503:17: note: =E2=80=98snprintf=E2=80=
=99 output between 35 and 41 bytes into a destination of size 36

The issue is that GCC does not know that the family can only be a byte
(it ultimately comes from CPUID).  Suggest the right size to the compiler
by marking the argument as char-size ("hh").  While at it, instead of
using the slightly more obscure precision specifier use the width with
zero padding (over 23000 occurrences in kernel sources, vs 500 for
the idiom using the precision).

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Closes: https://lore.kernel.org/oe-kbuild-all/202308252255.2HPJ6x5Q-lkp@intel=
.com/
Link: https://lore.kernel.org/r/20231016224858.2829248-1-pbonzini@redhat.com
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microc=
ode/amd.c
index bbd1dc3..b4eea8a 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -501,7 +501,7 @@ static bool get_builtin_microcode(struct cpio_data *cp, u=
nsigned int family)
=20
 	if (family >=3D 0x15)
 		snprintf(fw_name, sizeof(fw_name),
-			 "amd-ucode/microcode_amd_fam%.2xh.bin", family);
+			 "amd-ucode/microcode_amd_fam%02hhxh.bin", family);
=20
 	if (firmware_request_builtin(&fw, fw_name)) {
 		cp->size =3D fw.size;
