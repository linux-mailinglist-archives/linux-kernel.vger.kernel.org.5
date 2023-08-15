Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01FC77C6B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 06:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjHOEVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 00:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbjHOETi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 00:19:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3EE1BF7;
        Mon, 14 Aug 2023 21:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692073171;
        bh=aihpz8vRmNZEsamCQ7JCYCNCPEUi/nDxj5n6nI2TJ/I=;
        h=Date:From:To:Cc:Subject:From;
        b=o5ge1TTWJDiysDYk1eCPYQams6OlemE+LeObYb3/pjQHo1ypF+mGDoXu+/OclspuQ
         WqVI9iJ2p2vfrrBsLEaGnBOlRnMXRBtZBUc+7jmk+ab7q8FgxRKKOpDRgiSzLppjM/
         ezvaMBQfa5GFRdC7yBNC0YvuKg7UwPh35wgUjkq+cSfDvqy2w0MPqanfaZXRc90c7O
         8xN2oLdovJxL+8lks8BWynAZM769nqO/j1QHrIPOs5Evzs+BsAUal2Ivy6uZ2jvTZ1
         4T6BhhflRTvkkr8fv1kCfPiMkX+8V+FmU8Rlxucxy31OfPlYk2bGVMJlsUWd7svb/a
         I9sdmWjYo8Qlw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPyhf0pnnz4wZs;
        Tue, 15 Aug 2023 14:19:29 +1000 (AEST)
Date:   Tue, 15 Aug 2023 14:19:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: linux-next: manual merge of the tip tree with the mm-stable tree
Message-ID: <20230815141929.0c162def@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AhL+NPTLpDTh_deEriG30oW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AhL+NPTLpDTh_deEriG30oW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/s390/Kconfig

between commit:

  7e6ebd8ee418 ("mm/vmemmap optimization: split hugetlb and devdax vmemmap =
optimization")

from the mm-stable tree and commit:

  2f0584f3f4bd ("mm: Rename arch pte_mkwrite()'s to pte_mkwrite_novma()")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/s390/Kconfig
index 661b6de69c27,91514d535c46..000000000000
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@@ -127,7 -127,8 +127,8 @@@ config S39
  	select ARCH_WANTS_NO_INSTR
  	select ARCH_WANT_DEFAULT_BPF_JIT
  	select ARCH_WANT_IPC_PARSE_VERSION
 -	select ARCH_WANT_OPTIMIZE_VMEMMAP
 +	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
+ 	select ARCH_WANT_KERNEL_PMD_MKWRITE
  	select BUILDTIME_TABLE_SORT
  	select CLONE_BACKWARDS2
  	select DMA_OPS if PCI

--Sig_/AhL+NPTLpDTh_deEriG30oW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTa/NEACgkQAVBC80lX
0GzvkAf8DmX5v6WQR0hQ/eFcSXBNphrYPvIIbEfccN4eIV9DEaXudYYjgTIZJdpJ
kLGJgFEDRR05j8E/6KeEJPxjQTVOKUgpsWl3E24ii+r6KtaRULj9Iuve654cPM4S
RxOHsNn8ss7C++ksllcd7aC1ui+hYxXtCc/sS1vR+7h6iEUMVuT9HTDwND3Y/KXu
vsw6jqd6W2QtQnrb9xt+gOx0uzPN1DH21ZREhRDrUnL++nA67HZNjjGbutzoS0ji
OkV2ezyoXGExgXAN/nDcWZn/HzuhFyJGkqNr8jTj8/9ptaUVEzqMl0zB+Wr/lDhU
dISDyEf12rwcGBNpLP2c0gki1Y6HZQ==
=lkpv
-----END PGP SIGNATURE-----

--Sig_/AhL+NPTLpDTh_deEriG30oW--
