Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925BD7A1204
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 01:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjINXrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 19:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjINXri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 19:47:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4C42100;
        Thu, 14 Sep 2023 16:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694735252;
        bh=9patxbNFGAzErm12k2acKDbtykuvtFZGquoKci9pL2Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S4ylrAEvFGUjAedAM7hKhJk1oI23FnsRLMmTUUXQDX/nQnbtCetlpqj3otm5HNUWO
         Ibeeog+VSaMLOnLQbhmZC1AN4ebaE6YWctvpdzc+aktMJpxyV2Jtuz8dDa3BhGwa1N
         k6E0DCs0A5I6Dk3KAyDUdxOh7olff2FdmTXSBHblC5Gcu6zWEUzysB9IK5t0vUKIoy
         s3E1wUc7/MDMsQsURgTpO8B2v8mYUvDvoYyBpLu4b39xQw3KkjrWDQs8e2nQVkuoCa
         DTwGk3kPAdTCOqLHStiRtBwwh92E92tZzrnRE0jjJAahN2+LgCbLtmWpZp11bNnduP
         L7qMQ5ClqQt/w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RmvBW6kD7z4wb1;
        Fri, 15 Sep 2023 09:47:31 +1000 (AEST)
Date:   Fri, 15 Sep 2023 09:47:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: linux-next: manual merge of the btrfs tree with the mm tree
Message-ID: <20230915094731.076a3e98@canb.auug.org.au>
In-Reply-To: <20230915091421.58207f2c@canb.auug.org.au>
References: <20230915091421.58207f2c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9uejlp7IAa7pwaCXIWPCDo_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9uejlp7IAa7pwaCXIWPCDo_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[Forgot the diff ...]

On Fri, 15 Sep 2023 09:14:21 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the btrfs tree got a conflict in:
>=20
>   fs/btrfs/super.c
>=20
> between commit:
>=20
>   c0824542e4d1 ("fs: super: dynamically allocate the s_shrink")
>=20
> from the mm tree and commit:
>=20
>   2ebed4689ba2 ("btrfs: open block devices after superblock creation")
>=20
> from the btrfs tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/btrfs/super.c
index 3b165d9967bb,3eff75e06a57..000000000000
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@@ -1518,8 -1459,23 +1459,23 @@@ static struct dentry *btrfs_mount_root(
  		if ((flags ^ s->s_flags) & SB_RDONLY)
  			error =3D -EBUSY;
  	} else {
- 		snprintf(s->s_id, sizeof(s->s_id), "%pg", bdev);
+ 		struct btrfs_fs_devices *fs_devices =3D fs_info->fs_devices;
+=20
+ 		mutex_lock(&uuid_mutex);
+ 		error =3D btrfs_open_devices(fs_devices, sb_open_mode(flags),
+ 					   fs_type);
+ 		mutex_unlock(&uuid_mutex);
+ 		if (error)
+ 			goto error_deactivate;
+=20
+ 		if (!(flags & SB_RDONLY) && fs_devices->rw_devices =3D=3D 0) {
+ 			error =3D -EACCES;
+ 			goto error_deactivate;
+ 		}
+=20
+ 		snprintf(s->s_id, sizeof(s->s_id), "%pg",
+ 			 fs_devices->latest_dev->bdev);
 -		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s", fs_type->name,
 +		shrinker_debugfs_rename(s->s_shrink, "sb-%s:%s", fs_type->name,
  					s->s_id);
  		btrfs_sb(s)->bdev_holder =3D fs_type;
  		error =3D btrfs_fill_super(s, fs_devices, data);

--Sig_/9uejlp7IAa7pwaCXIWPCDo_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUDm5MACgkQAVBC80lX
0GwNlgf/c8QLvGO7aWYDfCnianzsnQO453i8/VaSFrJoo6X22GtnnKFYpJ73yhxn
N+5CNz75RUJGI3/ZLlNaFY5CPoN2RTRrnnaypb5TMzuXIthynSdpSZETNwCJN8IB
O5VdkxxnLJmiaCdh8JD1QejOSlRBAjhOlMS8albR9XIuRbF8Nu4TC/PolAkz0/VE
qf3fd9PRSbf2yAe33dbIV7szOCkbY2GJtXn2LqgnDx+dTeBgTlcIT6XOCVUY/NG/
d482Y7XLdPYvVTuICHBA4h7rgYlAdHE1iJ40P3jGCALuGd8nDRYXh4zl1iZrYAa2
6V8dv/5fL1kGW8gAv2jfhnlTRmCCUQ==
=sG5a
-----END PGP SIGNATURE-----

--Sig_/9uejlp7IAa7pwaCXIWPCDo_--
