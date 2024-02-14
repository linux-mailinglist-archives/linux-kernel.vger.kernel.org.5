Return-Path: <linux-kernel+bounces-65123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF2A854841
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21EE7B266C1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB4C199BE;
	Wed, 14 Feb 2024 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G5+zG4XV"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4173C18E1F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910050; cv=none; b=ODnvNvITYq5b42VqK1CH4LEpYdzUBTsBzFp30m2c5ljnbw++6BTb9PEWThtfW6IP6iaLOYHlP3hwhpV67j74/AdFxSiWgWhEMB0RXtnOXGcV1+pzjR666pb9w0h8OrxYFvhMNOJIicRuRb51pDCSrZRM1CJi0iFHMTfkMFtSl/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910050; c=relaxed/simple;
	bh=jQMkdXCT94+t/fNhRyP4HURQcFoXYNiOsIjLxQJ+Fuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m79ucKJFDfjYQvC2T+PFgEUegmBZfxkzhYu967AabHo4UJhJYXi+ROskXMp2gEhQTPyieE4sBgMW4pP1d65/cQaTarpvqstorhtvKFq7OfchaIc3tifg1NWIeOQd0HDwYIh9t1XGG2+NEnD8Ruiv/7C/z2rtaY9pv1GbFSbDybg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G5+zG4XV; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso754061276.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 03:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707910048; x=1708514848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J7vxhx2/+AlV4ML2Sm5aRUStZ5melg4wfKc+++QxWBI=;
        b=G5+zG4XVJEBMDDm2fylTaBJjdZy3BiQpBfcjPCHzOz8BNHFfx+m6K8rGXYdAnLA9LZ
         Jddp7yhYRRbn+JCmjT/igPP6Nc2oARnEJVtzuLhactfzp0dB3eu+sRklyfr7rQWGsQDA
         WKpgQF1S9Lp40hZEpFkfQkE6wh35yXIuxmH4KK/sCRE7WEzz7eGsUX1qtywQF9dATxIz
         /ZAcecXmlBdNUUXZDslXbt5nYuhFVw4mCq5naTd4JLaNhunruONA0pCl0O/D5HghnwwZ
         hBVKDj3WEXcaxJgFFSSwEXMT36UFccU61rNmfNIy8uOCFS4lFK958+sbEZt40v1JnGz6
         r7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707910048; x=1708514848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J7vxhx2/+AlV4ML2Sm5aRUStZ5melg4wfKc+++QxWBI=;
        b=r/0frKPptRcr5I7IVN6xEGfUJcWnxZBxhzAlSCi5FpM7/BkOdNkKnVjxVKXrfTjuIn
         tFzFxaRBkb2EbuBgiJaUtKJov3xKeSEF+MiPQTMktiCND77DCdDhVSYRPr2wY3U5v2I7
         YXpSdAB/E7zak0Z1+Yomg5Z86I1W3wTiEj9rbmFVSx2clQbNE+rx4iMz84ukbkWoch+K
         5/dGy0miV+xroDFzsPmp5VxeNutRL8BNnZ1aTXlmYbKe3Eds9/3IxRF4D0Whl+9JQNPW
         hYtzQUwnP2TFXlUJOE6Nub7WWhW8b65ZpbEHzAcMZdnjwHhT0X7ESQbpN1/LX9ScLvOw
         sVYA==
X-Forwarded-Encrypted: i=1; AJvYcCXG50MxZsRtf4sy1l5FDDAbrw4/tiUB2PIPLDia7C7iaOBIypWv4mFs1enbcm3AMLIumcbcImlHV0RIwzFNJpAFykLOX1dsCloY5AuL
X-Gm-Message-State: AOJu0YzLHMmnprmbxdgTMVU+jasNDoI2WmHm4xoTC1W2lQf3n90AqpUW
	ajznDua9QV5999+Ifnq60+LbbMdkQIhHlFv+QKfvILidx9Jb70Tns+lBF8HwdRKdQGdj2qXMsLW
	nz3ksR+jtrCqz608S41GBk2uGAmdj1LTNJ9BtLQ==
