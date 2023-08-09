Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4918D7750D2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 04:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjHICPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 22:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjHICPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 22:15:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A391FF5;
        Tue,  8 Aug 2023 19:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691547314;
        bh=WwhPpUPIIJ1F0bzlOpEW0k9XGC15BGNZygV8v9njSAE=;
        h=Date:From:To:Cc:Subject:From;
        b=FzAQ4+AeQxDY6ihN3HVgV1vJKNN6sy3W7x/3QDDV8wpqpi8jgllQsMvLvBmQAuOXX
         /Wkt3zh+fv1tgX4QVNPMlQaHoUhFSE9WcTpe+wsweOi8gQR6MNT4Ebv77U7Ewt0q9n
         X/JXDfMIzIY5+7JHmkNz6YtZSvsC/i8kPx6CMoZizupybRpS4fGP5CZZrllajw2fQ/
         a0EEWiBbh8NBswd4rESwQ4R1+EUv5HdTOcSKLjHjg1qVVACYLOcT/vhCnH02fhw9N6
         e+grgUiMeBE6RTinHaA1TJemgHTolPP7Mob2Ck94o2ajtL1t4a9HVKxLFT68KcZQ9I
         t3W6eoxsn2nBg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RLDD069zFz4wqX;
        Wed,  9 Aug 2023 12:15:12 +1000 (AEST)
Date:   Wed, 9 Aug 2023 12:15:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>
Subject: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20230809121511.683222bc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/x4+GA/H3iTCwCxkB3mEt39H";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/x4+GA/H3iTCwCxkB3mEt39H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got conflicts in:

  arch/x86/include/asm/processor.h
  arch/x86/kernel/vmlinux.lds.S
  arch/x86/lib/retpoline.S

between commits:

  fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
  3bbbe97ad83d ("x86/srso: Add a forgotten NOENDBR annotation")

