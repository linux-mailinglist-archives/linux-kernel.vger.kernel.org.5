Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9566776A684
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjHABms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjHABmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:42:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24DF1BF1;
        Mon, 31 Jul 2023 18:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690854137;
        bh=R0PEe73zlfYAKebLRzhdfAzKrKATJClV0PH4WjYF9+Y=;
        h=Date:From:To:Cc:Subject:From;
        b=JoH0sr+YSK8u4uQc94xxJYtL0S7C1R0vkckil6rOa2KHb7cYTnbAFpzwKU5spHrER
         kaqMVgKdhEzIySPt9FF7MnspVVSf/hCU342ZLO8t1oX0Wj/sf/t59WcNULrkv9h7Yi
         ETuvuOOsmSOcYCfqrMUZG2jbGogMwOuBvozjZ5+bja1QE72zYeJy1GTC1dN3acqBGR
         s1EM4fPyMtiA2JgPAkQQzcuMVGwMveU0/lK2DKCLux/GVnfKTs3LdawYtW/HtP21Kf
         Rrlcv853z3Szq0Cr/Ratnhxr4UaLJRw5/7AWBv2J4uvvx0neH2q9njEiBsr4Y4rRQA
         E9sXHH38Rs8mw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RFHsg6VQwz4wZw;
        Tue,  1 Aug 2023 11:42:15 +1000 (AEST)
Date:   Tue, 1 Aug 2023 11:42:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the security tree with the net-next
 tree
Message-ID: <20230801114214.2e169762@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SlBZ/wYr8B1uaHmZK/xISTS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SlBZ/wYr8B1uaHmZK/xISTS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the security tree got a conflict in:

  security/security.c

between commit:

  5b52ad34f948 ("security: Constify sk in the sk_getsecid hook.")

from the net-next tree and commit:

  bd1f5934e460 ("lsm: add comment block for security_sk_classify_flow LSM h=
ook")

from the security tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc security/security.c
index 2dfc7b9f6ed9,9177fd0968bd..000000000000
--- a/security/security.c
+++ b/security/security.c
@@@ -4396,7 -4421,14 +4421,14 @@@ void security_sk_clone(const struct soc
  }
  EXPORT_SYMBOL(security_sk_clone);
 =20
+ /**
+  * security_sk_classify_flow() - Set a flow's secid based on socket
+  * @sk: original socket
+  * @flic: target flow
+  *
+  * Set the target flow's secid to socket's secid.
+  */
 -void security_sk_classify_flow(struct sock *sk, struct flowi_common *flic)
 +void security_sk_classify_flow(const struct sock *sk, struct flowi_common=
 *flic)
  {
  	call_void_hook(sk_getsecid, sk, &flic->flowic_secid);
  }

--Sig_/SlBZ/wYr8B1uaHmZK/xISTS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTIYvYACgkQAVBC80lX
0GxibAf/V0a39pcCXf9IcteRyqNunHpmz4gxlVi7pAUrGkNWZ5HSGOZqW6YzjcUG
021K7vdkI907fOtYQ78FpckhEykLY2Ibi0iwUezNmd39ycPniL3QTxWzOk6p4N/I
S5CaQfh9Xib03TWFhoNcMOvHY37RpLMXKbii8Njv8M4DwlwVVtrR1fxmFFoezYlO
ehGSZRjaEPLDDLze+hxAZi5XRvwdWYW77GuRwSbqw/letpC3r+0jbe6lP0jVGB3F
BS39zrSDb50l4nN8W6KkIhVSBUckBqgbJlx16VY67aJwov+yTjGqQJCAmgC/Yh7u
RG0MlqdcCrw+aMtIGZi9Sx6XFmzXeg==
=LR5K
-----END PGP SIGNATURE-----

--Sig_/SlBZ/wYr8B1uaHmZK/xISTS--
