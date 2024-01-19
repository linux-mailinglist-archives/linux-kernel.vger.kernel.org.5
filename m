Return-Path: <linux-kernel+bounces-31208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E10832A99
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4681C23A23
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6C053804;
	Fri, 19 Jan 2024 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qkLmQzVh"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7310252F7C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671341; cv=none; b=Uceh3SkZV3OeSGOgWssPt7nJuwaoUvzLBt8QVIC6S6JAlMbH9ShGFLZnhxRy3IbD4/SlfEmhp/4skYgngYPs1RB1sad/WCQmUOp/o062ITkVnf8988v6CjPWpXF5IDJ2rNAqaVu1m0V/9d+Xqln1n3HxvPtR8DrAPRY7UI/COXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671341; c=relaxed/simple;
	bh=yiI86I5gHRG/HoqT9qSoOayumgDBCDCKPfF6rOc+WW4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amx68HQl8njv1lSwlwSHyDMt5BuSKuERqljMtAuTiSQFGaFXf3CxyXTMlwHx1qerYpv9X1n/2voOBYoL3dqihRuoaNZJUpdi8KeRQz/ElDHrn8T6+tmD1ahCAn2M+G6SVIIW2JaJZEntigYBSG33wHrGUD0WqoNYGWyd7VNBmMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qkLmQzVh; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d2ded146cbso90035241.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 05:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705671338; x=1706276138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MFcJPX/tMH3HP3YK+mAZ7w3k83QON/otK7FNXqhhh5I=;
        b=qkLmQzVhdtKfz3bqdIVoErhWKMcX4s7BV0eBzcCf6YcMB1AFT16DrIGzqldNnIz/JS
         CLGHAyIkII5lHmcrw54+79BuOAwqBRwyrUeu8p+IEl+20IR5TzhEoD7qgreCOwLsVE1q
         MYNesH6DT/eN3K1gd8UYVFdjvyGm2Ez2zXK6dv0ZLx898JxbNApJZBbZSZHHk/K02HfL
         iaCCIzdJ7FJzUXRU+tJYyAiE0d+iz2Cq8Po9sVLyYYM6ShVPbViCUN4QMm1PRMd+siLT
         hbSoraOLhHqsb/GF+d0MQRU0ns5+5qTZ8iQLfmYnhcT7t1RXriNXZRSyOigEbrG3QlbN
         SOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705671338; x=1706276138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MFcJPX/tMH3HP3YK+mAZ7w3k83QON/otK7FNXqhhh5I=;
        b=gTxorQDjPt1y9ZgJhjm6oDdpqc7uy5GrJqy2MYag/F0++Y4VssNvVHN4cS6joEXJHH
         SYsxwVRj/GEYGoSFvSmWd5qeDDJ2USv38DPyyhwb8dQjwuPlvWMNblcDXN89bo8tcBJe
         AdFCoGOOvN0nkr/w+INMfg+XFx5iqg0d98Uv+B57hqzbRfAABsVCvjJxxQU1SJLVUx+I
         VqS8SbwDU65mzHbSuKzugl+FMFEIeskSx8PVD58Fwam7X7VinA9WC8lJr0Qu8oli/gAF
         EQzxuro4Q9ISNZoKYj7YLdLbZsdFfkCaaLb0wC05gu+yUg6c5S/ZndPu3qbqkJQOnCFq
         Kc0Q==
X-Gm-Message-State: AOJu0YzhF7QJbWnoY6lLnOu1X+07xuWVILJL8Wge3/e0Tydctr+jge2i
	vuzSBwc1JndAJkM4Btr4DzQzF80S8Zy/vuRTue4sxnDxI95fa6gk68eFlX2T0e2Ad61CCUHmm2o
	d0Yb17/xhNp0QW4UF5YdEjpU2Fs8xy5qJjFUQDA==
X-Google-Smtp-Source: AGHT+IHtiAlznGMHxXmouh4A2/+guzqh7G9NE3arpc3+6Xsoj6ApH5/MO/HpkzGmPXPrTZ7lEuSC3GsYcrm1POCp6n4=
X-Received: by 2002:ac5:cd93:0:b0:4b7:8d7c:346f with SMTP id
 i19-20020ac5cd93000000b004b78d7c346fmr1888914vka.9.1705671338177; Fri, 19 Jan
 2024 05:35:38 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 Jan 2024 05:35:37 -0800
