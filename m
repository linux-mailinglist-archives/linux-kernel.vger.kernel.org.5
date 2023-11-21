Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1927F3A46
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjKUXb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjKUXb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:31:27 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD508197;
        Tue, 21 Nov 2023 15:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700609481;
        bh=vm3LHH7rKIIonbHQ6vl80PvHC1BET5XzshuquqAVAn8=;
        h=Date:From:To:Cc:Subject:From;
        b=rL/oebaq/ssFWqmAON1HNvciwD1Dm+RJDL2+GoNxyKmTZshZ/CXc+v+W5FlR9UzZ2
         3eleu5fRDAEE3S7xJRLZRgk5w7K0zzyr0BMOvya70T4vXmEdb99IbsLLMFfj3DMhXY
         //G1pAkIUiYyLFKLKqryFumdgrCUPhHNboONCzYrIRGOJXRCbOZMvxSssrAlUKhA9m
         GNtjEDLZihNUhfa1KR+goEv3nNSBXNDCYfovxMfoTIaqXEYvBPDvP+4c0GGX2EoMKq
         R8ke10MFcsap1ogGM/0na0QjkijxPpk0xvlyxEMQzmq5cgT25YRkbWtJAqMgil5Ydh
         tSlHp8SVKqmPg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SZgcS6vYFz4wc6;
        Wed, 22 Nov 2023 10:31:20 +1100 (AEDT)
Date:   Wed, 22 Nov 2023 10:31:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the mm tree
Message-ID: <20231122103119.34d23955@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+ZVO8UFyA4X2t7Y8pFC8p/v";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+ZVO8UFyA4X2t7Y8pFC8p/v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/buffer.c

between commits:

  2c68861ed127 ("buffer: return bool from grow_dev_folio()")
  5334c6480adb ("buffer: calculate block number inside folio_init_buffers()=
")

from the mm tree and commit:

  488e2eea5100 ("fs: Rename mapping private members")

from the vfs-brauner tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/buffer.c
index 4eb44ccdc6be,5ffc44ab4854..000000000000
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@@ -1067,14 -1064,17 +1067,14 @@@ static bool grow_dev_folio(struct block
  	 * lock to be atomic wrt __find_get_block(), which does not
  	 * run under the folio lock.
  	 */
- 	spin_lock(&inode->i_mapping->private_lock);
+ 	spin_lock(&inode->i_mapping->i_private_lock);
  	link_dev_buffers(folio, bh);
 -	end_block =3D folio_init_buffers(folio, bdev,
 -			(sector_t)index << sizebits, size);
 +	end_block =3D folio_init_buffers(folio, bdev, size);
- 	spin_unlock(&inode->i_mapping->private_lock);
+ 	spin_unlock(&inode->i_mapping->i_private_lock);
 -done:
 -	ret =3D (block < end_block) ? 1 : -ENXIO;
 -failed:
 +unlock:
  	folio_unlock(folio);
  	folio_put(folio);
 -	return ret;
 +	return block < end_block;
  }
 =20
  /*

--Sig_/+ZVO8UFyA4X2t7Y8pFC8p/v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVdPccACgkQAVBC80lX
0GzEIgf/X4Ngzk9qgsmGIYIAViv6uLFqMEpi3CPO3L9dH4VCiOv65zzbpo48ifWf
DcNRXRsZiT/YwMo7QRWE0ln8aIjHp6YYwqMD7LY12bksvNctb7vVTmrNYqchrhmw
rW3bpYQzGeqXT/poSsDt7pVmCirOPh+sTwmMhE6TTx4Emd/5EfZ0JL+M1jQ2rpNK
qYsqmUsE+Q9YqFWGhnDPnIsClFCwA+IOTzNfJL9w9IYZU6Yv7ZnVXl1EPnPfC7/P
V+1jpKU9GMMeiJgPKkkm4Bw6vjTMGi8xcQoj5U5XC153BKVPuGs4WKud13HJhLTd
4dkfumnyKNQSl9FPCXE4jCF9jrqhdw==
=Izk1
-----END PGP SIGNATURE-----

--Sig_/+ZVO8UFyA4X2t7Y8pFC8p/v--
