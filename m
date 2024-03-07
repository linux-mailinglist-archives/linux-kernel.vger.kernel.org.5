Return-Path: <linux-kernel+bounces-95544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA519874F3F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CFC1C2438D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B1312BE96;
	Thu,  7 Mar 2024 12:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1Qt2fzw"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B803233;
	Thu,  7 Mar 2024 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709815120; cv=none; b=oIbZlY4cReV3t16Y1NswgbN/LhcJLg91RqfCasyowdgqr6dkyW03EivN+smUrc4uSeJEjT/oZKAstvTcAa7QnG2jCW/lbnBUSsG47tcjf34KJkMJVcqJf7dg9CwG0s1FYy83ZQwkw48KmFa8yk28unQZ3elR4zx3OolSfjHb6Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709815120; c=relaxed/simple;
	bh=GHG5tKz8t+x8TB3ThH0+zcLMt9MZt5CEGpm9xUMiCPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzPLIjc7BXpcvJl4mYbr3UjTeACTykUC0w5AejNK50mVq+rq/xM9xH4+nbVa6cvHhuo9+yzduN6IFvhJFoblbbULp/2VwLeSx8R0OwBcAV7PcWDj2KKQw1tweDAHW8yP7PCNgBFeWnmXK1NFK7p68zaUgoYv2uBSR3+M1T0/KN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1Qt2fzw; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a293f2280c7so144745666b.1;
        Thu, 07 Mar 2024 04:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709815117; x=1710419917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYEmkHPaO75Pt9X91rpDnDEdVODsoJ/PTraIJQRrksA=;
        b=j1Qt2fzw2chUCPmvgDduLiR1xn1cing9wwdXVCOeo6W8VZFVELfDC+weSeOPtEnj2U
         k+X6JEHaVktyyMTLU1SnRNCvM/Ixo98qJHgySEyZCkAqNJ0ghXmYgYSnGkbhWIzV4jyt
         n2ewYv3O0Oo1x2p5HS2cX5GeQ4xXLleYdIUza7F3AF9xiZlvJ2Cm0gGssp7gL81akpWQ
         JXFvB8PNew4NyRQP05ZTJkGesZvkPODIEZGsW9uC7D8dPgWqQcl/3o6WI1nDRDFsmTFG
         ww8txhy5+U+obApz5BUZO359OPPbjy95CA4b97HyEUAoVUbqXfmLAM7YS+ZT4W+TzOnd
         bOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709815117; x=1710419917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYEmkHPaO75Pt9X91rpDnDEdVODsoJ/PTraIJQRrksA=;
        b=adfbHeVWEA94mdOWtdNol3JLZRoA6uTWj9nx0Ikw1x2mGoRk5x78oZ0vFtw2+Hb2mc
         Dded4KLvzjL6OsOmgWMW0MXm2V8VChBxMITQyeSIgg2nY3/nYqFzugJNwdl1XkA4yg9T
         uNeGG674QSnGghDhbFzdXYouzaw0QYjqDQAkimwtueCLV1wcErlNqd45gsnxPTbo5I6p
         EwLocr5foqxzruQcnW/hJnfkG/oG8QS4cE4SD3RMD49mircoPvdnUDpeIRev5mgyoAfU
         a5T0T662xh97aCAf9rjwRzsWka5tAsl1dKkNcZ7+PFWhYfh/UtuU1PhS3yI3+n1lc1U+
         xUBw==
X-Forwarded-Encrypted: i=1; AJvYcCUo4QA6JGhQr411vL7792/vnsW7+9HzpH15eykZ0p0C0DqN5+4DV9QBdFWUe8gaCWQN4fUIIEuH84iHixKwYtShUIx9QCam9PbPIGZMpCJ3OjhOsnBWTFuGjdmF6j1wTKmW7IY8pEPQfw==
X-Gm-Message-State: AOJu0YxFrrMPjC2kC9QIRR9djV5RzBltdVJW1lqB4pMX3Cq6c8qis6uU
	S9NqCk8QVyj9EJKw4cvIXLMaWs5Wh3TX694+1Sd0Bpr6F9It9XyiCarZFVco4r2wORm/5M+UQiR
	xsYtRhvTMIMeXSixmdwfspzoE+FE=