From: brgl@bgdev.pl
In-Reply-To: <CAA8EJprFV6SS_dGF8tOHcBG+y8j74vO0B40Y=e7Kj1-ZThNqPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117160748.37682-1-brgl@bgdev.pl> <CAA8EJpoQfPqoMVyTmUjPs4c1Uc-p4n7zNcG+USNjXX0Svp362w@mail.gmail.com>
 <CAA8EJpqyK=pkjEofWV595tp29vjkCeWKYr-KOJh_hBiBbkVBew@mail.gmail.com>
 <CAMRc=McUZh0jhjMW7H6aVKbw29WMCQ3wdkVAz=yOZVK5wc45OA@mail.gmail.com> <CAA8EJprFV6SS_dGF8tOHcBG+y8j74vO0B40Y=e7Kj1-ZThNqPA@mail.gmail.com>
Date: Fri, 19 Jan 2024 05:35:37 -0800
Message-ID: <CAMRc=MdOALzkDtpnbqF16suShvP5apGYy4LTQ4dTc3r9Rbb1kg@mail.gmail.com>
Subject: Re: [PATCH 0/9] PCI: introduce the concept of power sequencing of
 PCIe devices
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
	Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <terry.bowman@amd.com>, 
	Lukas Wunner <lukas@wunner.de>, Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jan 2024 13:31:53 +0100, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> said:
> On Fri, 19 Jan 2024 at 13:52, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> On Thu, Jan 18, 2024 at 7:53=E2=80=AFPM Dmitry Baryshkov
>> <dmitry.baryshkov@linaro.org> wrote:
>> >
>>
>> [snip]
>>
>> > >
>> > > I'd still like to see how this can be extended to handle BT power up=
,
>> > > having a single entity driving both of the BT and WiFI.
>> > >
>> > > The device tree changes behave in exactly the opposite way: they
>> > > define regulators for the WiFi device, while the WiFi is not being
>> > > powered by these regulators. Both WiFi and BT are powered by the PMU=
,
>> > > which in turn consumes all specified regulators.
>> >
>> > Some additional justification, why I think that this should be
>> > modelled as a single instance instead of two different items.
>> >
>> > This is from msm-5.10 kernel:
>> >
>> >
>> > =3D=3D=3D=3D=3D CUT HERE =3D=3D=3D=3D=3D
>> > /**
>> >  * cnss_select_pinctrl_enable - select WLAN_GPIO for Active pinctrl st=
atus
>> >  * @plat_priv: Platform private data structure pointer
>> >  *
>> >  * For QCA6490, PMU requires minimum 100ms delay between BT_EN_GPIO of=
f and
>> >  * WLAN_EN_GPIO on. This is done to avoid power up issues.
>> >  *
>> >  * Return: Status of pinctrl select operation. 0 - Success.
>> >  */
>> > static int cnss_select_pinctrl_enable(struct cnss_plat_data *plat_priv=
)
>> > =3D=3D=3D=3D=3D CUT HERE =3D=3D=3D=3D=3D
>> >
>> >
>> > Also see the bt_configure_gpios() function in the same kernel.
>> >
>>
>> You are talking about a different problem. Unfortunately we're using
>> similar naming here but I don't have a better alternative in mind.
>>
>> We have two separate issues: one is powering-up a PCI device so that
>> it can be detected and the second is dealing with a device that has
>> multiple modules in it which share a power sequence. The two are
>> independent and this series isn't trying to solve the latter.
>
> I see it from a different angle: a power up of the WiFi+BT chips. This
> includes devices like wcn3990 (which have platform + serial parts) and
> qca6390 / qca6490 / wcn6750 / etc. (which have PCI and serial parts).
>
> From my point of view, the PCIe-only part was nice for an RFC, but for
> v1 I have expected to see a final solution that we can reuse for
> wcn3990.
>

The submodules are represented as independent devices on the DT and I don't
think this will change. It's not even possible as they operate on different
buses so it's not like we can MFD it with a top-level platform device and t=
wo
sub-nodes of which one is PCI and another serdev. With that in mind, I'm
insisting that there are two separate issues and a generic power sequencing
can be built on top of the PCI-specific pwrseq added here.

