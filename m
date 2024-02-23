Return-Path: <linux-kernel+bounces-79143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842C2861E26
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02F81F21A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C85A1474A3;
	Fri, 23 Feb 2024 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kn6Q8OKE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C13612CD85;
	Fri, 23 Feb 2024 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721448; cv=none; b=s7VkKhfMUXaXhPIUe6qBeUNoqYCvS4Znbz5h5kY6cuZHwgkZiR6e5vEMONfOs7BdDEqbqquFzuGaY050JdHfnm/pTKDYEl9HxjeSvrsagQ0dQYHwu5ZjU7RJJmOVM+tBhWJUtcmYJIga15hgkGvuhpZDBPUygeriE7kKLlFmbiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721448; c=relaxed/simple;
	bh=PweppluXkvW8Lq4TMFJBzXOsYg6FGYfRiMivvD/uW4c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=MKpHXqG62x71Av1fSps0QHOYNgyQF3G4I1/IoBPX1k8HTGMlViNm5ux66uenfG3/XR+FbDS0LDOq/g9j3UHHOmmg1JEop9wvToAifha2hp+zYJ1KQasI6w5veeUNqJcr9VqsAV34sinA1mrBg1q7rBvorwYzmjPSt7CI2UKLWlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kn6Q8OKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F2CC433F1;
	Fri, 23 Feb 2024 20:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708721448;
	bh=PweppluXkvW8Lq4TMFJBzXOsYg6FGYfRiMivvD/uW4c=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Kn6Q8OKEAocDYsJkdulyJF53gQRvwhsW/5N4N8815Do4wwL1Nl7m/IZ0ar8j2yJbk
	 hE2w4nnWnSOmy4WOMRYi40GmSDx+s2lP0wXbcWl1eF988JSgprEWMJ8gXcBmxmMwhy
	 Wl/YLCyMDfIicd0AUmYEqdcd0oxwVgXJZ4vC+Kw3tZhxDJP+r5MBz/iuNx5NzvEc5F
	 69YrTeSrLAr7Mnx0tuRdB96jhbsOjmwGdQrIHOcG0taOlkXWmHZ3PV0hplj/fcbta2
	 LnuTn19vI9I+9zcZYf+RlhSrq/vhbkmzsOVQ8gpeYt6dMRb0FP72/MoZwcWZd9frT1
	 v8W/yehX/mz/A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 23 Feb 2024 22:50:43 +0200
Message-Id: <CZCR76MKS60B.UHM5MC0SBOQY@suppilovahvero>
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
 <CZA9CM3PDILC.82JMLUWMB6B7@seitikki> <CZA9GMC718HA.1JFHTTWV563IE@seitikki>
 <4bd31b91-1f6a-4081-9ad8-e5fae29d0dd7@apertussolutions.com>
In-Reply-To: <4bd31b91-1f6a-4081-9ad8-e5fae29d0dd7@apertussolutions.com>

On Fri Feb 23, 2024 at 3:57 AM EET, Daniel P. Smith wrote:
> On 2/20/24 17:31, Jarkko Sakkinen wrote:
> > On Tue Feb 20, 2024 at 10:26 PM UTC, Jarkko Sakkinen wrote:
> >> On Tue Feb 20, 2024 at 8:54 PM UTC, Lino Sanfilippo wrote:
> >>> for (i =3D 0; i <=3D MAX_LOCALITY; i++)
> >>> 	__tpm_tis_relinquish_locality(priv, i);
> >>
> >> I'm pretty unfamiliar with Intel TXT so asking a dummy question:
> >> if Intel TXT uses locality 2 I suppose we should not try to
> >> relinquish it, or?
> >>
> >> AFAIK, we don't have a symbol called MAX_LOCALITY.
> >=20
> > OK it was called TPM_MAX_LOCALITY :-) I had the patch set applied
> > in one branch but looked up with wrong symbol name.
> >=20
> > So I reformalize my question to two parts:
> >=20
> > 1. Why does TXT leave locality 2 open in the first place? I did
> >     not see explanation. Isn't this a bug in TXT?
>
> It does so because that is what the TCG D-RTM specification requires.=20
> See Section 5.3.4.10 of the TCG D-RTM specification[1], the first=20
> requirement is, "The DLME SHALL receive control with access to Locality 2=
"

