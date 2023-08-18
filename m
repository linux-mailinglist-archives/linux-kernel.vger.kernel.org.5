Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8BB78053F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 06:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357910AbjHRE6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 00:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348886AbjHRE6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 00:58:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7304358E;
        Thu, 17 Aug 2023 21:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692334708;
        bh=HiJA9PezM1HtffiYrXrdhi5mfPzK5Gu36qoqj3y34UQ=;
        h=Date:From:To:Cc:Subject:From;
        b=eCgz1PPdyt2Jld3CjkYn0XI0yuKWjdUTWTc2gTsfTgd6Os16DtPz/B/yBtHfmTLqE
         kBJ4yRxp+hYQ4qPLyLPfHOZmeg2IAw8w3WKgd1B36jEj91ogENlyG391wwkxtbT56V
         YCOSSZjJlEY6y/zbcB48azJrZwC/O6Ob/C3PQluLRzngn/h3pm1tmtXjvWFq8VYKT8
         F32fYiU1OZHdaTL9yZaNEKFq59AhL8IhvaiHb/i9brBbMFLVaQTWaHWckVp9arYHEq
         3GT5MaRtMfvD11WFvci6FDP5WKVMMpaAqlvuHvI774qZxPyyKGx3EjNVpyWIu94QBm
         rCGG3EaDSpVvg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RRqQC6MLvz4wxm;
        Fri, 18 Aug 2023 14:58:27 +1000 (AEST)
Date:   Fri, 18 Aug 2023 14:58:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tty tree with the powerpc tree
Message-ID: <20230818145826.00c7ead1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+BM+ZDeXTi+uS+L9NKgFyXK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+BM+ZDeXTi+uS+L9NKgFyXK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tty tree got a conflict in:

  arch/powerpc/include/asm/fs_pd.h

between commits:

  e6e077cb2aa4 ("powerpc/include: Declare mpc8xx_immr in 8xx_immap.h")
  fecc436a97af ("powerpc/include: Remove mpc8260.h and m82xx_pci.h")
  fbbf4280dae4 ("powerpc/8xx: Remove immr_map() and immr_unmap()")
  7768716d2f19 ("powerpc/cpm2: Remove cpm2_map() and cpm2_unmap()")

from the powerpc tree and commit:

  c2d6c1b4f034 ("serial: cpm_uart: Use get_baudrate() instead of uart_baudr=
ate()")

from the tty tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

Note that after all the above are applied, it looks like this file can
be removed completely as nothing in the tree includes it any more.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/include/asm/fs_pd.h
index d530f68b4eef,7b61b80f212d..000000000000
--- a/arch/powerpc/include/asm/fs_pd.h
+++ b/arch/powerpc/include/asm/fs_pd.h
@@@ -14,14 -14,26 +14,4 @@@
  #include <sysdev/fsl_soc.h>
  #include <asm/time.h>
 =20
- static inline int uart_baudrate(void)
- {
-         return get_baudrate();
- }
 -#ifdef CONFIG_CPM2
 -#include <asm/cpm2.h>
--
- static inline int uart_clock(void)
- {
-         return ppc_proc_freq;
- }
 -#if defined(CONFIG_8260)
 -#include <asm/mpc8260.h>
 -#endif
 -
 -#define cpm2_map(member) (&cpm2_immr->member)
 -#define cpm2_map_size(member, size) (&cpm2_immr->member)
 -#define cpm2_unmap(addr) do {} while(0)
 -#endif
 -
 -#ifdef CONFIG_PPC_8xx
 -#include <asm/8xx_immap.h>
 -
 -extern immap_t __iomem *mpc8xx_immr;
 -
 -#define immr_map(member) (&mpc8xx_immr->member)
 -#define immr_map_size(member, size) (&mpc8xx_immr->member)
 -#define immr_unmap(addr) do {} while (0)
 -#endif
--
  #endif

--Sig_/+BM+ZDeXTi+uS+L9NKgFyXK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTe+nIACgkQAVBC80lX
0GzCmQgAmP3nmQ0ZuhAn8IAop29hDMJ9UIpuvTIwLrXrmFIXo7tWOGa116pQxFkl
0+kFmuWcpAjEzbupP8Xu5c5EqY6mVifAySJuqQqievs0dFnEG5lVTgYLNjwGuOKP
/2dhd9+mJDRJkTWe0i5soJwntBy/gFIsjB2/0Ce1y9SA+qf4RZAWHUOfA4CiB4Ym
W1XErJP6WQyd75iLxojA3T+XYMGZv/I5OMrR2/o2i+i36zfphHpZiU/mZ930gtPy
jHq5X2H59AzBgpt5AXyLxCt2uXoqrXaBqoNg+huyOMeZEVipRcXJwI3Pb1G3AiEr
w6HanKvuBhq802YphvwzmSGclzDHSw==
=Y4Re
-----END PGP SIGNATURE-----

--Sig_/+BM+ZDeXTi+uS+L9NKgFyXK--
