Return-Path: <linux-kernel+bounces-128362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ADF8959DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D127D1F234F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131B4159900;
	Tue,  2 Apr 2024 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNZdWuPr"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0D4132C38;
	Tue,  2 Apr 2024 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076025; cv=none; b=lTds23ClhCHuLEdUQZsV8821V6rOdwCH5ohU+gFj1avTV3osUbgK04wByA3yJptDMZrQnQ+c0G41UhtdolwMuTuwGFhKmDxbm1jNM1W/CP+6MnIGkytj/pwRsNqOC9ZJJ21WtWJn5UitlVbbE/hpEX4IBgAPLT2XC8PXiahiCJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076025; c=relaxed/simple;
	bh=bPzZAjPgb7YR2f8OiRfv2mTtF4c6m/IEuL2l7gAXHyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLse4Utm7lGjjwpvO5GnA825gFy6DRR/DFdiYhnRzR2xesitiJmdxT3kS5aX44A8p4bFXh/PtNhkDCFox6c6jAf0LuzYRut/p3Vw7q1icfisRGbigOUySvloyvfAoCst4Ss8HHJS7b1GPiJjHqodErIp+HAJiszw1Bv3oJVrq/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNZdWuPr; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d485886545so89305111fa.2;
        Tue, 02 Apr 2024 09:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076021; x=1712680821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeglKPkGssu647V9+AWVaK1QLXwREHb2PyTHNRkcVfU=;
        b=MNZdWuPr2zyoun6926avXxjtEHcQG1a/NRbVOYLjlULP8KNvjLBHBN1EFBxTVW802N
         PqdxbOLOQNC9wl3xBkpzSwOqdmposWUNoc/CBhN/NI30kP0OhMe/E8Ft06XE2qYlHDkF
         B4eer0yLTPQD7wCV5+GMSgd+fUpGCw4jKfT0K6VXfyFKWz8sRbErCR4locvwQYVfPWGe
         vqwjqcCpI3lrIct2Nv4Kts914Yc8rsdpZ7CvznoOXnBUTapDCprsl0BzHXDgkDfeAIaJ
         3ID+8YMfcfqiZ/RHB0k3W67jPGFOaCZSSuwzsHNhbdQAEAKR3VBmcuZkmPePQU9Ni+8l
         0Rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076021; x=1712680821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xeglKPkGssu647V9+AWVaK1QLXwREHb2PyTHNRkcVfU=;
        b=YZ2wT40601v/MnCGzFesWqCiJCcGBtr5urZMkeJpLQVcj3W8/zWY1k9zyYQzDTn2Sb
         USERhKuzL21fne/RC8ADYxv2bjGncgYCtSxtTIhSeWaemH73AXAOMYcn4kmSHxXW9exO
         jwfXbRsOuqEkKFwZ3g+u4aKZXUlNosFyuw5C77qZWWXSmyjYsVov5N38NWU8m40f006I
         KD17HkOKXWBozXYGNs/y78Hsw3nvCd0L1nm+QuhGSs3QtaWD4BQ6qPlCJaYAYuvidlMH
         T2w9X2rCDofuwNxWIz6H2+4m7+6XwZrEk76qm7SKeNVT/xZUJYwMYP83WmDBPaYd/Mi/
         WMcA==
X-Forwarded-Encrypted: i=1; AJvYcCW6zCV6TViiScf94WeuqpzgnFkhzZW5acRK2z7u9i+2q4M15U97+a/0KUhSsDXjfD1PTvkoeW6hJI/a2ZobKanTgLaW+S4qQ6LNJf9bnZ5fwuAmo4+V7zfOSHXWlmatjpVq1wA29GucZx1UCXLxh9vP5XXyeO+5kMwJSsSld+Pmibnntu8=
X-Gm-Message-State: AOJu0YzOBTsv3IBODKvvL9kHpdhDoZKJUeFdcVA5PVfTA3CBdNrfvL9I
	Llo/cVp9SSGvO3bJaShSdH5Wp8/LoT6GfcuF+MFK07GHNEwveBwW7nb9d9tJ1ACgrxtmquFBWBo
	KRSh/uWEBc67SgphngmjO+DLJ++4=
