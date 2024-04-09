Return-Path: <linux-kernel+bounces-136209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B54589D139
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5279F285D71
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2364E54FAB;
	Tue,  9 Apr 2024 03:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aWvnMbHK"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C600754BCA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 03:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633988; cv=none; b=AcPuka3SR5JB7OtWXYvRUm5Ol6BhHnUz44J1F+qzRiAdiJEpNNjiI1EvCLLI9Y7TDty1QhIwOROlbJyTKQ7a6dv5matBemT2PAY92k+7YBk4kFPanVJHo/j/a2W9MJnsdkhpDrYD1T735utEBX9LxzgLuUvTx2FfEzlFS0APaa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633988; c=relaxed/simple;
	bh=EZ2T9kzzpeOrUuGVLRbShAImR8PnmT1WmVOGSUHPYL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3eiFGnfzJdVm6I96GjY1mlsxy9ZwKaN5PuMI3VFvW6xoIvckySxhAeHe3npgd+9a+ijCRW6DOy7HYxGW0V8P5bjLsOfyD8WbjyR6UDiJNAPiASeCPuILzOuWp2VXTCcwp6yn3EN2FFk1te3HhWz2jzxfHmEbgFER6mwglE23jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aWvnMbHK; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516b6e75dc3so6492629e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 20:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712633984; x=1713238784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKPZzs2J4lIrxwzL7Z1BludJY/XdSD/M6/ANxlIo6/0=;
        b=aWvnMbHKE0MGGIeoM1pwulgW1s0Muup4TuzdwLMJVccdlTbOSkxAcXwmfFupLApytw
         jQ4yMp+KqwekOEpBgwiNVCzjha/0MztfpSIUVqptFeBWoZh8A5IbhywdB9ZD3lROYcUL
         q6vDkpzw91gq0Q33n/O3XYtncm34njSP7H+7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712633984; x=1713238784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKPZzs2J4lIrxwzL7Z1BludJY/XdSD/M6/ANxlIo6/0=;
        b=iicpzVBFcsU/NB6lcYR7wSWHup6pKmyYwlVeJ9DUECirOEtC94Qh2qhhqO4+LpPj1M
         BiGKlH88vKBsWK65jHCodt2LiXGFBk2bDjnFzE1nCMPeWkVKKX0zou9+ZCtZFNIfNBm0
         CT10VJf3SH8HYjj6E+tU2AX6SNQ5KY56a6hKv8eDOh6hQvvv9NOiK0FSYJ5HsFHS3zG8
         8lr7OY2LvQSd7uuibPqjU9FJbxoTcHGResOl0NOneu/5Z2kBHyBCA/T3p1rIxDw/42FU
         0ebKluybIWT+BWpqOaDpAG1T8P+em1jbKOUpvwOGuTEeeJOtR5CLULsQyTsWOMcyBGZv
         Fp3A==
X-Forwarded-Encrypted: i=1; AJvYcCW18QlzzIBU2aTcR90eTu9gad32FqjLCNsqXBaED5vo198a07+C0I9GrdTpEVRIxIP2evtScmxOPydyvxc2xMjPZ5RFZ3f9MZ55Sr5A
X-Gm-Message-State: AOJu0YySOwfYTbn1V7sG5cuACYqoIbgv8+mc8cFAINLpz/c54CCpJ3YU
	AjU/I0kC4x+rrfRPXBJcPYGk+mY+oFC7dMCaZI56q/4azTDmN9UtRG4uRh1M/8aky3RpZ1qrsT9
	rygDJdqTA5+Zt3m2uBMWB1Qi/QL4kXK/PSFK6
X-Google-Smtp-Source: AGHT+IFba+BrwCMiOouL0a7dqzF+zOfyVTmCHkiqgDT24USb8iVyp548tZZRYidWDUI6/w60evjxT4xx96AaXSCW7qY=
X-Received: by 2002:ac2:43b6:0:b0:516:c099:e785 with SMTP id
 t22-20020ac243b6000000b00516c099e785mr6549819lfl.20.1712633983546; Mon, 08
 Apr 2024 20:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404081635.91412-1-angelogioacchino.delregno@collabora.com>
 <20240404081635.91412-3-angelogioacchino.delregno@collabora.com>
 <CAGXv+5F9rfTVDExKSCF7fBKwR+HijNzFYE6+4aHKw3ZP81DG9w@mail.gmail.com> <5e385c2e-6509-4347-96a5-4606b32d20ff@collabora.com>
