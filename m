Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF49C7C7C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 06:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjJMEO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 00:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMEO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 00:14:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA28B7;
        Thu, 12 Oct 2023 21:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697170461;
        bh=1oFR+4gMmVQ/M+j9VgpveDoSgWVkgbUXWAgYUu4d9rc=;
        h=Date:From:To:Cc:Subject:From;
        b=M/jaYbHQAbU9sUCMkeRV6dpKLBdvHz0/BIeycrxoAazPS7dh4JoHt3TIytRdIv8oG
         DyfZEwQigN8aRBFCe+4KO8jDbns+Dx/T8tyskqMllGErFwCbmmvjLjgbaOG0zVf84w
         Trzrh8BiJYfaev91+/GF1wq9/8t7MZ2hzxoGshRk3hzIw2yiuHTUMP8Lk147FUOtup
         UQSa89ieNZGdNEgY0tRgXWwtC3MLSJSY5IR+9GQQJeSXUE3WJuANJOpB3SM66i+FVZ
         1/65Xnx+MVCz8dAPblyvzJgHDpdtuUGZ+dn/NgAhEm0bQLX+9EXmJr1mR0/USBHilm
         WzzAOeVgSv2OA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S6CnS58pxz4xWZ;
        Fri, 13 Oct 2023 15:14:20 +1100 (AEDT)
Date:   Fri, 13 Oct 2023 15:14:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the gpio-brgl tree
Message-ID: <20231013151417.052aa2f5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cYl5uXWI44CaUaLuPVU.Lzk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cYl5uXWI44CaUaLuPVU.Lzk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the gpio-brgl tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/hte/hte-tegra194.c: In function 'tegra_hte_line_xlate':
drivers/hte/hte-tegra194.c:424:48: error: implicit declaration of function =
'gpio_device_get_base'; did you mean 'gpio_device_get_desc'? [-Werror=3Dimp=
licit-function-declaration]
  424 |                 line_id =3D desc->attr.line_id - gpio_device_get_ba=
se(gs->gdev);
      |                                                ^~~~~~~~~~~~~~~~~~~~
      |                                                gpio_device_get_desc
drivers/hte/hte-tegra194.c: In function 'tegra_hte_match_from_linedata':
drivers/hte/hte-tegra194.c:652:33: error: implicit declaration of function =
'gpiod_to_device'; did you mean 'gpio_to_desc'? [-Werror=3Dimplicit-functio=
n-declaration]
  652 |                                 gpiod_to_device(hdesc->attr.line_da=
ta);
      |                                 ^~~~~~~~~~~~~~~
      |                                 gpio_to_desc
drivers/hte/hte-tegra194.c:652:33: error: initialization of 'struct gpio_de=
vice *' from 'int' makes pointer from integer without a cast [-Werror=3Dint=
-conversion]
cc1: all warnings being treated as errors

Caused by commit

  ebee532ff34b ("hte: tegra194: don't access struct gpio_chip")

(Exposed by commit

  63137bee5a7a ("hte: allow building modules with COMPILE_TEST enabled")

from the hte tree.)

I have used the gpio-brgl tree from next-20231012 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/cYl5uXWI44CaUaLuPVU.Lzk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUoxBkACgkQAVBC80lX
0GyKlwgAiX9A0+jXo6BdW2jft0CiuqtmO+1uXdjFaiG41xhTsFRUgHBBP0RW4oxE
aNcONpBhZO6ZqwHdbNTYEr2a2xOCWflC4l2mHvmqj6iPwv6t85KUwRb0ClmIvaTe
I52kQWuLjMVErc8QTqmEkX+gvchNs+qi5NXIUuq4t0ffr/D8s1Z+J4MIYJsO8WLy
cuPc6+peszBxBmyNnHZlVp5otiqZt35jedhTP232MzavlmZRQuYavYDQW/aVPpcV
RrPO16L8Jc4Ag82X4k/gKjE0EA4IsKH8CIa/1q4lBmsw7dLUrqasoWp7Ur8EJntt
UfIGwnB81TkqLyBXCrKrn87fTClHbA==
=g/xu
-----END PGP SIGNATURE-----

--Sig_/cYl5uXWI44CaUaLuPVU.Lzk--
