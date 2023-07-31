Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7606576895F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 02:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjGaA0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 20:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjGaA0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 20:26:41 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B861B2;
        Sun, 30 Jul 2023 17:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690763195;
        bh=jVgBHko4/t4VVInw6sHfaCve6iYjTk+iGD9K7W3Ov68=;
        h=Date:From:To:Cc:Subject:From;
        b=invuTBDQNwM6PesMNBB//vWOz1iqarqra+if+jSzKfYezCRTCIJ8mjsPpoFGjcHQ8
         9pm1Et5VrNWm/D5ST3W4q9nhocGZPbkn4+keiYCietBiY7F+ASBpMaUD/IRH5UxvsM
         2Kk6tYEWN8BwaYBsTJx3GjTz48ZZgqf6B+A3Z+PNGoWERTI23u5gKpq14bIAU7Ghdd
         liOkZXDnBei7CYvQIGXJOTu4HxakDINHToeLTE5mOK9UkGanx5fbOEv3BNfovYqlSd
         5e28BUTsVRKkrRkcQhDkZ7RZCwVc34vnJI0WjwUrZxCUCete1rPKHakN5XyqnaetWr
         JXS0zuXOkj8Cw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RDfDp2FQ8z4wb8;
        Mon, 31 Jul 2023 10:26:34 +1000 (AEST)
Date:   Mon, 31 Jul 2023 10:26:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20230731102631.39988412@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cX8lMK13kAw0SPqGo9uxz9X";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cX8lMK13kAw0SPqGo9uxz9X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  net/xdp/xsk.c

between commit:

  3c5b4d69c358 ("net: annotate data-races around sk->sk_mark")

from the net tree and commit:

  b7f72a30e9ac ("xsk: introduce wrappers and helpers for supporting multi-b=
uffer in Tx path")

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

diff --cc net/xdp/xsk.c
index b89adb52a977,4f1e0599146e..000000000000
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@@ -505,11 -682,22 +682,22 @@@ static struct sk_buff *xsk_build_skb(st
 =20
  	skb->dev =3D dev;
  	skb->priority =3D xs->sk.sk_priority;
 -	skb->mark =3D xs->sk.sk_mark;
 +	skb->mark =3D READ_ONCE(xs->sk.sk_mark);
- 	skb_shinfo(skb)->destructor_arg =3D (void *)(long)desc->addr;
  	skb->destructor =3D xsk_destruct_skb;
+ 	xsk_set_destructor_arg(skb);
 =20
  	return skb;
+=20
+ free_err:
+ 	if (err =3D=3D -EAGAIN) {
+ 		xsk_cq_cancel_locked(xs, 1);
+ 	} else {
+ 		xsk_set_destructor_arg(skb);
+ 		xsk_drop_skb(skb);
+ 		xskq_cons_release(xs->tx);
+ 	}
+=20
+ 	return ERR_PTR(err);
  }
 =20
  static int __xsk_generic_xmit(struct sock *sk)

--Sig_/cX8lMK13kAw0SPqGo9uxz9X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTG/7cACgkQAVBC80lX
0GwVwgf/dK1xBNDlQv2abVMZNDtwbpTO1NdSgKgo8Tkk/OSHY300hlwYFdUn6d6S
/LzMrQWTpNwIwspFQBK8pi6Dg5Gjehk/qfBhi29i7gYrby241a6tMnpEHhmmXL0L
DGz5i6CYwg/Xc6eikgvgur+YNHUSiYL4HLFEWiqQRsyFJAckGMeLdUtDAKI7xZdh
OkoS0/qWoz9QINd+E781h4BHWzRQy/zEFlis5VAgp+jYFuc0v0PeH8N6KC7SjKM1
V+MiOrRZ2+cbgu2H+gUmXdYNH4WxUtani2+z7K+LtswUNDyyXwf7cGDWaaLiINTn
HliM9U+vzUw0stX/SmoWeitM0dpeaw==
=LGIa
-----END PGP SIGNATURE-----

--Sig_/cX8lMK13kAw0SPqGo9uxz9X--
