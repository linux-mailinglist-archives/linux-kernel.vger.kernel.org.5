Return-Path: <linux-kernel+bounces-94606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAC087420C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32798288F9A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A421B59E;
	Wed,  6 Mar 2024 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kZnBZUv7"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA13A1429B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 21:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709760886; cv=none; b=ajECru051q+tYaUKMqcOeB6xGPh1ih+caOSsvUXf59Aiq/oV8r2XpJsdaYnBhSZ33BfMDWTKspjZ+oRzS7XF2YQM1ZK/rhUPUzR40bypDmeiRWV2mdFl+68nI6Rz3KlvkCK/p6ippGzkt+/9DlnVQ1PPUMioZkRpnukFD10nuis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709760886; c=relaxed/simple;
	bh=VfP4PQ6CLQO2Gx1ykfJd2b0T4aya1Jb6oeEkNhDI5OY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNz1m9f1txpA2Vtg3q/6CKG4W/tT2p2p/r2Xxcj9IuiOV3LIGClmn5vfavD+c9X4TtC19s2pIuSwTdccrH72GiRG9CwappR6xRZelAgDi/KdqkX/ijXO+L7d9PD28GGUxzg87NljWuysNIQWoGxaeGjJKYolbP9vzYiZ4Fk1NJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=kZnBZUv7; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709760880;
	bh=vXx7/JmCH9QW+7mXHC7u2NKptyAP4I+/LVyLTHOKxQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kZnBZUv7seCuEMLDXYJIJ659rQLRmzBPRXiYFpQd6snY11Askz00l6XCmCIPAv3gA
	 OPjMFXZwGRbUxEx65XCMiUzKY1qApurG9rZE8Z55C8hqadOFagE84C7f2QW+4o7by5
	 /ogXbXq+Mpp4/4Ob0jfQAVwtsHd4+2U9R+8JXW5xVb/b2ID5L14q2dnxkMNRutrBP2
	 R6ijO2hpJyrQMxhRXtGtFaiIBHZiaFsstpLTzPXYTIdcxkD9idIb70VG/q22FX1AVt
	 tSIo6nUPO6qwHdvKQy5UcUdXeolOYZEEpcbs3thqf2ry831ui7s3VYBtDLCEDjv4ex
	 /ROm5tCMDJ6GQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tqm0v3jb5z4wc7;
	Thu,  7 Mar 2024 08:34:39 +1100 (AEDT)
Date: Thu, 7 Mar 2024 08:34:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thorsten Scherer
 <T.Scherer@eckelmann.de>, linux-kernel@vger.kernel.org, Pengutronix Kernel
 Team <kernel@pengutronix.de>, "Ricardo B. Marliere" <ricardo@marliere.net>
Subject: Re: siox patches for next development cycle [Re: [PATCH 0/4] siox:
 Move some complexity into the core]
Message-ID: <20240307083438.3cef23c5@canb.auug.org.au>
In-Reply-To: <vg5yex3wpnfeibgkwmi33yazdxdz2pbhn4w72mnffqm3qtvjf6@gv3syxj6gsk7>
References: <cover.1708328466.git.u.kleine-koenig@pengutronix.de>
	<lkgvr2t4wzw4jkfg523zcek6y2v5l7kj6onw77yffvvs7i2gfy@6ectsjpcg64t>
	<vg5yex3wpnfeibgkwmi33yazdxdz2pbhn4w72mnffqm3qtvjf6@gv3syxj6gsk7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kRCEx92IgB_FF=d7zFx1lWQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/kRCEx92IgB_FF=d7zFx1lWQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Wed, 6 Mar 2024 19:24:38 +0100 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pe=
ngutronix.de> wrote:
>
> On Tue, Feb 27, 2024 at 11:21:24AM +0100, Thorsten Scherer wrote:
> > On Mon, Feb 19, 2024 at 08:46:28AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > The series looks sensible.
> >=20
> > Acked-by: Thorsten Scherer <t.scherer@eckelmann.de>
> >=20
> > @gregkh: Would you please pick up Uwe's series as well? =20
>=20
> There are currently six patches for drivers/siox waiting to be applied.
> (Two by Ricardo and four by me.) Thorsten asked Greg to do so. Greg
> didn't pick these up yet though. So I collected them and put them to a
> branch at:
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git siox/=
for-next
>=20
> I'd like to get them in during the next development cycle.
>=20
> Greg, what is easiest for you? Are they still on your list of open
> patches and we (I) need just a bit more patience? Or should I send a PR
> to Linus when the merge window opens?
>=20
> Stephen: It would be nice to get this above branch into next, no matter
> if the patches make it in via Greg or me. Could you please add this
> branch to your list for next? If Greg will apply them, I'll empty this
> branch to not get duplicates.

Added from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--=20
Cheers,
Stephen Rothwell

--Sig_/kRCEx92IgB_FF=d7zFx1lWQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXo4W4ACgkQAVBC80lX
0GytDwf/Tvd1t4Lrr1ksGM7s2MpeL5yqrSXLDXgEY5/XcCk9VQLqhLqgpKEKwVMC
l/GyXbf21xxBofrXsHbnBQAnIRaOI/Ltuf4TVMvQOyEAqhQcjmc1jzxsHwfA7zM5
5Gy/VWT7I8KTywq0qDO4hkxjRrTMh8avd7E2Cz0883NMgFRK9P1wrQLUynWV3clo
eTMGAqiusNL9Ske5Up3KrrtLQvr6b7+8pA5xXCp8d5tyRK97u7plHGQB9ShjfnFw
h5IeXjrE66sqxKPgGEiW+nuJxK5+bzvKXtbKwDzGofEw1UAAD7xOmRSTA7YKqEpB
Cbvmfj0G+Z0scjS3B1HDipYGwTnSog==
=epjE
-----END PGP SIGNATURE-----

--Sig_/kRCEx92IgB_FF=d7zFx1lWQ--

