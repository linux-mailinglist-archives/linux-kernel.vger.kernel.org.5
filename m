Return-Path: <linux-kernel+bounces-41896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD4283F948
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB5A28375A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4C831A7E;
	Sun, 28 Jan 2024 19:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBlMQF44"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573AA2E851;
	Sun, 28 Jan 2024 19:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706469310; cv=none; b=E3nFI935ZsB5eaH174Fi26KIVllIc9bkIHNIbJQhDSTnmY36TVCiLX4WMpqEXX3UcEma28DeYoshWrGKpIOY/idtTr51dvkRVdW0y1XsjZfNSyee4LYKK+a+Mcz8xwywTzKZYEQmzPi9bLmUGMAe05uiaIFtuvCQ5jEvF5lcDKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706469310; c=relaxed/simple;
	bh=KIAiN+lQkwwq6VJ1cjU91z/aU+pDV8I2HOQfOJHmYu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxHj++XdKZujKza+idjO2iNAl/0hFdLG/ee6SZc+gH6a2ZGTFuB9DKO+ly4FPVG49fwOYK8uhzYGQuz6g55nBzKJ/ow+DdXez6b4QqZSa4bcUTjdMRJBeeMcorj8LnRpO1Ib+Jt88RiKnShEVCpVzsSx3efgEeML0IEV4+JKzaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBlMQF44; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a358ec50b7cso78883166b.0;
        Sun, 28 Jan 2024 11:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706469306; x=1707074106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcLwzPblK87z0P8mEm+hsxkESJ5afYl/DZ+sUXIYwZ0=;
        b=HBlMQF443TLTkIIZSiGxZ5E/03lR1bjjGfkxgaOSil56pVSEqqUG7KeeoAQULczG/5
         AgoSrQTvgeYU9dUfIkbElgYEyUVBYtLFoOaTXGmjyipG6ktZz9YESYchPGLcTLauK7Ul
         PEdJYLGbHG25dCo4hwGq940YDTcfBmqNBLOCz0UqQW3wRn8VQUlL0BSZoU1GH1jRQacs
         0UEvy3FXgXdIsc90vMBO42xLdQ74ZAe9ZGAONI3riz7Gx6g78czAqKIqlTS1lUSlEyi6
         +bcpZ+hqoVK6P2z9z6bRik+QpdiDEoq65tv9MWvcpgMQ6NUi7UE9SCGy/4LAnm9Hj7UY
         9xbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706469306; x=1707074106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcLwzPblK87z0P8mEm+hsxkESJ5afYl/DZ+sUXIYwZ0=;
        b=W/ndAjBkHgocV6zVRQW8ev7JeBOgCmMnZfo7CIFUqZJew/KHxS+SOLbpgxj4oqJAgs
         S39caINyI0jEQ/q15plZi0ztMLOAFbJykU9IFIDFBr7oThMh5K0sttIkMgFxVyGNjBGj
         OwhN8XcDScyGop/IIyJHohJooJ6M/6tih9BVp55gkaiUioEGCOArKxyKF2KUKcPhtFSG
         bjUb4g5Jbll4/SKgCLFCOPcW3On2mWtQ9FsViJzhKcnJbXokd0WQzkPyEBjB1pmZrIxL
         rwA3GsrAne6ArMSgGIgslULS6H1Kt8Or3XYvESJngT8JYDTa4zuyFJbJK0n0Z/V3K6vE
         mY3A==
X-Gm-Message-State: AOJu0Yz2kMigIfMR8ohgi89PLAakQ6slkVSY+LVxaQb5SmriquQP4gfV
	p/i6pCGeO7rknL3OCzebc10ABhOkP5MQeqtzB6lPLaYycRdBa/fwu0pZM8+ikaedmv+GfWb9k4C
	tLjnZ/5HvAw2baOcXLXvYn8ROl6E=
X-Google-Smtp-Source: AGHT+IFjVgqJbEbOWN22G7TgYwzqBwvhACbul/ERafukzE8fY31/uf/t6RhA0+xJxByPsKijqEDWNT6cC4SqpYZP9e4=
X-Received: by 2002:a17:907:c00f:b0:a35:15ea:3cc0 with SMTP id
 ss15-20020a170907c00f00b00a3515ea3cc0mr5625228ejc.26.1706469306111; Sun, 28
 Jan 2024 11:15:06 -0800 (PST)
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
 <CABjd4YzdD9ciMn=p=opEK+fdxCkeCodsryph7pkqgsEUNcNrUQ@mail.gmail.com>
 <5ef9bab979260884866efe30d19ba8f1@manjaro.org> <CABjd4YyyuB9ou-BaOrvt_rrv1-jPE=wtwWDHDqNqyT4a0E51wg@mail.gmail.com>
 <9fda41efe365241ce06bd58974c8e055@manjaro.org>
