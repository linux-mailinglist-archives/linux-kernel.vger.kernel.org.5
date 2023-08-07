Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDED7717DE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 03:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjHGBhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 21:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGBhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 21:37:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8821713;
        Sun,  6 Aug 2023 18:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691372215;
        bh=qYPlWaK95QOudWfmyyYQimN/oDRqRiEx4gbDGuC/L2U=;
        h=Date:From:To:Cc:Subject:From;
        b=RAr4mIkwQW2hGPy5ZYiTUz/cAuUG/ChZyigawb8Nr4wEQ1D0osIJNMQBuAEVek6TP
         UkTMZlGE4nuiadTj0quLFRWXIN+VGzzCC5ds2/iUX4eaxmhwjYVKKuuDQx4iYXNA3s
         eKps1Z4ERlwdE7sTcgCeCErl2AlFZ90/H0tma070IZ6nVwQDcWPLaw9BksPX9JpvOs
         UYvvxN9b1080nLPrJj2g416Gbg5ECNBoh9TWCV5OVCXS7JnPAL8JTu60rraEIt7KdX
         0j/3/nAhyBmGo1Sn+uVxb4qQ9oWuBojtKfCN5hpNkk81kwMW+z6g9A0ro6SMSp4zwu
         uxOaM4XPMVE2w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RJzSl31Mnz4wxQ;
        Mon,  7 Aug 2023 11:36:55 +1000 (AEST)
Date:   Mon, 7 Aug 2023 11:36:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Danilo Krummrich <dakr@redhat.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20230807113654.2979f61d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/P.sraW1v6VilysQk=hTs9d8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P.sraW1v6VilysQk=hTs9d8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/nouveau/nouveau_dmem.c: In function 'nouveau_dmem_migrate_c=
hunk':
drivers/gpu/drm/nouveau/nouveau_dmem.c:681:43: error: 'chunk' undeclared (f=
irst use in this function)
  681 |                 nouveau_fence_emit(fence, chunk->drm->dmem->migrate=
.chan);
      |                                           ^~~~~

Caused by commit

  7f2a0b50b2b2 ("drm/nouveau: fence: separate fence alloc and emit")

I have used the drm-misc tree from next-20230804 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/P.sraW1v6VilysQk=hTs9d8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTQSrYACgkQAVBC80lX
0GxyLAf9GHKNNoetGmEyq0zMc8qYcdTC3jBt2sIP4QnQwkPsjDuWvsNUfqTLtJTC
F3oxGntYtxBWW4Au7Oku8xOY1PZKCGbS8toY/FmYTO6ZYniLcngSuaLHLvDMZqov
M3mS6iUVQTxJKH/8V4koVBD7I0U5QZZqM66P+MqET6XJlUfBGP9S3Pt5lI5oRvg2
FviknAGPk3+dGKLKkv6/yowtYHVhHVFZKXzV4nXQ3Tw3dwZKF7KqgOnwAerZCZqX
eKJufgIHBoTp23AiHoGfb8xs6tqVX/2komDOSsnwTqny9l6J+OXx6HUYcHlAovDB
bPgj9q6lurdEyiW+YwVwuN5fi3l+fQ==
=vXDQ
-----END PGP SIGNATURE-----

--Sig_/P.sraW1v6VilysQk=hTs9d8--
