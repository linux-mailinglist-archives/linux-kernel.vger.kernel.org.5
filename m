Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497A57D9DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346033AbjJ0QBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjJ0QBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:01:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B23C2;
        Fri, 27 Oct 2023 09:01:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F41C433C7;
        Fri, 27 Oct 2023 16:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698422506;
        bh=Ewm732UumETJoeDvhFzcoS9AqhpoekceUefIzS+yEIc=;
        h=Date:From:To:Cc:Subject:From;
        b=KPD3stQG1yKXSYqloZEYNl8IIE0txhgWuEuZ7JVpnowthsFREFBuH9kIHB49dWwv9
         yu6iZxnIKsGZX0Udk1/MlMBTYCFOpa46bL1WVU2fkvi7898khWYsHpx+5PJ6kotz6I
         xexoj/9stXYkjCTdzJQCGCob/RkjqAM5M+d4A4N7qr8ZZrmZFuQepXciZ/yIKZ9Xfm
         +FjPpJIaFIqePKWjNluTbCGsKmAO5+VhqW8Vs5uZHenu5nqlbyz6g5gVqXmwsqoO+0
         P6h/sRAhVNkMuckIowC/0GRMMgXUZjHbF5RoRnz703d3Ro4yuWl62eyxi3jPzD18co
         iKAEOzsrbGZ2Q==
Date:   Fri, 27 Oct 2023 09:01:44 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Apply a1e2c031ec39 and e32683c6f7d2 to 5.15 and earlier
Message-ID: <20231027160144.GA232578@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1zwnuZMAaNaLvX2m"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1zwnuZMAaNaLvX2m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg and Sasha,

Please consider applying the following mbox files to their respective
stable trees, which contains commit a1e2c031ec39 ("x86/mm: Simplify
RESERVE_BRK()") and commit e32683c6f7d2 ("x86/mm: Fix RESERVE_BRK() for
older binutils"). This resolves a link failure noticed in the Android
trees due to a new diagnostic in ld.lld:

https://github.com/llvm/llvm-project/commit/1981b1b6b92f7579a30c9ed32dbdf3bc749c1b40

  ld.lld: error: relocation refers to a symbol in a discarded section: __brk_reservation_fn_dmi_alloc__
  >>> defined in vmlinux.o
  >>> referenced by ld-temp.o
  >>>               vmlinux.o:(exit_amd_microcode.cfi_jt)

  ld.lld: error: relocation refers to a symbol in a discarded section: __brk_reservation_fn_early_pgt_alloc__
  >>> defined in vmlinux.o
  >>> referenced by ld-temp.o
  >>>               vmlinux.o:(exit_amd_microcode.cfi_jt)

While I think this may be related to Android's downstream use of LTO and
CFI, I see no reason that this could not happen without LTO due to
RESERVE_BRK() prior to those upstream commits residing in the
.discard.text section.

I confirmed they resolve the Android build problem and I did an
ARCH=x86_64 defconfig build and boot test in QEMU and an allmodconfig
build with GCC, which had no regressions.

Cheers,
Nathan

--1zwnuZMAaNaLvX2m
Content-Type: application/mbox
Content-Disposition: attachment; filename="4.14.mbox"
Content-Transfer-Encoding: quoted-printable

=46rom 3e84500d881d306f8ff3b00b14e916ca0cb55238 Mon Sep 17 00:00:00 2001=0A=
=46rom: Josh Poimboeuf <jpoimboe@redhat.com>=0ADate: Fri, 6 May 2022 14:14:=
32 +0200=0ASubject: [PATCH 4.14 1/2] x86/mm: Simplify RESERVE_BRK()=0A=0Aco=
mmit a1e2c031ec3949b8c039b739c0b5bf9c30007b00 upstream.=0A=0ARESERVE_BRK() =
reserves data in the .brk_reservation section.  The data=0Ais initialized t=
o zero, like BSS, so the macro specifies 'nobits' to=0Aprevent the data fro=
m taking up space in the vmlinux binary.  The only=0Away to get the compile=
r to do that (without putting the variable in .bss=0Aproper) is to use inli=
ne asm.=0A=0AThe macro also has a hack which encloses the inline asm in a d=
iscarded=0Afunction, which allows the size to be passed (global inline asm =
doesn't=0Aallow inputs).=0A=0ARemove the need for the discarded function ha=
ck by just stringifying the=0Asize rather than supplying it as an input to =
the inline asm.=0A=0ASigned-off-by: Josh Poimboeuf <jpoimboe@redhat.com>=0A=
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>=0ASigned-off-b=
y: Borislav Petkov <bp@suse.de>=0AReviewed-by: Borislav Petkov <bp@suse.de>=
=0ALink: https://lore.kernel.org/r/20220506121631.133110232@infradead.org=
=0A[nathan: Fix conflict due to lack of 2b6ff7dea670 and 33def8498fdd]=0ASi=
gned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A arch/x86/includ=
e/asm/setup.h | 30 +++++++++++-------------------=0A 1 file changed, 11 ins=
ertions(+), 19 deletions(-)=0A=0Adiff --git a/arch/x86/include/asm/setup.h =
b/arch/x86/include/asm/setup.h=0Aindex ae13bc974416..e1110e2ebc9e 100644=0A=
--- a/arch/x86/include/asm/setup.h=0A+++ b/arch/x86/include/asm/setup.h=0A@=
@ -91,27 +91,19 @@ extern unsigned long _brk_end;=0A void *extend_brk(size_=
t size, size_t align);=0A =0A /*=0A- * Reserve space in the brk section.  T=
he name must be unique within=0A- * the file, and somewhat descriptive.  Th=
e size is in bytes.  Must be=0A- * used at file scope.=0A+ * Reserve space =
in the brk section.  The name must be unique within the file,=0A+ * and som=
ewhat descriptive.  The size is in bytes.=0A  *=0A- * (This uses a temp fun=
ction to wrap the asm so we can pass it the=0A- * size parameter; otherwise=
 we wouldn't be able to.  We can't use a=0A- * "section" attribute on a nor=
mal variable because it always ends up=0A- * being @progbits, which ends up=
 allocating space in the vmlinux=0A- * executable.)=0A+ * The allocation is=
 done using inline asm (rather than using a section=0A+ * attribute on a no=
rmal variable) in order to allow the use of @nobits, so=0A+ * that it doesn=
't take up any space in the vmlinux file.=0A  */=0A-#define RESERVE_BRK(nam=
e,sz)						\=0A-	static void __section(.discard.text) __used notrace		\=0A-=
	__brk_reservation_fn_##name##__(void) {				\=0A-		asm volatile (						\=0A=
-			".pushsection .brk_reservation,\"aw\",@nobits;" \=0A-			".brk." #name "=
:"				\=0A-			" 1:.skip %c0;"					\=0A-			" .size .brk." #name ", . - 1b;"	=
	\=0A-			" .popsection"					\=0A-			: : "i" (sz));					\=0A-	}=0A+#define R=
