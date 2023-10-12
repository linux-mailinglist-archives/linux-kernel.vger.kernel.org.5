Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33EC7C705E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjJLOgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjJLOge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:36:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D0CB8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:36:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE7CC433C8;
        Thu, 12 Oct 2023 14:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697121392;
        bh=T66Yur/UCraUQwTSXUcC9RiZqqV3VvZWqiVESHrtPY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MJ5DfxWaahvAPHHHHX8MojtEbigSm7v6EfEav0C0orOwLfJvGkfovUPkb3tBVLvER
         zm+g9r6QTVMjW5xGGYYlu0NIpCokM+fNKVw9BNEzwXu10r0GAAX0xZ/sty+ynEU8dJ
         oliyneNUpyAFk5zQ5D8TC9X//2xfeODIMy1lRkCydqISyZ2zN8lI/VjVNO0Pe63dfC
         SFQHAoLqs0K3wUNqrdTVVXT2ArrRSMb1MYbwWGknaIe2lGaWhj1t+HsGjAfs5bfAQl
         LewTlVrie9IFA9HjWbE44DRVu8U3mFjAxD81uMaYlzPMatHpCUXDtt8Ywj1kLbEzlr
         zEw0F/UQElxjg==
Date:   Thu, 12 Oct 2023 15:36:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] riscv: errata: thead: use riscv_nonstd_cache_ops
 for CMO
Message-ID: <20231012-remindful-coke-f9cfe950425f@spud>
References: <20231012141456.4078-1-jszhang@kernel.org>
 <ZSgA1BtMv/YDHzQX@xhacker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yhohIoGoNmGJsGcL"
Content-Disposition: inline
In-Reply-To: <ZSgA1BtMv/YDHzQX@xhacker>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yhohIoGoNmGJsGcL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 10:21:08PM +0800, Jisheng Zhang wrote:
> On Thu, Oct 12, 2023 at 10:14:54PM +0800, Jisheng Zhang wrote:
> > Previously, we use alternative mechanism to dynamically patch
> > the CMO operations for THEAD C906/C910 during boot for performance
> > reason. But as pointed out by Arnd, "there is already a significant
> > cost in accessing the invalidated cache lines afterwards, which is
> > likely going to be much higher than the cost of an indirect branch".
> > And indeed, there's no performance difference with GMAC and EMMC per
> > my test on Sipeed Lichee Pi 4A board.
> >=20
> > Use riscv_nonstd_cache_ops for THEAD C906/C910 CMO to simplify
> > the alternative code, and to acchieve Arnd's goal -- "I think
> > moving the THEAD ops at the same level as all nonstandard operations
> > makes sense, but I'd still leave CMO as an explicit fast path that
> > avoids the indirect branch. This seems like the right thing to do both
> > for readability and for platforms on which the indirect branch has a
> > noticeable overhead."
> >=20
> > To make bisect easy, I use two patches here: patch1 does the conversion
> > which just mimics current CMO behavior via. riscv_nonstd_cache_ops, I
> > assume no functionalities changes. patch2 uses T-HEAD PA based CMO
> > instructions so that we don't need to covert PA to VA.
> >=20
> > Hi Guo,
> >=20
> > I didn't use wback_inv for wback as you suggested during v1 reviewing,
> > this can be left as future optimizations.
> >=20
> > Thanks
> >=20
> > since v2:
> >   - collect Reviewed-by tag
>=20
> Oh, I missed the tag collection, but I know maintainers are using b4 whic=
h can
> collect and apply tags automatically ;). let me know if want a new
> version.

It doesn't collect tags (AFAIU) from earlier revisions though.

--yhohIoGoNmGJsGcL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSgEbAAKCRB4tDGHoIJi
0gDdAQDIEazfsbs4xfx2jNJUKGvwicJmPcJtkhPLURqghLYUgQEAwors/NUj/QyD
gd4wjd0Dg12NVYmAeaWwZ3XzoNOXYQw=
=/MRc
-----END PGP SIGNATURE-----

--yhohIoGoNmGJsGcL--
