Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47B67DC3B2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbjJaAmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjJaAmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:42:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886EB98;
        Mon, 30 Oct 2023 17:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698712919;
        bh=a4Hxqx+0CTVyusPauQe/h3KF1jX5MmLk6nH3Dh6Ja8A=;
        h=Date:From:To:Cc:Subject:From;
        b=twHymCGcm4HUckrQ+IjBCqJXNgzCc9UVUuJWYoBwmQtk0ggHc/EpwQyn6ALsrMvEs
         W7uaI4ewueSJkQY24bPDqi1Wm2TOJaOTpxdj+H7pXUZs3Fx03pacs+dtWw/AH0OJsd
         ITIZp1VITPWUv6RMMilGAdyOeCIAy0ABMMOpPvi1ihha5sqIRR+iYrodXJfkWmUvK7
         z9lmX5K48R1JiMViecxVmzPqjMepMerWPtzvQxNb+VAFR6kQZtB+jGG8HbGADRUrow
         TQ+Vv684RB38utxHejQ8UKJ97ofQYXkuu2SdL+k8KBHJ93uDtaqMlXBAsACGuhaMDw
         ynCsbTT4enIsQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SKBD734mLz4wd1;
        Tue, 31 Oct 2023 11:41:59 +1100 (AEDT)
Date:   Tue, 31 Oct 2023 11:41:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        David Chinner <david@fromorbit.com>
Cc:     <linux-xfs@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the xfs tree with Linus' tree
Message-ID: <20231031114158.548ff433@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KxSBFLBldxlh5yMp=MRA1aO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KxSBFLBldxlh5yMp=MRA1aO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the xfs tree got conflicts in:

  fs/xfs/libxfs/xfs_rtbitmap.c
  fs/xfs/xfs_rtalloc.c

between commit:

  75d1e312bbbd ("xfs: convert to new timestamp accessors")

from Linus' tree and commit:

  41f33d82cfd3 ("xfs: consolidate realtime allocation arguments")
  a684c538bc14 ("xfs: convert xfs_extlen_t to xfs_rtxlen_t in the rt alloca=
tor")
  2d5f216b77e3 ("xfs: convert rt extent numbers to xfs_rtxnum_t")

from the xfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/xfs/libxfs/xfs_rtbitmap.c
index 396648acb5be,b332ab490a48..000000000000
--- a/fs/xfs/libxfs/xfs_rtbitmap.c
+++ b/fs/xfs/libxfs/xfs_rtbitmap.c
@@@ -960,19 -931,18 +931,19 @@@ xfs_rtcheck_alloc_range
   * Free an extent in the realtime subvolume.  Length is expressed in
   * realtime extents, as is the block number.
   */
- int					/* error */
+ int
  xfs_rtfree_extent(
- 	xfs_trans_t	*tp,		/* transaction pointer */
- 	xfs_rtblock_t	bno,		/* starting block number to free */
- 	xfs_extlen_t	len)		/* length of extent freed */
+ 	struct xfs_trans	*tp,	/* transaction pointer */
+ 	xfs_rtxnum_t		start,	/* starting rtext number to free */
+ 	xfs_rtxlen_t		len)	/* length of extent freed */
  {
- 	int		error;		/* error value */
- 	xfs_mount_t	*mp;		/* file system mount structure */
- 	xfs_fsblock_t	sb;		/* summary file block number */
- 	struct xfs_buf	*sumbp =3D NULL;	/* summary file block buffer */
- 	struct timespec64 atime;
-=20
- 	mp =3D tp->t_mountp;
+ 	struct xfs_mount	*mp =3D tp->t_mountp;
+ 	struct xfs_rtalloc_args	args =3D {
+ 		.mp		=3D mp,
+ 		.tp		=3D tp,
+ 	};
+ 	int			error;
++	struct timespec64	atime;
 =20
  	ASSERT(mp->m_rbmip->i_itemp !=3D NULL);
  	ASSERT(xfs_isilocked(mp->m_rbmip, XFS_ILOCK_EXCL));
@@@ -1000,13 -970,46 +971,49 @@@
  	    mp->m_sb.sb_rextents) {
  		if (!(mp->m_rbmip->i_diflags & XFS_DIFLAG_NEWRTBM))
  			mp->m_rbmip->i_diflags |=3D XFS_DIFLAG_NEWRTBM;
 -		*(uint64_t *)&VFS_I(mp->m_rbmip)->i_atime =3D 0;
 +
 +		atime =3D inode_get_atime(VFS_I(mp->m_rbmip));
 +		*((uint64_t *)&atime) =3D 0;
 +		inode_set_atime_to_ts(VFS_I(mp->m_rbmip), atime);
  		xfs_trans_log_inode(tp, mp->m_rbmip, XFS_ILOG_CORE);
  	}
