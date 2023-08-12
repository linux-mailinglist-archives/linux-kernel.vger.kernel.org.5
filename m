Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E12D77A0DF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjHLPt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHLPtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:49:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F511FC1;
        Sat, 12 Aug 2023 08:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691855334; x=1692460134; i=deller@gmx.de;
 bh=AQBcB+CUsX2eTH/+u9mZCUJr+ijUOKXmaOz8H8saal4=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=qPwxhJR79FJL9yRRwISVfZJr9JX1oQFTtt1sOk7MYGg8JyJ0NJpteHMqDRHUa6VKhP7YWGO
 b62K2CYwt8ZZ7/zssWPu9tFrKj8pRJE801Jt0dmo6hrJPChzgFrk+xlzuYdgGtm60wCwLEUzw
 ITSkChaJxFIkFjeuHKFmuVaVvJWXp10BPder1HeNCPXOrc4exxq0EF6ygb0fPwVLE4sfMy4fy
 /xp6oOenmYg7z9hEmlpSZ/baoI6iFmWpnijNqbPk6txQruBcbKc0Ry74hXYXvG4ioWm1SQ5gE
 zK7UDRdXHtu0ycax5odDpdoX5iot6N0BHC2NQCLD2XNYqKuF5Sjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.153.44]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mkpf3-1q4YJd3GMp-00mJHY; Sat, 12
 Aug 2023 17:48:54 +0200
Date:   Sat, 12 Aug 2023 17:48:52 +0200
From:   Helge Deller <deller@gmx.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] lockdep: Fix static memory detection even more
Message-ID: <ZNep5EcYskP9HtGD@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:dcEbt/hL0xn2+/fOPVPAwmkoSqwPYd0eThhUGchBAgmMMFlJtPq
 GJlkPvu/V+fAy2HMh6rrZWAvitZoPyaIjpL79Ktanywxqa5gB3+sODzWqVKQ1crJGjx+WVJ
 puiHh5M6MMHwVqkeVaAge+FRxQqM6rKN8vSmn7d6InP8J5E0Xb2+Y6aypYADBMVL1svoGbj
 SQ/bR316Sou6uCSf5txYA==
UI-OutboundReport: notjunk:1;M01:P0:FQuwPfMEExY=;0JYJ1lo7wRKTut9LtUqVC1gCdxn
 cqA6IjESb79Fst17BdqiY//gP9sRdNViukWNjBbrLbSrmL/I0267DW2CLXR4aMkztB5ZIwC1J
 m1pw+iF7wl2G5yhVVmjMqlBCkaL6X7gcww2tOGjP4n2r24GtttypEzCTDUHdNtDatC9ZsLHy8
 6ngAUkx3qXiYB13r0rj7ZDrk8Exrj8MRBdGh+rxBbvP0JPugMBYR+QAWfws8eKZMfL1mUQ6Qb
 9ppGDVRn86xowoG8gzCbxTIFPjj0f//pqdOuXB6LVZibMKRoz1pqXRy5pJSNbNyIg+2yjVdP+
 Z7aIQuQ+0Nze57gQidbipSrOTB321PEIxU3fYQ3FzFacnEH8deDzD6FOFs3/59ITP78P4H0Ka
 49K8Vt2DjEDCBYVzW1sLb0PuflsYO2Oy8Y33aF8pGTGD4/eb2z8bOuotpLOgltKA3FfLTtk47
 n5hfn+JkscqiU/ojDZ+4sRXNdyMwUH9hU119zcwDFpAsH4WUHjhYFWB2AYqLtyBJjL/8l8zrZ
 wajni0bjSxw86vmmBpFCJYpHogZu9386UVrvphg1+T91UjtV05refULoCb5lwPVaDjTBXnixD
 Uo7UMSqBBjVbzEvmBr/RoRSvTJDa8DhjlYr6EhDnJTFjXmxo/2KV5aq1/b2d8zG26gdcZFUrK
 NXYPWuXBaNTwdSUY5na2Nb1a6TvVNGz40Z2dtvfHZxGJPTOg48vxDfllP2GXh6qFJLwC6sJky
 /VmkbA9DIwDHxZd4TJ4ljufD1RZAPvAKnzdDxAHzM1d1gVMYpH9GzTXDRefYhIYXlFkSPgoJQ
 eiQPbIHuBwijAiQDL0SuIUdrI7573NFTsbXJeonWsyQWXSx5U61Mj6Ajvjg8pBCRY4ZB9FKaO
 SHSRASFrLGqfc5SgN/KzUbHQUC52RX6n/jOWKpx/2xpaoivS8gV8la5Ma1cvZpel2gE+nWSgT
 PruKjg==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the parisc architecture, lockdep reports for all static objects which
