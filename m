Return-Path: <linux-kernel+bounces-79126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DE2861DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9F6289CA8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646AE1474C0;
	Fri, 23 Feb 2024 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5J+TKJX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4540146E76;
	Fri, 23 Feb 2024 20:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720948; cv=none; b=Z6xeEwJQfHL6tIFH5C5RTc6w1Glq+cAC3lV7KaYzUvO5yh9ispGiFYfTttzLJTBXLIQqJGc5Z0//7FG0wVT1kEORDMR4ZyTmQzz4A97n1K5Bv5dFQXwb5z5ZF6IAPguCZm8l8zbR6oiJNv7Fw8FLmPiCYwgwAEAY1QnQ/Di+6IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720948; c=relaxed/simple;
	bh=pHoXDnwutfbyjqrkBCrccDqh2gu3zSNO5OYOn7Rd5Dg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=l2HYpP9aY81yGHPQ9mSpf4BbukrzKl1zeck9HKHUiEOieT+VagQV0Y1qECyPD/tL+R37HD1uyLCykvSIdqbzZz489xwMOvAJC/lY7DIcFoSxPdvJY8E27TINr/Ugrn9mNRum14OacFWpJy1Lz5lWaCjpyf+GpY9BCrn7jn+jskk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5J+TKJX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95CFC433F1;
	Fri, 23 Feb 2024 20:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708720948;
	bh=pHoXDnwutfbyjqrkBCrccDqh2gu3zSNO5OYOn7Rd5Dg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=I5J+TKJXSsh/1Pd/kcCSDm5W0Zo/GXHSvaEAGbwlJyh7hyFMYwS8sSeMfDyFEyfbp
	 omK/t9h3JjNiNcFWT2M48tbNCbfWYwf/ap10zB986ogizIRRfxB2zsni3Hs+j8D1MV
	 wdG9R5XASvCB5cwH1fcAYaG+zC+dBsnM06UOI3UGoK0Ohu632/6eiA2lx9M6K2I27Y
	 Q2PgnrRDdwu2/0KzPuGdMP3ByC4H+1sQRjiByvWlagGVqXCvB7DV/yWIK2nTPMxXPr
	 Qg6utD1NfgGXYKOy0jayxr26lN0r3YHN3HNeO1m1EUFf0l3K1pranyPPOuQqgCkgnv
	 JUo32pR6bc8RA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Feb 2024 22:42:23 +0200
Message-Id: <CZCR0STNHQZ7.WQ6RUYVPYKZI@suppilovahvero>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Kanth Ghatraju"
 <kanth.ghatraju@oracle.com>, "Peter Huewe" <peterhuewe@gmx.dekkjkj>
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Daniel P. Smith"
 <dpsmith@apertussolutions.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>, "Alexander Steffen"
 <Alexander.Steffen@infineon.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Sasha
 Levin" <sashal@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
 <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
 <91f600ef-867b-4523-89be-1c0ba34f8a4c@kunbus.com>
 <CZA9CM3PDILC.82JMLUWMB6B7@seitikki> <CZA9GMC718HA.1JFHTTWV563IE@seitikki>
 <7a7f8f0c1b9d124bfc01b66082abf2d8445564ce.camel@HansenPartnership.com>
 <CZB0I9OAGNHT.1HTSJU3925RBY@seitikki>
 <f1a54774-9a44-4400-91e2-358facc12191@apertussolutions.com>
 <CZCQZ5FTCCB5.GIN1NU7G5S0@suppilovahvero>
In-Reply-To: <CZCQZ5FTCCB5.GIN1NU7G5S0@suppilovahvero>

On Fri Feb 23, 2024 at 10:40 PM EET, Jarkko Sakkinen wrote:
> On Fri Feb 23, 2024 at 3:57 AM EET, Daniel P. Smith wrote:
> > On 2/21/24 14:43, Jarkko Sakkinen wrote:
> > > On Wed Feb 21, 2024 at 12:37 PM UTC, James Bottomley wrote:
> > >> On Tue, 2024-02-20 at 22:31 +0000, Jarkko Sakkinen wrote:
> > >>>
> > >>> 2. Because localities are not too useful these days given TPM2's
> > >>>  =C2=A0=C2=A0 policy mechanism
> > >>
> > >> Localitites are useful to the TPM2 policy mechanism.  When we get ke=
y
> > >> policy in the kernel it will give us a way to create TPM wrapped key=
s
> > >> that can only be unwrapped in the kernel if we run the kernel in a
> > >> different locality from userspace (I already have demo patches doing
> > >> this).
> > >=20
> > > Let's keep this discussion in scope, please.
> > >=20
> > > Removing useless code using registers that you might have some actual=
ly
> > > useful use is not wrong thing to do. It is better to look at things f=
rom
> > > clean slate when the time comes.
> > >=20
> > >>>   I cannot recall out of top of my head can
> > >>>  =C2=A0=C2=A0 you have two localities open at same time.
> > >>
> > >> I think there's a misunderstanding about what localities are: they'r=
e
> > >> effectively an additional platform supplied tag to a command.  Each
> > >> command can therefore have one and only one locality.  The TPM doesn=
't
> > >=20
> > > Actually this was not unclear at all. I even read the chapters from
> > > Ariel Segall's yesterday as a refresher.
> > >=20
> > > I was merely asking that if TPM_ACCESS_X is not properly cleared and =
you
> > > se TPM_ACCESS_Y where Y < X how does the hardware react as the bug
> > > report is pretty open ended and not very clear of the steps leading t=
o
> > > unwanted results.
> > >=20
> > > With a quick check from [1] could not spot the conflict reaction but
> > > it is probably there.
> >
> > The expected behavior is explained in the Informative Comment of sectio=
n=20
> > 6.5.2.4 of the Client PTP spec[1]:
> >
> > "The purpose of this register is to allow the processes operating at th=
e=20
> > various localities to share the TPM. The basic notion is that any=20
> > locality can request access to the TPM by setting the=20
> > TPM_ACCESS_x.requestUse field using its assigned TPM_ACCESS_x register=
=20
> > address. If there is no currently set locality, the TPM sets current=20
> > locality to the requesting one and allows operations only from that=20
> > locality. If the TPM is currently at another locality, the TPM keeps th=
e=20
> > request pending until the currently executing locality frees the TPM.=
=20
>
> Right.
>
> I'd think it would make sense to document the basic dance like this as
> part of kdoc for request_locality:
>
> * Setting TPM_ACCESS_x.requestUse:
> *  1. No locality reserved =3D> set locality.
> *  2. Locality reserved =3D> set pending.
>
> I.e. easy reminder with enough granularity.

Also for any non-TPM kernel developer this should be enough to get the
basic gist of the mechanism without spending too much time reading.

BR, Jarkko

