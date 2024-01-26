Return-Path: <linux-kernel+bounces-39671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B9183D4E5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87AD61C24BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031CF200BA;
	Fri, 26 Jan 2024 06:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njdQswJs"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EAD200A6;
	Fri, 26 Jan 2024 06:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706251512; cv=none; b=D9DQTTCQhP9rV2TwFKoBFxW/SHuaenTTbfvBjEv9A487+U02fLFcR0HTHvdW5C6pjAKm9LyEt5vfS7Xz6rL5DxMkPhoQ1QEfXXwSV90pd6FvexL2zezEicqwB5tVx1VewtZRI7uKOdcwmNGNO49c0M2AgrNZOruR756iCejoGwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706251512; c=relaxed/simple;
	bh=BOxflLzIeMNhS+RFdg54XOCOCuypggJ+q3Ri8WKOQNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=COJu9Phvr89YyVqxiEIs7CdnVbcPNokIzXgdfGBWwfVRXj4cWirAraeB4dONZnK+JCXW/MC8ClttdAg6AkUdLdC/4rhvUk0WhstWfv3Dq9Q4ZyGWgBp1tAHPPcDy7hPnWafUXSHKGd/4FFpEv8WF1+C63071YrIZiINLAVmI/iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njdQswJs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40eacb6067dso687545e9.1;
        Thu, 25 Jan 2024 22:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706251508; x=1706856308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bj886cdMGlDeruMyVMMYt4Qd50oLO2t4eNJsFe4wLA=;
        b=njdQswJsKHZsDGzzwhcRra+yfGjI6BdYJWlhOSFRM6TxafUX8uyG22Hnb7aSMGNpKE
         FV2P9BtI0Is91CQKn/G1ZQoDxFv2jouQhaT5JsoIDSBqFKxbhxvgKqp6vphpNEKXK8J0
         dKh/AHfSKZL+UB/TQuCNfVHzxm3ZBnAWi2AOEdF1eF/qKLEdNTpjfvYc5N0RMoE60f2q
         pI04XGYcmLrRiuPMkKS+DbQqjS4dwm8tH+0E2ymwXaRfYBYU/MNXR0LM9nUHxTF3N9bg
         QOZswJidAzTLBWNndZpJ9g7z13pBNQl46Xn8HIaP2psFqjqb5C5ytqegYyAr8u/elN+h
         xfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706251508; x=1706856308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bj886cdMGlDeruMyVMMYt4Qd50oLO2t4eNJsFe4wLA=;
        b=nzPv9lW2YZcvqDTWSElMff8e5+rGWe9Y+slckznYZLHuQ4xzCIpUWzYV2x35A3hioB
         nOLR6v4BVjnJ0qLtCAKuWVsEBIclfdv0m/yAdHIzTFAg02pbyuxV8u5e+dhxSeiisb1c
         63VYluq0WsjMhKKkhcb/1qMtgKFbqwXVbvdtyq0WwImxJS5s4iSbMsdptPgvUQhjoaYY
         b3Sz9rRL9//W0xl4gL6G0kp20vQedktaVQaKBOGDtBoZYIGyRqkqZEuag1HjZoYjOOb9
         TBjJ4GbtTh4GyUosVgxTUo+bXoPROkG/wR4YcgOgCNeKQPnCQGDpGNz02MNR7mi+u6/m
         xrXw==
X-Gm-Message-State: AOJu0Yxtx5K+ukH5Qi2ZWg1rHt6TofZ6DRUYSntWiXwP7FYSuQTwP/I9
	LVcDWp/r8mBjtATXmQQPl8O6OaQKijxC4bU/O5/nr0gqWeP//2ljAnufr/RrWzRvkFqHE7zUqDu
	twghw/0iTZcw+weuzv3l1Eg8WlnxZ/dstZS00Hg==
X-Google-Smtp-Source: AGHT+IGwFn9jkWBi6z7hbIpnvIc8UUhXAaug5oMycuE622T+gwOxMHYEeneieu3ES3qyNNlnF6tWqAzIfU5vFCVLHB4=
X-Received: by 2002:a05:600c:1554:b0:40e:b908:30f4 with SMTP id
 f20-20020a05600c155400b0040eb90830f4mr280657wmg.88.1706251507902; Thu, 25 Jan
 2024 22:45:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com>
 <20240125-rk-dts-additions-v1-4-5879275db36f@gmail.com> <731aac66-f698-4a1e-b9ee-46a7f24ecae5@linaro.org>
 <ccc004cfae513195351ce0a79e12f6af@manjaro.org>
