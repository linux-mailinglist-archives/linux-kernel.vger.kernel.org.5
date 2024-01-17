Return-Path: <linux-kernel+bounces-29314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EACD830CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF90BB22E45
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6321F22F0E;
	Wed, 17 Jan 2024 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGTWGj3C"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC4D22EE1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705515855; cv=none; b=EobWrDQSzfLEnPLD0a0lkgB9pvEhl4kCXCLJqsUow4sDIyBi5uBYY3MQ5tyGoAeOmZuivVx8TKC8+GFAllAZr7W4B01sYqb0idCCXaQKGxZ9CgncyNxAq7llQWNZSyehtxHZ8ZzwuPHBm2mgcxlhxnse/NJ8ptCpIALWNMxOyE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705515855; c=relaxed/simple;
	bh=NFXD5kQKTGpTDVg2zunNmAEEapzyoqNHUtXRSN2eqjQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=ThMKcLqxw1mGBsExOoIN7v/kHJHhyT9W4sG2uTzj9/in0sNgscFSwjZy7++0z85QAImxY4y2fFmu/vXAj6zWaGFAJHOeGPddLRSba6DNTFkJPsfGnV6nldK2u56oxzjkBPYL6dlD5yFYuxO0Mw4t3LQBEizyYoJCNJqQcwkHbe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGTWGj3C; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33761776af9so2022084f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705515852; x=1706120652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KNRogNawE98vzU6hLj1KXDSyquhagx1/Y27JreKsQM=;
        b=lGTWGj3C02mWksDEhvegvWIsDb0MhaTwVioAwsOsCUheIQcg+z31ozUzmOuEo4CaFC
         iBeQm5gzinUUx7DiQa/3K2EyLzqJcMdjyYD+J242bOTAszTd/4KYYfn7XWQXEJT695Bp
         t1CLNQpGXaptgalKMkUlqW7qqosxPaM/G8ja7chHNN9913XtBZTBLAY+wtTZMG+389V5
         jcqb9zZe87yKXYzyRNYDDihbFwOjxpdIkBNLygEjh1vnRYBSFQ5ccP03bjFfmVawrZAa
         RSLYIVPJ49OxcwAno77GkARDGVhIq8hUmRWBV4blDUrFDV6nsMzxeulw/0pUMaufb2Iv
         klxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705515852; x=1706120652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KNRogNawE98vzU6hLj1KXDSyquhagx1/Y27JreKsQM=;
        b=HSlNhEtG/8uN4HtJ9/94+ZmDqd7YFbanxQprf3LFYaQXjuDXdWcNealit/hW/lg6xb
         nQXLpV3Zgz5Rfn8mEqDWRPsAK2NblZPxswARXJSqCvI/0aBvEfHkZWQmiOrfkTvclVFE
         eNIJjDUx0D3eoA1QCMYd7Ks9qD9OMsVPBd8SWtWPQP9LuCjh3kwLY/f3/YZY4yGgPoF2
         0w4q9Q5/Vhq0VlOkGy4lAzOZIt5YLVZazw2C00k23zkepnNwdTBTJ6u23H2sFyrlewmu
         NF3ljTQxE5VRi7P0agrJSVjOzk3SxfafN4aLH2kGbaC6e3x4rzg+IKgygDsl5UJ8CdIF
         DkCQ==
X-Gm-Message-State: AOJu0YxXOK+EhJubcX2QBCdCPRLHrJ5fmRA6/BbCleltoDlfgaQhTjMB
	hAUOccIN/lrzN1U3sEeK2xFJW6UOZLg1jUkZsxYpY31v
X-Google-Smtp-Source: AGHT+IHMrOchJ+5dcyqg95SjFNj5eWwJ0BRr8CfuLDBHpYipUaBdrJQEVAGODtTLanoMQLOnw2q9YwVW9qInm8lBML8=
X-Received: by 2002:a5d:4111:0:b0:337:c4c8:92d with SMTP id
 l17-20020a5d4111000000b00337c4c8092dmr1411467wrp.0.1705515852542; Wed, 17 Jan
 2024 10:24:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117031212.1104034-1-nunes.erico@gmail.com> <20240117031212.1104034-4-nunes.erico@gmail.com>
In-Reply-To: <20240117031212.1104034-4-nunes.erico@gmail.com>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Wed, 17 Jan 2024 10:23:45 -0800
Message-ID: <CA+E=qVfjKvW=R6NaF7eEKkHk91HLGnohQjM8h-3Kh=fv61WgJA@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] drm/lima: set bus_stop bit before hard reset
To: Erico Nunes <nunes.erico@gmail.com>
Cc: Qiang Yu <yuq825@gmail.com>, dri-devel@lists.freedesktop.org, 
	lima@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sumit Semwal <sumit.semwal@linaro.org>, christian.koenig@amd.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 7:12=E2=80=AFPM Erico Nunes <nunes.erico@gmail.com>=
 wrote:
>
> This is required for reliable hard resets. Otherwise, doing a hard reset
> while a task is still running (such as a task which is being stopped by
> the drm_sched timeout handler) may result in random mmu write timeouts
> or lockups which cause the entire gpu to hang.

It looks like Mali driver is doing the same, so it totally makes sense.

> Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>

> ---
>  drivers/gpu/drm/lima/lima_pp.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/lima/lima_pp.c b/drivers/gpu/drm/lima/lima_p=
p.c
> index a8f8f63b8295..ac097dd75072 100644
> --- a/drivers/gpu/drm/lima/lima_pp.c
> +++ b/drivers/gpu/drm/lima/lima_pp.c
> @@ -168,6 +168,11 @@ static void lima_pp_write_frame(struct lima_ip *ip, =
u32 *frame, u32 *wb)
>         }
>  }
>
> +static int lima_pp_bus_stop_poll(struct lima_ip *ip)
> +{
> +       return !!(pp_read(LIMA_PP_STATUS) & LIMA_PP_STATUS_BUS_STOPPED);
> +}
> +
>  static int lima_pp_hard_reset_poll(struct lima_ip *ip)
>  {
>         pp_write(LIMA_PP_PERF_CNT_0_LIMIT, 0xC01A0000);
> @@ -181,6 +186,14 @@ static int lima_pp_hard_reset(struct lima_ip *ip)
>
>         pp_write(LIMA_PP_PERF_CNT_0_LIMIT, 0xC0FFE000);
>         pp_write(LIMA_PP_INT_MASK, 0);
> +
> +       pp_write(LIMA_PP_CTRL, LIMA_PP_CTRL_STOP_BUS);
> +       ret =3D lima_poll_timeout(ip, lima_pp_bus_stop_poll, 10, 100);
> +       if (ret) {
> +               dev_err(dev->dev, "pp %s bus stop timeout\n", lima_ip_nam=
e(ip));
> +               return ret;
> +       }
> +
>         pp_write(LIMA_PP_CTRL, LIMA_PP_CTRL_FORCE_RESET);
>         ret =3D lima_poll_timeout(ip, lima_pp_hard_reset_poll, 10, 100);
>         if (ret) {
> --
> 2.43.0
>

