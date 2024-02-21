Return-Path: <linux-kernel+bounces-75418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9AA85E875
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82021F24AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F838664F;
	Wed, 21 Feb 2024 19:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5a73uOl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABDC85923;
	Wed, 21 Feb 2024 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544715; cv=none; b=Lb2SWnS1BC3YrRTxo0/U6U1ggwF68HEQcyjPcHAULzLydEbBEX2N15MfAPteki6iwbrHgfjFtDwx5cpCqM0QZYZamDdf6GwMg6e1edz1Z/1BGXObX6yjzkEGiXif87U6hBAj6Yt+RItKRn0F6Sv3j0kf4xs5bqr8TTxKesNnVSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544715; c=relaxed/simple;
	bh=k05KXlMbnmI+laCXj6HRVtiY8TJLU/7JY5PZjol1VlE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=pkvi7Q8k3YZRJmN7UpTRYr46di3jJPr161OnB9Il66rthA+wo0eOKcqCNdx1uBixEL9w9d4HMmco7UdF5U5s6IIsBMU83hYwaTs8tCSmDXgLYTfMJtYy2n9RP2GamtWWcJUZ5s7nIDipa42rsM/Eb8mgv48N8LHl+O+4cDuYv/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5a73uOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A47C433F1;
	Wed, 21 Feb 2024 19:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708544715;
	bh=k05KXlMbnmI+laCXj6HRVtiY8TJLU/7JY5PZjol1VlE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=n5a73uOlk8UvhfXlPtlBTswiTVyaiUkaE5eSHBu3gDjGAmcM8me1YEa89O9MsY9yd
	 EsjINJmcsHF4j/VVKs82e3dymbotED8p2aOWPWfaA/Gbtl2ZlmMyqlJUvFpnbuQ19R
	 SoY4b8uKbyHqHfFGeQl956wO4xaN8qNZy4TNOVL3YdsUMDyKyG+0av0ZltSj3Brr5w
	 jbTwBNERhlB5/QUdu1i3hOLLqaBkAMZUUiELvI5ggyk5iFTIsQgqyr/1n7Nf3+6qAL
	 0y4aRCchnh5IGO+GlkbfR1Eqb9xx5XzHp+ar5QT0S+R70d77KdlLAEztrYjVrnqhvv
	 1unSa4iY1jHRw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Feb 2024 19:45:10 +0000
Message-Id: <CZB0JWCZJVF1.17B3HJLTYVOWD@seitikki>
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>, "Alexander Steffen"
 <Alexander.Steffen@infineon.com>, "Daniel P. Smith"
 <dpsmith@apertussolutions.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Sasha
 Levin" <sashal@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Kanth Ghatraju"
 <kanth.ghatraju@oracle.com>, "Peter Huewe" <peterhuewe@gmx.de>
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
In-Reply-To: <CZB0I9OAGNHT.1HTSJU3925RBY@seitikki>

On Wed Feb 21, 2024 at 7:43 PM UTC, Jarkko Sakkinen wrote:
> On Wed Feb 21, 2024 at 12:37 PM UTC, James Bottomley wrote:
> > On Tue, 2024-02-20 at 22:31 +0000, Jarkko Sakkinen wrote:
> > >=20
> > > 2. Because localities are not too useful these days given TPM2's
> > > =C2=A0=C2=A0 policy mechanism
> >
> > Localitites are useful to the TPM2 policy mechanism.  When we get key
> > policy in the kernel it will give us a way to create TPM wrapped keys
> > that can only be unwrapped in the kernel if we run the kernel in a
> > different locality from userspace (I already have demo patches doing
> > this).
>
> Let's keep this discussion in scope, please.
>
> Removing useless code using registers that you might have some actually
> useful use is not wrong thing to do. It is better to look at things from
> clean slate when the time comes.
>
> > >  I cannot recall out of top of my head can
> > > =C2=A0=C2=A0 you have two localities open at same time.
> >
> > I think there's a misunderstanding about what localities are: they're
> > effectively an additional platform supplied tag to a command.  Each
> > command can therefore have one and only one locality.  The TPM doesn't
>
> Actually this was not unclear at all. I even read the chapters from
> Ariel Segall's yesterday as a refresher.

Refering to https://www.amazon.com/Trusted-Platform-Modules-Computing-Netwo=
rks/dp/1849198934

SBR, Jarkko

