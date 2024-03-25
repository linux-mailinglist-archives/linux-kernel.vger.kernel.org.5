Return-Path: <linux-kernel+bounces-117568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E35BE88ACB2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D601C3D496
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D04257337;
	Mon, 25 Mar 2024 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YemJ7wqK"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFA453387;
	Mon, 25 Mar 2024 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387189; cv=none; b=Aqx01WktuHRrBWDmPcPsSSbMflHtBbWentjgCnlt+KMwbm0FL8pMs35BBwHcTm7BFzERRV0puGmr5hUg0oDc7tjhJvU4+iKmHPd38Spd4N9rIeo0nKt2zmLLXbf31uF3ZoI80FPSVGUoHvHONX1ZBvh29/v8CtneMUDLeal4jTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387189; c=relaxed/simple;
	bh=75ihyrm2v0POCpOny14EBcy365OwfYgPNoejpuqAQ08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6xbSbUPyV9eZzgOx9+wZIuEZZStNCQ94GAbEZRsfxmy+2o0CkSPo26F1hOrGedwCB5oLaNv+oMNKEV7VtitSDl2lpjQbWFyi7Hqj6XwwhVfu9SNwEunyLDMkMxHUadKpbPSH21p0Z3d31mb2KPznxbeMHASzB9aGr8H9F3kfM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YemJ7wqK; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56bf6418434so2733227a12.0;
        Mon, 25 Mar 2024 10:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711387187; x=1711991987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75ihyrm2v0POCpOny14EBcy365OwfYgPNoejpuqAQ08=;
        b=YemJ7wqK8p0gAwl7EGPnO4/6aOD74US5F/2KLM6UA4H/8N42BMTjmYc2ioG9TcWHV/
         JhEhgGAvQO9/X5sUoPG5u1NvMzLzKA4buAwcpBvVArSfTqINEhVB/phZS2EYjXcXK8R9
         4yOjvaMNOWwJvbLZAN7Z3WYkuiDfNYyEE5yzXx+N1A4jjPQqRkR2fwoQ4z2d5PstLo1f
         Amz8G5LqRA9pZpXYc2sBW2BrnXmgcCH6WmHljNGdTaeD0DW+0Q5UsrVOGV42koTAQZz5
         HkuuNXMX7ebiWHB66XEtXPthxCNJcWeuZ0Vmj+0nImkci64MwcNWVbI4jrbufTfIWc/c
         sx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387187; x=1711991987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75ihyrm2v0POCpOny14EBcy365OwfYgPNoejpuqAQ08=;
        b=UmHHF6JGVwDjn64xWdY+lJEK5aKkPfi0Ns/AoDkbJ9npYsja4YKAKMVrrHA17a+ieA
         RlYidGTV63bXgwLA3RP4iUtISPLqjynl1/94GAdOsymjDeyZY/NIkIL1uqTErZheT3tI
         PI4gkSxfPhfjhi8TyQe7FQBZ+ubHMOJbc8OYIaKamWiXIXxw8mtd2ta6raG2ClwmQZVr
         TzIPcPYPtS02yqDcMQzzLVkzE3LL2wOX1rLq7wCHuj/AVsczrpfEZLCz4nDmreZxM1BT
         Qge8mZ0bBLKkLvGnqWykIxKONpmnOlnEWLdypOQxhXq9MsOveXsNvpCjPjvScyOEtkvP
         /koA==
X-Forwarded-Encrypted: i=1; AJvYcCUrnDh0PfBaOSd3rO8KmtNvAk+DrS6yaYOzuSVhnC+pptKRDObjT3rKC2YBq38RFypuRy+xf076KECk5EgQnKB0dN3w1gKP1dTpuCx1bv4AGG/Q+JNAHvQ4w/HcOXxf7B5g4B4utPBrPA==
X-Gm-Message-State: AOJu0YwBPedPP+LfScpMejUqGgHbD5e9VFidhvDF3C7RsQG9jx2uUsWj
	g3vGQb/bG514O9VHeecfduXa8ocDR6IKfP3Jyw3j9qc1qotexlH7q8lDIqu2OFKDSnTuBUIM/46
	mq/3cHZhI68JcaJZQNJblJDMiEl8=
X-Google-Smtp-Source: AGHT+IG6eOGseMTCjzeAv3soMifKZSfo1+beNKC6+feU9hC2xfExTJZe2LW52tp1M3FwcaOi8a0vLvdYtM6AlLDH48k=
X-Received: by 2002:a17:906:3650:b0:a46:8c03:b659 with SMTP id
 r16-20020a170906365000b00a468c03b659mr5122572ejb.42.1711387186608; Mon, 25
 Mar 2024 10:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322073725.3338266-1-peng.fan@oss.nxp.com>
 <CAHp75Vds1dmjbaDa0D+Xxoyt_9CgHhoS2j0cR3EQdMp3sbwg5g@mail.gmail.com>
 <CAMRc=McYbsd8t1_6PDypGBme2OSyvy8erdjR51cUzVhM-qQXZg@mail.gmail.com>
 <ZgGfgY2hITq_MDvl@smile.fi.intel.com> <CAMRc=Mec5DSegEJHf5khj5ksCE3+SjQoq6vwRPEdnS7arawz4A@mail.gmail.com>
In-Reply-To: <CAMRc=Mec5DSegEJHf5khj5ksCE3+SjQoq6vwRPEdnS7arawz4A@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 25 Mar 2024 19:19:09 +0200
Message-ID: <CAHp75Ve3wYHf2Kp+r1s-9KcQSbYJ2RCSxugBWDxMr_PC4DrL=w@mail.gmail.com>
Subject: Re: [PATCH V3] gpiolib: use dev_err() when gpiod_configure_flags failed
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, linus.walleij@linaro.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 6:24=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
> On Mon, Mar 25, 2024 at 5:00=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Mon, Mar 25, 2024 at 04:48:27PM +0100, Bartosz Golaszewski wrote:
> > > On Fri, Mar 22, 2024 at 4:59=E2=80=AFPM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Fri, Mar 22, 2024 at 9:29=E2=80=AFAM Peng Fan (OSS) <peng.fan@os=
s.nxp.com> wrote:

..

> > > > Bart, are you aware that this will add yet another possibility of
> > > > scary '(null)' in the error level, which is much likely visible to =
the
> > > > end users?
> > > >
> > > > I propose to apply my fix first to avoid this happening.
> > > > 20240320165930.1182653-1-andriy.shevchenko@linux.intel.com
> > >
> > > I think you meant the v2[1]?
> >
> > Yes!
> >
> > > And sure, I will pick it up shortly.
> >
> > Thank you!
> >
> > > [1] https://lore.kernel.org/lkml/20240320165930.1182653-1-andriy.shev=
chenko@linux.intel.com/T/
> >
> > I can update this patch (rebase it on top) if needed to make less burde=
n on
> > the author's shoulders. Just tell me.
>
> Sure, if you can resend both yours and this one then even better.

Just sent both as v4.

--=20
With Best Regards,
Andy Shevchenko

