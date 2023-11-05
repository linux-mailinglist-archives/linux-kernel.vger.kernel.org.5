Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40CE7E1755
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 23:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjKEWYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 17:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEWYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 17:24:19 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2FECF;
        Sun,  5 Nov 2023 14:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699223050;
        bh=YAxELxRWIwi3c78SCzfri2Ak5wWEvow0ypGfivoE5p8=;
        h=Date:From:To:Cc:Subject:From;
        b=a5pAmDZKcdrZF5107HD+V6yB4Fhj4EXTK/W1vMZ/zwQUh8YD8KKxBzcR/7fphNNdE
         fsIhYJzGJwqRe8UHYryftK4i5KrfGNdHbGRo6rYoSXQ+oMf2Vcqv2xIm+uQviiaPdE
         EKw0rCmsS73R2OPEaKTotWv/RkGMRrjHDxHJJ1j0OkzcXtemh+8h5HHJUUtsl18yPF
         UIG/0bg0t8vUJwArFNYztuFCZvhcWgW+Q/CZdjPw+P9jDyK9nFZHVSmY0s+jUqA6Aa
         9X6G7/uYGu0EL/dZBT5QtBMlgTDQseJWwloaTbYJfVGMqdn8iDee/Vypgn+9PWmtWR
         +UjDLKRTCnTFw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SNptL40vRz4x1v;
        Mon,  6 Nov 2023 09:24:10 +1100 (AEDT)
Date:   Mon, 6 Nov 2023 09:24:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jeff Layton <jlayton@kernel.org>, Ilya Dryomov <idryomov@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Xiubo Li <xiubli@redhat.com>
Subject: linux-next: manual merge of the ceph tree with Linus' tree
Message-ID: <20231106092408.24ea682e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1j8nlq0XA/GSLTG=Ly2X_.v";
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

--Sig_/1j8nlq0XA/GSLTG=Ly2X_.v
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ceph tree got a conflict in:

  fs/ceph/inode.c

between commit:

  c453bdb53534 ("ceph: convert to new timestamp accessors")

