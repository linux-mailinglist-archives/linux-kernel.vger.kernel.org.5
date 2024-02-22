Return-Path: <linux-kernel+bounces-77544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD40986071D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C411C2111B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB2013BAE1;
	Thu, 22 Feb 2024 23:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqaEpfHP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FAD199AD;
	Thu, 22 Feb 2024 23:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708645763; cv=none; b=olpBvmRP4oRlLUNQTcED5b96ncPMoAjlGOUwVL2FeKp6gczLOY42SwhuQxNZzmdyF13HqZzNUApNleN+NZKYWCsUEC4Wh37bASffLW7yklovcriQYDEyfSLWAWHKr6FaT7w8QBpFeilN0yydIMGMqVEBTxMJ5rvAyR4cXTKYN88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708645763; c=relaxed/simple;
	bh=bgmSMhBzcEqii8d0LHlz7CHuWt0HcycK02XxHyt6XZw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=G5nL6vp7QPxhzwtPtL5cxpG5k5VwJA5Y1G0ThE0+gH2ZuctFDnBxlCBIf0i6OeDRf4jIRDxjqe2uGMizE26342ADR5YAaH8IsERq/ohOvn8Law3J/bXfDpM7yhb+te3X3PuOrHpW5u5dspdS60p+Qsjpwb+DudOcwsmQJNkS4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqaEpfHP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39476C433C7;
	Thu, 22 Feb 2024 23:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708645762;
	bh=bgmSMhBzcEqii8d0LHlz7CHuWt0HcycK02XxHyt6XZw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=DqaEpfHP30g8Iz6Rzef8p2mZktl4RedmOVrmt4dtfVFJdItRjRNzDIz/Pprc5/jn5
	 02cJvYh9fXA2+/ZdbVWSIxLo4qAeFqy6uer1HmrYAL1/lBCuyg+LoBk8Cc9fLjyfqo
	 XxhHMz6nUzVNWob8UT5KGyh58GZPj1t/z6XOj3AEnqneT3Ul3NT7B6HkwvrSmZZzyj
	 M+9I7Cip7fEm/KNYDe5EEOF0eE3a8YE2KUXWn34HnClJQNgzw/EW6KdUcSXt9tA9q/
	 7yszg5RxG7ZfLcecfIb/aF9N6ZOq+gkHSC4LSjO0bHyRy1dLw2HToS6xzTjw6eCBPj
	 55vJxA9gIZ4kQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Feb 2024 01:49:17 +0200
Message-Id: <CZC0DCWSO6EW.2TWZ7DKGPZB41@kernel.org>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Kanth Ghatraju"
 <kanth.ghatraju@oracle.com>, "Peter Huewe" <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Lino
 Sanfilippo" <l.sanfilippo@kunbus.com>, "Alexander Steffen"
 <Alexander.Steffen@infineon.com>, "Daniel P. Smith"
 <dpsmith@apertussolutions.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Sasha
 Levin" <sashal@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
 <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
 <91f600ef-867b-4523-89be-1c0ba34f8a4c@kunbus.com>
 <CZA9CM3PDILC.82JMLUWMB6B7@seitikki> <CZA9GMC718HA.1JFHTTWV563IE@seitikki>
 <7a7f8f0c1b9d124bfc01b66082abf2d8445564ce.camel@HansenPartnership.com>
 <CZB0I9OAGNHT.1HTSJU3925RBY@seitikki>
 <354bf802d27ea995858e41dd90d9a83ffc6739aa.camel@HansenPartnership.com>
In-Reply-To: <354bf802d27ea995858e41dd90d9a83ffc6739aa.camel@HansenPartnership.com>

On Thu Feb 22, 2024 at 11:06 AM EET, James Bottomley wrote:
> On Wed, 2024-02-21 at 19:43 +0000, Jarkko Sakkinen wrote:
> > On Wed Feb 21, 2024 at 12:37 PM UTC, James Bottomley wrote:
> > > On Tue, 2024-02-20 at 22:31 +0000, Jarkko Sakkinen wrote:
> [...]
> > > > =C2=A0I cannot recall out of top of my head can
> > > > =C2=A0=C2=A0 you have two localities open at same time.
> > >=20
> > > I think there's a misunderstanding about what localities are:
> > > they're effectively an additional platform supplied tag to a
> > > command.=C2=A0 Each command can therefore have one and only one
> > > locality.=C2=A0 The TPM doesn't
> >=20
> > Actually this was not unclear at all. I even read the chapters from
> > Ariel Segall's yesterday as a refresher.
> >=20
> > I was merely asking that if TPM_ACCESS_X is not properly cleared and
> > you se TPM_ACCESS_Y where Y < X how does the hardware react as the
> > bug report is pretty open ended and not very clear of the steps
> > leading to unwanted results.
>
> So TPM_ACCESS_X is *not* a generic TPM thing, it's a TIS interface
> specific thing.  Now the TIS interface seems to be dominating, so
> perhaps it is the correct programming model for us to follow, but not
> all current TPMs adhere to it.

I know, I only have CRB based TPMs in my host machines but here the
context is TIS interface so in this scope it's what we care about.

We're trying to fix a bug here, not speculate what additional
features could be done with localities.

BR, Jarkko

