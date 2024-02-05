Return-Path: <linux-kernel+bounces-53893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CA284A7C5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154691C279E3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF6612C521;
	Mon,  5 Feb 2024 20:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOdvYgrW"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC8212D176
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 20:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163662; cv=none; b=G0LGHWMl+K8yM++KvbZbWbRWyRPIr8bfUA9Jfw0BIFd0ZjXmsabi8Qz1FG5qmq2Jk26N68WNlmqUpioXyCfAIhkfrin/hm0BFplC4MC1Feu2QD4krJWifnTACjBNULcL/9jBt9ap3NCjetlrlRetFDWS5x5eDQpIYJn6w708p+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163662; c=relaxed/simple;
	bh=t+OWdkJeuTSzV7PfUKGuV8pMc8lLvcRHZHwYfoQy/rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaDuNSa9Wf3z/Yyj0mVhykHvl8jkZ14kOVqqG3sRCHS1E+6LUd0B3qir7B2ecir2ew46x1iKmEuR5oSdOCoQEFmsBNEV4+s+tVd5rjWWQOZ0Zki5M3tL2VyM+HGFkxmj1xoCbRy1yQpoK8k1WPbMdCGD0KXNLui12cjGe6N14Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OOdvYgrW; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56012eeb755so4474a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 12:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707163658; x=1707768458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/ytStma+6/0t08q40U5JkmfQ9oxJWuzOyYAlQ2Q6ac=;
        b=OOdvYgrWjdI2FgTN17algMEKHIoeplEtxaOXPXtGRHOyG6lYCTC2r9nJEpFkRRzbZz
         cGoGJkasiGSCmOAuHkN+zhI+OMStM24ZcACsLLuhwnoEZ7Q1GxuRaaJ3WXj3zlYejJDI
         sqnfSsJDko8WIiWcSHiAUPYQokLUyhVvwsCVZkFZNfYXL7bwKHOYo5F0shwDJNMgHxf+
         xnlzhP01SKsGXaRMQdJEUOa2FnqOIEvuMa4jh6qB9yiHsDFv5rlnAC4Jz+qLohv4U+Pj
         Xxn2XVfPvwEgy9BMrY0j3LxHuZVQNwjy50L9d1h7ZXjJ9EXT5nMBhcws+pnWxh1r/asC
         +fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707163658; x=1707768458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/ytStma+6/0t08q40U5JkmfQ9oxJWuzOyYAlQ2Q6ac=;
        b=iiLhZHChFVvS99coISUiCvcpyFNicu4N/IZ84HxhWH73BCUfjdrNdoQIZn/mRPX343
         PkNPcSLig/mgKqzDjxEMCrlQC4r+ActL9gKaM8EAJgDaVel95MnYU9OPjCOhMoVL82O1
         paa2snDQzk6BPExU9NMAXkveKhgOplTxFZhsCF7S28bP8jlH47UxmAKeYM/r2gbiYi2L
         r2s2yQ91TOXVrkEIim6jmcEY7CVu6IIiDvPSl10ReacTuTdTXYrSit9UsIUTUTWuOeIe
         WEihMovUQY6mAJHbaLn8z1hU0GfYV0CgM5CH5WpcxILuGougNHjsrcH1l9zkloLBjgCE
         Ih+g==
X-Gm-Message-State: AOJu0YwaVpu/FMABjMUFnd0b6hhHwVFZgRM6IxinP8g38y4PZHeU7jKr
	BVUmy9mjhb0iRjztR5YRJhQ38UqPY8OdnRsXstol50MGcuovpx/23RNh88TDiSqx8FL4Px7zxkA
	mwQ0WqG1jeNj8ivz4t8I986dmYHE+6w9Asl01
X-Google-Smtp-Source: AGHT+IEEUt/DgzXO1AX+ZX14FPohfmver71O605lz2UODUD0bZlhFJyh1ggzF20lbyIhsK8T+wPlrH7YMIMW913bZlQ=
X-Received: by 2002:a50:9f8a:0:b0:55f:88de:bb03 with SMTP id
 c10-20020a509f8a000000b0055f88debb03mr40631edf.4.1707163657523; Mon, 05 Feb
 2024 12:07:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123014517.5787-1-mcpratt@pm.me>
