Return-Path: <linux-kernel+bounces-123115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D63890253
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD431F26E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E518312F39B;
	Thu, 28 Mar 2024 14:53:15 +0000 (UTC)
Received: from 9.mo575.mail-out.ovh.net (9.mo575.mail-out.ovh.net [46.105.78.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DE412DDA7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.78.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637595; cv=none; b=unTmNu3xe44JVSOt5l/kibPqfcLo15/3t1z064Do8K9Ka+zhczU89FcNa5ou+XTtuZvhRT0yN8TA42uMq4bMYTV8bfEQAv8MWnz8+nZA64zQ4rj46Uzbun0yZfqvrhd/6OIditQBPfvgjoSRajjWkZUrOPLVoGJ2gJm6i2ZUncY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637595; c=relaxed/simple;
	bh=PBil/XoTgdd3/TtGZlrRclNaQYhUhUn9fk15tLO9hdA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BJJV/J3czYszO29qkZOWHQYmZEqJNe/4SVqF1QTJ1AEY1lmv7HoLVLsmBo5KhjaYpQ352pixKYo+jGO8IoG7wYb8QKyMLntU9cxO5jQ9bpB2mRJ3jB8MQ0GbaVeaLyTCHEuB6aJynizf2J2p4yQ93o9wGi+kDruVJL0u7SlrsQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl; spf=pass smtp.mailfrom=milecki.pl; arc=none smtp.client-ip=46.105.78.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=milecki.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=milecki.pl
Received: from director2.ghost.mail-out.ovh.net (unknown [10.108.2.72])
	by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4V55sD6mzLz1Sqp
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:44:16 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-wxtpn (unknown [10.110.113.85])
	by director2.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 7E9DF1FE90;
	Thu, 28 Mar 2024 14:44:15 +0000 (UTC)
Received: from milecki.pl ([37.59.142.101])
	by ghost-submission-6684bf9d7b-wxtpn with ESMTPSA
	id IMV9Hj+CBWbZXggAzwvfSA
	(envelope-from <rafal@milecki.pl>); Thu, 28 Mar 2024 14:44:15 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-101G0045d0b1274-b274-498f-8ead-e6da2683c4fd,
                    2235DC1EC97375EE3D784BB84CDB06A8C08B71DD) smtp.auth=rafal@milecki.pl
X-OVh-ClientIp:51.255.71.60
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 28 Mar 2024 15:44:15 +0100
From: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
 <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] mtd: limit OTP NVMEM Cell parse to non Nand devices
In-Reply-To: <66057c71.050a0220.e4ba.97dc@mx.google.com>
References: <20240322040951.16680-1-ansuelsmth@gmail.com>
 <30bc0d38-b610-4397-ba42-46819d5507fc@milecki.pl>
 <66057c71.050a0220.e4ba.97dc@mx.google.com>
Message-ID: <a4632f1ba701f6b333c50a5366723cf4@milecki.pl>
X-Sender: rafal@milecki.pl
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9385501623872629561
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudduledgieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghfkfigihgtgfesthekjhdttddtjeenucfhrhhomheptfgrfhgrlhcuofhilhgvtghkihcuoehrrghfrghlsehmihhlvggtkhhirdhplheqnecuggftrfgrthhtvghrnhepgedttdevfffhueduvddvgfeufedtudevgefgteehhfehudelteehteekteeuffeinecuffhomhgrihhnpehophgvnhifrhhtrdhorhhgnecukfhppeduvdejrddtrddtrddupdefuddruddurddvudekrddutdeipdehuddrvdehhedrjedurdeitddpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjeehpdhmohguvgepshhmthhpohhuth

On 2024-03-28 15:19, Christian Marangi wrote:
> On Wed, Mar 27, 2024 at 11:15:02PM +0100, Rafał Miłecki wrote:
>> On 22.03.2024 05:09, Christian Marangi wrote:
>> > diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
>> > index 5887feb347a4..0de87bc63840 100644
>> > --- a/drivers/mtd/mtdcore.c
>> > +++ b/drivers/mtd/mtdcore.c
>> > @@ -900,7 +900,7 @@ static struct nvmem_device *mtd_otp_nvmem_register(struct mtd_info *mtd,
>> >   	config.name = compatible;
>> >   	config.id = NVMEM_DEVID_AUTO;
>> >   	config.owner = THIS_MODULE;
>> > -	config.add_legacy_fixed_of_cells = true;
>> > +	config.add_legacy_fixed_of_cells = !mtd_type_is_nand(mtd);
>> >   	config.type = NVMEM_TYPE_OTP;
>> >   	config.root_only = true;
>> >   	config.ignore_wp = true;
>> 
>> I think there may be even more unwanted behaviour here. If
>> mtd_otp_nvmem_register() fails to find node with "user-otp" /
>> "factory-otp" compatible then it sets "config.of_node" to NULL but 
>> that
>> means NVMEM core still looks for NVMEM cells in device's "of_node".
>> 
>> I believe we should not look for OTP NVMEM cells out of the "user-otp" 
>> /
>> "factory-otp" compatible nodes.
>> 
>> So maybe what we need in the first place is just:
>> config.add_legacy_fixed_of_cells = !!np;
>> ?
>> 
>> Any extra limitation of .add_legacy_fixed_of_cells should probably be
>> used only if we want to prevent new users of the legacy syntax. The
>> problem is that mtd.yaml binding allowed "user-otp" and "factory-otp"
>> with old syntax cells. It means every MTD device was allowed to have
>> them.
>> 
>> No in-kernel DTS even used "user-otp" or "factory-otp" with NVMEM 
>> legacy
>> cells but I'm not sure about downstream DTS files. Ideally we would do
>> config.add_legacy_fixed_of_cells = false;
>> but that could break compatibility with some downstream DTS files.
> 
> Yes the main problem is prevent regression in downstream. I feel for 
> the
> nand usage, this is 100% of the times broken. For SPI and other corner
> case MTD devices it's not?
> 
> Anyway did you by chance have a suggestion for a better fixes tag?

My personal idea for that would be to put two Fixes with two commits and
describe in commit body that one just exposed existing bug.

You may check my OpenWrt quick patch for an idea how I'd handle that:
https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/generic/pending-6.6/440-mtd-don-t-look-for-OTP-legacy-NVMEM-cells-if-proper-.patch;h=d9d15a4048c144d8565c8ea38e15a79f7f4a5fe1;hb=dd78a59cd7b029560b33cb3ac0e1aa8b747bd807

-- 
Rafał Miłecki

