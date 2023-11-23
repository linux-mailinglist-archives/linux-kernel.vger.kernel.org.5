Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC317F55D9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 02:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjKWB0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 20:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWB0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 20:26:46 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F040692;
        Wed, 22 Nov 2023 17:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700702805;
        bh=IvHOIfA9qWAsQrGBj3amwIrNeIf7IUTRccGXal+xPcU=;
        h=Date:From:To:Cc:Subject:From;
        b=XQ4f6cQVUu8tSG249lzsIhe6vh0FaOqRbogdowx0gLFZv6Pym6CsV4mV/HbJqXP7I
         QepilpT2t0ROYEcsAGeoQ5gOfx4AbMaIadYva821Ml5i3NvFPlZUoxE2Z7SeDLzgL9
         l2FWnDpxwiTYLOQwq8ejPMyWDOSoyWWb/GfQ/cSkU2j68CDjJNaj1J+7DgpE8MGK30
         mgtojoYtrNJBNWddpY75pbujszz4W4UmcuODb8g+rT4dexZyKI9mmmEcB48MsMMbPd
         tH+IG0pf9AAmJsh3TarBkQWmeJDpYSEh8j9FdYzBoUHDrQ6S6a/aXzHgS773ZHltgT
         dbeUUAjb5CYQA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SbL795Pwbz4x1R;
        Thu, 23 Nov 2023 12:26:45 +1100 (AEDT)
Date:   Thu, 23 Nov 2023 12:26:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tejun Heo <tj@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: linux-next: manual merge of the cgroup tree with the workqueues
 tree
Message-ID: <20231123122644.34518972@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0OHAM0=zUMJT0.mKO+UsGF1";
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

--Sig_/0OHAM0=zUMJT0.mKO+UsGF1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the cgroup tree got a conflict in:

  kernel/workqueue.c

between commit:

  4a6c5607d450 ("workqueue: Make sure that wq_unbound_cpumask is never empt=
y")

from the workqueues tree and commit:

  fe28f631fa94 ("workqueue: Add workqueue_unbound_exclude_cpumask() to excl=
ude CPUs from wq_unbound_cpumask")

from the cgroup tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/workqueue.c
index 2989b57e154a,2fc585d3d6ca..000000000000
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@@ -6542,11 -6606,14 +6614,14 @@@ void __init workqueue_init_early(void
  	BUILD_BUG_ON(__alignof__(struct pool_workqueue) < __alignof__(long long)=
);
 =20
  	BUG_ON(!alloc_cpumask_var(&wq_unbound_cpumask, GFP_KERNEL));
+ 	BUG_ON(!alloc_cpumask_var(&wq_requested_unbound_cpumask, GFP_KERNEL));
+ 	BUG_ON(!zalloc_cpumask_var(&wq_isolated_cpumask, GFP_KERNEL));
 -	cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(HK_TYPE_WQ));
 -	cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, housekeeping_cpumask=
(HK_TYPE_DOMAIN));
 -
 +	cpumask_copy(wq_unbound_cpumask, cpu_possible_mask);
 +	restrict_unbound_cpumask("HK_TYPE_WQ", housekeeping_cpumask(HK_TYPE_WQ));
 +	restrict_unbound_cpumask("HK_TYPE_DOMAIN", housekeeping_cpumask(HK_TYPE_=
DOMAIN));
  	if (!cpumask_empty(&wq_cmdline_cpumask))
 -		cpumask_and(wq_unbound_cpumask, wq_unbound_cpumask, &wq_cmdline_cpumask=
);
 +		restrict_unbound_cpumask("workqueue.unbound_cpus", &wq_cmdline_cpumask);
+ 	cpumask_copy(wq_requested_unbound_cpumask, wq_unbound_cpumask);
 =20
  	pwq_cache =3D KMEM_CACHE(pool_workqueue, SLAB_PANIC);
 =20

--Sig_/0OHAM0=zUMJT0.mKO+UsGF1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVeqlQACgkQAVBC80lX
0GxPdQf+LJxl0KUXKbsO1HaZB1mzz1SPLQkVJe+swfCsfgaU/7epDRnZwRSqfedZ
PZRTiwytp4qiEF5IzCfYoUSWnsniMA+76Pbl73vY0b8uul6FUtd67XMBGwaLy6Sm
01su1B0OjqaMuHzK3asQME2h/At2oH3LrntKtubMAEsUltcg9hdJ/myTcxbdlpPd
YiGKO0eGNNE2IhXNJWu5XxHZDdjUgUaKjSixFMaZOtz/gxPxxpB7o7Uxu4W36JUY
ugSDgrnXnLo6Bd6HZWV9aNHTS7SqgOl3ZPK2DbaAmRbEXw3FJJGjW4kgjQSAfxDM
/Dn8KM2Dj72xfx+BQM3Ugtxooeu0qQ==
=C6TD
-----END PGP SIGNATURE-----

--Sig_/0OHAM0=zUMJT0.mKO+UsGF1--
