Return-Path: <linux-kernel+bounces-121435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C52488E9ED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40B8AB230AC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB9913DB98;
	Wed, 27 Mar 2024 14:27:09 +0000 (UTC)
Received: from 10.mo575.mail-out.ovh.net (10.mo575.mail-out.ovh.net [46.105.79.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CC712F5B9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.79.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549628; cv=none; b=sDH8WziJUjQAAM5JnXdEmPtbF7hv/rvGGtSy47N1tLvqENkA6e+BTpL0m1dj1DE9xJfQgQ8wcw4aNiXQz/72rcBjgwLO1x7TVJipIDeun2fVTUgQ99zZQYcp62phCbeoPQQIbwGBvdo2RA4RYsDhhPSyokJhU9/iN8vbq6MRsUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549628; c=relaxed/simple;
	bh=pkuiviAAn0Uftfef1W5rS8J5Melpm/txesyxIQb8HRg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XIAfC5L/Is/3YvG0lR8JagLosczmF0QcqZPp7P3p7CqdvSb7dniHzt/5faIDduWhp5desNaOK/eb4ZvUuWWtQCtAKEamKOpZKn0KVOUSmViTUlB8uQbV8hVbUKmWEIpnBNUka/qioVVcYLDVRYtJC8XBqeUWkfB7fF6Wp+sJtaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl; spf=pass smtp.mailfrom=milecki.pl; arc=none smtp.client-ip=46.105.79.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=milecki.pl
Received: from director10.ghost.mail-out.ovh.net (unknown [10.108.17.93])
	by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4V4TWh5Yk6z1SsF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:26:56 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-5j6lf (unknown [10.110.96.237])
	by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 9D2931FE92;
	Wed, 27 Mar 2024 14:26:55 +0000 (UTC)
Received: from milecki.pl ([37.59.142.103])
	by ghost-submission-6684bf9d7b-5j6lf with ESMTPSA
	id lEULJa8sBGYx4A0AML5+ww
	(envelope-from <rafal@milecki.pl>); Wed, 27 Mar 2024 14:26:55 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-103G0051bcccc50-b51a-4dd6-be14-20d89d3369be,
                    AD8588E3BB83D84E59DEA8CE8674EAB20989D6B2) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp:178.33.236.78
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 Mar 2024 15:26:55 +0100
From: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
 <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] mtd: limit OTP NVMEM Cell parse to non Nand devices
In-Reply-To: <20240322040951.16680-1-ansuelsmth@gmail.com>
References: <20240322040951.16680-1-ansuelsmth@gmail.com>
Message-ID: <44a377b11208ff33045f12f260b667dd@milecki.pl>
X-Sender: rafal@milecki.pl
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3220073736837835577
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedggedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghfkfigihgtgfesthejjhdttddtvdenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepkeeftefghfetueetveevvddugfelfeevvedvleeljeetfefggfdtteevuddtleeunecukfhppeduvdejrddtrddtrddupdefuddruddurddvudekrddutdeipddujeekrdeffedrvdefiedrjeekpdefjedrheelrddugedvrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehrrghfrghlsehmihhlvggtkhhirdhplhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejhedpmhhouggvpehsmhhtphhouhht

On 2024-03-22 05:09, Christian Marangi wrote:
> MTD OTP logic is very fragile and can be problematic with some specific
> kind of devices.
> 
> NVMEM across the years had various iteration on how Cells could be
> declared in DT and MTD OTP probably was left behind and
> add_legacy_fixed_of_cells was enabled without thinking of the 
> consequences.

Er... thank you?


> That option enables NVMEM to scan the provided of_node and treat each
> child as a NVMEM Cell, this was to support legacy NVMEM implementation
> and don't cause regression.
> 
> This is problematic if we have devices like Nand where the OTP is
> triggered by setting a special mode in the flash. In this context real
> partitions declared in the Nand node are registered as OTP Cells and
> this cause probe fail with -EINVAL error.
> 
> This was never notice due to the fact that till now, no Nand supported
> the OTP feature. With commit e87161321a40 ("mtd: rawnand: macronix: OTP
> access for MX30LFxG18AC") this changed and coincidentally this Nand is
> used on an FritzBox 7530 supported on OpenWrt.

So as you noticed this problem was *exposed* by adding OTP support for
Macronix NAND chips.


> Alternative and more robust way to declare OTP Cells are already
> prossible by using the fixed-layout node or by declaring a child node
> with the compatible set to "otp-user" or "otp-factory".
> 
> To fix this and limit any regression with other MTD that makes use of
> declaring OTP as direct child of the dev node, disable
> add_legacy_fixed_of_cells if we detect the MTD type is Nand.
> 
> With the following logic, the OTP NVMEM entry is correctly created with
> no Cells and the MTD Nand is correctly probed and partitions are
> correctly exposed.
> 
> Fixes: 2cc3b37f5b6d ("nvmem: add explicit config option to read old 
> syntax fixed OF cells")

It's not that commit however that introduced the problem. Introducing
"add_legacy_fixed_of_cells" just added a clean way of enabling parsing
of old cells syntax. Even before my commit NVMEM subsystem was looking
for NVMEM cells in NAND devices.

I booted kernel 6.6 which has commit e87161321a40 ("mtd: rawnand:
macronix: OTP > access for MX30LFxG18AC") but does NOT have commit
2cc3b37f5b6d ("nvmem: add explicit config option to read old syntax
fixed OF cells").

Look at this log from Broadcom Northstar (Linux 6.6):
[    0.410107] nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xdc
[    0.416531] nand: Macronix MX30LF4G18AC
[    0.420409] nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, 
OOB size: 64
[    0.428022] iproc_nand 18028000.nand-controller: detected 512MiB 
total, 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-8
[    0.438991] Scanning device for bad blocks
[    0.873598] Bad eraseblock 738 at 0x000005c40000
[    1.030279] random: crng init done
[    1.854895] Bad eraseblock 2414 at 0x000012dc0000
[    2.657354] Bad eraseblock 3783 at 0x00001d8e0000
[    2.662967] Bad eraseblock 3785 at 0x00001d920000
[    2.848418] nvmem user-otp1: nvmem: invalid reg on 
/nand-controller@18028000/nand@0
[    2.856126] iproc_nand 18028000.nand-controller: error -EINVAL: 
Failed to register OTP NVMEM device

So to summary it up:
1. Problem exists since much earlier and wasn't introduced by 
2cc3b37f5b6d
2. Commit 2cc3b37f5b6d just gives you a clean way of solving this issue
3. Problem was exposed by commit e87161321a40
4. We miss fix for v6.6 which doesn't have 2cc3b37f5b6d (it hit v6.7)


> Cc: <stable@vger.kernel.org>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

