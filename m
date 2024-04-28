Return-Path: <linux-kernel+bounces-161605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 300008B4EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70459B20D65
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0291426C;
	Sun, 28 Apr 2024 22:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="m2XNYImJ"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2063.outbound.protection.outlook.com [40.92.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CDF9479;
	Sun, 28 Apr 2024 22:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714344225; cv=fail; b=PzWIwpR6RNwWJB+MMVydZpFAAFz+Lp2WbivWJQv1NULal4jOWVpyIp0Da6D4xE8BrHRcu1JqDad8es7htGw3OnBQ0kErMXeg8F3L0QF2dryowu3EGUVhvGp9J/7IAniBGEKq7sWwX/b6Kz20lEiTNBnZmEolteysSc+YqrtWGTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714344225; c=relaxed/simple;
	bh=jaoGKYw0WHZphhERdtAgIZ49NTY1fE/nYDKeN+NioZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pn4iNwLD5D1Fk4mOgcp9Lh/na4tQpxABEwySffTRbCHo5kbSzTw4L15FP8hggAjxOdh/ZJYudMaaX/p4ZaoIoOMg63ZIQDcV+ti1Hlpc9hk89274FbFERceF8CDiwNHWUkbgY0VxxZCt7FGckCW8TYndju+DwMLf8r0k1qTwFo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=m2XNYImJ; arc=fail smtp.client-ip=40.92.20.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avQOo8eFHy5ZiZ57w9D0ie8gUUzTQwrAw4PEa1TIxuJVs4wVnrHOmLer6JAh9Z0XsRd97FFA4tTyTUqU5fZJZBcTaptmnnyet1baPFfQubUbxvv/FW68qxBwLAYEQY1OYpC8kDzZaBlkVaZVJFiMJb6VGR1TUd9Cs6xaquPwEF5HPISnn40CITWRXKrCUuo9lablY//l1o0Xn6FkpaJI4fBz/5EQIc8I6PoCAGS76vWfZNI3B8LCOVzwLhOGq/7dik5/SFN3DC6Q3MPDV+iRsVB6pEscsRQVqY++Ct50Quh+qUxpqIruoIH1P99JFfDaJi67pUDg32DVFpgIsSxBLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcG089+NOhSsXEufRZPx+3V/5h8HsEPvNCeC+ovY22Q=;
 b=nfYa8lt/o0fE+giii9Q+xMmYv5rY/UntqO/nZ3kQmu6n786C7u89a3wmSbsarNmhn0FCbocCdcIUOJWdYrkIQm+2NNVKboh53umRyfz2WubmDgWSV0vwvU4mp1YogPUXC7qs+YN+52h9/GplJHm18RV9yP6zjUN8/GK1JbZ+f8D0cJTz2miOudy3SQyAQHtSj5nZ1GsQ38chMSNuLfvvjSfs/h2+7EFQmyaeRLcNCT5DsQEG0953209OXreElZrRY+fQJBrdpYvADqh8NbphUjWeHYDyl/QnvDWPsFfZPEamclqLoGu20vi3DTHopDgt9tDLCXwJJcpBXjjDUp9wOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcG089+NOhSsXEufRZPx+3V/5h8HsEPvNCeC+ovY22Q=;
 b=m2XNYImJ8v5CUyCtzIfwC5d8HQA03Mpv3PWZDv5xleW0+wchiwTTXujj+e4BwfCcOCgPc3yoKl3EJpRfztF3EWknNbFPICM8B/0I/3vvAgWtHlqEVl3/O4Ydf6wh6cO3BsZi0errDL7gLIqlAZwLySTl5draBsYTF3OA/R0/MYsRHkaH9U9dn/vIt9iyTecDz3ebFLd8BLcgolWKyZJwGkxP5uRWqaiGnbCSTii0dwmv1/LyLoZcWhqROi7uPoYHj0N4RkfHycC7t8WFKQfYlCigef4Pl9DEUoQaRqzoaD4kOBJBHZCKZYPJST8N+PA3/Ntlp9NsKktRuRVNx2PY3w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH3PR20MB5698.namprd20.prod.outlook.com (2603:10b6:610:14a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Sun, 28 Apr
 2024 22:43:40 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7519.031; Sun, 28 Apr 2024
 22:43:40 +0000
Date: Mon, 29 Apr 2024 06:44:05 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jean Delvare <jdelvare@suse.com>, Stephen Boyd <sboyd@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Samuel Holland <samuel.holland@sifive.com>, 
	Wei Xu <xuwei5@hisilicon.com>, Huisong Li <lihuisong@huawei.com>, Arnd Bergmann <arnd@arndb.de>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: soc: sophgo: Add SG2042 external hardware
 monitor support
Message-ID:
 <IA1PR20MB495343AC5FD3A23CF0D50BDFBB142@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49532A8A0C52FE5C599B6D13BB142@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953A6EF6ED0CD082B60DD80BB142@IA1PR20MB4953.namprd20.prod.outlook.com>
 <540cad62-db3d-4876-81a4-da396628e5ef@roeck-us.net>
 <IA1PR20MB49532EAE5B31E2B45CCA9CC8BB142@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240428-festive-imaging-261b81b9e541@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428-festive-imaging-261b81b9e541@spud>
X-TMN: [S4taRZ3FrwmjYJxo192t8Xm9Ayh2BVwti1WIOo9/YnE=]
X-ClientProxiedBy: SG2PR02CA0067.apcprd02.prod.outlook.com
 (2603:1096:4:54::31) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <d7pfrvxkhux7thad7mp2w3i2fa37fmrc4br3vov7arfwxk5s5k@lc7wpzbuaamp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH3PR20MB5698:EE_
X-MS-Office365-Filtering-Correlation-Id: a58f5b82-fc61-46c3-022b-08dc67d4a633
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|56899024|1710799017;
X-Microsoft-Antispam-Message-Info:
	T73AyK+jaZkjy5sFZ3l/4j1Fj+qE8HFZJHL9BcSxs9WAdqK0ACKRPP21kAWs0i068jpSKUqGR4KEiioljGuRDl0CSWToLHAxNB0QkS+qsM6QGdW6+6YMRFbRSDKrO1v1eKPRKmyVRTMCHXGL5eORlrRVQiAwDrGGSFXEAIVw2SJAtnK+q0G/2DzMdWifw1huFn3EL65bbRNXNKBYsNy5NSdoCsqI2rh2iwgs7tkvwsjp6Zi6yqPvMajM7js8ll3Oi25YgAJk0r+kwgvPSuQ6B+dE7HK4bK7sKooa5XY9OmdBAawRfbh/zEeOhCL7cTC8cCoN+Eg/vW0qycF7ZiSDJWisk2F6Lg9TGQEVV8aEzSxsV207ApvI0gVe/LRNNriqPeL/XnFAJEy121Bvv2WzuUxV5odUYVkUD6naLbYW92V/v6WojIAkkTyZVQSnrUd+npGH8Ys+NDWqEkkcFKrky06enTzcVSq3jxe90eAVmfK7JyiNj9kMOfHlUpSaXnUeS++9UAXISMuqLAwZ7eJBO3oLC8Do8wWhvMu0JjJAP9NeAaHruhDmwm/EaaHh6MJzyfUgxVXdDcObGHFbB8Wtp16RhaWAj1XCVyYgTbTpnt8FL2YbHAgDmur2W7nwlWFO
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S8UlhO08xRY9L4qIdZSRstgKA4IxCHcUULfAfsSXatFFv12Fyp1u3/qA2oEt?=
 =?us-ascii?Q?7zDLdWS3BMToZFBysNMQmsqt5hf5zv2SgUx997ivvWKESyTqi2IPceyc3s9l?=
 =?us-ascii?Q?lk+4GTLjpaaaF/mC6IwWU9+I540lQ9ax5ti+6ke1daW4c7ezd9NkWOnFyejf?=
 =?us-ascii?Q?q6VveOI/bmFRdLOdQLbb9JEVXB9DLnJqT5IyH/e40sqvx1tijeMRlcUh+jar?=
 =?us-ascii?Q?PLiltyv98JgIRV5jMvbAh17KFzqWP0JjkXRplA+KIL4st9waD0TU226YYGUa?=
 =?us-ascii?Q?g+5LxSQTHUKZKFT/9E8JE4KC8uzCKEM6Rd/ADvGVVBH+15tniHiU72qjQG0P?=
 =?us-ascii?Q?0LHy6UI14V8FA/Zaj0QFOk2KlsunaWDNcKCojGu6GgrzvKYMRFA9N1/pdfMd?=
 =?us-ascii?Q?NUK8qwc0okj1JhWDwLTDd1b+aWjDNQXhJ1IF/8KYkLON1eewZUUHVyOJ3vyc?=
 =?us-ascii?Q?6fa5344djL1+0nxvTMqHMPepN3YH5zdzNXoZZ+OfnrNi3gPWoRGR9BA8CCdb?=
 =?us-ascii?Q?QeiiVHnpoS3F13Vubx+epqkk9A2xm5Tqn/LDc/9V8qO0mgHGILfQxxydNdTG?=
 =?us-ascii?Q?jNJPGILWbFUyeIXAN/Vyg9TWWq9YbI3lCBGPZSG8vuCRC5Yk0rkfRzLL7/IZ?=
 =?us-ascii?Q?KjmIXaCUrXgALbJMvW0qKmX4Ur7l/q/HZmJzknwdypJc6ZrwBSMnoQ7yTqa9?=
 =?us-ascii?Q?WpWeVF4MkydHjVFcjOOt3tl4Rb9/z+rtJwQyp9DhAqjkFM/W4i8Y75YQD8R3?=
 =?us-ascii?Q?GV7YEM0C5ohvQocd4jzxrAxkCbWsenWLQC3XjBYO3cV8QANbZHufBoxcsoen?=
 =?us-ascii?Q?8HiHhN15drQZl/SpETEF2i5h5gkAJ9Sz8Ejpcq9tOzDA3eUmCcu+vd3PvkV/?=
 =?us-ascii?Q?7HZOJ+275BKGg/UexDZvWc21kyzh+GQLkhUit2EkuhEKJRUsBgA92gEEQ56R?=
 =?us-ascii?Q?VpwCFDNo/qx4QwFswb6ggB6IwumKvCIxcC4Bfg+6ko0kIZdHM5cmDz8piPqZ?=
 =?us-ascii?Q?POTxq2oXc8Q7jPVvYhaw3BaiBV/B5tgqqK+L74uyvHnMrYmyhpojcNCA3WAz?=
 =?us-ascii?Q?RvHBjyM+hPdtZ7V7jBEr9ZIT49tlfFhTka1DXjHPiKLRn5o1CrSXweFp/w0j?=
 =?us-ascii?Q?XrI+l2e3KZq7qHYY2d9fO0rxEGeY8wgS5+T8do7tGeSOuSG4gPwlrps0AerB?=
 =?us-ascii?Q?EAwDsR+ti3jjYe2OkbvbMM1rHvIGQT7qpEac41WZ7SrYaj6EytnAgcnnavkU?=
 =?us-ascii?Q?fyeYgbD/73UgnUIgso9n?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58f5b82-fc61-46c3-022b-08dc67d4a633
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 22:43:40.3786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB5698

On Sun, Apr 28, 2024 at 04:42:30PM GMT, Conor Dooley wrote:
> On Sun, Apr 28, 2024 at 08:09:48PM +0800, Inochi Amaoto wrote:
> > On Sun, Apr 28, 2024 at 12:00:15AM GMT, Guenter Roeck wrote:
> > > On 4/27/24 18:30, Inochi Amaoto wrote:
> > > > SG2042 use an external MCU to provide basic hardware information
> > > > and thermal sensors.
> > > > 
> > > > Add driver support for the onboard MCU of SG2042.
> > > > 
> > > > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > > 
> > > Why does this driver reside in drivers/soc and not in drivers/hwmon ?
> > > 
> > > NACK from my perspective.
> > > 
> > > Guenter
> > > 
> > 
> > In fact, I am pretty unsure which one is better. This driver also provides
> > something rather than the hardware monitor. For example, this device also
> > acts as a reset controller (now only used in SBI). Is it even better to
> > move the driver into hwmon subsystem in this case?
> 
> The guidance from Arnd about drivers/soc is that it is ideally only
> drivers that expose an in-kernel interface belong there, and if there's
> some sort of userspace interface, then it does not belong there.
> 

Thanks, I will swtich to hwmon for this driver.

> Additionally, I'd suggest that if the "reset controller" side of this
> is not resets for peripherals, but rather is poweroff/reboot, that the
> SBI firmware deals with that functionality and implements the SRST SBI
> extension.
> 

You are right, I forgot the "poweroff/reboot". Thanks for correction.

> Cheers,
> Conor.
> 
> > 
> > Regards,
> > Inochi
> > 
> > > > ---
> > > >   drivers/soc/Kconfig                   |   1 +
> > > >   drivers/soc/Makefile                  |   1 +
> > > >   drivers/soc/sophgo/Kconfig            |  12 +
> > > >   drivers/soc/sophgo/Makefile           |   5 +
> > > >   drivers/soc/sophgo/sg2042-hwmon-mcu.c | 531 ++++++++++++++++++++++++++
> > > >   5 files changed, 550 insertions(+)
> > > >   create mode 100644 drivers/soc/sophgo/Kconfig
> > > >   create mode 100644 drivers/soc/sophgo/Makefile
> > > >   create mode 100644 drivers/soc/sophgo/sg2042-hwmon-mcu.c
> > > > 
> > > > diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> > > > index 5d924e946507..19050f094996 100644
> > > > --- a/drivers/soc/Kconfig
> > > > +++ b/drivers/soc/Kconfig
> > > > @@ -22,6 +22,7 @@ source "drivers/soc/qcom/Kconfig"
> > > >   source "drivers/soc/renesas/Kconfig"
> > > >   source "drivers/soc/rockchip/Kconfig"
> > > >   source "drivers/soc/samsung/Kconfig"
> > > > +source "drivers/soc/sophgo/Kconfig"
> > > >   source "drivers/soc/sunxi/Kconfig"
> > > >   source "drivers/soc/tegra/Kconfig"
> > > >   source "drivers/soc/ti/Kconfig"
> > > > diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> > > > index ba8f5b5460e1..6948e6617316 100644
> > > > --- a/drivers/soc/Makefile
> > > > +++ b/drivers/soc/Makefile
> > > > @@ -28,6 +28,7 @@ obj-y				+= qcom/
> > > >   obj-y				+= renesas/
> > > >   obj-y				+= rockchip/
> > > >   obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
> > > > +obj-y				+= sophgo/
> > > >   obj-y				+= sunxi/
> > > >   obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
> > > >   obj-y				+= ti/
> > > > diff --git a/drivers/soc/sophgo/Kconfig b/drivers/soc/sophgo/Kconfig
> > > > new file mode 100644
> > > > index 000000000000..de9842d1c287
> > > > --- /dev/null
> > > > +++ b/drivers/soc/sophgo/Kconfig
> > > > @@ -0,0 +1,12 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only
> > > > +#
> > > > +# Sophgo SoC drivers
> > > > +#
> > > > +
> > > > +config SG2042_HWMON_MCU
> > > > +	tristate "SG2042 onboard MCU support"
> > > > +	depends on RISCV
> > > > +	help
> > > > +	  Support for SG2042 onboard MCU. This mcu provides power
> > > > +	  control and some basic information for SG2042 chip.
> > > > +	  If unsure, say Y.
> > > > diff --git a/drivers/soc/sophgo/Makefile b/drivers/soc/sophgo/Makefile
> > > > new file mode 100644
> > > > index 000000000000..c72729ce61aa
> > > > --- /dev/null
> > > > +++ b/drivers/soc/sophgo/Makefile
> > > > @@ -0,0 +1,5 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only
> > > > +#
> > > > +# Sophgo SoC drivers
> > > > +#
> > > > +obj-$(CONFIG_SG2042_HWMON_MCU)		+= sg2042-hwmon-mcu.o
> > > > diff --git a/drivers/soc/sophgo/sg2042-hwmon-mcu.c b/drivers/soc/sophgo/sg2042-hwmon-mcu.c
> > > > new file mode 100644
> > > > index 000000000000..3413b1a0f5e3
> > > > --- /dev/null
> > > > +++ b/drivers/soc/sophgo/sg2042-hwmon-mcu.c
> > > > @@ -0,0 +1,531 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * Copyright (c) 2024 Inochi Amaoto <inochiama@outlook.com>
> > > > + *
> > > > + * Sophgo power control mcu for SG2042
> > > > + */
> > > > +
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/err.h>
> > > > +#include <linux/hwmon.h>
> > > > +#include <linux/time.h>
> > > > +
> > > > +/* fixed MCU registers */
> > > > +#define REG_BOARD_TYPE				0x00
> > > > +#define REG_MCU_FIRMWARE_VERSION		0x01
> > > > +#define REG_PCB_VERSION				0x02
> > > > +#define REG_PWR_CTRL				0x03
> > > > +#define REG_SOC_TEMP				0x04
> > > > +#define REG_BOARD_TEMP				0x05
> > > > +#define REG_RST_COUNT				0x0a
> > > > +#define REG_UPTIME				0x0b
> > > > +#define REG_RESET_REASON			0x0d
> > > > +#define REG_MCU_TYPE				0x18
> > > > +#define REG_CRITICAL_ACTIONS			0x65
> > > > +#define REG_CRITICAL_TEMP			0x66
> > > > +#define REG_REPOWER_TEMP			0x67
> > > > +
> > > > +#define CRITICAL_ACTION_REBOOT			0x1
> > > > +#define CRITICAL_ACTION_POWEROFF		0x2
> > > > +
> > > > +#define DEFAULT_REPOWER_TEMP			60
> > > > +#define MAX_REPOWER_TEMP			100
> > > > +
> > > > +#define sg2042_mcu_read_byte(client, reg)			\
> > > > +	i2c_smbus_read_byte_data(client, reg)
> > > > +#define sg2042_mcu_write_byte(client, reg, value)		\
> > > > +	i2c_smbus_write_byte_data(client, reg, value)
> > > > +#define sg2042_mcu_read_block(client, reg, array)		\
> > > > +	i2c_smbus_read_i2c_block_data(client, reg, sizeof(array), array)
> > > > +
> > > > +#define DEFINE_MCU_ATTR_READ_FUNC(_name, _type, _format)		\
> > > > +	static ssize_t _name##_show(struct device *dev,			\
> > > > +				    struct device_attribute *attr,	\
> > > > +				    char *buf)				\
> > > > +	{								\
> > > > +		struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);	\
> > > > +		_type ret;						\
> > > > +		ret = sg2042_mcu_get_##_name(mcu->client);		\
> > > > +		if (ret < 0)						\
> > > > +			return ret;					\
> > > > +		return sprintf(buf, _format "\n", ret);			\
> > > > +	}
> > > > +
> > > > +struct sg2042_mcu_board_data {
> > > > +	u8		id;
> > > > +	const char	*name;
> > > > +};
> > > > +
> > > > +struct sg2042_mcu_data {
> > > > +	struct i2c_client			*client;
> > > > +	const struct sg2042_mcu_board_data	*board_info;
> > > > +};
> > > > +
> > > > +static const struct sg2042_mcu_board_data sg2042_boards_data[] = {
> > > > +	{
> > > > +		.id = 0x80,
> > > > +		.name = "SG2042 evb x8",
> > > > +	},
> > > > +	{
> > > > +		.id = 0x81,
> > > > +		.name = "SG2042R evb",
> > > > +	},
> > > > +	{
> > > > +		.id = 0x83,
> > > > +		.name = "SG2042 evb x4",
> > > > +	},
> > > > +	{
> > > > +		.id = 0x90,
> > > > +		.name = "Milk-V Pioneer",
> > > > +	},
> > > > +};
> > > > +
> > > > +static const char *sg2042_mcu_reset_reason[8] = {
> > > > +	"Power supply overheat",
> > > > +	"Power supply failure",
> > > > +	"12V power supply failure",
> > > > +	"Reset commant",
> > > > +	"Unknown",
> > > > +	"Unknown",
> > > > +	"Unknown",
> > > > +	"SoC overheat",
> > > > +};
> > > > +
> > > > +static int sg2042_mcu_get_board_type(struct i2c_client *client)
> > > > +{
> > > > +	return sg2042_mcu_read_byte(client, REG_BOARD_TYPE);
> > > > +}
> > > > +
> > > > +static int sg2042_mcu_get_firmware_version(struct i2c_client *client)
> > > > +{
> > > > +	return sg2042_mcu_read_byte(client, REG_MCU_FIRMWARE_VERSION);
> > > > +}
> > > > +
> > > > +static int sg2042_mcu_get_pcb_version(struct i2c_client *client)
> > > > +{
> > > > +	return sg2042_mcu_read_byte(client, REG_PCB_VERSION);
> > > > +}
> > > > +
> > > > +static int sg2042_mcu_get_soc_temp(struct i2c_client *client)
> > > > +{
> > > > +	return sg2042_mcu_read_byte(client, REG_SOC_TEMP);
> > > > +}
> > > > +
> > > > +static int sg2042_mcu_get_board_temp(struct i2c_client *client)
> > > > +{
> > > > +	return sg2042_mcu_read_byte(client, REG_BOARD_TEMP);
> > > > +}
> > > > +
> > > > +static int sg2042_mcu_get_reset_count(struct i2c_client *client)
> > > > +{
> > > > +	return sg2042_mcu_read_byte(client, REG_RST_COUNT);
> > > > +}
> > > > +
> > > > +static s32 sg2042_mcu_get_uptime(struct i2c_client *client)
> > > > +{
> > > > +	int ret;
> > > > +	u8 time_val[2];
> > > > +
> > > > +	ret = sg2042_mcu_read_block(client, REG_UPTIME, time_val);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	return (s32)(time_val[0]) + ((s32)(time_val[1]) << 8);
> > > > +}
> > > > +
> > > > +static int sg2042_mcu_get_reset_reason(struct i2c_client *client)
> > > > +{
> > > > +	return sg2042_mcu_read_byte(client, REG_RESET_REASON);
> > > > +}
> > > > +
> > > > +static int sg2042_mcu_get_mcu_type(struct i2c_client *client)
> > > > +{
> > > > +	return sg2042_mcu_read_byte(client, REG_MCU_TYPE);
> > > > +}
> > > > +
> > > > +static int sg2042_mcu_get_critical_action(struct i2c_client *client)
> > > > +{
> > > > +	return sg2042_mcu_read_byte(client, REG_CRITICAL_ACTIONS);
> > > > +}
> > > > +
> > > > +static int sg2042_mcu_get_critical_temp(struct i2c_client *client)
> > > > +{
> > > > +	return sg2042_mcu_read_byte(client, REG_CRITICAL_TEMP);
> > > > +}
> > > > +
> > > > +static int sg2042_mcu_get_repower_temp(struct i2c_client *client)
> > > > +{
> > > > +	return sg2042_mcu_read_byte(client, REG_REPOWER_TEMP);
> > > > +}
> > > > +
> > > > +static int sg2042_mcu_set_critical_action(struct i2c_client *client,
> > > > +					  u8 value)
> > > > +{
> > > > +	return sg2042_mcu_write_byte(client, REG_CRITICAL_ACTIONS, value);
> > > > +}
> > > > +
> > > > +static int sg2042_mcu_set_critical_temp(struct i2c_client *client,
> > > > +					u8 value)
> > > > +{
> > > > +	return sg2042_mcu_write_byte(client, REG_CRITICAL_TEMP, value);
> > > > +}
> > > > +
> > > > +static int sg2042_mcu_set_repower_temp(struct i2c_client *client,
> > > > +				       u8 value)
> > > > +{
> > > > +	return sg2042_mcu_write_byte(client, REG_REPOWER_TEMP, value);
> > > > +}
> > > > +
> > > > +static ssize_t board_type_show(struct device *dev,
> > > > +			       struct device_attribute *attr,
> > > > +			       char *buf)
> > > > +{
> > > > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > > > +
> > > > +	return sprintf(buf, "%s\n", mcu->board_info->name ?: "Unknown");
> > > > +}
> > > > +
> > > > +DEFINE_MCU_ATTR_READ_FUNC(firmware_version, int, "0x%02x");
> > > > +DEFINE_MCU_ATTR_READ_FUNC(pcb_version, int, "0x%02x");
> > > > +DEFINE_MCU_ATTR_READ_FUNC(reset_count, int, "%d");
> > > > +DEFINE_MCU_ATTR_READ_FUNC(uptime, s32, "%d");
> > > > +
> > > > +static ssize_t reset_reason_show(struct device *dev,
> > > > +				 struct device_attribute *attr,
> > > > +				 char *buf)
> > > > +{
> > > > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > > > +	int ret, val, i;
> > > > +
> > > > +	val = sg2042_mcu_get_reset_reason(mcu->client);
> > > > +	if (val < 0)
> > > > +		return val;
> > > > +
> > > > +	ret = sprintf(buf, "Reason: 0x%02x\n", val);
> > > > +
> > > > +	for (i = 0; i < ARRAY_SIZE(sg2042_mcu_reset_reason); i++) {
> > > > +		if (val & BIT(i))
> > > > +			ret += sprintf(buf + ret, "bit %d: %s\n", i,
> > > > +						  sg2042_mcu_reset_reason[i]);
> > > > +	}
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static ssize_t mcu_type_show(struct device *dev,
> > > > +			     struct device_attribute *attr,
> > > > +			     char *buf)
> > > > +{
> > > > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > > > +	int ret;
> > > > +
> > > > +	ret = sg2042_mcu_get_mcu_type(mcu->client);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	return sprintf(buf, ret ? "GD32\n" : "STM32\n");
> > > > +}
> > > > +
> > > > +static ssize_t critical_action_show(struct device *dev,
> > > > +				    struct device_attribute *attr,
> > > > +				    char *buf)
> > > > +{
> > > > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > > > +	int ret;
> > > > +	const char *action;
> > > > +
> > > > +	ret = sg2042_mcu_get_critical_action(mcu->client);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	if (ret == CRITICAL_ACTION_REBOOT)
> > > > +		action = "reboot";
> > > > +	else if (ret == CRITICAL_ACTION_POWEROFF)
> > > > +		action = "poweroff";
> > > > +	else
> > > > +		action = "unknown";
> > > > +
> > > > +	return sprintf(buf, "%s\n", action);
> > > > +}
> > > > +
> > > > +static ssize_t critical_action_store(struct device *dev,
> > > > +				     struct device_attribute *attr,
> > > > +				     const char *buf, size_t count)
> > > > +{
> > > > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > > > +	int value;
> > > > +
> > > > +	if (sysfs_streq("reboot", buf))
> > > > +		value = CRITICAL_ACTION_REBOOT;
> > > > +	else if (sysfs_streq("poweroff", buf))
> > > > +		value = CRITICAL_ACTION_POWEROFF;
> > > > +	else
> > > > +		return -EINVAL;
> > > > +
> > > > +	return sg2042_mcu_set_critical_action(mcu->client, value);
> > > > +}
> > > > +
> > > > +DEFINE_MCU_ATTR_READ_FUNC(repower_temp, u32, "%u");
> > > > +
> > > > +static ssize_t repower_temp_store(struct device *dev,
> > > > +				  struct device_attribute *attr,
> > > > +				  const char *buf, size_t count)
> > > > +{
> > > > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > > > +	u8 val;
> > > > +	int ret;
> > > > +
> > > > +	ret = kstrtou8(buf, 10, &val);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	if (val == 0 || val > MAX_REPOWER_TEMP)
> > > > +		return -EINVAL;
> > > > +
> > > > +	return sg2042_mcu_set_repower_temp(mcu->client, val);
> > > > +}
> > > > +
> > > > +static DEVICE_ATTR_RO(board_type);
> > > > +static DEVICE_ATTR_RO(firmware_version);
> > > > +static DEVICE_ATTR_RO(pcb_version);
> > > > +static DEVICE_ATTR_RO(reset_count);
> > > > +static DEVICE_ATTR_RO(uptime);
> > > > +static DEVICE_ATTR_RO(reset_reason);
> > > > +static DEVICE_ATTR_RO(mcu_type);
> > > > +static DEVICE_ATTR_RW(critical_action);
> > > > +static DEVICE_ATTR_RW(repower_temp);
> > > > +
> > > > +static struct attribute *sg2042_mcu_attrs[] = {
> > > > +	&dev_attr_board_type.attr,
> > > > +	&dev_attr_firmware_version.attr,
> > > > +	&dev_attr_pcb_version.attr,
> > > > +	&dev_attr_reset_count.attr,
> > > > +	&dev_attr_uptime.attr,
> > > > +	&dev_attr_reset_reason.attr,
> > > > +	&dev_attr_mcu_type.attr,
> > > > +	&dev_attr_critical_action.attr,
> > > > +	&dev_attr_repower_temp.attr,
> > > > +	NULL
> > > > +};
> > > > +
> > > > +static const struct attribute_group sg2042_mcu_attr_group = {
> > > > +	.attrs	= sg2042_mcu_attrs,
> > > > +};
> > > > +
> > > > +static const struct hwmon_channel_info * const sg2042_mcu_info[] = {
> > > > +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
> > > > +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_CRIT,
> > > > +				 HWMON_T_INPUT),
> > > > +	NULL
> > > > +};
> > > > +
> > > > +static int sg2042_mcu_read_temp(struct device *dev,
> > > > +				u32 attr, int channel,
> > > > +				long *val)
> > > > +{
> > > > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > > > +	long tmp;
> > > > +
> > > > +	switch (attr) {
> > > > +	case hwmon_temp_input:
> > > > +		switch (channel) {
> > > > +		case 0:
> > > > +			tmp = sg2042_mcu_get_soc_temp(mcu->client);
> > > > +			if (tmp < 0)
> > > > +				return tmp;
> > > > +			*val = tmp * 1000;
> > > > +			break;
> > > > +		case 1:
> > > > +			tmp = sg2042_mcu_get_board_temp(mcu->client);
> > > > +			if (tmp < 0)
> > > > +				return tmp;
> > > > +			*val = tmp * 1000;
> > > > +			break;
> > > > +		default:
> > > > +			return -EOPNOTSUPP;
> > > > +		}
> > > > +		break;
> > > > +	case hwmon_temp_crit:
> > > > +		if (channel)
> > > > +			return -EOPNOTSUPP;
> > > > +
> > > > +		tmp = sg2042_mcu_get_critical_temp(mcu->client);
> > > > +		if (tmp < 0)
> > > > +			return tmp;
> > > > +		*val = tmp * 1000;
> > > > +		break;
> > > > +	default:
> > > > +		return -EOPNOTSUPP;
> > > > +	}
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int sg2042_mcu_read(struct device *dev,
> > > > +			   enum hwmon_sensor_types type,
> > > > +			   u32 attr, int channel, long *val)
> > > > +{
> > > > +	switch (type) {
> > > > +	case hwmon_chip:
> > > > +		if (attr != hwmon_chip_update_interval)
> > > > +			return -EOPNOTSUPP;
> > > > +		*val = 1000;
> > > > +		break;
> > > > +	case hwmon_temp:
> > > > +		return sg2042_mcu_read_temp(dev, attr, channel, val);
> > > > +	default:
> > > > +		return -EOPNOTSUPP;
> > > > +	}
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int sg2042_mcu_write(struct device *dev,
> > > > +			    enum hwmon_sensor_types type,
> > > > +			    u32 attr, int channel, long val)
> > > > +{
> > > > +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> > > > +	u8 down_temp, repower_temp;
> > > > +	int ret;
> > > > +
> > > > +	if (type != hwmon_temp || attr != hwmon_temp_crit || !channel)
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > > +	ret = sg2042_mcu_get_repower_temp(mcu->client);
> > > > +	if (ret < 0)
> > > > +		repower_temp = DEFAULT_REPOWER_TEMP;
> > > > +	else
> > > > +		repower_temp = ret;
> > > > +
> > > > +	down_temp = val / 1000;
> > > > +	if (down_temp < repower_temp)
> > > > +		return -EINVAL;
> > > > +
> > > > +	return sg2042_mcu_set_critical_temp(mcu->client, (u8)(val / 1000));
> > > > +}
> > > > +
> > > > +static umode_t sg2042_mcu_is_visible(const void *_data,
> > > > +				     enum hwmon_sensor_types type,
> > > > +				     u32 attr, int channel)
> > > > +{
> > > > +	switch (type) {
> > > > +	case hwmon_chip:
> > > > +		if (attr == hwmon_chip_update_interval)
> > > > +			return 0444;
> > > > +		break;
> > > > +	case hwmon_temp:
> > > > +		switch (attr) {
> > > > +		case hwmon_temp_input:
> > > > +			if (channel < 2)
> > > > +				return 0444;
> > > > +			break;
> > > > +		case hwmon_temp_crit:
> > > > +			if (channel == 0)
> > > > +				return 0664;
> > > > +			break;
> > > > +		default:
> > > > +			return 0;
> > > > +		}
> > > > +		break;
> > > > +	default:
> > > > +		return 0;
> > > > +	}
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static const struct hwmon_ops sg2042_mcu_ops = {
> > > > +	.is_visible = sg2042_mcu_is_visible,
> > > > +	.read = sg2042_mcu_read,
> > > > +	.write = sg2042_mcu_write,
> > > > +};
> > > > +
> > > > +static const struct hwmon_chip_info sg2042_mcu_chip_info = {
> > > > +	.ops = &sg2042_mcu_ops,
> > > > +	.info = sg2042_mcu_info,
> > > > +};
> > > > +
> > > > +static int sg2042_mcu_check_board(u8 id)
> > > > +{
> > > > +	int i;
> > > > +
> > > > +	for (i = 0; i < ARRAY_SIZE(sg2042_boards_data); i++) {
> > > > +		if (sg2042_boards_data[i].id == id)
> > > > +			return i;
> > > > +	}
> > > > +
> > > > +	return -ENODEV;
> > > > +}
> > > > +
> > > > +static int sg2042_mcu_i2c_probe(struct i2c_client *client)
> > > > +{
> > > > +	int ret;
> > > > +	struct device *dev = &client->dev;
> > > > +	struct sg2042_mcu_data *mcu;
> > > > +	struct device *hwmon_dev;
> > > > +
> > > > +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> > > > +						I2C_FUNC_SMBUS_BLOCK_DATA))
> > > > +		return -EIO;
> > > > +
> > > > +	ret = sg2042_mcu_get_board_type(client);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	ret = sg2042_mcu_check_board(ret);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	mcu = devm_kmalloc(dev, sizeof(*mcu), GFP_KERNEL);
> > > > +	if (!mcu)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	mcu->client = client;
> > > > +	mcu->board_info = &sg2042_boards_data[ret];
> > > > +
> > > > +	ret = sysfs_create_group(&dev->kobj, &sg2042_mcu_attr_group);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	i2c_set_clientdata(client, mcu);
> > > > +
> > > > +	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
> > > > +							 mcu,
> > > > +							 &sg2042_mcu_chip_info,
> > > > +							 NULL);
> > > > +
> > > > +	return PTR_ERR_OR_ZERO(hwmon_dev);
> > > > +}
> > > > +
> > > > +static void sg2042_mcu_i2c_remove(struct i2c_client *client)
> > > > +{
> > > > +	struct device *dev = &client->dev;
> > > > +
> > > > +	sysfs_remove_group(&dev->kobj, &sg2042_mcu_attr_group);
> > > > +}
> > > > +
> > > > +static const struct i2c_device_id sg2042_mcu_id[] = {
> > > > +	{ "sg2042-hwmon-mcu", 0 },
> > > > +	{},
> > > > +};
> > > > +MODULE_DEVICE_TABLE(i2c, sg2042_mcu_id);
> > > > +
> > > > +static const struct of_device_id sg2042_mcu_of_id[] = {
> > > > +	{ .compatible = "sophgo,sg2042-hwmon-mcu" },
> > > > +	{},
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, sg2042_mcu_of_id);
> > > > +
> > > > +static struct i2c_driver sg2042_mcu_driver = {
> > > > +	.driver = {
> > > > +		.name = "sg2042-mcu",
> > > > +		.of_match_table = sg2042_mcu_of_id,
> > > > +	},
> > > > +	.probe = sg2042_mcu_i2c_probe,
> > > > +	.remove = sg2042_mcu_i2c_remove,
> > > > +	.id_table = sg2042_mcu_id,
> > > > +};
> > > > +
> > > > +module_i2c_driver(sg2042_mcu_driver);
> > > > +
> > > > +MODULE_DESCRIPTION("MCU I2C driver for bm16xx soc platform");
> > > > +MODULE_LICENSE("GPL");
> > > > --
> > > > 2.44.0
> > > > 
> > > 