from Linus' tree and commit:

  38d46409c463 ("ceph: print cluster fsid and client global_id in all debug=
 logs")

from the ceph tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/ceph/inode.c
index 2e2a303b9e64,b1b92a948a3b..000000000000
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@@ -833,33 -847,29 +847,32 @@@ void ceph_fill_file_time(struct inode *
  		if (ci->i_version =3D=3D 0 ||
  		    ceph_seq_cmp(time_warp_seq, ci->i_time_warp_seq) > 0) {
  			/* the MDS did a utimes() */
- 			dout("mtime %lld.%09ld -> %lld.%09ld "
- 			     "tw %d -> %d\n",
- 			     inode_get_mtime_sec(inode),
- 			     inode_get_mtime_nsec(inode),
- 			     mtime->tv_sec, mtime->tv_nsec,
- 			     ci->i_time_warp_seq, (int)time_warp_seq);
+ 			doutc(cl, "mtime %lld.%09ld -> %lld.%09ld tw %d -> %d\n",
 -			      inode->i_mtime.tv_sec, inode->i_mtime.tv_nsec,
++			      inode_get_mtime_sec(inode),
++			      inode_get_mtime_nsec(inode),
+ 			      mtime->tv_sec, mtime->tv_nsec,
+ 			      ci->i_time_warp_seq, (int)time_warp_seq);
 =20
 -			inode->i_mtime =3D *mtime;
 -			inode->i_atime =3D *atime;
 +			inode_set_mtime_to_ts(inode, *mtime);
 +			inode_set_atime_to_ts(inode, *atime);
  			ci->i_time_warp_seq =3D time_warp_seq;
  		} else if (time_warp_seq =3D=3D ci->i_time_warp_seq) {
 +			struct timespec64	ts;
 +
  			/* nobody did utimes(); take the max */
 -			if (timespec64_compare(mtime, &inode->i_mtime) > 0) {
 +			ts =3D inode_get_mtime(inode);
 +			if (timespec64_compare(mtime, &ts) > 0) {
- 				dout("mtime %lld.%09ld -> %lld.%09ld inc\n",
- 				     ts.tv_sec, ts.tv_nsec,
- 				     mtime->tv_sec, mtime->tv_nsec);
+ 				doutc(cl, "mtime %lld.%09ld -> %lld.%09ld inc\n",
 -				      inode->i_mtime.tv_sec,
 -				      inode->i_mtime.tv_nsec,
++				      ts.tv_sec, ts.tv_nsec,
+ 				      mtime->tv_sec, mtime->tv_nsec);
 -				inode->i_mtime =3D *mtime;
 +				inode_set_mtime_to_ts(inode, *mtime);
  			}
 -			if (timespec64_compare(atime, &inode->i_atime) > 0) {
 +			ts =3D inode_get_atime(inode);
 +			if (timespec64_compare(atime, &ts) > 0) {
- 				dout("atime %lld.%09ld -> %lld.%09ld inc\n",
- 				     ts.tv_sec, ts.tv_nsec,
- 				     atime->tv_sec, atime->tv_nsec);
+ 				doutc(cl, "atime %lld.%09ld -> %lld.%09ld inc\n",
 -				      inode->i_atime.tv_sec,
 -				      inode->i_atime.tv_nsec,
++				      ts.tv_sec, ts.tv_nsec,
+ 				      atime->tv_sec, atime->tv_nsec);
 -				inode->i_atime =3D *atime;
 +				inode_set_atime_to_ts(inode, *atime);
  			}
  		} else if (issued & CEPH_CAP_FILE_EXCL) {
  			/* we did a utimes(); ignore mds values */
@@@ -2554,22 -2595,21 +2598,22 @@@ retry
  	}
 =20
  	if (ia_valid & ATTR_ATIME) {
 +		struct timespec64 atime =3D inode_get_atime(inode);
 +
- 		dout("setattr %p atime %lld.%ld -> %lld.%ld\n", inode,
- 		     atime.tv_sec, atime.tv_nsec,
- 		     attr->ia_atime.tv_sec, attr->ia_atime.tv_nsec);
+ 		doutc(cl, "%p %llx.%llx atime %lld.%ld -> %lld.%ld\n",
 -		      inode, ceph_vinop(inode), inode->i_atime.tv_sec,
 -		      inode->i_atime.tv_nsec, attr->ia_atime.tv_sec,
 -		      attr->ia_atime.tv_nsec);
++		      inode, ceph_vinop(inode), atime.tv_sec, atime.tv_nsec,
++		      attr->ia_atime.tv_sec, attr->ia_atime.tv_nsec);
  		if (issued & CEPH_CAP_FILE_EXCL) {
  			ci->i_time_warp_seq++;
 -			inode->i_atime =3D attr->ia_atime;
 +			inode_set_atime_to_ts(inode, attr->ia_atime);
  			dirtied |=3D CEPH_CAP_FILE_EXCL;
  		} else if ((issued & CEPH_CAP_FILE_WR) &&
 -			   timespec64_compare(&inode->i_atime,
 -					    &attr->ia_atime) < 0) {
 -			inode->i_atime =3D attr->ia_atime;
 +			   timespec64_compare(&atime,
 +					      &attr->ia_atime) < 0) {
 +			inode_set_atime_to_ts(inode, attr->ia_atime);
  			dirtied |=3D CEPH_CAP_FILE_WR;
  		} else if ((issued & CEPH_CAP_FILE_SHARED) =3D=3D 0 ||
 -			   !timespec64_equal(&inode->i_atime, &attr->ia_atime)) {
 +			   !timespec64_equal(&atime, &attr->ia_atime)) {
  			ceph_encode_timespec64(&req->r_args.setattr.atime,
  					       &attr->ia_atime);
  			mask |=3D CEPH_SETATTR_ATIME;
@@@ -2629,21 -2670,21 +2674,21 @@@
  		}
  	}
  	if (ia_valid & ATTR_MTIME) {
 +		struct timespec64 mtime =3D inode_get_mtime(inode);
 +
- 		dout("setattr %p mtime %lld.%ld -> %lld.%ld\n", inode,
- 		     mtime.tv_sec, mtime.tv_nsec,
- 		     attr->ia_mtime.tv_sec, attr->ia_mtime.tv_nsec);
+ 		doutc(cl, "%p %llx.%llx mtime %lld.%ld -> %lld.%ld\n",
 -		      inode, ceph_vinop(inode), inode->i_mtime.tv_sec,
 -		      inode->i_mtime.tv_nsec, attr->ia_mtime.tv_sec,
 -		      attr->ia_mtime.tv_nsec);
++		      inode, ceph_vinop(inode), mtime.tv_sec, mtime.tv_nsec,
++		      attr->ia_mtime.tv_sec, attr->ia_mtime.tv_nsec);
  		if (issued & CEPH_CAP_FILE_EXCL) {
  			ci->i_time_warp_seq++;
 -			inode->i_mtime =3D attr->ia_mtime;
 +			inode_set_mtime_to_ts(inode, attr->ia_mtime);
  			dirtied |=3D CEPH_CAP_FILE_EXCL;
  		} else if ((issued & CEPH_CAP_FILE_WR) &&
 -			   timespec64_compare(&inode->i_mtime,
 -					    &attr->ia_mtime) < 0) {
 -			inode->i_mtime =3D attr->ia_mtime;
 +			   timespec64_compare(&mtime, &attr->ia_mtime) < 0) {
 +			inode_set_mtime_to_ts(inode, attr->ia_mtime);
  			dirtied |=3D CEPH_CAP_FILE_WR;
  		} else if ((issued & CEPH_CAP_FILE_SHARED) =3D=3D 0 ||
 -			   !timespec64_equal(&inode->i_mtime, &attr->ia_mtime)) {
 +			   !timespec64_equal(&mtime, &attr->ia_mtime)) {
  			ceph_encode_timespec64(&req->r_args.setattr.mtime,
  					       &attr->ia_mtime);
  			mask |=3D CEPH_SETATTR_MTIME;
@@@ -2656,11 -2697,12 +2701,12 @@@
  	if (ia_valid & ATTR_CTIME) {
  		bool only =3D (ia_valid & (ATTR_SIZE|ATTR_MTIME|ATTR_ATIME|
  					 ATTR_MODE|ATTR_UID|ATTR_GID)) =3D=3D 0;
- 		dout("setattr %p ctime %lld.%ld -> %lld.%ld (%s)\n", inode,
- 		     inode_get_ctime_sec(inode),
- 		     inode_get_ctime_nsec(inode),
- 		     attr->ia_ctime.tv_sec, attr->ia_ctime.tv_nsec,
- 		     only ? "ctime only" : "ignored");
+ 		doutc(cl, "%p %llx.%llx ctime %lld.%ld -> %lld.%ld (%s)\n",
 -		      inode, ceph_vinop(inode), inode_get_ctime(inode).tv_sec,
 -		      inode_get_ctime(inode).tv_nsec,
++		      inode, ceph_vinop(inode), inode_get_ctime_sec(inode),
++		      inode_get_ctime_nsec(inode),
+ 		      attr->ia_ctime.tv_sec, attr->ia_ctime.tv_nsec,
+ 		      only ? "ctime only" : "ignored");
+=20
  		if (only) {
  			/*
  			 * if kernel wants to dirty ctime but nothing else,

--Sig_/1j8nlq0XA/GSLTG=Ly2X_.v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVIFggACgkQAVBC80lX
0Gxd6wf8ClPpTZaexMFzLxPb60d+d5N50oCz4lIuf+1hKR178blo2DiD0lYX5s3X
KmzbRTJo+XmdK5pyfENBp6GG/TUYVjRcgJ1NIflVKU4cQA4gaOUITKpyEu4fbSTe
dEzRtkDJR0Fxbede0pnROarIzgAYL4euhpvfhnyBP92Ep+fGGrtMEVmPq4znoKeZ
otFSkaVNshBr+2TMApR7KBWk5ZsIQwUU3JUZ4J+DtOKYnZrausb40uZ4lTIacj9s
cweULZ3xHXWIt4kDJJkSTY/RyfajMAClndWhfUXD5XzogihV8xZUNO9cdMoS+tW9
lPbCbPM6GCeKVV0gMckReQIj5w9wpQ==
=L02l
-----END PGP SIGNATURE-----

--Sig_/1j8nlq0XA/GSLTG=Ly2X_.v--
