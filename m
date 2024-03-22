Return-Path: <linux-kernel+bounces-111748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76687887059
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D28D28476C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB8456B88;
	Fri, 22 Mar 2024 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ci0SNXZT"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048693F9FE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123700; cv=none; b=tXnrvWdkYT0v5cuJECszID/SO6rKAk5z3QanvG2SVqjCD2aHqeoghXXrdt7ccvQXeAIhZsggZfClV6D5lyeeMlRbL+GOEoaK0sUu9TdKS0ZBf2NVmUwXG6LOn/7MChU+ub6+sMtDVm5GMDSH3Pg/PK423IuETfer16YA1SMMy3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123700; c=relaxed/simple;
	bh=3/6Da4L2XvBgOrqn3o2yIooO5dOpfLrZ+Qn1yLqGuXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GhwV1yyLEiPCZ3X8GgWSlNjQU1N+GmJDVefc8Uy9pwjHfWOvfZ/tAZyjtgWMIKRqhOwtsEGsFDNqd2e2N0MCCFeC31NxOcDwIQ+mfMk1KSQ2N4j6QK7MgwUiJHIQI1HsapTRbKORGynH2fRYvniVnsDAg6X6jD6snTHTbiVCrcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ci0SNXZT; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcc71031680so2096938276.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711123698; x=1711728498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9eILtcw8oTk3Qybv1w2ZrcCWh+mJFldW7WtpqQLPrI=;
        b=Ci0SNXZTMmNhnL9IMrRDEi6QNZxUfafBNFOGFzAB6asHh21td5H3msXkNTmRkXYpWb
         kviy+beLHh08mDntMUxTjAH0GBUR8iHVymSlwsR0j9LVNxsRPVYAprBcKYdmieVprWXS
         Sp2GY65JYt2L5AOynzv4iTMZqiMKP1gex2bxgf+VjZIyMtN9SpNeHCC5xCXC0xf1yJ0v
         K0JwAetj7oOKtPi9p10Pmj4Lr6EL0StCMzla7sM2yaSMz3ocH4M//AsxklWqMGspTbDu
         XaSKEQl6rqoRwEdaxWYcnDByimoiUN2Tz0S3ax6uUOEQNrIB62zJqJoX0+JrEKzRWih4
         FYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711123698; x=1711728498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9eILtcw8oTk3Qybv1w2ZrcCWh+mJFldW7WtpqQLPrI=;
        b=jpmxjAc8Cqmfdio9u1MeA542KATkf7kzAq5r4lZ2NbB25V0AIMkXhrvdWPQDq+aBJd
         XbHBLvBQWMzh+JxpRAAzwAbW3vwMmbcwAk3LllZEloarijHq5PyDvqsYEWkeWh81hCpF
         jG26CNvVABKo1D6xEA7dGqKh5ulQe+ObIVvzDUY3VFyGJZ4rxJ2PwOaeepXBbCJ9ll3f
         8tuKXX9nY2pTxuZrYJsMhlim/c421qQn0O0bdhvYMOXd8LDA5bpR4Yj2r4fgHFSWeL8x
         eMbFo/85o3KV6vy2QZCBSDKB002lfhjxbZoM6wlQGXQfkUa++oT5i8dyrEejdLuKlokw
         Qb5w==
X-Gm-Message-State: AOJu0YyReESHrP5QJccsa8iCqpqvGH/8FTnhIUHD1mxr/fASmP9q8RyV
	1WUhmSjEXTCPUYScHOeyPuZEi60AgwSok9vABLIz8NPjjMA2mE12nm2K9mu5ViUOQaCFgYab4FZ
	PMMpqhaLGoEzizutK5OBT6YDSkN4=
