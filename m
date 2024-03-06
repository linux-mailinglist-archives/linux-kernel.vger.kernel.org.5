Return-Path: <linux-kernel+bounces-93488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DD8873089
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8B61C20E09
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8482D5D48E;
	Wed,  6 Mar 2024 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZMxQRxZ"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E205CDC2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713205; cv=none; b=a+gBckpMctFm94p29tevECW1ovAE07GCO964OdBbBp+Qbbzme1a+oDQm/KcAh4V+2NaHcmqGYQh13wfgdchWrJc7tJTlf+oZIHnOZJKLGVLdYxnjWakzC4+aH03ZrKxumesooolgzPnj8ne+To15sLzdrtY4tRjR16eJaaBSMnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713205; c=relaxed/simple;
	bh=eOXVyxGTQKrr0a/9S0g0Hrk5vw/Jn0sNrPViExOVtVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHysuRjoH8z2uyw1iu1K16Rxysd0HgsHn6q0hPT6wzVZlk/ycZ+sf2OECb1kK6i7iST2WXcL/7U8Pi9wcPeEBAUzGK3Py03RvaPgx6HdLntFOpgs68O+3dMv5eh8Dm4f6jSYUi9tozA2F7e4Z3ETPJpjFXHYL2WcqIz//Jz3mMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qZMxQRxZ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6093e067220so62276717b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 00:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709713203; x=1710318003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uZBC76fSENwy+KneqSdW8FRSfPWe31aQehHnjGJ1/Zs=;
        b=qZMxQRxZVf5ajm3d9RwRzJ8sZwVHluZ+yFozJFYQdC56hQHzVU7AMsVvtjvMd1Y3IN
         wFXGy6porYIm+B3F6dTvUDElq/L0vcz+sezeYH+d1To01FPxc/EjHuPmxJQwPZFzvZAb
         KPFbHh1+DRs6m2Z2Yo2c+z7aK3sh/ztMu9cUvCBzauRo40scXhn2IM3g1D3U5PmMjSQ0
         SPlSmQ2pAXGGw3u8aHUsmx28n502LUb9sjzmhHj6z0VP/moNZPt84OvGeXtUhAEZk/i7
         NRMCN147gUVlljMpqAE6NaMpJ1mn5oWVBdnLwTtZs/oXBUcSXGoo+zkFp3PNMkKK+ZMt
         kiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709713203; x=1710318003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uZBC76fSENwy+KneqSdW8FRSfPWe31aQehHnjGJ1/Zs=;
        b=hFqH7EX6M1oMvJYYieGPAPEZy9Bzv8qvWm6k5orfzDP3ILFWOh3KO+cYLOvXaNVG9a
         tlHQoSQhfMjIfDC3pc9SYHE0FZJiOKHmKVEd6DJ0jlHzKJzUB7zIOONrlkDsCm7WeKUX
         Cag2Rf02UeBDfJZF1YnpdFOtnKsV+EqKdfRwHLYXQCYRelN7MwgnbEZ/DBOCo4EvtESC
         WzE/o3voSps/IVB8clljcR1Jtx4tqo77va1gDkZ9IGimclida9GalGLA/+p5ejZTGIIO
         NVYHKbnI10OqJXC5fFJDLPn1pB8tEcFd6YS+OGxY7gszpxi1qOTt36UIFC9qUvH1KrJQ
         HfRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNhkJKSRXTyMV0Lj2HnrGgvIvizJcncJn2DW3/p0mzFHhIjNw8JjTRsmyN5XP3OqbM8PgaRZW8XtO6uDaFYHsJwVGXf/+pTfxp445a
X-Gm-Message-State: AOJu0Ywpxp1UTdLlBiEe0hFPUkb0fHCo5ndfrfS9uq4cB2wqGsye/ydU
	d5jpK/4xgWz7ipwOUkbtIdlqEE6mRzSmJCFZ4Z/p/x5MNjnKoB/NDPMIsxVEJgH7tK6CJNPiMaO
	F3XsaTei7Iz4in+LZVMebP8+F2DskKkk28zgt0A==
X-Google-Smtp-Source: AGHT+IHmSEq4j6J3wCtEWvd0nDZ+HJhTa6lo6OjGsJL8RlcpCjZPLN6kBAKWI2pyqgguTpS58xSFj4shg2VyfA6Y9G8=
X-Received: by 2002:a25:9d88:0:b0:dcb:aa26:50fe with SMTP id
 v8-20020a259d88000000b00dcbaa2650femr11041610ybp.15.1709713203375; Wed, 06
 Mar 2024 00:20:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-castor-changes-v1-0-2286eaf85fff@z3ntu.xyz> <20240306-castor-changes-v1-4-2286eaf85fff@z3ntu.xyz>
In-Reply-To: <20240306-castor-changes-v1-4-2286eaf85fff@z3ntu.xyz>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 6 Mar 2024 10:19:52 +0200
Message-ID: <CAA8EJpqBHoGj0Brfiu8GQbxBKfB=v0-x=udMTE8wqVbO-rRjXQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: dts: qcom: msm8974pro-castor: Add
 debounce-interval for keys
To: Luca Weiss <luca@z3ntu.xyz>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 01:26, Luca Weiss <luca@z3ntu.xyz> wrote:
>
> Set the debounce-interval for the GPIO keys.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts | 2 ++
>  1 file changed, 2 insertions(+)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

