Return-Path: <linux-kernel+bounces-73758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1630E85CAA6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28FE1F21F99
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7711534E1;
	Tue, 20 Feb 2024 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIS1TAq/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD83B14A4D2;
	Tue, 20 Feb 2024 22:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708467798; cv=none; b=XDRLfWaU4Z5Jbf5SppILwUPn+C4M2gaQoWE1guxWYrppVs8cnv8U38ungJTKYyqkoHOsvwGhdJCJBenMe4hBq6dJDSySz5npiVRsYVc5uOLsE5m7D3ylIQfVx7gbnNFHpF5+CQjTNw090pJjIdokY3cDn7f3i9j4Yk073qTZP+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708467798; c=relaxed/simple;
	bh=OKS6Udcp6igVrG987pzqq3GCkNomRfNehWlRDWLPYoM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MCsP2kvUVJel57QnlgEfGK6LlN2Kx28ZkeMetDGeLg7BFi1kU6Cl3pUG+mLLZ2TLXOHazSwI8yMxP0SKml4cQN2cFdwASRtFFnvhZos7PY6Nz5f3ADTY7ZjKql4eXDrXy/lBZgiBdUGYNwrZy816s6FxYypTDHitvPsmRp2umF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIS1TAq/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0703FC433F1;
	Tue, 20 Feb 2024 22:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708467798;
	bh=OKS6Udcp6igVrG987pzqq3GCkNomRfNehWlRDWLPYoM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UIS1TAq/SIc7z+kKMQv5U7evPlAFezVV/5KXY51Bp3Et8Gj86uAE0arOUP4bTNbVt
	 j5ZVQ5Wqm92Z2b8QeXU4qR+JOL/7Af0wzR7fDbyNCdAJ9KGRpxNWHNqF1EeEPkBd2e
	 LXrPuJEcwefDbsmsY7iqPk1ikvPFnoNL4Ry03OCrlqph8GEPNbKqKb55nmbzXiXp+0
	 UOvuFVoJwJARlhHtJ4RSRV7ODNjA26/S5UfSAY/E9W+cBW2eMcAg28wL035BWG31k1
	 QPSKxQxTyVdMqmVqCzLoW/CveW1nicG437KO1zO3PNuDkqE2gwtug1TbKIRiaYnUkU
	 WtGgVYBM/hYlA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Feb 2024 22:23:13 +0000
Message-Id: <CZA9ADCGOTQT.LB5XHZZVTWVH@seitikki>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Kanth Ghatraju"
 <kanth.ghatraju@oracle.com>, "Peter Huewe" <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lino Sanfilippo" <l.sanfilippo@kunbus.com>, "Alexander Steffen"
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
In-Reply-To: <91f600ef-867b-4523-89be-1c0ba34f8a4c@kunbus.com>

On Tue Feb 20, 2024 at 8:54 PM UTC, Lino Sanfilippo wrote:
> Hi,
>
> On 20.02.24 19:42, Alexander Steffen wrote:
> > ATTENTION: This e-mail is from an external sender. Please check attachm=
ents and links before opening e.g. with mouseover.
> >=20
> >=20
> > On 02.02.2024 04:08, Lino Sanfilippo wrote:
> >> On 01.02.24 23:21, Jarkko Sakkinen wrote:
> >>
> >>>
> >>> On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
> >>>> Commit 933bfc5ad213 introduced the use of a locality counter to cont=
rol when a
> >>>> locality request is allowed to be sent to the TPM. In the commit, th=
e counter
> >>>> is indiscriminately decremented. Thus creating a situation for an in=
teger
> >>>> underflow of the counter.
> >>>
> >>> What is the sequence of events that leads to this triggering the
> >>> underflow? This information should be represent in the commit message=
.
> >>>
> >>
> >> AFAIU this is:
> >>
> >> 1. We start with a locality_counter of 0 and then we call tpm_tis_requ=
est_locality()
> >> for the first time, but since a locality is (unexpectedly) already act=
ive
> >> check_locality() and consequently __tpm_tis_request_locality() return =
"true".
> >=20
> > check_locality() returns true, but __tpm_tis_request_locality() returns
> > the requested locality. Currently, this is always 0, so the check for
> > !ret will always correctly indicate success and increment the
> > locality_count.
> >=20
>
> Will the TPM TIS CORE ever (have to) request another locality than 0? May=
be the best would
> be to hardcode TPM_ACCESS(0) and get rid of all the locality parameters t=
hat are
> passed from one function to another.

Usually, or at least use cases I'm aware of, localities are per
component. E.g. Intel TXT has one and Linux has another.

There's been some proposals in the past here for hypervisor specific
locality here at LKML they didn't lead to anything.

If you are suggesting of removing "int l" parameter altogether, I
do support that idea.

> But this is rather code optimization and not really required to fix
> the reported bug.

Just adding here that I wish we also had a log transcript of bug, which
is right now missing. The explanation believable enough to move forward
but I still wish to see a log transcript.

A/B testing of the bug and fix is something I'm lacking here. If anyone
has ideas how to use QEMU to simulate what Intel TXT does with
localities that would help.

Most of us do not carry Intel TXT setup anywhere (home or office).

Also even tho 0/3 has an explanation bug 1/3 does not have anything at
all to make it to be counted as a bug fix. Pretty difficult to compare
any possible proposals for a fix on this playground tbh.

BR, Jarkko