ESERVE_BRK(name, size)						\=0A+	asm(".pushsection .brk_reservation,\"aw\"=
,@nobits\n\t"		\=0A+	    ".brk." #name ":\n\t"					\=0A+	    ".skip " __str=
ingify(size) "\n\t"				\=0A+	    ".size .brk." #name ", " __stringify(size)=
 "\n\t"		\=0A+	    ".popsection\n\t")=0A =0A /* Helper for reserving space =
for arrays of things */=0A #define RESERVE_BRK_ARRAY(type, name, entries)		=
\=0A=0Abase-commit: 89d93e9d9f32df4b2d7f4ff3bff645f0c7acad35=0A-- =0A2.42.0=
=0A=0A=0AFrom 9be27be873349f37d7ecd5d4864aed00114d8911 Mon Sep 17 00:00:00 =
2001=0AFrom: Josh Poimboeuf <jpoimboe@kernel.org>=0ADate: Thu, 9 Jun 2022 0=
0:17:32 -0700=0ASubject: [PATCH 4.14 2/2] x86/mm: Fix RESERVE_BRK() for old=
er binutils=0A=0Acommit e32683c6f7d22ba624e0bfc58b02cf3348bdca63 upstream.=
=0A=0AWith binutils 2.26, RESERVE_BRK() causes a build failure:=0A=0A  /tmp=
/ccnGOKZ5.s: Assembler messages:=0A  /tmp/ccnGOKZ5.s:98: Error: missing ')'=
=0A  /tmp/ccnGOKZ5.s:98: Error: missing ')'=0A  /tmp/ccnGOKZ5.s:98: Error: =
missing ')'=0A  /tmp/ccnGOKZ5.s:98: Error: junk at end of line, first unrec=
ognized=0A  character is `U'=0A=0AThe problem is this line:=0A=0A  RESERVE_=
BRK(early_pgt_alloc, INIT_PGT_BUF_SIZE)=0A=0ASpecifically, the INIT_PGT_BUF=
_SIZE macro which (via PAGE_SIZE's use=0A_AC()) has a "1UL", which makes ol=
der versions of the assembler unhappy.=0AUnfortunately the _AC() macro does=
n't work for inline asm.=0A=0AInline asm was only needed here to convince t=
he toolchain to add the=0ASTT_NOBITS flag.  However, if a C variable is pla=
ced in a section whose=0Aname is prefixed with ".bss", GCC and Clang automa=
tically set=0ASTT_NOBITS.  In fact, ".bss..page_aligned" already relies on =
this trick.=0A=0ASo fix the build failure (and simplify the macro) by alloc=
ating the=0Avariable in C.=0A=0AAlso, add NOLOAD to the ".brk" output secti=
on clause in the linker=0Ascript.  This is a failsafe in case the ".bss" pr=
efix magic trick ever=0Astops working somehow.  If there's a section type m=
ismatch, the GNU=0Alinker will force the ".brk" output section to be STT_NO=
BITS.  The LLVM=0Alinker will fail with a "section type mismatch" error.=0A=
=0ANote this also changes the name of the variable from .brk.##name to=0A__=
brk_##name.  The variable names aren't actually used anywhere, so it's=0Aha=
rmless.=0A=0AFixes: a1e2c031ec39 ("x86/mm: Simplify RESERVE_BRK()")=0ARepor=
ted-by: Joe Damato <jdamato@fastly.com>=0AReported-by: Byungchul Park <byun=
gchul.park@lge.com>=0ASigned-off-by: Josh Poimboeuf <jpoimboe@kernel.org>=
=0ASigned-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>=0ATested-by=
: Joe Damato <jdamato@fastly.com>=0ALink: https://lore.kernel.org/r/22d07a4=
4c80d8e8e1e82b9a806ddc8c6bbb2606e.1654759036.git.jpoimboe@kernel.org=0A[nat=
han: Fix conflict due to lack of 360db4ace311 and resolve silent=0A        =
 conflict with 360db4ace3117]=0ASigned-off-by: Nathan Chancellor <nathan@ke=
rnel.org>=0A---=0A arch/x86/include/asm/setup.h  | 38 +++++++++++++++++++--=
--------------=0A arch/x86/kernel/vmlinux.lds.S |  4 ++--=0A 2 files change=
d, 23 insertions(+), 19 deletions(-)=0A=0Adiff --git a/arch/x86/include/asm=
/setup.h b/arch/x86/include/asm/setup.h=0Aindex e1110e2ebc9e..e0e6aad9cd51 =
100644=0A--- a/arch/x86/include/asm/setup.h=0A+++ b/arch/x86/include/asm/se=
tup.h=0A@@ -91,19 +91,16 @@ extern unsigned long _brk_end;=0A void *extend_=
brk(size_t size, size_t align);=0A =0A /*=0A- * Reserve space in the brk se=
ction.  The name must be unique within the file,=0A- * and somewhat descrip=
tive.  The size is in bytes.=0A+ * Reserve space in the .brk section, which=
 is a block of memory from which the=0A+ * caller is allowed to allocate ve=
ry early (before even memblock is available)=0A+ * by calling extend_brk().=
  All allocated memory will be eventually converted=0A+ * to memblock.  Any=
 leftover unallocated memory will be freed.=0A  *=0A- * The allocation is d=
one using inline asm (rather than using a section=0A- * attribute on a norm=
al variable) in order to allow the use of @nobits, so=0A- * that it doesn't=
 take up any space in the vmlinux file.=0A+ * The size is in bytes.=0A  */=
=0A-#define RESERVE_BRK(name, size)						\=0A-	asm(".pushsection .brk_reser=
vation,\"aw\",@nobits\n\t"		\=0A-	    ".brk." #name ":\n\t"					\=0A-	    "=
=2Eskip " __stringify(size) "\n\t"				\=0A-	    ".size .brk." #name ", " __=
stringify(size) "\n\t"		\=0A-	    ".popsection\n\t")=0A+#define RESERVE_BRK=
(name, size)					\=0A+	__section(.bss..brk) __aligned(1) __used	\=0A+	stati=
c char __brk_##name[size]=0A =0A /* Helper for reserving space for arrays o=
f things */=0A #define RESERVE_BRK_ARRAY(type, name, entries)		\=0A@@ -121,=
12 +118,19 @@ asmlinkage void __init x86_64_start_reservations(char *real_m=
ode_data);=0A =0A #endif /* __i386__ */=0A #endif /* _SETUP */=0A-#else=0A-=
#define RESERVE_BRK(name,sz)				\=0A-	.pushsection .brk_reservation,"aw",@n=
obits;	\=0A-.brk.name:						\=0A-1:	.skip sz;					\=0A-	.size .brk.name,.-1=
b;				\=0A+=0A+#else  /* __ASSEMBLY */=0A+=0A+.macro __RESERVE_BRK name, si=
ze=0A+	.pushsection .bss..brk, "aw"=0A+SYM_DATA_START(__brk_\name)=0A+	.ski=
p \size=0A+SYM_DATA_END(__brk_\name)=0A 	.popsection=0A+.endm=0A+=0A+#defin=
e RESERVE_BRK(name, size) __RESERVE_BRK name, size=0A+=0A #endif /* __ASSEM=
BLY__ */=0A+=0A #endif /* _ASM_X86_SETUP_H */=0Adiff --git a/arch/x86/kerne=
l/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S=0Aindex d3dc8bc6b3ad..9f1e4=
fe643b5 100644=0A--- a/arch/x86/kernel/vmlinux.lds.S=0A+++ b/arch/x86/kerne=
l/vmlinux.lds.S=0A@@ -359,10 +359,10 @@ SECTIONS=0A 	}=0A =0A 	. =3D ALIGN(=
PAGE_SIZE);=0A-	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {=0A+	.brk (NOLOAD) : A=
T(ADDR(.brk) - LOAD_OFFSET) {=0A 		__brk_base =3D .;=0A 		. +=3D 64 * 1024;=
		/* 64k alignment slop space */=0A-		*(.brk_reservation)	/* areas brk user=
s have reserved */=0A+		*(.bss..brk)		/* areas brk users have reserved */=
=0A 		__brk_limit =3D .;=0A 	}=0A =0A-- =0A2.42.0=0A=0A
--1zwnuZMAaNaLvX2m
Content-Type: application/mbox
Content-Disposition: attachment; filename="4.19.mbox"
Content-Transfer-Encoding: quoted-printable

=46rom a210bdbea666487df5665a541554374bdfa9833a Mon Sep 17 00:00:00 2001=0A=
=46rom: Josh Poimboeuf <jpoimboe@redhat.com>=0ADate: Fri, 6 May 2022 14:14:=
32 +0200=0ASubject: [PATCH 4.19 1/2] x86/mm: Simplify RESERVE_BRK()=0A=0Aco=
mmit a1e2c031ec3949b8c039b739c0b5bf9c30007b00 upstream.=0A=0ARESERVE_BRK() =
reserves data in the .brk_reservation section.  The data=0Ais initialized t=
o zero, like BSS, so the macro specifies 'nobits' to=0Aprevent the data fro=
m taking up space in the vmlinux binary.  The only=0Away to get the compile=
r to do that (without putting the variable in .bss=0Aproper) is to use inli=
ne asm.=0A=0AThe macro also has a hack which encloses the inline asm in a d=
iscarded=0Afunction, which allows the size to be passed (global inline asm =
doesn't=0Aallow inputs).=0A=0ARemove the need for the discarded function ha=
ck by just stringifying the=0Asize rather than supplying it as an input to =
the inline asm.=0A=0ASigned-off-by: Josh Poimboeuf <jpoimboe@redhat.com>=0A=
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>=0ASigned-off-b=
y: Borislav Petkov <bp@suse.de>=0AReviewed-by: Borislav Petkov <bp@suse.de>=
=0ALink: https://lore.kernel.org/r/20220506121631.133110232@infradead.org=
=0A[nathan: Fix conflict due to lack of 2b6ff7dea670 and 33def8498fdd]=0ASi=
gned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A arch/x86/includ=
e/asm/setup.h | 30 +++++++++++-------------------=0A 1 file changed, 11 ins=
ertions(+), 19 deletions(-)=0A=0Adiff --git a/arch/x86/include/asm/setup.h =
b/arch/x86/include/asm/setup.h=0Aindex ae13bc974416..e1110e2ebc9e 100644=0A=
--- a/arch/x86/include/asm/setup.h=0A+++ b/arch/x86/include/asm/setup.h=0A@=
@ -91,27 +91,19 @@ extern unsigned long _brk_end;=0A void *extend_brk(size_=
t size, size_t align);=0A =0A /*=0A- * Reserve space in the brk section.  T=
he name must be unique within=0A- * the file, and somewhat descriptive.  Th=
e size is in bytes.  Must be=0A- * used at file scope.=0A+ * Reserve space =
in the brk section.  The name must be unique within the file,=0A+ * and som=
ewhat descriptive.  The size is in bytes.=0A  *=0A- * (This uses a temp fun=
ction to wrap the asm so we can pass it the=0A- * size parameter; otherwise=
 we wouldn't be able to.  We can't use a=0A- * "section" attribute on a nor=
mal variable because it always ends up=0A- * being @progbits, which ends up=
 allocating space in the vmlinux=0A- * executable.)=0A+ * The allocation is=
 done using inline asm (rather than using a section=0A+ * attribute on a no=
rmal variable) in order to allow the use of @nobits, so=0A+ * that it doesn=
't take up any space in the vmlinux file.=0A  */=0A-#define RESERVE_BRK(nam=
e,sz)						\=0A-	static void __section(.discard.text) __used notrace		\=0A-=
	__brk_reservation_fn_##name##__(void) {				\=0A-		asm volatile (						\=0A=
-			".pushsection .brk_reservation,\"aw\",@nobits;" \=0A-			".brk." #name "=
:"				\=0A-			" 1:.skip %c0;"					\=0A-			" .size .brk." #name ", . - 1b;"	=
	\=0A-			" .popsection"					\=0A-			: : "i" (sz));					\=0A-	}=0A+#define R=
ESERVE_BRK(name, size)						\=0A+	asm(".pushsection .brk_reservation,\"aw\"=
,@nobits\n\t"		\=0A+	    ".brk." #name ":\n\t"					\=0A+	    ".skip " __str=
ingify(size) "\n\t"				\=0A+	    ".size .brk." #name ", " __stringify(size)=
 "\n\t"		\=0A+	    ".popsection\n\t")=0A =0A /* Helper for reserving space =
for arrays of things */=0A #define RESERVE_BRK_ARRAY(type, name, entries)		=
\=0A=0Abase-commit: 4a82dfcb8b4d07331d1db05a36f7d87013787e9e=0A-- =0A2.42.0=
=0A=0A=0AFrom 274836aec5aff770ee29608d8c8e2279c07c6b0d Mon Sep 17 00:00:00 =
2001=0AFrom: Josh Poimboeuf <jpoimboe@kernel.org>=0ADate: Thu, 9 Jun 2022 0=
0:17:32 -0700=0ASubject: [PATCH 4.19 2/2] x86/mm: Fix RESERVE_BRK() for old=
er binutils=0A=0Acommit e32683c6f7d22ba624e0bfc58b02cf3348bdca63 upstream.=
=0A=0AWith binutils 2.26, RESERVE_BRK() causes a build failure:=0A=0A  /tmp=
/ccnGOKZ5.s: Assembler messages:=0A  /tmp/ccnGOKZ5.s:98: Error: missing ')'=
=0A  /tmp/ccnGOKZ5.s:98: Error: missing ')'=0A  /tmp/ccnGOKZ5.s:98: Error: =
missing ')'=0A  /tmp/ccnGOKZ5.s:98: Error: junk at end of line, first unrec=
ognized=0A  character is `U'=0A=0AThe problem is this line:=0A=0A  RESERVE_=
BRK(early_pgt_alloc, INIT_PGT_BUF_SIZE)=0A=0ASpecifically, the INIT_PGT_BUF=
_SIZE macro which (via PAGE_SIZE's use=0A_AC()) has a "1UL", which makes ol=
der versions of the assembler unhappy.=0AUnfortunately the _AC() macro does=
n't work for inline asm.=0A=0AInline asm was only needed here to convince t=
he toolchain to add the=0ASTT_NOBITS flag.  However, if a C variable is pla=
ced in a section whose=0Aname is prefixed with ".bss", GCC and Clang automa=
tically set=0ASTT_NOBITS.  In fact, ".bss..page_aligned" already relies on =
this trick.=0A=0ASo fix the build failure (and simplify the macro) by alloc=
ating the=0Avariable in C.=0A=0AAlso, add NOLOAD to the ".brk" output secti=
on clause in the linker=0Ascript.  This is a failsafe in case the ".bss" pr=
efix magic trick ever=0Astops working somehow.  If there's a section type m=
ismatch, the GNU=0Alinker will force the ".brk" output section to be STT_NO=
BITS.  The LLVM=0Alinker will fail with a "section type mismatch" error.=0A=
=0ANote this also changes the name of the variable from .brk.##name to=0A__=
brk_##name.  The variable names aren't actually used anywhere, so it's=0Aha=
rmless.=0A=0AFixes: a1e2c031ec39 ("x86/mm: Simplify RESERVE_BRK()")=0ARepor=
ted-by: Joe Damato <jdamato@fastly.com>=0AReported-by: Byungchul Park <byun=
gchul.park@lge.com>=0ASigned-off-by: Josh Poimboeuf <jpoimboe@kernel.org>=
=0ASigned-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>=0ATested-by=
: Joe Damato <jdamato@fastly.com>=0ALink: https://lore.kernel.org/r/22d07a4=
4c80d8e8e1e82b9a806ddc8c6bbb2606e.1654759036.git.jpoimboe@kernel.org=0A[nat=
han: Fix conflict due to lack of 360db4ace311 and resolve silent=0A        =
 conflict with 360db4ace3117]=0ASigned-off-by: Nathan Chancellor <nathan@ke=
rnel.org>=0A---=0A arch/x86/include/asm/setup.h  | 38 +++++++++++++++++++--=
--------------=0A arch/x86/kernel/vmlinux.lds.S |  4 ++--=0A 2 files change=
d, 23 insertions(+), 19 deletions(-)=0A=0Adiff --git a/arch/x86/include/asm=
/setup.h b/arch/x86/include/asm/setup.h=0Aindex e1110e2ebc9e..e0e6aad9cd51 =
100644=0A--- a/arch/x86/include/asm/setup.h=0A+++ b/arch/x86/include/asm/se=
tup.h=0A@@ -91,19 +91,16 @@ extern unsigned long _brk_end;=0A void *extend_=
brk(size_t size, size_t align);=0A =0A /*=0A- * Reserve space in the brk se=
ction.  The name must be unique within the file,=0A- * and somewhat descrip=
tive.  The size is in bytes.=0A+ * Reserve space in the .brk section, which=
 is a block of memory from which the=0A+ * caller is allowed to allocate ve=
ry early (before even memblock is available)=0A+ * by calling extend_brk().=
  All allocated memory will be eventually converted=0A+ * to memblock.  Any=
 leftover unallocated memory will be freed.=0A  *=0A- * The allocation is d=
one using inline asm (rather than using a section=0A- * attribute on a norm=
al variable) in order to allow the use of @nobits, so=0A- * that it doesn't=
 take up any space in the vmlinux file.=0A+ * The size is in bytes.=0A  */=
=0A-#define RESERVE_BRK(name, size)						\=0A-	asm(".pushsection .brk_reser=
vation,\"aw\",@nobits\n\t"		\=0A-	    ".brk." #name ":\n\t"					\=0A-	    "=
=2Eskip " __stringify(size) "\n\t"				\=0A-	    ".size .brk." #name ", " __=
stringify(size) "\n\t"		\=0A-	    ".popsection\n\t")=0A+#define RESERVE_BRK=
(name, size)					\=0A+	__section(.bss..brk) __aligned(1) __used	\=0A+	stati=
c char __brk_##name[size]=0A =0A /* Helper for reserving space for arrays o=
f things */=0A #define RESERVE_BRK_ARRAY(type, name, entries)		\=0A@@ -121,=
12 +118,19 @@ asmlinkage void __init x86_64_start_reservations(char *real_m=
ode_data);=0A =0A #endif /* __i386__ */=0A #endif /* _SETUP */=0A-#else=0A-=
#define RESERVE_BRK(name,sz)				\=0A-	.pushsection .brk_reservation,"aw",@n=
obits;	\=0A-.brk.name:						\=0A-1:	.skip sz;					\=0A-	.size .brk.name,.-1=
b;				\=0A+=0A+#else  /* __ASSEMBLY */=0A+=0A+.macro __RESERVE_BRK name, si=
ze=0A+	.pushsection .bss..brk, "aw"=0A+SYM_DATA_START(__brk_\name)=0A+	.ski=
p \size=0A+SYM_DATA_END(__brk_\name)=0A 	.popsection=0A+.endm=0A+=0A+#defin=
e RESERVE_BRK(name, size) __RESERVE_BRK name, size=0A+=0A #endif /* __ASSEM=
BLY__ */=0A+=0A #endif /* _ASM_X86_SETUP_H */=0Adiff --git a/arch/x86/kerne=
l/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S=0Aindex 34c0652ca8b4..7e12b=
7d93b72 100644=0A--- a/arch/x86/kernel/vmlinux.lds.S=0A+++ b/arch/x86/kerne=
l/vmlinux.lds.S=0A@@ -380,10 +380,10 @@ SECTIONS=0A 	}=0A =0A 	. =3D ALIGN(=
PAGE_SIZE);=0A-	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {=0A+	.brk (NOLOAD) : A=
T(ADDR(.brk) - LOAD_OFFSET) {=0A 		__brk_base =3D .;=0A 		. +=3D 64 * 1024;=
		/* 64k alignment slop space */=0A-		*(.brk_reservation)	/* areas brk user=
s have reserved */=0A+		*(.bss..brk)		/* areas brk users have reserved */=
=0A 		__brk_limit =3D .;=0A 	}=0A =0A-- =0A2.42.0=0A=0A
--1zwnuZMAaNaLvX2m
Content-Type: application/mbox
Content-Disposition: attachment; filename="5.4.mbox"
Content-Transfer-Encoding: quoted-printable

=46rom ce59f44f17050137345e85d6066c94fc7b19f4da Mon Sep 17 00:00:00 2001=0A=
=46rom: Josh Poimboeuf <jpoimboe@redhat.com>=0ADate: Fri, 6 May 2022 14:14:=
32 +0200=0ASubject: [PATCH 5.4 1/2] x86/mm: Simplify RESERVE_BRK()=0A=0Acom=
mit a1e2c031ec3949b8c039b739c0b5bf9c30007b00 upstream.=0A=0ARESERVE_BRK() r=
eserves data in the .brk_reservation section.  The data=0Ais initialized to=
 zero, like BSS, so the macro specifies 'nobits' to=0Aprevent the data from=
 taking up space in the vmlinux binary.  The only=0Away to get the compiler=
 to do that (without putting the variable in .bss=0Aproper) is to use inlin=
e asm.=0A=0AThe macro also has a hack which encloses the inline asm in a di=
scarded=0Afunction, which allows the size to be passed (global inline asm d=
oesn't=0Aallow inputs).=0A=0ARemove the need for the discarded function hac=
k by just stringifying the=0Asize rather than supplying it as an input to t=
he inline asm.=0A=0ASigned-off-by: Josh Poimboeuf <jpoimboe@redhat.com>=0AS=
igned-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>=0ASigned-off-by=
: Borislav Petkov <bp@suse.de>=0AReviewed-by: Borislav Petkov <bp@suse.de>=
=0ALink: https://lore.kernel.org/r/20220506121631.133110232@infradead.org=
=0A[nathan: Fix conflict due to lack of 2b6ff7dea670 and 33def8498fdd]=0ASi=
gned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A arch/x86/includ=
e/asm/setup.h | 30 +++++++++++-------------------=0A 1 file changed, 11 ins=
ertions(+), 19 deletions(-)=0A=0Adiff --git a/arch/x86/include/asm/setup.h =
b/arch/x86/include/asm/setup.h=0Aindex ed8ec011a9fd..58cfd5bd209a 100644=0A=
--- a/arch/x86/include/asm/setup.h=0A+++ b/arch/x86/include/asm/setup.h=0A@=
@ -94,27 +94,19 @@ extern unsigned long _brk_end;=0A void *extend_brk(size_=
t size, size_t align);=0A =0A /*=0A- * Reserve space in the brk section.  T=
he name must be unique within=0A- * the file, and somewhat descriptive.  Th=
e size is in bytes.  Must be=0A- * used at file scope.=0A+ * Reserve space =
in the brk section.  The name must be unique within the file,=0A+ * and som=
ewhat descriptive.  The size is in bytes.=0A  *=0A- * (This uses a temp fun=
ction to wrap the asm so we can pass it the=0A- * size parameter; otherwise=
 we wouldn't be able to.  We can't use a=0A- * "section" attribute on a nor=
mal variable because it always ends up=0A- * being @progbits, which ends up=
 allocating space in the vmlinux=0A- * executable.)=0A+ * The allocation is=
 done using inline asm (rather than using a section=0A+ * attribute on a no=
rmal variable) in order to allow the use of @nobits, so=0A+ * that it doesn=
't take up any space in the vmlinux file.=0A  */=0A-#define RESERVE_BRK(nam=
e,sz)						\=0A-	static void __section(.discard.text) __used notrace		\=0A-=
	__brk_reservation_fn_##name##__(void) {				\=0A-		asm volatile (						\=0A=
-			".pushsection .brk_reservation,\"aw\",@nobits;" \=0A-			".brk." #name "=
:"				\=0A-			" 1:.skip %c0;"					\=0A-			" .size .brk." #name ", . - 1b;"	=
	\=0A-			" .popsection"					\=0A-			: : "i" (sz));					\=0A-	}=0A+#define R=
