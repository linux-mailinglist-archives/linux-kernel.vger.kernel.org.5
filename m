Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFF27E92F6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 23:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjKLWax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 17:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjKLWaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 17:30:52 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717AA1FFD;
        Sun, 12 Nov 2023 14:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699828248;
        bh=TEKCVcg3cJ1+ginSwn8P5SzwHvCjrGK+U4hEwLtiSYo=;
        h=Date:From:To:Cc:Subject:From;
        b=C4yDZ/w6W6kr+BNTaCx1P+ps0DEvuzhQsspv+uH71kEM99Ij+YP0QfKoXm6AQn46l
         tqzmXpPSouAoH6NDTntDxkzQoEyMKPMv8BlPqSMckHSwB+Y2uRaPaksEbPgDkSajyb
         koKpOI8TPigRDiNpJj1yECNaVhVvsx++pT7uTggpC2nVrMiu3HyV6hODLXy2pBpZA0
         YHsR/fBS5/aBAU80a4zTo/A/zEf8K0asS/ojgBS13rB0T/tjTVF6xZsvwvjm6Tcqed
         tBtmTu/f8o5EGsm86qLN45Na5shJfMnLVI8GX9w2M7bn+v1DGVzlwMiAT40+ECjvQO
         IxEJOc0alwqlw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4ST6hm1Bycz4wc0;
        Mon, 13 Nov 2023 09:30:48 +1100 (AEDT)
Date:   Mon, 13 Nov 2023 09:30:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bcachefs tree
Message-ID: <20231113093046.7b79407e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tBdII.3REG410ivn1=cbV.Q";
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

--Sig_/tBdII.3REG410ivn1=cbV.Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bcachefs tree, today's linux-next build (x86_64
allmodconfig) failed like this:

fs/bcachefs/inode.c: In function 'may_delete_deleted_inode':
fs/bcachefs/inode.c:1129:43: error: 'BTREE_INSERT_NOFAIL' undeclared (first=
 use in this function)
 1129 |                                           BTREE_INSERT_NOFAIL|
      |                                           ^~~~~~~~~~~~~~~~~~~
fs/bcachefs/inode.c:1129:43: note: each undeclared identifier is reported o=
nly once for each function it appears in
fs/bcachefs/inode.c:1130:43: error: 'BTREE_INSERT_LAZY_RW' undeclared (firs=
t use in this function)
 1130 |                                           BTREE_INSERT_LAZY_RW);
      |                                           ^~~~~~~~~~~~~~~~~~~~

Caused by commit

  4b8cc695db52 ("bcachefs: Rename BTREE_INSERT flags")

interacting with commit

  897d32dffe59 ("bcachefs: Fix missing transaction commit")

I have used the bcachefs tree from next-20231110 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/tBdII.3REG410ivn1=cbV.Q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVRUhYACgkQAVBC80lX
0GzfGAf8CIvTCvC2L3B2nDPVB6IjjKp70mV2/cJVaoRyc/FB3n7k+rXa11CPsXFg
f09Pm88oM7qDa6JY0deIs5miy/Qj/w1JYCh7OH9T3EmplKex5iG1s2BJPcWny0YD
jrzdWu7TNBGge2lWMqdl6Eg2Z7rBURScb94KBBifCwvOPe3wYqvtXLhCwvw+40U9
S1rYsOj4FDV4fFrmnHmfyGnyWhj/YfdL6si8Ki83+F9Bh13z+Vrght2GeI7JVX+g
2BwvHtFC0A8odrXnWKi7WwJw+URejGI792rFI9v4k9FpBh8guhhlqzOxn04FKxyf
SjFjmqeCtmUjBJy3Bez3GK4gsW8G+A==
=lbzs
-----END PGP SIGNATURE-----

--Sig_/tBdII.3REG410ivn1=cbV.Q--