In-Reply-To: <9fda41efe365241ce06bd58974c8e055@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Sun, 28 Jan 2024 23:14:54 +0400
Message-ID: <CABjd4Ywfy8zT4sJ5v77CZQ9BNC=nkB7ZQq3QQyONST7gVHq=AA@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: Add OPP data for CPU cores on RK3588
To: Dragan Simic <dsimic@manjaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 7:35=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> On 2024-01-27 20:41, Alexey Charkov wrote:
> > On Sat, Jan 27, 2024 at 12:33=E2=80=AFAM Dragan Simic <dsimic@manjaro.o=
rg>
> > wrote:
> >> On 2024-01-26 14:44, Alexey Charkov wrote:
> >> > On Fri, Jan 26, 2024 at 4:56=E2=80=AFPM Daniel Lezcano <daniel.lezca=
no@linaro.org> wrote:
> >> >> On 26/01/2024 08:49, Dragan Simic wrote:
> >> >> > On 2024-01-26 08:30, Alexey Charkov wrote:
> >> >> >> On Fri, Jan 26, 2024 at 11:05=E2=80=AFAM Dragan Simic <dsimic@ma=
njaro.org> wrote:
> >> >> >>> On 2024-01-26 07:44, Alexey Charkov wrote:
> >> >> >>> > On Fri, Jan 26, 2024 at 10:32=E2=80=AFAM Dragan Simic <dsimic=
@manjaro.org> wrote:
> >> >> >>> >> On 2024-01-25 10:30, Daniel Lezcano wrote:
> >> >> >> Throttling would also lower the voltage at some point, which coo=
ls it
> >> >> >> down much faster!
> >> >> >
> >> >> > Of course, but the key is not to cool (and slow down) the CPU cor=
es too
> >> >> > much, but just enough to stay within the available thermal envelo=
pe,
> >> >> > which is where the same-voltage, lower-frequency OPPs should shin=
e.
> >> >>
> >> >> That implies the resulting power is sustainable which I doubt it is
> >> >> the
> >> >> case.
> >> >>
> >> >> The voltage scaling makes the cooling effect efficient not the
> >> >> frequency.
> >> >>
> >> >> For example:
> >> >>         opp5 =3D opp(2GHz, 1V) =3D> 2 BogoWatt
> >> >>         opp4 =3D opp(1.9GHz, 1V) =3D> 1.9 BogoWatt
> >> >>         opp3 =3D opp(1.8GHz, 0.9V) =3D> 1.458 BogoWatt
> >> >>         [ other states but we focus on these 3 ]
> >> >>
> >> >> opp5->opp4 =3D> -5% compute capacity, -5% power, ratio=3D1
> >> >> opp4->opp3 =3D> -5% compute capacity, -23.1% power, ratio=3D21,6
> >> >>
> >> >> opp5->opp3 =3D> -10% compute capacity, -27.1% power, ratio=3D36.9
> >> >>
> >> >> In burst operation (no thermal throttling), opp4 is pointless we ag=
ree
> >> >> on that.
> >> >>
> >> >> IMO the following will happen: in burst operation with thermal
> >> >> throttling we hit the trip point and then the step wise governor
> >> >> reduces
> >> >> opp5 -> opp4. We have slight power reduction but the temperature do=
es
> >> >> not decrease, so at the next iteration, it is throttle at opp3. And=
 at
> >> >> the end we have opp4 <-> opp3 back and forth instead of opp5 <-> op=
p3.
> >> >>
> >> >> It is probable we end up with an equivalent frequency average (or
> >> >> compute capacity avg).
> >> >>
> >> >> opp4 <-> opp3 (longer duration in states, less transitions)
> >> >> opp5 <-> opp3 (shorter duration in states, more transitions)
> >> >>
> >> >> Some platforms had their higher OPPs with the same voltage and they
> >> >> failed to cool down the CPU in the long run.
> >> >>
> >> >> Anyway, there is only one way to check it out :)
> >> >>
> >> >> Alexey, is it possible to compare the compute duration for 'dhrysto=
ne'
> >> >> with these voltage OPP and without ? (with a period of cool down
> >> >> between
> >> >> the test in order to start at the same thermal condition) ?
> >> >
> >> > Sure, let me try that - would be interesting to see the results. In =
my
> >> > previous tinkering there were cases when the system stayed at 2.35GH=
z
> >> > for all big cores for non-trivial time (using the step-wise thermal
> >> > governor), and that's an example of "same voltage, lower frequency".
> >> > Other times though it throttled one cluster down to 1.8GHz and kept
> >> > the other at 2.4GHz, and was also stationary at those parameters for
> >> > extended time. This probably indicates that both of those states use
> >> > sustainable power in my cooling setup.
> >>
> >> IMHO, there are simply too many factors at play, including different
> >> possible cooling setups, so providing additional CPU throttling
> >> granularity can only be helpful.  Of course, testing and recording
> >> data is the way to move forward, but I think we should use a few
> >> different tests.
> >
> > Soooo, benchmarking these turned out a bit trickier than I had hoped
> > for. Apparently, dhrystone uses an unsigned int rather than an
> > unsigned long for the loops count (or something of that sort), which
> > means that I can't get it to run enough loops to heat up my chip from
> > a stable idle state to the throttling state (due to counter
> > wraparound). So I ended up with a couple of crutches, namely:
>
> Huh, it seems that recent SBCs may have become a bit too fast for it,
> which is great. :)  Thank you for the benchmarking.
>
> >  - run dhrystone continuously on 6 out of 8 cores to make the chip
> > warm enough (`taskset -c 0-5 ./dhrystone -t 6 -r 6000` - note that on
> > my machine cores 6-7 are usually the first ones to get throttled, due
> > to whatever thermal peculiarities)
> >  - wait for the temperature to stabilize (which happens at 79.5C)
> >  - then run timed dhrystone on the remaining 2 out of 6 cores (big
> > ones) to see how throttling with different OPP tables affects overall
> > performance.
>
> Just checking, running the test on just two CPU cores was enough to
> keep the package temperature at around 80 oC?

