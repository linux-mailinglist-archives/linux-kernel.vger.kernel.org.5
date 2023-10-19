Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D4C7CEF53
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjJSFs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbjJSFs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:48:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3E8B6;
        Wed, 18 Oct 2023 22:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697694527;
        bh=CR7dWSEwjH6imZHnVlXAbeQgnXp1ZZMTjjN1Ld5riCc=;
        h=Date:From:To:Cc:Subject:From;
        b=W1EOf7KB8sRaSXlw9dVE0T0wXyu1Oyqnzkx0PJNcwP5Q2nbMp0apO4UJHlIciNHRk
         3kMzxiWUH5Z2mV0xY95EP9WXEl3If65YbcBpSNzCvrE3J4Xn94sj67kQhNEjObHOTi
         1Dbx4XTWm49rA+UA9tv98qjsngmFQ8VxvJptN6cTEKReQsdLK68fUf4Hs0QKUe8tC7
         ArKUDEs2nKzd8JVTR8hHeBNyx2I8oS/3Z1LlzQc5yMg9ZpKUwwzwh2uWIxjUgtbNMS
         zWmsBN6FGZf+sjrYpM0NaXgVljCVXIfYJWI/kH/KpFK3okTvGn8Qg67ECIg5vvRxVo
         YhDorjcy8HzEw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9xbf4FkWz4xQQ;
        Thu, 19 Oct 2023 16:48:46 +1100 (AEDT)
Date:   Thu, 19 Oct 2023 16:48:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Paul Greenwalt <paul.greenwalt@intel.com>,
        Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: linux-next: manual merge of the bitmap tree with the net-next tree
Message-ID: <20231019164844.4cc37f93@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iYTkWDP_1_tS6QBLU_WRv4Z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iYTkWDP_1_tS6QBLU_WRv4Z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bitmap tree got a conflict in:

  include/linux/linkmode.h

between commit:

  26c5334d344d ("ethtool: Add forced speed to supported link modes maps")

from the net-next tree and commit:

  f849608560af ("linkmode: convert linkmode_{test,set,clear,mod}_bit() to m=
acros")

from the bitmap tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/linkmode.h
index cd38f89553e6,f231e2edbfa5..000000000000
--- a/include/linux/linkmode.h
+++ b/include/linux/linkmode.h
@@@ -2,21 -2,6 +2,18 @@@
  #define __LINKMODE_H
 =20
  #include <linux/bitmap.h>
 +
- static inline void linkmode_set_bit(int nr, volatile unsigned long *addr)
- {
- 	__set_bit(nr, addr);
- }
++#define linkmode_set_bit	__set_bit
 +
 +static inline void linkmode_set_bit_array(const int *array, int array_siz=
e,
 +					  unsigned long *addr)
 +{
 +	int i;
 +
 +	for (i =3D 0; i < array_size; i++)
 +		linkmode_set_bit(array[i], addr);
 +}
 +
  #include <linux/ethtool.h>
  #include <uapi/linux/ethtool.h>
 =20
@@@ -53,25 -38,20 +50,10 @@@ static inline int linkmode_andnot(unsig
  	return bitmap_andnot(dst, src1, src2,  __ETHTOOL_LINK_MODE_MASK_NBITS);
  }
 =20
- static inline void linkmode_clear_bit(int nr, volatile unsigned long *add=
r)
- {
- 	__clear_bit(nr, addr);
- }
-=20
- static inline void linkmode_mod_bit(int nr, volatile unsigned long *addr,
- 				    int set)
- {
- 	if (set)
- 		linkmode_set_bit(nr, addr);
- 	else
- 		linkmode_clear_bit(nr, addr);
- }
-=20
- static inline int linkmode_test_bit(int nr, const volatile unsigned long =
*addr)
- {
- 	return test_bit(nr, addr);
- }
+ #define linkmode_test_bit	test_bit
 -#define linkmode_set_bit	__set_bit
+ #define linkmode_clear_bit	__clear_bit
+ #define linkmode_mod_bit	__assign_bit
 =20
 -static inline void linkmode_set_bit_array(const int *array, int array_siz=
e,
 -					  unsigned long *addr)
 -{
 -	int i;
 -
 -	for (i =3D 0; i < array_size; i++)
 -		linkmode_set_bit(array[i], addr);
 -}
 -
  static inline int linkmode_equal(const unsigned long *src1,
  				 const unsigned long *src2)
  {

--Sig_/iYTkWDP_1_tS6QBLU_WRv4Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUwwzwACgkQAVBC80lX
0Gw8dQf/ckBlyqp0x9E8fPVAlHEGxWz7oIixRXFmyKVZtQX+FBMrvd+8ZgWRtjvk
UjnR7VBJnwW5dPik7yaw+9dkdwZX7xFx8ALRAt24bMdf3idw2nD3/djdr+EjnEz7
rlAajFjWOFfCuvbx3DAMwZT5yWJkdCzy5qxhhmNMHpku0oQv2E13W+bgb/rGFQbb
kyXJwRITcfuoVkLZDv3dfcwueSFu29kty8hBP2dej037TgBSPaG2kej62HWyKH4s
gZEATqGiQQgKvwRHLAmGk7B08TZBqrjieO/mwF+V7sGvaf+UF8R6BP/+UpmrLx8V
mXGwoP4E023L9ekDlPpSK8Z2DeK+FQ==
=C7Mx
-----END PGP SIGNATURE-----

--Sig_/iYTkWDP_1_tS6QBLU_WRv4Z--