ESERVE_BRK(name, size)						\=0A+	asm(".pushsection .brk_reservation,\"aw\"=
,@nobits\n\t"		\=0A+	    ".brk." #name ":\n\t"					\=0A+	    ".skip " __str=
ingify(size) "\n\t"				\=0A+	    ".size .brk." #name ", " __stringify(size)=
 "\n\t"		\=0A+	    ".popsection\n\t")=0A =0A /* Helper for reserving space =
for arrays of things */=0A #define RESERVE_BRK_ARRAY(type, name, entries)		=
\=0A=0Abase-commit: 86ea40e6ad22d9d7daa54b9e8167ad1e4a8a48ee=0A-- =0A2.42.0=
=0A=0A=0AFrom aecb8b77bd7ab9befb1353d27b48e12eaabd5e71 Mon Sep 17 00:00:00 =
2001=0AFrom: Josh Poimboeuf <jpoimboe@kernel.org>=0ADate: Thu, 9 Jun 2022 0=
0:17:32 -0700=0ASubject: [PATCH 5.4 2/2] x86/mm: Fix RESERVE_BRK() for olde=
r binutils=0A=0Acommit e32683c6f7d22ba624e0bfc58b02cf3348bdca63 upstream.=
=0A=0AWith binutils 2.26, RESERVE_BRK() causes a build failure:=0A=0A  /tmp=
/ccnGOKZ5.s: Assembler messages:=0A  /tmp/ccnGOKZ5.s:98: Error: missing ')'=
=0A  /tmp/ccnGOKZ5.s:98: Error: missing ')'=0A  /tmp/ccnGOKZ5.s:98: Error: =
missing ')'=0A  /tmp/ccnGOKZ5.s:98: Error: junk at end of line, first unrec=
ognized=0A  character is `U'=0A=0AThe problem is this line:=0A=0A  RESERVE_=
BRK(early_pgt_alloc, INIT_PGT_BUF_SIZE)=0A=0ASpecifically, the INIT_PGT_BUF=
_SIZE macro which (via PAGE_SIZE's use=0A_AC()) has a "1UL", which makes ol=
der versions of the assembler unhappy.=0AUnfortunately the _AC() macro does=
n't work for inline asm.=0A=0AInline asm was only needed here to convince t=
he toolchain to add the=0ASTT_NOBITS flag.  However, if a C variable is pla=
ced in a section whose=0Aname is prefixed with ".bss", GCC and Clang automa=
tically set=0ASTT_NOBITS.  In fact, ".bss..page_aligned" already relies on =
this trick.=0A=0ASo fix the build failure (and simplify the macro) by alloc=
ating the=0Avariable in C.=0A=0AAlso, add NOLOAD to the ".brk" output secti=
on clause in the linker=0Ascript.  This is a failsafe in case the ".bss" pr=
efix magic trick ever=0Astops working somehow.  If there's a section type m=
ismatch, the GNU=0Alinker will force the ".brk" output section to be STT_NO=
BITS.  The LLVM=0Alinker will fail with a "section type mismatch" error.=0A=
=0ANote this also changes the name of the variable from .brk.##name to=0A__=
brk_##name.  The variable names aren't actually used anywhere, so it's=0Aha=
rmless.=0A=0AFixes: a1e2c031ec39 ("x86/mm: Simplify RESERVE_BRK()")=0ARepor=
ted-by: Joe Damato <jdamato@fastly.com>=0AReported-by: Byungchul Park <byun=
gchul.park@lge.com>=0ASigned-off-by: Josh Poimboeuf <jpoimboe@kernel.org>=
=0ASigned-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>=0ATested-by=
: Joe Damato <jdamato@fastly.com>=0ALink: https://lore.kernel.org/r/22d07a4=
4c80d8e8e1e82b9a806ddc8c6bbb2606e.1654759036.git.jpoimboe@kernel.org=0A[nat=
han: Fix conflict due to lack of 360db4ace311 and resolve silent=0A        =
 conflict with 360db4ace3117]=0ASigned-off-by: Nathan Chancellor <nathan@ke=
rnel.org>=0A---=0A arch/x86/include/asm/setup.h  | 38 +++++++++++++++++++--=
--------------=0A arch/x86/kernel/vmlinux.lds.S |  4 ++--=0A 2 files change=
d, 23 insertions(+), 19 deletions(-)=0A=0Adiff --git a/arch/x86/include/asm=
/setup.h b/arch/x86/include/asm/setup.h=0Aindex 58cfd5bd209a..e832082b2761 =
100644=0A--- a/arch/x86/include/asm/setup.h=0A+++ b/arch/x86/include/asm/se=
tup.h=0A@@ -94,19 +94,16 @@ extern unsigned long _brk_end;=0A void *extend_=
brk(size_t size, size_t align);=0A =0A /*=0A- * Reserve space in the brk se=
ction.  The name must be unique within the file,=0A- * and somewhat descrip=
tive.  The size is in bytes.=0A+ * Reserve space in the .brk section, which=
 is a block of memory from which the=0A+ * caller is allowed to allocate ve=
ry early (before even memblock is available)=0A+ * by calling extend_brk().=
  All allocated memory will be eventually converted=0A+ * to memblock.  Any=
 leftover unallocated memory will be freed.=0A  *=0A- * The allocation is d=
one using inline asm (rather than using a section=0A- * attribute on a norm=
al variable) in order to allow the use of @nobits, so=0A- * that it doesn't=
 take up any space in the vmlinux file.=0A+ * The size is in bytes.=0A  */=
=0A-#define RESERVE_BRK(name, size)						\=0A-	asm(".pushsection .brk_reser=
vation,\"aw\",@nobits\n\t"		\=0A-	    ".brk." #name ":\n\t"					\=0A-	    "=
=2Eskip " __stringify(size) "\n\t"				\=0A-	    ".size .brk." #name ", " __=
stringify(size) "\n\t"		\=0A-	    ".popsection\n\t")=0A+#define RESERVE_BRK=
(name, size)					\=0A+	__section(.bss..brk) __aligned(1) __used	\=0A+	stati=
c char __brk_##name[size]=0A =0A /* Helper for reserving space for arrays o=
f things */=0A #define RESERVE_BRK_ARRAY(type, name, entries)		\=0A@@ -124,=
12 +121,19 @@ asmlinkage void __init x86_64_start_reservations(char *real_m=
ode_data);=0A =0A #endif /* __i386__ */=0A #endif /* _SETUP */=0A-#else=0A-=
#define RESERVE_BRK(name,sz)				\=0A-	.pushsection .brk_reservation,"aw",@n=
obits;	\=0A-.brk.name:						\=0A-1:	.skip sz;					\=0A-	.size .brk.name,.-1=
b;				\=0A+=0A+#else  /* __ASSEMBLY */=0A+=0A+.macro __RESERVE_BRK name, si=
ze=0A+	.pushsection .bss..brk, "aw"=0A+SYM_DATA_START(__brk_\name)=0A+	.ski=
p \size=0A+SYM_DATA_END(__brk_\name)=0A 	.popsection=0A+.endm=0A+=0A+#defin=
e RESERVE_BRK(name, size) __RESERVE_BRK name, size=0A+=0A #endif /* __ASSEM=
BLY__ */=0A+=0A #endif /* _ASM_X86_SETUP_H */=0Adiff --git a/arch/x86/kerne=
l/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S=0Aindex 7e0e21082c93..d9453=
c793570 100644=0A--- a/arch/x86/kernel/vmlinux.lds.S=0A+++ b/arch/x86/kerne=
l/vmlinux.lds.S=0A@@ -380,10 +380,10 @@ SECTIONS=0A 	__end_of_kernel_reserv=
e =3D .;=0A =0A 	. =3D ALIGN(PAGE_SIZE);=0A-	.brk : AT(ADDR(.brk) - LOAD_OF=
FSET) {=0A+	.brk (NOLOAD) : AT(ADDR(.brk) - LOAD_OFFSET) {=0A 		__brk_base =
=3D .;=0A 		. +=3D 64 * 1024;		/* 64k alignment slop space */=0A-		*(.brk_r=
eservation)	/* areas brk users have reserved */=0A+		*(.bss..brk)		/* areas=
 brk users have reserved */=0A 		__brk_limit =3D .;=0A 	}=0A =0A-- =0A2.42.=
0=0A=0A
--1zwnuZMAaNaLvX2m
Content-Type: application/mbox
Content-Disposition: attachment; filename="5.10.mbox"
Content-Transfer-Encoding: quoted-printable

=46rom 41644eb4c9029f7f916c6181fba20b30f3d796a6 Mon Sep 17 00:00:00 2001=0A=
=46rom: Josh Poimboeuf <jpoimboe@redhat.com>=0ADate: Fri, 6 May 2022 14:14:=
32 +0200=0ASubject: [PATCH 5.10 1/2] x86/mm: Simplify RESERVE_BRK()=0A=0Aco=
mmit a1e2c031ec3949b8c039b739c0b5bf9c30007b00 upstream.=0A=0ARESERVE_BRK() =
reserves data in the .brk_reservation section.  The data=0Ais initialized t=
o zero, like BSS, so the macro specifies 'nobits' to=0Aprevent the data fro=
m taking up space in the vmlinux binary.  The only=0Away to get the compile=
r to do that (without putting the variable in .bss=0Aproper) is to use inli=
ne asm.=0A=0AThe macro also has a hack which encloses the inline asm in a d=
iscarded=0Afunction, which allows the size to be passed (global inline asm =
doesn't=0Aallow inputs).=0A=0ARemove the need for the discarded function ha=
ck by just stringifying the=0Asize rather than supplying it as an input to =
the inline asm.=0A=0ASigned-off-by: Josh Poimboeuf <jpoimboe@redhat.com>=0A=
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>=0ASigned-off-b=
y: Borislav Petkov <bp@suse.de>=0AReviewed-by: Borislav Petkov <bp@suse.de>=
=0ALink: https://lore.kernel.org/r/20220506121631.133110232@infradead.org=
=0A[nathan: Resolve conflict due to lack of 2b6ff7dea670]=0ASigned-off-by: =
Nathan Chancellor <nathan@kernel.org>=0A---=0A arch/x86/include/asm/setup.h=
 | 30 +++++++++++-------------------=0A 1 file changed, 11 insertions(+), 1=
9 deletions(-)=0A=0Adiff --git a/arch/x86/include/asm/setup.h b/arch/x86/in=
clude/asm/setup.h=0Aindex 389d851a02c4..f0aa958bccbe 100644=0A--- a/arch/x8=
6/include/asm/setup.h=0A+++ b/arch/x86/include/asm/setup.h=0A@@ -108,27 +10=
8,19 @@ extern unsigned long _brk_end;=0A void *extend_brk(size_t size, siz=
e_t align);=0A =0A /*=0A- * Reserve space in the brk section.  The name mus=
t be unique within=0A- * the file, and somewhat descriptive.  The size is i=
n bytes.  Must be=0A- * used at file scope.=0A+ * Reserve space in the brk =
section.  The name must be unique within the file,=0A+ * and somewhat descr=
iptive.  The size is in bytes.=0A  *=0A- * (This uses a temp function to wr=
ap the asm so we can pass it the=0A- * size parameter; otherwise we wouldn'=
t be able to.  We can't use a=0A- * "section" attribute on a normal variabl=
e because it always ends up=0A- * being @progbits, which ends up allocating=
 space in the vmlinux=0A- * executable.)=0A+ * The allocation is done using=
 inline asm (rather than using a section=0A+ * attribute on a normal variab=
le) in order to allow the use of @nobits, so=0A+ * that it doesn't take up =
any space in the vmlinux file.=0A  */=0A-#define RESERVE_BRK(name,sz)						=
\=0A-	static void __section(".discard.text") __used notrace		\=0A-	__brk_re=
servation_fn_##name##__(void) {				\=0A-		asm volatile (						\=0A-			".pus=
hsection .brk_reservation,\"aw\",@nobits;" \=0A-			".brk." #name ":"				\=
=0A-			" 1:.skip %c0;"					\=0A-			" .size .brk." #name ", . - 1b;"		\=0A-	=
		" .popsection"					\=0A-			: : "i" (sz));					\=0A-	}=0A+#define RESERVE_=
BRK(name, size)						\=0A+	asm(".pushsection .brk_reservation,\"aw\",@nobit=
s\n\t"		\=0A+	    ".brk." #name ":\n\t"					\=0A+	    ".skip " __stringify(=
size) "\n\t"				\=0A+	    ".size .brk." #name ", " __stringify(size) "\n\t"=
		\=0A+	    ".popsection\n\t")=0A =0A /* Helper for reserving space for arr=
ays of things */=0A #define RESERVE_BRK_ARRAY(type, name, entries)		\=0A=0A=
base-commit: cb49f0e441ce7db63ef67ccfa9d9562c22f5d6c3=0A-- =0A2.42.0=0A=0A=
=0AFrom 9ebc163ce50160e21c649a0ae74e44d3998049df Mon Sep 17 00:00:00 2001=
=0AFrom: Josh Poimboeuf <jpoimboe@kernel.org>=0ADate: Thu, 9 Jun 2022 00:17=
:32 -0700=0ASubject: [PATCH 5.10 2/2] x86/mm: Fix RESERVE_BRK() for older b=
inutils=0A=0Acommit e32683c6f7d22ba624e0bfc58b02cf3348bdca63 upstream.=0A=
=0AWith binutils 2.26, RESERVE_BRK() causes a build failure:=0A=0A  /tmp/cc=
nGOKZ5.s: Assembler messages:=0A  /tmp/ccnGOKZ5.s:98: Error: missing ')'=0A=
  /tmp/ccnGOKZ5.s:98: Error: missing ')'=0A  /tmp/ccnGOKZ5.s:98: Error: mis=
sing ')'=0A  /tmp/ccnGOKZ5.s:98: Error: junk at end of line, first unrecogn=
ized=0A  character is `U'=0A=0AThe problem is this line:=0A=0A  RESERVE_BRK=
(early_pgt_alloc, INIT_PGT_BUF_SIZE)=0A=0ASpecifically, the INIT_PGT_BUF_SI=
ZE macro which (via PAGE_SIZE's use=0A_AC()) has a "1UL", which makes older=
 versions of the assembler unhappy.=0AUnfortunately the _AC() macro doesn't=
 work for inline asm.=0A=0AInline asm was only needed here to convince the =
toolchain to add the=0ASTT_NOBITS flag.  However, if a C variable is placed=
 in a section whose=0Aname is prefixed with ".bss", GCC and Clang automatic=
ally set=0ASTT_NOBITS.  In fact, ".bss..page_aligned" already relies on thi=
s trick.=0A=0ASo fix the build failure (and simplify the macro) by allocati=
ng the=0Avariable in C.=0A=0AAlso, add NOLOAD to the ".brk" output section =
clause in the linker=0Ascript.  This is a failsafe in case the ".bss" prefi=
x magic trick ever=0Astops working somehow.  If there's a section type mism=
atch, the GNU=0Alinker will force the ".brk" output section to be STT_NOBIT=
S.  The LLVM=0Alinker will fail with a "section type mismatch" error.=0A=0A=
Note this also changes the name of the variable from .brk.##name to=0A__brk=
_##name.  The variable names aren't actually used anywhere, so it's=0Aharml=
ess.=0A=0AFixes: a1e2c031ec39 ("x86/mm: Simplify RESERVE_BRK()")=0AReported=
-by: Joe Damato <jdamato@fastly.com>=0AReported-by: Byungchul Park <byungch=
ul.park@lge.com>=0ASigned-off-by: Josh Poimboeuf <jpoimboe@kernel.org>=0ASi=
gned-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>=0ATested-by: Joe=
 Damato <jdamato@fastly.com>=0ALink: https://lore.kernel.org/r/22d07a44c80d=
8e8e1e82b9a806ddc8c6bbb2606e.1654759036.git.jpoimboe@kernel.org=0A[nathan: =
Fix trivial conflict due to lack of 81519f778830]=0ASigned-off-by: Nathan C=
hancellor <nathan@kernel.org>=0A---=0A arch/x86/include/asm/setup.h  | 38 +=
++++++++++++++++++----------------=0A arch/x86/kernel/setup.c       |  5 --=
---=0A arch/x86/kernel/vmlinux.lds.S |  4 ++--=0A 3 files changed, 23 inser=
tions(+), 24 deletions(-)=0A=0Adiff --git a/arch/x86/include/asm/setup.h b/=
arch/x86/include/asm/setup.h=0Aindex f0aa958bccbe..4e1757bf66a8 100644=0A--=
- a/arch/x86/include/asm/setup.h=0A+++ b/arch/x86/include/asm/setup.h=0A@@ =
-108,19 +108,16 @@ extern unsigned long _brk_end;=0A void *extend_brk(size_=
t size, size_t align);=0A =0A /*=0A- * Reserve space in the brk section.  T=
he name must be unique within the file,=0A- * and somewhat descriptive.  Th=
e size is in bytes.=0A+ * Reserve space in the .brk section, which is a blo=
ck of memory from which the=0A+ * caller is allowed to allocate very early =
(before even memblock is available)=0A+ * by calling extend_brk().  All all=
ocated memory will be eventually converted=0A+ * to memblock.  Any leftover=
 unallocated memory will be freed.=0A  *=0A- * The allocation is done using=
 inline asm (rather than using a section=0A- * attribute on a normal variab=
le) in order to allow the use of @nobits, so=0A- * that it doesn't take up =
any space in the vmlinux file.=0A+ * The size is in bytes.=0A  */=0A-#defin=
e RESERVE_BRK(name, size)						\=0A-	asm(".pushsection .brk_reservation,\"a=
w\",@nobits\n\t"		\=0A-	    ".brk." #name ":\n\t"					\=0A-	    ".skip " __=
stringify(size) "\n\t"				\=0A-	    ".size .brk." #name ", " __stringify(si=
ze) "\n\t"		\=0A-	    ".popsection\n\t")=0A+#define RESERVE_BRK(name, size)=
					\=0A+	__section(".bss..brk") __aligned(1) __used	\=0A+	static char __b=
