Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DD07B7444
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 00:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjJCWvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 18:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjJCWvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 18:51:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAABCAB;
        Tue,  3 Oct 2023 15:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696373469;
        bh=AbHgkLw6pkAiF+hp9Xi3YUuEXjip/NWdn8JZOZ7S79A=;
        h=Date:From:To:Cc:Subject:From;
        b=RQVGhtncQsHbkRYyOeNG7HA1jL3oHK91Fzsr2oNx1Y31Kz+1loHVwqhFo2qnGaG44
         JE2oO5uXtcI+A5lhntVof3XtSX1occzDuPxGo4lVh38ujhj5Z1DSRncWChQw+3IOak
         +x5TGjWB3+o1Ayz0OY+Vj0NoQnTKTpjEQBjKdp0nHLh3Kntn3tQpSRhLwovMKL6fjs
         1b5BZEGEVeh9j/pWq2kliCdD/RKTJVqgbAK2Y9YmB1Xx+7AeE8bZkvIsvqrt8Rj6Fw
         k3rogAHqOpKCvmSDT6n1vpmLL/UdtZmVv0wPWhqU/voEgWwAhridMTB8I61cOpHjL+
         D7gRgMY6wEpWA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S0Y2j2nZhz4xPQ;
        Wed,  4 Oct 2023 09:51:09 +1100 (AEDT)
Date:   Wed, 4 Oct 2023 09:50:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Laight <david.laight@aculab.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20231004095058.392f8c17@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=rjFqCZOmRnTDUB+/7gW/nM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=rjFqCZOmRnTDUB+/7gW/nM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (native perf) failed
like this:

In file included from tools/include/linux/bits.h:21,
                 from tools/include/linux/bitops.h:14,
                 from tools/include/linux/bitmap.h:6,
                 from tools/perf/util/header.h:10,
                 from /home/sfr/next/perf/pmu-events/pmu-events.c:3:
tools/include/linux/find.h: In function 'find_next_bit':
tools/include/linux/bits.h:24:17: error: implicit declaration of function '=
__is_constexpr' [-Werror=3Dimplicit-function-declaration]
   24 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                 ^~~~~~~~~~~~~~
tools/include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_=
BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); }=
)))
      |                                                              ^
tools/include/linux/bits.h:37:10: note: in expansion of macro 'GENMASK_INPU=
T_CHECK'
   37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
tools/include/linux/find.h:42:31: note: in expansion of macro 'GENMASK'
   42 |                 val =3D *addr & GENMASK(size - 1, offset);
      |                               ^~~~~~~
tools/include/linux/bits.h:23:28: error: first argument to '__builtin_choos=
e_expr' not a constant
   23 |         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
      |                            ^~~~~~~~~~~~~~~~~~~~~
tools/include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_=
BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); }=
)))
      |                                                              ^
tools/include/linux/bits.h:37:10: note: in expansion of macro 'GENMASK_INPU=
T_CHECK'
   37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
tools/include/linux/find.h:42:31: note: in expansion of macro 'GENMASK'
   42 |                 val =3D *addr & GENMASK(size - 1, offset);
      |                               ^~~~~~~

... and much more ...

Caused by commit

  5bee02eadb5d ("compiler.h: move __is_constexpr() to compiler.h")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/=rjFqCZOmRnTDUB+/7gW/nM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUcmtIACgkQAVBC80lX
0GwIfQf/ZcE4yCqcXlK7iSUd+e/AKBGHTndJVn0kbSt5780085FlkP0I8xbsf/Sg
kKtzs7GoAnDvBpjq/oDBvyKvM66u3MU0XuI9ZI4qLb5fThj4xNeIZq50FzlAXy24
HeiGl1KU6MLakWItd5TlCmfsBmtuhSZJHYBgPLCTQZoL+Rv921CN+K6vuALfrk+z
bqpnRc5sOhllKMeIYTJ74OWxwEQUElnG8aoWTz06JcSWckqkbI8Mj3as0f/jTYJv
fbc8zZvjJCp4P4H7yAIascSHmkH0DzYZAk3DGEG8qUPr1fW4agSF2AMSrvZledjZ
oEpHaH+sKP4vwWxJ2bsbE75sNPcMig==
=bz8g
-----END PGP SIGNATURE-----

--Sig_/=rjFqCZOmRnTDUB+/7gW/nM--
