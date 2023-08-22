Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51A8783734
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 03:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjHVBGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 21:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHVBGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 21:06:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734D7185;
        Mon, 21 Aug 2023 18:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692666354;
        bh=dLNPkNzrsUQPHYqcG5PTQ5m5jKVe/5xNPpVdDqWY0P8=;
        h=Date:From:To:Cc:Subject:From;
        b=FmwletMLLrIuDFZMN8bemXT9zKovdse0zED9O2+28i62B3Y9jE4UNAW/4Ux7nLhmn
         yW+ns8HthyWCunUvBJq0HEZI3++5pCDsY+JeZ1rTDDUxgoAoHa4fwzA0SRaLd3lXKA
         Am/CDe153+dHxdgcMgtrsfmZ0UFzxDzwLrGTda+QUOR3SsO31UIFP0NwBzaJYPcKBM
         /DacOUp3H00p8DI6dZOPUTSq4zcEYwkQrgRq92D8vhW7y5ntPfwu8dkkYtgcF6HKqh
         zaX0zDWAVdCYXqF3bVBiBOR2Uxd1wAfed0ZmLapZn+Zp+9qy9FcetaBm2qmkHyladH
         PXlPlGSwkdb3Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RVB416cwvz4wxQ;
        Tue, 22 Aug 2023 11:05:53 +1000 (AEST)
Date:   Tue, 22 Aug 2023 11:05:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the djw-vfs
 tree
Message-ID: <20230822110551.6386dd5d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5s5T0c62aH+9qxSzh6nDAM9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5s5T0c62aH+9qxSzh6nDAM9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/super.c