rk_##name[size]=0A =0A /* Helper for reserving space for arrays of things *=
/=0A #define RESERVE_BRK_ARRAY(type, name, entries)		\=0A@@ -138,12 +135,19=
 @@ asmlinkage void __init x86_64_start_reservations(char *real_mode_data);=
=0A =0A #endif /* __i386__ */=0A #endif /* _SETUP */=0A-#else=0A-#define RE=
SERVE_BRK(name,sz)				\=0A-	.pushsection .brk_reservation,"aw",@nobits;	\=
=0A-.brk.name:						\=0A-1:	.skip sz;					\=0A-	.size .brk.name,.-1b;				\=
=0A+=0A+#else  /* __ASSEMBLY */=0A+=0A+.macro __RESERVE_BRK name, size=0A+	=
=2Epushsection .bss..brk, "aw"=0A+SYM_DATA_START(__brk_\name)=0A+	.skip \si=
ze=0A+SYM_DATA_END(__brk_\name)=0A 	.popsection=0A+.endm=0A+=0A+#define RES=
ERVE_BRK(name, size) __RESERVE_BRK name, size=0A+=0A #endif /* __ASSEMBLY__=
 */=0A+=0A #endif /* _ASM_X86_SETUP_H */=0Adiff --git a/arch/x86/kernel/set=
