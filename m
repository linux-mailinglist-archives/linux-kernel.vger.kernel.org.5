Return-Path: <linux-kernel+bounces-40142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED82083DB22
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A175B26731
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F9F1B955;
	Fri, 26 Jan 2024 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3Ehot0l"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5AC1B942;
	Fri, 26 Jan 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706276702; cv=none; b=udIVKPplXmJrTGI4UuR2igJ882kbtISPSYJ1u3dc/KmfEQ+hogsSh41NvUcWXPSBtDw9LyUd6oJe6BCfz49FiLkVrhTSwcTINJTkRmnggW3g0WHZQ23VOFaoZu0GUwH6rfYTbGM2AWM/D04ifKBc9urfbyke29YdLFDRCkFurJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706276702; c=relaxed/simple;
	bh=Hy74lV5gtmSNn2XWXUaZggJxpS9RAZmuW3fG/Zmrcfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdbkyZd4Hnq8CuYFoCLkr6XXDsNaUZuRTWGkW7DjxNFhIN/OqYrn4OhS69g49JVE4dkGNNuHvKqHL5lTnilxPZY1Bv5Zlw1F5iQwQY2pT48rxanS2BzjAGbWzwwzaNcFHZwczpJlExADTaJrotTGgswdSuJMc3kkMzd1oZME5vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3Ehot0l; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ade380b9fso466958f8f.2;
        Fri, 26 Jan 2024 05:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706276699; x=1706881499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syGzEQrVWcLtI559gM1dEJe5dJ5RhKL4dWF8cdKerO4=;
        b=k3Ehot0l4jIUqzj9hwM0Cj46/p5gPWCLKipQml37j8QlgU4TIUPxa8sDWaPLp80KyG
         uMhpbqyJqkkT+FQjH0iyiXj44H/wggW7FUg5hM95aqYZcptQ7CJ1+lTp1hebOq+MtI+r
         QRwdstBwiaV+PPaVgPHC/Zx02ee6xjXsIJzXfDVibCiK33RcagZW24NLPrHt2C6OPVRq
         kMVM5jKf8WXptpCUTMWsj0b9llGaXnniSDkaEAXhjDeXzo3aQLwb/FYsR+BPw1VNOKp0
         3ZHXC+N6T725U2i+qoSWzmC6Y9KsZ6gJbE6tslUC+6231UjyVmK4SyhKRZ8NaolXI86x
         5KXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706276699; x=1706881499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syGzEQrVWcLtI559gM1dEJe5dJ5RhKL4dWF8cdKerO4=;
        b=sRQhuixD8tE/k7UW/BYXaA+ZTdDw3czo3drCF3g/B8W0rIXU0+vZUKAO+IGO+GijBM
         7dZVS/QtxFSgHCiIBw1XHnsbr8/+lryQphfNKFJ0znC+Qov/Bqu3OUXMGIF8b10yB7Oq
         XjZKSNCT9Y9QXbpWXWBhSNhECyftg0pKFGzRxXIE4Magi0SvnxAYe23pJW0PI001c6zc
         d9Giu93eeyDs0O/9z6Acpe+2MT5he8vVnTFTjlExrq1rgkxmjI6ORjV9DikEAYn8qf4Y
         CUaPRw6ITG3RCQAHKgq7hdoB6X14Lhtli71yPDDDsET5zkiWU+bK2rjUMM4mGMrb93tv
         brJQ==
X-Gm-Message-State: AOJu0YzqxJWV8vWe7+0rfxl7KxOWKJfsiaBKY3ESB7n5rYm1V3HEUNzo
	/9DgOO6tAZ1uZk8OKWY+jN684cYxJmmfDBe6dRQbEzgrQV2jcIwy/tVOUz6t0Pke+rh9MLSET/P
	gPmnS/1vLNuGI5WA0zcKZhOy0WkjEJ47ghypeIg==
X-Google-Smtp-Source: AGHT+IEDDO5mLMdinDwrRxPoOwn0aiY6a064MPOzk/zSJW3LYCdRoz1OyLt0pOaN2xC2WHd9+8kYCwSKnzHrGOR+2qs=
X-Received: by 2002:a05:600c:4e55:b0:40e:b179:5820 with SMTP id
 e21-20020a05600c4e5500b0040eb1795820mr547420wmq.24.1706276698649; Fri, 26 Jan
 2024 05:44:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
 <20240125-rk-dts-additions-v1-4-5879275db36f@gmail.com> <731aac66-f698-4a1e-b9ee-46a7f24ecae5@linaro.org>
 <ccc004cfae513195351ce0a79e12f6af@manjaro.org> <CABjd4YxSTLZjrnSCn0fh81US682-uhZ16-cgydzz97shhCpq4w@mail.gmail.com>
 <1f0608831cfb95c80edf16cd751eee76@manjaro.org> <CABjd4Yx06igrZQvHA4q-mcr2oSEf7eQyUS+KEATUGbw6qLc2sg@mail.gmail.com>
 <528a37d84cdd871e717b4ebf648bb8a7@manjaro.org> <9b72b688-be63-464e-a5dc-cf6051ccee12@linaro.org>
