Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB79775A382
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 02:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjGTAfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 20:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTAfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 20:35:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E741A8;
        Wed, 19 Jul 2023 17:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689813341;
        bh=yVMVY4ZGVwKTCGyvtEewwCuRBTwtpUmcyBtB3yTy3pU=;
        h=Date:From:To:Cc:Subject:From;
        b=KRG05TnypiyYSuNIh2a6t75Z22TVHSxpO4F23xpq+cSbJNUWmupWzV1OWS16nmwZf
         n7gOZQhvXquiIgVFKn5X+mGcSKGyXLfRhy5UeA4KiugkTH5dw+vLopjv9SCvaVH5j8
         h/Jwwbj2M7vlhsA2qf8NqT5LMD6YC1KOqHQhleUH2AfR8eWQ8aPup2xLxdtnPN5g7d
         BVAXKgLYfO4gjM2MKU5ZZHp31zAZdkjSejewuLZC1dGBHVOYSwpoyVC+CvDbM+VGgK
         MuefqdGMqlVUCJR9KhZSCjLrLsVf2zhp8Ej6b0yUhCUIBtl0mzuTE0vNCVFXlGeCcT
         IPQXYmqz+ECrw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R5tyP47YWz4wxx;
        Thu, 20 Jul 2023 10:35:41 +1000 (AEST)
Date:   Thu, 20 Jul 2023 10:35:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Winston Wen <wentao@uniontech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org
Subject: linux-next: build failure after merge of the cifs tree
Message-ID: <20230720103540.0436273d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SNLc3YH5=1GospBWQy3z/qr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SNLc3YH5=1GospBWQy3z/qr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the cifs tree, today's linux-next build (x86_64
allmodconfig) failed like this:

fs/smb/client/connect.c: In function 'cifs_get_smb_ses':
fs/smb/client/connect.c:2293:49: error: passing argument 1 of 'load_nls' di=
scards 'const' qualifier from pointer target type [-Werror=3Ddiscarded-qual=
ifiers]
 2293 |         ses->local_nls =3D load_nls(ctx->local_nls->charset);
      |                                   ~~~~~~~~~~~~~~^~~~~~~~~
In file included from fs/smb/client/cifsproto.h:10,
                 from fs/smb/client/connect.c:37:
include/linux/nls.h:50:35: note: expected 'char *' but argument is of type =
'const char *'
   50 | extern struct nls_table *load_nls(char *);
      |                                   ^~~~~~

Caused by commit

  46055407cd4a ("cifs: fix charset issue in reconnection")

I have used the cifs tree from next-20230719 for today.

It looks as though the parameter to load_nls could be made const safely
as it is just passed to try_then_request_module() passes it to
__request_module() which just passes it to vsnprintf() to construct the
module name.  There does not appear to be any maintainer for fs/nls ...
--=20
Cheers,
Stephen Rothwell

--Sig_/SNLc3YH5=1GospBWQy3z/qr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS4gVwACgkQAVBC80lX
0Gy/8ggAoUGb9kyA06ycG74jKmmoNg9T4v+DDRjTyycfFIKih/2MxKXu2VJucbLJ
WYiawBAi8eFUGNLwkYv/bczyT1fjGsN1w7bz48NDiesjgY/rZy8igqZRKCHanpxc
RWCd6R+hvFRJlZZJ2akPqZdjatNzcluRodxiTDcFJ3fFtqmy+dpZHwcuaJXqmuvw
lOtghx7+zlL6POxVkRxbDuV+VdOAxHblSbjp65Nud8lzjZaLOWJhlCjpw0DtWUpv
x6YxApKzH7ua20roGBHef39hxy/9KQUr6pdckMp2YUUGFw2VIxomfrWiRQ+DJ2+C
0CPNnq9jsapNYODYVX8eBjz6o6Xm6g==
=pYt/
-----END PGP SIGNATURE-----

--Sig_/SNLc3YH5=1GospBWQy3z/qr--
