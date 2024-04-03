Return-Path: <linux-kernel+bounces-129356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A335D896965
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59911285DC5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300575FEE5;
	Wed,  3 Apr 2024 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTZgiFVj"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A01152F97;
	Wed,  3 Apr 2024 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133906; cv=none; b=qWd1FFmaj8M+KRWXbBZPswznBdANFnOBa5wvdfxiNaveNSS6nlp38cYFO0s798w8X0Y10l5ag9wlthMFBLGpr55CAJOOeB5XXR5skXoPfx/YxXWjKYuANzgLezi2lAu6Usd8Xt+3mOjbMheK5s8+T/7xcgyHdN+dInXduiqcvyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133906; c=relaxed/simple;
	bh=LiuEPSBbBZhjq99c5gnSda0jGuZJeU5oKE7nApE5nEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V7dUr26NCzAmO7bzPUpJ/Y7Mpfj3GSBU8tXfs2VmbzXuhL0hf++4gMS4RwnfD/EbpxbnCKdPCy2JSnFo5ypM+N1pb2Ws3sxYK+rltj8wNUpI5nwqs9viSCxZFsF68pHt8JMuiu3mBaL5SpzX9PGnADic5+L0RVPWrFOlto2KbsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTZgiFVj; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513e6777af4so10052304e87.2;
        Wed, 03 Apr 2024 01:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712133902; x=1712738702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWLSu4uzQTB9M/BAwKHtnLRv6ngDwtAIdk7qUH2kq2s=;
        b=KTZgiFVjVBCF+eGULCqT6XK0c5AqWnclgqmfEV7VjtgBmacpR5cOkvobdhp3QVzHS4
         qiqjKHOtyHwydROEjhBRMaQr1cow35H1y1T+EqRwgkIKdhY5tZ8P3Lhj8I7OCxx6h4+J
         nSSLx3xLN9Dztd91xb5pbbgaGnYozL/INukgzGyMp4A3LzlMo/WU19heDn4i0Zuxfmai
         iYTHA3OW8b11kTt0C/QIyWPgCoQ5tVPHeY0WWc1yPPpTaeZQ/vFZ2Pgdo82+Dk3o/EVZ
         WLIjxGrptcUew81UZTpZaQ2roJj412FwPr3qtrqRXsV8psq7vD+qYhQE91ZNRlxtvsWV
         8SDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712133902; x=1712738702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWLSu4uzQTB9M/BAwKHtnLRv6ngDwtAIdk7qUH2kq2s=;
        b=Uox4n1wx300wLsnyYB7hPQcLcKPvuLuBF0eUTlDl+s42BLOWZTbiNq6+BEx7cfWaPv
         2utOS2kcxqaJQ57yxqorOibqchjrBgL/uZQUYnmrgLD020aGMQ8HpYgawQ3D4uz3b7yA
         GVo7YSbPKEsxC1imQ4vGQvhVzoS1HKIU7rKS3iemxhAMDVXutiLtxSw3ANWxzdDQcZKP
         0ZGgFMece3WJBUML/yjxgwqE3e1kI1+u1B+kwhcLbHYWPfp3C32zTRQPNRgwZUM3plhO
         Ppo06vPETWdBTVH/DnE5RpmL8sV/aPM3N5LQ4+Xw9LV4GcJyCL/cfvwGG3OkYW7O/0yV
         pfuw==
X-Forwarded-Encrypted: i=1; AJvYcCXUQ76iLaFdiUTgRHAhdJM1GmBsJGSvYwjBWqQDA3jpCjPRn15EWI8U36LxqW8WL7z7kWb/Rd3r1o7qGThkJMoUhMKl4wMeEl8lQa/EgTyMqLKwDBm5YbVec8iRDqIWs3IX7Gsp2JbYP1BrgFhlU04tq4V6gsHZubgViCsYUinoNsiYdgo=
X-Gm-Message-State: AOJu0YySkK5Y0LfX1M31d0rnXb0z8giq5dS3A71WB9kttSwZE1BuwV3x
	qITPhJw3w6vYzpTulC409ar/DL7ovYdBuOiqMUqiRNneyv9oCpJkv1TvfuSVyIfXSxmggsEUfte
	A8cnKk2NugL/xgmgjRPZzQqjtIpY=
