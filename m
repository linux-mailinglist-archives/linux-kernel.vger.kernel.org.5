Return-Path: <linux-kernel+bounces-32243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571EE835908
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF0728204C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 00:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F166376;
	Mon, 22 Jan 2024 00:56:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C06360;
	Mon, 22 Jan 2024 00:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705885013; cv=none; b=hpveTN8tvETpVHnQvll8UNWWO+UrUXFxNkTYtlIMJOBcCbNHoKS42ToGt83D7jBWZwrks4NwPqfSFRU6uajsDAdGrxEmmS3BACdtknBCT98j5d8pREPBFp8O1YNzUaDn2O5fcQnbUjUPII4FVRn40aul/Z8MHhTdZMzWUEc2JP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705885013; c=relaxed/simple;
	bh=PfuLQEs9jPY1A0Ncv4JftOLO3KUiPnkTqTfpYDXRRdw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dbv401INWTtvGuSMHe1+7VZfaa/sIP+b9Pt2VJvPmH0TLH0Irv9tn6IY349Tz/8MQgur//yKf9CnSBLoikxwMEQgKlihmSa6IessNtt61f6Kn2uHyuSvxEjIhtTFUTQevFc124ypyN6kV2izEFoBZSSTG3ryPNjMuJtpjefd2U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C1FC433F1;
	Mon, 22 Jan 2024 00:56:50 +0000 (UTC)
Date: Sun, 21 Jan 2024 19:56:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thorsten Glaser <tg@debian.org>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-toolchains@vger.kernel.org, jpoimboe@redhat.com,
 alexei.starovoitov@gmail.com, mhiramat@kernel.org
Subject: Re: [PATCH 1/2] x86: Remove dynamic NOP selection
Message-ID: <20240121195649.7355e1d5@rorschach.local.home>
In-Reply-To: <20B57BDC-9A3F-4B02-9BA9-41477088A6CE@zytor.com>
References: <20210312113253.305040674@infradead.org>
	<20210312115749.065275711@infradead.org>
	<Pine.BSM.4.64L.2401200654480.19429@herc.mirbsd.org>
	<CE53F232-3D2D-4910-94B4-A4304F5990C7@zytor.com>
	<Pine.BSM.4.64L.2401201652490.29203@herc.mirbsd.org>
	<d23e1b70-7ac3-49cd-8d5f-1dedc0108603@zytor.com>
	<Pine.BSM.4.64L.2401212356390.999@herc.mirbsd.org>
	<20B57BDC-9A3F-4B02-9BA9-41477088A6CE@zytor.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 21 Jan 2024 16:15:57 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

> On January 21, 2024 3:58:11 PM PST, Thorsten Glaser <tg@debian.org> wrote:
> >H. Peter Anvin dixit:
> > =20
> >> But yes, with all even remotely recent CPUs all actually handling nopl
> >> properly, this isn't relevant anymore. =20
> >
> >This was, incidentally, triggered by looking into a problem report that
> >something did *not* work on a Geode LX system.

What problem happened?

> >
> >People don=E2=80=99t just run Linux on =E2=80=9Crecent CPUs=E2=80=9D (th=
ough I at least got me
> >an Atom and a Core2Duo for it and run BSD on my Pentium-M and VIA C7
> >systems).
> >
> >bye,
> >//mirabilos =20
>=20
> Yes, but it is a matter of where we optimize for performance as opposed t=
o correctness.

There is no such thing as "optimize for correctness", it is either
correct or it is not. Correctness should always come before performance
(at least that is what Thomas has pounded into me ;-)

If a kernel use to work on a machine but a newer version no longer
works, I call that a regression.

-- Steve