- 	return 0;
+ 	error =3D 0;
+ out:
+ 	xfs_rtbuf_cache_relse(&args);
+ 	return error;
+ }
+=20
+ /*
+  * Free some blocks in the realtime subvolume.  rtbno and rtlen are in un=
its of
+  * rt blocks, not rt extents; must be aligned to the rt extent size; and =
rtlen
+  * cannot exceed XFS_MAX_BMBT_EXTLEN.
+  */
+ int
+ xfs_rtfree_blocks(
+ 	struct xfs_trans	*tp,
+ 	xfs_fsblock_t		rtbno,
+ 	xfs_filblks_t		rtlen)
+ {
+ 	struct xfs_mount	*mp =3D tp->t_mountp;
+ 	xfs_rtxnum_t		start;
+ 	xfs_filblks_t		len;
+ 	xfs_extlen_t		mod;
+=20
+ 	ASSERT(rtlen <=3D XFS_MAX_BMBT_EXTLEN);
+=20
+ 	len =3D xfs_rtb_to_rtxrem(mp, rtlen, &mod);
+ 	if (mod) {
+ 		ASSERT(mod =3D=3D 0);
+ 		return -EIO;
+ 	}
+=20
+ 	start =3D xfs_rtb_to_rtxrem(mp, rtbno, &mod);
+ 	if (mod) {
+ 		ASSERT(mod =3D=3D 0);
+ 		return -EIO;
+ 	}
+=20
+ 	return xfs_rtfree_extent(tp, start, len);
  }
 =20
  /* Find all the free records within a given range. */
diff --cc fs/xfs/xfs_rtalloc.c
index 2e1a4e5cd03d,ba66442910b1..000000000000
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@@ -1420,16 -1414,16 +1414,16 @@@ xfs_rtunmount_inodes
   */
  int					/* error */
  xfs_rtpick_extent(
 -	xfs_mount_t	*mp,		/* file system mount point */
 -	xfs_trans_t	*tp,		/* transaction pointer */
 -	xfs_rtxlen_t	len,		/* allocation length (rtextents) */
 -	xfs_rtxnum_t	*pick)		/* result rt extent */
 -{
 -	xfs_rtxnum_t	b;		/* result rtext */
 -	int		log2;		/* log of sequence number */
 -	uint64_t	resid;		/* residual after log removed */
 -	uint64_t	seq;		/* sequence number of file creation */
 -	uint64_t	*seqp;		/* pointer to seqno in inode */
 +	xfs_mount_t		*mp,		/* file system mount point */
 +	xfs_trans_t		*tp,		/* transaction pointer */
- 	xfs_extlen_t		len,		/* allocation length (rtextents) */
- 	xfs_rtblock_t		*pick)		/* result rt extent */
++	xfs_rtxlen_t		len,		/* allocation length (rtextents) */
++	xfs_rtxnum_t		*pick)		/* result rt extent */
 +	{
- 	xfs_rtblock_t		b;		/* result block */
++	xfs_rtxnum_t		b;		/* result rtext */
 +	int			log2;		/* log of sequence number */
 +	uint64_t		resid;		/* residual after log removed */
 +	uint64_t		seq;		/* sequence number of file creation */
 +	struct timespec64	ts;		/* temporary timespec64 storage */
 =20
  	ASSERT(xfs_isilocked(mp->m_rbmip, XFS_ILOCK_EXCL));
 =20

--Sig_/KxSBFLBldxlh5yMp=MRA1aO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVATVYACgkQAVBC80lX
0GwwXAf9GxpP7kHw4pI0RM0rQWsKC3UddPkaZgaLMyxHY0gsDvBVza7t7Lx4/YJr
5M66pkoyVJiOV5WkLk9DXvW7KS4fOulA9QfwTXq5Nr5oaQZNTAQuf4QRsLiYUX+v
JqgNdyYx5sepcFB5m+IOKjzpjcAuGOkt6VcEbQtw2e2Xo7QOIEWrdV0Ry6HWlrec
kknwoHH0355rjZqivbELtPConczrIY1doyKnHitP0YSPSbeJ9VCxenMFfkeLwLkQ
PTNUUwAhqt0BcdFO8fynSdQsoWt8gENTA/tNMI7AyKQ9J6Rqo8TKNhHsESZvLeno
qdeK7+Yp9NePWDzwtfraz+mIz6GXsw==
=fHMO
-----END PGP SIGNATURE-----

--Sig_/KxSBFLBldxlh5yMp=MRA1aO--