In-Reply-To: <ccc004cfae513195351ce0a79e12f6af@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 26 Jan 2024 10:44:56 +0400
Message-ID: <CABjd4YxSTLZjrnSCn0fh81US682-uhZ16-cgydzz97shhCpq4w@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: rockchip: Add OPP data for CPU cores on RK3588
To: Dragan Simic <dsimic@manjaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 10:32=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> =
wrote:
>
> Hello Daniel,
>
> On 2024-01-25 10:30, Daniel Lezcano wrote:
> > On 24/01/2024 21:30, Alexey Charkov wrote:
> >> By default the CPUs on RK3588 start up in a conservative performance
> >> mode. Add frequency and voltage mappings to the device tree to enable
> >> dynamic scaling via cpufreq
> >>
> >> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> >> ---
> >>   arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 209
> >> ++++++++++++++++++++++++++++++
> >>   1 file changed, 209 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> index 131b9eb21398..e605be531a0f 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> >> @@ -97,6 +97,7 @@ cpu_l0: cpu@0 {
> >>                      clocks =3D <&scmi_clk SCMI_CLK_CPUL>;
> >>                      assigned-clocks =3D <&scmi_clk SCMI_CLK_CPUL>;
> >>                      assigned-clock-rates =3D <816000000>;
> >> +                    operating-points-v2 =3D <&cluster0_opp_table>;
> >>                      cpu-idle-states =3D <&CPU_SLEEP>;
> >>                      i-cache-size =3D <32768>;
> >>                      i-cache-line-size =3D <64>;
> >> @@ -116,6 +117,7 @@ cpu_l1: cpu@100 {
> >>                      enable-method =3D "psci";
> >>                      capacity-dmips-mhz =3D <530>;
> >>                      clocks =3D <&scmi_clk SCMI_CLK_CPUL>;
> >> +                    operating-points-v2 =3D <&cluster0_opp_table>;
> >>                      cpu-idle-states =3D <&CPU_SLEEP>;
> >>                      i-cache-size =3D <32768>;
> >>                      i-cache-line-size =3D <64>;
> >> @@ -135,6 +137,7 @@ cpu_l2: cpu@200 {
> >>                      enable-method =3D "psci";
> >>                      capacity-dmips-mhz =3D <530>;
> >>                      clocks =3D <&scmi_clk SCMI_CLK_CPUL>;
> >> +                    operating-points-v2 =3D <&cluster0_opp_table>;
> >>                      cpu-idle-states =3D <&CPU_SLEEP>;
> >>                      i-cache-size =3D <32768>;
> >>                      i-cache-line-size =3D <64>;
> >> @@ -154,6 +157,7 @@ cpu_l3: cpu@300 {
> >>                      enable-method =3D "psci";
> >>                      capacity-dmips-mhz =3D <530>;
> >>                      clocks =3D <&scmi_clk SCMI_CLK_CPUL>;
> >> +                    operating-points-v2 =3D <&cluster0_opp_table>;
> >>                      cpu-idle-states =3D <&CPU_SLEEP>;
> >>                      i-cache-size =3D <32768>;
> >>                      i-cache-line-size =3D <64>;
> >> @@ -175,6 +179,7 @@ cpu_b0: cpu@400 {
> >>                      clocks =3D <&scmi_clk SCMI_CLK_CPUB01>;
> >>                      assigned-clocks =3D <&scmi_clk SCMI_CLK_CPUB01>;
> >>                      assigned-clock-rates =3D <816000000>;
> >> +                    operating-points-v2 =3D <&cluster1_opp_table>;
> >>                      cpu-idle-states =3D <&CPU_SLEEP>;
> >>                      i-cache-size =3D <65536>;
> >>                      i-cache-line-size =3D <64>;
> >> @@ -194,6 +199,7 @@ cpu_b1: cpu@500 {
> >>                      enable-method =3D "psci";
> >>                      capacity-dmips-mhz =3D <1024>;
> >>                      clocks =3D <&scmi_clk SCMI_CLK_CPUB01>;
> >> +                    operating-points-v2 =3D <&cluster1_opp_table>;
> >>                      cpu-idle-states =3D <&CPU_SLEEP>;
> >>                      i-cache-size =3D <65536>;
> >>                      i-cache-line-size =3D <64>;
> >> @@ -215,6 +221,7 @@ cpu_b2: cpu@600 {
> >>                      clocks =3D <&scmi_clk SCMI_CLK_CPUB23>;
> >>                      assigned-clocks =3D <&scmi_clk SCMI_CLK_CPUB23>;
> >>                      assigned-clock-rates =3D <816000000>;
> >> +                    operating-points-v2 =3D <&cluster2_opp_table>;
> >>                      cpu-idle-states =3D <&CPU_SLEEP>;
> >>                      i-cache-size =3D <65536>;
> >>                      i-cache-line-size =3D <64>;
> >> @@ -234,6 +241,7 @@ cpu_b3: cpu@700 {
> >>                      enable-method =3D "psci";
> >>                      capacity-dmips-mhz =3D <1024>;
> >>                      clocks =3D <&scmi_clk SCMI_CLK_CPUB23>;
> >> +                    operating-points-v2 =3D <&cluster2_opp_table>;
> >>                      cpu-idle-states =3D <&CPU_SLEEP>;
> >>                      i-cache-size =3D <65536>;
> >>                      i-cache-line-size =3D <64>;
> >> @@ -348,6 +356,207 @@ l3_cache: l3-cache {
> >>              };
> >>      };
> >>   +  cluster0_opp_table: opp-table-cluster0 {
> >> +            compatible =3D "operating-points-v2";
> >> +            opp-shared;
> >> +
> >> +            opp-408000000 {
> >> +                    opp-hz =3D /bits/ 64 <408000000>;
> >> +                    opp-microvolt =3D <675000 675000 950000>;
> >> +                    clock-latency-ns =3D <40000>;
> >> +            };
> >> +            opp-600000000 {
> >> +                    opp-hz =3D /bits/ 64 <600000000>;
> >> +                    opp-microvolt =3D <675000 675000 950000>;
> >> +                    clock-latency-ns =3D <40000>;
> >> +            };
> >> +            opp-816000000 {
> >> +                    opp-hz =3D /bits/ 64 <816000000>;
> >> +                    opp-microvolt =3D <675000 675000 950000>;
> >> +                    clock-latency-ns =3D <40000>;
> >> +            };
> >> +            opp-1008000000 {
> >> +                    opp-hz =3D /bits/ 64 <1008000000>;
> >> +                    opp-microvolt =3D <675000 675000 950000>;
> >> +                    clock-latency-ns =3D <40000>;
> >> +            };
> >
> > It is not useful to introduce OPP with the same voltage. There is no
> > gain in terms of energy efficiency as the compute capacity is linearly
> > tied with power consumption (P=3DCxFxV=C2=B2) in this case.
> >
> > For example, opp-408 consumes 2 bogoWatts and opp-816 consumes 4
> > bogoWatts (because of the same voltage).
> >
> > For a workload, opp-408 takes 10 sec and opp-816 takes 5 sec because
> > it is twice faster.
> >
> > The energy consumption is:
> >
> > opp-408 =3D 10 x 2 =3D 20 BogoJoules
> > opp-816 =3D 5 x 4 =3D 20 BogoJoules
>
> I'd respectfully disagree that including multiple OPPs with the same
> voltage
> but different frequencies isn't useful.  Please allow me to explain.
>
> See, the total amount of consumed energy is, in general, the same for
> such
> OPPs and the same CPU task(s), if we ignore the static leakage current
> and
> such stuff, which isn't important here.  Though, the emphasis here is on
> "total", i.e. without taking into account the actual amount of time
> required
> for the exemplified CPU task(s) to complete.  If the total amount of
> time
> is quite short, we aren't going to heat up the package and the board
> enough
> to hit the CPU thermal throttling;  this approach is also sometimes
> referred
> to as "race to idle", which is actually quite effective for
> battery-powered
> mobile devices that tend to load their CPU cores in bursts, while
> remaining
> kind of inactive for the remaining time.
>
> However, if the CPU task(s) last long enough to actually saturate the
> thermal
> capacities of the package and the board or the device, we're getting
> into the
> CPU throttling territory, in which running the CPU cores slower, but
> still as
> fast as possible, may actually be beneficial for the overall CPU
> performance.
> By running the CPU cores slower, we're lowering the power and
> "spreading" the
> total energy consumption over time, i.e. we're making some time to allow
> the
> generated heat to dissipate into the surroundings.  As we know, having
> more
> energy consumed by the SoC means more heat generated by the SoC, but the
> resulting temperature of the SoC depends on how fast the energy is
> consumed,
> which equals to how fast the CPUs run;  of course, all that is valid
> under
> the reasonable assumption that the entire cooling setup, including the
> board
> surroundings, remains unchanged all the time.

On the other hand, convective heat dissipation is approximately
proportional to the temperature differential, therefore heating up the
core to a higher temperature over a shorter period of time would let
it dissipate the same joule amount faster. Given that total joules
generated for a particular load are approximately the same for
different frequencies as long as voltage remains the same (as Daniel
pointed out), higher frequency seems to lead to better heat transfer
to the environment for the same load. And also the task completes
sooner, which is probably always good, ceteris paribus.

Not sure how that all changes when throttling enters the game though :)

Best regards,
Alexey

