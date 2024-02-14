Return-Path: <linux-kernel+bounces-64708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1CB8541C6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E556D28B445
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28352B66B;
	Wed, 14 Feb 2024 03:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fKl2EIOp"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F137945A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 03:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707881358; cv=none; b=o9KHz+i2FlOzW+aFEESN1+/nTUOM8Ags3+VIxVKBAk/moO60lRtXPQehIi7QucjTlSjw3yhq2/Ejnxf82AhV3zjNi0yAiLWsqsXkQzJVYKRRbZlLuhiwSavYGelA5wq90tLR13RSS9EBoFZzUzyewUfxKSYL/Pe8eTEsoCMMedg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707881358; c=relaxed/simple;
	bh=uQ9lj8YmsGd2m3HSYfn58m69JIvnSWjra9sGbJgUSQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gy6ct8a5V6Xepx7OgExTJSIdX7bBPQGJTT5pLkIEQVUj2SvxTz0Yv0V1nCExCFNWrfJtJguLQEOLh0sM4JaFU0QR8sX9wtPszjAO7yIP0hl9dRvcAj55LWY+HjHU0Me0vnCWQsA2sWBzSAz9sGq8x2oRHLgVauXj3VDW/3ZdAE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fKl2EIOp; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-428405a0205so575551cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 19:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707881355; x=1708486155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEpPY5pRAKDFBbmEO202dbr7ZJfJqmGAy9ZnyjZq7WI=;
        b=fKl2EIOpcxtU0n+DatCIzed9OiGyWILYBSa/8hd15uxPJ/ormoeUtTUgKnzZnGXBxS
         k+8wGMPaAR8OdRqHtaZMc5m9G6J8P4lQkI/BiYRGtKKFC/rZkKNgo7G3lLd1Fdl+LFCD
         C2C0LVr+C97CBriOB0kayAYzzRFjcv7j5+SLp5C4OQdtvK4jcgPg5CRYLLfnssawCQei
         o30Z+5RtdLJ10Scrjcut0VD9zcuvflr/t/7Kx6F9kvGmfgrEtzlTJbKeeJ4VWI6Qwkp5
         7Jqt/01/uQHXuF6d/SEEFxEpW1vsMkU0ceUwDfVgDL6afG9u0gBY376Om7joIitxh/EV
         2LCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707881355; x=1708486155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEpPY5pRAKDFBbmEO202dbr7ZJfJqmGAy9ZnyjZq7WI=;
        b=vb7qSADzYFV4vBVvxsfQtXGRvEfXOICU1gf8Bvkt3aIZyGGglkh/G2GLJ7hUkEmazk
         /qo6NsUvrei3w3F4i/V9121XQrCiqCOLuLrQgv0WWB7albWrq34aPKpiWaDY+IeBtSQ9
         VN1kgMPyz4I3TPvFL6WDxAGuEpEn8jVo+flzbDF0KD3J8/UbuWvc0PH2z4RICBnWytH0
         DEzK0V0jWDcHSVPBe9wg1Rbj6neyiU6eW0b4+VKKcPLaa5wZoOAeGAN10Fu1q2ELkI+n
         a5UfeoVhbvdzzrp3GznX5c40zR4hkxGeck7BbeXOtAOqO3mYQrnfj8cogIi3tc8DNcla
         cn9A==
X-Forwarded-Encrypted: i=1; AJvYcCXRYn/FCPUb2UXJUxyYdwMkoPnxpij34FH/SjrrvWFeKrZRi+ZGq+T2szzOWa8UC7mK7/ROvhr1aBPJs7FgB/+Pied87ae179+Wk0fM
X-Gm-Message-State: AOJu0YwDXXIooV3oHLSiBGfpOiApGahUrl+JldzNpufOwSYO5JnYGnPN
	j88p7WRChGGtpMTRB+arWQqa1VAMWyVi+YlH9aDwVxBela7sHoZrkTnfM5WtY7yDMgJrjSmZP+E
	BLeb32s71UTuGr/Ochz92mzauk8SPYJsxUhDE
