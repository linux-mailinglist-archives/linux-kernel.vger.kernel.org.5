Return-Path: <linux-kernel+bounces-103594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C591987C18D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24427B2283E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E192D74402;
	Thu, 14 Mar 2024 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaXBx30C"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670A46F524
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435055; cv=none; b=LjEFMa/mDoPEnC8vtPmZ62tlz7Ape/WcihkACiOipQhV44DUMgmRfjmNM87ARkl7hqBVyBFCoBK2YoBH9OA09VG7pvzmg+0K8L6GHtTV54AyT+Cc/SP3a1rdvQEk/WIPyLN3WqI7m9S3XQ9woclEJB1CV/y59har8B8XrHXQk9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435055; c=relaxed/simple;
	bh=8/LHmabbFOa2irz28iyD2mUOsrRWs77lzjfbdo5vmdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAm9fAALas5EpSCSRTln57hLXZkrI3PSIiiUZn+Sate29tL5repECHI//NLu0DVF0sG0WKNZ8azSWJqtAmkSdPQkRhvsrlRSDizKFF0n1M/Z2/+C+wRYLTc/A9Nqpebco7SY/WqAuQX5uslT3lsrcDfJZBOYyf2Yfq09+vkicDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaXBx30C; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3122b70439so143086166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710435052; x=1711039852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2RYm1vaspI8Y3As/a7F8BfaRLfVKAt2m0ryDQAGWpA=;
        b=BaXBx30CtIvml/n912HRmRM6fg2+M3Zq6FJAJws0OLnZD7QZUPsmSOzC/kRyARaHn3
         NRYDM0CNA304G8uci0iyre46vwqNAl1u+2l2/Jc4QZ0nvpHYLCM63Y1TUf/oUsdgke1y
         tIfLw2qLcdaotGVxl5hBIEQKWM+iOgaVSlYnnUzjBwVEhfQcvEtFPAd8CU4X+tm5cy5u
         kkBaIU1Glb1PNFoViMsnG1EKVGtvPjLbSMy2yWaG54Oxk2Zd0hQ58CvUn4yKwAPpJCMm
         dd6olkmKedrssacCt/dLGgUZfgt1REHdELTcd6PQIgNYH2HdpmXXxuKssplEGoTgpVdI
         S3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710435052; x=1711039852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2RYm1vaspI8Y3As/a7F8BfaRLfVKAt2m0ryDQAGWpA=;
        b=wJlpf4K6E9OWoMi/YtymIEtcBNUqj0riSs0+TJDMqeEZgmEy4dR01sBXTRS+0LQspk
         ynGFkMCqlQJ7El4x1KJ551hfiVDMPYc5sCwAlg1OYkMQL79gczZqA9W+gqx7aPqHlkTH
         K4A1N2lQEYx0GCl8PrH91n4CuUhnsO6Mu6YiuYl3TH9+5r47IPNrsJcGcROzPltOP2wj
         fIjZEJg42ulS7SxVM8owlFYv50G1Rwm9QijWRKsLBeEIWF5iMxuHWGucAqUZQ1tx2Cm6
         gdSKxfLbmOM++oOZEWy8k6xHrqgy8a+Tvxn/2jNhpwKoeeoflwHKigfIV673ZZjtfB3S
         oSTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgGZMkPJwm3Hmy2webAbr1BtzgulPXoi+ssT9P44rVIvj6YdTFCFnidz5wcHLg9Llse5Q+ovn7xhuc+XMXD7zRjRC3RPDV5un44hnI
X-Gm-Message-State: AOJu0YxlHaPR4Wsn41D8HZSWMBrTBv+2PWr5jtbRmAX8bF05jlpjeDNQ
	nulWA6Wp+OpGHsz84gjxnxcgUCsCp+PeXN6znYJ3mZQB/DBoSxpv
X-Google-Smtp-Source: AGHT+IFJKP6hw9ITWzKnemudaDXluZtn2m9/KXcvFV7zOjEAbqJJ2r6ERXAFkSkgobY7+7st62Fj/w==
X-Received: by 2002:a17:906:abcd:b0:a45:c8c8:7b99 with SMTP id kq13-20020a170906abcd00b00a45c8c87b99mr1326980ejb.31.1710435051518;
        Thu, 14 Mar 2024 09:50:51 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id b26-20020a170906039a00b00a4547925e3asm875284eja.141.2024.03.14.09.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 09:50:51 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
 Kamil Kasperski <ressetkk@gmail.com>