up.c b/arch/x86/kernel/setup.c=0Aindex 065152d9265e..e9b483c6f413 100644=0A=
--- a/arch/x86/kernel/setup.c=0A+++ b/arch/x86/kernel/setup.c=0A@@ -64,11 +=
64,6 @@ RESERVE_BRK(dmi_alloc, 65536);=0A #endif=0A =0A =0A-/*=0A- * Range =
of the BSS area. The size of the BSS area is determined=0A- * at link time,=
 with RESERVE_BRK*() facility reserving additional=0A- * chunks.=0A- */=0A =
unsigned long _brk_start =3D (unsigned long)__brk_base;=0A unsigned long _b=
rk_end   =3D (unsigned long)__brk_base;=0A =0Adiff --git a/arch/x86/kernel/=
vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S=0Aindex f0d4500ae77a..d685369=
fd30a 100644=0A--- a/arch/x86/kernel/vmlinux.lds.S=0A+++ b/arch/x86/kernel/=
vmlinux.lds.S=0A@@ -411,10 +411,10 @@ SECTIONS=0A 	__end_of_kernel_reserve =
=3D .;=0A =0A 	. =3D ALIGN(PAGE_SIZE);=0A-	.brk : AT(ADDR(.brk) - LOAD_OFFS=
ET) {=0A+	.brk (NOLOAD) : AT(ADDR(.brk) - LOAD_OFFSET) {=0A 		__brk_base =
=3D .;=0A 		. +=3D 64 * 1024;		/* 64k alignment slop space */=0A-		*(.brk_r=
eservation)	/* areas brk users have reserved */=0A+		*(.bss..brk)		/* areas=
 brk users have reserved */=0A 		__brk_limit =3D .;=0A 	}=0A =0A-- =0A2.42.=
0=0A=0A
--1zwnuZMAaNaLvX2m
Content-Type: application/mbox
Content-Disposition: attachment; filename="5.15.mbox"
Content-Transfer-Encoding: quoted-printable

=46rom 069f622c5d827be25cdf13e300fc4c4b0c97f997 Mon Sep 17 00:00:00 2001=0A=
=46rom: Josh Poimboeuf <jpoimboe@redhat.com>=0ADate: Fri, 6 May 2022 14:14:=
32 +0200=0ASubject: [PATCH 5.15 1/2] x86/mm: Simplify RESERVE_BRK()=0A=0Aco=
mmit a1e2c031ec3949b8c039b739c0b5bf9c30007b00 upstream.=0A=0ARESERVE_BRK() =
reserves data in the .brk_reservation section.  The data=0Ais initialized t=
o zero, like BSS, so the macro specifies 'nobits' to=0Aprevent the data fro=
m taking up space in the vmlinux binary.  The only=0Away to get the compile=
r to do that (without putting the variable in .bss=0Aproper) is to use inli=
ne asm.=0A=0AThe macro also has a hack which encloses the inline asm in a d=
iscarded=0Afunction, which allows the size to be passed (global inline asm =
doesn't=0Aallow inputs).=0A=0ARemove the need for the discarded function ha=
ck by just stringifying the=0Asize rather than supplying it as an input to =
the inline asm.=0A=0ASigned-off-by: Josh Poimboeuf <jpoimboe@redhat.com>=0A=
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>=0ASigned-off-b=
y: Borislav Petkov <bp@suse.de>=0AReviewed-by: Borislav Petkov <bp@suse.de>=
=0ALink: https://lore.kernel.org/r/20220506121631.133110232@infradead.org=
=0A[nathan: Resolve conflict due to lack of 2b6ff7dea670]=0ASigned-off-by: =
Nathan Chancellor <nathan@kernel.org>=0A---=0A arch/x86/include/asm/setup.h=
 | 30 +++++++++++-------------------=0A 1 file changed, 11 insertions(+), 1=
9 deletions(-)=0A=0Adiff --git a/arch/x86/include/asm/setup.h b/arch/x86/in=
clude/asm/setup.h=0Aindex a12458a7a8d4..c0932449cbe9 100644=0A--- a/arch/x8=
6/include/asm/setup.h=0A+++ b/arch/x86/include/asm/setup.h=0A@@ -108,27 +10=
8,19 @@ extern unsigned long _brk_end;=0A void *extend_brk(size_t size, siz=
e_t align);=0A =0A /*=0A- * Reserve space in the brk section.  The name mus=
t be unique within=0A- * the file, and somewhat descriptive.  The size is i=
n bytes.  Must be=0A- * used at file scope.=0A+ * Reserve space in the brk =
section.  The name must be unique within the file,=0A+ * and somewhat descr=
iptive.  The size is in bytes.=0A  *=0A- * (This uses a temp function to wr=
ap the asm so we can pass it the=0A- * size parameter; otherwise we wouldn'=
t be able to.  We can't use a=0A- * "section" attribute on a normal variabl=
e because it always ends up=0A- * being @progbits, which ends up allocating=
 space in the vmlinux=0A- * executable.)=0A+ * The allocation is done using=
 inline asm (rather than using a section=0A+ * attribute on a normal variab=
le) in order to allow the use of @nobits, so=0A+ * that it doesn't take up =
any space in the vmlinux file.=0A  */=0A-#define RESERVE_BRK(name,sz)						=
\=0A-	static void __section(".discard.text") __used notrace		\=0A-	__brk_re=
servation_fn_##name##__(void) {				\=0A-		asm volatile (						\=0A-			".pus=
hsection .brk_reservation,\"aw\",@nobits;" \=0A-			".brk." #name ":"				\=
=0A-			" 1:.skip %c0;"					\=0A-			" .size .brk." #name ", . - 1b;"		\=0A-	=
		" .popsection"					\=0A-			: : "i" (sz));					\=0A-	}=0A+#define RESERVE_=
