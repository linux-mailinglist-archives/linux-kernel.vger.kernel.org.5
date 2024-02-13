Return-Path: <linux-kernel+bounces-64546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9D1854028
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE91284C10
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B3F63110;
	Tue, 13 Feb 2024 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k1bf6dtd"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A4A63101
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867143; cv=none; b=KeiNn4MSRbD7aYgIoYlCgBfy+MTIHVp5hmrdc+iczTpM7F90XUMCPqaGQ+hYi6KlUNN68zGsxnfeO2Nb8U5kJzuZl57oSpUfXXQQ/p7hQndmRm1yxivcC0E8zSflPl0VzCy8MkqlRd2xYLwKbaVDXjwqPdvdRSJk/zFx+3FM1Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867143; c=relaxed/simple;
	bh=bcNZkTfy8xF0KWYq2Ov+PCZSbZ3Z6PXo5Nj4PAZaHYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjQM0HTRjqFggw+W7X+0BfnceXsx2wXkcTXGtauEmb4v9gPwu6wO7qajFuzGQZ+f6daYLByjkhQiEQZ1m2WSFqfJR0iDGSTLPIHpCknQqoXhPYQ947IsXzAA3IF5sS9yyLz7H32uAgrrhUAQTskzjvQp09RUHhclAX2s87wYUTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k1bf6dtd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-558f523c072so7505871a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707867139; x=1708471939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owV9kvvQ01YV0IOM7V6TZ+A51SR1Xuk2YazbU2H7zpE=;
        b=k1bf6dtdGVHiJVSaTEWCS45bE114FF325Zy7Qqu1iv82knnNs0Q/vdb6k5PC3LJ1Bp
         EKA/BVFUDrEH4FU878Rp5iFNTHjkvJ4Xsic1CSHAqM4srp7LFliqIpYMkJ93+3B2KmtL
         hLA1wPEvQM+vWBuIQNfdKFCVl2N8YYBQKNZSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707867139; x=1708471939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owV9kvvQ01YV0IOM7V6TZ+A51SR1Xuk2YazbU2H7zpE=;
        b=D679U6Qexb0LErYjkxeJvaDk8PLP15VBrqoivziQjCh+ZLDHAcW7L898eQyyPEdZcY
         HTx9btwjMEpgAoLn3t/aLbwBoo4ciQPGWXTXH20qQ/ipuKirxf/aqBOG2xFnBI5Ashgt
         +aZi5LysNgFL2of0Wa5vI9py4JeQu/A+1izlHLcEEFwGSM8nQ/eZ3o72T60vl47QpMmt
         FCgNsurJiiJgDB2lCEbZfTj/lRaAMFzgYClg56a4TdCf7bIBEujG7gzoRYRauanFUr8E
         8PpgsHdHbMun+aA8sB7yopYDsyZZiOxOfQ9fYDJfJjVRP/ufFyMwEgC4Nl5kTJpW+Gtn
         zAAw==
X-Forwarded-Encrypted: i=1; AJvYcCXuDBTnWj2l+G9fPtRZFWMNOf3+Wk0hdbuoeODCpc/FQqIx/MXRvNFOxwXGyg955IzF+bbiElbzL4/U6VIJ7JRyHxeZGzE5/QKvt0yy
X-Gm-Message-State: AOJu0YyjcudRIpphtRMX/NAoky3fxdktDTIW7KC8YS0d6Q7MTUvLrVzQ
	oKs5XoT7DSmAPOLWjbyGeHQC4UYxO4jHuMLRZUihXj2ZZJwpQMXVOQXmff91ACAxv4kcRY6dcP0
	0N8vK
X-Google-Smtp-Source: AGHT+IEnOtaNW/gKtdmiCu+gV7jA1Oc5QRvupWGFPdGEsote3HvW1BoF9iEbpM2c5X6nn5tUdpq1Rg==
X-Received: by 2002:a05:6402:12d3:b0:560:ea64:3810 with SMTP id k19-20020a05640212d300b00560ea643810mr875024edx.8.1707867139681;
        Tue, 13 Feb 2024 15:32:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWalJlx88lgBTSoVJ54/OR67L8uCBuQwGxiBs9v5Rx2dPCdnm1Qa7VIm6gxnV4mZifi7y1vPqtC7yN5gvzk+3PpWQV2HxXSlfXSXGJ3
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id g14-20020a056402428e00b0055fba4996d9sm4125646edc.71.2024.02.13.15.32.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 15:32:19 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-410acf9e776so97045e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:32:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWaJpngyx+eMluWeTUUnxe3fMoHcG5tPy8R/3Q+orpr9gaHQZmyTDMMgyNg482HnkiZBRPFJEXJfcy1nRCbFYfYhhvZLu0qoo/hzz3n
X-Received: by 2002:a05:600c:a01a:b0:411:e72d:e5c9 with SMTP id
 jg26-20020a05600ca01a00b00411e72de5c9mr7584wmb.5.1707866675833; Tue, 13 Feb
 2024 15:24:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210070934.2549994-1-swboyd@chromium.org> <20240210070934.2549994-21-swboyd@chromium.org>
In-Reply-To: <20240210070934.2549994-21-swboyd@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 13 Feb 2024 15:24:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XH=yJdEKSmOq50mXw12hsBc0-oWmhnc4h_itGqfoEjfA@mail.gmail.com>
Message-ID: <CAD=FV=XH=yJdEKSmOq50mXw12hsBc0-oWmhnc4h_itGqfoEjfA@mail.gmail.com>
Subject: Re: [PATCH 20/22] arm64: dts: qcom: sc7180: pazquel: Add missing
 comment header
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
> We put a header before modifying pinctrl nodes defined in
> sc7180-trogdor.dtsi in every other file. Add one here so we know that
> this section is for pinctrl modifications.
>
> Cc: <cros-qcom-dts-watchers@chromium.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: <linux-arm-msm@vger.kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

Bjorn: happy to see this landed any time to shorten Stephen's series.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

