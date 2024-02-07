Return-Path: <linux-kernel+bounces-56768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6F084CEE8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E3828BBAC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E65E5A10B;
	Wed,  7 Feb 2024 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZL+hZ9pA"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA85D35280
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323573; cv=none; b=kROnr87VhR4/gbRRHRsh8S3NBhkWGg3i7Gp7wq6rjqSECRAXZP/d3uj6bhjSVLxWHuiJ4Nkjmj/KheJke/7S7+iNQdg5zww611c7kanfAKAGM7T0LA4ScHLIBiTi/JRo5Y4ikPCpVn61tpll1JjEFe35lD7quWNnVGsqDGxn0cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323573; c=relaxed/simple;
	bh=6Yo/fyYh7fG38u08ZGJVpdUslT92MuMedlOE+fskdT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=It1oHIGEBm5QsgDaLHGroLIrKB4LkENNU9dMNEbXkL1MIOR1jYD4lD7lgyD4l0/m+pJ+js7ApBzyPO0jcc0Bb23GjuyI9tWWLJ1hx83ppnx2oNx0hdF2AnT1l0KEH8mV83eYGi48cBbY7M4uYlIwDewao5U3LIqnYAlv+G9CszI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZL+hZ9pA; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6d2e82f72so776514276.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 08:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707323570; x=1707928370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Yo/fyYh7fG38u08ZGJVpdUslT92MuMedlOE+fskdT4=;
        b=ZL+hZ9pAzfYVNJ5X4fBcLg98ndLaGNBYNck/AGtAA7VIwl+S3EzDE5SR8pbD2kfH5l
         Z1TncIKTTzRVVDES9JJYV1zrVXgx57Vi5m1lZvp14iG/TIlWwfTNZRULuKa4ZQGQDo/j
         rNpe1Svy1sqh88W83WF4u3ZZozQpX6xZX0Go07Cl6o0E9jfIwQ4upB2+hN5+d8mQy7jQ
         HCj7onieCi3bvpel3sD5Y6BilbfKMoDilGzKNVagV77JXL4aFaBNsdNcb9Tfa/fFwj7a
         gZKGCWpVW7Xialj9vVy7WMbglDL3NPCof+8Bn+QFI1EhM2cqXmOzVqJd10LSat8CbeAi
         7mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707323570; x=1707928370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Yo/fyYh7fG38u08ZGJVpdUslT92MuMedlOE+fskdT4=;
        b=eO+ZzSp2V6EKA0GXQtBj/HJoVDuCzEsQ/voJmbH3R6+lmWDBvEWZ4aDlzBxTjLh03Y
         Aw6UTt4IuFh1IUgh6DStQk61LO3aehuAgMtvBpsyDPevI1unuKcZFMRCLMxJqn4mt7Ek
         I9Gu9ob90FElz4Uc9qX9Xqxf6d9q+xK5xw2D0891htdcGdZL9BzHT8WyA0jf1atU+TJU
         qnz1Zhva1AKaKus3c9Q7Sq9D8ECI2EY/GY+v9TAH7pJ9QxrkflIuh4H/gdK/l24hfF9F
         9Gu7T8RHAFv4dHJyOkr/FhhRoD1WR9LlYTZCDy5FEOVs/nEw0rnvfJDb0zy/kb7h9RrL
         zWxw==
X-Gm-Message-State: AOJu0YxxJZm3TpLAKMHx20tasE+jBqID8bCRhLFLfutZ4BoqzSjeKVwu
	t2XRlxyIrt/NqG6Opjc0ef2561wNBRTJwHQ+QGJU6+yJrqB97BXcDyrvwSKRR9WRhi3qCK6hODR
	JwR26LlsqKeV+8CK4Ga+jDOY1uzdHKQQQUVAE1g==
