Return-Path: <linux-kernel+bounces-64319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C1B853CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB201F234FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E13062148;
	Tue, 13 Feb 2024 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MDMpb4pm"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A41B4501B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858591; cv=none; b=cWyBQt+Io2/GgKp+oXhpXSOVr6IGCOu0t3IKFsmSDN9G5YK+BA8/n1ymvXMckDG2x+qklN1/ztvmA9dY60nJIoxoOY5rx9gINcRTMSK5wAdRnzN+zg3wSIcNwLQ0V1gY5b6IVT9RpqfAcceZ/4DHrAXny0mRqY2qJvREaezgVuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858591; c=relaxed/simple;
	bh=yE563jYemyl/vAZ+FK/z0jc0wfNO0ntt3wJwgwq9H40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyDWfSy0drWGzm1YGpy29wYgnQgDLwgb63i1m3rRkA4BmMfCaymV7sV+/m6OTfBhEZS/ZYiXk6r5B6Hbc7nChxoWOrQLucJ6f3j+u1d4ixIsr2YGLclofvIsxdxhqt/4faSxiBHKa8OOGb8VMyCLR4NWwhm5RI5oitj3x5rjR9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MDMpb4pm; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5620f15c3e5so946955a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707858587; x=1708463387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odSVkG5Ep60HRCR2A/0o61mTWPkFfp+uEG3bmWlcvqQ=;
        b=MDMpb4pmYr5kNXB94iWQO9W3RymH8jC8OzQZIHa04lsZZtKnk56Tg+LnvQ7GcvyuLb
         Gtuep7G0JleVYgKgM2Dyi+izFPQ9etLhWLMdy/Vh2UiCLeruHwa/ysy4vmPS55eCNFsW
         nEE6328pdD0OtCGJn6aSXDinxyeW1aNFjfTck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707858587; x=1708463387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odSVkG5Ep60HRCR2A/0o61mTWPkFfp+uEG3bmWlcvqQ=;
        b=XM75bXLzLDBc4AHgViLcXtzH5M6EC74T+Pss9vnSaHRWxsQ4kpIpG7XPGuxVIcC+rS
         eepB98/jNScQJLOx4Opuikr/NUx+pa5hqCNHolyzQQSbNAZrU8Auv/LT3mAzMPoCkBve
         jrQXh8JB4moyM6ivFq/rv+eTS2RLIx/MZtzmztDccHbjWezdkF1lTVd1AQ/9m3QVqwnj
         o6qI5KZl8DVvUq3wZQ2SSyhbwdAompcCduFsl26RnGeYe/0ohz8n9snWBtEpxLPqNNT2
         0CGfyqxf2oN90J5V/Xz7C2ADTGMGbx6l1fQG6F9z90sSXFfkyiF95+MeanvPq9tNFkZp
         kPvg==
X-Forwarded-Encrypted: i=1; AJvYcCW0BDpKDzbMHa0wEI1wbcV8hhHTHFiLiMBY3+SMSStRcZE1SHI1mT2iWey82YIywffCgqDCnbaYO3z64I2VBpwkXjS9yAgdGCbWodEu
X-Gm-Message-State: AOJu0YxH14+TyYx6Y37FQtwS5WouGKJldpbTh70sLIXB1T3lcT5lLoOA
	qauX3GUeyvySH6wKpRZT5Ngwisyk5IXO5ILh6EDIGY1lqnM/tptJw18byUTPIEzAONyXnub4hX+
	uSA==
X-Google-Smtp-Source: AGHT+IFAVXnTwShs2v9rntKUPcdqky6dn6OLnsAkdVEj3wExsLDc5kHVWTHRK4DOEUq4LCPLKG2NLA==
X-Received: by 2002:a17:906:7c9:b0:a3c:1402:e042 with SMTP id m9-20020a17090607c900b00a3c1402e042mr318233ejc.37.1707858587029;
        Tue, 13 Feb 2024 13:09:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWiKjikcEjYtMriI9Uojx/DxFsxWTKML9V/2WZOQybsGJOFI71aNQcXlaFGvUuN7iuzkUDBx842DnzOMlVzKK+HXWJk6KyHlR+JwqCl
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id ti13-20020a170907c20d00b00a3ce3c5b2a4sm1461202ejc.195.2024.02.13.13.09.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 13:09:46 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-410cf70a057so88505e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 13:09:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPXNPfMfM3AhbD4LuXanVEWaisDhHBFNxLOltzX/zlfbWe3yuLkjc4B9gWeB7aiGNpaHBcthWSnCca0ESgZTgK/WsqUxpV7CuQgt/C
X-Received: by 2002:a05:600c:1d93:b0:411:cdf8:f3d1 with SMTP id
 p19-20020a05600c1d9300b00411cdf8f3d1mr85206wms.0.1707858585791; Tue, 13 Feb
 2024 13:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213145124.342514-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240213145124.342514-1-krzysztof.kozlowski@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 13 Feb 2024 13:09:30 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V+MNxSpNLCjrHb553QrK4NjZHNJZymQ9+Q7qB2qjOfEw@mail.gmail.com>
Message-ID: <CAD=FV=V+MNxSpNLCjrHb553QrK4NjZHNJZymQ9+Q7qB2qjOfEw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: replace underscores in node names
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 13, 2024 at 6:51=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Underscores should not be used in node names (dtc with W=3D2 warns about
> them), so replace them with hyphens.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8939.dtsi              |  2 +-
>  .../boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi  |  2 +-
>  .../dts/qcom/msm8994-sony-xperia-kitakami.dtsi     |  2 +-
>  arch/arm64/boot/dts/qcom/msm8994.dtsi              |  4 ++--
>  arch/arm64/boot/dts/qcom/msm8996.dtsi              |  4 ++--
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts           |  2 +-
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts       |  2 +-
>  arch/arm64/boot/dts/qcom/sc7180.dtsi               |  2 +-
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               |  2 +-
>  arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts  |  2 +-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi               |  4 ++--
>  arch/arm64/boot/dts/qcom/sm6115.dtsi               | 14 +++++++-------
>  arch/arm64/boot/dts/qcom/sm8150.dtsi               | 10 +++++-----
>  arch/arm64/boot/dts/qcom/sm8250.dtsi               |  6 +++---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi               |  4 ++--
>  15 files changed, 31 insertions(+), 31 deletions(-)

FWIW, everything here looks reasonable to me. Thanks for the cleanup!

Reviewed-by: Douglas Anderson <dianders@chromium.org>

