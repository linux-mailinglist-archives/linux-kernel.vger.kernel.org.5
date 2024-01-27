Return-Path: <linux-kernel+bounces-40961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7497C83E8FC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4EC1F28201
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321A39455;
	Sat, 27 Jan 2024 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VkpAWpeP"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECACC8F40;
	Sat, 27 Jan 2024 01:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706319146; cv=none; b=egm5Z+i11EqJKEuxjlritJ1uDKFww/KHPRSXV1QiH5t/bScErhLtSL5sLtSchqcFIR2G/uyjskWlN5wNvkLsAf02cHZ2SbAjdmxSHjPfJpi+5AI0bKo2Zv2KizKp5VSjBR6OuSukD2NFRgYt18k2DhsJADCx+qkz0LMtk4Iro5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706319146; c=relaxed/simple;
	bh=+NLWTLWEimvQy+Vf8ru0xO3+WRiqVvMJUQuTrXgjY7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vgbs1RFXH58swqUgPEvX1TRv1ojoY2EXMaGG/aNC75fLscpKePnQIl8nmjFdutRhViIOz76dfzPL2h6ADlx5ZgIUI3SVfyM4rWSWJG38b1Xq55Uc8kT9Ffwe50bYQLLptWGoQjHl4uBANXvqb+44azOa9CZMfjTxlVJtBK0RG5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VkpAWpeP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706319143;
	bh=+NLWTLWEimvQy+Vf8ru0xO3+WRiqVvMJUQuTrXgjY7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VkpAWpePpJ8q3GgK424//fqkI2GKVZrNWP83gmqvt4/LfWLoiA8cq20J5HwZUR/55
	 r8YW3MqulC7ry5rnloMkNbcmRkkU485CnCg8RKL5H6ExwodbotBgAMuWbUlQQuCtyB
	 ahiqOV+jzfdl7NqrZlkU59bJV1/OTIvASBoBBIG4nWbvEZi3MweOgae9JTgHQJdKHv
	 0HKHhODI7hBaXIwN1PQqn7WfOcMopnYxzqLd9M2cliTT3oy1x3CXOMUHqxwAlVhYbm
	 BT/9bSpmvi0/DdXCvKMbnQxNb6BGXqlPWb41pxDOzye2/EeQjCbFXfcw2zOl9EMqLL
	 0ZbdhvrZef5vw==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 098FD37811D4;
	Sat, 27 Jan 2024 01:32:23 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 50FC3106A754; Sat, 27 Jan 2024 02:32:22 +0100 (CET)
Date: Sat, 27 Jan 2024 02:32:22 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Andrew Davis <afd@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/5] power: supply: bq27xxx: Switch to a simpler
 IDA interface
Message-ID: <espkk27v22oedaarobneijy2njhp5zzqwo2d2eiskezlezklsw@qmsnac2xyp2u>
References: <20240123150914.308510-1-afd@ti.com>
 <170631648751.848730.15797573817520426864.b4-ty@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jjoze5d5h732pmeu"
Content-Disposition: inline
In-Reply-To: <170631648751.848730.15797573817520426864.b4-ty@collabora.com>


--jjoze5d5h732pmeu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jan 27, 2024 at 01:48:07AM +0100, Sebastian Reichel wrote:
> On Tue, 23 Jan 2024 09:09:10 -0600, Andrew Davis wrote:
> > We don't need to specify any ranges when allocating IDs so we can switch
> > to ida_alloc() and ida_free() instead of the ida_simple_ counterparts.
>=20
> Applied, thanks!
>=20
> [5/5] power: supply: bq27xxx: Move one time design full read out of poll
>       commit: b282c30dad3e10738a4f03043efaff93d9e8de02

FWIW, I queued all 5 patches.

-- Sebastian

--jjoze5d5h732pmeu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmW0XPsACgkQ2O7X88g7
+pqv4BAAjohiakLeTVFs/ZAL3cHTUQf4qt3y6enLrNBslCMkpi0tHkS5QiqpG+td
PNJAVsDtHAd3tdph/LvKouyM0SWYuktvngNIuOM89qWY53Pi4DNo0C2mB0j8Gzgj
6Ej25Jj1WPnnDaD6HdUULqc1izmtD11wkHnIIxBAougR6af8tBxkempdW8oh4b1V
esJL2uK9GbG4FdnUrQbhW/GMDgRA9wTwmfnAj9LWxJ0xUcDJ3kM17eUKa1HuudFg
Alv0NoVlkEHYM9E8SirxhoGSSIZDbgC2yqXjb6tHm6Ms6Z5GLupoGhTY1hEyt/sT
EHOlwml4SLDkq4tOCo8fKceDzV4E6lBFQFJn/dg/cLhu77Er+dC8WFbrhCdthcbu
vyd4iuaDGg18b0nG8umW0xPWJjnyyJ3UyZHN80ed6s7p7aSV/iqYSpMb6FkBJ7ns
dRRyYBz6ToLG4a6+cgmx2wDzs2C9AJyLInG+tu+R7l0sBctuUTyBszSO7XPjunAS
MqLpE1W8n8qpBcb5Hs/w1TREAXEiCy4m8v7K3MzZ/p6rVczS8BRHrKnXaIkGmoUm
8ut/iDqh8JJDYS87s3NF8MxyJE/0p/UyjAQKbpU5+r57Hz0csPTKhCc4hqbz/cuw
DGn/igMvfPPIW2VCPaNU6HL9t2h50mbLHWzNzjyzFc0lXP+0bos=
=jzRx
-----END PGP SIGNATURE-----

--jjoze5d5h732pmeu--