X-Google-Smtp-Source: AGHT+IF7fNd2JRX3NvA9PbJWU4NXe1WgXGNXA7AONOSIwQ87Oj0NPA7NictZA/Fg6/5TNlFFNJsMMeASLn3d65XcKQ4=
X-Received: by 2002:a5b:1cb:0:b0:dc2:547f:27a2 with SMTP id
 f11-20020a5b01cb000000b00dc2547f27a2mr1919705ybp.50.1707910048182; Wed, 14
 Feb 2024 03:27:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240213051332epcas1p1f45d02dc34d1b95ea5608ab779d6b6cc@epcas1p1.samsung.com>
 <20240213051716.6596-1-sh043.lee@samsung.com>
In-Reply-To: <20240213051716.6596-1-sh043.lee@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 14 Feb 2024 12:26:51 +0100
Message-ID: <CAPDyKFrjZ4jRHAfXsvrEvezuHTxbA3SAniF8CuObyLuW=AUoeA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sd: Add a variable to check a faulty device
To: Seunghui Lee <sh043.lee@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org, avri.altman@wdc.com, grant.jung@samsung.com, 
	jt77.jang@samsung.com, dh0421.hwang@samsung.com, junwoo80.lee@samsung.com, 
	jangsub.yi@samsung.com, cw9316.lee@samsung.com, sh8267.baek@samsung.com, 
	wkon.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Feb 2024 at 06:13, Seunghui Lee <sh043.lee@samsung.com> wrote:
>
> In mobile devices, suspend/resume situations are frequent.
> In the case of a defective SD card in which initialization fails,
> unnecessary initialization time is consumed for each resume.
> A field is needed to check that SD card initialization has failed
> on the host. It could be used to remove unnecessary initialization.

It's not clear to me, under what circumstance you want to optimize for.

Is the SD card ever getting properly initialized during boot?

Kind regards
Uffe

>
> Signed-off-by: Seunghui Lee <sh043.lee@samsung.com>
> ---
>  drivers/mmc/core/sd.c        | 12 +++++++++++-
>  drivers/mmc/core/slot-gpio.c |  1 +
>  include/linux/mmc/host.h     |  1 +
>  3 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index c3e554344c99..f0eb3864dc24 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1410,6 +1410,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>         bool v18_fixup_failed = false;
>
>         WARN_ON(!host->claimed);
> +       host->init_failed = false;
>  retry:
>         err = mmc_sd_get_cid(host, ocr, cid, &rocr);
>         if (err)
> @@ -1752,6 +1753,8 @@ static int _mmc_sd_resume(struct mmc_host *host)
>
>         mmc_power_up(host, host->card->ocr);
>         err = mmc_sd_init_card(host, host->card->ocr, host->card);
> +       if (err)
> +               host->init_failed = true;
>         mmc_card_clr_suspended(host->card);
>
>  out:
> @@ -1803,8 +1806,12 @@ static int mmc_sd_runtime_resume(struct mmc_host *host)
>
>  static int mmc_sd_hw_reset(struct mmc_host *host)
>  {
> +       int err;
>         mmc_power_cycle(host, host->card->ocr);
> -       return mmc_sd_init_card(host, host->card->ocr, host->card);
> +       err = mmc_sd_init_card(host, host->card->ocr, host->card);
> +       if (err)
> +               host->init_failed = true;
> +       return err;
>  }
>
>  static const struct mmc_bus_ops mmc_sd_ops = {
> @@ -1891,5 +1898,8 @@ int mmc_attach_sd(struct mmc_host *host)
>         pr_err("%s: error %d whilst initialising SD card\n",
>                 mmc_hostname(host), err);
>
> +       if (err)
> +               host->init_failed = true;
> +
>         return err;
>  }
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index 2a2d949a9344..93d081c7dd53 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -33,6 +33,7 @@ static irqreturn_t mmc_gpio_cd_irqt(int irq, void *dev_id)
>         struct mmc_gpio *ctx = host->slot.handler_priv;
>
>         host->trigger_card_event = true;
> +       host->init_failed = false;
>         mmc_detect_change(host, msecs_to_jiffies(ctx->cd_debounce_delay_ms));
>
>         return IRQ_HANDLED;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 2f445c651742..1d75cfdbf981 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -467,6 +467,7 @@ struct mmc_host {
>         struct timer_list       retune_timer;   /* for periodic re-tuning */
>
>         bool                    trigger_card_event; /* card_event necessary */
> +       bool                    init_failed;    /* check if failed to initialize */
>
>         struct mmc_card         *card;          /* device attached to this host */
>
> --
> 2.29.0
>