In-Reply-To: <20240123014517.5787-1-mcpratt@pm.me>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 5 Feb 2024 12:06:56 -0800
Message-ID: <CAGETcx_CqcHhKCXrUQOOnrr9Ke=dJRcJGTGxrdbPxnDOG1Xrbw@mail.gmail.com>
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

On Mon, Jan 22, 2024 at 5:46=E2=80=AFPM Michael Pratt <mcpratt@pm.me> wrote=
:
>
> Hi all,
>
> First off, if you are CC'ed here, it's likely because you were
> involved in or CC'ed in a patch series by Saravana Kannan for fw_devlink,
> and for consistency, I'm kindly asking for review from you all as well.
> If you think this may not affect your use cases, feel free to ignore this=
.
> I'm also CC'ing Christian and Rafal from the Openwrt project.
>
> This series is following up on some excellent work from Saravana [1]
> which is another patch series that includes some changes
> that helped make it possible for fw_devlink to work with MTD partitions
> that are a supplier fwnode by being a NVMEM provider. For an MTD partitio=
n
> to become an NVMEM provider, it must be registered as a platform device
> using of_platform_populate() or similar function
> which was done in a previous commit [2]
> but this also resulted in fw_devlink to apply
> to those fwnodes and their child fwnodes.
>
> That regression caused consumer devices to defer indefinitely
> while waiting for probing that will never happen or for device links
> to form from fwnode links with fwnodes that are not associated
> with any real device or driver that probes
> (e.g. describing the location of a MAC address).
>
> Saravana's patch series helped in two ways:
> First, by moving consumers from a child fwnode (in this case,
> the "nvmem-cells" compatible node) to an ancestor fwnode
> that represents the actual supplier device when that device probes,
> which handles the case where
> the supplier device has a probe attempt first. [3] [4]
> And secondly, by specifically marking "nvmem-cells" compatible nodes
> as populated during MTD partition parsing which also occurs during
> the supplier device probe, which handles both cases of initial probe orde=
r,
> but only for that node type. [5]
>
> However, there's some drawbacks to the second solution

Oh, somehow missed this thread entirely until it saw some activity today.

> from having to manually name which nodes need the workaround
> for the corner case with the compatible string.
> Most notably, that it's possible for this corner case
> to apply to other nodes types, but also the fact that initial probe order
> deciding whether or not everything probes in the intended order, if at al=
l,
> through driver core alone is still an issue with fw_devlink,
> despite the fact that controlling probe order in driver core
> is one of it's goals. In other words, the real problem is in driver core,
> but the fix is in the mtd driver.

It's been a while since I looked at MTD code, but the real problem is
not in driver core, but how it's used incorrectly by the MTD/nvmem
frameworks. Adding devices to a bus that'll never probe is wrong. I
think there's also a case of two devices being created off the same DT
node. While not technically wrong, it's weird when one of them never
probes.

I'll take a closer look and respond to this series later. Hopefully
this week, but if not, then next week.

As I said in the other patch, I don't like the series in the current
form because it's changing APIs in not so great ways.

fwnode_link_add() is supposed to be super dumb and simple. It's
literally there just to avoid reparsing DT nodes multiple times.
Nothing more ever. It just denotes the "pointers" between fwnode or DT
nodes.

The "smarts" should either be where fwnode links are converted into
device links (and not have to fix them up) or where nvmem-cells is
being parsed and converted to fwnode links.

As I said in the other patch, let me take a closer look this week or
next and get back. These things needs several hours of uninterrupted
time for me to debug and unwind.

-Saravana