No, not even remotely.

I kept the continuous 6 dhrystone threads running on all the other
cores (`taskset -c 0-5 ./dhrystone -t 6 -r 6000`) to let it reach the
throttling temperature. This adds further imprecision to the benchmark
of course, because the governor might choose to throttle some of the
cores that do not participate in the timed benchmarking run, and thus
lend some thermal headroom to the latter. That didn't seem to happen
from my naked-eye observation via `watch "cpupower -c 0,4,6
frequency-info | grep current"`, although I admit that I didn't record
more granular logs of frequency states, and some quick transitions to
lower frequencies could also have happened on the other cores. Don't
think it's a major influence though, because a quick transition back
and forth shouldn't have contributed much to the thermal output.

> > In the end, here's what I got with the 'original' OPP table (including
> > "same voltage - different frequencies" states):
> > alchark@rock-5b ~ $ taskset -c 6-7 ./dhrystone -t 2 -l 4000000000
> > duration: 0 seconds
> > number of threads: 2
> > number of loops: 4000000000000000
> > delay between starting threads: 0 seconds
> >
> > Dhrystone(1.1) time for 1233977344 passes =3D 29.7
> > This machine benchmarks at 41481539 dhrystones/second
> >                            23609 DMIPS
> > Dhrystone(1.1) time for 1233977344 passes =3D 29.8
> > This machine benchmarks at 41476618 dhrystones/second
> >                            23606 DMIPS
> >
> > Total dhrystone run time: 30.864492 seconds.
> >
> > And here's what I got with the 'reduced' OPP table (keeping only the
> > highest frequency state for each voltage):
> > alchark@rock-5b ~ $ taskset -c 6-7 ./dhrystone -t 2 -l 4000000000
> > duration: 0 seconds
> > number of threads: 2
> > number of loops: 4000000000000000
> > delay between starting threads: 0 seconds
> >
> > Dhrystone(1.1) time for 1233977344 passes =3D 30.9
> > This machine benchmarks at 39968549 dhrystones/second
> >                           22748 DMIPS
> > Dhrystone(1.1) time for 1233977344 passes =3D 31.0
> > This machine benchmarks at 39817431 dhrystones/second
> >                           22662 DMIPS
> >
> > Total dhrystone run time: 31.995136 seconds.
> >
> > Bottomline: removing the lower-frequency OPPs led to a 3.8% drop in
> > performance in this setup. This is probably far from a reliable
> > estimate, but I guess it indeed indicates that having lower-frequency
> > states might be beneficial in some load scenarios.
>
> Measuring a difference of about 4% may be attributed to some unknown
> inaccuracy or test deviation, but again, a performance improvement of
> about 4% that comes free of charge is nothing to be sneezed at, IMHO.

True :)

> > Note though that several seconds after hitting the throttling
> > threshold cores 6-7 were oscillating between 1.608GHz and 1.8GHz in
> > both runs, which implies that the whole difference in performance was
> > due to different speed of initial throttling (i.e. it might be a
> > peculiarity of the step-wise thermal governor operation when it has to
> > go through more cooling states to reach the "steady-state" one). Given
> > that both 1.608GHz and 1.8GHz have no lower-frequency same-voltage
> > siblings in either of the OPP tables, it implies that under prolonged
> > constant load there should be no performance difference at all.
>
> ... all that with one possible cooling setup, and with one synthetic
> test.  We simply can't know in advance how would a different cooling
> setup on the same or on a different board behave, if you agree.

Of course. My only concern is whether we might be somewhat deceiving
ourselves by that benchmarked performance boost: after all, it's also
entirely possible that by going through multiple intermediate
frequency states, the step-wise governor simply didn't cool the core
just enough over some fraction of the benchmarking run, which we would
have observed in a detailed temperature log as a higher peak
temperature and longer residence above the throttling threshold
temperature (and that would be the case if intermediate frequency
states were "unsustainable" as Daniel pointed out, which they probably
were given that the throttling didn't stop at any of them).

Attributing a performance increase in this case to a benefit from
additional intermediate OPPs is not fully fair, because then we can
also simply move the throttling threshold higher. And it would be
super tricky to separate the effects from greater system throughput at
intermediate frequency states vs. greater effective thermal budget we
allow the governor to use before it even considers throttling.

Best regards,
Alexey

