Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A914801C7B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 12:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjLBLpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 06:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBLpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 06:45:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1108911F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 03:45:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E878C433C9;
        Sat,  2 Dec 2023 11:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701517548;
        bh=uSCwJobsv7eeFCBU3RQEyIImjUxRbMNqeubbtgPE2UY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2aZ+tpYZc1B+VffwLZP5uR8wuY2wfDyB0dgPW19VJ08pMMcJVaJ778Yw9lntR0mG
         YIIdnB09hIBjnOp6oJGZ5fLAdKO/+ePBmoNjkjsUVxx0nbemTqNisiNhxwfjH05pNZ
         UUndxqxuMNmJbewMA/talTn+nliBmu6EykAaV8nLdGrUmLni/Z6cvnbz//953qDdYo
         Z6T1aluqOJ8HWIdIvQR86Cpx1LYoH9gd29h06f7ToxDmGG4P1sVJ5WNYxHfsY6SWHL
         gtGHw1dliNhYygnX8O4J9ZjX2TwwMztBTfwNeNNds2hFeiN4eC/Ua9V0Vn4NAG+HSy
         OiEIEp6wU/rTQ==
Date:   Sat, 2 Dec 2023 11:45:44 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question about BUILTIN_DTB support in RISCV
Message-ID: <20231202-paparazzi-thievish-744c40e351be@spud>
References: <CAK7LNATt_56mO2Le4v4EnPnAfd3gC8S_Sm5-GCsfa=qXy=8Lrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Gwwjm7FWxQD2puPb"
Content-Disposition: inline
In-Reply-To: <CAK7LNATt_56mO2Le4v4EnPnAfd3gC8S_Sm5-GCsfa=qXy=8Lrg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Gwwjm7FWxQD2puPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2023 at 03:45:00AM +0900, Masahiro Yamada wrote:
> Hi.
>=20
> I have a question about CONFIG_BUILTIN_DTB for riscv.
>=20
> Please see this commit history.
>=20
>=20
> [1]
> 2d2682512f0faf4d09a696184bf3c0bb6838baca
> added built-in DTB support, attempting
> to include multiple DTB into vmlinux
> by using SOC_BUILTIN_DTB_DECLARE() macro.
>=20
>=20
> [2]
> d5805af9fe9ffe4a9d975e9bc39496f57a161076
> pointed out that choosing the correct DTB
> is impossible. It fell back to the single
> built-in DTB support, like other architectures.
>=20
> [3]
> 0ddd7eaffa644baa78e247bbd220ab7195b1eed6
> added BUILTIN_DTB support for sifive and microchip,
> while apparently multiple DTBs are embedded into vmlinux.

The thread for this one is interesting:
https://lore.kernel.org/all/20210604120639.1447869-1-alex@ghiti.fr/

None of the other !canaan platforms actually support this, so it is only
for PolarFire and the SiFive boards that this is enabled. It sounds,
=66rom your comments below, that this does not even work. If it doesn't, I
would be inclined to just delete it.

If XIP is the user, we want to deprecate XIP anyway, so pointing out
that this has not worked properly in a long time for PolarFire and
?ever? for the SiFive unmatched is another nail in the coffin for that.

My vote would be for reverting [3] and removing support for XIP :)

> So, how does it work?
>=20
>=20
> With
> CONFIG_ARCH_MICROCHIP_POLARFIRE=3Dy
> CONFIG_ARCH_SIFIVE=3Dy
> CONFIG_BUILTIN_DTB=3Dy
>=20
> 7 DTB files are embedded in vmlinux.
>=20
>=20
> masahiro@zoe:~/ref/linux(master)$ riscv64-linux-gnu-nm -n vmlinux |
> grep -A15 dtb_start
> ffffffff82112620 D __dtb_start
> ffffffff82115a2c D __dtb_mpfs_icicle_kit_end
> ffffffff82115a40 D __dtb_mpfs_m100pfsevp_begin
> ffffffff82118b3b D __dtb_mpfs_m100pfsevp_end
> ffffffff82118b40 D __dtb_mpfs_polarberry_begin
> ffffffff8211b9c2 D __dtb_mpfs_polarberry_end
> ffffffff8211b9e0 D __dtb_mpfs_sev_kit_begin
> ffffffff8211e7bb D __dtb_mpfs_sev_kit_end
> ffffffff8211e7c0 D __dtb_mpfs_tysom_m_begin
> ffffffff8212162e D __dtb_mpfs_tysom_m_end
> ffffffff82121640 D __dtb_hifive_unleashed_a00_begin
> ffffffff821236af D __dtb_hifive_unleashed_a00_end
> ffffffff821236c0 D __dtb_hifive_unmatched_a00_begin
> ffffffff8212621b D __dtb_hifive_unmatched_a00_end
> ffffffff82126220 D __dtb_end
>=20
>=20
> In my understanding, the first one
> (mpfs-icicle-kit.dtb) is always used.
>=20
> You cannot use the other 6 DTBs.
> Am I missing something?

Alex? I gave a cursory test and it does in fact behave like this.


--Gwwjm7FWxQD2puPb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWsY6AAKCRB4tDGHoIJi
0qL1AP42NadeFiz5c/wdHAp3pzYsORuTAsof8ogQqSkVyoDWogEAqwXZrryKGWID
GqGD5DMLBVzIH6oEvhsmFPSmg1sgvAs=
=HWh1
-----END PGP SIGNATURE-----

--Gwwjm7FWxQD2puPb--
