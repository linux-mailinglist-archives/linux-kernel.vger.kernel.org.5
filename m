Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661F77D46AA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 06:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjJXELu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 00:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjJXELp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 00:11:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C994B10E;
        Mon, 23 Oct 2023 21:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698120701;
        bh=Ou9+eoT1DfUcoGZAKsecRDOEYriRBnaZ7ZxjIG/Npuo=;
        h=Date:From:To:Cc:Subject:From;
        b=c2t8Cg8cTALBbYqgNYbdoRl11YblEIICLP9m86x80kK2deliUwR7hKJNdEYtXvndK
         AqK6nL3fShdu9Krwa5Zo46ETrdy9BadWa0R0JoYGM4LSsZKi6X7qdHiXvESkOVeytc
         31vfYBbBZBgZXaRG361Jp+IgdeY0odWwjL0PHXqhBnem4cT7XtX2KVLtS1+n5fwgu0
         cCJg+wOA5FdnnXR00VRq/eA7yw5XHX8tTmIKic3GZWbaq6HkhMJ4K7wBC9gVDzRChD
         lnbW2qpvlDMcfzAog3kokGbaL2tXlzzUDqPhP75j56WWNsAGqZPhUYoT+MfsbmFJ67
         SteRo6jQ0EtiA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SDzCJ1Q0cz4wd2;
        Tue, 24 Oct 2023 15:11:39 +1100 (AEDT)
Date:   Tue, 24 Oct 2023 15:11:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dipen Patel <dipenp@nvidia.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the hte tree with the gpio-brgl tree
Message-ID: <20231024151138.74b045ce@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lojYEUpnjkKC_U36m+RmUz/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lojYEUpnjkKC_U36m+RmUz/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the hte tree got a conflict in:

  drivers/hte/Kconfig

between commit:

  9bc633117d6a ("hte: tegra194: add GPIOLIB dependency")

from the gpio-brgl tree and commit:

  63137bee5a7a ("hte: allow building modules with COMPILE_TEST enabled")

from the hte tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/hte/Kconfig
index 8e0fd818a73e,083e67492bf2..000000000000
--- a/drivers/hte/Kconfig
+++ b/drivers/hte/Kconfig
@@@ -16,8 -16,7 +16,8 @@@ if HT
 =20
  config HTE_TEGRA194
  	tristate "NVIDIA Tegra194 HTE Support"
- 	depends on ARCH_TEGRA_194_SOC
+ 	depends on (ARCH_TEGRA_194_SOC || COMPILE_TEST)
 +	depends on GPIOLIB
  	help
  	  Enable this option for integrated hardware timestamping engine also
  	  known as generic timestamping engine (GTE) support on NVIDIA Tegra194

--Sig_/lojYEUpnjkKC_U36m+RmUz/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU3Q/oACgkQAVBC80lX
0GzmIwf/WO100H/5y/7Oz7WFHUnguvhiaUyG2JRJBXwBMEcG85fwWZh7koIIrkn4
n4SBBeWUCVtOZxu0n3abYWLIiUSzwpIUN24+sccg/8tqgz3rcFSBBJPpfra46iDA
uefC6THxGj+LLiGTC4NTGpRvaP0gYTfy3GOWhUFkfIy2xV16A7ZVXpgC9httbiii
TiMb+YmC86jvzPmi6T21od55MJgzVQ1HrqPxcAt87imdo7GID9/ZpZIFdOgjkLFt
LlTipZTK81qZT8WdUavUUOzEgtOkfAiy3QTi5lIDo66PcglpgF4iHh67k1fpFstb
2Ip8C9CZrzGFScFM9BukzKq6CFpeqw==
=nJpq
-----END PGP SIGNATURE-----

--Sig_/lojYEUpnjkKC_U36m+RmUz/--
