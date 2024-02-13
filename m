Return-Path: <linux-kernel+bounces-64554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7FF85403A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7288728B51F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EDA63117;
	Tue, 13 Feb 2024 23:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MpFBsdNA"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C5D63100
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867621; cv=none; b=KsGuRLvGMeZTr7kCpjNXH/6KtahjjDbxAti1Z6RP5wsHshtsJfLow2ppFl8WqFnMTYLe7cImj09UDYMA9gMh/71LpFqYuBW6NWb/eDmdnVn22czryFa5/kCNogtME1tbvxTNe/a9QoTTPtzfPVBBRYv8I2t+E/JPkcfdbVQIvzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867621; c=relaxed/simple;
	bh=hZDX0moxKA2jr0nQXnCCS4aPrBUL93MmvQjXD7Vlbz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mq/yS9ngWn9XZqRzLqpbADdYPjPcozm8QatEZZVeGN/R1jzMyChzNznP5+VMXR5YYqCQn8CUwW5qDx+reap/914figuM11RQbZk5Ez8eV6XB6yaphnjdII/lF/HwkgczEO3j4ucj05MNgZL5dhLHK2ZUXfzQ+RmknGz08tfY734=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MpFBsdNA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a293f2280c7so692211466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707867618; x=1708472418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egLJA3w8XbBkzhBhvJeKiOGztHliZVh9q//fDQHtqjA=;
        b=MpFBsdNAZTH4zMD1zVtXhKbBLWxD0OGFO6bXW2SVAtxImkXqgVkmL1CRk4Cw1NGFD5
         ogdrPetnKuJpFm5hHXj964bBwUzRuVjUbarQS4hL9cNqex/fkQlK7+3/rr0zWl41IkKA
         DpUmF/ksCLTfdV7tL0WfjOSL4ZjTVzTlo+PKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707867618; x=1708472418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egLJA3w8XbBkzhBhvJeKiOGztHliZVh9q//fDQHtqjA=;
        b=HNUPSqLmWnO1YWlZRLdHD2cg16PyOwl+NHk3muq1tMPiGmSy62sfMEEvgA5sk/S5uA
         QmQTlA4MJ563QI/F6KxdecKlEx/v4YUPgm+6ZCMOvhCub3GO5DsVGlMYeQ4RBjrWYLc3
         2IsWBPasnP6d2/bVueXVBX0un/XR0oXJBp86c3WDZ6wZb8/zeWhmLCHf0S1pqC5EIRsB
         6BuJm0tiZ1TAqaFtRZtujoG+mLh9McldlCV/Me7qtspCdu5N3/KdLqGEvUqxfaCIuSMo
         ZhVk7R9MxHm5p3ETQBkvlq9xQoDiiKSNzs5ivjnNB17gk6gOmszlBwEMOoyDL1Aeri4d
         8VoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqZsJ3f9gb6U3dTdpXkRZ9vXLva7z3wZF95DdW74bgPVpeAnqJ/PjwwPHTrYwFj5xo/VayBqtVfd8m+X4ayhdP5HM+u8kBvvNd38wt
X-Gm-Message-State: AOJu0YymL5hmyStU1xLidmcPhuY7A05j8FgXZhZwEVM+UDYZ/1YYGko8
	K892itHFak7dpAhmYOszqr1SJWbwPHKcTVU9U7G8SGsa2Tfg3kGkatmV0dtB4KOXX1m4/X4NYcs
	pZRXU
X-Google-Smtp-Source: AGHT+IEVVA1ktIdHfJmMzIjerHHCtuLUdwTzpEAlJHL+ecZomftc1FBsoTwZL82Fx9fdvGn7p844IQ==
X-Received: by 2002:a17:906:3549:b0:a3c:f531:4514 with SMTP id s9-20020a170906354900b00a3cf5314514mr579176eja.62.1707867617886;
        Tue, 13 Feb 2024 15:40:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWKQ35jy+pNMu/Fb4Bp3BfYaUyvauXX4ZMnkqI+Y2vBK+nKfQBjy4Ox6op+0az2uKLgZe1dxyobzPNqlAw4+93JeV/mQawQi30Vgdk9
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id m8-20020a1709060d8800b00a3d47ee62c7sm1899eji.124.2024.02.13.15.40.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 15:40:17 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-410acf9e776so97455e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:40:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX7Zg2Z4GAgPlbQPgZcR3DfGc4Tj8UnRwNxR9ex6EwDRzf4aEJ/MHJKnMWBSHYBWksaPuLc8O5iDhBM0kzI9hkMwqklP2WYGz6koHae
X-Received: by 2002:a05:600c:a01a:b0:411:e72d:e5c9 with SMTP id
 jg26-20020a05600ca01a00b00411e72de5c9mr9514wmb.5.1707867294378; Tue, 13 Feb
 2024 15:34:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210070934.2549994-1-swboyd@chromium.org> <20240210070934.2549994-22-swboyd@chromium.org>
In-Reply-To: <20240210070934.2549994-22-swboyd@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 13 Feb 2024 15:34:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WovmtKFiG0OMzpus9=z8UJ+Ev3TrwsVia8pSegvjwUiw@mail.gmail.com>
Message-ID: <CAD=FV=WovmtKFiG0OMzpus9=z8UJ+Ev3TrwsVia8pSegvjwUiw@mail.gmail.com>
Subject: Re: [PATCH 21/22] arm64: dts: qcom: sc7180-trogdor: Make
 clamshell/detachable fragments
To: Stephen Boyd <swboyd@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Pin-yen Lin <treapking@chromium.org>, cros-qcom-dts-watchers@chromium.org, 
	Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 9, 2024 at 11:10=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> =
wrote:
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-clamshell.dtsi b/arc=
h/arm64/boot/dts/qcom/sc7180-trogdor-clamshell.dtsi
> new file mode 100644
> index 000000000000..bcf3df463f80
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-clamshell.dtsi
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Trogdor dts framgent for clamshells

s/framgent/fragment


> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-detachable.dtsi b/ar=
ch/arm64/boot/dts/qcom/sc7180-trogdor-detachable.dtsi
> new file mode 100644
> index 000000000000..ab0f30288871
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-detachable.dtsi
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Trogdor dts framgent for detachables

s/framgent/fragment


> + * Copyright 2024 Google LLC.
> + */
> +

Tiny nit: should this file have a comment like "/* This file must be
included after sc7180-trogdor.dtsi */" like the clamshell file?


> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/ar=
m64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
> index e9f213d27711..c3fd6760de7a 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
> @@ -5,8 +5,7 @@
>   * Copyright 2020 Google LLC.
>   */
>
> -/* This file must be included after sc7180-trogdor.dtsi */
> -#include <arm/cros-ec-keyboard.dtsi>
> +#include "sc7180-trogdor-clamshell.dtsi"

nit: Not that it was terribly consistent before, but in lazor you
remove the "This file must be included after sc7180-trogdor.dtsi"
because (I guess) it moved to the clamshell file. However, in other
dts files you don't remove it. pazquel has the exact same comment and
it's not removed. Pompom has a slight variant of the comment where it
explains the reason (to modify cros_ec) and it's not removed. Could
make it more consistent...


Everything above is either tiny typos or nits, so happy enough with:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

