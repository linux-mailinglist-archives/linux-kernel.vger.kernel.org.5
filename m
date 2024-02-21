Return-Path: <linux-kernel+bounces-73870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C9085CCDB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16CD1C21868
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6171F1FD7;
	Wed, 21 Feb 2024 00:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/IcATy7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27401841;
	Wed, 21 Feb 2024 00:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476063; cv=none; b=B4NEf2+9TurdoIC06MC0oOLiXY3WKcA3s7jC121e0XaK5fUO2AJHqjuh0HpVVUov4cX0J1PrGw8/FHk/YamuIhQWlh3K1xAK9s/AX8bf9CqwjZqkMndQdqHc6Qt2VE/fRJK101dR7HHeXHrOmjz+UQO3i//RSwOHGU3jcZA4ym0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476063; c=relaxed/simple;
	bh=kWIAPvMn057OFGEtOjgI4lHWt5h003rFHFlQMrNSEvw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KDwxi3GQYQKVCwwDCI8S3xVolCGJbMebQ9DZ+2M5BFzPh11sV26HzppXKKRIG5M/R00BHt+Son3IyyhGbBljInwoIyrewDYk5v5Vp4fywa4XtKktPTR5TkZBAnRnkaig1owHEYvYJG2GMIWMak4CTR7uEgFDxYqNrwUfy26Rm5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/IcATy7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7B8C433F1;
	Wed, 21 Feb 2024 00:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708476063;
	bh=kWIAPvMn057OFGEtOjgI4lHWt5h003rFHFlQMrNSEvw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=r/IcATy7RunSAZdZHzWO4lQq/f4hhuBaOqN0St7yn1UYon9E+TxIHsEpV5kI6Il8T
	 kZCt5pI1N485NzkhJLoogwM9L/BO7nFSCAEYAdt32Xb17MyMcAxHYG5z0kTK2bHP5F
	 vVZ26PWJYgiA9iq33RtcVAG7OeqdhE764mlp3vrvA7czJEBOxMRZgBkDCA9yUuF7tG
	 /WjkOtcwBLp8YGiBgC1ZFsM7aKzkdanZrAdEt3jZ8wKazwT1gcsRdDRWSXYGcHJL9L
	 q/iszWDfVZHNgvYDGpBHORDOckinHvd7vafo2EyXu5d4VlUbFL53UCrt74TDSSqBVA
	 OXMjKv3GlDP2A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Feb 2024 00:40:58 +0000
Message-Id: <CZAC7U3W7L5A.1JST8CWN3PNND@seitikki>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Kanth Ghatraju"
 <kanth.ghatraju@oracle.com>, "Peter Huewe" <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lino Sanfilippo" <LinoSanfilippo@gmx.de>, "Lino Sanfilippo"
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
 <CZA9ADCGOTQT.LB5XHZZVTWVH@seitikki>
 <0d482ce6-4318-4e42-ac12-be2a26ef3548@gmx.de>
In-Reply-To: <0d482ce6-4318-4e42-ac12-be2a26ef3548@gmx.de>

On Tue Feb 20, 2024 at 11:19 PM UTC, Lino Sanfilippo wrote:
>
>
> On 20.02.24 23:23, Jarkko Sakkinen wrote:
> > On Tue Feb 20, 2024 at 8:54 PM UTC, Lino Sanfilippo wrote:
> >> Hi,
> >>
> >> On 20.02.24 19:42, Alexander Steffen wrote:
> >>> ATTENTION: This e-mail is from an external sender. Please check attac=
hments and links before opening e.g. with mouseover.
> >>>
> >>>
> >>> On 02.02.2024 04:08, Lino Sanfilippo wrote:
> >>>> On 01.02.24 23:21, Jarkko Sakkinen wrote:
> >>>>
> >>>>>
> >>>>> On Wed Jan 31, 2024 at 7:08 PM EET, Daniel P. Smith wrote:
> >>>>>> Commit 933bfc5ad213 introduced the use of a locality counter to co=
ntrol when a
> >>>>>> locality request is allowed to be sent to the TPM. In the commit, =
the counter
> >>>>>> is indiscriminately decremented. Thus creating a situation for an =
integer
> >>>>>> underflow of the counter.
> >>>>>
> >>>>> What is the sequence of events that leads to this triggering the
> >>>>> underflow? This information should be represent in the commit messa=
ge.
> >>>>>
> >>>>
> >>>> AFAIU this is:
> >>>>
> >>>> 1. We start with a locality_counter of 0 and then we call tpm_tis_re=
quest_locality()
> >>>> for the first time, but since a locality is (unexpectedly) already a=
ctive
> >>>> check_locality() and consequently __tpm_tis_request_locality() retur=
n "true".
> >>>
> >>> check_locality() returns true, but __tpm_tis_request_locality() retur=
ns
> >>> the requested locality. Currently, this is always 0, so the check for
> >>> !ret will always correctly indicate success and increment the
> >>> locality_count.
> >>>
> >>
> >> Will the TPM TIS CORE ever (have to) request another locality than 0? =
Maybe the best would
> >> be to hardcode TPM_ACCESS(0) and get rid of all the locality parameter=
s that are
> >> passed from one function to another.
> >
> > Usually, or at least use cases I'm aware of, localities are per
> > component. E.g. Intel TXT has one and Linux has another.
> >
> > There's been some proposals in the past here for hypervisor specific
> > locality here at LKML they didn't lead to anything.
> >
> > If you are suggesting of removing "int l" parameter altogether, I
> > do support that idea.
> >
>
> Yes, removing the "l" parameter is what I meant. I can prepare a patch fo=
r
> the removal.

This change BTW does not need to be supported by any bug per se as
removing useless code is always welcome.

If we wanted ever use let's say separate locality for hypervisor,
we would want to design such feature from ground up. I don't think
this will happen tho since localities are sort of trend that died
with TPM 1.2... It had only authorization value and locality brought
some additional granularity to it.

As for this patch set I also don't think kernel should care about
localities beyond 2 or at least not ever try relinquish them.

I.e. it should at most relinquish localities 0-2. The only action
taken for 3-4 should really be perhaps rollbacking the driver init
and report to klog that these localities have been left open by
the platform.

BR, Jarkko

