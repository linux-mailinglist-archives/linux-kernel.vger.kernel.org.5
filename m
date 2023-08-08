Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9087774728
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbjHHTKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjHHTJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:09:42 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374E967F0;
        Tue,  8 Aug 2023 09:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691469624;
        bh=iPSr/ASAjYvgb6RftdXqdhWqOLirl2mfmvwZjh9Uq7A=;
        h=Date:From:To:Cc:Subject:From;
        b=aATJUpCOJNTGlQUrivd/UwybA2i1onLSK5fAwtNIr17BfPqaExv2ErUCKavMXeEBI
         SZB+PQaHu5Hc5wG7YdzfR0r8O5pkFCr3FSvjtE3GyPn/TbmPAQAqbr2g14WbEqlt0r
         LMKppEeOSMdO0TjNQ9oO5qI5qFFG5uNXJJkI64U6Dt6JYzSfQIn2t3XWhQaswQNzWU
         poFaLTy7dtzB+KW1jzMbef0ZSmHx5ltFrGOCiaCUKVmGOSzw0HnXS2wlyx/9SCGEou
         vVGANawUqUp/fHL4hgL556w1jXwUZ8a1ikSWDMU5c32yA8hicJ7djybGs8x13zkd1g
         CwfK3E+TwXz8A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RKgTz44wGz4wjG;
        Tue,  8 Aug 2023 14:40:23 +1000 (AEST)
Date:   Tue, 8 Aug 2023 14:40:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20230808144020.538cdab8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Y.ZH866Yy2hMCsnmzV9L5k=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Y.ZH866Yy2hMCsnmzV9L5k=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc
ppc44x_defconfig) failed like this:

In file included from kernel/crash_core.c:23:
kernel/kexec_internal.h:11:54: warning: 'struct kexec_segment' declared ins=
ide parameter list will not be visible outside of this definition or declar=
ation
   11 | int kimage_load_segment(struct kimage *image, struct kexec_segment =
*segment);
      |                                                      ^~~~~~~~~~~~~
