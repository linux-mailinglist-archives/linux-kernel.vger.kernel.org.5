Return-Path: <linux-kernel+bounces-126804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07CE893CE5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A8E283027
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDC846B9F;
	Mon,  1 Apr 2024 15:36:50 +0000 (UTC)
Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6324501C;
	Mon,  1 Apr 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711985810; cv=none; b=gRBoHAMRSppPND7vtpbIaneEUhLK51dposn1KRJ4MLMNhHBth3KGPLrpb7HrqiuZuBWMKKBM+AP5YaMn6ITRyafVJN1E+uTShjOXCTVhxB5MRLEjtOL/8qNBEERU4/i0KDt22JthRab30skQQcpu2WiW+un4dHAHfOnkOUw8M7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711985810; c=relaxed/simple;
	bh=4IkYm12Xm40qZ4Fx7s8GjYsSBQxNdQAXgH2rzdNq4sw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sq9OXk9HhAdw0/CvxN2/My5zO5MYx5opPuTt/L5NeduUVcYxhVPxra24P25/wJHKre0+lweM/fULtkECUHcXu5wpHak8/tu8kDXdmnWbTNv+srf9U8tVzQodX/tKjvQ8ieMEz+LAe/tRaX2YaQefYwvxYySTPXJSKqzt20Bi3QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inka.de; spf=pass smtp.mailfrom=inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inka.de
Received: from mail.berkhan-weisser.de ([2a03:4000:54:b9a::4])
	by mail.inka.de with esmtpsa 
	id 1rrJiE-00ArAD-30; Mon, 01 Apr 2024 17:36:42 +0200
Received: from 127.0.0.1 (helo=localhost.localdomain)
	by mail.berkhan-weisser.de with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <Enrik.Berkhan@inka.de>)
	id 1rrJiD-003wxe-30;
	Mon, 01 Apr 2024 17:36:41 +0200
Message-ID: <85837371eadac58dec812c0be14264152ee1e5fd.camel@inka.de>
Subject: Re: [PATCH 1/1] platform/x86/intel/hid: Don't wake on 5-button
 releases
From: Enrik Berkhan <Enrik.Berkhan@inka.de>
To: Linux regressions mailing list <regressions@lists.linux.dev>, David
 McFarland <corngood@gmail.com>, Chris Feng <chris.feng@mediatek.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alex Hung
 <alexhung@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>,  LKML
 <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
Date: Mon, 01 Apr 2024 17:36:35 +0200
In-Reply-To: <1198933e-bf89-4237-a6e8-f7daeeebf885@leemhuis.info>
References: <20240318191153.6978-1-corngood@gmail.com>
	 <20240318191153.6978-2-corngood@gmail.com>
	 <1198933e-bf89-4237-a6e8-f7daeeebf885@leemhuis.info>
Autocrypt: addr=Enrik.Berkhan@inka.de; prefer-encrypt=mutual;
 keydata=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
 Dh1pYX8125Sys26JeDfnh3bnI=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On Fri, 2024-03-29 at 14:51 +0100, Linux regression tracking (Thorsten
Leemhuis) wrote:
> [CCing Chris, who authored the culprit; also CCing the platform folks
> and a few lists]

(Intentionally replying to the "wrong" e-mail to get the enlarged
recipient list for free ...)

>=20

> Regarding the patch itself: hopefully this mail will get things
> moving.
>=20
> [1]
> https://lore.kernel.org/linux-pm/20240318191153.6978-1-corngood@gmail.com=
/
>=20
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker'
> hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>=20
> #regzbot poke
>=20
> > Signed-off-by: David McFarland <corngood@gmail.com>

Tested-by: Enrik Berkhan <Enrik.Berkhan@inka.de>

> > > ---
> > =C2=A0drivers/platform/x86/intel/hid.c | 8 +++++++-
> > =C2=A01 file changed, 7 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/platform/x86/intel/hid.c
> > b/drivers/platform/x86/intel/hid.c
> > index 7457ca2b27a6..707de9895965 100644
> > --- a/drivers/platform/x86/intel/hid.c
> > +++ b/drivers/platform/x86/intel/hid.c
> > @@ -504,6 +504,7 @@ static void notify_handler(acpi_handle handle,
> > u32 event, void *context)
> > =C2=A0	struct platform_device *device =3D context;
> > =C2=A0	struct intel_hid_priv *priv =3D dev_get_drvdata(&device-
> > >dev);
> > =C2=A0	unsigned long long ev_index;
> > +	struct key_entry *ke;
> > =C2=A0	int err;
> > =C2=A0
> > =C2=A0	/*
> > @@ -545,11 +546,16 @@ static void notify_handler(acpi_handle
> > handle, u32 event, void *context)
> > =C2=A0		if (event =3D=3D 0xc0 || !priv->array)
> > =C2=A0			return;
> > =C2=A0
> > -		if (!sparse_keymap_entry_from_scancode(priv-
> > >array, event)) {
> > +		ke =3D sparse_keymap_entry_from_scancode(priv-
> > >array, event);
> > +
> > +		if (!ke) {
> > =C2=A0			dev_info(&device->dev, "unknown event
> > 0x%x\n", event);
> > =C2=A0			return;
> > =C2=A0		}
> > =C2=A0
> > +		if (ke->type =3D=3D KE_IGNORE)
> > +			return;
> > +
> > =C2=A0wakeup:
> > =C2=A0		pm_wakeup_hard_event(&device->dev);
> > =C2=A0

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEbLyQBMI0qAWiF6l31AjqSkbLPKQFAmYK1IQACgkQ1AjqSkbL
PKSUXwv/YWiU334Osus+niffw9gN94vCQid6OWuTIbX2zMNIunHmpHouMtfo6dpb
7Qsyaz0sxaUEclRPLf/bSAV8zWromM/4Xoa/DoBq+GPOLle5wTJAlislhZVfDZFX
FZ0EfUg+MvThqlJD8yhGNJWGVnSn92hDid7yy5Y/BSWTPCNhRxEsqy+d0pN82EnD
0mqWnpfG28uqK6dtOLnvbiOuWQhgKYerKFYHXw8FLxZV0eKb3+RqBFf6ZdsAjUEC
+d7G9Oq4pc9jxZNvOMop+z3Eskd/bD8Wi2aDtR1qcRENMaK0ucevTuOjGL8Gh80c
SbgKu2eU/qVlbnVrcaPgpB0CXXza7SYUynw5XWB8jBWOj6w2nxpnQPm5a0Z5aNYw
/kLuabhSommEmUIJtoOA2vgO8D0ACfF2n95cNXaJRiOhuag3SRoair50TOzmf09Z
4uco5iaWeIQwEpVFGdy+qh0V18kYclnNMZHC9bhO6heBDLB9Wy/iXDxko9tMXm/v
XnfAKKw9
=3DudJV
-----END PGP SIGNATURE-----

