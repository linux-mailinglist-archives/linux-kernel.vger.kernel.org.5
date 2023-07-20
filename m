Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FAE75AF77
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjGTNPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjGTNPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:15:52 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABA7269A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:15:46 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qMTV8-0000mX-0X;
        Thu, 20 Jul 2023 09:15:26 -0400
Message-ID: <7dc943023c620bed4bf49710dbe6facaade203fa.camel@surriel.com>
Subject: Re: [PATCH] mm,memblock: reset memblock.reserved to system init
 state to  prevent UAF
From:   Rik van Riel <riel@surriel.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Date:   Thu, 20 Jul 2023 09:15:25 -0400
In-Reply-To: <20230720050047.GL1901145@kernel.org>
References: <20230719154137.732d8525@imladris.surriel.com>
         <20230720050047.GL1901145@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-z3EnKr3kBd390TWl4hRd"
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-z3EnKr3kBd390TWl4hRd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2023-07-20 at 08:00 +0300, Mike Rapoport wrote:
> Hi Ric,
>=20
> On Wed, Jul 19, 2023 at 03:41:37PM -0400, Rik van Riel wrote:
> > The memblock_discard function frees the memblock.reserved.regions
> > array, which is good.
> >=20
> > However, if a subsequent memblock_free (or memblock_phys_free)
> > comes
> > in later, from for example ima_free_kexec_buffer, that will result
> > in
> > a use after free bug in memblock_isolate_range.
>=20
> The use of memblock_phys_free() in ima_free_kexec_buffer() is
> entirely
> bogus and must be fixed. It should be memblock_free_late() there.
>=20
I'll send in a patch for that code, then. Thank you!

> > When running a kernel with CONFIG_KASAN enabled, this will cause a
> > kernel panic very early in boot. Without CONFIG_KASAN, there is
> > a chance that memblock_isolate_range might scribble on memory
> > that is now in use by somebody else.
> =C2=A0
> This can't happen because memblock_double_array() uses kmalloc() as
> soon as
> slab_is_available(), so this sentence is misleading.

memblock_discard() freed the array, but did not change
the pointer. That resulted in memblock_isolate_range()
following a stale pointer.

There was no call to memblock_double_array() in the
final call that crashed. I checked that by booting
with memblock=3Ddebug.

kind regards,

Rik van Riel
--=20
All Rights Reversed.

--=-z3EnKr3kBd390TWl4hRd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmS5M20ACgkQznnekoTE
3oOr6gf/YAHP9Wh62dvAwLIqvbxzi9A1JenT3vRtd9tw854rVZaUy4WalweHjQYO
dUDidfirkAnKDjjuywdNtrjy4sjvSJ6w8Be4WNPsMwiOEIKs3Xr+ooJcVJ5cqD96
Pypfa+AZRCAukqrmyId1I5uh42T+82oU5ZSh5wiEt5E5Dk5XhUoxEVPbhMi9oz2R
LTtrlnJDmHUOiic6BMIjaFRrtb6ahw2EHNwery0hSfjMoqM2pRthkTzT8jvlhEGX
58vxJ6+q1KKmsgrAQovpM0eaNb/xkZkRkt6IB3yawjFqbBGmxdJp2CY1zuXHaRvJ
ZFIUCtiS6/tpMpyp9dChoKcaCnbXXA==
=2UF1
-----END PGP SIGNATURE-----

--=-z3EnKr3kBd390TWl4hRd--
