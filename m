Return-Path: <linux-kernel+bounces-80300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E1E862D14
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3CE61F21A77
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03891B950;
	Sun, 25 Feb 2024 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JDGQ42iZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87394D2FE;
	Sun, 25 Feb 2024 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708895440; cv=none; b=V0CFP/6BneXsTQmJUuoBaGhJMfYtQBYLAVecKLLh0cXZgvSEfmDHAscH4alCETYjh2qI2PiJey6wCZhVqGeVu70LCLBVLo+lszwzSmH9hNBfXAN3j6RP5VRQdJ7YiPno1db6itCGWVfdoZ/ECznItrTxYZDdAfPWxsYDAImcis8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708895440; c=relaxed/simple;
	bh=ryofm9AyC66ppNGNCwpZaLes36i3wdGJU2nOHNj7U7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXTVCzXSNW7MgSsscDQIj5MrT/uOuDT5/Vevp5rv90beADV8elCsYISyskOVdrBDIOf27GWxJI0XJFglfQ9epuNMz9PKrV86V9zGxwiY+WJlwxyqRImXRSGdhC4GNxASHQvinuWH6WCW3Am26PqAKBDFxfkrJ4o0HM2q99+S51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JDGQ42iZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708895431;
	bh=ryofm9AyC66ppNGNCwpZaLes36i3wdGJU2nOHNj7U7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDGQ42iZF9z9zvzCL5m1pkvzT+1qD6P8H6wOv+VUegTaqiJq4+BizCI7MNmF1GsSS
	 lk7tCPFlXoJBF3jqlaWFAuaf+5kCXt48/g9XgbSgHE7f49N2aqEHjxvvs7gtum/mww
	 nFS1dZhs0jT+Y5ST8JOT5gmrvT5xUGboplqgkA6fdWTJ5mdbawfdbzTI3fIhT/6VCI
	 jZTgo26gWSsIeMlbbh4IBUPNjTzCmUvOEs/pgGKkqzIauAqhx0gcimWF/nVxL08ovT
	 mvjE9q4ojyNeIOp7zrIP/EY7VYn+V1I4jyi3ft2SZ13UW2yAO4PYiOy1MBCNQz2jIU
	 TL6jPJTJjEeIA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4A78C3781FD9;
	Sun, 25 Feb 2024 21:10:31 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id C300F1060D21; Sun, 25 Feb 2024 22:10:30 +0100 (CET)
Date: Sun, 25 Feb 2024 22:10:30 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Hermes Zhang <chenhuiz@axis.com>
Cc: Hermes Zhang <Hermes.Zhang@axis.com>, kernel@axis.com, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq27xxx: Introduce parameter to config
 cache regs
Message-ID: <op5ovg3cv4raqy4zmol7wfy7hm72ptgxleh2ykoyg5qvnbhfcl@pxfzkij5xkkw>
References: <20240219100541.48453-1-Hermes.Zhang@axis.com>
 <eh34cvorgnrw4v5a6emzjk2p6om2ybkn627bpmh775z4ubw63h@nbxgpm767u4x>
 <1fe2c4b3-9dd2-a961-4198-45aca3449c36@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aqiglmpeyh36bxal"
Content-Disposition: inline
In-Reply-To: <1fe2c4b3-9dd2-a961-4198-45aca3449c36@axis.com>


--aqiglmpeyh36bxal
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 23, 2024 at 04:40:18PM +0800, Hermes Zhang wrote:
> On 2024/2/22 7:03, Sebastian Reichel wrote:
> > On Mon, Feb 19, 2024 at 06:05:40PM +0800, Hermes Zhang wrote:
> > > Since all of the regs in the bq27xxx_reg_cache are now cached, a simp=
le
> > > property read (such as temperature) will need nine I2C transmissions.
> > > Introduce a new module parameter to enable the reg cache to be config=
ured,
> > > which decrease the amount of unnecessary I2C transmission and prevent=
ing
> > > the error -16 (EBUSY) happen when working on an I2C bus that is share=
d by
> > > many devices.
> > So the problem is not the caching, but the grouping. So instead
> > of adding this hack, please change the code to do the caching
> > per register. That way you can just keep the caching enabled and
> > don't need any custom module parameters.
>=20
> Thanks for the reply. Yes, the key is the grouping. So do you suggest to
> drop the bq27xxx_reg_cache struct totally and handle the cache for each
> register in e.g. bq27xxx_battery_get_property()? Then it will require an
> extra time info for each register, will that be a big cost? Or am I
> misunderstanding?

Yes, this requires time info for each cached register. I don't think
the added memory is a big deal. There usually is only a single
battery and we are caching 10 timestamps. So that's 80 bytes.

-- Sebastian

--aqiglmpeyh36bxal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXbrLkACgkQ2O7X88g7
+pocVA//Q3NWvrv9EnteHXjrW328s/R0Hdu1cPyVLAEt1j7UCWIMBwo38e5JuZuf
sEKkvFNDgGe+jJzVS2DRkvky8J+JvUZ4L0pgXdbGHPKhM/vIRjyD1RhJneIc6U3S
q3e7hUOSj0YrKBHO/GbDpyB77p1Uo23E+e7Fs9EWPEc9ZawvOqBxb6b9O29Dyf3x
ZbliWPS6JZ2cIZ7RFtUMHc8e1AItmluyHTHMxJz9d2gL1vPrUBT7gmD6PzZl/u1o
EI7c4DXDUUKb2Cvqh04pXMrVMU8z+u6SIhZExFtijs5VZjzn3BjREIo8Vj046shC
ggB2awWdekGzLw0qjiRlRicy2eP76lCKFfeDt1MGwLxDLExVi1vwQcxsjKBjNUfK
QzwZgIGQUc/zzKwhGagjh+oJebCqnUgd8K9S/226Z/m1oDona/Rt1aJios780UA4
NyeI7O2BgnpDzRoFJnqLduzFiXuW5KakLkRqwrQeb14HucMvWDxILGBmJPH+Y11W
ZHlBML5F2VYYxx7qgpgM/nYmKPM+g3uJXuGLlubdkV2rrwVcy4uB1kZNjhFJblCh
hn/0JNoSJtjnzmwYRvOEOAcuAHgDEyjaLkNs+LwDtrQkEeIcFI/+TU3vqdU+sFxJ
n0yEeuGxMdC3dk9nE6bAn9DJ7DrynifbW74RVxrtaWGlY5uCrus=
=e0sY
-----END PGP SIGNATURE-----

--aqiglmpeyh36bxal--

