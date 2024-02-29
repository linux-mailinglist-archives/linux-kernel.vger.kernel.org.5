Return-Path: <linux-kernel+bounces-86010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DCC86BE70
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B2A284E30
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57BE36113;
	Thu, 29 Feb 2024 01:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jq8MHo2b"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6346913D311
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171175; cv=none; b=QZAjqAsJZEc3Eg8AXabBppFR8f69CLYU09Ocem6DtIQ2ZHYldtuy+YMX3MFPS3WlaWgjjVdYIfNqACc4AbEDOKJqZxP+EqJxKvF1yRDP5Unvc/Ykq6NTpwuV2bPrCe5xzQeIzEQ+Ku09OZLQdnR5zATylIyXwOAUD4vl+BoR1C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171175; c=relaxed/simple;
	bh=OWe4oUBOmApqxp6RuSwzBaqEjECsstdX9gvjE7NjtL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDDJ1iOFpKdawJM7qNbTEAwKAjVfIudcJ9Mbe9anA/SfxyfwNv7cnZBIMoLucAzlveAikhgX54TOdEB0nTzzYVuR5yKE8YtcX+tH6hEgkcTALkba8lUZof3RkdqB+oBLqbd6cqvd5uMGXHd5Ue9VaOJaorNSz9b9Qw62fEqONLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Jq8MHo2b; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d208be133bso4397601fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709171170; x=1709775970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4l+dEcSZUPzIQHrYPeg5QRKPOIlq4y/RNg3JOxmjZQ=;
        b=Jq8MHo2bF5AJswsSKYzCbY+qPx0+zajkQBpaZBx2SfGPavR7CVCgmfOgJqRANNoAQ7
         bDaIRf2GzsvW2YwBirbrZ//GC47rC0o2hXsyZZlG18PUdNN1upT0FaavqGhpVErZpCnk
         yYFL9Q/7JMF+xNOVsftiSkw8ku7791ifQPYBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709171170; x=1709775970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4l+dEcSZUPzIQHrYPeg5QRKPOIlq4y/RNg3JOxmjZQ=;
        b=tfvzKzsa9SBGzFt9QT02iXuKDRMPU7/jj6LiVKotMWRC0gZozO6RxLvYrPzCdfHTrD
         Ns7hr9Y2OiHzzHDzBRrvzlxQyDPM4HijEeyknFgRG6tMWBIqjTQqU8uB2UngFkWH9weN
         Fpqd6p9JcoytpyDUIs8K9jfzMnmbJNGFPVOqlx3yPgqI1or+K6k3aMnEOni2ZDZET8DQ
         zC1V9GMJE9tSMRpaqwGhipsh35Ps8PbJurT+b2QDIR6ByHIGijmBttSzyZ5y1fG+WxEG
         NsaHg87A6Khji0aTqey2S62mzZH44kefLdYpLygA8U9/4E5NHQjRHskzPPbR34iBL134
         Dp3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIwmsFukVqXTDneCURhHn7Os3m/hXgDfUDgcx+6oMdPN67xDMPVuKzptD6irV7jmw73ZAqH7epG/4xaXkA801hIpFWvmizBy30EdDs
X-Gm-Message-State: AOJu0YwJ1jkSi3FZ4MnUgtuEaaI6TKBkvpep91UwykDJQIc2gSpDaorX
	CZSBOT3EJsNkCH97x3CD82ahVnJJ9PL5WejjfduW1NX6HGGVJ70ct8apZ5dk8wuzuIOlblzG4VB
	O0lR5
X-Google-Smtp-Source: AGHT+IEmQrVgcZM0Hou0oyJtbv0oahGEIetDryKR5PYboDBEAQVc4NOaUr4qOGs8h0qEDeQK/IJ7mw==
X-Received: by 2002:a05:6512:10cb:b0:513:255b:a9d2 with SMTP id k11-20020a05651210cb00b00513255ba9d2mr256146lfg.67.1709171170480;
        Wed, 28 Feb 2024 17:46:10 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id h4-20020a1709063b4400b00a433f470cf1sm128478ejf.138.2024.02.28.17.46.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 17:46:10 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4129a5f7b54so19615e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:46:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUs7w3aTbtmaSh5yLSmB92TmEN1LoD2oDnm+fxuCB9d3CUZcpyjkgexG0JI0ShBU0o5xqh4kMw7TkoF9yxHWtSw+3x2KIusfYPF8/R
X-Received: by 2002:a05:600c:1d98:b0:412:bb83:bc7c with SMTP id
 p24-20020a05600c1d9800b00412bb83bc7cmr14062wms.7.1709171169334; Wed, 28 Feb
 2024 17:46:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229012828.438020-1-swboyd@chromium.org>
In-Reply-To: <20240229012828.438020-1-swboyd@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 28 Feb 2024 17:45:53 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wy9pPqFGhU3MGoNXFVrCpyy8Yk=FTNa2MV-DTVLWQdUQ@mail.gmail.com>
Message-ID: <CAD=FV=Wy9pPqFGhU3MGoNXFVrCpyy8Yk=FTNa2MV-DTVLWQdUQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Disable pmic pinctrl node on Trogdor
To: Stephen Boyd <swboyd@chromium.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, cros-qcom-dts-watchers@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 28, 2024 at 5:28=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> =
wrote:
>
> We don't use this pmic pinctrl node on any Trogdor devices. The
> AP_SUSPEND pin is here, but this pinctrl device isn't a supplier to
> anything in the devicetrees that include this file. Disable this device
> node in the DTS so that we don't waste time or memory on this device.
>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

