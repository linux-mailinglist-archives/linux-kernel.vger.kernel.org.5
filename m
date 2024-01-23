Return-Path: <linux-kernel+bounces-35243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA25838E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E961F250DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57595DF31;
	Tue, 23 Jan 2024 12:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="daSWs3v5"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9895DF11
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012570; cv=none; b=R9KSjIx7uMGOiN3s70FbJ32+7S1wR3poHvC/CDo4FkUQ5ylsJ1jYfxpBiZ4aLXy/Fd1+YjwGICxfya0TUwSoWMfqZvzxZ/I+ueNougMb6nAzKFSGzUaD5aCw9AW9xDyrJbDmFCPojtHbMPKYrGQb+7QvgYmo7wHX7zjLGeIua8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012570; c=relaxed/simple;
	bh=k01DIOSRLVW+DQ24icE6Ir9vmX5ig64RCP8pnc3p7ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JL2ws6m79rFsk41lLz/NcINsPmtmr/MinVcOjuhOPnY8Oay0rJaqVwVzhMDg9zbGRyRpSaMaKgFuoiImwKBd5/LA9LwULWCUdcnxhCLKi384rVdz0yzz0wMQAG03NurCwza2qKNp5TY5fbOdD0ZqGrO98U7FlnI835VoIedgDvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=daSWs3v5; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc24ead4428so2801457276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 04:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706012568; x=1706617368; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2i2JkhvjeVmwGZk7KmpKzIYKY/0vcbt6K1rVecnj+is=;
        b=daSWs3v5GBb3Z796ykMqaJjklxg1kU4UFVj3TpUM78LR2YYzsoZK7WhOJT9lYvfyrw
         gsnQQ+PxWeat1m0NrXbEl1JMcoCQud030KlSPgJ/Sp8VWBPU580chAk0nb3bt9DSAvRj
         SrkcS3aRWhplQ99RBozUBlFUtUXG6FBo3bC4VEwe1BolkujeQEb0xMkwqpF7a+0de6Cn
         W2n0wFPBabGPvhqri2pkLimwQukTkjaH5MamK5V3KOdotP2RRBBwfMPtXlrsjFZ9VTi8
         cLZNlqkqEuVbBTfSrjoatBCNHTS/kEDc5y/s7Ha3R/5XfsARGCvROt1YVsCrMu34i45X
         ai+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706012568; x=1706617368;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2i2JkhvjeVmwGZk7KmpKzIYKY/0vcbt6K1rVecnj+is=;
        b=JV/xQI9sathTxHlYHd4Zm7eQ/MIF79Tr+X5+KMXlTpInFdvB8TP0i6JTsLn8DnILfx
         Nf0Zw6wDraHQ5g3al6SrzsnlCW44Y9ojiMMiXyapn09vLzrF8c5GIkVb8tUDkYlZG3bL
         5+XoX8HWSA6AXtj5Dp+VMINS6x2Ot+1R0kB84kFWPrELRSAZjBS4AmzgnDsWNVAb3Rb8
         DOrDxrRGZM8VQkVIHuKgGUfjLF8TGc0Yxg2GiuYQepT3TY/WHY98f9yZ4xwUgtXGAIL5
         tTslAuvf9IQVBzWTfcGS0c9bvnVTRcqij4bx/25WdpqKqAH+4Z5eYA+k/YyOUOkHBiiC
         oBBA==
X-Gm-Message-State: AOJu0YxcIqwxeyCnH5a6Y4sFyWIi0NzKNaOwgB18FOAiPVVjF18j/QwK
	gjHSKIrQvx+mynsl1mP/UpiQkAsJQ7o2CPHFffzb+D0QcxkQ/FoeZJbp98/uAa4HPB14N0Kf6wy
	tB9H5c4V54tr9fZvx3P2NhQOloZIA019jsAQUU81MSkM4V/baWPs=
X-Google-Smtp-Source: AGHT+IHRYpBdL+ROMhEUsObvUM8ZcI+g0eEAzyEDHj0Yi0tXAbx/m8ujU8Z/pG8HvhWj58H8mBPxPah0p/6uQX6mzx0=
X-Received: by 2002:a5b:d0d:0:b0:dc2:46cd:eeef with SMTP id
 y13-20020a5b0d0d000000b00dc246cdeeefmr3299310ybp.130.1706012568299; Tue, 23
 Jan 2024 04:22:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231225133615.78993-1-eugen.hristev@collabora.com>
