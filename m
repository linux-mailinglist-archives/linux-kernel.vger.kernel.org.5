Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADD87D076C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 06:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjJTEtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 00:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjJTEtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 00:49:33 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B819B0;
        Thu, 19 Oct 2023 21:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697777363;
        bh=eXV2vEVpWVxI4+H9UAV6iZ7tSFAOG0kvRU3LLLlxz34=;
        h=Date:From:To:Cc:Subject:From;
        b=DGPe9EVZXZ5GwU5ztgsLN5IYkO4DAxn0UxU5s6EpKvX2ExULawAGqFxJ53M5muvRy
         FfLDw4Ej2QK/F0mq+q5UvxtC+W5pL+SNiWae3YMwgyR7DQ6Gn145f7+eXSeGZqr/r2
         58gZUSyx8uXQJ2RrAH9PGsgLhi6jO05SAhbmVlpwYqxlzpXGjTcFwszU2Z4cjzdLgO
         6zDLOq1APN28L6ef0WSClpVDk++ba3ObBywZVDM/ZIXyu1coGURvZMn2z+KC9O4LKR
         oZOUkrU24ePkNFaX3qWgptP/sutpkx0vDR4qCGlyktUarxH/5aDM3mR0a4RcJhAsLc
         oGIJWWDSqTMcw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SBXDg4TNnz4xF9;
        Fri, 20 Oct 2023 15:49:23 +1100 (AEDT)
Date:   Fri, 20 Oct 2023 15:49:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bitmap tree
Message-ID: <20231020154921.2988e5ba@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nkOYrQfrxkMDmuZTfPoaAPW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nkOYrQfrxkMDmuZTfPoaAPW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bitmap tree, today's linux-next build (native perf)
failed like this:

util/probe-finder.c: In function 'convert_variable_type':
util/probe-finder.c:336:51: error: format '%zd' expects argument of type 's=
igned size_t', but argument 6 has type 'int' [-Werror=3Dformat=3D]
  336 |                 ret =3D snprintf(buf, 16, "b%d@%d/%zd", bsize, boff=
s,
      |                                                 ~~^
      |                                                   |
      |                                                   long int
      |                                                 %d
cc1: all warnings being treated as errors

Caused by commit

  f14eba432b67 ("bitops: make BYTES_TO_BITS() treewide-available")

I have used the bitmap tree from next-20231018 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/nkOYrQfrxkMDmuZTfPoaAPW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUyBtEACgkQAVBC80lX
0Gzf8Af/btXlUth9HILv8gskd1aj0lLUbVdjw3BTszED5sKjEvJqXrfoI7CgcQ9+
f7mErFnZOCO8xw1bhtLAhVNrsBoEVd1FOd3AQNwmNIFQsVX3oNp5qy539t/rUBH8
hz2A/U5ZKtAv1u8WgKnDRCCeMVnop2BxTYeU1gl5RFMX9wC9IgXXVO+DKIyq8O/V
u0Byb5arMzibIXbe5IAo4ikTz0tX3os2LQSBNYaEQ4Wk9QYoW8RRfjuUPJLmpeCH
q1SGGw+o9NLy0MeUdpL/X2sFw7JRE9Nrtea/MSynwkyQ59tfBJjAlaw+1vOylApC
yxpDws/Ea7cVslO2DLYtzdjUY+1liQ==
=46/G
-----END PGP SIGNATURE-----

--Sig_/nkOYrQfrxkMDmuZTfPoaAPW--