X-Google-Smtp-Source: AGHT+IFNFO+nOI8dNHsuG86TF8WKE282yu42b7vwXfmpSN4OtD3CKeAs1VM/dGBrbeOlOWtKoWF2x/h7W3HUWkzTwvk=
X-Received: by 2002:a05:6512:2813:b0:515:9c73:e29a with SMTP id
 cf19-20020a056512281300b005159c73e29amr4278680lfb.66.1712133902030; Wed, 03
 Apr 2024 01:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
 <20240323-pinctrl-scmi-v6-3-a895243257c0@nxp.com> <ZgcP4IkTQGks9ehH@surfacebook.localdomain>
 <DU0PR04MB9417E797F4E0F7BB6154B3BE88382@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Zgu4Tok43W5t8KM0@pluto> <CAHp75VdAaTeQ_Ag3gd0s9UfT=kAT2hwibeJ9-YFXJx4z=R3e+g@mail.gmail.com>
 <ZgwrKnx3hb59OG77@pluto> <CAHp75VeOB2_ivX5y8YfPEb64YUZBi+3U_1xUdjDVWzLiD=f+nw@mail.gmail.com>
 <Zg0N8S05D329BVjN@pluto>
In-Reply-To: <Zg0N8S05D329BVjN@pluto>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 3 Apr 2024 11:44:25 +0300
Message-ID: <CAHp75Vf+eVgTbemaE4az8s50GgrTyZ40Z=4BX46gseRTSyjzqg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 11:06=E2=80=AFAM Cristian Marussi
<cristian.marussi@arm.com> wrote:
> On Tue, Apr 02, 2024 at 07:39:44PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 2, 2024 at 6:58=E2=80=AFPM Cristian Marussi
> > <cristian.marussi@arm.com> wrote:
> > > On Tue, Apr 02, 2024 at 04:06:06PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Apr 2, 2024 at 10:48=E2=80=AFAM Cristian Marussi
> > > > <cristian.marussi@arm.com> wrote:
> > > > > On Sun, Mar 31, 2024 at 01:44:28PM +0000, Peng Fan wrote:
> > > > > > > Sat, Mar 23, 2024 at 08:15:16PM +0800, Peng Fan (OSS) kirjoit=
ti:

..

> > > > > > > > +#include <linux/module.h>
> > > > > > > > +#include <linux/scmi_protocol.h>
> > > > > > > > +#include <linux/slab.h>
> > > > > > >
> > > > > > > This is semi-random list of headers. Please, follow IWYU prin=
ciple (include
> > > > > > > what you use). There are a lot of inclusions I see missing (j=
ust in the context of
> > > > > > > this page I see bits.h, types.h, and  asm/byteorder.h).
> > > > > >
> > > > > > Is there any documentation about this requirement?
> > > > > > Some headers are already included by others.
> > > >
> > > > The documentation here is called "a common sense".
> > > > The C language is built like this and we expect that nobody will
> > > > invest into the dependency hell that we have already, that's why IW=
YU
> > > > principle, please follow it.
> > >
> > > Yes, but given that we have a growing number of SCMI protocols there =
is a
> > > common local protocols.h header to group all includes needed by any
> > > protocols: the idea behind this (and the devm_ saga down below) was t=
o ease
> > > development of protocols, since there are lots of them and growing, g=
iven
> > > the SCMI spec is extensible.
> >
> > Yes, and what you are effectively suggesting is: "Technical debt? Oh,
> > fine, we do not care!" This is not good. I'm in a long term of
> > cleaning up the dependency hell in the kernel (my main focus is
> > kernel.h for now) and I am talking from my experience. I do not like
> > what people are doing in 95% of the code, that's why I really want to
> > stop the bad practices as soon as possible.
>
> Not at all, the aim was exactly the opposite, avoiding that some protocol
> could have been written without all the needed includes: since a basic se=
t
> of headers is definitely common to any protocol you may think to write,
> grouping all there was meant to avoid this...I thought that by moving the
> problem away in one single internal common header was easier to monitor.

Which may or may not be okay. It plays too smart, so the end developer
won't care about real headers they need as they are the only ones who
know the source code in the best possible way.

> I certainly maybe wrong, but I dont see how you can deduce I dont care...

