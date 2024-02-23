Return-Path: <linux-kernel+bounces-79138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F253861E18
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3B82822D9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5CF146E8C;
	Fri, 23 Feb 2024 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYqvQTmn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65B1179A8;
	Fri, 23 Feb 2024 20:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721093; cv=none; b=gOW7Pr7+YQf4bCWTzIhNkiUxB7U4m7Dj8X0qpCiaYIcOIgJKw2jyRUCB+HL53wTwA6dcLcXOqJcGTkFRKKK0No60YYHfhMRdjNKGg5JGT5dDBEGpEnKM8pNRW3XCq1rc226p6mz/vtbev/8Tx7VokjepmuPTIHmi8YQpyWGGF6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721093; c=relaxed/simple;
	bh=81yMsgnNPtyxWeBwSw7QL9ejxblFCxtOK+JB/uT5avw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=t/s4xH66zijNd8VTS8cE0FsV7jeCG4lS83ROQsHqY19Rb5S6gK3N5Ah03gfqU5y+XJzHzzR+IXpcKfl1tg9PYVr+nnStwmwSOtw8K5zR3TU2g6QA9oVCXDy/WdQuMuIVsPd4OicfBmdYR0bCHdbWKdDFxMILI+pSw1K4XB6Zus8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYqvQTmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3C3C433C7;
	Fri, 23 Feb 2024 20:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708721092;
	bh=81yMsgnNPtyxWeBwSw7QL9ejxblFCxtOK+JB/uT5avw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=IYqvQTmnoiByiLmEB90ugg69ZgcLiroI2x+zzB6fFua8K1J3aav+uaE6e7/n/d6nS
	 MzCXd6MMhCuAjVjNGUN7+rfVx2zpsV42Jc3lLYXjfCjjTEaCJwKTOmbVoWc5q1DDVr
	 B5E1pY53PgoxUP1l49VkH3wDJ+Orb+eAJYkcYNAOZUc3JJ/hrEpJIn0K71wtP9JNdn
	 vJ6//PUgGG5ZJ19nFSpd8AlWOLT92tjlBq9RTnQxnkMvswAgO4sY3aHYFB6UV3femx
	 tswbUEM/tSUGQzoe+oicsNr3K0BG6+7RiSSJvFOjaXlT32c2tR36LBvSXt3CCgOcA2
	 G5dEB0VmZSQrg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Feb 2024 22:44:48 +0200
Message-Id: <CZCR2N9XKXJQ.32FMAU50UOLT2@suppilovahvero>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Kanth Ghatraju"
 <kanth.ghatraju@oracle.com>, "Peter Huewe" <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, "Lino Sanfilippo"
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
 <8692fcf6-2e67-45b4-b809-7723f30736a2@apertussolutions.com>
In-Reply-To: <8692fcf6-2e67-45b4-b809-7723f30736a2@apertussolutions.com>

On Fri Feb 23, 2024 at 3:56 AM EET, Daniel P. Smith wrote:
> On 2/20/24 15:54, Lino Sanfilippo wrote:
> > Hi,
> >=20
> > On 20.02.24 19:42, Alexander Steffen wrote:
> >> ATTENTION: This e-mail is from an external sender. Please check attach=
ments and links before opening e.g. with mouseover.
> >>
> >>
> >> On 02.02.2024 04:08, Lino Sanfilippo wrote:
> >>> On 01.02.24 23:21, Jarkko Sakkinen wrote:
> >>>
> >>>>
> >>>> On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
> >>>>> Commit 933bfc5ad213 introduced the use of a locality counter to con=
trol when a
> >>>>> locality request is allowed to be sent to the TPM. In the commit, t=
he counter
> >>>>> is indiscriminately decremented. Thus creating a situation for an i=
nteger
> >>>>> underflow of the counter.
> >>>>
> >>>> What is the sequence of events that leads to this triggering the
> >>>> underflow? This information should be represent in the commit messag=
e.
> >>>>
> >>>
> >>> AFAIU this is:
> >>>
> >>> 1. We start with a locality_counter of 0 and then we call tpm_tis_req=
uest_locality()
> >>> for the first time, but since a locality is (unexpectedly) already ac=
tive
> >>> check_locality() and consequently __tpm_tis_request_locality() return=
 "true".
> >>
> >> check_locality() returns true, but __tpm_tis_request_locality() return=
s
> >> the requested locality. Currently, this is always 0, so the check for
> >> !ret will always correctly indicate success and increment the
> >> locality_count.
> >>
> >=20
> > Will the TPM TIS CORE ever (have to) request another locality than 0? M=
aybe the best would
> > be to hardcode TPM_ACCESS(0) and get rid of all the locality parameters=
 that are
> > passed from one function to another.
> > But this is rather code optimization and not really required to fix the=
 reported bug.
>
> Actually, doing so will break the TPM API. The function=20
> tpm_tis_request_locality() is registered as the locality handler,=20
>   int (*request_locality)(struct tpm_chip *chip, int loc), in the tis=20
> instance of struct tpm_class_ops{}. This is the API used by the Secure=20
> Launch series to open Locality2 for the measurements it must record.

OK, based on James' earlier feedback on possibility to have kernel
specific locality and this , and some reconsideration of my position on
the topic, and reading all these great and informative responses, I
think I went too far with this :-)

>
> v/r,
> dps

BR, Jarkko

