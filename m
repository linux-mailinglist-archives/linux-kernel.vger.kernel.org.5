Return-Path: <linux-kernel+bounces-33147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D66A3836540
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90064289ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33033D551;
	Mon, 22 Jan 2024 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiY9/ZK9"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369AC1DDC3;
	Mon, 22 Jan 2024 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705933271; cv=none; b=MVyxelBoaNEbLrPuRp+wn5ysmdBq85LwocymsVRW+dAnf2rWbdXVATT7csjusCVIMB06S4ZHfQZEAA/fXo+XXfdGGAEl8ZnrltOt8Kx454yZ8qD151Ea7brJTk/HRlS5jH5kaEbox2fRsjX3z7QWfI5Vi1Ii3sPzqcX/HAFa8fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705933271; c=relaxed/simple;
	bh=/OiSOf1dxe7/x3O4pUMFGEf8cbKO4q48qz9aptH7mPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nltlOwttoOqLMZU/B85YAj/04xfV5rmIlKm2pXfr9Iw/FNr9Wn5DWWNG7512pr0eTtQOg6Q74Nh9piJJaowFBdwKklG3IIGCFTXvVQ5mmX9OAsXxok+kjFK0Sj4sYhhZzP5BmFzuR661J9Bg+clFkCFmRx1Y0GVDqm8cOWOSVwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiY9/ZK9; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso3357774e87.1;
        Mon, 22 Jan 2024 06:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705933267; x=1706538067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zB3kOyhIcCOt/Jppp5iQur4STVOrQ4FRP/kqR1IvMQ=;
        b=EiY9/ZK91f8FOveruA1BW+LvSQMtCcQd/Ch7yRLlngznQ4rhJSXTWphplNetw+13mc
         DYsGBF0rIp2oMwZy1yGKyEoDxob4q245KESzg9Bqkfsaw+BYMWcRccP3ivwB2Zv8VrOD
         e/F8ZYXQZA8kwL3EriQ8RVJRcM73GXjJ5l+aVTtAedVffdUqcEiWJF4nXtMHDsIU9fEA
         8vpJGwhK/W5TFvSCYzyUgVoahC1lpQYHaFelYVlPxuw3OEp4raegYHRSayvZZKp5eyYP
         CBK2LF0+OjlwZTnAHZG84sc7gEhm1gqaIDVkBhgV/OgCzc2hbgwXvSK6j0/XDk3WB96v
         yEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705933267; x=1706538067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zB3kOyhIcCOt/Jppp5iQur4STVOrQ4FRP/kqR1IvMQ=;
        b=dDhEkXEzUVeodEh/c+9uU8+3kAYna9wP+ply+tiarYHX8UWmwh+8WU8iQIPtRByCec
         vucLFpKXD2vnS8z8pmgyguw02tCL7x1Kj0JYcEHQzLeXRsF4ANWcEt7a8iMfD/mEV4+Z
         D/1zpjmAd9eFnUtGoizU70QT/fgiJ26pzI1hxfrMrokAYMWgz9bpjW4FQnlFSu9dra77
         rONbYsM2BiVJRBgh9aQnTdan85I2LGVCDWgVPXw9gh8A+Z1v20XmYvVEd8J2QfL48lDW
         DGfmg/RSLo2CjM7uF3Ean3gCGpi3NnfTfd65ga2GNGw/Qsih7b5hU+EJzntLw/R+yt08
         /yow==
X-Gm-Message-State: AOJu0YyyU+RiZ3Xj5MWSveKHLHlY9dB/yXFuTdxyiGUHJQfwBwVkArM7
	iFUjHOUW44zmGcT+RGoRKN9Uv5Eqw+nfjg1BnoEgCE6EqwCDbw3prQBMjPYeen1XAHrxjmdBteq
	5LkTHsHgjeDnGYfM57jsI5oi8/xdUDQK7uWVfOg==
X-Google-Smtp-Source: AGHT+IHLzSwUvGmeRcBBFDiiH5cZTAZmJmfsdurhg2UQyjhB1t8qqFCr/veWOFjMkbXydkb2TEAAcQ42inGnrslhZ/Q=
X-Received: by 2002:a05:6512:b01:b0:50e:e3e5:40f8 with SMTP id
 w1-20020a0565120b0100b0050ee3e540f8mr820239lfu.1.1705933266840; Mon, 22 Jan
 2024 06:21:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106222357.23835-1-alchark@gmail.com> <e0302da12345e5539583b2c96d747592@manjaro.org>
 <CABjd4Yw5wTLyK5OPw2S-ipPVCw7RTUeF2J0RgH-Vyis-ng8rTw@mail.gmail.com>
 <d7f2f25071a4d7c72bd286b11836dce7@manjaro.org> <CABjd4Yz11D8ThcT-oCWsQf9jL2idChFYSRYVVu3KNnzwoOwkKQ@mail.gmail.com>
 <f5c05015e042b11a51a9af26c35f18ed@manjaro.org> <CABjd4Yy91MAd2wALp4KQiEub9OyxU+MR+ti5KA_c+yvZT5xaqQ@mail.gmail.com>
 <81a5410c3dbedbd4fe9ce60ab236700c@manjaro.org> <CABjd4YwxoPrKRPmjn-eWsU1N5fXCjAbnRwfKD9DLKgeL2=vHrA@mail.gmail.com>
 <a15edb98c32ca79b75bd4eaf64734561@manjaro.org>