BRK(name, size)						\=0A+	asm(".pushsection .brk_reservation,\"aw\",@nobit=
s\n\t"		\=0A+	    ".brk." #name ":\n\t"					\=0A+	    ".skip " __stringify(=
size) "\n\t"				\=0A+	    ".size .brk." #name ", " __stringify(size) "\n\t"=
		\=0A+	    ".popsection\n\t")=0A =0A extern void probe_roms(void);=0A #ifd=
ef __i386__=0A=0Abase-commit: 12952a23a5da6459aaaaa3ae4bc8ce8fef952ef5=0A--=
 =0A2.42.0=0A=0A=0AFrom 372ecf8b299adbe1ae8916e25b67139034b71211 Mon Sep 17=
 00:00:00 2001=0AFrom: Josh Poimboeuf <jpoimboe@kernel.org>=0ADate: Thu, 9 =
Jun 2022 00:17:32 -0700=0ASubject: [PATCH 5.15 2/2] x86/mm: Fix RESERVE_BRK=
() for older binutils=0A=0Acommit e32683c6f7d22ba624e0bfc58b02cf3348bdca63 =
upstream.=0A=0AWith binutils 2.26, RESERVE_BRK() causes a build failure:=0A=
=0A  /tmp/ccnGOKZ5.s: Assembler messages:=0A  /tmp/ccnGOKZ5.s:98: Error: mi=
ssing ')'=0A  /tmp/ccnGOKZ5.s:98: Error: missing ')'=0A  /tmp/ccnGOKZ5.s:98=
: Error: missing ')'=0A  /tmp/ccnGOKZ5.s:98: Error: junk at end of line, fi=
rst unrecognized=0A  character is `U'=0A=0AThe problem is this line:=0A=0A =
 RESERVE_BRK(early_pgt_alloc, INIT_PGT_BUF_SIZE)=0A=0ASpecifically, the INI=
T_PGT_BUF_SIZE macro which (via PAGE_SIZE's use=0A_AC()) has a "1UL", which=
 makes older versions of the assembler unhappy.=0AUnfortunately the _AC() m=
acro doesn't work for inline asm.=0A=0AInline asm was only needed here to c=
onvince the toolchain to add the=0ASTT_NOBITS flag.  However, if a C variab=
le is placed in a section whose=0Aname is prefixed with ".bss", GCC and Cla=
ng automatically set=0ASTT_NOBITS.  In fact, ".bss..page_aligned" already r=
elies on this trick.=0A=0ASo fix the build failure (and simplify the macro)=
 by allocating the=0Avariable in C.=0A=0AAlso, add NOLOAD to the ".brk" out=
put section clause in the linker=0Ascript.  This is a failsafe in case the =
".bss" prefix magic trick ever=0Astops working somehow.  If there's a secti=
on type mismatch, the GNU=0Alinker will force the ".brk" output section to =
be STT_NOBITS.  The LLVM=0Alinker will fail with a "section type mismatch" =
error.=0A=0ANote this also changes the name of the variable from .brk.##nam=
e to=0A__brk_##name.  The variable names aren't actually used anywhere, so =
it's=0Aharmless.=0A=0AFixes: a1e2c031ec39 ("x86/mm: Simplify RESERVE_BRK()"=
)=0AReported-by: Joe Damato <jdamato@fastly.com>=0AReported-by: Byungchul P=
ark <byungchul.park@lge.com>=0ASigned-off-by: Josh Poimboeuf <jpoimboe@kern=
el.org>=0ASigned-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>=0ATe=
sted-by: Joe Damato <jdamato@fastly.com>=0ALink: https://lore.kernel.org/r/=
22d07a44c80d8e8e1e82b9a806ddc8c6bbb2606e.1654759036.git.jpoimboe@kernel.org=
=0ASigned-off-by: Nathan Chancellor <nathan@kernel.org>=0A---=0A arch/x86/i=
nclude/asm/setup.h  | 38 +++++++++++++++++++----------------=0A arch/x86/ke=
rnel/setup.c       |  5 -----=0A arch/x86/kernel/vmlinux.lds.S |  4 ++--=0A=
 3 files changed, 23 insertions(+), 24 deletions(-)=0A=0Adiff --git a/arch/=
x86/include/asm/setup.h b/arch/x86/include/asm/setup.h=0Aindex c0932449cbe9=
=2E.e43ccc62fc1c 100644=0A--- a/arch/x86/include/asm/setup.h=0A+++ b/arch/x=
86/include/asm/setup.h=0A@@ -108,19 +108,16 @@ extern unsigned long _brk_en=
d;=0A void *extend_brk(size_t size, size_t align);=0A =0A /*=0A- * Reserve =
space in the brk section.  The name must be unique within the file,=0A- * a=
nd somewhat descriptive.  The size is in bytes.=0A+ * Reserve space in the =
=2Ebrk section, which is a block of memory from which the=0A+ * caller is a=
llowed to allocate very early (before even memblock is available)=0A+ * by =
calling extend_brk().  All allocated memory will be eventually converted=0A=
+ * to memblock.  Any leftover unallocated memory will be freed.=0A  *=0A- =
* The allocation is done using inline asm (rather than using a section=0A- =
* attribute on a normal variable) in order to allow the use of @nobits, so=
=0A- * that it doesn't take up any space in the vmlinux file.=0A+ * The siz=
e is in bytes.=0A  */=0A-#define RESERVE_BRK(name, size)						\=0A-	asm(".p=
ushsection .brk_reservation,\"aw\",@nobits\n\t"		\=0A-	    ".brk." #name ":=
\n\t"					\=0A-	    ".skip " __stringify(size) "\n\t"				\=0A-	    ".size .=
brk." #name ", " __stringify(size) "\n\t"		\=0A-	    ".popsection\n\t")=0A+=
#define RESERVE_BRK(name, size)					\=0A+	__section(".bss..brk") __aligned(=
1) __used	\=0A+	static char __brk_##name[size]=0A =0A extern void probe_rom=
s(void);=0A #ifdef __i386__=0A@@ -133,12 +130,19 @@ asmlinkage void __init =
x86_64_start_reservations(char *real_mode_data);=0A =0A #endif /* __i386__ =
*/=0A #endif /* _SETUP */=0A-#else=0A-#define RESERVE_BRK(name,sz)				\=0A-=
	.pushsection .brk_reservation,"aw",@nobits;	\=0A-.brk.name:						\=0A-1:	.=
skip sz;					\=0A-	.size .brk.name,.-1b;				\=0A+=0A+#else  /* __ASSEMBLY *=
/=0A+=0A+.macro __RESERVE_BRK name, size=0A+	.pushsection .bss..brk, "aw"=
=0A+SYM_DATA_START(__brk_\name)=0A+	.skip \size=0A+SYM_DATA_END(__brk_\name=
)=0A 	.popsection=0A+.endm=0A+=0A+#define RESERVE_BRK(name, size) __RESERVE=
_BRK name, size=0A+=0A #endif /* __ASSEMBLY__ */=0A+=0A #endif /* _ASM_X86_=
SETUP_H */=0Adiff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c=
=0Aindex 8e56c4de00b9..dcfea7b01c57 100644=0A--- a/arch/x86/kernel/setup.c=
=0A+++ b/arch/x86/kernel/setup.c=0A@@ -66,11 +66,6 @@ RESERVE_BRK(dmi_alloc=
, 65536);=0A #endif=0A =0A =0A-/*=0A- * Range of the BSS area. The size of =
the BSS area is determined=0A- * at link time, with RESERVE_BRK() facility =
reserving additional=0A- * chunks.=0A- */=0A unsigned long _brk_start =3D (=
unsigned long)__brk_base;=0A unsigned long _brk_end   =3D (unsigned long)__=
brk_base;=0A =0Adiff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kerne=
l/vmlinux.lds.S=0Aindex ca1a7595edac..bed5475b2ee9 100644=0A--- a/arch/x86/=
kernel/vmlinux.lds.S=0A+++ b/arch/x86/kernel/vmlinux.lds.S=0A@@ -411,10 +41=
1,10 @@ SECTIONS=0A 	__end_of_kernel_reserve =3D .;=0A =0A 	. =3D ALIGN(PAG=
E_SIZE);=0A-	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {=0A+	.brk (NOLOAD) : AT(A=
DDR(.brk) - LOAD_OFFSET) {=0A 		__brk_base =3D .;=0A 		. +=3D 64 * 1024;		/=
* 64k alignment slop space */=0A-		*(.brk_reservation)	/* areas brk users h=
ave reserved */=0A+		*(.bss..brk)		/* areas brk users have reserved */=0A 	=
	__brk_limit =3D .;=0A 	}=0A =0A-- =0A2.42.0=0A=0A
--1zwnuZMAaNaLvX2m--
