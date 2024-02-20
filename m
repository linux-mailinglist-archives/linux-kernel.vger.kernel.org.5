Return-Path: <linux-kernel+bounces-73564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1E485C43B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23131F241BC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF5712FF62;
	Tue, 20 Feb 2024 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukPV0cIf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA94578B51;
	Tue, 20 Feb 2024 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455857; cv=none; b=TvU3aThvg/F237/os9jK2fTJ7n7JPJM7YXtJuHVYQjJAXqwrCx77yjK4+a08Trex1mnkl2czATI8C5ITLmvjaQtz65/wQFyp+I9e3nN6ed4Yw9OYV/l5rDpQoGX/4FrxoraYvXLA0LpSwGQuCJ8QeryEuDAlUDsfaMoACogrLy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455857; c=relaxed/simple;
	bh=bo2nHAeqd0NORabbrx7IJ4Cql2j0t4M6YbDm1ZBPCRI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Z/Dx2JITN90JqHNnfdMmvRmqq5iUVYmu8iYA9gcr2nBMls4Ob0knLJhzmZ8jnxc7dCG0MKoHDh8gbj0t0aMnPU8cahOoAB0QP8eXKNfOsr47Fsyy0ZUKRZfd7nHhRJQD+48YVeYMnPrdLwZGauWJWz9jGzDVXpZgxM+ZZUMT2tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukPV0cIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5202EC433C7;
	Tue, 20 Feb 2024 19:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708455856;
	bh=bo2nHAeqd0NORabbrx7IJ4Cql2j0t4M6YbDm1ZBPCRI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ukPV0cIfs9S85rpn7vR8ZhA8m2SRA0UnASsufZ1ij2Od2J9alMS/+4R5eI6iQeasZ
	 GLvBgI1g6r2UViQFAdmQOoIT3SaK6FjRdXHK2pyy3JM+Wu/KmXvSqPWvGYbnFwLbIe
	 8Ny1fkmI3Z5DY9JkJybT8rBGD7g8hbDXP8ACOIbv35qFTi9rkuZxI7zlnjHZ86ZRO8
	 w2GXO5NgBJYuXmi+//JWws/AusmJV5ZTp8Aem+7MTxPQrlp8tNDtJp74UNmpVVKXHq
	 Wn+gY5jhHbFvNyfbtGl8gg9978tvNA/UiDwUSY+4ZNHF5Yv6xKJD40vdjgxNNToChW
	 O+Euhl4hVYarA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Feb 2024 21:04:12 +0200
Message-Id: <CZA51ZEVD7KW.3R3QBO7CGX1SC@kernel.org>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Kanth Ghatraju"
 <kanth.ghatraju@oracle.com>, "Peter Huewe" <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Alexander Steffen" <Alexander.Steffen@infineon.com>, "Lino Sanfilippo"
 <l.sanfilippo@kunbus.com>, "Daniel P. Smith"
 <dpsmith@apertussolutions.com>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Sasha
 Levin" <sashal@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.16.0
References: <20240131170824.6183-1-dpsmith@apertussolutions.com>
 <20240131170824.6183-2-dpsmith@apertussolutions.com>
 <CYU3CFW08DAA.29DJY7SJYPJJZ@suppilovahvero>
 <2ba9a96e-f93b-48e2-9ca0-48318af7f9b1@kunbus.com>
 <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>
In-Reply-To: <ae3fecc4-7b76-4607-8749-045e17941923@infineon.com>

On Tue Feb 20, 2024 at 8:42 PM EET, Alexander Steffen wrote:
> On 02.02.2024 04:08, Lino Sanfilippo wrote:
> > On 01.02.24 23:21, Jarkko Sakkinen wrote:
> >=20
> >>
> >> On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
> >>> Commit 933bfc5ad213 introduced the use of a locality counter to contr=
ol when a
> >>> locality request is allowed to be sent to the TPM. In the commit, the=
 counter
> >>> is indiscriminately decremented. Thus creating a situation for an int=
eger
> >>> underflow of the counter.
> >>
> >> What is the sequence of events that leads to this triggering the
> >> underflow? This information should be represent in the commit message.
> >>
> >=20
> > AFAIU this is:
> >=20
> > 1. We start with a locality_counter of 0 and then we call tpm_tis_reque=
st_locality()
> > for the first time, but since a locality is (unexpectedly) already acti=
ve
> > check_locality() and consequently __tpm_tis_request_locality() return "=
true".
>
> check_locality() returns true, but __tpm_tis_request_locality() returns=
=20
> the requested locality. Currently, this is always 0, so the check for=20
> !ret will always correctly indicate success and increment the=20
> locality_count.
>
> But since theoretically a locality !=3D 0 could be requested, the correct=
=20
> fix would be to check for something like ret >=3D 0 or ret =3D=3D l inste=
ad of=20
> !ret. Then the counter will also be incremented correctly for localities=
=20
> !=3D 0, and no underflow will happen later on. Therefore, explicitly=20
> checking for an underflow is unnecessary and hides the real problem.

Good point.

I think that the check should contain info-level klog message of the
event together with the check against the underflow. I think this is
very useful info for live systems.

BR, Jarkko




