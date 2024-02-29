Return-Path: <linux-kernel+bounces-86218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D040A86C1B7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7317A1F24B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2051044C76;
	Thu, 29 Feb 2024 07:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="efzuX+ou"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF66D44C69
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 07:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709190830; cv=none; b=okAEdYcV9T8g3Y/VVOCuiIB9YkBMnFy2+91HtVQ/3k/ROY7C/epfbP4O2j/BWq+bFn/urazVuk70YKyQDbJ7GrBytSzM57J5lApQ/dfondLkEsWnYiQCgbFrbzQ5MqFDKme4CZkmsFlkP22NOi7kCUeLtaImDt4UqLXcfVuNBiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709190830; c=relaxed/simple;
	bh=M7x6Cc66pxbPK+o8J4gSFs2O1DtEGK4dKrrN13xWZGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwybLDPM/CU1EnuOHtt7m+BcyG17zu1QuIsk8ciByQi0nRynosrdJRMACJMAhnybAds7vQa3cy1fQ9X0OJMFhBaiWfYruN/Q9qEmAyejLkbpqml3jHjkaIrsXT/QbTiJNIjWcbd5pgOSke3z7sRUmVHK2IHpzORyetD5jTOANBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=efzuX+ou; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5131be81f12so571731e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 23:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709190826; x=1709795626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sW1HtD6+QhlshBfo2O8TyLUxF3XBhVUqFEhPUgz1nks=;
        b=efzuX+ouME/RAM8ZkUVkNB0x5lZ05n1IveYAl5gtEw9j7wKLjDaUHJMCvXiOom0lrB
         75jAIZMM3s856HUIkvNTRh8O4u11tiGtkZzv7mL16xUuz4DhxmUP/m2SD5rmR4GkFCQo
         E9bu6A0i5IgYzgTwaXgDSWh4Wf1Qwy8Yk/6ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709190826; x=1709795626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sW1HtD6+QhlshBfo2O8TyLUxF3XBhVUqFEhPUgz1nks=;
        b=a0lNS5lOFIaFR5NlewK2wmFdEeJevClfK/u/Be3ku2TPoexZP/EhdcRMehhNa+Fd6H
         j/hl02+23ZS5jclN1+li8cGgqSZwbNtv9E3mNm2Ips7QarYiYWYrwxYT9pLaDeNGJLQC
         pPlfDvWyrMZFulHERsi7OGZsmSy9DlJX+tU/3p3C+cepZinDP3nXPoGEmIISnqmbcAJ4
         TMtpzLXFsk72zJRFVbJrPbt2+IHWmplO3AbQmCq1tHH117tvHv3HCTzV4iNTMHxK8Ht/
         x40XBkZi4F4d/FYO7FXlocN2oGq2guye4pHBnZqMrr6H/ba7paJLfqM04NL5ihisvg5C
         MdDg==
X-Forwarded-Encrypted: i=1; AJvYcCWpHdcFS8AHxuOHRPWOsOEpMyw4uzQOx+gdzb4f9h09l1KBVsYv7TiYxJ4muf04oaHjDQjJBWrI6mCJF16oquwDoIrwf/JrEqpqY55v
X-Gm-Message-State: AOJu0YyKEqLYXxEB6lpMj+ho1sD35Lv8hk5gGbES65f3kG6K5rXmGL6e
	h4Og1hZCYIBkglvSrImACocpJCJhemvWY53Bcyq/jSGpf17hNw/4K6IqEiHKltooXndTDWuzIZ6
	DujJTr1TH1PfmhYEvsd9SALazG8cw9napae4j
X-Google-Smtp-Source: AGHT+IHYP2zEhw8fwOpmvt31M+HZmbYGEsHZBSayotV4ShVjz9H7wVGQo4fCF7t4FZe3rQUT6hsM0aXuVn25hgznTb0=
X-Received: by 2002:ac2:5145:0:b0:513:1e22:1f17 with SMTP id
 q5-20020ac25145000000b005131e221f17mr779797lfd.29.1709190825888; Wed, 28 Feb
 2024 23:13:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223091122.2430037-1-wenst@chromium.org> <feab2039-5745-41a4-87c3-44fa266efc1d@collabora.com>
In-Reply-To: <feab2039-5745-41a4-87c3-44fa266efc1d@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 29 Feb 2024 15:13:34 +0800
Message-ID: <CAGXv+5GpTJzMHxY+J6PshW6-xLfc5G3DTuAG4d9eCc+=WWRd9A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183: Add power-domains properity
 to mfgcfg
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Ikjoon Jang <ikjn@chromium.org>, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Weiyi Lu <weiyi.lu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 4:54=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 23/02/24 10:11, Chen-Yu Tsai ha scritto:
> > From: Ikjoon Jang <ikjn@chromium.org>
> >
> > mfgcfg clock is under MFG_ASYNC power domain.
> >
> > Fixes: e526c9bc11f8 ("arm64: dts: Add Mediatek SoC MT8183 and evaluatio=
n board dts and Makefile")
> > Fixes: 37fb78b9aeb7 ("arm64: dts: mediatek: Add mt8183 power domains co=
ntroller")
> > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> > Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > This patch is long overdue. Could we merge it for fixes for this or the
> > next release?
> >
>
> A clock controller that needs a power domain? Can you please describe the=
 issue
> that you're trying to solve with this?

Our issue tracker doesn't have much on this. But this was part of the initi=
al
submission for MT8183, but somehow got left out. The clk driver patch to
enable runtime PM was even merged, but was effectively reverted following
the clk driver rework.

> It's not very uncommon but I'm not entirely convinced that this is right,=
 because
> the MFG_BG3D is a gate - and it's *not* outputting a clock rate on its ow=
n: the
> mfgcfg is entirely GPU related and if there is no GPU support this clock =
is not
> even ever needed.

It could be just a gate, or could be a buffer. Either way, the registers to
control said device could be in a power domain that is not always on. I don=
't
think this can be ruled out.

And if the registers are in a powered down domain, then either the readout
would be bogus (if access isolation is implemented) or just hang the system=
.

ChenYu

> MediaTek, can you please clarify if (and why) this gate clock needs a MTC=
MOS to
> be ungated?
>
> Thanks,
> Angelo
>
> > Changes since v2:
> > - Rebased onto current tree
> > - Added Fixes tags
> > - Fix up subject prefix
> >
> >   arch/arm64/boot/dts/mediatek/mt8183.dtsi | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot=
/dts/mediatek/mt8183.dtsi
> > index 93dfbf130231..774ae5d9143f 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -1637,6 +1637,7 @@ mfgcfg: syscon@13000000 {
> >                       compatible =3D "mediatek,mt8183-mfgcfg", "syscon"=
;
> >                       reg =3D <0 0x13000000 0 0x1000>;
> >                       #clock-cells =3D <1>;
> > +                     power-domains =3D <&spm MT8183_POWER_DOMAIN_MFG_A=
SYNC>;
> >               };
> >
> >               gpu: gpu@13040000 {
>
>

