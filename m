Return-Path: <linux-kernel+bounces-127793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EAA895110
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C894A1F23BA3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A696996E;
	Tue,  2 Apr 2024 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uobyZy9N"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E1C66B57
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055455; cv=none; b=tdcszr564oZkOoVPphQfW+W8x+lwsrYY7Ixl9gI45LwuOaWc8BnefHJlozUdCkwr1V4hSqFJtVqRniQHu9E2OSdjawEoZFwPa/f8R4Sx0ld3Bv4zR5RKqCnlqlEj748fnnQBfaUie5t6WS4vbBYJ0rZZI9GygDDVXSSZkAQN+zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055455; c=relaxed/simple;
	bh=vqO89eEBR/ktnLPEQMdwBobaFGHWU1KaYv7JeHQaYdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pS54Twb6emcprtydlJPMtq/Yl2ysmmDasq7sWz3mD0FOpM8oWMdc33aPYV/WA8gXhuYGNcRcCak2r3oAJPSS9slwxfQ6lDG0EOOH4jOfavEM57hM8/oiu3iM7cuDoLX0yqbyhLUnSoBEraUOOkdYfN4DeP1IWtrwAjEJtrva44o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uobyZy9N; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc742543119so4921513276.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 03:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712055453; x=1712660253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yVXc1Bs+lpB1RIEnPb5YwNz2pgwy6ujAacaSwqfyeHo=;
        b=uobyZy9NKaUBGNXzkFnGopX75NrEOqO0RCxYx4AZ1qb2gkqq+3CraffwwXEEydaQhh
         /GTsKkc6WrT4DcPj2okLoCJ+AWCVEx0NhXhFcuD9hgzGm+WSx8S4WrqnmY6lSq4kuKwH
         xWRtsjPZXvoZrG8b0FD54YwB/lzq06pQrgwM2I+8wyGr4Opu9/DRvfAYmw7S3z+x2Ohc
         +UScUOIPfZvS7sAsjzdcEPtusJQ574hE6sxr+8KgXggJX3uOU+5HM8fhZ6ruuYkiuON7
         cuweW1ZwypaJMR7kGuRyJCy06QsdDEdgcH3yrHxKmmySukiHjtDV8X3Zie9awVYOhz6O
         /ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712055453; x=1712660253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVXc1Bs+lpB1RIEnPb5YwNz2pgwy6ujAacaSwqfyeHo=;
        b=fzps5asyYnF4gE+rF/yUATLEeZ3ohjPrCygLWqOV6+pDttI1V/PVlxCcFRI0yU0i6l
         cO2AwHV+o4QfBsLQp7dcxFB1K8sS+Rt1SEKwkM29OngVJN70T33hU+GhSaLx45zsjkQS
         BLrkVFNug/p/zog6I6UvFSMIgnwrU4isdFiD0zzmR1pjYRdOBySy2Y/n0QLuBLLY3Lmg
         DAbWDm+8IAL4X1aaVvVKdi/N2uNOrH7pbxV1YCwB4lcPUeb+Gq8EZucrw64WhzNJCir9
         448quZgs/Qxcw+RX1TYd3rFPoZ0UhXbpZkhPoGlid3kwPcXg8g6ezoceWH7McnunLsYr
         Xs+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEY7y0FD17ObM5Fh0qvx1T3/Ap2dej8H+MApT1RdXTV9rEd67aZMOVD1XI2fmHbprWobvDrcYoBlCKdsmlo5q4SH0wuVCxsOZzfHb6
X-Gm-Message-State: AOJu0Yyk7NHUVZOpOJMqSY6sZkCJXxdCi/ZYWtMjLtnPsT5aoVHwZ8Q+
	p5wvqXDUMB+leKr5PWnOBYNXr/jr34rkI6kcSrITDGOi0j8nu5Ebj9EZsgR33ZP1nTUrxxSniQj
	bVSSElioBQxc/Wb9N2yJQQwHI0IjMfApnd0jqwecr9iJugHQe
X-Google-Smtp-Source: AGHT+IFg1hu4FwOjpqGBH/SGeVvovCBllWh1O5bBs6IVNCKUcnc1PpAomYGLskhTJ+VShxhyKPmS5NFMVCtcej5YTDQ=
X-Received: by 2002:a0d:c145:0:b0:60c:d22b:8541 with SMTP id
 c66-20020a0dc145000000b0060cd22b8541mr9859110ywd.49.1712055452835; Tue, 02
 Apr 2024 03:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326094215.212930-1-r.czerwinski@pengutronix.de> <20240326094215.212930-2-r.czerwinski@pengutronix.de>
In-Reply-To: <20240326094215.212930-2-r.czerwinski@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Apr 2024 12:56:57 +0200
Message-ID: <CAPDyKFpUkAOd3h_s-zCArPWBhxqGHJ=dS6K6Bv+b6t0norMMeg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: debugfs: add card entry for quirks
To: Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 10:42, Rouven Czerwinski
<r.czerwinski@pengutronix.de> wrote:
>
> This is useful to check if a quirk has been applied for the connected
> mmc card.
>
> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/debugfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 6dbab860e453..f10a4dcf1f95 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -389,6 +389,7 @@ void mmc_add_card_debugfs(struct mmc_card *card)
>         card->debugfs_root = root;
>
>         debugfs_create_x32("state", 0400, root, &card->state);
> +       debugfs_create_x32("quirks", 0400, root, &card->quirks);
>  }
>
>  void mmc_remove_card_debugfs(struct mmc_card *card)
> --
> 2.44.0
>