kernel/crash_core.c:321:40: warning: 'struct crash_mem' declared inside par=
ameter list will not be visible outside of this definition or declaration
  321 | int crash_prepare_elf64_headers(struct crash_mem *mem, int need_ker=
nel_map,
      |                                        ^~~~~~~~~
kernel/crash_core.c: In function 'crash_prepare_elf64_headers':
kernel/crash_core.c:334:23: error: invalid use of undefined type 'struct cr=
ash_mem'
  334 |         nr_phdr +=3D mem->nr_ranges;
      |                       ^~
In file included from include/vdso/const.h:5,
                 from include/linux/const.h:4,
                 from include/linux/bits.h:5,
                 from include/linux/ratelimit_types.h:5,
                 from include/linux/printk.h:9,
                 from include/asm-generic/bug.h:22,
                 from arch/powerpc/include/asm/bug.h:116,
                 from include/linux/bug.h:5,
                 from arch/powerpc/include/asm/cmpxchg.h:8,
                 from arch/powerpc/include/asm/atomic.h:11,
                 from include/linux/atomic.h:7,
                 from include/linux/mm_types_task.h:13,
                 from include/linux/mm_types.h:5,
                 from include/linux/buildid.h:5,
                 from kernel/crash_core.c:7:
kernel/crash_core.c:346:32: error: 'ELF_CORE_HEADER_ALIGN' undeclared (firs=
t use in this function)
  346 |         elf_sz =3D ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
      |                                ^~~~~~~~~~~~~~~~~~~~~
include/uapi/linux/const.h:32:50: note: in definition of macro '__ALIGN_KER=
NEL_MASK'
   32 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
      |                                                  ^~~~
include/linux/align.h:8:33: note: in expansion of macro '__ALIGN_KERNEL'
    8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
      |                                 ^~~~~~~~~~~~~~
kernel/crash_core.c:346:18: note: in expansion of macro 'ALIGN'
  346 |         elf_sz =3D ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
      |                  ^~~~~
kernel/crash_core.c:346:32: note: each undeclared identifier is reported on=
ly once for each function it appears in
  346 |         elf_sz =3D ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
      |                                ^~~~~~~~~~~~~~~~~~~~~
include/uapi/linux/const.h:32:50: note: in definition of macro '__ALIGN_KER=
NEL_MASK'
   32 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
      |                                                  ^~~~
include/linux/align.h:8:33: note: in expansion of macro '__ALIGN_KERNEL'
    8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
      |                                 ^~~~~~~~~~~~~~
kernel/crash_core.c:346:18: note: in expansion of macro 'ALIGN'
  346 |         elf_sz =3D ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
      |                  ^~~~~
kernel/crash_core.c:396:28: error: invalid use of undefined type 'struct cr=
ash_mem'
  396 |         for (i =3D 0; i < mem->nr_ranges; i++) {
      |                            ^~
kernel/crash_core.c:397:29: error: invalid use of undefined type 'struct cr=
ash_mem'
  397 |                 mstart =3D mem->ranges[i].start;
      |                             ^~
kernel/crash_core.c:398:27: error: invalid use of undefined type 'struct cr=
ash_mem'
  398 |                 mend =3D mem->ranges[i].end;
      |                           ^~
kernel/crash_core.c: At top level:
kernel/crash_core.c:420:36: warning: 'struct crash_mem' declared inside par=
ameter list will not be visible outside of this definition or declaration
  420 | int crash_exclude_mem_range(struct crash_mem *mem,
      |                                    ^~~~~~~~~
kernel/crash_core.c: In function 'crash_exclude_mem_range':
kernel/crash_core.c:427:28: error: invalid use of undefined type 'struct cr=
ash_mem'
  427 |         for (i =3D 0; i < mem->nr_ranges; i++) {
      |                            ^~
kernel/crash_core.c:428:28: error: invalid use of undefined type 'struct cr=
ash_mem'
  428 |                 start =3D mem->ranges[i].start;
      |                            ^~
kernel/crash_core.c:429:26: error: invalid use of undefined type 'struct cr=
ash_mem'
  429 |                 end =3D mem->ranges[i].end;
      |                          ^~
kernel/crash_core.c:444:28: error: invalid use of undefined type 'struct cr=
ash_mem'
  444 |                         mem->ranges[i].start =3D 0;
      |                            ^~
kernel/crash_core.c:445:28: error: invalid use of undefined type 'struct cr=
ash_mem'
  445 |                         mem->ranges[i].end =3D 0;
      |                            ^~
kernel/crash_core.c:446:36: error: invalid use of undefined type 'struct cr=
ash_mem'
  446 |                         if (i < mem->nr_ranges - 1) {
      |                                    ^~
kernel/crash_core.c:448:52: error: invalid use of undefined type 'struct cr=
ash_mem'
  448 |                                 for (j =3D i; j < mem->nr_ranges - =
1; j++) {
      |                                                    ^~
kernel/crash_core.c:449:44: error: invalid use of undefined type 'struct cr=
ash_mem'
  449 |                                         mem->ranges[j].start =3D
      |                                            ^~
kernel/crash_core.c:450:52: error: invalid use of undefined type 'struct cr=
ash_mem'
  450 |                                                 mem->ranges[j+1].st=
art;
      |                                                    ^~
kernel/crash_core.c:451:44: error: invalid use of undefined type 'struct cr=
ash_mem'
  451 |                                         mem->ranges[j].end =3D
      |                                            ^~
kernel/crash_core.c:452:60: error: invalid use of undefined type 'struct cr=
ash_mem'
  452 |                                                         mem->ranges=
[j+1].end;
      |                                                            ^~
kernel/crash_core.c:461:36: error: invalid use of undefined type 'struct cr=
ash_mem'
  461 |                                 mem->nr_ranges--;
      |                                    ^~
kernel/crash_core.c:464:28: error: invalid use of undefined type 'struct cr=
ash_mem'
  464 |                         mem->nr_ranges--;
      |                            ^~
kernel/crash_core.c:470:28: error: invalid use of undefined type 'struct cr=
ash_mem'
  470 |                         mem->ranges[i].end =3D p_start - 1;
      |                            ^~
kernel/crash_core.c:474:28: error: invalid use of undefined type 'struct cr=
ash_mem'
  474 |                         mem->ranges[i].end =3D p_start - 1;
      |                            ^~
kernel/crash_core.c:476:28: error: invalid use of undefined type 'struct cr=
ash_mem'
  476 |                         mem->ranges[i].start =3D p_end + 1;
      |                            ^~
kernel/crash_core.c:485:21: error: invalid use of undefined type 'struct cr=
ash_mem'
  485 |         if (i =3D=3D mem->max_nr_ranges - 1)
      |                     ^~
kernel/crash_core.c:490:20: error: invalid use of undefined type 'struct cr=
ash_mem'
  490 |         if (j < mem->nr_ranges) {
      |                    ^~
kernel/crash_core.c:492:29: error: invalid use of undefined type 'struct cr=
ash_mem'
  492 |                 for (i =3D mem->nr_ranges - 1; i >=3D j; i--)
      |                             ^~
kernel/crash_core.c:493:28: error: invalid use of undefined type 'struct cr=
ash_mem'
  493 |                         mem->ranges[i + 1] =3D mem->ranges[i];
      |                            ^~
kernel/crash_core.c:493:49: error: invalid use of undefined type 'struct cr=
ash_mem'
  493 |                         mem->ranges[i + 1] =3D mem->ranges[i];
      |                                                 ^~
kernel/crash_core.c:496:12: error: invalid use of undefined type 'struct cr=
ash_mem'
  496 |         mem->ranges[j].start =3D temp_range.start;
      |            ^~
kernel/crash_core.c:497:12: error: invalid use of undefined type 'struct cr=
ash_mem'
  497 |         mem->ranges[j].end =3D temp_range.end;
      |            ^~
kernel/crash_core.c:498:12: error: invalid use of undefined type 'struct cr=
ash_mem'
  498 |         mem->nr_ranges++;
      |            ^~

I am not sure exactly which commit caused but I have revreted these
for today:

  6a41fd4665e6 ("x86/crash: optimize CPU changes")
  add3b7e011e9 ("crash: change crash_prepare_elf64_headers() to for_each_po=
ssible_cpu()")
  4a7eed40a7bc ("crash: hotplug support for kexec_load()")
  8ce41bc6b147 ("x86/crash: add x86 crash hotplug support")
  2b765af0c14f ("crash: memory and CPU hotplug sysfs attributes")
  36d2b573329b ("kexec: exclude elfcorehdr from the segment digest")
  ccfe0040500f ("crash: add generic infrastructure for crash hotplug suppor=
t")
  626775922a57 ("crash: move a few code bits to setup support of crash hotp=
lug")

--=20
Cheers,
Stephen Rothwell

--Sig_/Y.ZH866Yy2hMCsnmzV9L5k=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTRxzQACgkQAVBC80lX
0GwDRQgAl8aFvNP0KFSs6mhbEeUzdhslz1rfQ6LplWOEcEA6PzesrIJK5f68OLzR
lIGFgnAqIGPEgoWB6d0fMWcLcr18Hh/8B+UzWmLiLCCDI1g5ldI01YUcboqIKQfo
HMIMaosoFBBFopf/68e6xkAcshaWduOaq2zDg7Bvkan7/HRst2o/4iKqYZtKkYha
xlcrNyGmctJCiIIgCwoKq1dcHU5GTmR09nMRmTYl0juvWzsdV90/zRYdQ1bbcfwn
rhsBwc8MSqtcXWNYLE4/2YVTTeTsJkkhfmIv6DVfRkNYX/Nftrt67pE4cFefXqEZ
rKxVcmMqyuueGt0N+ehVg+h2slsdTQ==
=jNf+
-----END PGP SIGNATURE-----

--Sig_/Y.ZH866Yy2hMCsnmzV9L5k=--
