Return-Path: <linux-kernel+bounces-81068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E491867067
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B695AB21650
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AB45D726;
	Mon, 26 Feb 2024 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndpY59ga"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1517F5D49A;
	Mon, 26 Feb 2024 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708940324; cv=none; b=OHjl8Sd9hotWBNobIw4CJZdouh0XNbETSPDPcKpYa2KDGe9bgvvqTm5Px+xOc60y0dAxtZALYylUcfxGd3F3BWf6AamQvQdujXxmFtte7y4QYNYZAa7Y2n2uBsTJ0ZVGG3XUTVtcbZNcOGAyPmgIHFh0zXWAF0K+XORJKOJcJFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708940324; c=relaxed/simple;
	bh=hhG00OyEDeWdYwOZW6NZDyKXB/h/3F2ZEF/AqLqkOj8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JLzbkzGWD5rbPBMH1kAFgOTTe6hc9sgX9yt8kVPTL7h70LMAj2GFcNSluawh8yIqq44EYfHoTwr6upz3JOCecqy75vSEdDotGiwkGWh6lEnqCpt9c3JPZ9AU7G9jO7r4gbXFwIC+zewNG7Vk+yRoSc4+TjaUtYKiv9qh78BoQGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndpY59ga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE6BC433F1;
	Mon, 26 Feb 2024 09:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708940323;
	bh=hhG00OyEDeWdYwOZW6NZDyKXB/h/3F2ZEF/AqLqkOj8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ndpY59gaX5H/LlbJgo0UuXF1oSj6Xg2eZvHSb/62FfoQj7dXzoOEzjqHpXaRxdjeW
	 N6J+awVv5/pINt0vdAxc83xdEm7dw9ZKBKZ13wT6zI4gkHePQuEFj1/qZwG/dpdyPz
	 svLgGz0DQwc4CM4Y24TLXzqWf3MpQBWIAeXeARk8W9R2YutToSWPSv/8/LIoVJIF+2
	 mGUi0hXd+rnnjR5yTemGuSr7S5ISUTBPHslaOdXv5+NNBIHLxfou8aQeM/107eFjSl
	 m1qJ9rhvIm7Ol0fjuEVEnWqsxcdUahD/paGBAdLFVrQtcIzIsLwidZ6dBIdvMyOBS/
	 kOVf1xkieH6Lw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Feb 2024 11:38:39 +0200
Message-Id: <CZEWS8QBYSF9.120NE1F4L75VT@suppilovahvero>
Cc: "Ross Philipson" <ross.philipson@oracle.com>, "Kanth Ghatraju"
 <kanth.ghatraju@oracle.com>, "Peter Huewe" <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] tpm: protect against locality counter underflow
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lino Sanfilippo" <l.sanfilippo@kunbus.com>, "Daniel P. Smith"
 <dpsmith@apertussolutions.com>, "Alexander Steffen"
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
 <75642d53-9daa-4be7-8d3d-d1d86bc60b3e@kunbus.com>
In-Reply-To: <75642d53-9daa-4be7-8d3d-d1d86bc60b3e@kunbus.com>

On Sat Feb 24, 2024 at 4:34 AM EET, Lino Sanfilippo wrote:
>
>
> On 23.02.24 02:56, Daniel P. Smith wrote:
>
> >>
> >> Will the TPM TIS CORE ever (have to) request another locality than 0? =
Maybe the best would
> >> be to hardcode TPM_ACCESS(0) and get rid of all the locality parameter=
s that are
> >> passed from one function to another.
> >> But this is rather code optimization and not really required to fix th=
e reported bug.
> >=20
> > Actually, doing so will break the TPM API. The function
> > tpm_tis_request_locality() is registered as the locality handler,
> > =C2=A0int (*request_locality)(struct tpm_chip *chip, int loc), in the t=
is
> > instance of struct tpm_class_ops{}. This is the API used by the Secure
> > Launch series to open Locality2 for the measurements it must record.
> >=20
>
> I dont understand this. How do you use locality 2 with the current mainli=
ne
> API? Do you adjust the mainline code to use locality 2 instead of 0? This=
 would=20
> at least explain how you ran into the underflow issue which from
> the source code seems to be impossible when using locality 0. But then I =
wonder why
> this has not been made clear in this discussion. And then we are talking
> about fixing a bug that does not even exist in the upstream code.=20

Thanks for bringing this up, now I finally figured out what confuses me
in this series.

Daniel, I also have troubles understanding why locality_count would ever
be greater than zero exactly in the mainline kernel, *without* [1]?

[1] https://lore.kernel.org/linux-integrity/20240214221847.2066632-1-ross.p=
hilipson@oracle.com/

BR, Jarkko

