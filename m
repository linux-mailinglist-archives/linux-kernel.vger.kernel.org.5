Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E967DFC3F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377461AbjKBWO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjKBWOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:14:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD46A91;
        Thu,  2 Nov 2023 15:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698963288;
        bh=i80a06SOeQSQ1W4w6P9Q8wfCVSh8IgOe4nN4K90pDck=;
        h=Date:From:To:Cc:Subject:From;
        b=sWdmCh01Iql1djxCPponKgqM3MVvtQjBtJi3XQEPrLx9KZOgn/9NvJHrp0vkBmWvO
         81lnK0VFvTVKL/Yo3ykG4W9eOOiY2pGwoqdB8JYp6z53XLvMfH3Sr3N5De3wHVacup
         NHsy1Ga9KUJ2yl3U/OdYH7EtlbEnnm7YRrlHw/9zyr69q29QaBxD2frn9nK/xbn0C5
         3v/s4XdiFuiQDVxE3hnufXDkK24rEeKhIybLAHXuM52NEDXJjJn+7rpCbc2D/579Jq
         d4fHfox9739O9v5oMDFXm1mg5mfgTfL0GGM/6QM37CFuJ3i7Pan9MAwPoARO/ScKad
         EPFlTaAwG5Adw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SLypv3TjMz4xQS;
        Fri,  3 Nov 2023 09:14:47 +1100 (AEDT)
Date:   Fri, 3 Nov 2023 09:14:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Jiexun Wang <wangjiexun@tinylab.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: linux-next: manual merge of the risc-v tree with Linus' tree
Message-ID: <20231103091436.730cb6c6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_/ZYG0PhO7Kp5.fiNdLvnQ2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_/ZYG0PhO7Kp5.fiNdLvnQ2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the risc-v tree got a conflict in:

  arch/riscv/kernel/irq.c

between commit:

  07a27665754b ("RISC-V: Fix wrong use of CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK")

from Linus' tree and commit:

  82982fdd5133 ("riscv: Deduplicate IRQ stack switching")

from the risc-v tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/riscv/kernel/irq.c
index 9cc0a7669271,7bfea97ee7e7..000000000000
--- a/arch/riscv/kernel/irq.c
+++ b/arch/riscv/kernel/irq.c
@@@ -60,41 -79,23 +79,23 @@@ static void init_irq_stacks(void
  }
  #endif /* CONFIG_VMAP_STACK */
 =20
 -#ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
 +#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
+ static void ___do_softirq(struct pt_regs *regs)
+ {
+ 	__do_softirq();
+ }
+=20
  void do_softirq_own_stack(void)
  {
- #ifdef CONFIG_IRQ_STACKS
- 	if (on_thread_stack()) {
- 		ulong *sp =3D per_cpu(irq_stack_ptr, smp_processor_id())
- 					+ IRQ_STACK_SIZE/sizeof(ulong);
- 		__asm__ __volatile(
- 		"addi	sp, sp, -"RISCV_SZPTR  "\n"
- 		REG_S"  ra, (sp)		\n"
- 		"addi	sp, sp, -"RISCV_SZPTR  "\n"
- 		REG_S"  s0, (sp)		\n"
- 		"addi	s0, sp, 2*"RISCV_SZPTR "\n"
- 		"move	sp, %[sp]		\n"
- 		"call	__do_softirq		\n"
- 		"addi	sp, s0, -2*"RISCV_SZPTR"\n"
- 		REG_L"  s0, (sp)		\n"
- 		"addi	sp, sp, "RISCV_SZPTR   "\n"
- 		REG_L"  ra, (sp)		\n"
- 		"addi	sp, sp, "RISCV_SZPTR   "\n"
- 		:
- 		: [sp] "r" (sp)
- 		: "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
- 		  "t0", "t1", "t2", "t3", "t4", "t5", "t6",
- #ifndef CONFIG_FRAME_POINTER
- 		  "s0",
- #endif
- 		  "memory");
- 	} else
- #endif
+ 	if (on_thread_stack())
+ 		call_on_irq_stack(NULL, ___do_softirq);
+ 	else
  		__do_softirq();
  }
 -#endif /* CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK */
 +#endif /* CONFIG_SOFTIRQ_ON_OWN_STACK */
 =20
  #else
+ static void init_irq_scs(void) {}
  static void init_irq_stacks(void) {}
  #endif /* CONFIG_IRQ_STACKS */
 =20

--Sig_/_/ZYG0PhO7Kp5.fiNdLvnQ2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVEH0wACgkQAVBC80lX
0Gw61Af/cpxDB3nTwIhG02iZyOLJUwgYroVw2nP8RuVb/+BKta3FfY03/FqFzanG
zeXcMftPUDz98EMWv36AdVf3ziwMRE/nSQ6Kl1y5j3qzTepL+UylK5BJqNJNcFHO
IHOIwzoeKHkrYmabNiha+ovAGee0HYT/7GT/R5XbNFOdNAl7F5w4ojln3p9L8btJ
xUGzK+MT0kUMhP/TKCxmz/IjD3OnwFv+S798px3JgM8+ysTlZUoi+iDybHJKY26Y
rlhvfO6/MUpuHGCRx39LRdmni8/tutOK1rZPXODwhpy5m7Uh75OEVxwQUZFatu7N
Ylg3AjXrafX+0sPtGShfrbEbSJUDcw==
=9FZK
-----END PGP SIGNATURE-----

--Sig_/_/ZYG0PhO7Kp5.fiNdLvnQ2--