In-Reply-To: <20231225133615.78993-1-eugen.hristev@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 23 Jan 2024 13:22:12 +0100
Message-ID: <CAPDyKFoNuKv3BSifiuJrYQ7JSKo6OHaugrWChhKWB3BxKrdKCQ@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: mediatek: fix race conditions with genpd
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Dec 2023 at 14:36, Eugen Hristev <eugen.hristev@collabora.com> wrote:
>
> If the power domains are registered first with genpd and *after that*
> the driver attempts to power them on in the probe sequence, then it is
> possible that a race condition occurs if genpd tries to power them on
> in the same time.
> The same is valid for powering them off before unregistering them
> from genpd.

Right. When the PM domain has been registered with genpd, attempts to
power-on/off the PM domain need to be synchronized with genpd.

> Attempt to fix race conditions by first removing the domains from genpd
> and *after that* powering down domains.
> Also first power up the domains and *after that* register them
> to genpd.

This seems like a reasonable approach to me.

>
> Fixes: 59b644b01cf4 ("soc: mediatek: Add MediaTek SCPSYS power domains")
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>

Applied for fixes and by adding a stable tag, thanks! Although,
please, see some more comments below.

> ---
>
> This comes as another way to fix the problem as described in this thread:
> https://lore.kernel.org/linux-arm-kernel/20231129113120.4907-1-eugen.hristev@collabora.com/
>
> I have not been able to reproduce the problem with either fix anymore
> (so far).
>
> I have a few doubts about this one though, if I really covered the
> way it's supposed to work, and registering the pmdomains in the recursive
> function in the reversed order has any side effect or if it does not
> work correctly.
> Tested on mt8186 where it appears to be fine.

I had a quick look at the code in the driver and a few things caught my eyes.

*) The error path in scpsys_probe() doesn't seem to handle removal of
the link between parent/child-domains (subdomains).
**) An option that might simplify the code and error path too, could
be to convert into using of_genpd_add|remove_subdomain() in favor or
pm_genpd_add|remove_subdomain().

Kind regards
Uffe


>
> Eugen
>
>  drivers/pmdomain/mediatek/mtk-pm-domains.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> index e26dc17d07ad..e274e3315fe7 100644
> --- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
> +++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
> @@ -561,6 +561,11 @@ static int scpsys_add_subdomain(struct scpsys *scpsys, struct device_node *paren
>                         goto err_put_node;
>                 }
>
> +               /* recursive call to add all subdomains */
> +               ret = scpsys_add_subdomain(scpsys, child);
> +               if (ret)
> +                       goto err_put_node;
> +
>                 ret = pm_genpd_add_subdomain(parent_pd, child_pd);
>                 if (ret) {
>                         dev_err(scpsys->dev, "failed to add %s subdomain to parent %s\n",
> @@ -570,11 +575,6 @@ static int scpsys_add_subdomain(struct scpsys *scpsys, struct device_node *paren
>                         dev_dbg(scpsys->dev, "%s add subdomain: %s\n", parent_pd->name,
>                                 child_pd->name);
>                 }
> -
> -               /* recursive call to add all subdomains */
> -               ret = scpsys_add_subdomain(scpsys, child);
> -               if (ret)
> -                       goto err_put_node;
>         }
>
>         return 0;
> @@ -588,9 +588,6 @@ static void scpsys_remove_one_domain(struct scpsys_domain *pd)
>  {
>         int ret;
>
> -       if (scpsys_domain_is_on(pd))
> -               scpsys_power_off(&pd->genpd);
> -
>         /*
>          * We're in the error cleanup already, so we only complain,
>          * but won't emit another error on top of the original one.
> @@ -600,6 +597,8 @@ static void scpsys_remove_one_domain(struct scpsys_domain *pd)
>                 dev_err(pd->scpsys->dev,
>                         "failed to remove domain '%s' : %d - state may be inconsistent\n",
>                         pd->genpd.name, ret);
> +       if (scpsys_domain_is_on(pd))
> +               scpsys_power_off(&pd->genpd);
>
>         clk_bulk_put(pd->num_clks, pd->clks);
>         clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
> --
> 2.34.1
>
>