X-Google-Smtp-Source: AGHT+IGl+uNohAmGp7yty1Y/r35Wex0MlzIlU/dh6fUEpfO9UkK1JTZF2iD3j6JHceSsWZiSgmFGxtk1zREniCvtrzM=
X-Received: by 2002:a2e:a168:0:b0:2d8:d91:d77a with SMTP id
 u8-20020a2ea168000000b002d80d91d77amr2094457ljl.5.1712076020719; Tue, 02 Apr
 2024 09:40:20 -0700 (PDT)
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
 <ZgwrKnx3hb59OG77@pluto>
In-Reply-To: <ZgwrKnx3hb59OG77@pluto>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 Apr 2024 19:39:44 +0300
Message-ID: <CAHp75VeOB2_ivX5y8YfPEb64YUZBi+3U_1xUdjDVWzLiD=f+nw@mail.gmail.com>
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

On Tue, Apr 2, 2024 at 6:58=E2=80=AFPM Cristian Marussi
<cristian.marussi@arm.com> wrote:
> On Tue, Apr 02, 2024 at 04:06:06PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 2, 2024 at 10:48=E2=80=AFAM Cristian Marussi
> > <cristian.marussi@arm.com> wrote:
> > > On Sun, Mar 31, 2024 at 01:44:28PM +0000, Peng Fan wrote:
> > > > > Sat, Mar 23, 2024 at 08:15:16PM +0800, Peng Fan (OSS) kirjoitti:

..

> > > > > > +#include <linux/module.h>
> > > > > > +#include <linux/scmi_protocol.h>
> > > > > > +#include <linux/slab.h>
> > > > >
> > > > > This is semi-random list of headers. Please, follow IWYU principl=
e (include
> > > > > what you use). There are a lot of inclusions I see missing (just =
in the context of
> > > > > this page I see bits.h, types.h, and  asm/byteorder.h).
> > > >
> > > > Is there any documentation about this requirement?
> > > > Some headers are already included by others.
> >
> > The documentation here is called "a common sense".
> > The C language is built like this and we expect that nobody will
> > invest into the dependency hell that we have already, that's why IWYU
> > principle, please follow it.
>
> Yes, but given that we have a growing number of SCMI protocols there is a
> common local protocols.h header to group all includes needed by any
> protocols: the idea behind this (and the devm_ saga down below) was to ea=
se
> development of protocols, since there are lots of them and growing, given
> the SCMI spec is extensible.

Yes, and what you are effectively suggesting is: "Technical debt? Oh,
fine, we do not care!" This is not good. I'm in a long term of
cleaning up the dependency hell in the kernel (my main focus is
kernel.h for now) and I am talking from my experience. I do not like
what people are doing in 95% of the code, that's why I really want to
stop the bad practices as soon as possible.

Last to add, but not least is that your code may be used as an example
for others, hence we really have to do our best in order to avoid bad
design, practices, and cargo cults. If this requires more refactoring
of the existing code, then do it sooner than later.

..

