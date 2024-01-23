Return-Path: <linux-kernel+bounces-34694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19FC838638
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF0111C24D7B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BC0185B;
	Tue, 23 Jan 2024 04:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AGQsdm8G"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E766417FE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 04:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705982603; cv=none; b=QjMkD8ILcZFm40FOp7WHZf2ZYcmP+bu3QP+QBeOyDJfwY6iBO6qfZqKEdEkGGYJbCfmPfWH3IoyZy35Q+k1zQobPTJRydYI76GUBNQgCRqHXBcNtgF7mf+3/F4vIonhg4I0PCGCfT3J+FKuST7s/FM5sEemObfLh7bkQ12nmeaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705982603; c=relaxed/simple;
	bh=8zPcSrF6GmbzOiYc91taFPys9TJUmsTbr1QKDG1KWzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQ6cRH+p100G7eYs31MVgg3BWk4tPSqNAsGI/cFPgscvACtLhF+OGNlk8CQEq118+gXK0ViKPQs8qLTTFB1m9WMs9p961xgUNRMW4OngQP6FGA+n2jo+r9YTyC/nN07g/XreKnxfhqwBKjfhoGcd1mwoyrQnnKrtlIlTMmC61R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AGQsdm8G; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cdb50d8982so43762241fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 20:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705982600; x=1706587400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZiWFNa696bYRV0aTpMTHBZfZZ8Fbva5ASueNEpSuTo=;
        b=AGQsdm8GnZmIgookWVaY/7zA/9hm1n0LfseZIidLGefxH6cWNG3c6JRNupaIZQRmn9
         8GBAtlt1sMjZmk5JlusWJen5CpdybU9xRHBLCwGPPus5bH+XCE6MqWjcaTjrX2FdZB9e
         A5CC3t0IzcgU0SAXjN3lO7vSOjVOzMz1ilLhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705982600; x=1706587400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZiWFNa696bYRV0aTpMTHBZfZZ8Fbva5ASueNEpSuTo=;
        b=ieyAWUStwX2bAolvQU6MH68HTFuvAv8BaQtTrL0VWlAP9579moTmWtiIYwFvV4JH7n
         hAjxwSMD3Z3gY5Vc+ztw2EKBJd/u+2zByPzdKIsh/+UIYEA/ugzWfcl6BYd8QCqPB+BJ
         QyPnUliqPv2XORqDSZvPxGSttbirN7I2lMXTBn9ixkQjVNKQnKZ2dXf7Xfo7e0kUwZLX
         kPo78y9OxYdR24I37+hXjoFJmTohzF9Kqsj2iZq+BMAFNtJWQXg3Zpg96tE11FqqAYzf
         Lrvrk2GHmQAuQnX8Ojn7W9NmSx8K4y68ObKBUFDG40fnOS7P1LGtpTL0CefDEoJYH8jK
         E0Hw==
X-Gm-Message-State: AOJu0YxEVfXFDu9uTfDvT1U++rOBdUNXI+jFa+jt0vDr4UJNCgfaYkav
	KlkC7OCo3uQzYfPg5bmyRUqf2aSY/pohzcCBZz0m0l7iublLpds/XOUwu0cANgx5rwbUIjOeI5T
	c7gx8qJL+hLA4ox2kQSchrvqUz6H13pDsamU1
X-Google-Smtp-Source: AGHT+IGiy9y9L53Ax5tTXs/dc2tT4NfqKH1k/Qj4AXIACAgYekrtU+BVkqbTaBWD6iDaDB+W8QdXO0quF0B5cBl9/58=
X-Received: by 2002:a2e:9112:0:b0:2cc:769e:723d with SMTP id
 m18-20020a2e9112000000b002cc769e723dmr2352566ljg.87.1705982599785; Mon, 22
 Jan 2024 20:03:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228105717.719624-1-yuanhsinte@chromium.org>
In-Reply-To: <20231228105717.719624-1-yuanhsinte@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 23 Jan 2024 12:03:08 +0800
Message-ID: <CAGXv+5H-mpXZ_0H_HchDWeTgx+4Nkxh6651DEs1C62mrXczTkA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] arm64: dts: mt8195-cherry-tomato: change
 watchdog reset boot flow
To: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+CC Nicolas

On Thu, Dec 28, 2023 at 6:57=E2=80=AFPM Hsin-Te Yuan <yuanhsinte@chromium.o=
rg> wrote:
>
> The external output reset signal was originally disabled and sent from
> firmware. However, an unfixed bug in the firmware on tomato prevents
> the signal from being sent, causing the device to fail to boot. To fix
> this, enable external output reset signal to allow the device to reboot
> normally.
>
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

Friendly ping?

Also wondering if you folks hit this, or if you haven't triggered the
watchdog at all.

ChenYu

> ---
>
> Changes in v2:
> - Limit the effect only on tomato.
>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts | 4 ++++
>  arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts | 4 ++++
>  arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts | 4 ++++
>  3 files changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b/a=
rch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> index 2d5e8f371b6d..a82d716f10d4 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> @@ -23,3 +23,7 @@ &sound {
>  &ts_10 {
>         status =3D "okay";
>  };
> +
> +&watchdog {
> +       /delete-property/ mediatek,disable-extrst;
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts b/a=
rch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
> index 2586c32ce6e6..2fe20e0dad83 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
> @@ -43,3 +43,7 @@ &sound {
>  &ts_10 {
>         status =3D "okay";
>  };
> +
> +&watchdog {
> +       /delete-property/ mediatek,disable-extrst;
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts b/a=
rch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
> index f54f9477b99d..dd294ca98194 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
> @@ -44,3 +44,7 @@ &sound {
>  &ts_10 {
>         status =3D "okay";
>  };
> +
> +&watchdog {
> +       /delete-property/ mediatek,disable-extrst;
> +};
> --
> 2.43.0.472.g3155946c3a-goog
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

