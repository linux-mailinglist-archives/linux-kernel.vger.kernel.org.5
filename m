Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3331E7F95B6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 23:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjKZWOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 17:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZWOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 17:14:37 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42897ED;
        Sun, 26 Nov 2023 14:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701036880;
        bh=OpZS2AexNOfrXRUm1M+fIArYkz61bIJm4/IPafcYDz8=;
        h=Date:From:To:Cc:Subject:From;
        b=Y8PFyBH54Iuag2coKTKuZQfD1QN7rwJwurE8pUJtx6Zqcn6dfCLwWUKvgoQF+jWJ2
         2L7ThNLRelQ1syjvlOdlPKQDYXXRwgUp8GG6vEOyMfDVi5ScvSItw9BufO37P0E0Aj
         hrQXZRRsvKmKsAzIhjBxsZTKZWVW0eX2tvTUHm0v3J3we67fotMovSVHBS0W5pa/8b
         GT6d6xxYV59TSU9HksSGg1HUkUYupVkXJ3dlBbVbQ9LV7WgUbXSBSTwR+Pd8L6vxLf
         kRdjurVz1yja8Sgx7khTQYJGqQ0fWIHh5Gv4m453dtXvJflVskoQPwD8iRgNzeb2i2
         rLaZHsO6ixq5w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sdjgg6P7tz4wc3;
        Mon, 27 Nov 2023 09:14:39 +1100 (AEDT)
Date:   Mon, 27 Nov 2023 09:14:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Qu Wenruo <wqu@suse.com>
Subject: linux-next: manual merge of the vfs-brauner tree with the btrfs
 tree
Message-ID: <20231127091437.4062f96c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Dse0H36zV=K5vfNRjUVbwgI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Dse0H36zV=K5vfNRjUVbwgI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got conflicts in:

  fs/btrfs/extent_io.c
  fs/btrfs/subpage.c

