Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A1F7F9727
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 02:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjK0B3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 20:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjK0B3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 20:29:00 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0438E3;
        Sun, 26 Nov 2023 17:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701048544;
        bh=c8WraKH7izMTzidMiHYbs+LFOZrlhXTUuBrEz0967Ec=;
        h=Date:From:To:Cc:Subject:From;
        b=gJSY2rLP/nKY6yZzr6xV5MaHq6oFnYlDzsoHwxbFZzDpoo2sZGhn56OfiClTv69SQ
         GgsJFOOj3vhZ+tD27+T6HXCFnmqVFwpY2lXcIntW8w9NDXhQsQ2XpT/+VBatQ4Rkap
         pdD7t7l/Or8xl7FM6gS8v+ro7tC3QZtr0tF/YlVzMBuqudSdSQmBtMOKgQxBq0XAAJ
         6pERLj6f8GwMr+TXiW73Fjucn7/h/IslYYNG8362Pr3GdJT5ZQv/yoiCAARaqfGCFn
         XxRcXrQTewG9hLz8AAbVDT/br6kEa80lfXSHJEmf+VyVSemDT8kjJni0Ns9nwA4p8Q
         Fs9XzOWqunMmQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sdnzz5rnHz4wc1;
        Mon, 27 Nov 2023 12:29:03 +1100 (AEDT)
Date:   Mon, 27 Nov 2023 12:29:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the slab tree with the mm tree
Message-ID: <20231127122902.566de6d1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9qvVD_TXCr7c=szVwJfkcnk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9qvVD_TXCr7c=szVwJfkcnk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the slab tree got a conflict in:

  mm/kasan/quarantine.c

between commit:

  f644ee35cf5b ("kasan: use stack_depot_put for Generic mode")

from the mm tree and commit:

  40a038d5fc11 ("KASAN: remove code paths guarded by CONFIG_SLAB")

from the slab tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/kasan/quarantine.c
index 265ca2bbe2dd,138c57b836f2..000000000000
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@@ -143,22 -143,7 +143,21 @@@ static void *qlink_to_object(struct qli
  static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
  {
  	void *object =3D qlink_to_object(qlink, cache);
 -	struct kasan_free_meta *meta =3D kasan_get_free_meta(cache, object);
 +	struct kasan_alloc_meta *alloc_meta =3D kasan_get_alloc_meta(cache, obje=
ct);
 +	struct kasan_free_meta *free_meta =3D kasan_get_free_meta(cache, object);
- 	unsigned long flags;
 +
 +	if (alloc_meta) {
 +		stack_depot_put(alloc_meta->alloc_track.stack);
 +		stack_depot_put(alloc_meta->aux_stack[0]);
 +		stack_depot_put(alloc_meta->aux_stack[1]);
 +		__memset(alloc_meta, 0, sizeof(*alloc_meta));
 +	}
 +
 +	if (free_meta &&
 +	    *(u8 *)kasan_mem_to_shadow(object) =3D=3D KASAN_SLAB_FREETRACK) {
 +		stack_depot_put(free_meta->free_track.stack);
 +		free_meta->free_track.stack =3D 0;
 +	}
 =20
  	/*
  	 * If init_on_free is enabled and KASAN's free metadata is stored in

--Sig_/9qvVD_TXCr7c=szVwJfkcnk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVj8N4ACgkQAVBC80lX
0GyebAgAoWkglSXrgn+ihSDD0b2x8HHiVEXkcAt3Wru2wnaw31Lya+Y6xuJ7t4X7
dzOFrxIL14sIwDhwTeL5Iangh/2oPsnfI0j0qOc5FGVdZ8NgwCYkVEW6HEMb/sj7
obo6X0mnydSd3F+1ChzbVU5BOPM7KdB0T13fy8lfq8XcljyBs8qHN+29gbTf1eaD
Iq5nBLsAkADutX+KKvF0o7oaefOE6H0A1EFsULCLTh/ejpxsOOQ9gO/GNAYT1230
cwqjxw+4jigsGw4H1jjH3M4eyYVIZTZoIDdzDdhWOr+2W4PA/qUj1RK9IzyBwWW9
Ups9ksfnmvokPpOOuViolSYgBIr+1A==
=UaKz
-----END PGP SIGNATURE-----

--Sig_/9qvVD_TXCr7c=szVwJfkcnk--
