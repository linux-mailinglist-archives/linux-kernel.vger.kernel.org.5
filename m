Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F5578E232
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245669AbjH3WRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbjH3WRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:17:11 -0400
X-Greylist: delayed 3495 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 15:16:45 PDT
Received: from bues.ch (bues.ch [80.190.117.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7E911F;
        Wed, 30 Aug 2023 15:16:45 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.96)
        (envelope-from <m@bues.ch>)
        id 1qbRx8-000JBj-2f;
        Wed, 30 Aug 2023 22:38:13 +0200
Date:   Wed, 30 Aug 2023 22:37:41 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Rand Deeb <deeb.rand@confident.ru>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, voskresenski.stanislav@confident.ru
Subject: Re: [PATCH] ssb-main: Fix division by zero in ssb_calc_clock_rate()
Message-ID: <20230830223741.7a4684d5@barney>
In-Reply-To: <4c6d01bf-1a0f-27de-54e1-4afdcf4bc8d5@lwfinger.net>
References: <20230830082759.23336-1-deeb.rand@confident.ru>
 <4c6d01bf-1a0f-27de-54e1-4afdcf4bc8d5@lwfinger.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ab++gLz=cpsDQxgilphpite";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ab++gLz=cpsDQxgilphpite
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Aug 2023 14:50:42 -0500
Larry Finger <Larry.Finger@lwfinger.net> wrote:

> I agree that clkfactor_f6_resolv() could return 0, but we have not
> been overrun with reports of divide by zero errors, which suggests
> that the branch is never taken. This patch will make your tool happy
> and is much simpler:
>=20
> diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
> index ab080cf26c9f..b9934b9c2d70 100644
> --- a/drivers/ssb/main.c
> +++ b/drivers/ssb/main.c
> @@ -837,7 +837,7 @@ static u32 clkfactor_f6_resolve(u32 v)
>          case SSB_CHIPCO_CLK_F6_7:
>                  return 7;
>          }
> -       return 0;
> +       return 1;
>   }

Yes, I agree that this is the much simpler and also more sensible
solution to this theoretical problem.

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/ab++gLz=cpsDQxgilphpite
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmTvqJUACgkQ9TK+HZCN
iw5B/w//c1XdA0n/Bi6a1M0ycUPnd/PHcZyveH9Mh/ILjmHJNQMhYP+GHPo995TM
zqwSA2r3z6K++DHCR1wTojX615ReD4bi77Um60a29VCa/JZGELJwewut5J+RhFAF
rAUWf7KGX6AFEGoN9CE1CH3ZwiItvWJ1R48JpLLXR7iERrdBpjGCq7agjfxWqIqR
iL4sqeujLa3uB78Wku/pJsVAY2b6613n35S7LfRS7B3hnFDb0uAzKSk7Bb+KANS/
TUK2+3fiZ3Ya80dpIYo+UM2s4QNnzcsOVQibPe9Zsixtsj6UPJ5PrcdUJU2i0ziy
TFNdMxRHrcew99z/jd7Mm04tLFNTBnda/0yBuSKav02802+zeSxyKFNYgC5o1zSz
Q1BN6Z57ADwbvuQndsL3QywNXyhy7HPL7dCkB8XKDgmmNi24y99leLTpsHU1PpI9
xC/OZk3bxuWJB72dhavAGOoWScFnK1XBFMpE+WFmpK2HU2oF1MKKH5Q2CXrmkTIJ
AF4xWloUzgXqH4BYyZQHKl6YiM8But026536sIHl9zVc4zjF79W13ec41wWQgFmE
7LewbUZJFx+8xa56MByZWazWKSPiTr7IvGXnA24FCN8XugLsMWw4eklCDmPK+SNh
TXtz0qxrxCvIoIYV0zqzlYCI01847mtR7fnHa5dALKhgE16//ds=
=bQTe
-----END PGP SIGNATURE-----

--Sig_/ab++gLz=cpsDQxgilphpite--
