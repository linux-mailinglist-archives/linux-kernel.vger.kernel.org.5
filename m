Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBB27DD89B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 23:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344888AbjJaWuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 18:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344196AbjJaWuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 18:50:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B42B9;
        Tue, 31 Oct 2023 15:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698792603;
        bh=TGLDyaxbXwrRXxeoq6uzWjCu5hnLNuWS15sOBL5JZQc=;
        h=Date:From:To:Cc:Subject:From;
        b=QcdMIQWLryv6F7kJHQ3a3WJ8m3eoXkiVKHzBWp3KRWu2YNdQS5Oq6jvtDFxZNP5Iv
         9K3Akj9WRTNbZdS0dGmJ07LlTXRd5NI2z+6v47CnaSF+AKWzOWF7Bh0JLsDf12KBRM
         +9afXB39vH5tYA0Zi/YJxyh/eQHGwK7EL5YoCEUag15Yrvb/hrN/q8kml2jnq7e2Pc
         XKVgHqY2EQzdJ8nywqyFJM67Nk1P1nJO3QTY7E2enQdc9b1eNGzxSRW3MySqyVDlyf
         IS9vttrG0c7dO3oCSXorljBWlQqOoLuL/98iZRnSbytj6P3AFMk7ZY8N6g+Pap9faF
         +DHY7X1IE8GQw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SKlhW1dykz4wcH;
        Wed,  1 Nov 2023 09:50:03 +1100 (AEDT)
Date:   Wed, 1 Nov 2023 09:50:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bcachefs tree with the mm tree
Message-ID: <20231101095002.737cedb8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UjKdMn7cI9InZx1MbFBjZO4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UjKdMn7cI9InZx1MbFBjZO4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bcachefs tree got conflicts in:

  fs/bcachefs/btree_cache.c
  fs/bcachefs/btree_key_cache.c

between commit:

  e1ae18bfd5bc ("Merge branch 'mm-everything' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/akpm/mm")
(this merge commit includes fix up for the shrinker allocation changes)

from the mm tree and commit:

  a1d97d8417d3 ("bcachefs: Fix shrinker names")

from the bcachefs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/bcachefs/btree_cache.c
index 5e5858191905,0b084fbc478a..000000000000
--- a/fs/bcachefs/btree_cache.c
+++ b/fs/bcachefs/btree_cache.c
@@@ -472,15 -473,12 +472,15 @@@ int bch2_fs_btree_cache_init(struct bch
 =20
  	mutex_init(&c->verify_lock);
 =20
- 	shrink =3D shrinker_alloc(0, "%s/btree_cache", c->name);
 -	bc->shrink.count_objects	=3D bch2_btree_cache_count;
 -	bc->shrink.scan_objects		=3D bch2_btree_cache_scan;
 -	bc->shrink.seeks		=3D 4;
 -	ret =3D register_shrinker(&bc->shrink, "%s-btree_cache", c->name);
 -	if (ret)
++	shrink =3D shrinker_alloc(0, "%s-btree_cache", c->name);
 +	if (!shrink)
  		goto err;
 +	bc->shrink =3D shrink;
 +	shrink->count_objects	=3D bch2_btree_cache_count;
 +	shrink->scan_objects	=3D bch2_btree_cache_scan;
 +	shrink->seeks		=3D 4;
 +	shrink->private_data	=3D c;
 +	shrinker_register(shrink);
 =20
  	return 0;
  err:
diff --cc fs/bcachefs/btree_key_cache.c
index f9a5e38a085b,3304bff7d464..000000000000
--- a/fs/bcachefs/btree_key_cache.c
+++ b/fs/bcachefs/btree_key_cache.c
@@@ -1038,15 -1039,11 +1038,15 @@@ int bch2_fs_btree_key_cache_init(struc
 =20
  	bc->table_init_done =3D true;
 =20
- 	shrink =3D shrinker_alloc(0, "%s/btree_key_cache", c->name);
 -	bc->shrink.seeks		=3D 0;
 -	bc->shrink.count_objects	=3D bch2_btree_key_cache_count;
 -	bc->shrink.scan_objects		=3D bch2_btree_key_cache_scan;
 -	if (register_shrinker(&bc->shrink, "%s-btree_key_cache", c->name))
++	shrink =3D shrinker_alloc(0, "%s-btree_key_cache", c->name);
 +	if (!shrink)
  		return -BCH_ERR_ENOMEM_fs_btree_cache_init;
 +	bc->shrink =3D shrink;
 +	shrink->seeks		=3D 0;
 +	shrink->count_objects	=3D bch2_btree_key_cache_count;
 +	shrink->scan_objects	=3D bch2_btree_key_cache_scan;
 +	shrink->private_data	=3D c;
 +	shrinker_register(shrink);
  	return 0;
  }
 =20

--Sig_/UjKdMn7cI9InZx1MbFBjZO4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVBhJoACgkQAVBC80lX
0GxZzQf/c88Z/IHte83IQmkmqGnYLsMXRdNUPY2G0sWJwKdWqPtuPqfjNEhIwqp7
RKvB35VGrt+FWiWEyXa9QGLvH3JT6/CNJrG43eBJCLFkrUCNw0a3na0r+AEYBtcY
YGSwW1mx4nGyAU03wZfHXx1DDiAdedhKUPO0B0eUI5vTklCBCUUOGKIe8My8lY4z
D02BnOnvcKfJ5AIhNQSYsW+5+iCDyLW8uEuY9dOhTUKQL8aqRhIbLyUmYb3xTTa9
pxqYs4YNV2nnlUkPO6WOgN6Wn06iD3fE4Msxi+NCP+XrJYD/K+Za1wUsiNJZs1nJ
2DtZSoh8ecuWBmk19fBQDpMnjizD9A==
=U57/
-----END PGP SIGNATURE-----

--Sig_/UjKdMn7cI9InZx1MbFBjZO4--