X-Google-Smtp-Source: AGHT+IE3zCdfJVGHV2I6xOZuAs5X41g7XZwMrMfSjZMfsSrqtH+jCnKdu76h60nVbqejDK2GD8n0GFHFIxgNUHOMEGE=
X-Received: by 2002:a5b:74f:0:b0:dc6:de64:f74 with SMTP id s15-20020a5b074f000000b00dc6de640f74mr4960135ybq.9.1707323569174;
 Wed, 07 Feb 2024 08:32:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117160748.37682-1-brgl@bgdev.pl> <20240117160748.37682-5-brgl@bgdev.pl>
 <2024011707-alibi-pregnancy-a64b@gregkh> <CAMRc=Mef7wxRccnfQ=EDLckpb1YN4DNLoC=AYL8v1LLJ=uFH2Q@mail.gmail.com>
 <2024011836-wok-treadmill-c517@gregkh> <d2he3ufg6m46zos4swww4t3peyq55blxhirsx37ou37rwqxmz2@5khumvic62je>
 <CAMRc=MeXJjpJhDjyn_P-SGo4rDnEuT9kGN5jAbRcuM_c7_aDzQ@mail.gmail.com>
 <oiwvcvu6wdmpvhss3t7uaqkl5q73mki5pz6liuv66bap4dr2mp@jtjjwzlvt6za> <CAMRc=McT8wt6UbKtyofkJo3WcyJ-S4d2MPp8oZmjWbX6LGbETQ@mail.gmail.com>
In-Reply-To: <CAMRc=McT8wt6UbKtyofkJo3WcyJ-S4d2MPp8oZmjWbX6LGbETQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 7 Feb 2024 17:32:38 +0100
Message-ID: <CAMRc=MeWgp27YcS=-dbYdN1is1MEuZ2ar=pW_p9oY0Nf1EbFHA@mail.gmail.com>
Subject: Re: Re: Re: [PATCH 4/9] PCI: create platform devices for child OF
 nodes of the port node
To: Bjorn Andersson <andersson@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
	Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <terry.bowman@amd.com>, 
	Lukas Wunner <lukas@wunner.de>, Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 11:02=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Fri, Feb 2, 2024 at 1:03=E2=80=AFAM Bjorn Andersson <andersson@kernel.=
org> wrote:
> >
>
> [snip]
>
> > > >
> > > > I believe I missed this part of the discussion, why does this need =
to be
> > > > a platform_device? What does the platform_bus bring that can't be
> > > > provided by some other bus?
> > > >
> > >
> > > Does it need to be a platform_device? No, of course not. Does it make
> > > sense for it to be one? Yes, for two reasons:
> > >
> > > 1. The ATH11K WLAN module is represented on the device tree like a
> > > platform device, we know it's always there and it consumes regulators
> > > from another platform device. The fact it uses PCIe doesn't change th=
e
> > > fact that it is logically a platform device.
> >
> > Are you referring to the ath11k SNOC (firmware running on co-processor
> > in the SoC) variant?
> >
> > Afaict the PCIe-attached ath11k is not represented as a platform_device
> > in DeviceTree.
> >
>
> My bad. In RB5 it isn't (yet - I want to add it in the power
> sequencing series). It is in X13s though[1].
>
> > Said platform_device is also not a child under the PCIe bus, so this
> > would be a different platform_device...
> >
>
> It's the child of the PCIe port node but there's a reason for it to
> have the `compatible` property. It's because it's an entity of whose
> existence we are aware before the system boots.
>
> > > 2. The platform bus already provides us with the entire infrastructur=
e
> > > that we'd now need to duplicate (possibly adding bugs) in order to
> > > introduce a "power sequencing bus".
> > >
> >
> > This is a perfectly reasonable desire. Look at our PMICs, they are full
> > of platform_devices. But through the years it's been said many times,
> > that this is not a valid or good reason for using platform_devices, and
> > as a result we have e.g. auxiliary bus.
> >
>
> Ok, so I cannot find this information anywhere (nor any example). Do
> you happen to know if the auxiliary bus offers any software node
> integration so that the `compatible` property from DT can get
> seamlessly mapped to auxiliary device IDs?
>

So I was just trying to port this to using the auxiliary bus, only to
find myself literally reimplementing functions from
drivers/of/device.c. I have a feeling that this is simply wrong. If
we're instantiating devices well defined on the device-tree then IMO
we *should* make them platform devices. Anything else and we'll be
reimplementing drivers/of/ because we will need to parse the device
nodes, check the compatible, match it against drivers etc. Things that
are already implemented for the platform bus and of_* APIs.

Greg: Could you chime in and confirm that it's alright to use the
platform bus here? Or maybe there is some infrastructure to create
auxiliary devices from software nodes?

Bartosz

> > Anyway, (please) don't claim that "we need to", when it actually is "we
> > want to use platform_device because that's more convenient"!
>
> Bart
>
> [snip]
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts#n744

