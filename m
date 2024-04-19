Return-Path: <linux-kernel+bounces-151992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4CA8AB71B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381A61C20C03
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0071E13D289;
	Fri, 19 Apr 2024 22:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="klmOHkgY"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA79B13D248
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 22:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564713; cv=none; b=Ei+u1IppNuZfTaW/MTXIh7z2QqNppkoZtT+0BKCIQjhvomq7QCBnaQiW1bOvO5bPrpdiZwH5DaxRNMSFd6oV3t790VnQFA5Lp7F1P9A9ufe8+gsPzzR12sPqc+0tgqgSYs+WqNIHXl12QOnvERPgTA1m5OQqiB7B6raXwEXv1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564713; c=relaxed/simple;
	bh=UYppbqgkb9HL8eP99TFkv4gWxzja0p1FvJqGbmTcDAs=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXbaBcJgEiTtN39O4093fF+e7B9FU4/0SYyDrhqYsxyeIbpfMaCbWjL/vEjNPuclM6Hv/fCMY3Y/SyvmtsJH1GsTqZ5baHW0ECfEo/iz3EpwbOkh1Ks4fQZBQ6pLNu22+ncw2BJs5x7yNrXa+YXMVJmxg44ySG5Mt7QLe9f8NHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=klmOHkgY; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4C0F43F1B4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 22:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713564709;
	bh=qDs1PP73Myr2habNrM7w8WokE4Tu9ltpN7loN9K/23g=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=klmOHkgYk/n2LOTPqho1MopK9AUepx8w88mJDGFGoevfHmBG6ChY/aEpcfTE1d5eU
	 +1AXdagyxC07nx9R8BkxnL8M8kqcSWIpYDvDN4nqMcBddvcWvpyd21l+ow0K38RdeZ
	 mcvYhz1Ba8yHyWiDhRTzSvGOldKqPCO2Oj+Tzvl354hzUTZHH1r1NCcPn/aMjTkouN
	 /3zf6vxqEbtKDCSI7rpbpnB4p2xV+OuLxZh33Vco6HZnaLGDNpRStvs85OvNShSxUw
	 Qf9Sn2318kp52aD19+1dhagmTWB2P+zrxIbjWk/Mugsl6mEY6RTWqWDPxpXzvoQ1G7
	 dRnvLtMWGs45Q==
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c709618a03so3429236b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713564708; x=1714169508;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qDs1PP73Myr2habNrM7w8WokE4Tu9ltpN7loN9K/23g=;
        b=Cxw9m8aP4qGHlLgTud6Im2qHIyltf5q+uyBikizcHIdXL2xrteLh8qCyx+aZTkDLC4
         qb3vhp7ONJmiEIjKX62H4YkPIxTHNJdE0CWYKYN2HBNxGQvcD5BaGqI3m3ccFo9zNrtW
         EVB2mefrickgaaRXFfd4glocM7uSyqPCc37bReh7AK5nsE9JNHK5E7NhvoVV2cZup4mq
         4PIQ3L/akjzBNTrjdODH4rVk2d8b480L2EhfcS5OpIB6a7TRTgvuuR+mz4A9yseLJsjn
         XRcoHSviY3ac2nesTmQWNUj2HnCJzlZBFNEha6qgnw2NogqibnOB0ukTtKpZLLKxkvlw
         BSwA==
X-Forwarded-Encrypted: i=1; AJvYcCX7YCKhj6LreYtvLzghzyb5gFGPgZe2kY5GiDGay18nkYX2N0Aurh+fd9ENVCjQnN6v+2Mb+GQECnIB3EBzQubeACcWEJXp6irStvmx
X-Gm-Message-State: AOJu0YySTPhRD6HTvjLcN9dBMW5eyTpaD+b8ruY6Ypb/BRRHhDriaDsj
	jy+WSF5UjtVzxA0ukX0Y9NAoC4oVEWWNXn2/ZfGoqJ8QYyFKgzxxtnnGt4ngUjp+ql+TjP3rV9f
	XNWajmsqzDdE7OhKiYWbs2/VPYfsSBlQZ95dNaZ0BAd9g3NoYXwFIFMyn5Y5ut1jWDnTaYnYNcv
	C/pJX+hiGbT20z4/enZi+CmZBYwEcWI+NagatkX3zycvMZpHeUvYjp
X-Received: by 2002:a05:6808:aa4:b0:3c7:df4:8fb2 with SMTP id r4-20020a0568080aa400b003c70df48fb2mr3355965oij.33.1713564708129;
        Fri, 19 Apr 2024 15:11:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE24uPXK76ve4p+kz9T9NLOzorCp/2i7z+OZo/ijMXuEyfIYaaX+7aIp5O26ess0IsJvcz+NdmGN13nL+4dm4U=
X-Received: by 2002:a05:6808:aa4:b0:3c7:df4:8fb2 with SMTP id
 r4-20020a0568080aa400b003c70df48fb2mr3355944oij.33.1713564707849; Fri, 19 Apr
 2024 15:11:47 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Apr 2024 15:11:47 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <ZgrIXHNRTB_NeDeF@xhacker>
