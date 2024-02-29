Return-Path: <linux-kernel+bounces-86782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9163C86CAAF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1C0284BDB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B32128820;
	Thu, 29 Feb 2024 13:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDp2MwoJ"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB82D37B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709214690; cv=none; b=Uq/DzKbjHq2QTPt7UCr+gk8OZ4b5CX3C1mcgg7O4TqpGRBTTkRVv7v22wM8RDCdo6leG0ev7/mxiYinedDcxzoOKg4Jur5CJPxsn6kIgHJgQUlU/ykH4RWwPCjh2XiTTOrlyIFV5TtyUedBIGAFW897axxWy9SFqWaAAhFDb6Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709214690; c=relaxed/simple;
	bh=VCRBABw8KmpUgXtF2gQ1npSuYjYA4fTRgP0v3OZT+Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYiO9AIq4DDCka4kB+UgzDunpkLtd9n/GGmRmHAueEE9Atm1BtZYpRfKYhdC//nncwAU4SNm+8HuCvaSyYH/BUd0nXWALEUbXWXmr+qApJ/Z1G+UmsQnLvvW2A/36lQWsTDmCJhVKPS7MC+rMuYU3yAlUkxEjD45EaMGNqTB7xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TDp2MwoJ; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso898633276.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709214688; x=1709819488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCRBABw8KmpUgXtF2gQ1npSuYjYA4fTRgP0v3OZT+Ww=;
        b=TDp2MwoJHcrL5r2PXEBLbl1l7kl7hSo9m+xuwP6VjZ4CAQNRTFbLKzp2LgD29iIhi3
         uEbnwJyIQqckWk19KpmJTa9rVRKwWPCHFml9/+vzugU5da4oFgIyQp0/Vn95oxqJdlsQ
         ZX2HH/lMabvAGX3/Tp0trhyGkKUHO/Iwd0hF1iWaDQas0SQEAdf9NBVEVAcdw5TfEbkp
         4I2gkvdUidu46MLYCt4dqNWp3zKmAmEsbS+MyB0UnNRehGMF7UV+k1Tt4mUBuWCNTDDV
         wIv7kZeeewxTM79Kp7ez/2l3iZ7gzHVjsifNVfEo1YCgdcZpqEzJV2jtM3Isa8u0rRC/
         F85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709214688; x=1709819488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCRBABw8KmpUgXtF2gQ1npSuYjYA4fTRgP0v3OZT+Ww=;
        b=bSfuxUhCp9AoqoCjTyObgevM+OtJMocGcoqaMxXPa1FxGRy136TkG5WgY5K4mbV4tA
         oRYqjmDuP2Z3iBG+QeJVrqAfju6EZ2g1iNTi4zLrFyJl5084wzJJZ+Sj4rlgUZkxjkTD
         NhnYsVBWJpayrbrQgqZMDEmik2nHaEiZaAGEKS3Klzz35I5CnOjFMQSHUH27NKKARYJT
         IROddtlWBur1nZeeRCA1YnKyoSdLz0ODre8uY7ybm+a+xOvN5830II9PJH0Bq0Xs317x
         3aeXuB4/zunKtHIKT7ZvO0tgm46JCd/YwAjUxV+UPZ14YuP15poppVYMQe87B0J/Ez+9
         YCJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6sFsjhbWHBXXyH3gR2FOL8j1bJ4/ziHvCvqWPu2ETpP2LX1qMv8QAwSo45PpjxT9yCjJWOMB+qsPpNDoPhVQNih3L3P5e2S6VtAyI
X-Gm-Message-State: AOJu0Yxs4wilGlSg99O7MF44/q0V2IzwjBMT1e63jGQVwEB3j/Wwf60b
	XG3YYsFW6+d07WbWFLesX8fBXWeffqg6eeuy37RpxjsIxrOhuQi2Zqf4VApvtgw1ruBRrDQ1dyJ
	Q8PU4P9VbErDEhnb2MCWDbkjC5Gc/JiZKcAm4zA==
X-Google-Smtp-Source: AGHT+IEYhNAeRh9ONe2PLD/A8u7wUHFfcrYiceM9fcEYENn8XLe8Y1+j4qublU+HUjK2deQ2vLtn2qxDO9n4pQzAFnM=
X-Received: by 2002:a25:9d84:0:b0:dcc:8c7d:970d with SMTP id
 v4-20020a259d84000000b00dcc8c7d970dmr2327901ybp.47.1709214687813; Thu, 29 Feb
 2024 05:51:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223071557.2681316-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240223071557.2681316-1-peng.fan@oss.nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 14:51:16 +0100
Message-ID: <CACRpkdYX1CtmOkDhyfCAcbY2yHHfjjRhTg0r=sW3iA6dvxvmdw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: scmi: support i.MX OEM pin configuration type
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Sascha Hauer <kernel@pengutronix.de>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, aisheng.dong@nxp.com, nitin.garg_3@nxp.com, 
	ranjani.vaidyanathan@nxp.com, ye.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 8:07=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> i.MX95 System Manager FW supports SCMI PINCTRL protocol, but uses
> OEM Pin Configuration type, so extend the driver to support custom
> params.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

I can't really say much about this as pinctrl maintainer other than that
it makes me a bit unhappy that i.MX95 is not using the "default"
SCMI pinctrl bindings.

If the spec allows for this, and NXP Freescale is using it, I will just
have to accept it.

It feels like that's the old NXP Freescale pin controller living on
just hidden behind SCMI, so potentially it should also share code
with the old i.MX pin controller driver. But I think you wrote part of
that driver so you would be the best to ask about that in any case
I think?

Yours,
Linus Walleij