X-Google-Smtp-Source: AGHT+IF9OWLOQr1CkZTFNEjOLwWvF0gmZSA+Yx2B1AROLJTkZXotXL+3NGJITbTGsBRH1MtZm6wwLwP6rX6yZXlJ/RY=
X-Received: by 2002:a17:907:b9d8:b0:a45:c294:6e46 with SMTP id
 xa24-20020a170907b9d800b00a45c2946e46mr3010733ejc.64.1709815116204; Thu, 07
 Mar 2024 04:38:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <j3krazypdc7gsvnp4kcocaftxsbjrfhj6nr2kf2cieo4bjxbv7@bqdfbirk5tei> <CABjd4Yxs9b0XDXYfdnmT08BQnsJLonRy4X-g73J67yeGw3xL+w@mail.gmail.com>
In-Reply-To: <CABjd4Yxs9b0XDXYfdnmT08BQnsJLonRy4X-g73J67yeGw3xL+w@mail.gmail.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 7 Mar 2024 16:38:24 +0400
Message-ID: <CABjd4YzTL=5S7cS8ACNAYVa730WA3iGd5L_wP1Vn9=f83RCORA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] RK3588 and Rock 5B dts additions: thermal, OPP and fan
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 12:06=E2=80=AFPM Alexey Charkov <alchark@gmail.com> =
wrote:
>
> Hi Sebastian!
>
> On Mon, Mar 4, 2024 at 9:51=E2=80=AFPM Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> >
> > Hi,
> >
> > On Thu, Feb 29, 2024 at 11:26:31PM +0400, Alexey Charkov wrote:
> > > This enables thermal monitoring and CPU DVFS on RK3588(s), as well as
> > > active cooling on Radxa Rock 5B via the provided PWM fan.
> > >
> > > Some RK3588 boards use separate regulators to supply CPUs and their
> > > respective memory interfaces, so this is handled by coupling those
> > > regulators in affected boards' device trees to ensure that their
> > > voltage is adjusted in step.
> > >
> > > In this revision of the series I chose to enable TSADC for all boards
> > > at .dtsi level, because:
> > >  - The defaults already in .dtsi should work for all users, given tha=
t
> > >    the CRU based resets don't need any out-of-chip components, and
> > >    the CRU vs. PMIC reset is pretty much the only thing a board might
> > >    have to configure / override there
> > >  - The boards that have TSADC_SHUT signal wired to the PMIC reset lin=
e
> > >    can still choose to override the reset logic in their .dts. Or sta=
y
> > >    with CRU based resets, as downstream kernels do anyway
> > >  - The on-by-default approach helps ensure thermal protections are in
> > >    place (emergency reset and throttling) for any board even with a
> > >    rudimentary .dts, and thus lets us introduce CPU DVFS with better
> > >    peace of mind
> > >
> > > Fan control on Rock 5B has been split into two intervals: let it spin
> > > at the minimum cooling state between 55C and 65C, and then accelerate
> > > if the system crosses the 65C mark - thanks to Dragan for suggesting.
> > > This lets some cooling setups with beefier heatsinks and/or larger
> > > fan fins to stay in the quietest non-zero fan state while still
> > > gaining potential benefits from the airflow it generates, and
> > > possibly avoiding noisy speeds altogether for some workloads.
> > >
> > > OPPs help actually scale CPU frequencies up and down for both cooling
> > > and performance - tested on Rock 5B under varied loads. I've split
> > > the patch into two parts: the first containing those OPPs that seem
> > > to be no-regret with general consensus during v1 review [2], while
> > > the second contains OPPs that cause frequency reductions without
> > > accompanying decrease in CPU voltage. There seems to be a slight
> > > performance gain in some workload scenarios when using these, but
> > > previous discussion was inconclusive as to whether they should be
> > > included or not. Having them as separate patches enables easier
> > > comparison and partial reversion if people want to test it under
> > > their workloads, and also enables the first 'no-regret' part to be
> > > merged to -next while the jury is still out on the second one.
> > >
> > > [1] https://lore.kernel.org/linux-rockchip/1824717.EqSB1tO5pr@bagend/=
T/#ma2ab949da2235a8e759eab22155fb2bc397d8aea
> > > [2] https://lore.kernel.org/linux-rockchip/CABjd4YxqarUCbZ-a2XLe3TWJ-=
qjphGkyq=3DwDnctnEhdoSdPPpw@mail.gmail.com/T/#m49d2b94e773f5b532a0bb5d3d766=
4799ff28cc2c
> > >
> > > Signed-off-by: Alexey Charkov <alchark@gmail.com>
> > > ---
> > > Changes in v3:
> > > - Added regulator coupling for EVB1 and QuartzPro64
> > > - Enabled the TSADC for all boards in .dtsi, not just Rock 5B (thanks=
 ChenYu)
