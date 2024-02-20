Return-Path: <linux-kernel+bounces-73806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E70B785CBCC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2528D1C21DBD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC6215444A;
	Tue, 20 Feb 2024 23:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEulaNXg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1746B78688;
	Tue, 20 Feb 2024 23:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470621; cv=none; b=j5Psbhhzzr3y5CXONJUoPwA/acXIW6zhkS/5xNFDjCVFZAoqnSN+GwNHJLVF0cpdVohmYiFouUrsJrf9K2LbnckjO+iSH0I/bqv1akD82Mn0e+i8jY3kVCLSIDVj+lSC0SRFMP3hA2lbGj0qOPOQVOwL16svBD7P14yBujCurCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470621; c=relaxed/simple;
	bh=p4Y5zFaznuU/jAxRto/Andt0gHvIWiVFBkF7HqRzBBE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BtVvbkIcEdodxZbMLNPAbxfIcM5L/xe1VKc0uoVKZe2Ud2FZ9scXfjXYUfeCUDYSVIwN4y8mQM8xiV5yosKtvSrST2QjDDz9yoEAItLgJVLJ0+qWLoQTHTM2vS8FA7fYRqnifBb5sjjtJ6jZrtm0qAMPaoqyuryTL6ecLTzRzFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEulaNXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0EDC433F1;
	Tue, 20 Feb 2024 23:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708470620;
	bh=p4Y5zFaznuU/jAxRto/Andt0gHvIWiVFBkF7HqRzBBE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=cEulaNXgaujAjGhH0EmEplokbROaStrHhXDzOxPGEnD6mSZrqcaVm1wQH8O4ZjLoM
	 GQjHcqk+ETFMN7jbAICkc6rchrHOupfq5IC09elv+VlzqV7dQ8JPanpguZs0iMa8z4
	 zMfG15JgdVxZzMRT4Z5tvxPlGnXGet0JHxsfkHuWJnfJMz119qXWXVYhfexVwU30vY
	 8hYowdPSmHLlVsgG1V1q6v9M1Vo3OKw5SjPerw4nt/g1uoKN7HcWDJkIdMsM7RVtHy
	 Xd7E4CgYMRhzNaen+qvLZk53HsFpB07cFBhe9tAzRlGhRgYROP13Pqv1EXnw+seOn1
	 slGNpRl/loTow==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Feb 2024 23:10:16 +0000
Message-Id: <CZAAADX4NK8Y.OA6YAA7HQFFJ@seitikki>
Cc: "Kanth Ghatraju" <kanth.ghatraju@oracle.com>, "Peter Huewe"
 <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: <ross.philipson@oracle.com>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>, "Alexander Steffen"
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
In-Reply-To: <657ade76-98c5-4f93-9716-b471b31d07e2@oracle.com>

On Tue Feb 20, 2024 at 10:57 PM UTC,  wrote:
> On 2/20/24 2:26 PM, Jarkko Sakkinen wrote:
> > On Tue Feb 20, 2024 at 8:54 PM UTC, Lino Sanfilippo wrote:
> >> for (i =3D 0; i <=3D MAX_LOCALITY; i++)
> >> 	__tpm_tis_relinquish_locality(priv, i);
> >=20
> > I'm pretty unfamiliar with Intel TXT so asking a dummy question:
> > if Intel TXT uses locality 2 I suppose we should not try to
> > relinquish it, or?
>
> The TPM has five localities (0 - 4). Localities 1 - 4 are for DRTM=20
> support. For TXT, locality 4 is hard wired to the CPU - nothing else can=
=20

Locality 4 is familiar because it comes across from time to time.

If I recall correctly DRTM should use only localities 3-4 and=20
localities 0-2 should be reserved for the OS use.

So this does not match what I recall unfortunately but I'm not
really expert with this stuff.

The patches has zero explanations SINIT ACM's behaviour on
locality use and without that this cannot move forward because
there's neither way to reproduce any of this.

Actually there's zero effort on anything related to SINIT.

> an AC (Authenticated Code) module. That leaves 1 and 2 for the DRTM=20
> software environment to use. If the DRTM software opens 1 or 2, it=20
> should close them before exiting the DRTM.
>
> >=20
> > AFAIK, we don't have a symbol called MAX_LOCALITY.
>
> Daniel added it in the patch set.

Got this, my symbol lookup just failed in my Git tree but looking at
the patch set there was a symbol called *TPM_*MAX_LOCALITY :-)

BR, Jarkko

