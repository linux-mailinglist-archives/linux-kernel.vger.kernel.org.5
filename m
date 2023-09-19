Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB6D7A59E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjISGZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjISGZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:25:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B80100;
        Mon, 18 Sep 2023 23:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695104720;
        bh=PYyJpfVNu3Wc5HIfrR0xLmvXbr92eNrixN6pE3JOwzk=;
        h=Date:From:To:Cc:Subject:From;
        b=D1bJafs0H2+otYJSyK0o+Pwcw9Uh/O0U/0hCT+llfUmmomGrSu7vkokvzM3VhfWrE
         LRXesvyPYiPYoqBO09Jv2kMJpwrAnyihLRb/GDnh7X/Lsk8tcPpOJ/phW60/QQiz9S
         sNJ2jzXi/Qbi8X4XJPL8otIvKZ9LyDUMP8xwx/U1M1SHrQotWEfFtjxY2Vz98RtXo9
         fdcPik+gVPsrmWMjRJLhozVtx6buh1djQiALk7FT0stzMzQPwqqLJMPtr5Q9YBfiya
         qB6KRFSXLL1pTZwZZlcf1wRu7oqeIh4VmoL14ZbGOcIWKzsXm0vuFyNVq2M4yzoTos
         bsXhvMcJ4k5WA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RqWqh2rlQz4xM6;
        Tue, 19 Sep 2023 16:25:20 +1000 (AEST)
Date:   Tue, 19 Sep 2023 16:25:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: boot warning after merge of the mm tree
Message-ID: <20230919162518.180fd9f3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/f_i2jmMzJinMrcS.xCKiQnG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/f_i2jmMzJinMrcS.xCKiQnG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next qemu opbbt test (powerpc
pseries_le_defconfig) produced this warning:

vmap allocation for size 131072 failed: use vmalloc=3D<size> to increase si=
ze
swapper/0: vmalloc error: size 65536, vm_struct allocation failed, mode:0xc=
c0(GFP_KERNEL), nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc2-06327-g52a3bc18f36c #1
Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf0000=
04 of:SLOF,HEAD pSeries
Call Trace:
[c00000000478f780] [c000000001174678] dump_stack_lvl+0x6c/0x9c (unreliable)
[c00000000478f7b0] [c0000000004b7450] warn_alloc+0x150/0x210
[c00000000478f850] [c0000000004abcd0] __vmalloc_node_range+0x4c0/0xab0
[c00000000478f9d0] [c0000000005534dc] execmem_alloc+0xec/0x180
[c00000000478fa70] [c0000000002c1ef8] alloc_insn_page+0x28/0x80
[c00000000478fa90] [c0000000002c5624] __get_insn_slot+0x1c4/0x2a0
[c00000000478fad0] [c00000000005cd68] arch_prepare_kprobe+0x168/0x2e0
[c00000000478fb50] [c0000000002c69c0] register_kprobe+0x550/0x880
[c00000000478fbc0] [c000000002012968] arch_init_kprobes+0x28/0x3c
[c00000000478fbe0] [c000000002038a50] init_kprobes+0x118/0x1a0
[c00000000478fc50] [c000000000010bc0] do_one_initcall+0x80/0x300
[c00000000478fd20] [c000000002004848] kernel_init_freeable+0x1dc/0x3b4
[c00000000478fdf0] [c0000000000111b0] kernel_init+0x30/0x1a0
[c00000000478fe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x1c
--- interrupt: 0 at 0x0
NIP:  0000000000000000 LR: 0000000000000000 CTR: 0000000000000000
REGS: c00000000478fe80 TRAP: 0000   Not tainted  (6.6.0-rc2-06327-g52a3bc18=
f36c)
MSR:  0000000000000000 <>  CR: 00000000  XER: 00000000
CFAR: 0000000000000000 IRQMASK: 0=20
GPR00: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR04: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR12: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR28: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
NIP [0000000000000000] 0x0
LR [0000000000000000] 0x0
--- interrupt: 0
Mem-Info:
active_anon:0 inactive_anon:0 isolated_anon:0
 active_file:0 inactive_file:0 isolated_file:0
 unevictable:0 dirty:0 writeback:0
 slab_reclaimable:4 slab_unreclaimable:94
 mapped:0 shmem:0 pagetables:1
 sec_pagetables:0 bounce:0
 kernel_misc_reclaimable:0
 free:31798 free_pcp:10 free_cma:0
Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB =
unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB =
writeback:0kB shmem:0kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writ=
eback_tmp:0kB kernel_stack:272kB pagetables:64kB sec_pagetables:0kB all_unr=
eclaimable? no
Node 0 Normal free:2035072kB boost:0kB min:0kB low:0kB high:0kB reserved_hi=
ghatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_fil=
e:0kB unevictable:0kB writepending:0kB present:2097152kB managed:2043904kB =
mlocked:0kB bounce:0kB free_pcp:640kB local_pcp:640kB free_cma:0kB
lowmem_reserve[]: 0 0 0
Node 0 Normal: 4*64kB (M) 5*128kB (UM) 6*256kB (ME) 6*512kB (UME) 6*1024kB =
(UME) 6*2048kB (UME) 5*4096kB (UME) 5*8192kB (ME) 119*16384kB (M) =3D 20350=
72kB
0 total pagecache pages
0 pages in swap cache
Free swap  =3D 0kB
Total swap =3D 0kB
32768 pages RAM
0 pages HighMem/MovableOnly
832 pages reserved
0 pages cma reserved

Introduced by commit (via bisection)

  2d278773305d ("powerpc: extend execmem_params for kprobes allocations")

I have reverted the following commits for today.

  be2e02ac422f ("bpf: remove CONFIG_BPF_JIT dependency on CONFIG_MODULES of=
")
  68f60fd96f9d ("kprobes: remove dependency on CONFIG_MODULES")
  2177ac117a8e ("x86/ftrace: enable dynamic ftrace without CONFIG_MODULES")
  3300c3af2009 ("arch: make execmem setup available regardless of CONFIG_MO=
DULES")
  2d278773305d ("powerpc: extend execmem_params for kprobes allocations")

--=20
Cheers,
Stephen Rothwell

--Sig_/f_i2jmMzJinMrcS.xCKiQnG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUJPs4ACgkQAVBC80lX
0GxdvAf+IU4Sia7nvZ6h/9Qh/dAfvF9JN1O3ckwl6eGeEeUaEaGXkUXMTXA3bh8G
C0oMcVNogz5bz/QllNwya/R5A+/MAzZbFeu1u9UVryYek+3pEm5I9yaVpX7nftIz
4vMjxi/SBtihFVVBUSbp1MOte5Wec3lLnGqnuACEO2xHfTtZV+htP6lgy9+dWMsX
JEF5EdKWbnbkxwG3DfOQAbRBbjlp8mMcMrPzOZy/pH6I0rkRUk3RxGp7KX4auw1A
djxlEX/JdYLpbBwYIDFYdyXA/jMbyv3SSX/7KDKAjswWXW+xlmgPOB0DuzLB/ntT
oWIbtgkt/povqeSDetCf2A8cD9u/ew==
=WV/a
-----END PGP SIGNATURE-----

--Sig_/f_i2jmMzJinMrcS.xCKiQnG--
