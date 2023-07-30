Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B9476894A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 01:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjG3Xhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 19:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjG3Xhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 19:37:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935EDE7C;
        Sun, 30 Jul 2023 16:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690760247;
        bh=mm6RxOwGfiU74ywzZ1i3ynNKnObG5WZOWaIhzscxZTE=;
        h=Date:From:To:Cc:Subject:From;
        b=rlGB8IBZAIw7rS6mwxOmPu2H3XN6sIG5y9/egkkDypKlueOEzuZXaXFIitixoBxQ0
         dkIE3eU2d/S6ySwKJc2fSlA/Kl7wHW12FK8X9L2SEnipkdlTnoO4Y7KPmchyXLYPzE
         2LHUMWTeT42L3RjMuBSj/6xWnW1PlmlHbGTN6JaksdnGqfY7ltxu3ncMwJqRg1Lciw
         mIrhuFpv0elH3a+BTRFFYn1uN5YQgzw5BQApL8DOo9kWOKGZNS7eo5X25nbKjkj6GE
         P8a0zKrQ4SayPDufjKfuHQD6EVtbv/YT1inF4bP7YXz6UOl7LP/Y78c2tHD0v5YFpT
         RqfOazTKaNtKQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RDd8724Zrz4wbv;
        Mon, 31 Jul 2023 09:37:27 +1000 (AEST)
Date:   Mon, 31 Jul 2023 09:37:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Anastasia Eskova <anastasia.eskova@ibm.com>,
        Costa Shulyupin <costa.shul@redhat.com>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: linux-next: manual merge of the s390 tree with the mm tree
Message-ID: <20230731093724.1c75858d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vjBWBHUZn9SzQEm.9tRgpLH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vjBWBHUZn9SzQEm.9tRgpLH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the s390 tree got a conflict in:

  arch/s390/Kconfig

between commits:

  e86a64d19d20 ("s390/kexec: refactor for kernel/Kconfig.kexec")
  54d5daef8143 ("kexec: rename ARCH_HAS_KEXEC_PURGATORY")

from the mm tree and commits:

  8cf57d7217c3 ("s390: add support for user-defined certificates")
  37002bc6b603 ("docs: move s390 under arch")
  b90a64caf844 ("s390/cert_store: select CRYPTO_LIB_SHA256")

from the s390 tree.

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
index 42c98931de2c,18bf754e1fad..000000000000
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@@ -246,28 -245,6 +247,28 @@@ config PGTABLE_LEVEL
 =20
  source "kernel/livepatch/Kconfig"
 =20
 +config ARCH_DEFAULT_KEXEC
 +	def_bool y
 +
 +config ARCH_SUPPORTS_KEXEC
 +	def_bool y
 +
 +config ARCH_SUPPORTS_KEXEC_FILE
 +	def_bool CRYPTO && CRYPTO_SHA256 && CRYPTO_SHA256_S390
 +
 +config ARCH_SUPPORTS_KEXEC_SIG
 +	def_bool MODULE_SIG_FORMAT
 +
 +config ARCH_SUPPORTS_KEXEC_PURGATORY
 +	def_bool KEXEC_FILE
 +
 +config ARCH_SUPPORTS_CRASH_DUMP
 +	def_bool y
 +	help
- 	  Refer to <file:Documentation/s390/zfcpdump.rst> for more details on th=
is.
++	  Refer to <file:Documentation/arch/s390/zfcpdump.rst> for more details =
on this.
 +	  This option also enables s390 zfcpdump.
- 	  See also <file:Documentation/s390/zfcpdump.rst>
++	  See also <file:Documentation/arch/s390/zfcpdump.rst>
 +
  menu "Processor type and features"
 =20
  config HAVE_MARCH_Z10_FEATURES
@@@ -506,6 -483,47 +507,17 @@@ config SCHED_TOPOLOG
 =20
  source "kernel/Kconfig.hz"
 =20
 -config KEXEC
 -	def_bool y
 -	select KEXEC_CORE
 -
 -config KEXEC_FILE
 -	bool "kexec file based system call"
 -	select KEXEC_CORE
 -	depends on CRYPTO
 -	depends on CRYPTO_SHA256
 -	depends on CRYPTO_SHA256_S390
 -	help
 -	  Enable the kexec file based system call. In contrast to the normal
 -	  kexec system call this system call takes file descriptors for the
 -	  kernel and initramfs as arguments.
 -
 -config ARCH_HAS_KEXEC_PURGATORY
 -	def_bool y
 -	depends on KEXEC_FILE
 -
 -config KEXEC_SIG
 -	bool "Verify kernel signature during kexec_file_load() syscall"
 -	depends on KEXEC_FILE && MODULE_SIG_FORMAT
 -	help
 -	  This option makes kernel signature verification mandatory for
 -	  the kexec_file_load() syscall.
 -
 -	  In addition to that option, you need to enable signature
 -	  verification for the corresponding kernel image type being
 -	  loaded in order for this to work.
 -
+ config CERT_STORE
+ 	bool "Get user certificates via DIAG320"
+ 	depends on KEYS
+ 	select CRYPTO_LIB_SHA256
+ 	help
+ 	  Enable this option if you want to access user-provided secure boot
+ 	  certificates via DIAG 0x320.
+=20
+ 	  These certificates will be made available via the keyring named
+ 	  'cert_store'.
+=20
  config KERNEL_NOBP
  	def_bool n
  	prompt "Enable modified branch prediction for the kernel by default"

--Sig_/vjBWBHUZn9SzQEm.9tRgpLH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTG9DQACgkQAVBC80lX
0Gxgpwf/XOvFaXEfeeAij5RL2JQuTdXbqzDqNo3SN6E2B4NO3J9I4g6S4RrDRhpx
GdCLBIgTlooD0wNb8vnKXCtuTmK1B1STZXp/oywjH1TOeRFvAvd5ABf0F/VP8xGB
jLKz4o6ohII9SRkXyjzCUUgYcUeRnsHsgajLjPEUWpXg3ax/DwxttkjNUY5PzlDU
aKi5yHTowFqIDuPbE9eUVnK4JGLSGNrwSSWrJRqvp3yEbnfhjrsxMLfzQrUQn07D
YlDXv3XxfyRjah+TcVqYn8E4O1etkcvobWRS81ii+oHzMpFGL2wTzp588TUkxD3m
XeJd5NemYtKWVYG4O6KC0xoJp3Kbrg==
=xMss
-----END PGP SIGNATURE-----

--Sig_/vjBWBHUZn9SzQEm.9tRgpLH--
