Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F57477D721
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 02:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240840AbjHPAid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 20:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240831AbjHPAiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 20:38:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935B5BF;
        Tue, 15 Aug 2023 17:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692146277;
        bh=rosYWlrI4t8faM1fS957HJl/UNmmlb1l7OR8EeMZW24=;
        h=Date:From:To:Cc:Subject:From;
        b=Vv+64eFWO4zKY0uvcFyF0dpfMVO6vG6OVQ3u5fy4g5897tNVJlygkniN2fJzwO+fa
         6Lf5jiWzSgNj9SGsD+UlVrN2fODZ9oN086h3MXAWQ5Dofs1uLZaRx0/ZUkQ0CqbY0q
         ybIZD/zn5F/R/gDZz+cQ2by0Asd8CZVrOvSPJMZSK3356Ngk5wV+7Q/VKsRQHgJDg7
         NffUoD2GHzYp8UpPZfm1rEbszm2waZYIruyroEySohwoK7yk6NrGonJ7/B+Ajo6Uw9
         xLHMsyN3wQGLoH09KQU3ZPD42dHdqh2R3ujs+jXE+z6xQjsCt21Fte/lqSlU+feZqo
         0e+jAc77jY9qA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQTkX249Bz4wxN;
        Wed, 16 Aug 2023 10:37:55 +1000 (AEST)
Date:   Wed, 16 Aug 2023 10:37:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jan Kara <jack@suse.cz>
Cc:     Georg Ottinger <g.ottinger@gmx.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the ext3 tree
Message-ID: <20230816103751.13f217a8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2aLrO901fVUIKWWqFTtcN/5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2aLrO901fVUIKWWqFTtcN/5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the ext3 tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/kernel.h:30,
                 from arch/x86/include/asm/percpu.h:27,
                 from arch/x86/include/asm/preempt.h:6,
                 from include/linux/preempt.h:79,
                 from include/linux/spinlock.h:56,
                 from include/linux/wait.h:9,
                 from include/linux/wait_bit.h:8,
                 from include/linux/fs.h:6,
                 from include/linux/highmem.h:5,
                 from include/linux/bvec.h:10,
                 from include/linux/blk_types.h:10,
                 from include/linux/buffer_head.h:12,
                 from fs/ext2/xattr.c:57:
fs/ext2/xattr.c: In function 'ext2_xattr_set2':
fs/ext2/xattr.c:748:42: error: format '%d' expects argument of type 'int', =
but argument 2 has type 'ext2_fsblk_t' {aka 'long unsigned int'} [-Werror=
=3Dformat=3D]
  748 |                         ea_idebug(inode, "creating block %d", block=
);
      |                                          ^~~~~~~~~~~~~~~~~~~  ~~~~~
      |                                                               |
      |                                                               ext2_=
fsblk_t {aka long unsigned int}
include/linux/printk.h:427:25: note: in definition of macro 'printk_index_w=
rap'
  427 |                 _p_func(_fmt, ##__VA_ARGS__);                      =
     \
      |                         ^~~~
include/linux/printk.h:129:17: note: in expansion of macro 'printk'
  129 |                 printk(fmt, ##__VA_ARGS__);             \
      |                 ^~~~~~
fs/ext2/xattr.c:88:33: note: in expansion of macro 'no_printk'
   88 | # define ea_idebug(inode, f...) no_printk(f)
      |                                 ^~~~~~~~~
fs/ext2/xattr.c:748:25: note: in expansion of macro 'ea_idebug'
  748 |                         ea_idebug(inode, "creating block %d", block=
);
      |                         ^~~~~~~~~
fs/ext2/xattr.c:748:59: note: format string is defined here
  748 |                         ea_idebug(inode, "creating block %d", block=
);
      |                                                          ~^
      |                                                           |
      |                                                           int
      |                                                          %ld

Caused by commit

  38e38567c5bd ("ext2: fix datatype of block number in ext2_xattr_set2()")

I have used the ext3 tree from next-20230815 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/2aLrO901fVUIKWWqFTtcN/5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTcGl8ACgkQAVBC80lX
0Gxc2gf/SvEty4U6GCMjGxljcgLN3o7dIZf6R7sYQzL2Lk7FGGFHdEkYdDUPXWfE
cD3tSC4hKDl1QBQGbvm4cy2fU7ZtafpCg+YuQdlBpmzMtKPDsGTTnDv4ZhEZGwx1
RtGQpVX3xcF5ApeXbpZ0ARrOvn3ixOlw9ke2+qRLsZA/S3/G7C9MnwmNMZrOOUeG
8e4tT1IX2qbwiPZc9IFdFzqdiTLgwJ4KNOZDybtqpYTfC/jBFbt68wcfJa7TwzxX
ip/7mcJnzX/CI8IlkHW10YOBbE0vuRcaZe6na3wRTmyX/khNaZTGpEo97cOAEwAo
v/7vzuqD6i8eXHURYWqrnLT8rUfJmg==
=9ZPO
-----END PGP SIGNATURE-----

--Sig_/2aLrO901fVUIKWWqFTtcN/5--