> > > - Added comments regarding two passive cooling trips in each zone (th=
anks Dragan)
> > > - Fixed active cooling map numbering for Radxa Rock 5B (thanks Dragan=
)
> > > - Dropped Daniel's Acked-by tag from the Rock 5B fan patch, as there'=
s been quite some
> > >   churn there since the version he acknowledged
> > > - Link to v2: https://lore.kernel.org/r/20240130-rk-dts-additions-v2-=
0-c6222c4c78df@gmail.com
> > >
> > > Changes in v2:
> > > - Dropped the rfkill patch which Heiko has already applied
> > > - Set higher 'polling-delay-passive' (100 instead of 20)
> > > - Name all cooling maps starting from map0 in each respective zone
> > > - Drop 'contribution' properties from passive cooling maps
> > > - Link to v1: https://lore.kernel.org/r/20240125-rk-dts-additions-v1-=
0-5879275db36f@gmail.com
> > >
> > > ---
> > > Alexey Charkov (5):
> > >       arm64: dts: rockchip: enable built-in thermal monitoring on RK3=
588
> > >       arm64: dts: rockchip: enable automatic active cooling on Rock 5=
B
> > >       arm64: dts: rockchip: Add CPU/memory regulator coupling for RK3=
588
> > >       arm64: dts: rockchip: Add OPP data for CPU cores on RK3588
> > >       arm64: dts: rockchip: Add further granularity in RK3588 CPU OPP=
s
> > >
> > >  arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts   |  12 +
> > >  .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts |  12 +
> > >  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |  30 +-
> > >  arch/arm64/boot/dts/rockchip/rk3588s.dtsi          | 385 +++++++++++=
+++++++++-
> > >  4 files changed, 437 insertions(+), 2 deletions(-)
> >
> > I'm too busy to have a detailed review of this series right now, but
> > I pushed it to our CI and it results in a board reset at boot time:
> >
> > https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/=
jobs/300950
> >
> > I also pushed just the first three patches (i.e. without OPP /
> > cpufreq) and that boots fine:
> >
> > https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/=
jobs/300953
>
> Thank you for testing these! I've noticed in the boot log that the CI
> machine uses some u-boot 2023.07 - is that a downstream one? Any
> chance to compare it to 2023.11 or 2024.01 from your (Collabora)
> integration tree?
>
> I use 2023.11 from your integration tree, with a binary bl31, and I'm
> not getting those resets even under prolonged heavy load (I rebuild
> Chromium with 8 concurrent compilation jobs as the stress test -
> that's 14 hours of heavy CPU, memory and IO use). Would be interesting
> to understand if it's just a 'lucky' SoC specimen on my side, or if
> there is some dark magic happening differently on my machine vs. your
> CI machine.
>
> Thinking that maybe if your CI machine uses a downstream u-boot it
> might be leaving some extra hardware running (PVTM?) which might do
> weird stuff when TSADC/clocks/voltages get readjusted by the generic
> cpufreq driver?..
>
> > Note, that OPP / cpufreq works on the same boards in the CI when
> > using the ugly-and-not-for-upstream cpufreq driver:
> >
> > https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/=
commit/9c90c5032743a0419bf3fd2f914a24fd53101acd
> >
> > My best guess right now is, that this is related to the generic
> > driver obviously not updating the GRF read margin registers.
>
> If it was about memory read margins I believe I would have been
> unlikely to get my machine to work reliably under heavy load with the
> default ones, but who knows...

Sebastian's report led me to investigate further how all those things
are organized in the downstream code and in hardware, and what could
be a pragmatic way forward with upstream enablement. It turned out to
be quite a rabbit hole frankly, with multiple layers of abstraction
and intertwined code in different places.

Here's a quick summary for future reference:
 - CPU clocks on RK3588 are ultimately managed by the ATF firmware,
which provides an SCMI service to expose them to the kernel
 - ATF itself doesn't directly set any clock frequencies. Instead, it
accepts a target frequency via SCMI and converts it into an oscillator
ring length setting for the PVPLL hardware block (via a fixed table
lookup). At least that's how it's done in the recently released TF-A
bl31 code [1] - perhaps the binary bl31 does something similar
 - U-boot doesn't seem to mess with CPU clocks, PVTM or PVPLL
 - PVPLL produces a reference clock to feed to the CPUs, which depends
on the configured oscillator ring length but also on the supply
voltage, silicon quality and perhaps temperature too. ATF doesn't know
anything about voltages or temperatures, so it doesn't guarantee that
the requested frequency is matched by the hardware
 - PVPLL frequency generation is bypassed for lower-frequency OPPs, in
which case the target frequency is directly fed by the ATF to the CRU.
This happens for both big-core and little-core frequencies below 816
MHz
 - Given that requesting a particular frequency via SCMI doesn't
guarantee that it will be what the CPUs end up running at, the vendor
kernel also does a runtime voltage calibration for the supply
regulators, by adjusting the supply voltage in minimum regulator steps
until the frequency reported by PVPLL gets close to the requested one
[2]. It then overwrites OPP provided voltage values with the
calibrated ones
 - There's also some trickery with preselecting OPP voltage sets using
the "-Lx" suffix based on silicon quality, as measured by a "leakage"
value stored in an NVMEM cell and/or the PVTM frequency generated at a
reference "midpoint" OPP [3]. Better performing silicon gets to run at
lower default supply voltages, thus saving power
 - Once the OPPs are selected and calibrated, the only remaining
trickery is the two supply regulators per each CPU cluster (one for
the CPUs and the other for the memory interface)
 - Another catch, as Sebastian points out, is that memory read margins
must be adjusted whenever the memory interface supply voltage crosses
certain thresholds [4]. This has little to do with CPUs or
frequencies, and is only tangentially related to them due to the
dependency chain between the target CPU frequency -> required CPU
supply voltage -> matching memory interface supply voltage -> required
read margins
 - At reset the ATF switches all clocks to the lowest 408 MHz [6], so
setting it to anything in kernel code (as the downstream driver does)
seems redundant

All in all, it does indeed sound like Collabora's CI machine boot-time
resets are most likely caused by the missing memory read margin
settings in my patch series. Voltage values in the OPPs I used are the
most conservative defaults of what the downstream DT has, and PVPLL
should be able to generate reasonable clock speeds with those (albeit
likely suboptimal, due to them not being tuned to the particular
silicon specimen). And there is little else to differ frankly.

As for the way forward, it would be great to know the opinions from
the list. My thinking is as follows:
 - I can introduce memory read margin updates as the first priority,
leaving voltage calibration and/or OPP preselection for later (as
those should not affect system stability at current default values,
perhaps only power efficiency to a certain extent)
 - CPUfreq doesn't sound like the right place for those, given that
they have little to do with either CPU or freq :)
 - I suggest a custom regulator config helper to plug into the OPP