>>
>> But I am aware of this and so I actually have an idea for a
>> generalized power sequencing framework. Let's call it pwrseq as
>> opposed to pci_pwrseq.
>>
>> Krzysztof is telling me that there cannot be any power sequencing
>> information contained in DT. Also: modelling the PMU in DT would just
>> over complicate stuff for now reason. We'd end up having the PMU node
>> consuming the regulators but it too would need to expose regulators
>> for WLAN and BT or be otherwise referenced by their nodes.
>
> Yes. And it is a correct representation of the device. The WiFi and BT
> parts are powered up by the outputs from PMU. We happen to have three
> different pieces (WiFi, BT and PMU) squashed on a single physical
> device.
>

Alright, so let's imagine we do model the PMU on the device tree. It would
look something like this:

qca6390_pmu: pmic@0 {
	compatible =3D "qcom,qca6390-pmu";

	bt-gpios =3D <...>;
	wlan-gpios =3D <...>;

	vdd-supply =3D <&vreg...>;
	...

	regulators-0 {
		vreg_x: foo {
			...
		};

		...
	};
};

Then the WLAN and BT consume the regulators from &qca6390_pmu. Obviously we
cannot go:

wlan {
	pwrseq =3D &qca6390_pmu;
};

But it's enough to:

wlan {
	vdd-supply =3D <&vreg_x>;
};

But the pwrseq driver for "qcom,qca6390-pmu" could map BT and WLAN compatib=
les
to the correct power sequence and then the relevant drivers could enable it
using pwrseq_power_on().

But that comes back to what I'm doing here: the PCI part for ath11k still
needs the platform driver that will trigger the power sequence and that cou=
ld
be the PCI pwrseq driver for which the framework is introduced in this seri=
es.

As I said: the two are largely orthogonal.

>>
>> So I'm thinking that the DT representation should remain as it is:
>> with separate WLAN and BT nodes consuming resources relevant to their
>> functionality (BT does not need to enable PCIe regulators).
>
> Is it so? The QCA6390 docs clearly say that all regulators should be
> enabled before asserting BT_EN / WLAN_EN. See the powerup timing
> diagram and the t2 note to that diagram.
>

Fair enough.

>> Now how to
>> handle the QCA6490 model you brought up? How about pwrseq drivers that
>> would handle the sequence based on compatibles?
>
> The QCA6490 is also known as WCN6855. So this problem applies to
> Qualcomm sm8350 / sm8450 platforms.
>
> And strictly speaking I don't see any significant difference between
> QCA6390 and WCN6855. The regulators might be different, but the
> implementation should be the same.
>
>>
>> We'd add a new subsystem at drivers/pwrseq/. Inside there would be:
>> drivers/pwrseq/pwrseq-qca6490.c. The pwrseq framework would expose an
>> API to "sub-drivers" (in this case: BT serdev driver and the qca6490
>> power sequencing driver). Now the latter goes:
>>
>> struct pwrseq_desc *pwrseq =3D pwrseq_get(dev);
>>
>> And the pwrseq subsystem matches the device's compatible against the
>> correct, *shared* sequence. The BT driver can do the same at any time.
>> The pwrseq driver then gets regulators, GPIOs, clocks etc. and will be
>> responsible for dealing with them.
>>
>> In sub-drivers we now do:
>>
>> ret =3D pwrseq_power_on(pwrseq);
>>
>> or
>>
>> ret =3D pwrseq_power_off(pwrseq);
>>
>> in the sub-device drivers and no longer interact with each regulator
>> on our own. The pwrseq subsystem is now in charge of adding delays
>> etc.
>>
>> That's only an idea and I haven't done any real work yet but I'm
>> throwing it out there for discussion.
>
> I've been there and I had implemented it in the same way, but rather
> having the pwrseq as a primary device in DT and parsing end-devices
> only as a fallback / compatibility case.
>

Would you mind posting an example DT code here? I'm not sure if I understan=
d
what "primary device" means in this context.

Bartosz

>
>
> --
> With best wishes
> Dmitry
>