In-Reply-To: <5e385c2e-6509-4347-96a5-4606b32d20ff@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 9 Apr 2024 11:39:32 +0800
Message-ID: <CAGXv+5HkKZr0tDPhS9qVs=Uw7YYpfFYaC2Qf4Suv7RznUNWVsQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: chunkuang.hu@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	matthias.bgg@gmail.com, shawn.sung@mediatek.com, yu-chang.lee@mediatek.com, 
	ck.hu@mediatek.com, jitao.shi@mediatek.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 6:16=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 08/04/24 05:20, Chen-Yu Tsai ha scritto:
> > On Thu, Apr 4, 2024 at 4:16=E2=80=AFPM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> Document OF graph on MMSYS/VDOSYS: this supports up to three DDP paths
> >> per HW instance (so potentially up to six displays for multi-vdo SoCs)=
.
> >>
> >> The MMSYS or VDOSYS is always the first component in the DDP pipeline,
> >> so it only supports an output port with multiple endpoints - where eac=
h
> >> endpoint defines the starting point for one of the (currently three)
> >> possible hardware paths.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@c=
ollabora.com>
> >> ---
> >>   .../bindings/arm/mediatek/mediatek,mmsys.yaml | 23 +++++++++++++++++=
++
> >>   1 file changed, 23 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,m=
msys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.y=
aml
> >> index b3c6888c1457..90758bb5bcb1 100644
> >> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.ya=
ml
> >> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.ya=
ml
> >> @@ -93,6 +93,29 @@ properties:
> >>     '#reset-cells':
> >>       const: 1
> >>
> >> +  port:
> >> +    $ref: /schemas/graph.yaml#/properties/port
> >> +    description:
> >> +      Output port node. This port connects the MMSYS/VDOSYS output to
> >> +      the first component of one display pipeline, for example one of
> >> +      the available OVL or RDMA blocks.
> >> +      Some MediaTek SoCs support up to three display outputs per MMSY=
S.
> >> +    properties:
> >> +      endpoint@0:
> >> +        $ref: /schemas/graph.yaml#/properties/endpoint
> >> +        description: Output to the primary display pipeline
> >> +
> >> +      endpoint@1:
> >> +        $ref: /schemas/graph.yaml#/properties/endpoint
> >> +        description: Output to the secondary display pipeline
> >> +
> >> +      endpoint@2:
> >> +        $ref: /schemas/graph.yaml#/properties/endpoint
> >> +        description: Output to the tertiary display pipeline
> >> +
> >> +      required:
> >> +        - endpoint@0
> >> +
> >
> > Technically the mmsys device serves as an glue layer for the display
> > pipeline, providing things like clock control and signal routing; the
> > device itself is not part of the pipeline, and probably shouldn't be
> > part of the graph?
> >
>
> That is (only) partially true: in the case of older SoCs, the MMSYS can o=
nly
> connect to a single first IP of the pipeline, but in the case of newer on=
es,
> and especially (but not limited to) MT8195 onwards having multiple instan=
ces
> of VDOSYS, that really becomes part of the pipeline.
>
> This is not because of the possible different first IP in the pipeline, b=
ut
> because of support for dual-interface (DSI and DP) that, in even newer So=
Cs,
> can be done with cross-mmsys (cross-vdosys, actually...) as some of those=
 do
> have the two in different VDOs.
>
> So yes, this can be done without the graph in MMSYS *in this precise mome=
nt in
> time*, but we'll anyway end up adding it sooner than later - and I'm doin=
g this
> right now, instead of later, because it's also simplifying the implementa=
tion
> so like that I'm "catching two birds with one stone" :-)

I see. Thanks for sorting it out. We had something similar on Allwinner
platforms but it was never as complex or flexible as this.

ChenYu

> Cheers,
> Angelo
>
> > ChenYu
> >
> >>   required:
> >>     - compatible
> >>     - reg
> >> --
> >> 2.44.0
> >>
>
>

