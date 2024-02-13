Return-Path: <linux-kernel+bounces-64536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA8785400B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C381C20E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6651633F9;
	Tue, 13 Feb 2024 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TPspMKOs"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C15F63103
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866669; cv=none; b=QhndgOzfGI0mZP8WtKpqzBmJbSIF1q4134h0DMCpV2O6pJ3A7g4aQYe8HYpmEkuBOpLNfC/imKi5YeXF0M88riZJXneGEDmJu+ZjUXOL2mmvovYvMlNfhQe8/2IdwpuZ52pebtOORfvKxbC+QvuWT2t5jpTyyy0jvP9lt3hItmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866669; c=relaxed/simple;
	bh=SNOVFhian0wSmfjQUWbhIZH1oLKhGuatN3RQQaM/zI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMxXygmXfKpY8mQO5EoqRr2gzL+eJpGNm/Vm8u90YgqgddH2vgofxg8OdSu2jJ5EAQY/E1CFZNXmRdi41oGjNovsHR3orufI9H//gq3OdummvTzOZ1bGJVnW1BIu+jKEObxNpu4SKW/b3nnXKcKh/6q0pZKsxEh2Rofr2wD1xdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TPspMKOs; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3d2cce1126so60954766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707866662; x=1708471462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyzkdDn36VkqM4HUW3/5Yc8FfYXf+Vgri3xwPCVSUsQ=;
        b=TPspMKOsrV8aSUQARaHs7Jl2xx5/lqXWOuMBls7HyH2hBMi11g7yOXbtll5xYDuQtk
         LW4aFr8+R284ZjI5XS59L7yWXwmMG2yJvHh/SvI+iwDlZGgWIx2x8n/x+hOckH8VutX4
         68nand1erw/FU60tAKKQaLMKz01fuA56FWr44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866662; x=1708471462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyzkdDn36VkqM4HUW3/5Yc8FfYXf+Vgri3xwPCVSUsQ=;
        b=F4zWkZF52zqBlODn+3t2MGRi6/v/mV0OhFv3829UkW/h5LsVkzMQjiFSxakNYiB9nY
         hhqFBV8JLs2/kWF7SKAC+0du6nvcdhG0bb4plu80sjUKg5fgNd42GsdhOWD28/mPp0z1
         g4oFXF1XAVwsNLPyslAP5ZVo5ElN8/d6XiqbT1JAwXEv22odTmKleI57JcYlsb1L3e4O
         Xe1ORFjdXvuMLjhkOCWjsHmGT9qouyeC1B+AYKfLaObjg5sRUS5ohOotOX6maLehh8GO
         twSPC6EHQf2sCoICyeT1NiH4/yXxOvUGLVtzvqC25nFwKd8GpDMQZXzsZb0c6S3bk4Kz
         iIKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDOVbjyWwwCwmIE4vndZj7xoehactqiDveWRlzS2m8yZke6Y6FdQKV7m5aF5Z5RbkStsb+7Xybhs4guTuIeCADpJMVzO//HMj0vCIt
X-Gm-Message-State: AOJu0YwFhS1Smn5CtTgh3ketH5RtTGDRwQuEqmMg9p4MwvgysdorHDjE
	2sCF8JBwUpVPp1oJC2al3w4gM1xwtUfTyVDHlDUghsx8qwqg53d803PFn7OUFhyVvcnZ2Ckqulz
	PymNR
X-Google-Smtp-Source: AGHT+IGnYFPL11a9eocVVWJws5KRPonrvlMynQjnoJgqmrouD3Xd5t2MKIA1WtX/JCMgFKv6Upk6IA==
X-Received: by 2002:a17:906:6812:b0:a3c:a4ba:7917 with SMTP id k18-20020a170906681200b00a3ca4ba7917mr548163ejr.0.1707866662279;
        Tue, 13 Feb 2024 15:24:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWRJ/XbHTVGcDw5ZbzpBQAFb88uDKozd9mK+yK1DHbMWwX/VDr5vnHLqcwfEWtmYKyHGIlCdRaOnK4PJHfvCf5GX1/CRVEBCQxJpuFV
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id g7-20020a170906594700b00a3d35017d77sm202241ejr.205.2024.02.13.15.24.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 15:24:21 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-410cf70a057so97365e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:24:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqX1uIdmf2QEcjX/T8TN+UMzS/mUYScLRb0D0t0kJ98mfldj6KhCcxhO64i+3/nXR0XH3BRGmmKFi8xQWXSV/hsuLwMDCCfn83zGUH
X-Received: by 2002:a05:600c:a16:b0:411:cf85:9549 with SMTP id
 z22-20020a05600c0a1600b00411cf859549mr57493wmp.3.1707866660353; Tue, 13 Feb
 2024 15:24:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210070934.2549994-1-swboyd@chromium.org> <20240210070934.2549994-20-swboyd@chromium.org>
In-Reply-To: <20240210070934.2549994-20-swboyd@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 13 Feb 2024 15:24:03 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XxX9wqZdwf9Wtq2=KOKgTr5FhyJJWp8S9W1xFW3cY80Q@mail.gmail.com>
Message-ID: <CAD=FV=XxX9wqZdwf9Wtq2=KOKgTr5FhyJJWp8S9W1xFW3cY80Q@mail.gmail.com>
Subject: Re: [PATCH 19/22] arm64: dts: qcom: sc7180: quackingstick: Disable
 instead of delete usb_c1
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
> It's simpler to reason about things if we disable nodes instead of
> deleting them. Disable the second usb type-c connector node on
> quackingstick instead of deleting it so that we can reason about ports
> more easily.
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
>  .../arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Bjorn: happy to see this landed any time to shorten Stephen's series.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

