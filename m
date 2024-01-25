Return-Path: <linux-kernel+bounces-38373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B7083BE77
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8FB61C28CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D711CA85;
	Thu, 25 Jan 2024 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXq2igKD"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440861C6BC;
	Thu, 25 Jan 2024 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177856; cv=none; b=UvHHzLSo6r9t+4ojjDEQlfnc6cpjM29KLfUIF1rT5Ohe8ImyduQuBsNvyTee19ubnR7i8adxuRcQJVUyPtpddrpjY6UpnbV2KhwydKBSIEvJlXY+v+mn6OeWupdZsQNZN1WlDlR1ZeKnLpE+Tion+xHx7+hMGEC8SZVpKTE5wgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177856; c=relaxed/simple;
	bh=QjDA9PkCJirHegUJ4lnB7pA7PyppfMkdD3Xdk3N02jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOt9MczvSooVav2HC5NCSBJHt5wdn5WcErkr1i2htDX4jT6GDAZ+iyjlrqDwT4ZULFAh+vsBBOTpyJdu6hWX20i42MTzJ7iXmiJdZXYaArMRPdnu7WWRzc8nhvE1AyMT8LQPlGrEfgp7+wMUwYA1WeWc9unIQGB0EPXXq7R2ppg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXq2igKD; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a349cf29cso7634674a12.0;
        Thu, 25 Jan 2024 02:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706177852; x=1706782652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHFPm70p9n02aaOjN2EKpORM1VcAf+spqQnNizZf5G8=;
        b=fXq2igKDtQ/aQ12V2QLZiMXHwZckzO8cSOqcI5WxbJtvx5213eszy2h+o8Wq6PEF8H
         dxLbwsCOBGcMOa8gNLjP4ZPo+flWyMMlbPiQmxykUTPOH6lGzHKPbgVy1B0r1emfLsr1
         baJMgZzRrJ16CpAow6tyc8sm92vmEgP7MQec35FgUa1wENxPJlluWA3xItWUm+LGPdqc
         YVGkrY7iMy+JfhUbW0cf7k3GWExus3KYkd9G+6E0AHTeomczmtg+akas0uYHl9Jk0xvE
         AmrvuwXMNmU/gNgqC32i5mm4QDjCfcgWN/+cLxtS0LxzdL6E3IztxPqAVzPo9MUbvJwg
         1/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706177852; x=1706782652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHFPm70p9n02aaOjN2EKpORM1VcAf+spqQnNizZf5G8=;
        b=hH1hiTVOUHFnJG6Nd2IGSpYOLpl14Ry2rM/H7ucRkECgsztYxlNi2wootcspZ4wAl8
         S6ZcUl1MwKc72jb2HPYcthRKWgD382jj2BVRc2XZgU8kG5r7ocTAhB2YslCkcZjJBt9i
         HU6DTTc1/+sbG3PcStLtAGsdKpMoh/0sDVzEPohZxGRznD01i5KsltDahFeMDTxtGKY7
         s3V6dEIE/5/Bno/8X23DXgD6FByr9QKnfW/IIkMGzeDL9TD5ID6m2W9yCWtsBl5A44+2
         FQyOYTQpow//zfWSK/mHRG0iwt5rSMje/CHMKajBuPeqacOg2YbcDJR6VUhtiGJDsEPo
         Ig5Q==
X-Gm-Message-State: AOJu0YzYMjKg36b0omaUkSGvMPNnnUUJlqPTHfLrzZuQ5j7mRDz7pVo6
	VLB+gLItJPJEhhtB1yDJZZC7Gbxr1kzdQbekisBcBtaERd4vgZ9xrBibt+/OyHwmJBWT3bh261O
	A/PwdKs3zuzRy0AvCEoJ2AGlVVrRhunQvhR79yQ==
