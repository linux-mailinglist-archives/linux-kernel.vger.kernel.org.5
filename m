Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD4C77EE36
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 02:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347306AbjHQAYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 20:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347304AbjHQAXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 20:23:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50B7E2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 17:23:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A98D60EB9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB708C433C7;
        Thu, 17 Aug 2023 00:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692231814;
        bh=i7nrr4LyNIuY6UOB1gyYO/oyeK14L+tqSi5nyUZLaJo=;
        h=Date:To:Cc:From:Subject:From;
        b=RzsNQo19+bm0GRyfBuqtiXeXio96PcsYC0fgx2RdCxUqK62phC4BUW9AynlF5OpgP
         mPpUI4k7qD3FjCNL+Ha2r0NUEFifKlaM4irNx5DApCIcQohj/CgmZI6q4/LsjaFzlz
         7MvNA/pLVEN5ObqDLriM/tTt9H2SzZC2VZVKKnjj/7jIfLuPIg5945oCGUhBE+kOWj
         q2KEaVauN13bXsvM2N8cfPMc23+g/bbeuw8QYCiXo7lorpU/YORy5d/g6kMtrt4FTz
         rxCeeOa5/NBY1pi3rMyJ9rdQRyZLN84GcwTqL6JTfjd9IWllWOTttoBMUzsZ5OW0Ep
         y5cYjKq+tKtug==
Message-ID: <74e8cf91-d095-33e3-c548-34d80b691089@kernel.org>
Date:   Thu, 17 Aug 2023 02:23:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Alejandro Colomar <alx@kernel.org>
Subject: struct_size() using sizeof() vs offsetof()
Organization: Linux
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------VU0FwU6spAIyu0nWfnOfeY3f"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------VU0FwU6spAIyu0nWfnOfeY3f
Content-Type: multipart/mixed; boundary="------------pJ2rRR0wEjT504gyeJcuzxuO";
 protected-headers="v1"
From: Alejandro Colomar <alx@kernel.org>
To: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Message-ID: <74e8cf91-d095-33e3-c548-34d80b691089@kernel.org>
Subject: struct_size() using sizeof() vs offsetof()

--------------pJ2rRR0wEjT504gyeJcuzxuO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Kees, Gustavo,

I've been discussing with a friend about the appropriateness of sizeof()
vs offsetof() for calculating the size of a structure with a flexible
array member (FAM).

After reading Jens Gustedt's blog post about it[1], we tried some tests,
and we got some interesting results that discouraged me from using sizeof=
().
See below.

But then, said friend pointed to me that the kernel uses sizeof() in
struct_size(), and we wondered why you would have chosen it.  It's safe
as long as you _know_ that there's no padding, or that the alignment of
the FAM is as large as the padding (which you probably know in the kernel=
),
but it seems safer to use

	MAX(sizeof(s), offsetof(s, fam) + sizeof_member(s, fam) * count)

The thing is, if there's any trailing padding in the struct, the FAM may
overlap the padding, and the calculation with sizeof() will waste a few
bytes, and if misused to get the location of the FAM, the problem will be=

bigger, as you'll get a wrong location.

So, I just wanted to pry what and especially why the kernel chose to pref=
er
a simple sizeof().

Cheers,
Alex

---

$ cat off.c=20
#include <err.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


struct s {
	int   i;
	char  c;
	char  fam[];
};


static inline void *xmalloc(size_t size);


int
main(void)
{
	char      *p;
	struct s  *s;

	printf("sizeof: %zu\n", sizeof(struct s));
	printf("offsetof: %zu\n", offsetof(struct s, fam));

	puts("\nWith sizeof():");

	s =3D xmalloc(sizeof(struct s) + sizeof("Hello, sizeof!"));
	strcpy(s->fam, "Hello, sizeof!");
	p =3D (char *) s + sizeof(struct s);
	puts(p);
	free(s);

	puts("\nWith offsetof(3):");

	s =3D xmalloc(offsetof(struct s, fam) + sizeof("Hello, offsetof!"));
	strcpy(s->fam, "Hello, offsetof!");
	p =3D (char *) s + offsetof(struct s, fam);
	puts(p);
	free(s);

	exit(EXIT_SUCCESS);
}


static inline void *
xmalloc(size_t size)
{
	void  *p;

	p =3D malloc(size);
	if (p =3D=3D NULL)
		err(EXIT_FAILURE, "malloc");
	return p;
}


$ ./a.out=20
sizeof: 8
offsetof: 5

With sizeof():
lo, sizeof!

With offsetof(3):
Hello, offsetof!


[1]: <https://gustedt.wordpress.com/2011/03/14/flexible-array-member/>
--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------pJ2rRR0wEjT504gyeJcuzxuO--

--------------VU0FwU6spAIyu0nWfnOfeY3f
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmTdaHkACgkQnowa+77/
2zJGGA/9G/J109UYm+1rCxpEvwEgLUA4kLiJ8GKPZfQOxk/fyzgAPx2pm3eAk/Lh
M+F+I7zrtGFKZXJkmFIPETTiRDBEHSynyC+K1tGn4l3ZO4d0ymAhwBVLUmKwH7hv
AyOYOWL1VC8ITyXlg579/SF7nBiTne5VRWvwIArVDZB5+LvMT71wNz/iU4Q9x2GH
wsUbpHLt9BhRo6O32qAAQUDnc8Vi92TT8HKOvYqptmMBeWZ/ETxQHCGkvjFbriwg
8KkQuyq1ooubXuRMfUHc4xDrNJtm63E+D9pLtAL9rtOMoiUrmB2GyJAkGzlNBQAy
MW27IEJo/2rG+Cjaqm7gRwCe4bOmfqx2VlZyWXcbGi+0FXnFCT3POoijatmdVB5V
c4PrKCgM3Is0cTduAK2+KyLoMNGUw5sZLr8s1qk4+yDU1smoGzUm4Vc7WtS4epxS
Z0M6KszGdzuNbjKru+tdGA5jfmCZO+eYxPeXtcBvGMlkqsPApXHNsEopcmWI14Ff
KxDDnk8MOcD+cn6EoGFjeZlWAZV9ij8URQujGnIAKEO/dvITJiMc/uLLe7iYCTnt
iVZYufqGJWyE+cpO2PzEJ5itutagza6Gc/jWqu+oaOnnC47Mfbha+/dTCdrOEr7M
jHv/px5BErBANcAiECeKQQ6XQd+X593eIVBsaN1jbY/UbF1EN74=
=FXMK
-----END PGP SIGNATURE-----

--------------VU0FwU6spAIyu0nWfnOfeY3f--
