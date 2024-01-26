Return-Path: <linux-kernel+bounces-39701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F7A83D51D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7549D1F21207
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BABA1B7F4;
	Fri, 26 Jan 2024 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMCnut6v"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B621171E;
	Fri, 26 Jan 2024 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706254243; cv=none; b=Z/ewTyMKWEMzQKEmN82zuzVuN1aBLM0z67YZW5H9CiF96yMgELDOnMCRnwjElIWGzXz8GM2sXdIPSqZ5+rUMPf2aCNfe0S/RfgDiOCZYDPYrh0VajxJqZxMJX+FOwSLPthbc5fIPYocaHeyKPOWxtNnp9tXPKzalUh6Va0dW2A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706254243; c=relaxed/simple;
	bh=rctLMT+7kG2suR8d3J2W3zGCYRyf+76dIXayEf4IHnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqVwceCyBk644vUiLtrKcFItKVpcW78eoW40c6fvk4y+I5qHSy8DTrpFoIUd1lWZZzOFgjBOgNa/un6LH1VEXbr4jrSIZEOGbuAFUmmWgSTcIoxRp+CQ4ueanxUoXFtpqT6RfToMbweckOTN1G3sfFTUKMjSmuIaktfezdlQo88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMCnut6v; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a31713c8bdbso6223966b.2;
        Thu, 25 Jan 2024 23:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706254239; x=1706859039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxPSg3lfMPvgPz2RQncjQcO/LLNqEf5TPMm9SZkjhE4=;
        b=GMCnut6v/VRUBl+B5nkrU4V6VkBRHl4XIpVxUw0rRKaznZZXg5NEv9VWtSY4vnMMh5
         TPGpxrapTIdO209FsT9oNEt/r6FUFbWntPyoWBikVb3/Qj0sGUP9mL+ifLcBs1P7se0P
         Ke+xMtyTPCQbxfkJ5OS2BG713otpsnq/IBlMg0PV7hoRlcHW0RY6+ldqNHuYMbzoFE42
         EEXTslrf89C2elfRzhSwQIMO0FyZKAVSwZ9Knz3qeTKoO8Ed+ktTSLfwZZEzdgALsHun
         bsnrRyQo2ZlGbXppzr9bEcCOCYslvhfWjklBcw5qWDOkEs4ox5A0isffnjoGgADTcTxF
         zXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706254239; x=1706859039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxPSg3lfMPvgPz2RQncjQcO/LLNqEf5TPMm9SZkjhE4=;
        b=HksZIfZCre05C0F1hWYOWkrSxeRV/v3RxyV5AfPzOYlfJwN35HYv9T6R9f6idsdI0J
         KVWt2xow4L9tBNkjMOAJoqVx4wNuzikFAHmp5d3tRSzI45MH64XjJYVFsNcPzDVrOym1
         /9Z0N9l8X0lfx+pFeBLtVlVnkrCiPwqqBvM9hvKNAVd4fDlg8jtKbpouthjbp+afbYIn
         QF8OnEsBTJQSJ8rYU+I2TY5FFefE1dNyZHLBvL7vJW7rucD9d5H6lpn1jvXVXrft54qv
         wpsMHIgsP2YJSqX3kcUN9qYK9TkwSSRN5zk/tDeCDZqisR10CDarzLZyzGkoPsCMWFv7
         mKPg==
X-Gm-Message-State: AOJu0YzgKgC/re/LpKsRfQOahwhGl/2UV4aWUW5BNksabBTJNNehrYvl
	UNL4FKIt763CiA2LwWilRlJvdRdjEBYz7zfOcGIMqjibDyW2pHYeEmXEzxMRaTTba8eS8dxFLVQ
	nq5+metfwiSqMIdH/7bNbjR9i+d8=
