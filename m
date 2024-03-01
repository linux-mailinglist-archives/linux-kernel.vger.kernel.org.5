Return-Path: <linux-kernel+bounces-88307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 815C786DFE4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3B51F23619
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B946E6CDAE;
	Fri,  1 Mar 2024 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsWId5jn"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691A96F071;
	Fri,  1 Mar 2024 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709291420; cv=none; b=IcRzNAhS626PHTlIAO8KdQ07sxl94Xznax/+ifaqcFv++A0fwggVgIOv4ENIhGWbGCWDaiBFp96LFwD0i69MTso5vkBZu20MaoRLlrc6XewqYnh88RQDRPFoCcstIFF7OM5T4oYb1u8+Grfxk8hzSpnROct2z/JcEmnrG1XJYgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709291420; c=relaxed/simple;
	bh=Zn5tFz4mlwgB2k7uLI30ADrJjag5ECyirJs3HBfHS5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aF9DVncm0aNQBtzPozV7jVdp4Ba28M6yJpbD+k8MIc2gqqt0ngVFraLMH88uhJMoJqk4uiZCS7nxI1G/8VMklWHz60FUbEnyDKIeqdKCc1XNzf7kJgsUKsNK3ybBN9LFaJHlfW2d4UOkdBq3XZncTsCHjqq0CaGTfjr/fcO3KoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsWId5jn; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a44b0b2c7cdso15450066b.0;
        Fri, 01 Mar 2024 03:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709291417; x=1709896217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeRKdGSxMr3JH8iNhj6oycTeZGyjnD0bnEtjcI9n35g=;
        b=AsWId5jnS63P/hISI+VsPfhuheaQ/BlJy1sUnJKxi7M6eHoZ1soQ27/NQgjZiJAzKd
         P4zwsaADMivYssAAwGSLPlczL4QbphlYU2FXNfNZVdj0mTi3ovLcC40WvPlw1BWydH9z
         zvMhJXd/BPaJrSfHLhKz4wpwas6DaO5JeHmas/809buOGaqhytAyu/xPhF9bbDgFXa6J
         c0Jkhrl9N3igwRAzzwuYKe3R5K405feuaxLhv7Ra9a9Ngp3+uzZymzy/vpnXcgv/ee04
         82dCe4dPQpxHZE2B20kJTTWP+Ofn1BJcEletKalk5/E+n1F5NKKCVIyW3CqKj1SzJsON
         RZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709291417; x=1709896217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FeRKdGSxMr3JH8iNhj6oycTeZGyjnD0bnEtjcI9n35g=;
        b=YQ6wHV28yYJu4gZ696SWnbHTbq5tbA2Ij1fqiwfZD363sK8yqrfPZZTd9IjZ0nmXsP
         afV2atjvT5T9CxedPk3ZKpL9Eucc7j3P3eSavSxMfYK3QerqXUxY9ixKxZsSjIxLRfee
         GTzppO53WSXfoZo+I/tMlhTVK+LUwLjFAwo/lVYakSE3SYn2C/EwKoLgjv6B3xjOEO7i
         COAfvVpc5oKPylSK3ROZqCorXrL6ENp6tXa2NCn3OsweE2rxIIw6/On5cyOycGCXiZyH
         H0pCHxX6Zz99mJ476YuyQibXrRMKNp4JBz9pGkJiKU+B8vLNC78OfhtGkJb3hoIMufDv
         uHWw==
X-Forwarded-Encrypted: i=1; AJvYcCWv6ywzVq3msrpeC4jrNvTaWj3lsMUREgdbX50RyJ01mBK3ZVTtL1yP16TNoLtx+h6vEPUw9C23ZJQIHjXb5htP22q6Kx/WixpItv08HzMMUogbO9mCh3PPkvqaNqmmjU8B+ekRchD+1w==
X-Gm-Message-State: AOJu0Yw2D/aBUROi6QsszEJI6ySusqe9bDSfIN1+harco+lKwBMSP4EJ
	I8XwnXr8Qyyzkajbn1EMxVCHqK/SY2wYjj1o1gJm+kh/WKIzP1NyPytzMz15ScypPemSmaTAH+b
	qZeumth/Eq+53jSHKo8HP/aNz81A=
X-Google-Smtp-Source: AGHT+IG1T6KoKoG7SwaIAZeN5HhMYxAGsBloQDuHVLdzf5Rj2mzD7qcNIZEvC7/mXs4ryMSG3UhKHQOyrdfoCLmabGg=
X-Received: by 2002:a17:906:af42:b0:a44:4c8e:f167 with SMTP id
 ly2-20020a170906af4200b00a444c8ef167mr762213ejb.69.1709291416369; Fri, 01 Mar
 2024 03:10:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-1-6afe8473a631@gmail.com> <a370efd768021ce1afd6ea5ce841acbb@manjaro.org>
 <CABjd4YxM3HY20BbLZ2bJbEFuf6Uv9P_=v4NdHuvN2M-pxh652Q@mail.gmail.com>
 <ad00189e1a25ca90128be6c8b3841b77@manjaro.org> <CABjd4YwMtZUhZG12qXv-=L8e2itwr6_Pex3E_ma1UC9MPQ95EA@mail.gmail.com>
 <8b48eeac7b629c39adc6024ff418724c@manjaro.org>
