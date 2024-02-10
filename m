Return-Path: <linux-kernel+bounces-60388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01236850450
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E92286C15
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE3F3D55E;
	Sat, 10 Feb 2024 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g65cUGgn"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E373D54D
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707566009; cv=none; b=dgwUi5k0N0ZspwmaWtmOe4/MgUPgri9Z5mNty+Yoiz5+SLcBHLyxMu9VuEt3yEILbMmK/zc3dcNnEK6sN3ahZLlz6uSl9LJSM2UiST57dSoTDsOX9S12jHBP9aU4WeTCNTG2nkEmSAoUWWgvZ7IH7GZc0TNHySbuzb2WLgiisFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707566009; c=relaxed/simple;
	bh=9bQZqD23DARa5dmQXwWYHcnI+MX2yoHshObqALvEMWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdTIAHEUYWS56XT/eVIWNjUTz+WIqsRRallNHz/hD3JTQqZ+9v4Q94mHAo5rKyTHpUJXEtY9t564Yn2OeKs97AjLoaoMvmcYoha11jh3oCHeZVdZHmbM/NMzW+LbBkcWCxl14N2LLLy7Mc8UeIuTuS+miL77SCd1vCF0EnhblJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g65cUGgn; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6e08fde11so1921603276.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 03:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707566007; x=1708170807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XWXgSyVP+N1LKifAWR9rUMalj+Xn0R6HoByIzflb0PQ=;
        b=g65cUGgnt8WSSlUdeP2L/iLZFyWEir3GrpronbNIwF2WoY/SLTOpxO0Rd+bMgxSzrs
         o7JD+hYTFmmbKaWA3icuqL8Ge4/e7n8IEw4ixeZZJutGxDeuWP4juQAQvHcRkZkAK8WM
         cnFhJFcwSUgxj7S6hrRFZq0JfMEYCC8wasIY1ay+1DQmSLL3Z/4k5vRsrvK0s0C9Pf3J
         guX6XcSx+dXj/b0F+kAN+FsYs4L44Hz3NUWHS3Q50LJXitq3s4SqlsfmHj1PsnamsoCT
         e/d3m8Hs6Kp5unzNtCArX8Z7yTbwR8p8TLkCabenR/ZnafW9SZXRuugUwCwXHAL+/aRw
         P0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707566007; x=1708170807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWXgSyVP+N1LKifAWR9rUMalj+Xn0R6HoByIzflb0PQ=;
        b=SwStbcJbpFitwhQb0K+spoxmLUQt0x/yRIsJHk5Idw74maK9xjs92kAKQlBrUmAru7
         jHrps7M5OhG6aGDAdeOff6OQ+nIDh39zj1sXXrYZnd/CdjeH1dJsqSW6rqcYRBbi+mOT
         sijW/ltnnQC88cvEm+BprAJYqA9sYmB64SEBfFF4T0dVThX8Qe4CGGvcfXGPny7t/AMs
         p5HoL40dDYQeCH/lJ8jGU7DDqND7NsciSP8RLqMFMMe169Fvk7DaSSwqvzqN5ovttYRz
         Z9c0tV09GY0UkWOHxzY0e1k/QLmHu7mu8wikZrQDAD+5f2OpJSEh17y3xdByPLXwX45b
         EmxA==
X-Gm-Message-State: AOJu0Yz54amLdL3MZvWe7/SXw8xXSAlfCYS3A4JmyMPpyLY1j+XiIKB/
	hkwH1phsBhc2TLccrgv7/mY0ubbPnakg2sZak5WVKGNUYBr+w4nCKc9rGKq/TeOaQsDziosNNhK
	bPH331CFo0LDBlO7ceWw8Wy3FAs/1irPKGXggAq8TtS5x3mjXluc=
X-Google-Smtp-Source: AGHT+IFMW08q299IizgKGdLgUOVbSLepSnMhrSOl8xiICHLdby/JMn0zC+h9YOLRZctZ72Bz13hmpDHWTJ95DQfia/Y=
X-Received: by 2002:a25:8686:0:b0:dc7:47b7:6d69 with SMTP id
 z6-20020a258686000000b00dc747b76d69mr1199763ybk.60.1707566006887; Sat, 10 Feb
 2024 03:53:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210070934.2549994-1-swboyd@chromium.org> <20240210070934.2549994-22-swboyd@chromium.org>
In-Reply-To: <20240210070934.2549994-22-swboyd@chromium.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 10 Feb 2024 13:53:16 +0200
Message-ID: <CAA8EJprROcMa5U0Q8fMk_aJpk6ecMoDKhtD31CCss-bHu2S+7Q@mail.gmail.com>
Subject: Re: [PATCH 21/22] arm64: dts: qcom: sc7180-trogdor: Make
 clamshell/detachable fragments
To: Stephen Boyd <swboyd@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Pin-yen Lin <treapking@chromium.org>, 
	cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Feb 2024 at 09:17, Stephen Boyd <swboyd@chromium.org> wrote:
>
> At a high-level, detachable Trogdors (sometimes known as Strongbads)
> don't have a cros_ec keyboard, while all clamshell Trogdors (only known
> as Trogdors) always have a cros_ec keyboard. Looking closer though, all
> clamshells have a USB type-A connector and a hardwired USB camera. And
> all detachables replace the USB camera with a MIPI based one and swap
> the USB type-a connector for the detachable keyboard pogo pins.
>
> Split the detachable and clamshell bits into different files so we can
> describe these differences in one place instead of in each board that
> includes sc7180-trogdor.dtsi. For now this is just the keyboard part,
> but eventually this will include the type-a port and the pogo pins.
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
>  .../boot/dts/qcom/sc7180-trogdor-clamshell.dtsi      |  9 +++++++++
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  5 +----
>  .../boot/dts/qcom/sc7180-trogdor-detachable.dtsi     | 12 ++++++++++++
>  .../arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi |  7 +------
>  .../boot/dts/qcom/sc7180-trogdor-kingoftown.dts      |  2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  3 +--
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi |  2 +-
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  2 +-
>  .../boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi  |  7 +------
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts       |  2 +-
>  .../boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi    |  5 +----
>  11 files changed, 30 insertions(+), 26 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-clamshell.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-detachable.dtsi
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

