Return-Path: <linux-kernel+bounces-100768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BE9879CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1BA1C217AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33455142916;
	Tue, 12 Mar 2024 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="RGkPoje2"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34387382;
	Tue, 12 Mar 2024 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710275735; cv=none; b=A4uXq468gHnkdoZmYc7XsavQjRVs8vNvAlfQ94b6U1ZPe2ed4iKEwECyNZNmLFV3gUgW+3cNykReLRHtwDAEBgaDCIrbi5nh0fs2WDrpESNnAbtmCubwut1v76T2uBQcIXn81Veh1CgqwSVomsWeu97na1MZ0XHweSJeumeUtt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710275735; c=relaxed/simple;
	bh=fKgQaaspTGFzvzo/bz2ErnQPBXcO9olZD3j4RL0bxrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=No6XCiSV1GgLYwxcaYg+uP88K+KbrjfqWJhW20/nKndtUj/k1UwgOjd3tZ0xIlgYCSvynCh4a4RNvUDa04AY+wSL2ACX+hhu1rVB50xr1mVfJth5l6+wAy3slWanpnE2aNhtHQTWWxSHzvvAVUrLflkI5K/GfzIfp5TknD8QxKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=RGkPoje2; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 86FA21C006B; Tue, 12 Mar 2024 21:35:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1710275727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HNuaGq7efeL3zZ9PVtEBZwNZ/Oitr+2+cYKedn9BI08=;
	b=RGkPoje2O9DvNxoRXqyhz2QrfHvoTo4F2wbq1D0c00Rxfs7+2wzX0NXy5xMAPRQ7q18tIS
	Q8VtuVD4dPyr4NkThpGAgxg3/qK3nR/7+UMW90isqjTK9pVRieuCzTE41zilKwAKFxYJsT
	u0u2J16bXexO2KSbsCkVJ2gnYMVY/Kw=
Date: Tue, 12 Mar 2024 21:35:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, sthemmin@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, x86@kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	devel@linuxdriverproject.org
Subject: Re: [PATCH AUTOSEL 6.1 3/7] x86/hyperv: Use slow_virt_to_phys() in
 page transition hypervisor callback
Message-ID: <ZfC8j2eUP/139bSh@duo.ucw.cz>
References: <20240311183826.328535-1-sashal@kernel.org>
 <20240311183826.328535-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hdxVmSkgdoQeUsAT"
Content-Disposition: inline
In-Reply-To: <20240311183826.328535-3-sashal@kernel.org>


--hdxVmSkgdoQeUsAT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> In preparation for temporarily marking pages not present during a
> transition between encrypted and decrypted, use slow_virt_to_phys()
> in the hypervisor callback. As long as the PFN is correct,

This seems to be preparation for something we don't plan to do in
-stable. Please drop.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--hdxVmSkgdoQeUsAT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZfC8jwAKCRAw5/Bqldv6
8koDAJ9q8exh6UyNP6LQHyZQLDOy6tr8IwCfbTuTK6Fh951cIruZfOENraPzaa8=
=Q6XM
-----END PGP SIGNATURE-----

--hdxVmSkgdoQeUsAT--

