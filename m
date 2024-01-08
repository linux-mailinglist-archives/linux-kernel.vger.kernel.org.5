Return-Path: <linux-kernel+bounces-20166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D884F827AE8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828EB285836
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1C35674C;
	Mon,  8 Jan 2024 22:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="W5GyNJOc"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04CF56740;
	Mon,  8 Jan 2024 22:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704754449;
	bh=VBF/byM1vm/iUxyCl1D+PwVWglAOTC24+zekK3GjUWc=;
	h=Date:From:To:Cc:Subject:From;
	b=W5GyNJOc481nBtBBx1fxw2zP1bPRX7fYSvM/lW95zPf7jL//64ljUQLgeG7cUGph2
	 CsCylcItm7JT2h7Uf0iSlKoOvzJ6nRsAma/yOoeTLjF0Yx1fbZ7Oc5llI2YO0eWZT0
	 vxG9GW7krME/ln9M6lTGSaJ90mQWz6qahrWQT/l0g9xmrfsYY3ehN+V0VAcwExJU3A
	 T57tAYPA6kHpoVnn2l6JDnDwoZGUI90iKp02uMTnf7Fle+g0L0tthG3Vm5lMUwzv+m
	 b8LQ1j42xQmpyhQSWAX0Z+o9MVfTFOtiXTcA8Is08XYZ8v5nG3ugUCJKwV/o1luYSP
	 FBkxJ5+N0u3Hw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T88WN3Q2Qz4x1P;
	Tue,  9 Jan 2024 09:54:08 +1100 (AEDT)
Date: Tue, 9 Jan 2024 09:54:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Sterba <dsterba@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Qu Wenruo <wqu@suse.com>
Subject: linux-next: manual merge of the btrfs tree with Linus' tree
Message-ID: <20240109095405.02bd795f@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Q5zib2a=DHH=.b+Zu7rSaoh";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Q5zib2a=DHH=.b+Zu7rSaoh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the btrfs tree got a conflict in:

  fs/btrfs/extent_io.c

between commit:

  600f111ef51d ("fs: Rename mapping private members")

from Linus' tree and commits:

  08236d11031b ("btrfs: cache folio size and shift in extent_buffer")
  13df3775efca ("btrfs: cleanup metadata page pointer usage")
  082d5bb9b336 ("btrfs: migrate extent_buffer::pages[] to folio")
  09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to allocate-then-att=
