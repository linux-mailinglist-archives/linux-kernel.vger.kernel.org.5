Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C397807C5B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441801AbjLFXcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379687AbjLFXcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:32:16 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B058A9;
        Wed,  6 Dec 2023 15:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701905536;
        bh=RmWTnho2ChNHrBvziL4QMZJuQBN4A37smmhxbE20hAM=;
        h=Date:From:To:Cc:Subject:From;
        b=IFGjD25WKSPgU/p+mxVi5YKS6vte77vRJYEGOUBVP7qrhhk8VA26+FRWfEem1Es/X
         pPcB+DXYHL+egSw05sHMnthROyMiFa0WT/BrEm1x7Gz5RMjNmGljVIBxOFHAghThCi
         W6BpEQIWIWYiwxVAannG0dxUpF4Xsr41CHAwMdpNSxXdKoSjRRXLu27OeZbnDx7ina
         Bq/5f782+kGp2K+IjKyEsfTQm1QSoQtZVnRBdLstGvm2B795I3DHaRh2DUPjJfVAFo
         XDPTnuFlc6uMszbbK76o+FN1nGq8Qduv+iuOkLSdlns/1lcua6TC/ZYsq77/i/VMjd
         yFz5G3UJcRpmw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sltwb4R3rz4wc6;
        Thu,  7 Dec 2023 10:32:15 +1100 (AEDT)
Date:   Thu, 7 Dec 2023 10:32:13 +1100
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
Message-ID: <20231207103213.555cc6b5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rySalxan94zsooOnOA8FNpb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rySalxan94zsooOnOA8FNpb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/btrfs/extent_io.c

between commits:

  16aee93de711 ("btrfs: migrate to use folio private instead of page privat=
e")
  042eab832c43 ("btrfs: refactor alloc_extent_buffer() to allocate-then-att=
ach method")

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
index 5cae7884e8d9,3431a53bf3fd..000000000000
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@@ -881,13 -870,13 +881,13 @@@ static int attach_extent_buffer_page(st
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
@@@ -1750,9 -1736,9 +1750,9 @@@ static int submit_eb_subpage(struct pag
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
@@@ -1826,9 -1811,9 +1826,9 @@@ static int submit_eb_page(struct page *
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
@@@ -3070,13 -3054,12 +3070,13 @@@ static int extent_buffer_under_io(cons
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
@@@ -3093,18 -3076,17 +3093,18 @@@ static void detach_extent_buffer_page(s
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
@@@ -3120,11 -3103,14 +3120,11 @@@
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
@@@ -3588,8 -3513,8 +3588,8 @@@ struct extent_buffer *alloc_extent_buff
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
@@@ -3602,31 -3527,24 +3602,31 @@@
  		}
  	}
 =20
 -	for (i =3D 0; i < num_pages; i++, index++) {
 -		p =3D find_or_create_page(mapping, index, GFP_NOFS|__GFP_NOFAIL);
 -		if (!p) {
 -			exists =3D ERR_PTR(-ENOMEM);
 -			btrfs_free_subpage(prealloc);
 -			goto free_eb;
 -		}
 +	/* Allocate all pages first. */
 +	ret =3D btrfs_alloc_page_array(num_pages, eb->pages, __GFP_NOFAIL);
 +	if (ret < 0) {
 +		btrfs_free_subpage(prealloc);
 +		goto out;
 +	}
 =20
 -		spin_lock(&mapping->i_private_lock);
 -		exists =3D grab_extent_buffer(fs_info, p);
 -		if (exists) {
 -			spin_unlock(&mapping->i_private_lock);
 -			unlock_page(p);
 -			put_page(p);
 -			mark_extent_buffer_accessed(exists, p);
 -			btrfs_free_subpage(prealloc);
 -			goto free_eb;
 +	/* Attach all pages to the filemap. */
 +	for (int i =3D 0; i < num_pages; i++) {
 +		struct page *p;
 +
 +		ret =3D attach_eb_page_to_filemap(eb, i, &existing_eb);
 +		if (ret > 0) {
 +			ASSERT(existing_eb);
 +			goto out;
  		}
 +		attached++;
 +
 +		/*
 +		 * Only after attach_eb_page_to_filemap(), eb->pages[] is
 +		 * reliable, as we may choose to reuse the existing page cache
 +		 * and free the allocated page.
 +		 */
 +		p =3D eb->pages[i];
- 		spin_lock(&mapping->private_lock);
++		spin_lock(&mapping->i_private_lock);
  		/* Should not fail, as we have preallocated the memory */
  		ret =3D attach_extent_buffer_page(eb, p, prealloc);
  		ASSERT(!ret);
@@@ -3640,17 -3558,10 +3640,17 @@@
  		 * Thus needs no special handling in error path.
  		 */
  		btrfs_page_inc_eb_refs(fs_info, p);
- 		spin_unlock(&mapping->private_lock);
+ 		spin_unlock(&mapping->i_private_lock);
 =20
  		WARN_ON(btrfs_page_test_dirty(fs_info, p, eb->start, eb->len));
 -		eb->pages[i] =3D p;
 +
 +		/*
 +		 * Check if the current page is physically contiguous with previous eb
 +		 * page.
 +		 */
 +		if (i && eb->pages[i - 1] + 1 !=3D p)
 +			page_contig =3D false;
 +
  		if (!btrfs_page_test_uptodate(fs_info, p, eb->start, eb->len))
  			uptodate =3D 0;
 =20
@@@ -4713,11 -4560,11 +4713,11 @@@ static int try_release_subpage_extent_b
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
@@@ -4735,12 -4581,12 +4735,12 @@@ int try_release_extent_buffer(struct pa
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

--Sig_/rySalxan94zsooOnOA8FNpb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVxBH0ACgkQAVBC80lX
0GwrSwf/UxOMjU+dDm/uEIfrJzwws2tH1k8/N5I09iPVASfrM/lGWk2p95jR1+2f
i3zm6IlpZsMJWzIF9VCvKUQao6ZAtjk09qopf69U7fgyDe/1KKmarg2iblA4zr2X
geTUJHRg9NEw1Yg8q8Txe+MAZcYBzf0+QhNcFSa7efusATNibM5RpM24wut5bUon
QJ+OGh2Q2t471wPjDbryQ/MlqdZTBYecoqTLQAfupx4sOI/Ooj8D5NfnbMXtl4Vo
kwrNKJr9HlNVVr42J/vwsPCmQnW58ido73AjvvVqBPeom6ZcjA6ZrUdW3iN1NWbK
oamWBNDnO5l4eMbF9q9oH5sSxgN4+Q==
=u0wM
-----END PGP SIGNATURE-----

--Sig_/rySalxan94zsooOnOA8FNpb--
