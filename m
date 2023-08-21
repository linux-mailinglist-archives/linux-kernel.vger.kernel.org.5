Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AED9782102
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjHUBGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjHUBGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:06:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A6399;
        Sun, 20 Aug 2023 18:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692579996;
        bh=U+DoApGrhEYg9skyatke/aQbjC6SuS7jT2aVsr2aNFM=;
        h=Date:From:To:Cc:Subject:From;
        b=cnwZ4QkQrq52IGnD4GkcoBLXy/aJp+DGfSlUvnW4mE06SB/VL+aGF70EkPekzScbU
         mzW/j2yAHPhjocCBkdcBEduOxibdhWeudkUiNbmza+IjGOkD4ZiV/2dc+dpC1BplpB
         CpLcRyZtA6h8zc+R0jYg2JEFwuZfJ+2QJ+FiGUlwBxum2eJI6LoHQ28aOfgATq+tUt
         W0wAyaDhA6PeCnHYfm2DN1OQpmUgVQYG8hxlyPcazJc3A0oDoCMv01cdG0nzr2R9B7
         qJDYX9V9ih/d9Lx7Y8Km3YGra74vOaI+L+BoayvwFxgG41QYRHrIy/JTibcLKKOpfw
         v4Y85jR253zAw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RTZ7H66zcz4wZn;
        Mon, 21 Aug 2023 11:06:35 +1000 (AEST)
Date:   Mon, 21 Aug 2023 11:06:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20230821110633.432a1599@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ei2v3GXqxFAT/qw0=ZB97_Q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ei2v3GXqxFAT/qw0=ZB97_Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  include/net/inet_sock.h

between commit:

  f866fbc842de ("ipv4: fix data-races around inet->inet_id")

from the net tree and commit:

  c274af224269 ("inet: introduce inet->inet_flags")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/net/inet_sock.h
index 491ceb7ebe5d,acbb93d7607a..000000000000
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@@ -218,12 -218,12 +218,12 @@@ struct inet_sock=20
  #define inet_dport		sk.__sk_common.skc_dport
  #define inet_num		sk.__sk_common.skc_num
 =20
+ 	unsigned long		inet_flags;
  	__be32			inet_saddr;
  	__s16			uc_ttl;
- 	__u16			cmsg_flags;
- 	struct ip_options_rcu __rcu	*inet_opt;
- 	atomic_t		inet_id;
  	__be16			inet_sport;
++	atomic_t		inet_id;
+ 	struct ip_options_rcu __rcu	*inet_opt;
 -	__u16			inet_id;
 =20
  	__u8			tos;
  	__u8			min_ttl;

--Sig_/ei2v3GXqxFAT/qw0=ZB97_Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTiuJoACgkQAVBC80lX
0Gxzmwf6A7r8T2PfS2DmKexlBnvaqDgXR3Zr6XHwLlfGcUH9+9uzEGLU4Lcck3ZE
Bagl8MZQrl200AtZG4ycOvvbS13ZR8S0OCHV6VbQXRkQ27I2YGJuf3Gna0BPdfgp
7gjx90aQHE1DGB404Tc2FOXn61ErOVXUBximGaKwRlqT818N1E78XwpXrXjLe2+W
d/AuKY8evmIuRGbZNEM/tR+M8RqtQevio8m/ZFrZfUI6MKIBt+jwZe8kp1mPWPjZ
RoPkQvOULtQPYjf6jCt77ObtraDc+xtkeqHyMglkVl5M4+6XX8t+VML1CMbuxcO1
k0fdUiTRnDjoHWlDhWeg7nvK8Z2WYQ==
=t4U7
-----END PGP SIGNATURE-----

--Sig_/ei2v3GXqxFAT/qw0=ZB97_Q--