In-Reply-To: <8b48eeac7b629c39adc6024ff418724c@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 1 Mar 2024 15:10:04 +0400
Message-ID: <CABjd4YzjQ8NdA-gdux3YPw2K6dwLn5oNWRAix7raSgoGsEdpbA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] arm64: dts: rockchip: enable built-in thermal
 monitoring on RK3588
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 12:52=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> On 2024-03-01 09:25, Alexey Charkov wrote:
> > On Fri, Mar 1, 2024 at 9:51=E2=80=AFAM Dragan Simic <dsimic@manjaro.org=
> wrote:
> >> On 2024-03-01 06:12, Alexey Charkov wrote:
> >> > On Fri, Mar 1, 2024 at 12:21=E2=80=AFAM Dragan Simic <dsimic@manjaro=
org>
> >> > wrote:
> >> >> On 2024-02-29 20:26, Alexey Charkov wrote:
> >> >> > Include thermal zones information in device tree for RK3588 varia=
nts.
> >> >> >
> >> >> > This also enables the TSADC controller unconditionally on all boa=
rds
> >> >> > to ensure that thermal protections are in place via throttling an=
d
> >> >> > emergency reset, once OPPs are added to enable CPU DVFS.
> >> >> >
> >> >> > The default settings (using CRU as the emergency reset mechanism)
> >> >> > should work on all boards regardless of their wiring, as CRU rese=
ts
> >> >> > do not depend on any external components. Boards that have the TS=
HUT
> >> >> > signal wired to the reset line of the PMIC may opt to switch to G=
PIO
> >> >> > tshut mode instead (rockchip,hw-tshut-mode =3D <1>;)
> >> >>
> >> >> Quite frankly, I'm still not sure that enabling this on the SoC lev=
el
> >> >> is the way to go.  As I already described in detail, [4] according =
to
> >> >> the RK3588 Hardware Design Guide v1.0 and the Rock 5B schematic, we
> >> >> should actually use GPIO-based handling for the thermal runaways on
> >> >> the Rock 5B.  Other boards should also be investigated individually=
,
> >> >> and the TSADC should be enabled on a board-to-board basis.
> >> >
> >> > With all due respect, I disagree, here is why:
> >> >  - Neither the schematic nor the hardware design guide, on which the
> >> > schematic seems to be based, prescribes a particular way to handle
> >> > thermal runaways. They only provide the possibility of GPIO based
> >> > resets, along with the CRU based one
> >>
> >> Please note that other documents from Rockchip also exist.  Below is
> >> a link to a screenshot from the Thermal developer guide, version 1.0,
> >> which describes the whole thing further.  I believe it's obvious that
> >> the thermal runaway is to be treated as a board-level feature.
> >>
> >> - https://i.imgur.com/IJ6dSAc.png
> >
> > Frankly, that still doesn't make TSADC per se a board-level thing IMO.
> > The only thing that is board-level is the wiring of GPIO based resets,
> > which I fully agree should go to board .dts for boards that support
> > it, but that's not part of the current defaults and can be safely
> > added later.
> >
> > TSADC is inside the SoC. CRU is inside the SoC. They work just fine
> > for a thermal reset, even if no dedicated reset logic is wired on the
> > board. I really don't see any downsides in having TSADC enabled by
> > default with CRU based resets:
> > - it's a safe default (i.e. I cannot think of any configuration or use
> > case where enabled-by-default TSADC does any harm)
> > - it's safer than accidentally forgetting to enable TSADC (as it adds
> > thermal protection which is otherwise missing)
> > - it will work on all boards (even if it doesn't utilize the full
> > hardware functionality by ignoring GPIO resets that some boards also
> > have in addition to the CRU)
> > - and it requires fewer overrides in board .dts files
> >
> > Sounds like a no-regret move to me.
>
> Please see my comments below.
>
> >> To be fair, that version of the Thermal developer guide dates back to
> >> 2019, meaning that it technically applies to the RK3399, for example,
> >> but the TSADC and reset circuitry design has basically remained the
> >> same for the RK3588.
> >>
> >> >  - My strong belief is that defaults (regardless of context) should =
be
> >> > safe and reasonable, and should also minimize the need to override
> >> > them
> >>
> >> Please note that the TSADC is disabled in the RK3399 SoC dtsi, so
> >> having
> >> it disabled in the RK3588(s) SoC dtsi would provide some consistency.
> >
> > I'm happy to produce a patch to reverse the logic in RK3399 (and any
> > others for that matter) to also have TSADC enabled by default there,
> > thus saving several lines of code, if it's just about consistency.
>
> But why should we change something that has served us for years, on
> multiple SoCs, with zero troubles and with (AFAIK) zero boards producing
> puffs of bluish smoke?

That's just if we are concerned about consistency across different SoC
series. The point is that I'm happy to make whatever change we agree
upon in a consistent way across all related .dtsi/.dts files - thus no
need to worry about past decisions that have already been implemented
for other chips. Let's just agree on the technical merits of one or
the other approach, leaving "we've been doing it differently
elsewhere" aside for now.

