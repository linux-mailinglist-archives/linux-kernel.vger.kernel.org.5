Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71AB7F0B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 05:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjKTEWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 23:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTEWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 23:22:43 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3623BC5;
        Sun, 19 Nov 2023 20:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700454156;
        bh=0q6NjU+ifeLvujPJLHr8VqYO47RqQ4I3ODqxgOoEHMY=;
        h=Date:From:To:Cc:Subject:From;
        b=SWM5zXWmCl9j2pPW5U4s2sP/7ykJceEih5LBo4n7tulgcg9ecov73QBwrU1jSz/gy
         5d87zLWpgenaT673+I/V71Z80HQs5zI4nMezehUVreW+r4XvrR76IkCsoK155PyRUp
         3Wm1UsnIyJKTFTrwp10qsnY47K2oH8oe6Y2YuQ1GuSUOcP2QStBreNvCYh7gdVse36
         Ddb3al2kKGjsfYl+NG/UVAWS9m4GrE1yOiABts1Ct2HsA6diM5O0wZ4n3Cioxmu8Rr
         tzBkuInPyoXWh5TG/i87kZ3np9VFHAUx600dtU6w084YCTaXBdn+pXiKP4//mLGzgr
         iPCwyisrsm3GQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SYZ9M3Hsmz4xS9;
        Mon, 20 Nov 2023 15:22:31 +1100 (AEDT)
Date:   Mon, 20 Nov 2023 15:22:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     KVM <kvm@vger.kernel.org>, Ackerley Tng <ackerleytng@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kvm tree
Message-ID: <20231120152227.3bfe2450@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HQyEe5MksKX=y34cCuJH7xS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HQyEe5MksKX=y34cCuJH7xS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kvm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

arch/x86/kvm/../../../virt/kvm/guest_memfd.c:306:10: error: 'const struct a=
ddress_space_operations' has no member named 'error_remove_page'; did you m=
ean 'error_remove_folio'?
  306 |         .error_remove_page =3D kvm_gmem_error_page,
      |          ^~~~~~~~~~~~~~~~~
      |          error_remove_folio
arch/x86/kvm/../../../virt/kvm/guest_memfd.c:306:30: error: initialization =
of 'int (*)(struct folio *)' from incompatible pointer type 'int (*)(struct=
 address_space *, struct page *)' [-Werror=3Dincompatible-pointer-types]
  306 |         .error_remove_page =3D kvm_gmem_error_page,
      |                              ^~~~~~~~~~~~~~~~~~~
arch/x86/kvm/../../../virt/kvm/guest_memfd.c:306:30: note: (near initializa=
tion for 'kvm_gmem_aops.launder_folio')

Caused by commit

  640be5bc564f ("fs: convert error_remove_page to error_remove_folio")

from the mm tree intercting with commit

  a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific=
 backing memory")

I have applied the following supplied merge fix patch (thanks Andrew).

From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 17 Nov 2023 09:28:33 -0800
Subject: [PATCH] fs: Convert error_remove_page to error_remove_folio

On Fri, 17 Nov 2023 16:14:47 +0000 "Matthew Wilcox (Oracle)" <willy@infrade=
ad.org> wrote:

> There were already assertions that we were not passing a tail page
> to error_remove_page(), so make the compiler enforce that by converting
> everything to pass and use a folio.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  Documentation/filesystems/locking.rst |  4 ++--
>  Documentation/filesystems/vfs.rst     |  6 +++---
>  block/fops.c                          |  2 +-
>  fs/afs/write.c                        |  2 +-
>  fs/bcachefs/fs.c                      |  2 +-
>  fs/btrfs/inode.c                      |  2 +-
>  fs/ceph/addr.c                        |  4 ++--
>  fs/ext2/inode.c                       |  2 +-
>  fs/ext4/inode.c                       |  6 +++---
>  fs/f2fs/compress.c                    |  2 +-
>  fs/f2fs/inode.c                       |  2 +-
>  fs/gfs2/aops.c                        |  4 ++--
>  fs/hugetlbfs/inode.c                  |  6 +++---
>  fs/nfs/file.c                         |  2 +-
>  fs/ntfs/aops.c                        |  6 +++---
>  fs/ocfs2/aops.c                       |  2 +-
>  fs/xfs/xfs_aops.c                     |  2 +-
>  fs/zonefs/file.c                      |  2 +-
>  include/linux/fs.h                    |  2 +-
>  include/linux/mm.h                    |  3 ++-
>  mm/memory-failure.c                   | 10 +++++-----
>  mm/shmem.c                            |  6 +++---
>  mm/truncate.c                         |  9 ++++-----
>  virt/kvm/guest_memfd.c                |  9 +++++----

virt/kvm/guest_memfd.c exists only in the KVM tree (and hence
linux-next).  So I assume Stephen will use the change from this patch
when doing his resolution.

This:
---
 virt/kvm/guest_memfd.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index b99272396119..451435123fe7 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -267,7 +267,8 @@ static int kvm_gmem_migrate_folio(struct address_space =
*mapping,
 	return -EINVAL;
 }
=20
-static int kvm_gmem_error_page(struct address_space *mapping, struct page =
*page)
+static int kvm_gmem_error_folio(struct address_space *mapping,
+		struct folio *folio)
 {
 	struct list_head *gmem_list =3D &mapping->private_list;
 	struct kvm_gmem *gmem;
@@ -275,8 +276,8 @@ static int kvm_gmem_error_page(struct address_space *ma=
pping, struct page *page)
=20
 	filemap_invalidate_lock_shared(mapping);
=20
-	start =3D page->index;
-	end =3D start + thp_nr_pages(page);
+	start =3D folio->index;
+	end =3D start + folio_nr_pages(folio);
=20
 	list_for_each_entry(gmem, gmem_list, entry)
 		kvm_gmem_invalidate_begin(gmem, start, end);
@@ -303,7 +304,7 @@ static const struct address_space_operations kvm_gmem_a=
ops =3D {
 #ifdef CONFIG_MIGRATION
 	.migrate_folio	=3D kvm_gmem_migrate_folio,
 #endif
-	.error_remove_page =3D kvm_gmem_error_page,
+	.error_remove_folio =3D kvm_gmem_error_folio,
 };
=20
 static int kvm_gmem_getattr(struct mnt_idmap *idmap, const struct path *pa=
th,
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/HQyEe5MksKX=y34cCuJH7xS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVa3wMACgkQAVBC80lX
0GyOogf9EJDh3i01lt60JctG5HM++m93Iszf4pAQw5fEiRxG/YKyWCAC/mK6s9mq
UTlcebdBYgcYGtDclNoYVpZ2mYXqfwxEhPkfT6glga1POWDW/acuhLtTe/yo7uUX
oz4liDYNa76V+Q3lPtrdAfbUiwudq7AHwkuWBnjCeDbOByQrDaV5y5YEOSemC1Zg
0j5G8xNLyTMZFk2T0w3Lmb8QBimcf1g2ECwZr5Cvse6kCsoq+nuVwJmnEv8kWR4K
QrD8EngzncFxH3RWcVKBCn4E51NLOdJkj1d71uq5UlyA5rsZ8Cu5WZ7vsqV+hgqP
2EgAhy4WoIFPvKzcOA9jydK0uV3dSA==
=gNFH
-----END PGP SIGNATURE-----

--Sig_/HQyEe5MksKX=y34cCuJH7xS--