between commits:

  880b9577855e ("fs: distinguish between user initiated freeze and kernel i=
nitiated freeze")
  59ba4fdd2d1f ("fs: wait for partially frozen filesystems")

from the djw-vfs tree and commits:

  0ed33598ddf3 ("super: use locking helpers")
  5e8749141521 ("super: wait for nascent superblocks")

from the vfs-brauner tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/super.c
index da68584815e4,a00e9f706f0f..000000000000
--- a/fs/super.c
+++ b/fs/super.c
@@@ -1027,12 -1196,13 +1196,13 @@@ void emergency_remount(void
 =20
  static void do_thaw_all_callback(struct super_block *sb)
  {
- 	down_write(&sb->s_umount);
- 	if (sb->s_root && sb->s_flags & SB_BORN) {
+ 	bool born =3D super_lock_excl(sb);
+=20
+ 	if (born && sb->s_root) {
  		emergency_thaw_bdev(sb);
 -		thaw_super_locked(sb);
 +		thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE);
  	} else {
- 		up_write(&sb->s_umount);
+ 		super_unlock_excl(sb);
  	}
  }
 =20
@@@ -1644,24 -1836,6 +1836,24 @@@ static void sb_freeze_unlock(struct sup
  		percpu_up_write(sb->s_writers.rw_sem + level);
  }
 =20
 +static int wait_for_partially_frozen(struct super_block *sb)
 +{
 +	int ret =3D 0;
 +
 +	do {
 +		unsigned short old =3D sb->s_writers.frozen;
 +
- 		up_write(&sb->s_umount);
++		super_unlock_excl(sb);
 +		ret =3D wait_var_event_killable(&sb->s_writers.frozen,
 +					       sb->s_writers.frozen !=3D old);
- 		down_write(&sb->s_umount);
++		__super_lock_excl(sb);
 +	} while (ret =3D=3D 0 &&
 +		 sb->s_writers.frozen !=3D SB_UNFROZEN &&
 +		 sb->s_writers.frozen !=3D SB_FREEZE_COMPLETE);
 +
 +	return ret;
 +}
 +
  /**
   * freeze_super - lock the filesystem and force it into a consistent state
   * @sb: the super to lock
@@@ -1711,34 -1874,10 +1903,34 @@@ int freeze_super(struct super_block *sb
  	int ret;
 =20
  	atomic_inc(&sb->s_active);
- 	down_write(&sb->s_umount);
+ 	__super_lock_excl(sb);
 +
 +retry:
 +	if (sb->s_writers.frozen =3D=3D SB_FREEZE_COMPLETE) {
 +		if (sb->s_writers.freeze_holders & who) {
 +			deactivate_locked_super(sb);
 +			return -EBUSY;
 +		}
 +
 +		WARN_ON(sb->s_writers.freeze_holders =3D=3D 0);
 +
 +		/*
 +		 * Someone else already holds this type of freeze; share the
 +		 * freeze and assign the active ref to the freeze.
 +		 */
 +		sb->s_writers.freeze_holders |=3D who;
- 		up_write(&sb->s_umount);
++		super_unlock_excl(sb);
 +		return 0;
 +	}
 +
  	if (sb->s_writers.frozen !=3D SB_UNFROZEN) {
 -		deactivate_locked_super(sb);
 -		return -EBUSY;
 +		ret =3D wait_for_partially_frozen(sb);
 +		if (ret) {
 +			deactivate_locked_super(sb);
 +			return ret;
 +		}
 +
 +		goto retry;
  	}
 =20
  	if (!(sb->s_flags & SB_BORN)) {
@@@ -1748,10 -1887,8 +1940,10 @@@
 =20
  	if (sb_rdonly(sb)) {
  		/* Nothing to do really... */
 +		sb->s_writers.freeze_holders |=3D who;
  		sb->s_writers.frozen =3D SB_FREEZE_COMPLETE;
 +		wake_up_var(&sb->s_writers.frozen);
- 		up_write(&sb->s_umount);
+ 		super_unlock_excl(sb);
  		return 0;
  	}
 =20
@@@ -1795,11 -1930,9 +1987,11 @@@
  	 * For debugging purposes so that fs can warn if it sees write activity
  	 * when frozen is set to SB_FREEZE_COMPLETE, and for thaw_super().
  	 */
 +	sb->s_writers.freeze_holders |=3D who;
  	sb->s_writers.frozen =3D SB_FREEZE_COMPLETE;
 +	wake_up_var(&sb->s_writers.frozen);
  	lockdep_sb_freeze_release(sb);
- 	up_write(&sb->s_umount);
+ 	super_unlock_excl(sb);
  	return 0;
  }
  EXPORT_SYMBOL(freeze_super);
@@@ -1814,24 -1941,8 +2006,24 @@@ static int thaw_super_locked(struct sup
  {
  	int error;
 =20
 -	if (sb->s_writers.frozen !=3D SB_FREEZE_COMPLETE) {
 +	if (sb->s_writers.frozen =3D=3D SB_FREEZE_COMPLETE) {
 +		if (!(sb->s_writers.freeze_holders & who)) {
- 			up_write(&sb->s_umount);
++			super_unlock_excl(sb);
 +			return -EINVAL;
 +		}
 +
 +		/*
 +		 * Freeze is shared with someone else.  Release our hold and
 +		 * drop the active ref that freeze_super assigned to the
 +		 * freezer.
 +		 */
 +		if (sb->s_writers.freeze_holders & ~who) {
 +			sb->s_writers.freeze_holders &=3D ~who;
 +			deactivate_locked_super(sb);
 +			return 0;
 +		}
 +	} else {
- 		up_write(&sb->s_umount);
+ 		super_unlock_excl(sb);
  		return -EINVAL;
  	}
 =20
@@@ -1867,19 -1974,13 +2059,19 @@@ out
  /**
   * thaw_super -- unlock filesystem
   * @sb: the super to thaw
 + * @who: context that wants to freeze
   *
 - * Unlocks the filesystem and marks it writeable again after freeze_super=
().
 + * Unlocks the filesystem and marks it writeable again after freeze_super=
()
 + * if there are no remaining freezes on the filesystem.
 + *
 + * @who should be:
 + * * %FREEZE_HOLDER_USERSPACE if userspace wants to thaw the fs;
 + * * %FREEZE_HOLDER_KERNEL if the kernel wants to thaw the fs.
   */
 -int thaw_super(struct super_block *sb)
 +int thaw_super(struct super_block *sb, enum freeze_holder who)
  {
- 	down_write(&sb->s_umount);
+ 	__super_lock_excl(sb);
 -	return thaw_super_locked(sb);
 +	return thaw_super_locked(sb, who);
  }
  EXPORT_SYMBOL(thaw_super);
 =20

--Sig_/5s5T0c62aH+9qxSzh6nDAM9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTkCe8ACgkQAVBC80lX
0GwdYAgAnVXPkgH9pj9EdqgpZe1rscNRRxl9XmnILdgLXMv903dN+CVV66p26gez
bGBMOTdu8jEx3qi+udXNr1bAg3EjziG7ZhNxGnV9inEFgPiWv4YwF1bu6hNZouhz
TAYOgK3a/jwpU5/yY+8e7PdEtW5LCnPd9c3isyH/G86cezxDAtyfvWUBDtEoIUy6
gyQ2BPO2imu21DtBRroIseXo9CiJ/L1CTSmGEoD5ung4JLbdudBCAGdmqJz0yAZC
c83tyq6gBDlol1RgDoRekIjHlEPZC3Our4K4BwmpxumPC97QddjQOOHX4DaNXRwt
k+6voNE69nNeY5tRjBsiSPt76lmMcw==
=Hfsm
-----END PGP SIGNATURE-----

--Sig_/5s5T0c62aH+9qxSzh6nDAM9--
