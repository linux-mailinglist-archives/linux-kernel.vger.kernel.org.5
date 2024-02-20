Return-Path: <linux-kernel+bounces-73807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3521B85CBD0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A66DB21D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC35215444E;
	Tue, 20 Feb 2024 23:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5dppUpc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F6915442A;
	Tue, 20 Feb 2024 23:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470796; cv=none; b=cMTg8Em6wMlyb6ZQN95h4u/3D4HePezXbpW8lDovytx2MsX0NuTtyTboIor8Z4+y1fLJZw+WRDIvuwHDcEgCjRlS3fto+cbPeNBYu8YdFlaGmU2wJVTa1hXjjzcaJwvy8aovs68Bm23JWzJwRMwUun1H+8Eg6JwuTKMSWI4oEVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470796; c=relaxed/simple;
	bh=3vGct6fyWaeG1D4cSXWDULBZIRqLRMImFmhMqUWov1M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NML4AJrfNEOpw/UDbvR/LeeeprqzIEAk2UJbPYTyji9BPUuHPhBVGVEnyauFuUkBsxjtF2KNBmgYrdZdkOgcOMqCns3kE7C2LDr+30oo5STTRNO0SDuzrYVB8G2rUo+F5lvHp/QTFwDfjPsmB+Xg+8MOebpte63Mq3pW4LyGoZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5dppUpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23819C433C7;
	Tue, 20 Feb 2024 23:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708470795;
	bh=3vGct6fyWaeG1D4cSXWDULBZIRqLRMImFmhMqUWov1M=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=P5dppUpcllHI1hbII1XmHEvbfSRwtL90aBmChsdL68+YBubMgCPI0uKDR+Kb+Jy6Z
	 U4LsvS+dlaO5XZvA1I759lDQ6OKW3ZTDKDyRMelXnG3FgSIv4dR30zaTMTTCK/SpLb
	 YW48S8lqHjQ8lNdXpJVmBIu4Bkww6iQstYG+06vzPY1uHEEfMbSxaKseqo3Fsb5ihA
	 NuJydKLG5JVZ4DsgJglBQMtMG9S8npQCFWDLpUGdlpcKCuD2bAaylooSgfA2ZJwIcX
	 9q4MAMkFbCpVUGA10TYpNz+nF6j4rkZsKqsqQXoBO0rGZRFf67MHLyLduEAsq7TLdR
	 TO0U8fUdWyC+w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Feb 2024 23:13:11 +0000
Message-Id: <CZAACMD4UW9B.3DWXS99QRF6KV@seitikki>
Cc: "Kanth Ghatraju" <kanth.ghatraju@oracle.com>, "Peter Huewe"
 <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <ross.philipson@oracle.com>,
 "Lino Sanfilippo" <l.sanfilippo@kunbus.com>, "Alexander Steffen"
 <Alexander.Steffen@infineon.com>, "Daniel P. Smith"
 <dpsmith@apertussolutions.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Sasha
 Levin" <sashal@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
 <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
 <91f600ef-867b-4523-89be-1c0ba34f8a4c@kunbus.com>
 <CZA9CM3PDILC.82JMLUWMB6B7@seitikki>
 <657ade76-98c5-4f93-9716-b471b31d07e2@oracle.com>
 <CZAAADX4NK8Y.OA6YAA7HQFFJ@seitikki>
In-Reply-To: <CZAAADX4NK8Y.OA6YAA7HQFFJ@seitikki>

On Tue Feb 20, 2024 at 11:10 PM UTC, Jarkko Sakkinen wrote
> On Tue Feb 20, 2024 at 10:57 PM UTC,  wrote:
> > On 2/20/24 2:26 PM, Jarkko Sakkinen wrote:
> > > On Tue Feb 20, 2024 at 8:54 PM UTC, Lino Sanfilippo wrote:
> > >> for (i =3D 0; i <=3D MAX_LOCALITY; i++)
> > >> 	__tpm_tis_relinquish_locality(priv, i);
> > >=20
> > > I'm pretty unfamiliar with Intel TXT so asking a dummy question:
> > > if Intel TXT uses locality 2 I suppose we should not try to
> > > relinquish it, or?
> >
> > The TPM has five localities (0 - 4). Localities 1 - 4 are for DRTM=20
> > support. For TXT, locality 4 is hard wired to the CPU - nothing else ca=
n=20
>
> Locality 4 is familiar because it comes across from time to time.
>
> If I recall correctly DRTM should use only localities 3-4 and=20
> localities 0-2 should be reserved for the OS use.
>
> So this does not match what I recall unfortunately but I'm not
> really expert with this stuff.
>
> The patches has zero explanations SINIT ACM's behaviour on
> locality use and without that this cannot move forward because
> there's neither way to reproduce any of this.
>
> Actually there's zero effort on anything related to SINIT.

To put short we need a clearer sequence what Intel TXT does
causing leaving localities does. If that is nailed to less
abstract description then we can review this.

If we know this blackbox model then there's a chance to make
simulation of it e.g. with QEMU.

Alternatively we need a more trivial scenario to reproduce
a bug in locality handling than Intel TXT. There's no enough
beef ATM to really make good decisions what sort of code change
would be best for Linux.

BR, Jarkko