X-Google-Smtp-Source: AGHT+IEXsjgsXMjk9JvnFSugZIfF17hJqUykp/07AazIgCBi1mvYLWvG3p2t3OeVHjCToVyhoSbqY4In0cNaz5XpHPQ=
X-Received: by 2002:a25:df06:0:b0:dcb:ba75:bde7 with SMTP id
 w6-20020a25df06000000b00dcbba75bde7mr2585115ybg.7.1711123697948; Fri, 22 Mar
 2024 09:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315140433.1966543-1-hjl.tools@gmail.com> <5f0620c55a01d6a195154783a477ec295cbb4b1c.camel@intel.com>
 <CAMe9rOrgAtQvA=Tj0=T095JmdoRZ8pLuNOY3sT_RwwnznJN2Ow@mail.gmail.com>
 <7b341bef9c0cab324350873cab75b7e1313a5172.camel@intel.com>
 <CAMe9rOq9=7hS-Ohk+5kOnstp4tFFsAF11L=EKdTm+gUt97ugbg@mail.gmail.com> <95a27fd1e3b263d2b002c47751b1b42b3d639bae.camel@intel.com>
In-Reply-To: <95a27fd1e3b263d2b002c47751b1b42b3d639bae.camel@intel.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Fri, 22 Mar 2024 09:07:41 -0700
Message-ID: <CAMe9rOpO7=KL5XuvtR=cCSVatEsT5eFn7nuknRnDDQk9PbCb9w@mail.gmail.com>
Subject: Re: [PATCH] x86/shstk: Enable shadow stack for x32
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 8:58=E2=80=AFAM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Fri, 2024-03-22 at 08:06 -0700, H.J. Lu wrote:
> > On Fri, Mar 22, 2024 at 7:07=E2=80=AFAM Edgecombe, Rick P
> > <rick.p.edgecombe@intel.com> wrote:
> > >
> > > On Fri, 2024-03-15 at 07:34 -0700, H.J. Lu wrote:
> > > > > How many people do you think will use this?
> > >
> > > I'm concerned that the only use of this will ever be exercise via
> > > the
> > > glibc unit tests, but will still require work to support.
> >
> >  Correct.  A small glibc change is needed.  Will post it after
> > my kernel change is merged.
>
> I mean it will require kernel work in the future to maintain support.
> That we will have to think about x32 effects when making other shadow
> stack changes.

It is way more than kernel SHSTK self tests.

> I'll paste my other comment in this thread:
>
> The main usage of shadow stack is security, and comes with some
> overhead. IIUC the main usage of x32 is performance benchmarking type
> stuff. Why would someone want to use shadow stack and x32 together?

Improve x32 security and user space IBT will add more improvement.

> >
> >
> > > > >
> > > > > I would have thought it would require more changes for basic
> > > > > x32
> > > >
> > > > This is all needed.
> > > >
> > > > > operation. What was the testing exactly?
> > > >
> > > > I configured x32 glibc with --enable-cet, build glibc and
> > > > run all glibc tests with shadow stack enabled.  There are
> > > > no regressions.  I verified that shadow stack is enabled
> > > > via /proc/pid/status.
> > >
> > > The shadow stack is supposed to be mapped above 4G, so how is this
> > > supposed to work for x32?
> >
> > This is not what I see:
> >
> > (gdb) info reg
> > ...
> > pl3_ssp        0xf7dcbfe8          0xf7dcbfe8
>
> The mapping above 4G was because Peterz raised the possibility that a
> 64 bit process could far call into a 32 bit segment and start doing
> signal stuff that would encounter undefined behavior. He wanted it
> cleanly blocked. So by keeping the shadow stack above 4GB, existing
> processes that turned on shadow stack would be preventing from
> transitioning to 32 bit and encountering the missing 32 bit signal
> support (because the CPU would #GP during the 32 bit transition if SSP
> is above 4GB).
>
> Probably there is some interplay between the x32 mmap logic and shadow
> stacks mapping, where it then becomes possible to get below 4GB. Since
> x32 needs the shadow stack to be below 4GB, it's incompatible with that
> solution. So this patch is not sufficient to enable x32 without side
> effects that were previously considered bad.

Mapping shadow stack below 4GB on x32 still provides security improvements
over no show stack.

> I see this is in tip now. I don't think it's a good idea to support
> upstream. The implications need more discussion, and there doesn't seem
> to be any real end user value.



--=20
H.J.

