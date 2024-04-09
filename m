Return-Path: <linux-kernel+bounces-136867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F27A89D937
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA971F22106
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2989212D210;
	Tue,  9 Apr 2024 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="bwTO4ehy"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2085.outbound.protection.outlook.com [40.92.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B5512D745;
	Tue,  9 Apr 2024 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712665667; cv=fail; b=gw3SvlLOfAFQ8dj7PsmstpXhGbP44IZQYfVqdlsmyxeiNbzpCkzeGnNahgMEcDQF4FUtMST/0scFk99ZaqslXd/DA9aefN6IkVa9GdfJh+KSXNn52cJPSAN/08FPeD7ZfROGlE3Bx41jf7XiEGms9KPz3WjYEOL7GFQ2kelGx+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712665667; c=relaxed/simple;
	bh=NVHS0NFCDip/2FuZbhsnWf2t+sz7rw4g2WNuSQ8RkqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RMDSfQlXzhy/WSORwlHh2lBY8EG/41QO9kmS6st9eeQIekH2JDlXShUEeofJ9FH8WfySvk4tqRWfOHzVRmRlWeamy64zWA9iseEsQG/vkqiWnLQUoLbTaO6rJnYTS7q+UXkw6qUxJIUrxVmy19oh2l+mlIaj+AqFSlXk/qjhcDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=bwTO4ehy; arc=fail smtp.client-ip=40.92.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6XVQ7LIZ550DdVE7Xmm99V6m6vUf0xDMbX5Xfx176q3WUq5Rgja7tAUll8NEwEObqetrPv2g/V6mYok43SwgLBB81n8RO1xiaDj8tDkjijhh/nTpLAPm1IY4/q9pdc8mNDro5BbMwSCR09Sa0ZUMnHFvqF/bd00HW26B7v5hQTUz8HtMH6ZepMrHkIvF5N4EBVYDFgvm7BdK7vEDZcEj3dVAUMirkZieuNhKPvrmJtptJ13kaASQoE7R4gvvJHRU0TE+eiSjCj1orYVLFKm4mARlDOOjApZT8RwKv+dF6pvpDCsXxVGlqMZZ6c8HhyQcDOwXePAWdG1wh3dcT81WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwN9d21f1+AQQrTXsJw6vJibsoes3GRYAleY1+qDbvU=;
 b=m/YHfaChGW8O0bci46uO0IbvdfjPw18reWTdqmfEV9h+Qwtq7kczg1VQRj6ZlRX+6fUIx6aVCR7VcWj97TyQlVZUje1O3dlG3niRhc0/C2NwoE5LlapgzDJ4P8nfgxzYz/RhoOBUvSsUxxfcM4mj69zxFlrM3BlH7rhtaR+VOnjZfrLrGC0GPy4bUYsWmbEWLNIAB05WRYbpPt3N8kMSuiC8lNZEPc5TFjYKmvLq6BN299oRzUE6IYsJEniP8LM/3x6XjKl3tUyNpxOgDGn61Go+OJUVUm5d6LobW7fEPgZq70RZRbdljxZcGrjI9YdUDNmXTYpeWv8K12kXvNjgng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwN9d21f1+AQQrTXsJw6vJibsoes3GRYAleY1+qDbvU=;
 b=bwTO4ehyYOfzGcXzL35kwHIU8tu31fMF3tMPsvnU8rqmbmS3Z8iQy9HcYGQ5Yn1c97D0IUvmRnOAUYWFDhxj0An7d5x+MSVmbRn6/b5Y6D6aGQpka+PW/CK7MO0opuT5+z387km07c7YNIOx+76e3ns4DREefNnXg9+539ukUFZsNahsg9JK82LFubAtiUC7OSlY3edjBgDa/3tc8j/9is0UwlHTyui+yEFBT6QqanHxk1u8uV9MhqriWKZBZrd8UestB5TihrWQez99T4zxg7pwpIXPPXhvaHU6DK7bcHPmjy6jjuaevJwd79Bcm/e+SNW9XIMt9j0oExtyWNq5nQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DM4PR20MB5728.namprd20.prod.outlook.com (2603:10b6:8:104::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 12:27:43 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 12:27:43 +0000
Date: Tue, 9 Apr 2024 20:27:59 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: michael.opdenacker@bootlin.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: sophgo: add initial Milk-V Duo S board
 device tree
Message-ID:
 <IA1PR20MB49534E00CAE29D24F7D7E718BB072@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <20240409064504.4010353-1-michael.opdenacker@bootlin.com>
 <IA1PR20MB49532A8D4294ADCE0C33A654BB072@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240409-prevent-deepness-2d22bf009b16@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409-prevent-deepness-2d22bf009b16@spud>
X-TMN: [BY1G+xbhpw2NTwj1WcdvtHxx7gvFi79a0GK+N2RelVE=]
X-ClientProxiedBy: TY2PR06CA0044.apcprd06.prod.outlook.com
 (2603:1096:404:2e::32) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <sdvof7tugu7ia2ibsn6dlqgl7einpneazvnl33wtorzelkqrh7@lafxnnegnjaf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DM4PR20MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd9f83f-455e-4d7f-edfa-08dc58907424
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YvrAjKfH7G8Bh2HBKidSop8Pv7nXaIsI3ZXs0Ftg1eOxaqWhCVHrUsV+Ia9D/3T5I/MZcc4eGymJDWL9FpJc8oXTNixugQ0AqFnT4PVxWt8WrrQv1gF2Ahl9v0OO09qWzsGpJzr9h02h+1BMeXVcZYpvgCLtc8gALHTmXd9lPvfn/kh0UsLgtvMR4Tern/RNeeUeyz8Dzur9IGt/NtkGVA07rGfBNZMdwy/H0mGGsBd+y3oPWNsbbUrIiOxQp6/UkVBMZY40UGpEW0d6yzsQLVy/o66TK1ac0oUe2/ZGhDmNfVbUNv1CKsVdvgmIH8tXpOHPRs9nsRFQOdNdwf/wZmx6L+3bzhm1nTzjsrxWWM/E8LBd7QD83iiKqnk+xGvzZe4htOJU9y5ZuhhYIjd8GHfq+a1Sdsn4Ltu6/EotzA4gSPfGn/H/Ub+U6BEZP3YPfHjG/iUYiJrFy9rh0eGXCTzIi45Jlz0hwnZM0T6iuEHFCcfsbQSzlHM0oYLMq0BEmQSmPLvG/+fKeEd8keq0BehQ6EbWX4n4JhdrN5Pzp+NKaHOW0qThvazkjq7e1R/hradILa5TTywQpICAsmBVWjME3abrcz4U0QGPYFCp/6H3W4ALdN2BvGYnOU2rEi5JReLoi+ucuGAmsf/DodKLDVhTMRjR2UntQNl8KbwPOP9FImNOaz9leYFo2GN7FFK2AH0gz2P2UO/AXyLoo97aXQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HQ8pwfvA4Lovrym3fYOr2INn0RX5O7i93Z9nY12aNVZMvQQLg3MPu9Wfl17a?=
 =?us-ascii?Q?cNshP9Mt7y5WLZCmwiFyqv43SoLGWAHX2kOeOGTbnhairDMXoD1EPyo7K2bZ?=
 =?us-ascii?Q?AR8U5PMdFt32wI/4D241x8AI9khSyczJosbkA//gH0Irj6G4uSc7xezSQalY?=
 =?us-ascii?Q?yUzfcEY5p8aLh7rzqxq/rpKXEfEkjy+wAM+WoFF4y3UqPRLD2QjULVKnjhzV?=
 =?us-ascii?Q?kwOI/LuDz0aKucPBBgCATeClH19afJrP364/nLUzS8473QvN0EfT8J8bos65?=
 =?us-ascii?Q?RwIh0nGu/ggcXKYxgz9iNXG3XCezoPTS3r4kYklNGI8qz8wFSMNWKFZLYQmJ?=
 =?us-ascii?Q?tG2RQ8PqLAK/fCzRo48QNXGr+/t2PMo0JLCDbj1Mq7frqoBb/Shhkb//5k55?=
 =?us-ascii?Q?NxZLCCBafZXIGnJx9SLlqS4gbQEubLBP/D3tfB9BsOvngDfitVlnt3IUgPfD?=
 =?us-ascii?Q?v2LkqNYEk5ma8BA5+bLVKsOBLadl9FbVfr+EzB2nu4PQS32AnJo4WbC1q913?=
 =?us-ascii?Q?rq59Or74wB367zn20oBJfcRLhuVo09qzRF+EFo9DAgqlOHrEVWH+97D+68ys?=
 =?us-ascii?Q?3/gphCKwwyeTB18YVdoDQwNn7dzu5iZ2zGH6vsS+KyccyTygsdgdmKrKGDrz?=
 =?us-ascii?Q?o7KFrlNK7fGn6aXATDQipkdp9b+UhhiDNMZmFWwIu0AvC3QemUPa9ytturyQ?=
 =?us-ascii?Q?/F8GMWsUx2oHFvLNgCi34ChyFmi6kAIVSb8NjgM2XRFPb9OXvXEi5AJN/+lS?=
 =?us-ascii?Q?yns+UJw+c2PPUQ2CGA+5RSQvYYVtOfU1c6ivDuXjOGZ21ADl8VEZoCit3jyD?=
 =?us-ascii?Q?6MC6+aFQtBkpJ4YYDw9117LDk+WIqy95zdjjmUKVGo2D1rQPpWvmPtK+bh7M?=
 =?us-ascii?Q?oLQEqytyBHX+dwLMzEQFLSVgnC8y5OUaTUI3r88ne/49J52hx5qI1mTvdnVt?=
 =?us-ascii?Q?Pe4YGQcduiVAw79tWcKZaecUmNWuuXlTDQF857rEQwhOjbPyMcsQRz0OLCBE?=
 =?us-ascii?Q?mkgnTpByA+Hs5YcY+JDtWWOMQYud6LXdmD+mLQiiW+dYr8uQa1Inlo+/c7fi?=
 =?us-ascii?Q?cACfq5lPjeG39B8QH2CA1JsdD/MzrB7G5K/6ApTBlwkFI1Dd+dbATCSPNsh5?=
 =?us-ascii?Q?2tkjHPNOHCDCC5hOqtFBQR1rZQK/bqwoec9Ziev9WfcHcP0xw25Cam5LnPD8?=
 =?us-ascii?Q?ZCzmog9WVFN6B5ECSQqp4lAqEnIapHSltUro70iRp1VBDE1+ZSPdkld+lUxt?=
 =?us-ascii?Q?VSg1lsuUZDLl75I3DKQN?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd9f83f-455e-4d7f-edfa-08dc58907424
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 12:27:42.9467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR20MB5728

On Tue, Apr 09, 2024 at 01:13:32PM +0100, Conor Dooley wrote:
> On Tue, Apr 09, 2024 at 03:17:35PM +0800, Inochi Amaoto wrote:
> > On Tue, Apr 09, 2024 at 08:45:04AM +0200, michael.opdenacker@bootlin.com wrote:
> > > From: Michael Opdenacker <michael.opdenacker@bootlin.com>
> > > 
> > > This adds initial support for the Milk-V Duo S board
> > > (https://milkv.io/duo-s), enabling the serial port and
> > > read-only SD card support, allowing to boot Linux to the
> > > command line.
> > > 
> > 
> > Hi Michael,
> > 
> > I think your patch losts the board binding and have wrong compatiable. 
> > Also, the SD can have rw support with proper property. See link [1] 
> > (need 'disable-wp').
> 
> [1] doesn't go anywhere useful.
> 

This is my fault, I copied the wrong url. The right patch is
https://lore.kernel.org/r/20240217144826.3944-1-jszhang@kernel.org.

> > I suggest you resubmitting this patch after applying clk patchs. 
> > This could reduce some unnecessary change. For now, you can just 
> > use the dts for huashan-pi (with changed memory size).
> 
> Why would using patched huashan-pi dts be more suitable than carrying
> a local patch for duo-s devicetree? What am I missing?
> 
> Cheers,
> Conor.
> 
> > 
> > [1]: https://lore.kernel.org/linux-riscv/IA1PR20MB4953B158F6F575840F3D4267BB7D2@IA1PR20MB4953.namprd20.prod.outlook.com/

I think you miss nothing. Using huashan-pi dts as a temporary 
solution is just because they are both CV181X series. Since
only a few peripherals are supported, it is also OK to use duo 
dts with local change. They're not significantly different.
This is also the reason I did not prepare any patch for the 
new board. (such as lichee RV NANO, duo 256).