References: <20240131132600.4067-1-jszhang@kernel.org> <20240131132600.4067-7-jszhang@kernel.org>
 <20240206-magma-deem-2c88e45a545a@spud> <43918921-0d05-41d3-a19b-f137314e868d@canonical.com>
 <ZgYn9t4akccWuHyf@xhacker> <013f6d51-7f78-4de0-945d-8902f32c850a@canonical.com>
 <ZgrIXHNRTB_NeDeF@xhacker>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 19 Apr 2024 15:11:47 -0700
Message-ID: <CAJM55Z_BemQoQ8Qrcz_vYOJ3n+-3DKn_iu==58euv9HWa99dEw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] riscv: dts: starfive: add Milkv Mars board device tree
To: Jisheng Zhang <jszhang@kernel.org>, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Emil Renner Berthing <kernel@esmil.dk>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jisheng Zhang wrote:
> On Mon, Apr 01, 2024 at 03:28:33PM +0200, Heinrich Schuchardt wrote:
> > On 3/29/24 03:31, Jisheng Zhang wrote:
> > > On Thu, Mar 28, 2024 at 10:28:28PM +0100, Heinrich Schuchardt wrote:
> > > > On 2/6/24 20:13, Conor Dooley wrote:
> > > > > On Wed, Jan 31, 2024 at 09:26:00PM +0800, Jisheng Zhang wrote:
> > > > > > The Milkv Mars is a development board based on the Starfive JH7=
110 SoC.
> > > > > > The board features:
> > > > > >
> > > > > > - JH7110 SoC
> > > > > > - 1/2/4/8 GiB LPDDR4 DRAM
> > > > > > - AXP15060 PMIC
> > > > > > - 40 pin GPIO header
> > > > > > - 3x USB 3.0 host port
> > > > > > - 1x USB 2.0 host port
> > > > > > - 1x M.2 E-Key
> > > > > > - 1x eMMC slot
> > > > > > - 1x MicroSD slot
> > > > > > - 1x QSPI Flash
> > > > > > - 1x 1Gbps Ethernet port
> > > > > > - 1x HDMI port
> > > > > > - 1x 2-lane DSI and 1x 4-lane DSI
> > > > > > - 1x 2-lane CSI
> > > > > >
> > > > > > Add the devicetree file describing the currently supported feat=
ures,
> > > > > > namely PMIC, UART, I2C, GPIO, SD card, QSPI Flash, eMMC and Eth=
ernet.
> > > > > >
> > > > > > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
..
> > > > > > +
> > > > > > +&mmc1 {
> > > > > > +	disable-wp;
> > > >
> > > > Due to which difference is 'disable-wp' necessary for the Mars boar=
d and not
> > > > necessary for the VisionFive 2 board?
> > >
> > > Mars doesn't have wp pin, but dunno vf2 case since I don't have a VF2
> > > board ;)

The schematic is available here:
https://doc-en.rvspace.org/VisionFive2/PDF/RV002_V1.3B_20230208.PDF

> >
> > If the Milk-V Mars does not have a WP GPIO, we should be able to drop t=
his
> > property. The VisionFive 2 does not need it either.
>
> Nope, dropping this property would result in RO sdcard on vf2.
> >
> > > >
> > > > > > +	cd-gpios =3D <&sysgpio 41 GPIO_ACTIVE_LOW>;
> > > >
> > > > On my VisionFive 2 1.2B, and 1.3A boards GPIO 41 reflects if an SD-=
card is
> > > > inserted (as shown in U-Boot by gpio status -a). So shouldn't this =
value be
> > > > moved to the common include "jh7110-visionfive2-mars-common.dtsi" a=
nd
> > > > broken-cd removed from the VisionFive2 board?
> > >
> > > I tested the CD pin and can confirm it works on Mars, but I dunno whe=
ther
> > > this works on VF2 since I have no VF2 board.
> > > Could you please check whether it works or not on VF2?
> >
> > As mentioned in my prior mail the card detect GPIO is working on the
> > VisionFive 2. StarFive acknowledged my U-Boot patch:
> >
> > https://lore.kernel.org/u-boot/SHXPR01MB086314C47C281B3DDDF7BAE9E63AA@S=
HXPR01MB0863.CHNPR01.prod.partner.outlook.cn/
>
> Thanks for confirmation.

Actually comparing the schematic for the VF2 above and the Mars board[1] I
don't see any differences in how the SD-card is connected, so if I'm right =
the
mmc1 node could be fully defined in the jh7110-common.dtsi.

[1]: https://github.com/milkv-mars/mars-files/blob/main/Mars_hardware_schem=
atics/Mars_V1.11_20230821.pdf

/Emil

>
> >
> > Best regards
> >
> > Heinrich
> >
> > >
> > > >
> > > > https://doc-en.rvspace.org/VisionFive2/PDF/SCH_RV002_V1.2A_20221216=
pdf
> > > > has a line
> > > >
> > > >      GPIO41 | SD_SDIO0_CD_GPIO41 | Micro SD=EF=BC=9AJ10
> > > >
> > > > Best regards
> > > >
> > > > Heinrich
> > > >
> > > > > > +};
> > > > > > --
> > > > > > 2.43.0
> > > >
> >

