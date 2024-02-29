Return-Path: <linux-kernel+bounces-87058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4DF86CECE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3784B1F22164
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC98A14BD4F;
	Thu, 29 Feb 2024 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="bEv1V9xR"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2634C1361DF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223112; cv=none; b=kmmANSMW5CzMiMZr3pk9uvIA4kmvCZ5kSytAz8xM30DnPETLfzZX/UTcyED8rkebwGcpvjfaN85HyBpfHIqPDwjeeE2jZKhi0z49wtI14Cc+PsGt6CgGUZaeiZHExdM200XUdloU9qpfF5CuuEoJp29XmgBRyeJFQxmK47cbakc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223112; c=relaxed/simple;
	bh=PRvP/AE2jgDmBBLXF9/R3s6ZrxACG2eyhjflYyvi4c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YrUfRv3NfTdI9ypQ9NBvwzvkaebsWmPjYQDpHvjBKeiJLJjQ0AwqV+neEB+pO2Je8oOEIl9xRC9Wy/aXEykkacQLmXsHeef67RwFYicNtERJbRhxVHOfQJUKgQqumrUiYS0laNQT9zubQeC/s1fwl+aU5UQiGx6D9V+j3XqiyuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=bEv1V9xR; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E1B0B4070A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1709223107;
	bh=PRvP/AE2jgDmBBLXF9/R3s6ZrxACG2eyhjflYyvi4c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=bEv1V9xRuYXGfBI9ST22LLKz5GAOvH46UO74zlUICLsWj6l80pQywAYO9HBj244ko
	 bM4di2O2h7490PGdAPbgxtZYAaUyihD1N5kefovY1vsw19HKM5e0QjKH9jIKbHhjlS
	 1enGha4CkjeYyeo0OoQjFVTQCQngwlCSvP/BWcPew4l2e0DELGo6aCpqsgdZg58/UB
	 78kCsEdR9vEUtRd059B7xjLGJZglAoiu7LIdESRTJuniuDpprmaCnp0lOjbq7aLXae
	 i5tFX+gfKC+P9nQNxuTAJJ9JpID6JWMCSbAQsM9bjKiQOdXt5icjgspzchg7ndFlVe
	 SbfgP6rIGZGQA==
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5a04adc9c3fso1139168eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:11:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709223106; x=1709827906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRvP/AE2jgDmBBLXF9/R3s6ZrxACG2eyhjflYyvi4c4=;
        b=O1lX/fqIcSsImY93Z6jnIMApj34B7RD7vcWFIPhDB72DyeVJuAYbADSuMREmed/bQk
         e6E7sbj4j36fZkl59LpNgeuZbBOndkdhvAzE0ZJIH6nACU7G9YD1mWkS+UydZqGeaiWx
         OfxOU0JsfIDKkNoay6D++lsOLUFZCRmk30X7ZDMbETVNliCl0iOYyQhbdNAxtwmVy6hJ
         sqBOECmSxkDeZEHw+Pc9PfLoR7ddJ04WsF697em7CCx3XD2NMo9MJgnMrFY+sgUAJhBR
         asjws0N2GQPOU3YmqVl6bHWCYsKSY/l6ms2JtJnPb+MDvsIHLrPd/A04O9XlUSyyRziG
         dVmA==
X-Forwarded-Encrypted: i=1; AJvYcCUIxlpilYpdnO0jVcBq70t+WZxF0wW2ZS83ZrOGja0KWs/uDhDmgso9FYT25oQHx+f2LVScgodzb4a87x/Q5c0nf+gjbrH3uM724axA
X-Gm-Message-State: AOJu0Yw/lzqDqAGMroOfvCgYx+1kuy6ItN3VZnpyrLwe50lPmxriASMN
	QtmOx3BwHas5oiExH1jBXFoJShoTFVOIOtQ5sTGo+XyBsnZ5s+hNOGXpE5IePBKMIewPw8AY5XJ
	pGbC2imTzdtJW3YuHq6ROliJGyfXe+5tisNne4RzDHiy3xdKIsXmRVBXUQY0NOM8m8K8E3Lcaxa
	GyDXY81hzc5/ogdH/SfgG6LTwoMiZ3DjBOYwwOICiELVbMRWe7U9LZPTuHWHwXisw=
X-Received: by 2002:a05:6358:c87:b0:179:ff:2486 with SMTP id o7-20020a0563580c8700b0017900ff2486mr3218681rwj.29.1709223106440;
        Thu, 29 Feb 2024 08:11:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlA6u9Z7bK4Bo0CjsKePGPt3OWP6blInR4iHjL4WE6T4jPF7a1VHsRjNKbf3ENj2qHa9iYpHu7KXuOf4lnjrg=
