Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD38077C500
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjHOBUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjHOBU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:20:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A12AB2;
        Mon, 14 Aug 2023 18:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692062425;
        bh=JzJbi7tR/wVkQLC5d6yA0uesbpLj1o0LVg+u0WfLu5g=;
        h=Date:From:To:Cc:Subject:From;
        b=AiWwwKUW4/UGDLRWOkbkozlJpjEzC14UXLU92Lc1f/9U7MHcBn+p6jI0eTGKWwKlp
         1tePIMjG/u6KRC3mUEgrAnnwc5791rPPTMXKb6m/4zkZdx4s6JIFS2d6RsaoXCor6s
         RVuY9fF0xQIFhp21Wo75lIUvrRNvvvYiMiaNylcV8F1DnBbshY5XxDl5qEyGzDWIia
         W/q4lw1kpuvdMfjFjjGZS1vJv2wKXPZJA/aWsZI3sKuh3QEVR/WXW1PLAp3caoJ66u
         80tSxKeQFMgjz1AefBRHXlKvXeuOukaK/6/3Vtg1Jf1TLscgDjA3D8hu65vr9HQduV
         Asd5yWOsycFCg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPtjz6x5jz4wb5;
        Tue, 15 Aug 2023 11:20:23 +1000 (AEST)
Date:   Tue, 15 Aug 2023 11:20:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, Jeff Layton <jlayton@kernel.org>,
        Lee Trager <lee@trager.us>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs-brauner tree with the btrfs
 tree
Message-ID: <20230815112023.5903355c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/17NS/+R44cg_uOmnaNkxqKg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/17NS/+R44cg_uOmnaNkxqKg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  fs/btrfs/inode.c

between commit:

  ea6aa58a9229 ("btrfs: copy dir permission and time when creating a stub s=
ubvolume")

from the btrfs tree and commit:

  2a9462de4352 ("btrfs: convert to ctime accessor functions")

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

diff --cc fs/btrfs/inode.c
index 06c9ad527458,db7e1a19bb67..000000000000
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@@ -5558,12 -5757,9 +5555,11 @@@ static struct inode *new_simple_dir(str
  	inode->i_opflags &=3D ~IOP_XATTR;
  	inode->i_fop =3D &simple_dir_operations;
  	inode->i_mode =3D S_IFDIR | S_IRUGO | S_IWUSR | S_IXUGO;
- 	inode->i_mtime =3D current_time(inode);
+ 	inode->i_mtime =3D inode_set_ctime_current(inode);
 -	inode->i_atime =3D inode->i_mtime;
 +	inode->i_atime =3D dir->i_atime;
- 	inode->i_ctime =3D dir->i_ctime;
  	BTRFS_I(inode)->i_otime =3D inode->i_mtime;
 +	inode->i_uid =3D dir->i_uid;
 +	inode->i_gid =3D dir->i_gid;
 =20
  	return inode;
  }

--Sig_/17NS/+R44cg_uOmnaNkxqKg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTa0tcACgkQAVBC80lX
0GwjnAf9HVwwo5/mv17n1defcUdM5w6/67Gihy813d0IndlCe0jA2oCWR5oB3bZk
dIxZhd3FzfszOrfxIrskJLIZVA7t1T7thZF8TlU4LYAgFPv61ZQAgH3w5Wt9lrmZ
AiPwWD2Vt8aCMKocdJXTfd+4wZzJ06sAODLKwWL85Oj//t582S7uMzQ4eXjNND62
PjHuNkUdqDGgFh4I/kSfG4V/nRts6Q6ZUd33kiVv9Dqao+ZM9jXfMnSlkN+udbXu
9IcPLdfiDUB8vDM7F0ewnVTJ/FplbCTEODKP62rbqJbztAyIDPiWeQxBUMxIw6my
oi8A8LGjCIx1CQ7dfVoffX6AvNsmww==
=TrXf
-----END PGP SIGNATURE-----

--Sig_/17NS/+R44cg_uOmnaNkxqKg--