> >> Though, the RK3399 still does it in a safe way, by moving the OPPs
> >> into
> >> a separate dtsi file, named rk3399-opp.dtsi, which the board dts files
> >> then include together with enabling the TSADC.
> >>
> >> If you agree, let's employ the same approach for the RK3588(s), by
> >> having
> >> the its OPPs defined in a separate file, named rk3588s-opp.dtsi, etc.
> >
> > Separate file for OPPs is a good no-regret move to declutter the SoC
> > level .dtsi (as the OPP table is long and boring) - happy to move it
> > regardless of the outcome of the above TSADC discussion. Thanks for
> > the pointer!
>
> Yeah, but I'm not sure that everyone would like that kind of separation.
> In fact, such separation may be frowned upon unless it's necessary.
>
> As I already described in another thread, the separation for the RK3399
> is there only because a couple of different variants of the RK3399 SoC
> require different OPPs.
>
> >> >  - In context of dts/dtsi, as far as I understand the general logic
> >> > behind the split, the SoC .dtsi should contain all the things that a=
re
> >> > fully contained within the SoC and do not depend on the wiring of a
> >> > particular board or its target use case. Boards then
> >> > add/remove/override settings to match their wiring and use case more
> >> > closely
> >>
> >> Of course, but the thermal shutdown is obviously a board-level
> >> feature,
> >> which I described further above.
> >
> > Not so obvious to me :-) I don't mean to be stubborn or uncooperative
> > here, but I really can't find any technical merit in having it enabled
> > at board level instead of SoC level.
>
> Well, please also consider that the PMICs from Rockchip are kind of
> weird little chips, specifically customized to serve particular SoCs.
> For example, they ensure the right sequencing and ramping-up of
> different
> power rails, which is in many cases essential.

Sure. I'm not saying that switching to a PMIC-assisted reset shouldn't
be done where the board supports it - quite the opposite. All I'm
saying is that having at least passive cooling and CRU based resets
guaranteed for any board, regardless of how thought through its .dts
is, seems to be a better default than no thermal protection.

> Thus, who knows what might (or might not) go wrong if we don't reset the
> PMIC at the same time when the CRU resets the SoC?  Unfortunately, the
> things aren't that straightforward.
>
> On top of that, some boards, such as the Rock 5B, use a few additional
> discrete voltage regulators instead of a master-slave PMIC
> configuration,
> which may actually introduce some weird power-related issues, which also
> may be intermittent.  Actually, I've already overheard that the Rock 5B
> experiences some issues of that nature, but I don't know the details.

Those discrete regulators seem to be out of scope of this discussion.

I agree that a deeper power-cycle with proper power-up sequence to
follow it is better when it's available in the respective hardware.
I'm also happy to provide a follow-up patch to switch from CRU to PMIC
resets for the boards I found to support the latter.

The question we have at hand is solely about the default behavior for
a hypothetical new board with minimal .dts, or an existing board where
we can't determine the wiring of the TSHUT signal:
Option 1. Let them stay nice and warm at 120C+ under load, because
they should have known better and should have enabled the TSADC in
their device tree before putting the system under load
Option 2. Get them passively cooled at 85C under load even with no
heatsink, then force a CRU reset out of abundance of caution at 120C
unless they defined PMIC reset in their device tree

I'm advocating for the latter.

> > Switching to PMIC-assisted resets is one thing - it definitely should
> > go to board files, as it depends on the specific wiring of the
> > TSADC_SHUT signal. Enabling TSADC in a default configuration that can
> > and will work on all boards regardless of their wiring is another
> > thing. I'm just arguing for the latter.
>
> CRU-based thermal runaway handling may in theory work on all boards, but
> we simply can't be 100% sure without detailed insights into the board
> designs and testing.  Maybe even the downstream U-Boot does some magic
> during such thermal runaway resets, which we don't know.  It may be
> similar to the SoC reset issues that the RK3399 suffers from.

That might be true, but we're talking about operation at 120C+ here.
I'd rather have my board reboot in any way it pleases under those
conditions, and have that behavior triggered by default even if it's
imperfect, then worry about the correct state of all regulators and
peripherals upon next boot. The latter is important of course, but I'd
rather let it cool down and reboot it manually anyway, because that
heat could have made more things go sideways than just the regulators.

> See also my comment above.
>
> > To me it seems similar to the watchdog timer situation: we enable it
> > at the SoC level [1], as it is expected to work in its default
> > configuration regardless of the board wiring, and it provides
> > protection against system malfunctions. Doesn't matter if the board or
> > its userspace code ends up using the full functionality - it just sits
> > there waiting for its spotlight without hurting anybody.
>
> Frankly, I don't know much about the watchdog functionality, so I'd need
> to research it before I could say something about it.

FWIW, watchdog resets are exclusively routed through the CRU (see
RK3588 TRM V1.0 part 1 page 31). So if we expect that one to work
somehow, probably we should expect thermal resets to work too.

Best regards,
Alexey