In-Reply-To: <a15edb98c32ca79b75bd4eaf64734561@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 22 Jan 2024 18:20:54 +0400
Message-ID: <CABjd4Yxw_wgjRRO12Zjy75=CA_uuucexVnhVRt3fURJFYQqYSw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: enable built-in thermal monitoring
 on rk3588
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Sebastian Reichel <sebastian.reichel@collabora.com>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Christopher Obbard <chris.obbard@collabora.com>, =?UTF-8?B?VGFtw6FzIFN6xbFjcw==?= <szucst@iit.uni-miskolc.hu>, 
	Shreeya Patel <shreeya.patel@collabora.com>, Kever Yang <kever.yang@rock-chips.com>, 
	Chris Morgan <macromorgan@hotmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 11:57=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> =
wrote:
>
> On 2024-01-22 08:36, Alexey Charkov wrote:
> > On Mon, Jan 22, 2024 at 10:22=E2=80=AFAM Dragan Simic <dsimic@manjaro.o=
rg>
> > wrote:
> >> On 2024-01-22 07:03, Alexey Charkov wrote:
> >> > On Mon, Jan 22, 2024 at 8:55=E2=80=AFAM Dragan Simic <dsimic@manjaro=
org> wrote:
> >> >> On 2024-01-21 19:56, Alexey Charkov wrote:
> >> >> > I think I'll also add a board-specific active cooling mechanism o=
n the
> >> >> > package level in the next iteration, given that Rock 5B has a PWM=
 fan
> >> >> > defined as a cooling device. That will go in the separate patch t=
hat
> >> >> > updates rk3588-rock-5b.dts (your feedback to v2 of this patch is =
also
> >> >> > duly noted, thank you!)
> >> >>
> >> >> Great, thanks.  Sure, making use of the Rock 5B's support for attac=
hing
> >> >> a PWM-controlled cooling fan is the way to go.
> >> >>
> >> >> Just to reiterate a bit, any "active" trip points belong to the boa=
rd
> >> >> dts file(s), because having a cooling fan is a board-specific featu=
re.
> >> >> As a note, you may also want to have a look at the RockPro64 dts(i)
> >> >> files, for example;  the RockPro64 also comes with a cooling fan
> >> >> connector and the associated PWM fan control logic.
> >> >
> >> > Thanks for the pointer! There is also a helpful doc within devicetre=
e
> >> > bindings descriptions, although it sits under hwmon which was a bit
> >> > confusing to me. I've already tested it locally (by adding to the
> >> > board dts), and it spins up and down quite nicely, and even modulate=
s
> >> > the fan speed swiftly when the load changes - yay!
> >>
> >> Nice!  Also, isn't it like magic? :)  To me, turning LEDs on/off and
> >> controlling fans acts as some kind of a "bridge" between the virtual
> >> and the real world. :)
> >
> > Oh yes! I also keep admiring how one can add just a couple of lines of
> > text here and there that's not even real code, and the whole kernel
> > machinery starts crunching numbers, analyzing temperatures, running
> > PID loops, etc etc so that I could enjoy the satisfying whistle of a
> > small fan when I type `make -j8` :-D
>
> Yes, it's very satisfying, :) and it also demonstrates the true power
> of the device trees as hardware definitions.  Just a few more lines and
> the cooling works! :)
>
> >> As a suggestion, it would be good to test with a couple of different
> >> fans, to make sure that the PWM values work well for more that one fan
> >> model.  The Rock 5B requires a 5 V fan, if I'm not mistaken?
> >
> > It is 5V, yes. I only have one fan to try though, and I simply relied
> > on the PWM values that are already defined in the upstream
> > rk3588-rock-5b.dts. They don't look ideal for my particular fan,
> > because the lowest non-zero cooling state currently uses a PWM value
> > of 95, which doesn't always make it spin up. But in the end it doesn't
> > seem to matter that much, because that tiny fan needs to spin at full
> > 255 whenever all eight cores are loaded (and even then it can only
> > balance the temperature at around 60.5=D0=A1), and when the load is lig=
hter
> > (such as during various ./configure runs) it just switches off
> > completely as the temperature goes down to 46C even with the fan not
> > spinning.
>
> I see, 5 V fans unfortunately aren't very common.  I'm not sure why
> Radxa opted for 5 V there;  maybe the goal was to use Raspberry Pi 5 V
> fans, but using those tiny fans doesn't make much sense, IMHO.
>
> I think you can freely adjust the PWM values a bit to make your fan
> start reliably at the lowest state, regardless of how rarely that state
> will be used.  See, if your fan doesn't spin up reliably with the
> current
> lowest state, chances for other fan models not to spin up are quite
> high.
> IOW, it's better to play safe there, if you agree.
>
> What kind of heatsink are you using with your Rock 5B?  Ah yes, and
> what's the actual model of the fan you're using?

I use Radxa's 4012 heatsink-fan assembly that comes as an add-on
option when buying the board itself from Allnet. I guess I'll include
slightly adjusted PWM values in the rk3588-rock-5b.dts patch to better
represent my fan's "preferred" range (in my experience a PWM value of
around 120 is the reliable lower end - it would continue spinning
below that point but won't always start without being pushed manually)

> > I don't currently use the GPU/NPU/VPU though - maybe those would
> > produce more moderate load which could benefit from spinning the fan
> > at medium speeds.
>
> Perhaps, but it will need to be tested at some point.  Have you tried
> loading only one or two CPU cores?

I do see the full range of PWM values being used, including
intermediate ones. It doesn't go zero to hero :) My point was more
about the default fan not being super mighty vs. the full package
thermal output, which will likely mean that intermediate values are
rarely used. But I'll double check with more varied loads to make sure
it behaves in a sensible way (especially given that I'll be testing
purely interrupt-driven operation per Daniel's guidance in the other
sub-thread).

Best regards,
Alexey