layer, as is done for TI OMAP5 [6]. At first, it might be only used
for looking up and setting the correct memory read margin value
whenever the cluster supply voltage changes, and later the same code
can be extended to do voltage calibration. In fact, OMAP code is there
for a very similar purpose, but in their case optimized voltages are
pre-programmed in efuses and don't require runtime recalibration
 - Given that all OPPs in the downstream kernel list identical
voltages for the memory supply as for the CPU supply, I don't think it
makes much sense to customize the cpufreq driver per se.
Single-regulator approach with the generic cpufreq-dt and regulator
coupling sounds much less invasive and thus lower-maintenance

Best regards,
Alexey

[1] https://gitlab.collabora.com/hardware-enablement/rockchip-3588/trusted-=
firmware-a/-/blob/rk3588/plat/rockchip/rk3588/drivers/scmi/rk3588_clk.c?ref=
_type=3Dheads#L303
[2] https://github.com/radxa/kernel/blob/c428536281d69aeb2b3480f65b2b227210=
b61535/drivers/soc/rockchip/rockchip_opp_select.c#L804
[3] https://github.com/radxa/kernel/blob/c428536281d69aeb2b3480f65b2b227210=
b61535/drivers/soc/rockchip/rockchip_opp_select.c#L1575
[4] https://github.com/radxa/kernel/blob/c428536281d69aeb2b3480f65b2b227210=
b61535/drivers/cpufreq/rockchip-cpufreq.c#L405
[5] https://gitlab.collabora.com/hardware-enablement/rockchip-3588/trusted-=
firmware-a/-/blob/rk3588/plat/rockchip/rk3588/drivers/scmi/rk3588_clk.c?ref=
_type=3Dheads#L2419
[6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/opp/ti-opp-supply.c#n275