X-Google-Smtp-Source: AGHT+IEGinB5yJc+8L21uHOW4Lfff3h4LeG46EUoXKaXv9FaBM1ND/dLM4MEtlY6evLI45L9Fg80+59JFqEwzCWojXE=
X-Received: by 2002:ac8:5dce:0:b0:42d:b492:868f with SMTP id
 e14-20020ac85dce000000b0042db492868fmr196989qtx.24.1707881354884; Tue, 13 Feb
 2024 19:29:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123014517.5787-1-mcpratt@pm.me> <CAGETcx_CqcHhKCXrUQOOnrr9Ke=dJRcJGTGxrdbPxnDOG1Xrbw@mail.gmail.com>
In-Reply-To: <CAGETcx_CqcHhKCXrUQOOnrr9Ke=dJRcJGTGxrdbPxnDOG1Xrbw@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 13 Feb 2024 19:28:35 -0800
Message-ID: <CAGETcx_kH1Z7YuciybYac+q5qpA3EQb+7q77vx5OV+dk8_uwCQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] fw_devlink: generically handle bad links to child fwnodes
To: Michael Pratt <mcpratt@pm.me>
Cc: devicetree@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
	abel.vesa@linaro.org, alexander.stein@ew.tq-group.com, 
	andriy.shevchenko@linux.intel.com, bigunclemax@gmail.com, brgl@bgdev.pl, 
	colin.foster@in-advantage.com, djrscally@gmail.com, 
	dmitry.baryshkov@linaro.org, festevam@gmail.com, fido_max@inbox.ru, 
	frowand.list@gmail.com, geert@linux-m68k.org, heikki.krogerus@linux.intel.com, 
	kernel@pengutronix.de, linus.walleij@linaro.org, linux@roeck-us.net, 
	luca.weiss@fairphone.com, magnus.damm@gmail.com, martin.kepplinger@puri.sm, 
	miquel.raynal@bootlin.com, rafal@milecki.pl, ansuelsmth@gmail.com, 
	richard@nod.at, sakari.ailus@linux.intel.com, sudeep.holla@arm.com, 
	tglx@linutronix.de, tony@atomide.com, vigneshr@ti.com, dianders@chromium.org, 
	jpb@kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 12:06=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Mon, Jan 22, 2024 at 5:46=E2=80=AFPM Michael Pratt <mcpratt@pm.me> wro=