ach method")
  cfbf07e2787e ("btrfs: migrate to use folio private instead of page privat=
e")

from the btrfs tree.

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
index b6ff6f320198,c8aabe3be169..000000000000
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@@ -874,14 -901,14 +901,14 @@@ static int attach_extent_buffer_folio(s
  	 * For cloned or dummy extent buffers, their pages are not mapped and
  	 * will not race with any other ebs.
  	 */
- 	if (page->mapping)
- 		lockdep_assert_held(&page->mapping->i_private_lock);
+ 	if (folio->mapping)
 -		lockdep_assert_held(&folio->mapping->private_lock);
++		lockdep_assert_held(&folio->mapping->i_private_lock);
 =20
  	if (fs_info->nodesize >=3D PAGE_SIZE) {
- 		if (!PagePrivate(page))
- 			attach_page_private(page, eb);
+ 		if (!folio_test_private(folio))
+ 			folio_attach_private(folio, eb);
  		else
- 			WARN_ON(page->private !=3D (unsigned long)eb);
+ 			WARN_ON(folio_get_private(folio) !=3D eb);
  		return 0;
  	}
 =20
@@@ -1741,9 -1775,9 +1775,9 @@@ static int submit_eb_subpage(struct pag
  		 * Take private lock to ensure the subpage won't be detached
  		 * in the meantime.
  		 */
 -		spin_lock(&page->mapping->private_lock);
 +		spin_lock(&page->mapping->i_private_lock);
- 		if (!PagePrivate(page)) {
+ 		if (!folio_test_private(folio)) {
 -			spin_unlock(&page->mapping->private_lock);
 +			spin_unlock(&page->mapping->i_private_lock);
  			break;
  		}
  		spin_lock_irqsave(&subpage->lock, flags);
@@@ -1816,9 -1851,9 +1851,9 @@@ static int submit_eb_page(struct page *
  	if (btrfs_sb(page->mapping->host->i_sb)->nodesize < PAGE_SIZE)
  		return submit_eb_subpage(page, wbc);
 =20
 -	spin_lock(&mapping->private_lock);
 +	spin_lock(&mapping->i_private_lock);
- 	if (!PagePrivate(page)) {
+ 	if (!folio_test_private(folio)) {
 -		spin_unlock(&mapping->private_lock);
 +		spin_unlock(&mapping->i_private_lock);
  		return 0;
  	}
 =20
@@@ -3062,10 -3097,10 +3097,10 @@@ static bool folio_range_has_eb(struct b
  {
  	struct btrfs_subpage *subpage;
 =20
- 	lockdep_assert_held(&page->mapping->i_private_lock);
 -	lockdep_assert_held(&folio->mapping->private_lock);
++	lockdep_assert_held(&folio->mapping->i_private_lock);
 =20
- 	if (PagePrivate(page)) {
- 		subpage =3D (struct btrfs_subpage *)page->private;
+ 	if (folio_test_private(folio)) {
+ 		subpage =3D folio_get_private(folio);
  		if (atomic_read(&subpage->eb_refs))
  			return true;
  		/*
@@@ -3084,15 -3119,15 +3119,15 @@@ static void detach_extent_buffer_folio(
  	const bool mapped =3D !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
 =20
  	/*
- 	 * For mapped eb, we're going to change the page private, which should
+ 	 * For mapped eb, we're going to change the folio private, which should
 -	 * be done under the private_lock.
 +	 * be done under the i_private_lock.
  	 */
  	if (mapped)
- 		spin_lock(&page->mapping->i_private_lock);
 -		spin_lock(&folio->mapping->private_lock);
++		spin_lock(&folio->mapping->i_private_lock);
 =20
- 	if (!PagePrivate(page)) {
+ 	if (!folio_test_private(folio)) {
  		if (mapped)
- 			spin_unlock(&page->mapping->i_private_lock);
 -			spin_unlock(&folio->mapping->private_lock);
++			spin_unlock(&folio->mapping->i_private_lock);
  		return;
  	}
 =20
@@@ -3101,22 -3136,18 +3136,18 @@@
  		 * We do this since we'll remove the pages after we've
  		 * removed the eb from the radix tree, so we could race
  		 * and have this page now attached to the new eb.  So
- 		 * only clear page_private if it's still connected to
+ 		 * only clear folio if it's still connected to
  		 * this eb.
  		 */
- 		if (PagePrivate(page) &&
- 		    page->private =3D=3D (unsigned long)eb) {
+ 		if (folio_test_private(folio) && folio_get_private(folio) =3D=3D eb) {
  			BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
- 			BUG_ON(PageDirty(page));
- 			BUG_ON(PageWriteback(page));
- 			/*
- 			 * We need to make sure we haven't be attached
- 			 * to a new eb.
- 			 */
- 			detach_page_private(page);
+ 			BUG_ON(folio_test_dirty(folio));
+ 			BUG_ON(folio_test_writeback(folio));
+ 			/* We need to make sure we haven't be attached to a new eb. */
+ 			folio_detach_private(folio);
  		}
  		if (mapped)
- 			spin_unlock(&page->mapping->i_private_lock);
 -			spin_unlock(&folio->mapping->private_lock);
++			spin_unlock(&folio->mapping->i_private_lock);
  		return;
  	}
 =20
@@@ -3130,16 -3161,16 +3161,16 @@@
  		return;
  	}
 =20
- 	btrfs_page_dec_eb_refs(fs_info, page);
+ 	btrfs_folio_dec_eb_refs(fs_info, folio);
 =20
  	/*
- 	 * We can only detach the page private if there are no other ebs in the
+ 	 * We can only detach the folio private if there are no other ebs in the
  	 * page range and no unfinished IO.
  	 */
- 	if (!page_range_has_eb(fs_info, page))
- 		btrfs_detach_subpage(fs_info, page);
+ 	if (!folio_range_has_eb(fs_info, folio))
+ 		btrfs_detach_subpage(fs_info, folio);
 =20
- 	spin_unlock(&page->mapping->i_private_lock);
 -	spin_unlock(&folio->mapping->private_lock);
++	spin_unlock(&folio->mapping->i_private_lock);
  }
 =20
  /* Release all pages attached to the extent buffer */
@@@ -3516,11 -3603,9 +3603,9 @@@ struct extent_buffer *alloc_extent_buff
 =20
  	btrfs_set_buffer_lockdep_class(lockdep_owner, eb, level);
 =20
- 	num_pages =3D num_extent_pages(eb);
-=20
  	/*
- 	 * Preallocate page->private for subpage case, so that we won't
+ 	 * Preallocate folio private for subpage case, so that we won't
 -	 * allocate memory with private_lock nor page lock hold.
 +	 * allocate memory with i_private_lock nor page lock hold.
  	 *
  	 * The memory will be freed by attach_extent_buffer_page() or freed
  	 * manually if we exit earlier.
@@@ -3533,26 -3618,61 +3618,61 @@@
  		}
  	}
 =20
- 	for (i =3D 0; i < num_pages; i++, index++) {
- 		p =3D find_or_create_page(mapping, index, GFP_NOFS|__GFP_NOFAIL);
- 		if (!p) {
- 			exists =3D ERR_PTR(-ENOMEM);
- 			btrfs_free_subpage(prealloc);
- 			goto free_eb;
+ reallocate:
+ 	/* Allocate all pages first. */
+ 	ret =3D alloc_eb_folio_array(eb, __GFP_NOFAIL);
+ 	if (ret < 0) {
+ 		btrfs_free_subpage(prealloc);
+ 		goto out;
+ 	}
+=20
+ 	num_folios =3D num_extent_folios(eb);
+ 	/* Attach all pages to the filemap. */
+ 	for (int i =3D 0; i < num_folios; i++) {
+ 		struct folio *folio;
+=20
+ 		ret =3D attach_eb_folio_to_filemap(eb, i, &existing_eb);
+ 		if (ret > 0) {
+ 			ASSERT(existing_eb);
+ 			goto out;
  		}
 =20
- 		spin_lock(&mapping->i_private_lock);
- 		exists =3D grab_extent_buffer(fs_info, p);
- 		if (exists) {
- 			spin_unlock(&mapping->i_private_lock);
- 			unlock_page(p);
- 			put_page(p);
- 			mark_extent_buffer_accessed(exists, p);
- 			btrfs_free_subpage(prealloc);
- 			goto free_eb;
+ 		/*
+ 		 * TODO: Special handling for a corner case where the order of
+ 		 * folios mismatch between the new eb and filemap.
+ 		 *
+ 		 * This happens when:
+ 		 *
+ 		 * - the new eb is using higher order folio
+ 		 *
+ 		 * - the filemap is still using 0-order folios for the range
+ 		 *   This can happen at the previous eb allocation, and we don't
+ 		 *   have higher order folio for the call.
+ 		 *
+ 		 * - the existing eb has already been freed
+ 		 *
+ 		 * In this case, we have to free the existing folios first, and
+ 		 * re-allocate using the same order.
+ 		 * Thankfully this is not going to happen yet, as we're still
+ 		 * using 0-order folios.
+ 		 */
+ 		if (unlikely(ret =3D=3D -EAGAIN)) {
+ 			ASSERT(0);
+ 			goto reallocate;
  		}
+ 		attached++;
+=20
+ 		/*
+ 		 * Only after attach_eb_folio_to_filemap(), eb->folios[] is
+ 		 * reliable, as we may choose to reuse the existing page cache
+ 		 * and free the allocated page.
+ 		 */
+ 		folio =3D eb->folios[i];
+ 		eb->folio_size =3D folio_size(folio);
+ 		eb->folio_shift =3D folio_shift(folio);
 -		spin_lock(&mapping->private_lock);
++		spin_lock(&mapping->i_private_lock);
  		/* Should not fail, as we have preallocated the memory */
- 		ret =3D attach_extent_buffer_page(eb, p, prealloc);
+ 		ret =3D attach_extent_buffer_folio(eb, folio, prealloc);
  		ASSERT(!ret);
  		/*
  		 * To inform we have extra eb under allocation, so that
@@@ -3563,12 -3683,21 +3683,21 @@@
  		 * detach_extent_buffer_page().
  		 * Thus needs no special handling in error path.
  		 */
- 		btrfs_page_inc_eb_refs(fs_info, p);
+ 		btrfs_folio_inc_eb_refs(fs_info, folio);
 -		spin_unlock(&mapping->private_lock);
 +		spin_unlock(&mapping->i_private_lock);
 =20
- 		WARN_ON(btrfs_page_test_dirty(fs_info, p, eb->start, eb->len));
- 		eb->pages[i] =3D p;
- 		if (!btrfs_page_test_uptodate(fs_info, p, eb->start, eb->len))
+ 		WARN_ON(btrfs_folio_test_dirty(fs_info, folio, eb->start, eb->len));
+=20
+ 		/*
+ 		 * Check if the current page is physically contiguous with previous eb
+ 		 * page.
+ 		 * At this stage, either we allocated a large folio, thus @i
+ 		 * would only be 0, or we fall back to per-page allocation.
+ 		 */
+ 		if (i && folio_page(eb->folios[i - 1], 0) + 1 !=3D folio_page(folio, 0))
+ 			page_contig =3D false;
+=20
+ 		if (!btrfs_folio_test_uptodate(fs_info, folio, eb->start, eb->len))
  			uptodate =3D 0;
 =20
  		/*
@@@ -4566,11 -4773,11 +4773,11 @@@ static int try_release_subpage_extent_b
  		release_extent_buffer(eb);
  	}
  	/*
- 	 * Finally to check if we have cleared page private, as if we have
- 	 * released all ebs in the page, the page private should be cleared now.
+ 	 * Finally to check if we have cleared folio private, as if we have
+ 	 * released all ebs in the page, the folio private should be cleared now.
  	 */
 -	spin_lock(&page->mapping->private_lock);
 +	spin_lock(&page->mapping->i_private_lock);
- 	if (!PagePrivate(page))
+ 	if (!folio_test_private(page_folio(page)))
  		ret =3D 1;
  	else
  		ret =3D 0;
@@@ -4587,12 -4795,12 +4795,12 @@@ int try_release_extent_buffer(struct pa
  		return try_release_subpage_extent_buffer(page);
 =20
  	/*
- 	 * We need to make sure nobody is changing page->private, as we rely on
- 	 * page->private as the pointer to extent buffer.
+ 	 * We need to make sure nobody is changing folio private, as we rely on
+ 	 * folio private as the pointer to extent buffer.
  	 */
 -	spin_lock(&page->mapping->private_lock);
 +	spin_lock(&page->mapping->i_private_lock);
- 	if (!PagePrivate(page)) {
+ 	if (!folio_test_private(folio)) {
 -		spin_unlock(&page->mapping->private_lock);
 +		spin_unlock(&page->mapping->i_private_lock);
  		return 1;
  	}
 =20

--Sig_/Q5zib2a=DHH=.b+Zu7rSaoh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWcfQ0ACgkQAVBC80lX
0GzzQwf+OONW5Ff/GExciOfxFdEX9QsVw9Un/WgRsoPDscS4eHyr0+69gX6LHZD8
Ho+a2GS68qSOH0npggiydHf+ZzHg+n8y1U9FFmh/Hn546e2ZCHNbi+IAJUtK+9KK
sK2vZekOgzM0siGjnypbIKt7eh6C/MTkCa4/DEoBRN8Rivsh3ztbKq0oCHSLMauP
hWKzAWO4RlossIOth2N++tRnPMhfTJDIhwe2RU0wPeSV3j54l8a456DV/tsqJpBL
nlcfQ0x9hoW0I5JwNWx9F5Q4neB6dGqtP7uLgLMS2xkYYaD9uq2NwerLYclYeVDE
wHokVSLQiEx2B/7tuoTB27NQd1rZPg==
=Pw/q
-----END PGP SIGNATURE-----

--Sig_/Q5zib2a=DHH=.b+Zu7rSaoh--

