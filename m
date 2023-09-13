Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C1779F4CD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 00:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjIMWOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 18:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjIMWOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 18:14:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C311996;
        Wed, 13 Sep 2023 15:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694643243;
        bh=Yc79kZstegY2MgDJ+A93XCaJaTftTDq8DtZ/AeBZWgE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nqaDFJzNBxhN71nHpw2Fjuj3yUferW24HDRwvvGCglXoEjybqrVUrc6xGLT2vl8FK
         d1wm5ypI0Kc7SJPECo5wO4IJvhcYG7p5tKrOtdiyN0BjfKmAOnfpPC4hlMSfQi/cAW
         SBvNqG38KvDGeFnAsXQbq87QN11A2ni5zr7xMKXGQXM73Iq5QtqVWCNufbpuI/Ssjz
         Jh0XWwbaRcOX9Acffruj0CmP5rtTwNDMsRXspVhY9UtszApSN6EualnhOcO28MsRlb
         W/78TwgaNLJV20rX+cW5Bl4q2T35QZEMS592bszoAUycLAUoaFe+uMm2IKMrlErPFD
         xwFqy7GcKPPRQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RmF966DxFz4wxf;
        Thu, 14 Sep 2023 08:14:02 +1000 (AEST)
Date:   Thu, 14 Sep 2023 08:14:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bcachefs tree
Message-ID: <20230914081400.5d9e5b8f@canb.auug.org.au>
In-Reply-To: <20230912120429.7852428f@canb.auug.org.au>
References: <20230912120429.7852428f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TJF0qsaXAVjLHvoEJXlN/8F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TJF0qsaXAVjLHvoEJXlN/8F
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 12 Sep 2023 12:04:29 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the bcachefs tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> fs/bcachefs/btree_cache.c: In function 'bch2_fs_btree_cache_exit':
> fs/bcachefs/btree_cache.c:403:9: error: implicit declaration of function =
'unregister_shrinker'; did you mean 'unregister_chrdev'? [-Werror=3Dimplici=
t-function-declaration]
>   403 |         unregister_shrinker(&bc->shrink);
>       |         ^~~~~~~~~~~~~~~~~~~
>       |         unregister_chrdev
> fs/bcachefs/btree_cache.c: In function 'bch2_fs_btree_cache_init':
> fs/bcachefs/btree_cache.c:479:15: error: implicit declaration of function=
 'register_shrinker'; did you mean 'register_chrdev'? [-Werror=3Dimplicit-f=
unction-declaration]
>   479 |         ret =3D register_shrinker(&bc->shrink, "%s/btree_cache", =
c->name);
>       |               ^~~~~~~~~~~~~~~~~
>       |               register_chrdev
> cc1: all warnings being treated as errors
>=20
> Caused by commits
>=20
>   5ec30115c066 ("bcachefs: Initial commit")
>=20
> interacting with commit
>=20
>   eba045d9350d ("mm: shrinker: remove old APIs")
>=20
> from v6.6-rc1.

This latter commit is actually in the mm tree and is now commit

  d3ed57149dec ("mm: shrinker: remove old APIs")

--=20
Cheers,
Stephen Rothwell

--Sig_/TJF0qsaXAVjLHvoEJXlN/8F
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUCNCgACgkQAVBC80lX
0Gx5WQgAjnorkenbowZRRxj7bh6wVE9bBrQqFhyKbXhx/L+Tf04wm2m2CarbrNdN
FE0QCovckdbN9N/2jBpAd1tuTNW8g+a2IFCvwTh1IIrXUv9cUry1Pz4kkWiRXeso
oJ0fFAHPQkCVJ8RGZdCj4zf53RtWyJkFZ7GRElmD+hsVFZdbF8DHMOuq2nnam7yn
8cnlEX20jRQUWXb35wSBJwh/f89U3QjgTtce98QFZ9hJWnMPRv6SP8PnbxUxiXWQ
KCe/B4fErMci4KdkJJKPyS6Hfzdi5SvrtF7lP0QZu/0pOzUtlevheWWmdYJq4Xun
mqPJWTpcLPzhaNZf2Qs4vTgC9pDohA==
=3jSd
-----END PGP SIGNATURE-----

--Sig_/TJF0qsaXAVjLHvoEJXlN/8F--
