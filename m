Return-Path: <linux-kernel+bounces-133999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7EB89ABE9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9131C20C9B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464F63C087;
	Sat,  6 Apr 2024 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQmIhjkS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C9939FC5;
	Sat,  6 Apr 2024 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712419650; cv=none; b=B+l8yPM/XleGZpqBFxT/0VWUF0FB6PzwHP9G3AW9V/9gyBTmgRTn1oMyNVlOoyEFtTEvu+J41x/jqkacoh4kTJwxMcEwtMcnCct8mjHF27wQkXrIXVUC1QZZUoCVfAmzTK+D+UHp98zfB4rE9+GTSZEQkZuiF3ESMnL1GfdcpC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712419650; c=relaxed/simple;
	bh=zVT1kTFyJpggrN2Vq9amRM/0R/MdFrOjEQnNLK1sYHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwGjTxWL49jh/RerOiRAHP+uOo+OeH9Zoln9WtMzeFV0H3EOBcRUAhNMNxneEB01UgEzD5BmqDX+bir62E74YUjKFt4vPJovGSC0DvClBEczFpDVT76jaPQe4UH3wMCcZRLpJFu1IpA8tt/EtUYrhd2gWWiJJpgo2O6a/wYgRwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQmIhjkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8779FC433C7;
	Sat,  6 Apr 2024 16:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712419649;
	bh=zVT1kTFyJpggrN2Vq9amRM/0R/MdFrOjEQnNLK1sYHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mQmIhjkSlsHCV3tzg2qGznXeY83la3QN1daXmG1AiYQsu/4iqvPj8bWs6JERDHPrq
	 fG4lFV+O83dxD+X3rsq1xTJ3ufdjd8DzXYgGjXoBnvtYXt1BtKtok8sD1IW3AxU4/G
	 fasr7sKbGmwKctlBu8255KzOuvVTXz7AwX9vOr7h3PIOcJJxQ++bcs+A3HNbnLUAjn
	 IfMBDFYIIrFIr1UB+Cv2z/31d/LOOwe5968mUcIlIoNAcwGt5n20ZHufYnOXerZS/p
	 zDyfJCy2JkJ7y5kuoUiqIpwXGgUCeVquDGLZ8pUeRUOvoX2qJYlARseHvyQI8zXUOY
	 ULCUurC5EBPqw==
Date: Sat, 6 Apr 2024 17:07:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Nuno Sa
 <nuno.sa@analog.com>, Petr Mladek <pmladek@suse.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Olivier Moysan <olivier.moysan@foss.st.com>, Jyoti
 Bhayana <jbhayana@google.com>, Chris Down <chris@chrisdown.name>, John
 Ogness <john.ogness@linutronix.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: backend: make use of dev_errp_probe()
Message-ID: <20240406170717.31ab7e47@jic23-huawei>
In-Reply-To: <Zg7DWQtY6SP9E_1m@smile.fi.intel.com>
References: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
	<20240404-dev-add_dev_errp_probe-v1-3-d18e3eb7ec3f@analog.com>
	<Zg6bsS3WMvp-nY3S@smile.fi.intel.com>
	<9f91388faee750e16021f2c0544e7a158a16202b.camel@gmail.com>
	<Zg7DWQtY6SP9E_1m@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Apr 2024 18:12:25 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Apr 04, 2024 at 04:58:27PM +0200, Nuno S=C3=A1 wrote:
> > On Thu, 2024-04-04 at 15:23 +0300, Andy Shevchenko wrote: =20
> > > On Thu, Apr 04, 2024 at 01:06:25PM +0200, Nuno Sa wrote: =20
> > > > Using dev_errp_probe() to simplify the code. =20
>=20
> ...
>=20
> > > > +	if (IS_ERR(fwnode))
> > > > +		return dev_errp_probe(dev, PTR_ERR(fwnode),
> > > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Cannot get Firmware reference\=
n"); =20
> > >=20
> > > ERR_CAST() seems quite good candidate to have here.
> > >=20
> > > 		return dev_errp_probe(dev, fwnode, "Cannot get Firmware
> > > reference\n");
> > >=20
> > > (Assuming dev_errp_probe() magically understands that, note you may h=
ave it as
> > > =C2=A0a macro and distinguish parameter type with _Generic() or so an=
d behave
> > > =C2=A0differently: ERR_PTR() vs. ERR_CAST(), see acpi_dev_hid_uid_mat=
ch()
> > > =C2=A0implementation, but also keep in mind that it doesn't distingui=
sh NULL/0,
> > > there
> > > =C2=A0is a patch available in the mailing list to fix that, though.) =
=20
> >=20
> > Do we care that much for going with that trouble? =20
>=20
> I don't think we do. We are not supposed to be called with ret =3D=3D 0/N=
ULL.
> That's why I pointed out to the current version.
>=20
> > I understand like this we go
> > PTR_ERR() to then comeback to ERR_PTR() but this for probe() which is n=
ot a
> > fastpath. So perhaps we could just keep it simple? =20
>=20
> It's not about performance, it's about readability. See the difference be=
tween
> yours and mine.
>=20

You are suggesting making it transparently take an error ptr or an integer?
Whilst clever, I'm not seeing that as a good idea for readability / reviewa=
bility.
I expect something that looks like a function to take the same parameters (=
other vargs)
always.  _Generic messes with that.

Maybe I just don't like to learn new things!  If consensus comes down in fa=
vour
of _Generic trickery then I'll get used to it eventually.

Jonathan


