Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A04A7B5F54
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 05:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjJCD1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 23:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjJCD1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 23:27:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3CFAC;
        Mon,  2 Oct 2023 20:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696303660;
        bh=9jBALLCJQUpTVDnjs3fG9TETbp9kJUD4A4UhiLF7nlk=;
        h=Date:From:To:Cc:Subject:From;
        b=X7D5miWOQcajjcR7+Kgtm/J8s5Tk+6gLjVCxGSKDyFKjIRDQLz0MvjRwDKiicda+T
         oFcf87aBwrP3jOBP63L+VfD5JOkglaneDBy4UnsoK50G0esaCViE5ygGUYGL9LVcjj
         bwiuknUfiTaFXoL0s/HIhIofwEpf2DWJTmMgnsdqEk9p3qHh2ui676kZKLBT0R6Xsv
         wKVUvpVDhLoWrg5cRkFeW8cVV/AZe0acvJ6PNMyQLNdt0RMLPCHtQUbyyOcAOxxVvq
         6hSVQRXGUqbTmmzCYxiPqabilfK2lGZHC2t28a8V95t8GaHofzXVph2P29+cJ2efrk
         pRfqxnsgQa/JA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S03DC4zgjz4xF2;
        Tue,  3 Oct 2023 14:27:39 +1100 (AEDT)
Date:   Tue, 3 Oct 2023 14:27:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the landlock tree
Message-ID: <20231003142737.381e7dcb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+2JkPNoUxWlzyuFRjaGDngN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+2JkPNoUxWlzyuFRjaGDngN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the landlock tree, today's linux-next build (powerpc
allyesconfig) produced this warning:

samples/landlock/sandboxer.c: In function 'populate_ruleset_net':
samples/landlock/sandboxer.c:170:78: warning: format '%llu' expects argumen=
t of type 'long long unsigned int', but argument 3 has type '__u64' {aka 'l=
ong unsigned int'} [-Wformat=3D]
  170 |                                 "Failed to update the ruleset with =
port \"%llu\": %s\n",
      |                                                                    =
       ~~~^
      |                                                                    =
          |
      |                                                                    =
          long long unsigned int
      |                                                                    =
       %lu
  171 |                                 net_port.port, strerror(errno));
      |                                 ~~~~~~~~~~~~~                      =
          =20
      |                                         |
      |                                         __u64 {aka long unsigned in=
t}

Introduced by commit

  24889e7a2079 ("samples/landlock: Add network demo")

--=20
Cheers,
Stephen Rothwell

--Sig_/+2JkPNoUxWlzyuFRjaGDngN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUbiikACgkQAVBC80lX
0Gwi6wgAgxs6FtVG9oAK3kXK93O/I/d3D2auPqTiYwQisGVhyvv+RUrCqfemwC6u
KezRA36zDxEqUSyEuTLE/+OgeyB/SnlLboXAr/sP8z6cQNJ7W9CqqITg9yFxH3j9
tVH89ULCQkCiKahyCIODLisBFEIEYjUDzMpY01sI78ayZ4MClckZLcjc3F0zUQ6U
duCx900QY2V3Yd7jmd8R2Zz0CLZEhNKL+hnZqXIRoyCoavtA02mNFpBuqvSdBskn
omcMx69ricZ3wINeIA0ze+8EkHuvQtlGinXHUGu5F7yJ0AFZvI3RMSiOLk+pnTow
/CDCSGLw5TKMdtGdeRGkERrEKj58Ug==
=mb9C
-----END PGP SIGNATURE-----

--Sig_/+2JkPNoUxWlzyuFRjaGDngN--