te:
> >
> > Hi all,
> >
> > First off, if you are CC'ed here, it's likely because you were
> > involved in or CC'ed in a patch series by Saravana Kannan for fw_devlin=
k,
> > and for consistency, I'm kindly asking for review from you all as well.
> > If you think this may not affect your use cases, feel free to ignore th=
is.
> > I'm also CC'ing Christian and Rafal from the Openwrt project.
> >
> > This series is following up on some excellent work from Saravana [1]
> > which is another patch series that includes some changes
> > that helped make it possible for fw_devlink to work with MTD partitions
> > that are a supplier fwnode by being a NVMEM provider. For an MTD partit=
ion
> > to become an NVMEM provider, it must be registered as a platform device
> > using of_platform_populate() or similar function
> > which was done in a previous commit [2]
> > but this also resulted in fw_devlink to apply
> > to those fwnodes and their child fwnodes.
> >
> > That regression caused consumer devices to defer indefinitely
> > while waiting for probing that will never happen or for device links
> > to form from fwnode links with fwnodes that are not associated
> > with any real device or driver that probes
> > (e.g. describing the location of a MAC address).
> >
> > Saravana's patch series helped in two ways:
> > First, by moving consumers from a child fwnode (in this case,
> > the "nvmem-cells" compatible node) to an ancestor fwnode
> > that represents the actual supplier device when that device probes,
> > which handles the case where
> > the supplier device has a probe attempt first. [3] [4]
> > And secondly, by specifically marking "nvmem-cells" compatible nodes
> > as populated during MTD partition parsing which also occurs during
> > the supplier device probe, which handles both cases of initial probe or=
der,
> > but only for that node type. [5]
> >
> > However, there's some drawbacks to the second solution
>
> Oh, somehow missed this thread entirely until it saw some activity today.
>
> > from having to manually name which nodes need the workaround
> > for the corner case with the compatible string.
> > Most notably, that it's possible for this corner case
> > to apply to other nodes types, but also the fact that initial probe ord=
er
> > deciding whether or not everything probes in the intended order, if at =
all,
> > through driver core alone is still an issue with fw_devlink,
> > despite the fact that controlling probe order in driver core
> > is one of it's goals. In other words, the real problem is in driver cor=
e,
> > but the fix is in the mtd driver.
>
> It's been a while since I looked at MTD code, but the real problem is
> not in driver core, but how it's used incorrectly by the MTD/nvmem
> frameworks. Adding devices to a bus that'll never probe is wrong. I
> think there's also a case of two devices being created off the same DT
> node. While not technically wrong, it's weird when one of them never
> probes.
>
> I'll take a closer look and respond to this series later. Hopefully
> this week, but if not, then next week.
>
> As I said in the other patch, I don't like the series in the current
> form because it's changing APIs in not so great ways.
>
> fwnode_link_add() is supposed to be super dumb and simple. It's
> literally there just to avoid reparsing DT nodes multiple times.
> Nothing more ever. It just denotes the "pointers" between fwnode or DT
> nodes.
>
> The "smarts" should either be where fwnode links are converted into
> device links (and not have to fix them up) or where nvmem-cells is
> being parsed and converted to fwnode links.
>
> As I said in the other patch, let me take a closer look this week or
> next and get back. These things needs several hours of uninterrupted
> time for me to debug and unwind.

As promised, I took a closer look and left some comments in Patch 1
and 2. Patch 1 is 100% broken/wrong so the series will not be
accepted.

Just for the sake of understanding, can you send a patch that'll add
these additional compatible strings similar to how I handled
nvmem-cells and show my how much worse it is than this series?

>
> >
> > Unfortunately, with the Openwrt project
> > we are experiencing this regression again
> > by implementing the new NVMEM layout "fixed-layout"
> > after it was accepted into the kernel. [6]
> > This causes some subsystems of an SOC, like
> > ethernet or wireless or both depending on hardware and DTS,
> > and in some cases a completely different function like USB
> > to never probe once again, and the temporary fix, like before,
> > is by disabling fw_devlink. [7]
> >
> > Below is a simplified DTS of an Atheros device with the NVMEM layout:
> >
> >
> > &eth0 {
> >         nvmem-cells =3D <&macaddr_art_0>;
> >         nvmem-cell-names =3D "mac-address";
> > };
> >
> > &wifi {
> >         nvmem-cells =3D <&caldata_art_1000>;
> >         nvmem-cell-names =3D "calibration";
> > };
> >
> > &spi {
> >         status =3D "okay";
> >
> >         flash@0 {
> >                 compatible =3D "jedec,spi-nor";
> >
> >                 partitions {
> >                         compatible =3D "fixed-partitions";
> >
> >                         partition@ff0000 {
> >                                 label =3D "art";
> >                                 reg =3D <0xff0000 0x010000>;
> >                                 read-only;
> >
> >                                 nvmem-layout {
> >                                         compatible =3D "fixed-layout";
> >
> >                                         macaddr_art_0: macaddr@0 {
> >                                                 reg =3D <0x0 0x6>;
> >                                         };
> >
> >                                         caldata_art_1000: caldata@1000 =
{
> >                                                 reg =3D <0x1000 0x440>;
> >                                         };
> >                                 };
> >                         };
> >                 };
> >         };
> > };

In this example, can you walk me through the probe attempts/successes
of the nvmem supplier and it's consumers and at what point does
fw_devlink makes the wrong decision? You also said fw_devlink depends
on the order in which devices probe to work correctly. This is
definitely not the case/intention. So, if you can show me an example
of that, I'll fix that too.