> > > Andy made (mostly) the same remarks on this same patch ~1-year ago on
> > > this same patch while it was posted by Oleksii.
> > >
> > > And I told that time that most of the remarks around devm_ usage were
> > > wrong due to how the SCMI core handles protocol initialization (using=
 a
> > > devres group transparently).
> > >
> > > This is what I answered that time.
> > >
> > > https://lore.kernel.org/linux-arm-kernel/ZJ78hBcjAhiU+ZBO@e120937-lin=
/#t
> > >
> > > I wont repeat myself, but, in a nutshell the memory allocation like i=
t
> > > is now is fine: a bit happens via devm_ at protocol initialization, t=
he
> > > other is doe via explicit kmalloc at runtime and freed via kfree at
> > > remove time (if needed...i.e. checking the present flag of some struc=
ts)
> >
> > This sounds like a mess. devm_ is expected to be used only for the
> > ->probe() stage, otherwise you may consider cleanup.h (__free() macro)
> > to have automatic free at the paths where memory is not needed.
>
> Indeed, this protocol_init code is called by the SCMI core once for all w=
hen
> an SCMI driver tries at first to use this specific protocol by 'getting' =
its
> protocol_ops, so it is indeed called inside the probe chain of the driver=
:
> at this point you *can* decide to use devres to allocate memory and be as=
sured
> that if the init fails, or when the driver cease to use this protocol (ca=
lling
> its remove()) and no other driver is using it, all the stuff that have be=
en
> allocated related to this protocol will be released by the core for you.
> (using an internal devres group)
>
> Without this you should handle manually all the deallocation manually on
> the init error-paths AND also provide all the cleanup explicitly when
> the protocol is no more used by any driver (multiple users of the same
> protocol instance are possible)...for all protocols.

Yes. Is it a problem?

> This is/was handy since, till now, all the SCMI querying and resources
> allocation happened anyway all at once at init time...
>
> ...the mess, as you kindly called it, derives from the fact that this spe=
cific
> protocol is the first and only one that does NOT allocate all that it nee=
ds
> during the initialization (to minimize needless allocs for a lot of possi=
bly
> unused resources) and this lazy-initialization phase, done after init at =
runtime,
> must be handled manually since it cannot be managed by the devres group t=
hat is
> open/clsoed around init by the SCMI core.
>
> I dont like particularly this split allocation but it has a reason and an=
y
> other solution seems more messy to me at the moment.
>
> And I dont feel like changing all the SCMI protocol initialziation core c=
ode
> (that address a lot more under the hood) is a desirable solution to addre=
ss a
> non-existent problem really.
>
> > And the function naming doesn't suggest that you have a probe-remove
> > pair. Moreover, if the init-deinit part is called in the probe-remove,
> > the devm_ must not be mixed with non-devm ones, as it breaks the order
> > and leads to subtle mistakes.
>
> Initialization order is enforced by SCMI core like this:
>
>  @driver_probe->get_protocol_ops()
>   @core/get_protocol_ops
>      -> devres_group_open()
>      -> protocol_init->devm_*()
>      -> devres_group_close()
>      -> driver_probing
>
>    @runtime optional explicit_lazy_kmallocs inside the protocol
>
>  @driver_remove->put_protocol_ops()
>    @core/put_protocol_ops()
>      -> protocol_denit->optional_explicit_kfree_of_the_above
>      -> devres_group_release()
>    -> driver_removing
>
> ... dont think there's an ordering problem.

The mess with devm_ vs. non-devm is quite easy to achieve. You are
probably out of the control of what the protocol driver wants to do in
the init. Is the usage of devm (which APIs and in which order can be
used)  WRT SCMI documented somewhere?

Misuse of devm is a common issue, I'm not surprised it will hit your
subsystem one day with such an approach.

> ...note that the ph->dev provided in the protocol_init and used by devm_
> is NOT the dev of the SCMI driver probe/remove that uses the get_protocol=
_ops,
> it is an internal SCMI device associated with the core SCMI stack probing=
 and
> allocations, within which a devres group for the specific protocol is cre=
ated
> when that specific protocol is initialized...protocols are not fully
> fledged drivers are just bits of the SCMI stack that are initialized when=
 needed
> (and possibly also loaded when needed for vendor protocols) and
> de-initialzed when no more SCMI driver users exist for that protocol.

P.S. I guess from now on it's your call, but this code and in case
other drivers use similar, is badly written. I hope some documentation
exists to at least justify all this mess and explaining why there no
and (what's really important) will never be a problem.

--=20
With Best Regards,
Andy Shevchenko

