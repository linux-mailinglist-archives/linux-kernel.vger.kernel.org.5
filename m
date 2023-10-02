Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099FE7B53B2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbjJBNLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbjJBNLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:11:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF87693
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 06:11:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44544C433C7;
        Mon,  2 Oct 2023 13:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696252282;
        bh=NJY7DZhSmTcXGEORtrXsTz9AsMnIx8Ld5dQpPWVHHTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sUTDN8IBbyw1yGoDkuRrJf8V7yv33vpjVPwhVtN96T0/3voKKRl92Efejo5nx9Obq
         Mhzh8cxEm3qkUmuIAXET4FUe9yL4If0fr3oH0AC2zUrSofinreoEMz+aXwfLy3WfR/
         dkFQx0tdhfhT/0kP0f3btwDIHQX95EBkVd3qxpZgMyWV8O9dDHwW4i1mGSIXYsR0m6
         1X/q+0vaNKU5p5rjX4g8ztaPwusQk0PY/mNL6+bF0zFzfLrqTrhJA/dWnOtnKqr1BS
         A0fXosGkGhnfSSCh9XcsEeKNt3RttXgb8q3Rbla+paFW2V74XBmJ3T8CpyaULQhn0r
         RJbSkBobKD8GQ==
Date:   Mon, 2 Oct 2023 14:11:17 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes 2/2] riscv: Fix set_huge_pte_at() for NAPOT
 mappings when a swap entry is set
Message-ID: <20231002-unending-ether-1b9f73eb642c@spud>
References: <20230928151846.8229-1-alexghiti@rivosinc.com>
 <20230928151846.8229-3-alexghiti@rivosinc.com>
 <20230930-unnoticed-slacked-0bf5696cc265@spud>
 <96984fd2-2e3b-d861-5555-5b5a4e5c55d6@ghiti.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wAGaI66Xrr9VnCv2"
Content-Disposition: inline
In-Reply-To: <96984fd2-2e3b-d861-5555-5b5a4e5c55d6@ghiti.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wAGaI66Xrr9VnCv2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2023 at 09:18:52AM +0200, Alexandre Ghiti wrote:
> Hi Conor,
>=20
> On 30/09/2023 11:14, Conor Dooley wrote:
> > On Thu, Sep 28, 2023 at 05:18:46PM +0200, Alexandre Ghiti wrote:
> > > We used to determine the number of page table entries to set for a NA=
POT
> > > hugepage by using the pte value which actually fails when the pte to =
set is
> > > a swap entry.
> > >=20
> > > So take advantage of a recent fix for arm64 reported in [1] which
> > > introduces the size of the mapping as an argument of set_huge_pte_at(=
): we
> > > can then use this size to compute the number of page table entries to=
 set
> > > for a NAPOT region.
> > >=20
> > > Fixes: 82a1a1f3bfb6 ("riscv: mm: support Svnapot in hugetlb page")
> > > Reported-by: Ryan Roberts <ryan.roberts@arm.com>
> > > Closes: https://lore.kernel.org/linux-arm-kernel/20230922115804.20437=
71-1-ryan.roberts@arm.com/ [1]
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

> > Breaks the build. Your $subject marks this for -fixes, but this will not
> > build there, as it relies on content that's not yet in that branch.
> > AFAICT, you're going to have to resend this with akpm on CC, as the
> > dependency is in his tree...
>=20
>=20
> I see, but I still don't understand why -fixes does not point to the late=
st
> rcX instead of staying on rc1?

It's up to Palmer what he does with his fixes branch, but two thoughts.
Doing what you suggest would require rebasing things not yet sent to Linus
every week and fast-forwarding when PRs are actually merged.
IIRC, Palmer used to do something like the latter, but IIRC he got some
complaints about that and switched to the current method.
At the very least, you should point out dependencies like this, as I
figure an individual patch could be applied on top of -rc4 and merged
in. Both Palmer and I have submitted things for b4 to improve support for
doing things exactly like this ;)

> The patch which this series depends on just made it to rc4.

However, if you do not mention what the deps for your patches are
explicitly, how are people supposed to know? The reference to the
dependency makes it look like a report for a similar problem that also
applies to riscv, not a pre-requisite for the patch.

Thanks,
Conor.

--wAGaI66Xrr9VnCv2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRrBdQAKCRB4tDGHoIJi
0ogrAQDVtpLukDHQPeeMY8fXo2JQPSwQj/fZN5+cBLUGdPsfNQEAjVH9QNHTm+QI
5G/qgyYuZHGA027PSue0EO8EO8ZEWws=
=JpKR
-----END PGP SIGNATURE-----

--wAGaI66Xrr9VnCv2--