See above, the protocols.h it's a reincarnation (much less twisted and
ugly, though) of something like kernel.h. Do you know why we have a
split to headers instead of having everything in one? It speeds up a
build, it separates namespace (to the extent of what we call
"namespace" in C language), it makes the modularization (of the source
code) better (easier to avoid considering what's not needed), and so
on. I don't think making a "common" header is a good idea.

> ...and maybe, only maybe, what that 95% of people is trying to do in thei=
r
> horrible code is to deliver the best reasonably possible thing within the=
ir
> timeline while you are barking at them in chase of never to be released u=
tter
> perfection.

Yeah. That's why it's good to teach people about many aspects of the C
language (which is not popular, in particular due to these nuances,
nowadays and we are starving for good developers).

> > Last to add, but not least is that your code may be used as an example
> > for others, hence we really have to do our best in order to avoid bad
> > design, practices, and cargo cults. If this requires more refactoring
> > of the existing code, then do it sooner than later.

..

> > > > > Andy made (mostly) the same remarks on this same patch ~1-year ag=
o on
> > > > > this same patch while it was posted by Oleksii.
> > > > >
> > > > > And I told that time that most of the remarks around devm_ usage =
were
> > > > > wrong due to how the SCMI core handles protocol initialization (u=
sing a
> > > > > devres group transparently).
> > > > >
> > > > > This is what I answered that time.
> > > > >
> > > > > https://lore.kernel.org/linux-arm-kernel/ZJ78hBcjAhiU+ZBO@e120937=
-lin/#t
> > > > >
> > > > > I wont repeat myself, but, in a nutshell the memory allocation li=
ke it
> > > > > is now is fine: a bit happens via devm_ at protocol initializatio=
n, the
> > > > > other is doe via explicit kmalloc at runtime and freed via kfree =
at
> > > > > remove time (if needed...i.e. checking the present flag of some s=
tructs)
> > > >
> > > > This sounds like a mess. devm_ is expected to be used only for the
> > > > ->probe() stage, otherwise you may consider cleanup.h (__free() mac=
ro)
> > > > to have automatic free at the paths where memory is not needed.
> > >
> > > Indeed, this protocol_init code is called by the SCMI core once for a=
ll when
> > > an SCMI driver tries at first to use this specific protocol by 'getti=
ng' its
> > > protocol_ops, so it is indeed called inside the probe chain of the dr=
iver:
> > > at this point you *can* decide to use devres to allocate memory and b=
e assured
> > > that if the init fails, or when the driver cease to use this protocol=
 (calling
> > > its remove()) and no other driver is using it, all the stuff that hav=
e been
> > > allocated related to this protocol will be released by the core for y=
ou.
> > > (using an internal devres group)
> > >
> > > Without this you should handle manually all the deallocation manually=
 on
> > > the init error-paths AND also provide all the cleanup explicitly when
> > > the protocol is no more used by any driver (multiple users of the sam=
e
> > > protocol instance are possible)...for all protocols.
> >
> > Yes. Is it a problem?
>
> Well, no, but is it not a repetitive and error-prone process ?

Yes. That's why we now have cleanup.h. Please, consider using it instead.

> Is it not the exact reason why devres management exist in first place, to=
 avoid
> repetitive manual alloc/free of resources and related pitfalls ? (even th=
ough
> certainly it is normally used in a more conventional and straightforward =
way)

No. Its scope is to clean the probe-remove parts, one should not
spread it otherwise and one definitely should know its limitations and
corner cases (I even gave some examples back in ca. 2017 in one of my
presentation WRT typical mistakes the developers make

> The idea was to give some sort of aid in the SCMI stack for writing proto=
cols,
> so regarding mem_mgmt, I just built on top of devres facilities, not inve=
nted
> anything, to try to avoid repetitions and let the core handle mem allocs/=
free
> during the probe phases as much as possible: in pinctrl case would be
> particularly trivial to instead manually allocate stuff at init (due to m=
any
> lazy delayed allocations) but other protocols need a lot more to be done =
at init,
> frequently in a loop to allocate multiple resources descriptors, and manu=
ally
> undoing all of that on each error-path and on cleanup is definitely error=
-prone
> and a pain.

I understand the motivation, but again, devm is a beast in the corner
cases. I believe Laurent Pinchart gave a presentation about how bad
devm can hit you if you don't know what you are doing (OTOH it's hard
to know with devm).

> Last but not least, this whole thing was designed to address the needs of=
 the
> protocols that existed at that time....it is only now with pinctrl lazy-a=
llocations
> at runtime that the ugly cohexistence of devm_ and non-devm allocations b=
ecame a
> thing....so clearly the thing needs to be improved/rethinked...even dropp=
ed if no
> more fitting...
>
> ... or alternatively since devres allocations are anyway optional, you co=
uld just
> use regular kmalloc/kfree for this protocol and avoid this dual handling.=
.

Probably, just have a look at cleanup.h.

> ...this was just to put things in context...and I'll happily let Sudeep d=
ecide
> what he prefers in the immediate for pinctrl or more in general about all=
 the
> scmi devres, that I've got enough of these pleasant interactions for now.=
.

As I said, it's your call, I'm not preventing you from applying
whatever is going on in the SCMI subsystem. Just tried to point out
the problem(s).

--=20
With Best Regards,
Andy Shevchenko

