Return-Path: <linux-kernel+bounces-151741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E05E8AB340
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2894282EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEFD1311A6;
	Fri, 19 Apr 2024 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=zougloub.eu header.i=@zougloub.eu header.b="y67Q1dJB"
Received: from zougloub.eu (zougloub.eu [69.70.16.42])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AF17641E;
	Fri, 19 Apr 2024 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.70.16.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543621; cv=none; b=AILgUCNUZhfRv8GEfR8DVWwz+ZYw+eHV0AKEZQBf3BQuQH74onkWBTo3+yCGsMbWGsvTc7si9LA+Zry49XrglOT9Ns8cgolpYOTo5qzQc3eM4/T9ow5Oq6gAHQhQ/g5m71Xu8qj+XUmxG8wz2PqvGWmgsSAl096wSkPTUIXI66w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543621; c=relaxed/simple;
	bh=UpPZloFIN+EDzPILAIZUv9E9HrCLhkTFGeBFj/OWjQU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PRR8gPdkpKzHs1fBF80UkZlvzLvX0j3n+g8cr8H/yhFgmqqjM6TeGajPaSSZAgJ7aLSQJrZjO4OWguM4ok9GHk84sLQzlHJOnAftKrBBzl5h1owbQD62ELyY+9AdQlvSk6vLlxZd9kEf2Cul9pmvj7HQdZYMdg2bzb2+n+JL4mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zougloub.eu; spf=pass smtp.mailfrom=zougloub.eu; dkim=pass (1024-bit key) header.d=zougloub.eu header.i=@zougloub.eu header.b=y67Q1dJB; arc=none smtp.client-ip=69.70.16.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zougloub.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zougloub.eu
Received: from pouet.cJ (exmakhina.com [69.70.16.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by zougloub.eu (Postfix) with ESMTPSA id CBA1528897D4;
	Fri, 19 Apr 2024 12:20:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zougloub.eu;
	s=zougloub.eu; t=1713543610;
	bh=UpPZloFIN+EDzPILAIZUv9E9HrCLhkTFGeBFj/OWjQU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=y67Q1dJBvrokiYdDyODvyMLhEDr367dDWfZW+7Sux2SfWeKzsJSRm89+akzwMfC8M
	 oA/4GRM+onXHs37rHAnbyt2SY59gyatex36NMtX/LQ3ZPoCb7mcyAg309Wzc4pqUPX
	 LAOlQArlm2iUhP/fAFtrSqOkoUSj6fv7AKHCKa/4=
Message-ID: <2259bbeb9a012548779e3bf09a393fdb7d62dd0c.camel@zougloub.eu>
Subject: Re: [Intel-wired-lan] [BUG] e1000e, scheduling while atomic (stable)
From: =?ISO-8859-1?Q?J=E9r=F4me?= Carretero <cJ-ko@zougloub.eu>
To: Sasha Neftin <sasha.neftin@intel.com>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 19 Apr 2024 12:20:05 -0400
In-Reply-To: <dff8729b-3ab6-4b54-a3b0-60fabf031d62@intel.com>
References: <a7eb665c74b5efb5140e6979759ed243072cb24a.camel@zougloub.eu>
	 <dff8729b-3ab6-4b54-a3b0-60fabf031d62@intel.com>
Autocrypt: addr=cJ@zougloub.eu; prefer-encrypt=mutual;
 keydata=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
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-gYqkxgZjrxXupy8tcWSb"
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-gYqkxgZjrxXupy8tcWSb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sasha,


Thank you, sorry for the delay but I coudln't reboot.

Adding Greg KH because I don't know if stable will receive my e-mail
(not subscribed) but the regression was integrated in stable:
 commit 0a4e3c2d976aa4dd38951afd6267f74ef3fade0e
so they should get the fix ASAP too.


Tested-by: J=C3=A9r=C3=B4me Carretero <cJ-ko@zougloub.eu>


Best regards,

--=20
J=C3=A9r=C3=B4me

On Thu, 2024-04-18 at 06:44 +0300, Sasha Neftin wrote:
> On 17/04/2024 21:46, J=C3=A9r=C3=B4me Carretero wrote:
> > Hi,
> >=20
> >=20
> > I opened https://bugzilla.kernel.org/show_bug.cgi?id=3D218740=C2=A0beca=
use
> > I'm
> > not quite sure the culprit is e1000e or some timer stuff.
>=20
> Hello J=C3=A9r=C3=B4me,
>=20
> You hit on regression introduced by 6dbdd4de0362 (used the wrong
> timer=20
> during code running in atomic contexts)
> Please, incorporate=20
> https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20240417190320=
3159360-1-vitaly.lifshits@intel.com/
> =C2=A0
> in your latest kernel.
>=20
> Thanks,
> sasha
>=20
> >=20
> > I just verified that this happens on the latest master.
> >=20
> >=20
> > Let me know if I can (quickly) help,
> >=20
> >=20
>=20


--=-gYqkxgZjrxXupy8tcWSb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJDBAABCAAtFiEEk5TkdsnFh9XvC+SieNwb2r75s3MFAmYimbUPHGNqQHpvdWds
b3ViLmV1AAoJEHjcG9q++bNzcCMQAKqyRQOHDJvtAUvu+YSDVlrb9Er/jl/Hwna7
qd9goaHuxJi+ycuhQKHENq66kIjKMhiL16Ky4ujCqFvacSj/HxQr9BIEYmMnsFVE
wCkF1dJRgyMZaalBqIMCF5hh/NSjc216+/CvvSxwVqU0fEuxq6AuClLocYFqz57l
QwBIJuueZ5JhsDWXaG9EK1CQpwvIvs0yGKQEivaEc79PYcBUP/lDhhilbRMq0TyY
e/3mTgu/cF5MF45mpd4aeXskRMR80nxAnVElHTV0JiW0NSmaP2Cbyw8sI7T1zmbV
XajVS1byKnY6ZQM9eWFX71WkbsdGn60uJPLCSdld5mr/XKUkTHCYNL/6PSoOT+uk
VGqPb22iVx3Nzgd6vKwjmXZNatKz4p1WQrNFRjjZeJBYGnqMEuxdMqGdvUWqUG67
IV/XHhw7zVHXMlSJAWVIsfHudpivfTaC2hkl1R0JHqX7R9kuQ2YSvIG551ILE1Z9
vbs1HvPt6DeuHSMy1s58T7jilFYymzuAX3Mn2adHNlrob3rqpw68EPDjND/4tuLt
teLNPPuo1MbHjYdbV9TeyIKAhSpldH8T1+auHBEFutWKLK4vWQhEPae32f26fYAD
ED4rSmHxDmTuuHlJqtRLPa/wnGAB0Jc426BtrEnoQd9jiQBDnQqoprJ1LvJwP1I3
4NCEJk35
=ZYut
-----END PGP SIGNATURE-----

--=-gYqkxgZjrxXupy8tcWSb--