X-Google-Smtp-Source: AGHT+IF/9LVoPv6C6s8FG8zHMfBuC2xd72GeWw99SiawXIjJA8MvOfMj8AWWkbTQFKi4nLhv1Ea7c4VkIdr4g5QpL5w=
X-Received: by 2002:a17:906:7b86:b0:a34:a1ec:52c0 with SMTP id
 s6-20020a1709067b8600b00a34a1ec52c0mr344148ejo.41.1706254239455; Thu, 25 Jan
 2024 23:30:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
 <20240125-rk-dts-additions-v1-4-5879275db36f@gmail.com> <731aac66-f698-4a1e-b9ee-46a7f24ecae5@linaro.org>
 <ccc004cfae513195351ce0a79e12f6af@manjaro.org> <CABjd4YxSTLZjrnSCn0fh81US682-uhZ16-cgydzz97shhCpq4w@mail.gmail.com>
 <1f0608831cfb95c80edf16cd751eee76@manjaro.org>
In-Reply-To: <1f0608831cfb95c80edf16cd751eee76@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 26 Jan 2024 11:30:27 +0400
Message-ID: <CABjd4Yx06igrZQvHA4q-mcr2oSEf7eQyUS+KEATUGbw6qLc2sg@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: Add OPP data for CPU cores on RK3588
To: Dragan Simic <dsimic@manjaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 11:05=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> =
wrote:
>
> Hello Alexey,
>
> On 2024-01-26 07:44, Alexey Charkov wrote:
> > On Fri, Jan 26, 2024 at 10:32=E2=80=AFAM Dragan Simic <dsimic@manjaro.o=
rg>
> > wrote:
> >> On 2024-01-25 10:30, Daniel Lezcano wrote:
> >> > On 24/01/2024 21:30, Alexey Charkov wrote:
> >> >> By default the CPUs on RK3588 start up in a conservative performanc=
e
> >> >> mode. Add frequency and voltage mappings to the device tree to enab=
le
> >> >> dynamic scaling via cpufreq
> >> >>
> >> >> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >> >> ---
> >> >>   arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 209
> >> >> ++++++++++++++++++++++++++++++
> >> >>   1 file changed, 209 insertions(+)
> >> >>
> >> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> >> b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> >> index 131b9eb21398..e605be531a0f 100644
> >> >> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> >> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> >> @@ -97,6 +97,7 @@ cpu_l0: cpu@0 {
> >> >>                      clocks =3D <&scmi_clk SCMI_CLK_CPUL>;
> >> >>                      assigned-clocks =3D <&scmi_clk SCMI_CLK_CPUL>;
> >> >>                      assigned-clock-rates =3D <816000000>;
> >> >> +                    operating-points-v2 =3D <&cluster0_opp_table>;
> >> >>                      cpu-idle-states =3D <&CPU_SLEEP>;
> >> >>                      i-cache-size =3D <32768>;
> >> >>                      i-cache-line-size =3D <64>;
> >> >> @@ -116,6 +117,7 @@ cpu_l1: cpu@100 {
> >> >>                      enable-method =3D "psci";
> >> >>                      capacity-dmips-mhz =3D <530>;
> >> >>                      clocks =3D <&scmi_clk SCMI_CLK_CPUL>;
> >> >> +                    operating-points-v2 =3D <&cluster0_opp_table>;
> >> >>                      cpu-idle-states =3D <&CPU_SLEEP>;
> >> >>                      i-cache-size =3D <32768>;
> >> >>                      i-cache-line-size =3D <64>;
> >> >> @@ -135,6 +137,7 @@ cpu_l2: cpu@200 {
> >> >>                      enable-method =3D "psci";
> >> >>                      capacity-dmips-mhz =3D <530>;
> >> >>                      clocks =3D <&scmi_clk SCMI_CLK_CPUL>;
> >> >> +                    operating-points-v2 =3D <&cluster0_opp_table>;
> >> >>                      cpu-idle-states =3D <&CPU_SLEEP>;
> >> >>                      i-cache-size =3D <32768>;
> >> >>                      i-cache-line-size =3D <64>;
> >> >> @@ -154,6 +157,7 @@ cpu_l3: cpu@300 {
> >> >>                      enable-method =3D "psci";
> >> >>                      capacity-dmips-mhz =3D <530>;
> >> >>                      clocks =3D <&scmi_clk SCMI_CLK_CPUL>;
> >> >> +                    operating-points-v2 =3D <&cluster0_opp_table>;
> >> >>                      cpu-idle-states =3D <&CPU_SLEEP>;
> >> >>                      i-cache-size =3D <32768>;
> >> >>                      i-cache-line-size =3D <64>;
> >> >> @@ -175,6 +179,7 @@ cpu_b0: cpu@400 {
> >> >>                      clocks =3D <&scmi_clk SCMI_CLK_CPUB01>;
> >> >>                      assigned-clocks =3D <&scmi_clk SCMI_CLK_CPUB01=
>;
> >> >>                      assigned-clock-rates =3D <816000000>;
> >> >> +                    operating-points-v2 =3D <&cluster1_opp_table>;
> >> >>                      cpu-idle-states =3D <&CPU_SLEEP>;
> >> >>                      i-cache-size =3D <65536>;
> >> >>                      i-cache-line-size =3D <64>;
> >> >> @@ -194,6 +199,7 @@ cpu_b1: cpu@500 {
> >> >>                      enable-method =3D "psci";
> >> >>                      capacity-dmips-mhz =3D <1024>;
> >> >>                      clocks =3D <&scmi_clk SCMI_CLK_CPUB01>;
> >> >> +                    operating-points-v2 =3D <&cluster1_opp_table>;
> >> >>                      cpu-idle-states =3D <&CPU_SLEEP>;
> >> >>                      i-cache-size =3D <65536>;
> >> >>                      i-cache-line-size =3D <64>;
> >> >> @@ -215,6 +221,7 @@ cpu_b2: cpu@600 {
> >> >>                      clocks =3D <&scmi_clk SCMI_CLK_CPUB23>;
> >> >>                      assigned-clocks =3D <&scmi_clk SCMI_CLK_CPUB23=
>;
> >> >>                      assigned-clock-rates =3D <816000000>;
> >> >> +                    operating-points-v2 =3D <&cluster2_opp_table>;
> >> >>                      cpu-idle-states =3D <&CPU_SLEEP>;
> >> >>                      i-cache-size =3D <65536>;
> >> >>                      i-cache-line-size =3D <64>;
> >> >> @@ -234,6 +241,7 @@ cpu_b3: cpu@700 {
> >> >>                      enable-method =3D "psci";
> >> >>                      capacity-dmips-mhz =3D <1024>;
> >> >>                      clocks =3D <&scmi_clk SCMI_CLK_CPUB23>;
> >> >> +                    operating-points-v2 =3D <&cluster2_opp_table>;
> >> >>                      cpu-idle-states =3D <&CPU_SLEEP>;
> >> >>                      i-cache-size =3D <65536>;
> >> >>                      i-cache-line-size =3D <64>;
> >> >> @@ -348,6 +356,207 @@ l3_cache: l3-cache {
> >> >>              };
> >> >>      };
> >> >>   +  cluster0_opp_table: opp-table-cluster0 {
> >> >> +            compatible =3D "operating-points-v2";
> >> >> +            opp-shared;
> >> >> +
> >> >> +            opp-408000000 {
> >> >> +                    opp-hz =3D /bits/ 64 <408000000>;
> >> >> +                    opp-microvolt =3D <675000 675000 950000>;
> >> >> +                    clock-latency-ns =3D <40000>;
> >> >> +            };
> >> >> +            opp-600000000 {
> >> >> +                    opp-hz =3D /bits/ 64 <600000000>;
> >> >> +                    opp-microvolt =3D <675000 675000 950000>;
> >> >> +                    clock-latency-ns =3D <40000>;
> >> >> +            };
> >> >> +            opp-816000000 {
> >> >> +                    opp-hz =3D /bits/ 64 <816000000>;
> >> >> +                    opp-microvolt =3D <675000 675000 950000>;
> >> >> +                    clock-latency-ns =3D <40000>;
> >> >> +            };
> >> >> +            opp-1008000000 {
> >> >> +                    opp-hz =3D /bits/ 64 <1008000000>;
> >> >> +                    opp-microvolt =3D <675000 675000 950000>;
> >> >> +                    clock-latency-ns =3D <40000>;
> >> >> +            };
> >> >
> >> > It is not useful to introduce OPP with the same voltage. There is no
> >> > gain in terms of energy efficiency as the compute capacity is linear=
ly
> >> > tied with power consumption (P=3DCxFxV=C2=B2) in this case.
> >> >
> >> > For example, opp-408 consumes 2 bogoWatts and opp-816 consumes 4
> >> > bogoWatts (because of the same voltage).
> >> >
> >> > For a workload, opp-408 takes 10 sec and opp-816 takes 5 sec because
> >> > it is twice faster.
> >> >
> >> > The energy consumption is:
> >> >
> >> > opp-408 =3D 10 x 2 =3D 20 BogoJoules
> >> > opp-816 =3D 5 x 4 =3D 20 BogoJoules
> >>
> >> I'd respectfully disagree that including multiple OPPs with the same
> >> voltage
> >> but different frequencies isn't useful.  Please allow me to explain.
> >>
> >> See, the total amount of consumed energy is, in general, the same for
> >> such
> >> OPPs and the same CPU task(s), if we ignore the static leakage current
> >> and
> >> such stuff, which isn't important here.  Though, the emphasis here is
> >> on
> >> "total", i.e. without taking into account the actual amount of time
> >> required
> >> for the exemplified CPU task(s) to complete.  If the total amount of
> >> time
> >> is quite short, we aren't going to heat up the package and the board
> >> enough
> >> to hit the CPU thermal throttling;  this approach is also sometimes
> >> referred
> >> to as "race to idle", which is actually quite effective for
> >> battery-powered
> >> mobile devices that tend to load their CPU cores in bursts, while
> >> remaining
> >> kind of inactive for the remaining time.
> >>
> >> However, if the CPU task(s) last long enough to actually saturate the
> >> thermal
> >> capacities of the package and the board or the device, we're getting
> >> into the
> >> CPU throttling territory, in which running the CPU cores slower, but
> >> still as
> >> fast as possible, may actually be beneficial for the overall CPU
> >> performance.
> >> By running the CPU cores slower, we're lowering the power and
> >> "spreading" the
> >> total energy consumption over time, i.e. we're making some time to
> >> allow
> >> the
> >> generated heat to dissipate into the surroundings.  As we know, having
> >> more
> >> energy consumed by the SoC means more heat generated by the SoC, but
> >> the
> >> resulting temperature of the SoC depends on how fast the energy is
> >> consumed,
> >> which equals to how fast the CPUs run;  of course, all that is valid
> >> under
> >> the reasonable assumption that the entire cooling setup, including the
> >> board
> >> surroundings, remains unchanged all the time.
> >
> > On the other hand, convective heat dissipation is approximately
> > proportional to the temperature differential, therefore heating up the
> > core to a higher temperature over a shorter period of time would let
> > it dissipate the same joule amount faster. Given that total joules
>
> Let me point out that the emphasis is again on "shorter period". :)
> Yes, when the CPU load is bursty, having multiple same-voltage OPPs
> almost surely won't help us at all, as I already noted.  However,
> the things will surely change when the CPU cores are loaded for
> longer amounts of time and, as a result, the defined thermal trips
> are reached, because the cooling system gets saturated.
>
> > generated for a particular load are approximately the same for
> > different frequencies as long as voltage remains the same (as Daniel
> > pointed out), higher frequency seems to lead to better heat transfer
> > to the environment for the same load. And also the task completes
> > sooner, which is probably always good, ceteris paribus.
> >
> > Not sure how that all changes when throttling enters the game though :)
>
> As I already noted above, the things are quite different when the CPU
> load isn't bursty.  Once the cooling setup is saturated, the heat no
> longer gets transferred effectively to the surroundings, while the CPU
> cores keep producing the heat, which cannot continue indefinitely.  As
> a result, the CPU cores need to run slower and "spread" the total amount
> of joules over time, but they still should run as fast as possible.

Wouldn't in this "non-bursty" case the total thermal production be
driven by how fast the system generates tasks, which is independent of
the thermal and frequency state? If joules per task are constant
(under steady state load), then it shouldn't matter whether they are
generated in short bursts or in a slower continuous flow - as long as
the time to dissipate the heat is longer than the time between tasks
at the high frequency state, in which case we are back to the "bursty"
scenario

> Another option is to introduce active cooling, which also comes with
> its own set of limits, but the initial assumption is that the cooling
> setup remains unchanged.
>
> In the end, if all that weren't the case, we wouldn't need CPU thermal
> throttling at all, or not as much. :)

Throttling would also lower the voltage at some point, which cools it
down much faster!

Best regards,
Alexey

