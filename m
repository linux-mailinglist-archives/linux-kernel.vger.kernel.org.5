Return-Path: <linux-kernel+bounces-106750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4296387F317
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2DDDB22416
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2D15A11C;
	Mon, 18 Mar 2024 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZgEJQB3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AD758AC7;
	Mon, 18 Mar 2024 22:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710800726; cv=none; b=rNqh0ailXuNPHZhMWh4joloVf5aEJwXhy8iU0uztwSoIGhJshnCFjHPqcydK/hKaqavh0a1+Uuy6OoizGBSAR9u68V9UIx25qNRgV5XAjugxhY84/59+QR4t7kN/1RbvlkrybdPOCUi9KtBpBZGznwW3wqNrUTJoFcfBicdU/EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710800726; c=relaxed/simple;
	bh=itttylFttcbiCbzFFglP/gxOduvNaaoCGRLHiPfLiJg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VstuSM5o/boek1rBVAwGyqFH0pATuTP5xO/kW2qftlbk+Y02VbERH3tVlqriqJIn80Ak42brMmWH1VgnORhTXDutDHKOYfPkm7pBq8JRb8etxNgV+CFhudoJccBtlBRqQK6VnsYlbaMCq9MdCrfJ8gETPUELDPasn/kT+Y3W+1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZgEJQB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19360C433C7;
	Mon, 18 Mar 2024 22:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710800726;
	bh=itttylFttcbiCbzFFglP/gxOduvNaaoCGRLHiPfLiJg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=eZgEJQB3Me3KvgDGLbPzkNSX7QZd7wuYGp/4rkVev4ls2tTomPc0MUNgWZwAVMuzT
	 xASDqm32pOIVx8gVOTtYpWIyeukaNOM3MjOGwSrCJtxXrc80828Abuur7sbL5jTfLn
	 PtFQPK3Ot46N0CrSKOFlWcyW4g+yJzhqDyR5fyBIO2iQrstrCNWkOK1+88Ym+e34hi
	 aGzdRljQhZJgp3eMhH7ClWpjcphictD4T6eU0tldas0tEOIwuyJRv2K1Mh/rOmFVYS
	 XjuV720pI8JA2maLIgV5GlbNPlw70zNulpOMF78BpIAUQ8WNMfu+0GXNUl1XXS+304
	 08sYaJ00kt7Hg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Mar 2024 00:25:22 +0200
Message-Id: <CZX88PUGBT4Q.992VYE0L8TS0@kernel.org>
Cc: "Stefan Berger" <stefanb@linux.vnet.ibm.com>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
 <linux-kernel@vger.kernel.org>, <saulo.alessandre@tse.jus.br>,
 <bbhushan2@marvell.com>, "Stefan Berger" <stefanb@linux.ibm.com>
Subject: Re: [PATCH v6 03/13] crypto: ecdsa - Adjust tests on length of key
 parameters
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lukas Wunner" <lukas@wunner.de>
X-Mailer: aerc 0.15.2
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-4-stefanb@linux.vnet.ibm.com>
 <CZX5OW9RVXGQ.2MBG8AQKHRKSE@kernel.org> <Zfikwi0v0_R58uNT@wunner.de>
In-Reply-To: <Zfikwi0v0_R58uNT@wunner.de>

On Mon Mar 18, 2024 at 10:32 PM EET, Lukas Wunner wrote:
> On Mon, Mar 18, 2024 at 10:25:26PM +0200, Jarkko Sakkinen wrote:
> > On Tue Mar 12, 2024 at 8:36 PM EET, Stefan Berger wrote:
> > > From: Stefan Berger <stefanb@linux.ibm.com>
> > >
> > > In preparation for support of NIST P521, adjust the basic tests on th=
e
> > > length of the provided key parameters to only ensure that the length =
of the
> > > x plus y coordinates parameter array is not an odd number and that ea=
ch
> > > coordinate fits into an array of 'ndigits' digits. Mathematical tests=
 on
> > > the key's parameters are then done in ecc_is_pubkey_valid_full reject=
ing
> > > invalid keys.
> > >
> > > The change is necessary since NIST P521 keys do not have keys with
> > > coordinates that each fully require 'full' digits (=3D u64), unlike
> > > NIST P192/256/384 that all require multiple 'full' digits.
> >=20
> > This sentence is not really comprehendable English sentence. Can you
> > just write the rationale in understandable form?
> >=20
> > "fully require full digits (=3D u64)" is something totally alien to me
> > tbh.
>
> It is proper English, but requires an understanding of how large integers
> are handled by crypto/ecdsa.c:  They're a sequence of u64.  For P192, P25=
6
> and P384 all u64 in the sequence are used to their full extent because th=
e
> key size is divisable by 64.  That's not the case for P521, where the mos=
t
> significant u64 is not fully used (only 2 out of 8 bytes are used).

This would be a great extension to the current commit message.

My point here is that:

1. I obviously acknowledge that not all math etc. related to a crypto
   standard can be explained in a commit message.
2. That said, they should be more verbose than usualy commit messages
   to be as easy to follow as possible, given the complexity of topic.

Here the topic is fairly complex but most of commit messages are written
without much focus on the background story. In this type of patch set
even having some redundancy in the commit messages is favorable so that
they are as easy to understand as possible.

Actually just as code changes they are quite simple but why they are
made is the complex topic, which means that commit messages are even
more important. This motivation comes from e.g. when these need to be
backtracked at some point when bisecting a bug and whatnot.

> Thanks,
>
> Lukas


BR, Jarkko