X-Google-Smtp-Source: AGHT+IEx+h5SBM2bgId1zr3Ii7PWy5ejzUKeLAKwDFAolLyZwSnTAs++pEfiZXhmeMzu/OZAN8qTpteBhMuGeCYaaRU=
X-Received: by 2002:a17:906:11d6:b0:a2b:1fc1:b3b5 with SMTP id
 o22-20020a17090611d600b00a2b1fc1b3b5mr394022eja.99.1706177852190; Thu, 25 Jan
 2024 02:17:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
 <20240125-rk-dts-additions-v1-4-5879275db36f@gmail.com> <731aac66-f698-4a1e-b9ee-46a7f24ecae5@linaro.org>
In-Reply-To: <731aac66-f698-4a1e-b9ee-46a7f24ecae5@linaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 25 Jan 2024 14:17:21 +0400
Message-ID: <CABjd4YzWJie91kcbHom_Zso=QQR9gPmAVvJb1vbqa0Qwu5egKg@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: Add OPP data for CPU cores on RK3588
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 1:30=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Alexey,
>
> Adding Viresh
>
> On 24/01/2024 21:30, Alexey Charkov wrote:
> > By default the CPUs on RK3588 start up in a conservative performance
> > mode. Add frequency and voltage mappings to the device tree to enable
> > dynamic scaling via cpufreq
> >
> > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > ---
> >   arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 209 +++++++++++++++++++++=
+++++++++
> >   1 file changed, 209 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boo=
t/dts/rockchip/rk3588s.dtsi
> > index 131b9eb21398..e605be531a0f 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > @@ -97,6 +97,7 @@ cpu_l0: cpu@0 {
> >                       clocks =3D <&scmi_clk SCMI_CLK_CPUL>;
> >                       assigned-clocks =3D <&scmi_clk SCMI_CLK_CPUL>;
> >                       assigned-clock-rates =3D <816000000>;
> > +                     operating-points-v2 =3D <&cluster0_opp_table>;
> >                       cpu-idle-states =3D <&CPU_SLEEP>;
> >                       i-cache-size =3D <32768>;
> >                       i-cache-line-size =3D <64>;
> > @@ -116,6 +117,7 @@ cpu_l1: cpu@100 {
> >                       enable-method =3D "psci";
> >                       capacity-dmips-mhz =3D <530>;
> >                       clocks =3D <&scmi_clk SCMI_CLK_CPUL>;
> > +                     operating-points-v2 =3D <&cluster0_opp_table>;
> >                       cpu-idle-states =3D <&CPU_SLEEP>;
> >                       i-cache-size =3D <32768>;
> >                       i-cache-line-size =3D <64>;
> > @@ -135,6 +137,7 @@ cpu_l2: cpu@200 {
> >                       enable-method =3D "psci";
> >                       capacity-dmips-mhz =3D <530>;
> >                       clocks =3D <&scmi_clk SCMI_CLK_CPUL>;
> > +                     operating-points-v2 =3D <&cluster0_opp_table>;
> >                       cpu-idle-states =3D <&CPU_SLEEP>;
> >                       i-cache-size =3D <32768>;
> >                       i-cache-line-size =3D <64>;
> > @@ -154,6 +157,7 @@ cpu_l3: cpu@300 {
> >                       enable-method =3D "psci";
> >                       capacity-dmips-mhz =3D <530>;
> >                       clocks =3D <&scmi_clk SCMI_CLK_CPUL>;
> > +                     operating-points-v2 =3D <&cluster0_opp_table>;
> >                       cpu-idle-states =3D <&CPU_SLEEP>;
> >                       i-cache-size =3D <32768>;
> >                       i-cache-line-size =3D <64>;
> > @@ -175,6 +179,7 @@ cpu_b0: cpu@400 {
> >                       clocks =3D <&scmi_clk SCMI_CLK_CPUB01>;
> >                       assigned-clocks =3D <&scmi_clk SCMI_CLK_CPUB01>;
> >                       assigned-clock-rates =3D <816000000>;
> > +                     operating-points-v2 =3D <&cluster1_opp_table>;
> >                       cpu-idle-states =3D <&CPU_SLEEP>;
> >                       i-cache-size =3D <65536>;
> >                       i-cache-line-size =3D <64>;
> > @@ -194,6 +199,7 @@ cpu_b1: cpu@500 {
> >                       enable-method =3D "psci";
> >                       capacity-dmips-mhz =3D <1024>;
> >                       clocks =3D <&scmi_clk SCMI_CLK_CPUB01>;
> > +                     operating-points-v2 =3D <&cluster1_opp_table>;
> >                       cpu-idle-states =3D <&CPU_SLEEP>;
> >                       i-cache-size =3D <65536>;
> >                       i-cache-line-size =3D <64>;
> > @@ -215,6 +221,7 @@ cpu_b2: cpu@600 {
> >                       clocks =3D <&scmi_clk SCMI_CLK_CPUB23>;
> >                       assigned-clocks =3D <&scmi_clk SCMI_CLK_CPUB23>;
> >                       assigned-clock-rates =3D <816000000>;
> > +                     operating-points-v2 =3D <&cluster2_opp_table>;
> >                       cpu-idle-states =3D <&CPU_SLEEP>;
> >                       i-cache-size =3D <65536>;
> >                       i-cache-line-size =3D <64>;
> > @@ -234,6 +241,7 @@ cpu_b3: cpu@700 {
> >                       enable-method =3D "psci";
> >                       capacity-dmips-mhz =3D <1024>;
> >                       clocks =3D <&scmi_clk SCMI_CLK_CPUB23>;
> > +                     operating-points-v2 =3D <&cluster2_opp_table>;
> >                       cpu-idle-states =3D <&CPU_SLEEP>;
> >                       i-cache-size =3D <65536>;
> >                       i-cache-line-size =3D <64>;
> > @@ -348,6 +356,207 @@ l3_cache: l3-cache {
> >               };
> >       };
> >
> > +     cluster0_opp_table: opp-table-cluster0 {
> > +             compatible =3D "operating-points-v2";
> > +             opp-shared;
> > +
> > +             opp-408000000 {
> > +                     opp-hz =3D /bits/ 64 <408000000>;
> > +                     opp-microvolt =3D <675000 675000 950000>;
> > +                     clock-latency-ns =3D <40000>;
> > +             };
> > +             opp-600000000 {
> > +                     opp-hz =3D /bits/ 64 <600000000>;
> > +                     opp-microvolt =3D <675000 675000 950000>;
> > +                     clock-latency-ns =3D <40000>;
> > +             };
> > +             opp-816000000 {
> > +                     opp-hz =3D /bits/ 64 <816000000>;
> > +                     opp-microvolt =3D <675000 675000 950000>;
> > +                     clock-latency-ns =3D <40000>;
> > +             };
> > +             opp-1008000000 {
> > +                     opp-hz =3D /bits/ 64 <1008000000>;
> > +                     opp-microvolt =3D <675000 675000 950000>;
> > +                     clock-latency-ns =3D <40000>;
> > +             };
>
> It is not useful to introduce OPP with the same voltage. There is no
> gain in terms of energy efficiency as the compute capacity is linearly
> tied with power consumption (P=3DCxFxV=C2=B2) in this case.
>
> For example, opp-408 consumes 2 bogoWatts and opp-816 consumes 4
> bogoWatts (because of the same voltage).
>
> For a workload, opp-408 takes 10 sec and opp-816 takes 5 sec because it
> is twice faster.
>
> The energy consumption is:
>
> opp-408 =3D 10 x 2 =3D 20 BogoJoules
> opp-816 =3D 5 x 4 =3D 20 BogoJoules

I see, thank you. Will drop all "lower frequency - same voltage"
instances and resubmit in the next iteration.

Best regards,
Alexey

