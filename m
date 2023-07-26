Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706D7762A77
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjGZEyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjGZEyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:54:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942D419AD;
        Tue, 25 Jul 2023 21:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690347237;
        bh=TdeNmVB+SeIWlacmvAwSccl9L0Em75y5kLVv1LWoRp4=;
        h=Date:From:To:Cc:Subject:From;
        b=MGSf7sgnaI9v57+h4KddKrCtakfSsLQAeWxsQfx6OeWKdPpqxmx7D3widt6WnimHT
         /T6L3L65wC/g0Lvkn9y6O7s7mB4JTmNS2KrAp8FCiN3EyNK6vUsXp/myASVUAnVSyd
         g57PrO0wL0hzT7+4q+wUBtP+8phgJmqPI5kQbxZvL+Hj7dpRBL2P4NPGbymXp+z4ew
         7VwRzgdziEtDmgymmLyBsEw2lBLZiz/fi0nREQzZJmZyQYG8Qasgd5XSk6axu7/hnd
         UFL7Mg48WOmmPUuXOtCKpHvVkJ6QjxO6HkSPph2Wr+zRrhC+YeusYIyVQE4B5ijfQ1
         o0aiiwZJm1VuA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R9hPd4tPgz4wy3;
        Wed, 26 Jul 2023 14:53:57 +1000 (AEST)
Date:   Wed, 26 Jul 2023 14:53:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20230726145356.5e42830f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DZmHxav8Sv6vAf8XNS+iwfE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DZmHxav8Sv6vAf8XNS+iwfE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc64
allnoconfig) failed like this:

In file included from arch/powerpc/include/asm/book3s/64/pgtable.h:285,
                 from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                 from arch/powerpc/include/asm/book3s/64/mmu.h:32,
                 from arch/powerpc/include/asm/mmu.h:396,
                 from arch/powerpc/include/asm/lppaca.h:46,
                 from arch/powerpc/include/asm/paca.h:18,
                 from arch/powerpc/include/asm/current.h:13,
                 from include/linux/thread_info.h:23,
                 from include/asm-generic/preempt.h:5,
                 from ./arch/powerpc/include/generated/asm/preempt.h:1,
                 from include/linux/preempt.h:79,
                 from include/linux/spinlock.h:56,
                 from include/linux/ipc.h:5,
                 from include/uapi/linux/sem.h:5,
                 from include/linux/sem.h:5,
                 from include/linux/compat.h:14,
                 from arch/powerpc/kernel/asm-offsets.c:12:
arch/powerpc/include/asm/book3s/64/radix.h:367:30: error: static declaratio=
n of 'vmemmap_can_optimize' follows non-static declaration
  367 | #define vmemmap_can_optimize vmemmap_can_optimize
      |                              ^~~~~~~~~~~~~~~~~~~~
include/linux/mm.h:3695:20: note: in expansion of macro 'vmemmap_can_optimi=
ze'
 3695 | static inline bool vmemmap_can_optimize(struct vmem_altmap *altmap,
      |                    ^~~~~~~~~~~~~~~~~~~~
arch/powerpc/include/asm/book3s/64/radix.h:367:30: note: previous declarati=
on of 'vmemmap_can_optimize' with type 'bool(struct vmem_altmap *, struct d=
ev_pagemap *)' {aka '_Bool(struct vmem_altmap *, struct dev_pagemap *)'}
  367 | #define vmemmap_can_optimize vmemmap_can_optimize
      |                              ^~~~~~~~~~~~~~~~~~~~
arch/powerpc/include/asm/book3s/64/radix.h:368:6: note: in expansion of mac=
ro 'vmemmap_can_optimize'
  368 | bool vmemmap_can_optimize(struct vmem_altmap *altmap, struct dev_pa=
gemap *pgmap);
      |      ^~~~~~~~~~~~~~~~~~~~

Presumably caused by commit

  f684ffc3ac9f ("powerpc/book3s64/radix: add support for vmemmap optimizati=
on for radix")

I have reverted that commit (and the following 2) for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/DZmHxav8Sv6vAf8XNS+iwfE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTApuQACgkQAVBC80lX
0GxyMAf/XII/D1P0qPMfvhceCyD7cW+v3WdJMdowSI9r0hGkHXA+7uBIC3m5278F
ke9pjM2iPVGNC0Q9D1NJkHBxCmynlgt2ar5xnBvkI2382v1Vfp7nxYy7TJsSIiC2
Ojg1mcNPfhTSVkCsFFkw3OnSSHz7BTCxpqCZ3kGfvDfXuvWEefdFvEJdwF/2djo0
GD6FJUSMg27Eb1uB6AU58vsa4jydoXJUvDyUW+hbJcRGDEgbjnlkXWRcAGtqnKFJ
Sdd9rf6K0e47C5839si4YG4ETEBo2g+nc6O5HkNPf8QNVdBgDJ0OEnpo7LTB0JPj
cDpvXKyZ36dIqMyH7lTToIM4v1+rHA==
=Fjpe
-----END PGP SIGNATURE-----

--Sig_/DZmHxav8Sv6vAf8XNS+iwfE--