>
> Unfortunately, with the Openwrt project
> we are experiencing this regression again
> by implementing the new NVMEM layout "fixed-layout"
> after it was accepted into the kernel. [6]
> This causes some subsystems of an SOC, like
> ethernet or wireless or both depending on hardware and DTS,
> and in some cases a completely different function like USB
> to never probe once again, and the temporary fix, like before,
> is by disabling fw_devlink. [7]
>
> Below is a simplified DTS of an Atheros device with the NVMEM layout:
>
>
> &eth0 {
>         nvmem-cells =3D <&macaddr_art_0>;
>         nvmem-cell-names =3D "mac-address";
> };
>
> &wifi {
>         nvmem-cells =3D <&caldata_art_1000>;
>         nvmem-cell-names =3D "calibration";
> };
>
> &spi {
>         status =3D "okay";
>
>         flash@0 {
>                 compatible =3D "jedec,spi-nor";
>
>                 partitions {
>                         compatible =3D "fixed-partitions";
>
>                         partition@ff0000 {
>                                 label =3D "art";
>                                 reg =3D <0xff0000 0x010000>;
>                                 read-only;
>
>                                 nvmem-layout {
>                                         compatible =3D "fixed-layout";
>
>                                         macaddr_art_0: macaddr@0 {
>                                                 reg =3D <0x0 0x6>;
>                                         };
>
>                                         caldata_art_1000: caldata@1000 {
>                                                 reg =3D <0x1000 0x440>;
>                                         };
>                                 };
>                         };
>                 };
>         };
> };
>
>
> When the DTS is written this way, not only is there a different node
> involved for NVMEM, but this node is a new node that is yet another
> descendant in the tree. In other words, the "partition@ff0000" node
> used to be what designated this device as the NVMEM provider
> with the "nvmem-cells" compatible, so the node that represents
> the actual probing device is now 4 parent nodes up in the tree
> in this example instead of 3 parent nodes up in the tree as before.
>
> For the past year, and even before the "fixed-layout" issue came up,
> I had been experimenting with a way to handle these reverse probe order
> and linking of distant descendant node issues in a generic way instead of
> naming exceptions with the compatible string, and this series is the
> culmination of those efforts. It may look strange at first,
> but there are a myriad set of cases to handle and other reasons
> that led me to develop this approach of using existing bad device links
> in order to find the correct fwnode to link to, and then redo
> the relevant links for that consumer device altogether.
> I'm concerned that doing this another way would be a much more massive
> project that would basically rewrite what the fw_devlink feature does.
> Or perhaps there would have to be a new, third form of device links
> that would be a "placeholder" before it becomes a fwnode link.
> Eventually, I came to the conclusion that
> there simply is not enough information to form the correct fwnode link
> before the real supplier device has a successful probe.
>
> Some of the changes proposed here are made on the extreme side of caution=
,
> for example, checking for null dereference when it might not be necessary=
,
> and reducing the activity of some functions in order to reduce
> the amount of assumptions taking place in the middle of driver core
> in cases where the new functions proposed here handles that just as well
> and closer to a possible probe defer event
> (e.g. not declaring a fwnode as NOT_DEVICE before
> a probe attempt is expected to have happened).
>
> I have tried to make the commit messages as self-explanatory as I can,
> but they might have ended up a little too verbose, and therefore confusin=
g
> but I'm ready to explain whatever has not been explained well already.
> Lastly, this is my first attempt at sending a larger change to the kernel=
,
> so I appreciate your time and patience very much.
>
> MCP
>
>
> [1] https://lore.kernel.org/lkml/20230207014207.1678715-1-saravanak@googl=
e.com/
>
> [2] bcdf0315a61a29eb753a607d3a85a4032de72d94
>
> [3] 3a2dbc510c437ca392516b0105bad8e7970e6614
>
> [4] 411c0d58ca6faa9bc4b9f5382118a31c7bb92a6f
>
> [5] fb42378dcc7f247df56f0ecddfdae85487495fbc
>
> [6] 27f699e578b1a72df89dfa3bc42e093a01dc8d10
>
> [7] https://github.com/openwrt/openwrt/commit/703d667a0cdf6dfa402c08e72d0=
c77a257ca5009
>
>
> Michael Pratt (4):
>   driver core: fw_devlink: Use driver to determine probe ability
>   driver core: fw_devlink: Link to supplier ancestor if no device
>   driver core: fw_devlink: Add function device_links_fixup_suppliers()
>   mtd: mtdpart: Allow fwnode links to NVMEM compatible fwnodes
>
>  drivers/base/base.h    |   1 +
>  drivers/base/core.c    | 144 ++++++++++++++++++++++++++++++++++++++---
>  drivers/base/dd.c      |   2 +
>  drivers/mtd/mtdpart.c  |  10 ---
>  include/linux/fwnode.h |   4 ++
>  5 files changed, 143 insertions(+), 18 deletions(-)
>
>
> base-commit: b0d326da462e20285236e11e4cbc32085de9f363
> --
> 2.30.2
>
>