From below also the locality enumeration would be good to have
documented (as a reminder).

>
> > 2. Because localities are not too useful these days given TPM2's
> >     policy mechanism I cannot recall out of top of my head can
> >     you have two localities open at same time. So what kind of
> >     conflict happens when you try to open locality 0 and have
> >     locality 2 open?
>
> I would disagree and would call your attention to the TCG's=20
> definition/motivation for localities, Section 3.2 of Client PTP=20
> specification[2].
>
> "=E2=80=9CLocality=E2=80=9D is an assertion to the TPM that a command=E2=
=80=99s source is=20
> associated with a particular component. Locality can be thought of as a=
=20
> hardware-based authorization. The TPM is not actually aware of the=20
> nature of the relationship between the locality and the component. The=20
> ability to reset and extend notwithstanding, it is important to note=20
> that, from a PCR =E2=80=9Cusage=E2=80=9D perspective, there is no hierarc=
hical=20
> relationship between different localities. The TPM simply enforces=20
> locality restrictions on TPM assets (such as PCR or SEALed blobs)."
>
> As stated, from the TPM specification perspective, it is not aware of=20
> this mapping to components and leaves it to the platform to enforce.

Yeah, TPM is a passive component, not active actor, in everything.

The way I see locality as way to separate e.g. kernel and user space
driver TPM transactions is pretty much like actor-dependent salt
(e.g. if 0 was for user space and 1 was for kernel).

>
> "The protection and separation of the localities (and therefore the=20
> association with the associated components) is entirely the=20
> responsibility of the platform components. Platform components,=20
> including the OS, may provide the separation of localities using=20
> protection mechanisms such as virtual memory or paging."
>
> The x86 manufactures opted to adopt the D-RTM specification which=20
> defines the components as follows:
>
> Locality 4: Usually associated with the CPU executing microcode. This is=
=20
> used to establish the Dynamic RTM.
> Locality 3: Auxiliary components. Use of this is optional and, if used,=
=20
> it is implementation dependent.
> Locality 2: Dynamically Launched OS (Dynamic OS) =E2=80=9Cruntime=E2=80=
=9D environment.
> Locality 1: An environment for use by the Dynamic OS.
> Locality 0: The Static RTM, its chain of trust and its environment.
>
> And the means to protect and separate those localities are encoded in=20
> the x86 chipset, i.e A D-RTM Event must be used to access any of the=20
> D-RTM Localities (Locality1 - Locality4).
>
> For Intel, Locality 4 can only be accessed when a dedicated signal=20
> between the CPU and the chipset is raised, thus only allowing the CPU to=
=20
> utilize Locality 4. The CPU will then close Locality 4, authenticate and=
=20
> give control to the ACM with access to Locality 3. When the ACM is=20
> complete, it will instruct the chipset to lock Locality 3 and give=20
> control to the DLME (MLE in Intel parlance) with Locality 2 open. It is=
=20
> up to the DLME, the Linux kernel in this case, to decide how to assign=20
> components to Locality 1 and 2.
>
> As to proposals to utilize localities by the Linux kernel, the only one=
=20
> I was aware of was dropped because they couldn't open the higher localiti=
es.
>
> I would also highlight that the D-RTM implementation guide for Arm=20
> allows for a hardware D-RTM event, which the vendor may choose to=20
> implement a hardware/CPU enforced access to TPM localities. Thus, the=20
> ability to support localities will also become a requirement for certain=
=20
> Arm CPUs.
>
> [1]=20
> https://trustedcomputinggroup.org/wp-content/uploads/TCG_D-RTM_Architectu=
re_v1-0_Published_06172013.pdf
> [2]=20
> https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-P=
latform-TPM-Profile-for-TPM-2p0-v1p05p_r14_pub.pdf

BR, Jarkko

