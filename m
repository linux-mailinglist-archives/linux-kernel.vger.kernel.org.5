Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851F5752E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 02:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjGNACQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 20:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjGNACO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 20:02:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530D526B5;
        Thu, 13 Jul 2023 17:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689292927;
        bh=URHyxa1dMA7/Qw7JnFbPE53OJDOdmKw1KXbuFMFCY9g=;
        h=Date:From:To:Cc:Subject:From;
        b=Q8e19YGXirL8mmrQkucNwKDswj+9I4hbnZdTGOkyz0zdV3bfUPbLh6ERXpVVvEglw
         qMlaLFLxhFQM3ZZnj5UBnRX04irNfcZ3rorZShYWAxpXrR3eT4qZ9xM/aT63kRMsfF
         VwjbJbedvbDKGmw0cISq9BtqXpipMRYpR20OK3OhbxyHIpHMev6ZgypS4GlozQNHmW
         Zsjj4OxWJj31urjE+ul75YQ2VsihjeE7khLs7QaMjH16Xr6TRdaCPda76dGjBhP73O
         ssTvLqD9HuBwqcidXoZdNar7DCOh446WOpUBjhQKx/Bi3MzxkUS7jYMDzPMSdIB/GZ
         dZn5P8mO3G6HA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R2BVR1dm1z4wqZ;
        Fri, 14 Jul 2023 10:02:07 +1000 (AEST)
Date:   Fri, 14 Jul 2023 10:02:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Carlos Maiolino <cem@kernel.org>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lukas Czerner <lczerner@redhat.com>
Subject: linux-next: manual merge of the vfs-brauner tree with the mm tree
Message-ID: <20230714100205.35b99670@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/s3va2hQ=MJzQAXQ6E2ARP=t";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/s3va2hQ=MJzQAXQ6E2ARP=t
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs-brauner tree got a conflict in:

  include/linux/shmem_fs.h

between commit:

  1a93dd24f1be ("shmem: quota support")

from the mm tree and commit:

  ad9717ca487a ("shmem: stable directory offsets")

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

diff --cc include/linux/shmem_fs.h
index c0058f3bba70,a5454a80ab30..000000000000
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@@ -31,9 -27,7 +31,10 @@@ struct shmem_inode_info=20
  	atomic_t		stop_eviction;	/* hold when working on inode */
  	struct timespec64	i_crtime;	/* file creation time */
  	unsigned int		fsflags;	/* flags for FS_IOC_[SG]ETFLAGS */
 +#ifdef CONFIG_TMPFS_QUOTA
 +	struct dquot		*i_dquot[MAXQUOTAS];
 +#endif
+ 	struct offset_ctx	dir_offsets;	/* stable entry offsets */
  	struct inode		vfs_inode;
  };
 =20

--Sig_/s3va2hQ=MJzQAXQ6E2ARP=t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSwkH0ACgkQAVBC80lX
0GzDmAgAmEKcMLkzmU2Njc1u6mqPQ16MG6xBQb+F2F/x73dbrIsn5Ys7DAEJj0hH
OeEX3P7SUvmsKq20c/KAYc4+FTSOQmy4S70Ycb9H3EC7mjyjaw9qjFGY5UTzFE1A
fU0ktHKwBYr22xeFL/lueuNDz0P6q4Og3GzbXv+klgX4tdC3cNm154ZAh37iRVxk
uqazOFk2Q2gxJNPnRZBswrh1AqgSbpA4vN9n6S3TtwuSvq+FQMsmaDAll1VHddzJ
XhChSFZdzH3Z9fIVjNF2FssEFuNxQ/mEGvRdu05157DQnvHp5WVdM69CjMCLz6vV
/0wq+FiNLj6lbTL8UC7awVnE83Sljw==
=XDiy
-----END PGP SIGNATURE-----

--Sig_/s3va2hQ=MJzQAXQ6E2ARP=t--
