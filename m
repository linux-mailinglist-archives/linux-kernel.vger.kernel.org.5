Return-Path: <linux-kernel+bounces-85284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7555886B375
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30518284159
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B655A15D5D0;
	Wed, 28 Feb 2024 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lMP16Zwf"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7700515B109
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134875; cv=none; b=FJaQ6uE/aaVb9GdvnZZyOxt8FHL1hcEeuDRj+5ENwe7YdaDUEwwmfEOw3MtTqjU0CW2q8wcikPYGJKX9WPB1hnxxiiOHYlv8LSzFtkXF4z6gSwkMEi07utfEqIBkjd2JgQofn0ZSnj3DVwkpJ4wcZfKiC47qDGM8mG2a7LtPzgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134875; c=relaxed/simple;
	bh=QHQxcBODUYiQb1yYM36IqEt4dgIYDC9UqJta385YNF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3Lxo3Tkb/s+89PPnwCFRintQRoP20t0tZggvtNnKa4E7xQF5YkdjuIa5x6JtAXc4NBzNgV+Set6hux+fX9Em8SFyczH87q/ECFqtNBndCF4mRdhHIQZVh6c/7/d4NZBcxWhm81Sdod9RsVA3vhPdCfRwDd5Ybofhad+u+kIsuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lMP16Zwf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so7890197a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709134872; x=1709739672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2tRApMKF3yJM+F82njXYmgcbTLvVNudocV6GcXTSm5g=;
        b=lMP16ZwfkwxT8itu7zCia8qjCyHhISvyKHBg9WrhqJmhgSFGCgE5eivwNA9R1vyV07
         ls0pgeMgSWkgXHFx1Cri+FdVFG9FYGruhs3JhUqHMVNmp8D4QvBgIGsFbksU8y4qW9+z
         zTBLSbdyzuh7Kfjluf4VS2eAc/hh44W8M5LGCN1iy3MbuW1tfCbIcFB8/FJdQ9QafNrY
         SYE7gTUcRBjM3qaJo+ICdsfPRU6rSqwSY/T0mtPJZlm2qnNktDGDGakEJXC0tXnI6Kzp
         qWhYNviSP2+wtn6i03sgY6c+/8B+5fm8hZwLoK1hBO8NauQrvm4mfIxEEqbGyWDi30Mq
         4KkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709134872; x=1709739672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tRApMKF3yJM+F82njXYmgcbTLvVNudocV6GcXTSm5g=;
        b=nmc/Jl7bHAURUJ8DR7G7tVb++w4aVJ/1aA7PzqHkP0vO7zT0oAMoe0I7lB+OLpkn0q
         VpnCfRaCoGwuk3gMjB8KtMUnzZxRlVRwR8tWDkREJ5IhJTiajM3OvO3nMzE7DbOCGhCo
         el6vJ5ktqXO+zLgsPM0BXHMKOE45DR+qPhYZnkLLkcFVwVWeb/XbI2OvBtNYlInkfmBC
         6Se6YyMB07ED0xLML46WFaiAM+PWwhmz/thLwAuLyXgnaNajOYz4o1JpCogla7PmOD1B
         +R/zccIVFuqvaPUpLjJEOZN9smT9B5MmXGRHjhQq9mBL97u1WbeWmrKIC2X6zSPGU7tx
         r+Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVBGN03KXsArg1jtz06/u7PI9KMAxTAASCMPu6x7149l+iCFSRvyrZtieeESiAFV8yX7zoL7Etm8uuAdAArKthoOqIUHrc81G+U2dPv
X-Gm-Message-State: AOJu0YxBt1fvokPdd4Sjn8DvIPNAFALQOPXc9HqKy5kPcdC4hhCMv0Tw
	F5pJHTpn5+xUBWOmDBIM4A4zDWYgK9WiWS0C8aBWDU928QwsRevgKzq14qqOTwFA/6W99mkzPu8
	BSu+pJS/XbMgJP9XkUEdASNE3e/QZ5WBN1P2bFQ==
X-Google-Smtp-Source: AGHT+IG365oga5w7zDBtHPazj2hxzm3EgUC8YA/EU30cur5ZUa1DEDy6fvESfJjz4iWUOKjXuivekncmBzXJyaua22s=
X-Received: by 2002:a05:6402:3456:b0:564:3b2e:2a2e with SMTP id
 l22-20020a056402345600b005643b2e2a2emr8870854edc.9.1709134871902; Wed, 28 Feb
 2024 07:41:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217-init_level-v1-0-bde9e11f8317@quicinc.com> <20240217-init_level-v1-1-bde9e11f8317@quicinc.com>
In-Reply-To: <20240217-init_level-v1-1-bde9e11f8317@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Feb 2024 16:40:35 +0100
Message-ID: <CAPDyKFogCeyMKU4iPeAHcx1J6nWrO-43yb9_2xYmXm202V-p3g@mail.gmail.com>
Subject: Re: [PATCH 1/2] soc: qcom: Update init level to core_initcall() for
 cmd-db and rpmh-rsc
To: Maulik Shah <quic_mkshah@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	quic_lsrao@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 14:57, Maulik Shah <quic_mkshah@quicinc.com> wrote:
>
> cmd-db and rpmh-rsc are used by clients like regulators, interconnects and
> clocks for resource voting. These clients are in core_initcall() while
> cmd-db and rpmh-rsc are in arch_initcall(). Update init level for these
> drivers also to core_initcall() to avoid unnecessary probe defer during
> boot up.
>
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/soc/qcom/cmd-db.c   | 2 +-
>  drivers/soc/qcom/rpmh-rsc.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index a5fd68411bed..c344107bc36c 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -362,7 +362,7 @@ static int __init cmd_db_device_init(void)
>  {
>         return platform_driver_register(&cmd_db_dev_driver);
>  }
> -arch_initcall(cmd_db_device_init);
> +core_initcall(cmd_db_device_init);
>
>  MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Command DB Driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index a021dc71807b..c4c7aad957e6 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -1154,7 +1154,7 @@ static int __init rpmh_driver_init(void)
>  {
>         return platform_driver_register(&rpmh_driver);
>  }
> -arch_initcall(rpmh_driver_init);
> +core_initcall(rpmh_driver_init);
>
>  MODULE_DESCRIPTION("Qualcomm Technologies, Inc. RPMh Driver");
>  MODULE_LICENSE("GPL v2");
>
> --
> 2.22.0
>