are in the __initdata section (e.g. "setup_done" in devtmpfs,
"kthreadd_done" in init/main.c) this warning:

	INFO: trying to register non-static key.

The warning itself is wrong, because those objects are in the __initdata
section, but the section itself is on parisc outside of range from
_stext to _end, which is why the static_obj() functions returns a wrong
answer.

While fixing this issue, I noticed that the whole existing check can
be simplified a lot.
Instead of checking against the _stext and _end symbols (which include
code areas too) just check for the .data and .bss segments (since we check=
 a
data object). This can be done with the existing is_kernel_core_data()
macro.

In addition objects in the __initdata section can be checked with
init_section_contains().

This partly reverts and simplifies commit bac59d18c701 ("x86/setup: Fix st=
atic
memory detection").

Tested on x86-64 and parisc.

Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: bac59d18c701 ("x86/setup: Fix static memory detection")

=2D--

diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sectio=
ns.h
index a6e8373a5170..3fa87e5e11ab 100644
=2D-- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_X86_SECTIONS_H
 #define _ASM_X86_SECTIONS_H

-#define arch_is_kernel_initmem_freed arch_is_kernel_initmem_freed
-
 #include <asm-generic/sections.h>
 #include <asm/extable.h>

@@ -18,20 +16,4 @@ extern char __end_of_kernel_reserve[];

 extern unsigned long _brk_start, _brk_end;

-static inline bool arch_is_kernel_initmem_freed(unsigned long addr)
-{
-	/*
-	 * If _brk_start has not been cleared, brk allocation is incomplete,
-	 * and we can not make assumptions about its use.
-	 */
-	if (_brk_start)
-		return 0;
-
-	/*
-	 * After brk allocation is complete, space between _brk_end and _end
-	 * is available for allocation.
-	 */
-	return addr >=3D _brk_end && addr < (unsigned long)&_end;
-}
-
 #endif	/* _ASM_X86_SECTIONS_H */
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 111607d91489..957b785d0b59 100644
=2D-- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -819,34 +819,20 @@ static int very_verbose(struct lock_class *class)
  * Is this the address of a static object:
  */
 #ifdef __KERNEL__
-/*
- * Check if an address is part of freed initmem. After initmem is freed,
- * memory can be allocated from it, and such allocations would then have
- * addresses within the range [_stext, _end].
- */
-#ifndef arch_is_kernel_initmem_freed
-static int arch_is_kernel_initmem_freed(unsigned long addr)
-{
-	if (system_state < SYSTEM_FREEING_INITMEM)
-		return 0;
-
-	return init_section_contains((void *)addr, 1);
-}
-#endif
-
 static int static_obj(const void *obj)
 {
-	unsigned long start =3D (unsigned long) &_stext,
-		      end   =3D (unsigned long) &_end,
-		      addr  =3D (unsigned long) obj;
+	unsigned long addr =3D (unsigned long) obj;

-	if (arch_is_kernel_initmem_freed(addr))
-		return 0;
+	if (is_kernel_core_data(addr))
+		return 1;

 	/*
-	 * static variable?
+	 * in initdata section and used during bootup only?
+	 * NOTE: On some platforms the initdata section is
+	 * outside of the _stext ... _end range.
 	 */
-	if ((addr >=3D start) && (addr < end))
+	if (system_state < SYSTEM_FREEING_INITMEM &&
+		init_section_contains((void *)addr, 1))
 		return 1;

 	/*
