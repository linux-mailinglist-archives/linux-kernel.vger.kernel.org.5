Return-Path: <linux-kernel+bounces-100474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BBA879858
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D9FDB20D02
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244637D06B;
	Tue, 12 Mar 2024 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9FnK3zr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C7479B65;
	Tue, 12 Mar 2024 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258661; cv=none; b=lQg13iAeN2cltKUwn6A9U0rwMBJPc2gu+PMokP5ZBpNOhweuGUlONZthbCwz3Kin0PSOx6oXXOyhYuyUxhsrxJmZ9R3MCGppw+fJukOM4iTXNX9Tn8qGbIyd51gXhP21bkeQo4CklxYOf9PbAKcDCNDswR1ExjFWIo5+3J6tXs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258661; c=relaxed/simple;
	bh=kntAY869wNjBhGqs4WVgCSk3Kuy6c3FLEZCqfnnjbPI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=efz9ub9aDNYY7T3M7tNS5vzOafmSrNtpH6iLCoNivWd9VXDEyv3dKre6O16tDl+hC7igRcnpituPaJzRllF7xMPmJJwlaHJZKt6iGaSDkNOE99LfrW1T4X/saV3I90G60IxqnaXF3Aypk56pji/iQVvOape9ZjkqcXIZXpqJX0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9FnK3zr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A9AC433F1;
	Tue, 12 Mar 2024 15:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710258661;
	bh=kntAY869wNjBhGqs4WVgCSk3Kuy6c3FLEZCqfnnjbPI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=I9FnK3zrII1xwFK/Fiw8498wJ2DZRNOF1Pjf/F6wirop9Q2YvgEX+VJ8wty50fav+
	 Ad9cY5qKToHlp99zxRnXZtRZMz3mJMf1NnaESuAYbgH8r5pQhpc9Ydk1vDaiVDj4dU
	 aLndCxdr47j9qH26XVlolYbHItTaRxEBRJ92aPxUtUrDZ7tL1W4IWVU8RHOlKxbfa6
	 PRo13SA1SRkzv2L55A4MERIQYxaCNkciyKGyiXAgo1rM9KC8m8cxtVyTdvFPxno6h5
	 nOG3SntuP6/Z8D89avNSUv/y6VKk/dSU+8bBgcUzeAZtToyvY2+N0eKbsVeqwBY1U9
	 D0aZDtfpQqDjA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 17:50:57 +0200
Message-Id: <CZRW3GY5O5C0.R5HY5SOFCFJA@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rnsastry@linux.ibm.com>,
 <peterhuewe@gmx.de>, <viparash@in.ibm.com>
Subject: Re: [PATCH 2/2] tpm: of: If available Use linux,sml-log to get the
 log and its size
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Michael Ellerman" <mpe@ellerman.id.au>, "Stefan Berger"
 <stefanb@linux.ibm.com>, <linux-integrity@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.17.0
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
 <20240306155511.974517-3-stefanb@linux.ibm.com>
 <CZNS7FO53BHK.6NO93P0C0VY5@kernel.org>
 <CZNS9K4BJPQ8.2MD4WZS8YMI3W@kernel.org>
 <663a3834-056e-4dda-99dd-16ee8734100e@linux.ibm.com>
 <877ci74u0w.fsf@mail.lhotse>
In-Reply-To: <877ci74u0w.fsf@mail.lhotse>

On Tue Mar 12, 2024 at 12:35 PM EET, Michael Ellerman wrote:
> Stefan Berger <stefanb@linux.ibm.com> writes:
> > On 3/7/24 15:00, Jarkko Sakkinen wrote:
> >> On Thu Mar 7, 2024 at 9:57 PM EET, Jarkko Sakkinen wrote:
> >>> in short summary: s/Use/use/
> >>>
> >>> On Wed Mar 6, 2024 at 5:55 PM EET, Stefan Berger wrote:
> >>>> If linux,sml-log is available use it to get the TPM log rather than =
the
> >>>> pointer found in linux,sml-base. This resolves an issue on PowerVM a=
nd KVM
> >>>> on Power where after a kexec the memory pointed to by linux,sml-base=
 may
> >>>> have been corrupted. Also, linux,sml-log has replaced linux,sml-base=
 and
> >>>> linux,sml-size on these two platforms.
> >>>>
> >>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >>>
> >>> So shouldn't this have a fixed tag, or not?
> >>=20
> >> In English: do we want this to be backported to stable kernel releases=
 or not?
> >
> > Ideally, yes. v3 will have 3 patches and all 3 of them will have to be=
=20
> > backported *together* and not applied otherwise if any one of them=20
> > fails. Can this be 'guaranteed'?
>
> You can use Depends-on: <previous commit SHA> to indicate the relationshi=
p.
>
> cheers

Thanks, I've missed depends-on tag.

Stefan, please add also "Cc: stable@vger.kernel.org" just to make sure
that I don't forget to add it.

Right, and since these are so small scoped commits, and bug fixes in
particular, it is also possible to do PR during the release cycle.

BR, Jarkko