X-Received: by 2002:a05:6358:c87:b0:179:ff:2486 with SMTP id
 o7-20020a0563580c8700b0017900ff2486mr3218660rwj.29.1709223106046; Thu, 29 Feb
 2024 08:11:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com>
 <20240222160915.315255-3-aleksandr.mikhalitsyn@canonical.com>
 <Zdd8MAJJD3M11yeR@tycho.pizza> <20240223-kantholz-knallen-558beba46c62@brauner>
 <ZdoEavHorDs3IlF5@tycho.pizza> <20240226-gestrafft-pastinaken-94ff0e993a51@brauner>
 <Zdyumw6OfWBqQMTj@tycho.pizza> <CAEivzxcVbEZtr+wPL1p+dM4r8+vFNnPoF+E-QvG_nLNHGDYJQg@mail.gmail.com>
In-Reply-To: <CAEivzxcVbEZtr+wPL1p+dM4r8+vFNnPoF+E-QvG_nLNHGDYJQg@mail.gmail.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Thu, 29 Feb 2024 17:11:34 +0100
Message-ID: <CAEivzxfOff_PrEfCmh_pJM4hm0PGVQjna4ucQi9_zKsaJPw42g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] tests/pid_namespace: add pid_max tests
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Christian Brauner <brauner@kernel.org>, stgraber@stgraber.org, cyphar@cyphar.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 4:14=E2=80=AFPM Aleksandr Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> On Mon, Feb 26, 2024 at 4:30=E2=80=AFPM Tycho Andersen <tycho@tycho.pizza=
> wrote:
> >
> > On Mon, Feb 26, 2024 at 09:57:47AM +0100, Christian Brauner wrote:
> > > > > > A small quibble, but I wonder about the semantics here. "You ca=
n write
> > > > > > whatever you want to this file, but we'll ignore it sometimes" =
seems
> > > > > > weird to me. What if someone (CRIU) wants to spawn a pid number=
ed 450
> > > > > > in this case? I suppose they read pid_max first, they'll be abl=
e to
> > > > > > tell it's impossible and can exit(1), but returning E2BIG from =
write()
> > > > > > might be more useful.
> > > > >
> > > > > That's a good idea. But it's a bit tricky. The straightforward th=
ing is
> > > > > to walk upwards through all ancestor pid namespaces and use the l=
owest
> > > > > pid_max value as the upper bound for the current pid namespace. T=
his
> > > > > will guarantee that you get an error when you try to write a valu=
e that
> > > > > you would't be able to create. The same logic should probably app=
ly to
> > > > > ns_last_pid as well.
> > > > >
> > > > > However, that still leaves cases where the current pid namespace =
writes
> > > > > a pid_max limit that is allowed (IOW, all ancestor pid namespaces=
 are
> > > > > above that limit.). But then immediately afterwards an ancestor p=
id
> > > > > namespace lowers the pid_max limit. So you can always end up in a
> > > > > scenario like this.
> > > >
> > > > I wonder if we can push edits down too? Or an render .effective fil=
e, like
> > >
> > > I don't think that works in the current design? The pid_max value is =
per
> > > struct pid_namespace. And while there is a 1:1 relationship between a
> > > child pid namespace to all of its ancestor pid namespaces there's a 1=
 to
> > > many relationship between a pid namespace and it's child pid namespac=
es.
> > > IOW, if you change pid_max in pidns_level_1 then you'd have to go
> > > through each of the child pid namespaces on pidns_level_2 which could=
 be
> > > thousands. So you could only do this lazily. IOW, compare and possibl=
y
> > > update the pid_max value of the child pid namespace everytime it's re=
ad
> > > or written. Maybe that .effective is the way to go; not sure right no=
w.
>
> Hi Tycho!
>
> >
> > I wonder then, does it make sense to implement this as a cgroup thing
> > instead, which is used to doing this kind of traversal?
> >
> > Or I suppose not, since the idea is to get legacy software that's
> > writing to pid_max to work?
>
> Yes, this is mostly for legacy software that expects host-like
> behavior in the container.
> I know that folks who work on running Android inside the container are
> very-very interested in this.

My colleague, Simon Fels, shared with me:
https://android.googlesource.com/platform/bionic.git/+/refs/heads/main/docs=
/32-bit-abi.md#is-too-small-for-large-pids

>
> Kind regards,
> Alex
>
> >
> > Tycho

