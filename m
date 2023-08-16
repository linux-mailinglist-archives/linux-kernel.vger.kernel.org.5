Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D51877DB2D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242349AbjHPHPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242339AbjHPHOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:14:44 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F92E2110;
        Wed, 16 Aug 2023 00:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692170081;
        bh=+feYQdKM1V6Lo60EyEJBEmLntK2OJwqq3SvU9qUhFsI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sfq15zyicbDJREJYQXmG2ooXB6gffWT5twNv9Bn6oRAo5tjeIMy4I0dR1Wl2BdE6h
         Ysxy6/sIJtFVTddxueKPF6RVps+KlyynwjzBVWqasBvAGNg77t/4TJCNlOg/nydvch
         sHgJiiLoOLhxuLyyoP6lZ4PW5l6R+U6pLVtqzE5Qn/LkqhMbOl5LPQVPeNnth+oN05
         hRdEZYaj2MIrMktorrc/wthju6ebvcjfXUg3n3CgY6ruXBYO/kRunT9NDayXxfMbJQ
         kCdi37FyiuArXqYEL7KcB4sGZ3lSuV4gVDhgOOgK2C5c7RVvnJBycBMzPb8U+xYL0P
         jXSy1IhfXvDFQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQfXK0XZwz4wb0;
        Wed, 16 Aug 2023 17:14:40 +1000 (AEST)
Date:   Wed, 16 Aug 2023 17:14:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-s390@vger.kernel.org, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next-2023-0815: s390/block/dasd: build error
Message-ID: <20230816170934.71a5e306@oak.ozlabs.ibm.com>
In-Reply-To: <95b176a2-3670-1e89-c8f6-86b094eebc4c@infradead.org>
References: <95b176a2-3670-1e89-c8f6-86b094eebc4c@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kW=O0+B7jK_ZpntnFB2yUm6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kW=O0+B7jK_ZpntnFB2yUm6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Tue, 15 Aug 2023 22:34:19 -0700 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> I have spent some time on this but I don't see where the problem is.
>=20
> ERROR: modpost: "bdev_mark_dead" [drivers/s390/block/dasd_mod.ko] undefin=
ed!
>=20
> CONFIG_BLOCK=3Dy, bdev.o is built and contains the missing symbol.
>=20
> Full randconfig file is attached.
>=20
> Hopefully I'm just overlooking something.

In your config, CONFIG_DASD=3Dm which means "#ifdef CONFIG_DASD" will
fail since CONFIG_DASD_MODULE is defined instead ... so maybe it should
be "#if IS_ENABLED(CONFIG_DASD)" in block/bdev.c.  This also fails an
s390 allmodconfig build (obviously).

So this is caused by commit

  381f678306ce ("block: consolidate __invalidate_device and fsync_bdev")

from the vfs-brauner branch in linux-next.
--=20
Cheers,
Stephen Rothwell

--Sig_/kW=O0+B7jK_ZpntnFB2yUm6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTcd2AACgkQAVBC80lX
0GxgMwf/dh+8co31G3DSQJ3eyvXpUaeisGE0JCkCBmexHbtGM+G+bKOTwxm3NXqC
aheTVU66xx5aQODR1aOdfdd9bRSl959MlQ6Mu7SR7ys/Muvxvf+rv78sIkUYaVw1
I7N6Q7G/G/Hqe/1ebZ29QTJ0gtZ47pG5x/V4882Q6WT64rNcutnbQNnI8vqvqELX
V3FRt1lxlI2bfzlPWTf1AInuqyCQ/khTang5OVXeEk8ctU3J6bsqCB6zpBINwa8j
m8sHfhffMkl44cj8asSQPhppiuLOPSzBC7eE2GMw1i7HenrsEgO8+2tU2g1d0IDC
2f2/KFqR3oxIhmwDb6cFHXSSQJbzrA==
=lP0e
-----END PGP SIGNATURE-----

--Sig_/kW=O0+B7jK_ZpntnFB2yUm6--