from Linus' tree and commits:

  566ffa3ae964 ("x86/cpu: Fix amd_check_microcode() declaration")
  973ab2d61f33 ("x86/retpoline,kprobes: Fix position of thunk sections with=
 CONFIG_LTO_CLANG")
  029239c5b0e6 ("x86/retpoline,kprobes: Skip optprobe check for indirect ju=
mps with retpolines and IBT")

from the tip tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/include/asm/processor.h
index 7c67db7c9f53,36d52075fdad..000000000000
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@@ -682,11 -682,11 +682,13 @@@ extern u16 get_llc_id(unsigned int cpu)
  #ifdef CONFIG_CPU_SUP_AMD
  extern u32 amd_get_nodes_per_socket(void);
  extern u32 amd_get_highest_perf(void);
 +extern bool cpu_has_ibpb_brtype_microcode(void);
+ extern void amd_check_microcode(void);
  #else
  static inline u32 amd_get_nodes_per_socket(void)	{ return 0; }
  static inline u32 amd_get_highest_perf(void)		{ return 0; }
 +static inline bool cpu_has_ibpb_brtype_microcode(void)	{ return false; }
+ static inline void amd_check_microcode(void)		{ }
  #endif
 =20
  extern unsigned long arch_align_stack(unsigned long sp);
diff --cc arch/x86/kernel/vmlinux.lds.S
index e76813230192,dd5b0a68cf84..000000000000
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@@ -133,28 -133,12 +133,26 @@@ SECTION
  		KPROBES_TEXT
  		SOFTIRQENTRY_TEXT
  #ifdef CONFIG_RETPOLINE
- 		__indirect_thunk_start =3D .;
- 		*(.text.__x86.indirect_thunk)
- 		*(.text.__x86.return_thunk)
- 		__indirect_thunk_end =3D .;
 -		*(.text..__x86.*)
++		*(.text..__x86.indirect_thunk)
++		*(.text..__x86.return_thunk)
  #endif
  		STATIC_CALL_TEXT
 =20
  		ALIGN_ENTRY_TEXT_BEGIN
 +#ifdef CONFIG_CPU_SRSO
- 		*(.text.__x86.rethunk_untrain)
++		*(.text..__x86.rethunk_untrain)
 +#endif
 +
  		ENTRY_TEXT
 +
 +#ifdef CONFIG_CPU_SRSO
 +		/*
 +		 * See the comment above srso_untrain_ret_alias()'s
 +		 * definition.
 +		 */
 +		. =3D srso_untrain_ret_alias | (1 << 2) | (1 << 8) | (1 << 14) | (1 << =
20);
- 		*(.text.__x86.rethunk_safe)
++		*(.text..__x86.rethunk_safe)
 +#endif
  		ALIGN_ENTRY_TEXT_END
  		*(.gnu.warning)
 =20
diff --cc arch/x86/lib/retpoline.S
index 2cff585f22f2,3bea96341d00..000000000000
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@@ -11,9 -11,8 +11,9 @@@
  #include <asm/unwind_hints.h>
  #include <asm/percpu.h>
  #include <asm/frame.h>
 +#include <asm/nops.h>
 =20
- 	.section .text.__x86.indirect_thunk
+ 	.section .text..__x86.indirect_thunk
 =20
 =20
  .macro POLINE reg
@@@ -132,47 -131,7 +132,47 @@@ SYM_CODE_END(__x86_indirect_jump_thunk_
   */
  #ifdef CONFIG_RETHUNK
 =20
 +/*
 + * srso_untrain_ret_alias() and srso_safe_ret_alias() are placed at
 + * special addresses:
 + *
 + * - srso_untrain_ret_alias() is 2M aligned
 + * - srso_safe_ret_alias() is also in the same 2M page but bits 2, 8, 14
 + * and 20 in its virtual address are set (while those bits in the
 + * srso_untrain_ret_alias() function are cleared).
 + *
 + * This guarantees that those two addresses will alias in the branch
 + * target buffer of Zen3/4 generations, leading to any potential
 + * poisoned entries at that BTB slot to get evicted.
 + *
 + * As a result, srso_safe_ret_alias() becomes a safe return.
 + */
 +#ifdef CONFIG_CPU_SRSO
- 	.section .text.__x86.rethunk_untrain
++	.section .text..__x86.rethunk_untrain
 +
 +SYM_START(srso_untrain_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
 +	ANNOTATE_NOENDBR
 +	ASM_NOP2
 +	lfence
 +	jmp __x86_return_thunk
 +SYM_FUNC_END(srso_untrain_ret_alias)
 +__EXPORT_THUNK(srso_untrain_ret_alias)
 +
- 	.section .text.__x86.rethunk_safe
++	.section .text..__x86.rethunk_safe
 +#endif
 +
 +/* Needs a definition for the __x86_return_thunk alternative below. */
 +SYM_START(srso_safe_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
 +#ifdef CONFIG_CPU_SRSO
 +	add $8, %_ASM_SP
 +	UNWIND_HINT_FUNC
 +#endif
 +	ANNOTATE_UNRET_SAFE
 +	ret
 +	int3
 +SYM_FUNC_END(srso_safe_ret_alias)
 +
- 	.section .text.__x86.return_thunk
+ 	.section .text..__x86.return_thunk
 =20
  /*
   * Safety details here pertain to the AMD Zen{1,2} microarchitecture:

--Sig_/x4+GA/H3iTCwCxkB3mEt39H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTS9q8ACgkQAVBC80lX
0GzdOwf/X9HFMeVhGA7dhzn2I8yOdafOMdBkjuyBInYjUNuHzKCPxn7pjk3DH/aj
QrxNuxMhd5Nwn1tiPjZsvXDpH5TNf2UPlq/QoykHB4jhjlpfvLxT8jIpw5gUy+86
sEObHKoPpuhHO28tzrHkCA4yyQ+rpi+aNAqQqf7THEurijn6mg9wG2PvroX6J7ff
Mm5wq3yXyG9SNPeLHJOYk8tM8aEAyJASwc40DWVw+8qI39pBkbxFvV9AetXZY78t
XwtTKRx4l61PIGDW82Gju6Ms/WYJBKtdvqRh+jAd0Ai2iu9TCr8XsZ1Cdvuj1fcF
8zy3hffNCNh9iZHP8XnUtADaJkp3pw==
=jdw1
-----END PGP SIGNATURE-----

--Sig_/x4+GA/H3iTCwCxkB3mEt39H--