In-Reply-To: <9b72b688-be63-464e-a5dc-cf6051ccee12@linaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 26 Jan 2024 17:44:46 +0400
Message-ID: <CABjd4YzdD9ciMn=p=opEK+fdxCkeCodsryph7pkqgsEUNcNrUQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: Add OPP data for CPU cores on RK3588
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Dragan Simic <dsimic@manjaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 4:56=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 26/01/2024 08:49, Dragan Simic wrote:
> > On 2024-01-26 08:30, Alexey Charkov wrote:
> >> On Fri, Jan 26, 2024 at 11:05=E2=80=AFAM Dragan Simic <dsimic@manjaro.=
org> wrote:
> >>> On 2024-01-26 07:44, Alexey Charkov wrote:
> >>> > On Fri, Jan 26, 2024 at 10:32=E2=80=AFAM Dragan Simic <dsimic@manja=
ro.org>
> >>> > wrote:
> >>> >> On 2024-01-25 10:30, Daniel Lezcano wrote:
> >>> >> > On 24/01/2024 21:30, Alexey Charkov wrote:
> >>> >> >> By default the CPUs on RK3588 start up in a conservative
> >>> performance
> >>> >> >> mode. Add frequency and voltage mappings to the device tree to
> >>> enable
>
> [ ... ]
>
> >> Throttling would also lower the voltage at some point, which cools it
> >> down much faster!
> >
> > Of course, but the key is not to cool (and slow down) the CPU cores too
> > much, but just enough to stay within the available thermal envelope,
> > which is where the same-voltage, lower-frequency OPPs should shine.
>
> That implies the resulting power is sustainable which I doubt it is the
> case.
>
> The voltage scaling makes the cooling effect efficient not the frequency.
>
> For example:
>         opp5 =3D opp(2GHz, 1V) =3D> 2 BogoWatt
>         opp4 =3D opp(1.9GHz, 1V) =3D> 1.9 BogoWatt
>         opp3 =3D opp(1.8GHz, 0.9V) =3D> 1.458 BogoWatt
>         [ other states but we focus on these 3 ]
>
> opp5->opp4 =3D> -5% compute capacity, -5% power, ratio=3D1
> opp4->opp3 =3D> -5% compute capacity, -23.1% power, ratio=3D21,6
>
> opp5->opp3 =3D> -10% compute capacity, -27.1% power, ratio=3D36.9
>
> In burst operation (no thermal throttling), opp4 is pointless we agree
> on that.
>
> IMO the following will happen: in burst operation with thermal
> throttling we hit the trip point and then the step wise governor reduces
> opp5 -> opp4. We have slight power reduction but the temperature does
> not decrease, so at the next iteration, it is throttle at opp3. And at
> the end we have opp4 <-> opp3 back and forth instead of opp5 <-> opp3.
>
> It is probable we end up with an equivalent frequency average (or
> compute capacity avg).
>
> opp4 <-> opp3 (longer duration in states, less transitions)
> opp5 <-> opp3 (shorter duration in states, more transitions)
>
> Some platforms had their higher OPPs with the same voltage and they
> failed to cool down the CPU in the long run.
>
> Anyway, there is only one way to check it out :)
>
> Alexey, is it possible to compare the compute duration for 'dhrystone'
> with these voltage OPP and without ? (with a period of cool down between
> the test in order to start at the same thermal condition) ?

Sure, let me try that - would be interesting to see the results. In my
previous tinkering there were cases when the system stayed at 2.35GHz
for all big cores for non-trivial time (using the step-wise thermal
governor), and that's an example of "same voltage, lower frequency".
Other times though it throttled one cluster down to 1.8GHz and kept
the other at 2.4GHz, and was also stationary at those parameters for
extended time. This probably indicates that both of those states use
sustainable power in my cooling setup.

Note though that I still have that tiny heatsink installed (even
though I disable the fan during tests), and in this setup the
temperature drops from 85C to around 70C in a matter of seconds as
soon as the load stops. And if I enable the fan then it balances the
temperature at the control setpoint of 55C using less than full fan
speed with 8 threads of dhrystone running for extended time (and the
PWM value chosen by the step-wise governor stabilizes at 240 out of
255). Looks like my prior assessment that "the fan is not super mighty
vs. the total thermal output" was wrong after all, despite its modest
size :)

Best regards,
Alexey