I'm fairly certain this example will end up being a case of the nvmem
framework creating pointless devices or using a "bus" when it needs a
"class". But I don't want to assume.

I'm asking all these question to understand your case better and maybe
suggest a better fix that doesn't break fw_devlink or effectively
disable it.

Thanks,
Saravana

> >
> >
> > When the DTS is written this way, not only is there a different node
> > involved for NVMEM, but this node is a new node that is yet another
> > descendant in the tree. In other words, the "partition@ff0000" node
> > used to be what designated this device as the NVMEM provider
> > with the "nvmem-cells" compatible, so the node that represents
> > the actual probing device is now 4 parent nodes up in the tree
> > in this example instead of 3 parent nodes up in the tree as before.
> >
> > For the past year, and even before the "fixed-layout" issue came up,
> > I had been experimenting with a way to handle these reverse probe order
> > and linking of distant descendant node issues in a generic way instead =
of
> > naming exceptions with the compatible string, and this series is the
> > culmination of those efforts. It may look strange at first,
> > but there are a myriad set of cases to handle and other reasons
> > that led me to develop this approach of using existing bad device links
> > in order to find the correct fwnode to link to, and then redo
> > the relevant links for that consumer device altogether.
> > I'm concerned that doing this another way would be a much more massive
> > project that would basically rewrite what the fw_devlink feature does.
> > Or perhaps there would have to be a new, third form of device links
> > that would be a "placeholder" before it becomes a fwnode link.
> > Eventually, I came to the conclusion that
> > there simply is not enough information to form the correct fwnode link
> > before the real supplier device has a successful probe.
> >
> > Some of the changes proposed here are made on the extreme side of cauti=
on,
> > for example, checking for null dereference when it might not be necessa=
ry,
> > and reducing the activity of some functions in order to reduce
> > the amount of assumptions taking place in the middle of driver core
> > in cases where the new functions proposed here handles that just as wel=
l
> > and closer to a possible probe defer event
> > (e.g. not declaring a fwnode as NOT_DEVICE before
> > a probe attempt is expected to have happened).
> >
> > I have tried to make the commit messages as self-explanatory as I can,
> > but they might have ended up a little too verbose, and therefore confus=
ing
> > but I'm ready to explain whatever has not been explained well already.
> > Lastly, this is my first attempt at sending a larger change to the kern=
el,
> > so I appreciate your time and patience very much.
> >
> > MCP
> >
> >
> > [1] https://lore.kernel.org/lkml/20230207014207.1678715-1-saravanak@goo=
gle.com/
> >
> > [2] bcdf0315a61a29eb753a607d3a85a4032de72d94
> >
> > [3] 3a2dbc510c437ca392516b0105bad8e7970e6614
> >
> > [4] 411c0d58ca6faa9bc4b9f5382118a31c7bb92a6f
> >
> > [5] fb42378dcc7f247df56f0ecddfdae85487495fbc
> >
> > [6] 27f699e578b1a72df89dfa3bc42e093a01dc8d10
> >
> > [7] https://github.com/openwrt/openwrt/commit/703d667a0cdf6dfa402c08e72=
d0c77a257ca5009
> >
> >
> > Michael Pratt (4):
> >   driver core: fw_devlink: Use driver to determine probe ability
> >   driver core: fw_devlink: Link to supplier ancestor if no device
> >   driver core: fw_devlink: Add function device_links_fixup_suppliers()
> >   mtd: mtdpart: Allow fwnode links to NVMEM compatible fwnodes
> >
> >  drivers/base/base.h    |   1 +
> >  drivers/base/core.c    | 144 ++++++++++++++++++++++++++++++++++++++---
> >  drivers/base/dd.c      |   2 +
> >  drivers/mtd/mtdpart.c  |  10 ---
> >  include/linux/fwnode.h |   4 ++
> >  5 files changed, 143 insertions(+), 18 deletions(-)
> >
> >
> > base-commit: b0d326da462e20285236e11e4cbc32085de9f363
> > --
> > 2.30.2
> >
> >

