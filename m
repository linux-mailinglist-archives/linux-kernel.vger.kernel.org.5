Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D2F8029A3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 01:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjLDAvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 19:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjLDAvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 19:51:46 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CCCDB;
        Sun,  3 Dec 2023 16:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701651110;
        bh=Opj6twM4acMBCpY7T23VTzRC6W4CJ1xxdOLVZ0BFwGY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PNAnU1fNgJ32W0hGwE141ESRcRgmPsdmNRAmufzHkJKRI4Fiavz0IwFyvIRBtLUpf
         T9ClY2QGqGkGvGUTANJb9Lwqi/BzFxasMIX1jCuD4mn08IpedB0jswkpKUiLuJiHTv
         I7ujGXEgxPWKcU9XdSM0YKEzxvs4r9b7ztl0khRBEa0E2wypMSpBXQS8SckDP442cV
         D/vwINh0JzvHvgwPPqT5sgARdrR9Q7Ps7OxlZfBLH9Oa7oRnsqvn5dtyTZLVtkQGlI
         bV+/GUeaof+/di1naCRaKj1mQtR1YenzV7czHxy5gGqExytOSxomtVvKvKHPyTQyYB
         VJAvBfYlf78Kg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sk4qn6b5hz4xhZ;
        Mon,  4 Dec 2023 11:51:49 +1100 (AEDT)
Date:   Mon, 4 Dec 2023 11:51:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: linux-next: manual merge of the kvm tree with the vfs-brauner
 tree
Message-ID: <20231204115148.0b09243b@canb.auug.org.au>
In-Reply-To: <20231122125539.5a7df3a3@canb.auug.org.au>
References: <20231122125539.5a7df3a3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8r2oWaKZaSmteXC+67jB/fz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8r2oWaKZaSmteXC+67jB/fz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 22 Nov 2023 12:55:39 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the kvm tree got a conflict in:
>=20
>   include/linux/pagemap.h
>=20
> between commit:
>=20
>   762321dab9a7 ("filemap: add a per-mapping stable writes flag")

This is now in Linus' tree.

> from the vfs-brauner tree and commit:
>=20
>   0003e2a41468 ("mm: Add AS_UNMOVABLE to mark mapping as completely unmov=
able")
>=20
> from the kvm tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

The current resolution is below.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/pagemap.h
index 06142ff7f9ce,bf2965b01b35..c2d90588c0bf
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@@ -203,9 -203,8 +203,10 @@@ enum mapping_flags=20
  	/* writeback related tags are not used */
  	AS_NO_WRITEBACK_TAGS =3D 5,
  	AS_LARGE_FOLIO_SUPPORT =3D 6,
 -	AS_RELEASE_ALWAYS =3D 7,	/* Call ->release_folio(), even if no private d=
ata */
 -	AS_UNMOVABLE	=3D 8,	/* The mapping cannot be moved, ever */
 +	AS_RELEASE_ALWAYS,	/* Call ->release_folio(), even if no private data */
 +	AS_STABLE_WRITES,	/* must wait for writeback before modifying
 +				   folio contents */
++	AS_UNMOVABLE,		/* The mapping cannot be moved, ever */
  };
 =20
  /**
@@@ -291,21 -290,22 +292,37 @@@ static inline void mapping_clear_releas
  	clear_bit(AS_RELEASE_ALWAYS, &mapping->flags);
  }
 =20
+ static inline void mapping_set_unmovable(struct address_space *mapping)
+ {
+ 	/*
+ 	 * It's expected unmovable mappings are also unevictable. Compaction
+ 	 * migrate scanner (isolate_migratepages_block()) relies on this to
+ 	 * reduce page locking.
+ 	 */
+ 	set_bit(AS_UNEVICTABLE, &mapping->flags);
+ 	set_bit(AS_UNMOVABLE, &mapping->flags);
+ }
+=20
+ static inline bool mapping_unmovable(struct address_space *mapping)
+ {
+ 	return test_bit(AS_UNMOVABLE, &mapping->flags);
+ }
+=20
 +static inline bool mapping_stable_writes(const struct address_space *mapp=
ing)
 +{
 +	return test_bit(AS_STABLE_WRITES, &mapping->flags);
 +}
 +
 +static inline void mapping_set_stable_writes(struct address_space *mappin=
g)
 +{
 +	set_bit(AS_STABLE_WRITES, &mapping->flags);
 +}
 +
 +static inline void mapping_clear_stable_writes(struct address_space *mapp=
ing)
 +{
 +	clear_bit(AS_STABLE_WRITES, &mapping->flags);
 +}
 +
  static inline gfp_t mapping_gfp_mask(struct address_space * mapping)
  {
  	return mapping->gfp_mask;

--Sig_/8r2oWaKZaSmteXC+67jB/fz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVtIqQACgkQAVBC80lX
0GzjWAf/X1tCPBNu95zV0Mq9esX+qPvDhfWOLbieaYGzjpHNlL9AXomcCbRTg8GF
8AtLG8v42IHH6GkeeETor1NiGcSv/BYyEa9ibvoO48x00YSKt8rAqUQKg4nBgXVa
/FNzujmiXacB+a+cgb4tyqlBYGMzadQOvR4am1UkTq249AYUw4fhphJqpQ+ggPPo
L/XsayunYH1AcUD1FpHLNmx2GeRrHuOXBFK3drqkK9JXlWNRHT5LW/5VuoTPUM/G
I3ueJ//hmBZGStJaSK3wE+lqmK7B1iEYjAajupkwu4XdWlDK0wUsX5KJxn2gjPp/
nhXaagOvwtGfZ1qv8sPuPf9HjmwWqA==
=U7sa
-----END PGP SIGNATURE-----

--Sig_/8r2oWaKZaSmteXC+67jB/fz--