between commit:

  16aee93de711 ("btrfs: migrate to use folio private instead of page privat=
e")

from the btrfs tree and commit:

  600f111ef51d ("fs: Rename mapping private members")

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

diff --cc fs/btrfs/extent_io.c
index 40cf80af88b1,3431a53bf3fd..000000000000
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@@ -878,13 -870,13 +878,13 @@@ static int attach_extent_buffer_page(st
  	 * will not race with any other ebs.
  	 */
  	if (page->mapping)
- 		lockdep_assert_held(&page->mapping->private_lock);
+ 		lockdep_assert_held(&page->mapping->i_private_lock);
 =20
  	if (fs_info->nodesize >=3D PAGE_SIZE) {
 -		if (!PagePrivate(page))
 -			attach_page_private(page, eb);
 +		if (!folio_test_private(folio))
 +			folio_attach_private(folio, eb);
  		else
 -			WARN_ON(page->private !=3D (unsigned long)eb);
 +			WARN_ON(folio_get_private(folio) !=3D eb);
  		return 0;
  	}
 =20
@@@ -1748,9 -1736,9 +1748,9 @@@ static int submit_eb_subpage(struct pag
  		 * Take private lock to ensure the subpage won't be detached
  		 * in the meantime.
  		 */
- 		spin_lock(&page->mapping->private_lock);
+ 		spin_lock(&page->mapping->i_private_lock);
 -		if (!PagePrivate(page)) {
 +		if (!folio_test_private(folio)) {
- 			spin_unlock(&page->mapping->private_lock);
+ 			spin_unlock(&page->mapping->i_private_lock);
  			break;
  		}
  		spin_lock_irqsave(&subpage->lock, flags);
@@@ -1824,9 -1811,9 +1824,9 @@@ static int submit_eb_page(struct page *
  	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
  		return submit_eb_subpage(page, wbc);
 =20
- 	spin_lock(&mapping->private_lock);
+ 	spin_lock(&mapping->i_private_lock);
 -	if (!PagePrivate(page)) {
 +	if (!folio_test_private(folio)) {
- 		spin_unlock(&mapping->private_lock);
+ 		spin_unlock(&mapping->i_private_lock);
  		return 0;
  	}
 =20
@@@ -3067,13 -3054,12 +3067,13 @@@ static int extent_buffer_under_io(cons
 =20
  static bool page_range_has_eb(struct btrfs_fs_info *fs_info, struct page =
*page)
  {
 +	struct folio *folio =3D page_folio(page);
  	struct btrfs_subpage *subpage;
 =20
- 	lockdep_assert_held(&page->mapping->private_lock);
+ 	lockdep_assert_held(&page->mapping->i_private_lock);
 =20
 -	if (PagePrivate(page)) {
 -		subpage =3D (struct btrfs_subpage *)page->private;
 +	if (folio_test_private(folio)) {
 +		subpage =3D folio_get_private(folio);
  		if (atomic_read(&subpage->eb_refs))
  			return true;
  		/*
@@@ -3090,18 -3076,17 +3090,18 @@@ static void detach_extent_buffer_page(s
  {
  	struct btrfs_fs_info *fs_info =3D eb->fs_info;
  	const bool mapped =3D !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
 +	struct folio *folio =3D page_folio(page);
 =20
  	/*
 -	 * For mapped eb, we're going to change the page private, which should
 +	 * For mapped eb, we're going to change the folio private, which should
- 	 * be done under the private_lock.
+ 	 * be done under the i_private_lock.
  	 */
  	if (mapped)
- 		spin_lock(&page->mapping->private_lock);
+ 		spin_lock(&page->mapping->i_private_lock);
 =20
 -	if (!PagePrivate(page)) {
 +	if (!folio_test_private(folio)) {
  		if (mapped)
- 			spin_unlock(&page->mapping->private_lock);
+ 			spin_unlock(&page->mapping->i_private_lock);
  		return;
  	}
 =20
@@@ -3117,11 -3103,14 +3117,11 @@@
  			BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
  			BUG_ON(PageDirty(page));
  			BUG_ON(PageWriteback(page));
 -			/*
 -			 * We need to make sure we haven't be attached
 -			 * to a new eb.
 -			 */
 -			detach_page_private(page);
 +			/* We need to make sure we haven't be attached to a new eb. */
 +			folio_detach_private(folio);
  		}
  		if (mapped)
- 			spin_unlock(&page->mapping->private_lock);
+ 			spin_unlock(&page->mapping->i_private_lock);
  		return;
  	}
 =20
@@@ -3526,8 -3513,8 +3526,8 @@@ struct extent_buffer *alloc_extent_buff
  	num_pages =3D num_extent_pages(eb);
 =20
  	/*
 -	 * Preallocate page->private for subpage case, so that we won't
 +	 * Preallocate folio private for subpage case, so that we won't
- 	 * allocate memory with private_lock nor page lock hold.
+ 	 * allocate memory with i_private_lock nor page lock hold.
  	 *
  	 * The memory will be freed by attach_extent_buffer_page() or freed
  	 * manually if we exit earlier.
@@@ -4638,11 -4560,11 +4638,11 @@@ static int try_release_subpage_extent_b
  		release_extent_buffer(eb);
  	}
  	/*
 -	 * Finally to check if we have cleared page private, as if we have
 -	 * released all ebs in the page, the page private should be cleared now.
 +	 * Finally to check if we have cleared folio private, as if we have
 +	 * released all ebs in the page, the folio private should be cleared now.
  	 */
- 	spin_lock(&page->mapping->private_lock);
+ 	spin_lock(&page->mapping->i_private_lock);
 -	if (!PagePrivate(page))
 +	if (!folio_test_private(page_folio(page)))
  		ret =3D 1;
  	else
  		ret =3D 0;
@@@ -4660,12 -4581,12 +4660,12 @@@ int try_release_extent_buffer(struct pa
  		return try_release_subpage_extent_buffer(page);
 =20
  	/*
 -	 * We need to make sure nobody is changing page->private, as we rely on
 -	 * page->private as the pointer to extent buffer.
 +	 * We need to make sure nobody is changing folio private, as we rely on
 +	 * folio private as the pointer to extent buffer.
  	 */
- 	spin_lock(&page->mapping->private_lock);
+ 	spin_lock(&page->mapping->i_private_lock);
 -	if (!PagePrivate(page)) {
 +	if (!folio_test_private(folio)) {
- 		spin_unlock(&page->mapping->private_lock);
+ 		spin_unlock(&page->mapping->i_private_lock);
  		return 1;
  	}
 =20
diff --cc fs/btrfs/subpage.c
index caf0013f2545,2347cf15278b..000000000000
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@@ -202,10 -199,10 +202,10 @@@ void btrfs_page_inc_eb_refs(const struc
  	if (!btrfs_is_subpage(fs_info, page))
  		return;
 =20
 -	ASSERT(PagePrivate(page) && page->mapping);
 +	ASSERT(folio_test_private(folio) && page->mapping);
- 	lockdep_assert_held(&page->mapping->private_lock);
+ 	lockdep_assert_held(&page->mapping->i_private_lock);
 =20
 -	subpage =3D (struct btrfs_subpage *)page->private;
 +	subpage =3D folio_get_private(folio);
  	atomic_inc(&subpage->eb_refs);
  }
 =20
@@@ -218,10 -214,10 +218,10 @@@ void btrfs_page_dec_eb_refs(const struc
  	if (!btrfs_is_subpage(fs_info, page))
  		return;
 =20
 -	ASSERT(PagePrivate(page) && page->mapping);
 +	ASSERT(folio_test_private(folio) && page->mapping);
- 	lockdep_assert_held(&page->mapping->private_lock);
+ 	lockdep_assert_held(&page->mapping->i_private_lock);
 =20
 -	subpage =3D (struct btrfs_subpage *)page->private;
 +	subpage =3D folio_get_private(folio);
  	ASSERT(atomic_read(&subpage->eb_refs));
  	atomic_dec(&subpage->eb_refs);
  }

--Sig_/Dse0H36zV=K5vfNRjUVbwgI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVjw00ACgkQAVBC80lX
0GzONwf+IzSKBhqtSvAvK5TIIZ9aMVH1IPe+/Bfw88AGsMt/aZj+0oFQ6Em7Cc3l
S26+mnku+7vYaoFubPiyADMNNg+NK6ll8NMTGnAqcrEy6DKRWwisIF+qpOMQ43Nx
i0+2StOg+lZtfnAkHhzRX3r7fnSWgXC+LNwMeN+gGPKOjnJ+fkQbgAp0rFrxQKHK
hTq1Zaxxbn4unL6mAQvemnSU6Xe2UOrXppzqHT2UZhvDGea8nmFFdn7kVt2eJYfg
ZIsfZ9z4NNDatj3ql5skEAq/BIdp8BNj8GVrgapjIKpTzTHERuyqB1MUYsqZyIAR
10J7fIOlClo30bgTwcluuL3r2/82QQ==
=mb0k
-----END PGP SIGNATURE-----

--Sig_/Dse0H36zV=K5vfNRjUVbwgI--
