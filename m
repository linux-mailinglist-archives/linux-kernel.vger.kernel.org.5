Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C952780C132
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 07:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjLKGOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 01:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjLKGOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 01:14:10 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E102D114;
        Sun, 10 Dec 2023 22:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702275247;
        bh=75WDSYsZLPIbgO3BE3vbjhlnfBOpxpqabZdatv1Aju8=;
        h=Date:From:To:Cc:Subject:From;
        b=E1CMVOzFav5IQxbdMPtH0LEQEosdxl67LJjuRKEeDdNGtPLgwM8UyT2jJT+0q8pDD
         62QBePhmoo4iTXkSQczOw18C68pN72y11A1ETj5CeSqh/TR1g4x5Se8gN3hiHfaoKP
         tg49ViigFmjTYYihp0b1D1kf00wkoKG1TRF+Nc3ZImuKfBMNkFEZqidPfMe1ji/pCX
         MYV83sgx3z7HV+diLI5DHC/u24zncjgPeBEGciyHcr5QIo7QYn16t6z3yqa+D8I1m6
         gq5UTuAMQeVx57lbeU3pVQZMysJgh0ezUyi0aAVixOY/TANQe+mXLTlSB2z2vOojTX
         TK1tH1tLemiGg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SpWfR4LWfz4xRj;
        Mon, 11 Dec 2023 17:14:07 +1100 (AEDT)
Date:   Mon, 11 Dec 2023 17:14:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the percpu tree
Message-ID: <20231211171406.71fdc29b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XWUqHXP3e4df7xtjMdu4NhY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XWUqHXP3e4df7xtjMdu4NhY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the percpu tree, today's linux-next build (sparc64
defconfig) failed like this:

mm/percpu.c: In function 'pcpu_page_first_chunk':
mm/percpu.c:3336:17: error: implicit declaration of function 'flush_cache_v=
map_early'; did you mean 'flush_cache_vmap'? [-Werror=3Dimplicit-function-d=
eclaration]
 3336 |                 flush_cache_vmap_early(unit_addr, unit_addr + ai->u=
nit_size);=20
      |                 ^~~~~~~~~~~~~~~~~~~~~~
      |                 flush_cache_vmap
cc1: some warnings being treated as errors

Caused by commit

  a95c15a43f4a ("mm: Introduce flush_cache_vmap_early() and its riscv imple=
mentation")

I have applied the following fix patch for today.  Are there other
archs that don't use asm-generic/cacheflush.h?

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 11 Dec 2023 16:57:00 +1100
Subject: [PATCH] fix up for "mm: Introduce flush_cache_vmap_early() and its=
 riscv implementation"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/sparc/include/asm/cacheflush.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/sparc/include/asm/cacheflush.h b/arch/sparc/include/asm/c=
acheflush.h
index 881ac76eab93..9d87b2bcb217 100644
--- a/arch/sparc/include/asm/cacheflush.h
+++ b/arch/sparc/include/asm/cacheflush.h
@@ -10,4 +10,11 @@
 #else
 #include <asm/cacheflush_32.h>
 #endif
+
+#ifndef __ASSEMBLY__
+static inline void flush_cache_vmap_early(unsigned long start, unsigned lo=
ng end)
+{
+}
+#endif
+
 #endif
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/XWUqHXP3e4df7xtjMdu4NhY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV2qK4ACgkQAVBC80lX
0GypFAf+KVrM+YaWGK2g1LhJmq5o5hvkWztCuYalAVhU6GQt45d+EPncwQtek6vm
ITHCyM3v/TVIksPLcwMUVkDemFMKX1jAEt+W8dRJ33193BfJZtUC6VGvMjsCAbuD
VHSw9pn0+VzPtGq4Ur6ijo4H6AssLUjdTVrWw3ii8nnm4AzPhbZ20WOqMdx3RSGG
gpuhjjzSZFrdAoA+CND4dmcnLUeK/b3NutEKU95V461+Wh2xZirL06Pk3r0iwofi
MfQA9WovfTHjVdffchA5LWN19/6W46PRhXZeW/f5st9gVvKi0rbsoYMecpDT9HZL
zXx4d9o2j6ALSYEGc+1xZ5QbERlhOw==
=OVpx
-----END PGP SIGNATURE-----

--Sig_/XWUqHXP3e4df7xtjMdu4NhY--
