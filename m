Return-Path: <linux-kernel+bounces-28262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AB882FC3D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8662C28EE86
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B927424B31;
	Tue, 16 Jan 2024 20:43:14 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5786C1D695;
	Tue, 16 Jan 2024 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437794; cv=none; b=Dw8Np/jfAs2OSiyFxXv/oApTiOLHzXguvwb1juR6ABawdLoztZeg7SJOKXbhLHBeviIlW9aC/ZiQVNRKujtAJWGTxZ4YxjZleNd21C0EfJNC8Kas+JosXiW4lrDM+08p9SWokksrH9ka+nUydD/fHH8mAAmePe2LP/VgIccdq1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437794; c=relaxed/simple;
	bh=sZJXPXcvlS/jVke7bDGNZMdYz3tnl4Zho2n6I37BIZU=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=MBj75tkeDS+wc7ClU/DxYq5HjoiAOIbuzsUm/PGCj2fuBZu5ITIHWBjGmzaN302Y1mSvipLSloGvS5NeJIwiVHkrLWBo1CrtpG9cIiVETojtnUPPrgHvUMBG0o+yOzpImSQwz94XYXk0CjxseTuiWx3mOVG0+G4PNAuV+dljKCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 16AF71C0071; Tue, 16 Jan 2024 21:43:10 +0100 (CET)
Date: Tue, 16 Jan 2024 21:43:09 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Christian Brauner <brauner@kernel.org>, zack.rusin@broadcom.com,
	mcgrof@kernel.org, pstanner@redhat.com, nick.alcock@oracle.com,
	code@siddh.me, ddiss@suse.de
Subject: Re: [PATCH AUTOSEL 5.10 01/10] watch_queue: fix kcalloc() arguments
 order
Message-ID: <ZabqXRf4X7wUgeqL@duo.ucw.cz>
References: <20240115232818.210010-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ynXok9RdLEYysjzt"
Content-Disposition: inline
In-Reply-To: <20240115232818.210010-1-sashal@kernel.org>


--ynXok9RdLEYysjzt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Dmitry Antipov <dmantipov@yandex.ru>
>=20
> [ Upstream commit 1bfc466b13cf6652ba227c282c27a30ffede69a5 ]
>=20
> When compiling with gcc version 14.0.0 20231220 (experimental)
> and W=3D1, I've noticed the following warning:
>=20
> kernel/watch_queue.c: In function 'watch_queue_set_size':
> kernel/watch_queue.c:273:32: warning: 'kcalloc' sizes specified with 'siz=
eof'
> in the earlier argument and not in the later argument [-Wcalloc-transpose=
d-args]
>   273 |         pages =3D kcalloc(sizeof(struct page *), nr_pages, GFP_KE=
RNEL);
>       |                                ^~~~~~
>=20
> Since 'n' and 'size' arguments of 'kcalloc()' are multiplied to
> calculate the final size, their actual order doesn't affect the
> result and so this is not a bug. But it's still worth to fix it.

Not a bugfix, please drop.

BR,
									Pavel
									--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ynXok9RdLEYysjzt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZabqXQAKCRAw5/Bqldv6
8sy4AJ48W6k2JPWpiIdoOOSsvyaGuUWJhwCdFtc8G45hj7QvRwAdO840zEPPBOA=
=ZAQg
-----END PGP SIGNATURE-----

--ynXok9RdLEYysjzt--