Cc: wens@csie.org, samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] dts: arm64: sunxi: add initial support for t95 tv box
Date: Thu, 14 Mar 2024 17:50:49 +0100
Message-ID: <4331305.ejJDZkT8p0@jernej-laptop>
In-Reply-To: <55eda2c6-1bca-463d-a908-1887543a47a5@gmail.com>
References:
 <20240311174750.6428-1-ressetkk@gmail.com> <8344274.T7Z3S40VBb@jernej-laptop>
 <55eda2c6-1bca-463d-a908-1887543a47a5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne =C4=8Detrtek, 14. marec 2024 ob 01:19:28 CET je Kamil Kasperski napisal=
(a):
> Hi Jernej, Andre!

Please no top posting as per rules.

>=20
> Thanks for the reply. My board has a name "H616-T95MAX-AXP313A-v3.0".

Ok, we for sure need to integrate this somehow to compatible string, since
there are at least two incompatible versions.

>=20
> I believe these boards are two different revisions and the one with=20
> AXP313A is a newer one, besides incorrectly label as v3.0. Sharing=20
> common configuration between boxes is also a good idea but for this=20
> specific configuration I would be cautious. From my experience with this=
=20
> board the default configuration for X96 Mate is not working at all. I=20
> suspect because of the PMIC and DRAM differences.
>=20
> Memory installed in X96 Mate is DDR3L and in mine T95 it's DDR3, hynix=20
> H5TQ2G43BFR, that requires 1.5V to operate.

PMIC is important difference, yes, but not DRAM. DDR3L is completely compat=
ible
with DDR3. It just additionally supports lower voltages. Additionally, Linux
doesn't care about DRAM type and all. It's firmware responsibility to prope=
rly
initialize it.

Best regards,
Jernej

>=20
> The rest of configuration for both boards, like HDMI, MMC, EPHY and=20
> audio codec seems to be the same across almost all H616-based boxes that=
=20
> I've researched.
>=20
>=20
> Moreover please let me update the patches and send v2 that aligns with=20
> mainline branch. I've incorrectly assumed to use sunxi fork instead of=20
> master. Sorry!
>=20
> W dniu 13.03.2024 o 19:00, Jernej =C5=A0krabec pisze:
> > Dne sreda, 13. marec 2024 ob 18:38:08 CET je Andre Przywara napisal(a):
> >> On Wed, 13 Mar 2024 18:25:14 +0100
> >> Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:
> >>
> >>> Hi Kamil!
> >>>
> >>> Dne ponedeljek, 11. marec 2024 ob 18:47:47 CET je Kamil Kasperski nap=
isal(a):
> >>>> T95 is a most commonly known for being a box with a pre-installed ma=
lware.
> >>>> It uses Allwinner H616 and comes with eMMC and DDR3 memory.
> >>>> This device comes with two versions - one with AXP305 PMIC and anoth=
er with AXP313 PMIC.
> >>> I have this board and it always felt like a clone of X96 Mate, which =
is
> >>> already supported in kernel, except for broken sd card detection. Wou=
ld it
> >>> make sense to unify those two boards and just overwrite or update par=
ts here
> >>> that are not the same?
> >> I think the box you have is an older one, with the AXP305? IIUC, this =
is
> >> about a newer revision with the AXP313. There are quite some differenc=
es
> >> between the two PMICs, though it might still make sense to share the D=
Ts,
> >> see the OrangePi Zero[23].
> > Right, mine is with AXP305. It has "T95MAX v4.0" printed on PCB.
> >
> > Kamil, does your board also have "MAX" mentioned somewhere?
> >
> > Best regards,
> > Jernej
> >
> >> Cheers,
> >> Andre
> >>
> >>>> Kamil Kasperski (3):
> >>>>    dt-bindings: vendor-prefixes: sunxi: add T95 to vendor-prefixes
> >>>>    dt-bindings: arm: sunxi: add t95 compatible string to list of kno=
wn
> >>>>      boards
> >>>>    dts: arm64: sunxi: add initial support for T95 AXP313 tv box
> >>>>
> >>>>   .../devicetree/bindings/arm/sunxi.yaml        |   5 +
> >>>>   .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
> >>>>   arch/arm64/boot/dts/allwinner/Makefile        |   1 +
> >>>>   .../dts/allwinner/sun50i-h616-t95-axp313.dts  | 138 ++++++++++++++=
++++
> >>>>   4 files changed, 146 insertions(+)
> >>>>   create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-t95-a=
xp313.dts
> >>>>
> >>>>   =20
> >>>
> >>>
> >>>
> >>>
> >>
> >
> >
> >
>=20





