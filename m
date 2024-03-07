Return-Path: <linux-kernel+bounces-95370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3501874CD0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161031C227D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54406126F3C;
	Thu,  7 Mar 2024 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="potKs36F"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70A163411
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809075; cv=none; b=exQeCY8wruphAwpHZTJGfonX7C7+u0I8C5Yrn8u44MPp7UK6ZXkk4FKxsIiVK9F1ZNPQUEVlfCmZR0t4KuFT6lURi0Y5iSvVYPaJkv8+vaFcb3xfuvp2UzDMUmN/4Q/PkhoSC8ogEbvE2zd/2aSEA/im+6BjnrZ3Pj47XQUefd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809075; c=relaxed/simple;
	bh=/fiBZaDVI8D+68biIo4CAt/ib/Y3X7aN1Tu1p+7XeA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egSMAeDqOv5sbB0OvxP2YbV7amd7BAp/6OxAW0gUodiwrtBkdIrmiTdV+2nxyTrquAwgf3Z4sdkahVhanM1Ff7lMvGUCSIxB3nSho7U/0jQHbs70yQfwYjPjQJdE/mxz6gUFOzkV35/WAgdNBfwa0OBnvl6Uh31mJ/AvDvmrutY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=potKs36F; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6096ff3e4abso6664037b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 02:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709809073; x=1710413873; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNxbMXYwIPnmt8O7zwgRdhBxxDwkUuvEtABz+BytD3g=;
        b=potKs36FdQiGFwxfytailT+Lu0noLufeLXha3aRGfKtkhnTwieaGFB/pg9SlT7GznM
         MyDgILKuOCzHPja4SkFVZ2cl0GrK+Rg6mSAiTs6MZ2z/F6t8AibQyoqSkP2PnEVgfZQu
         kc18sRW6RjvQNMMQ1kVg7uk50bKDEu6lldroabwit4Jgs/i0ZVwM7muRepVtTV8u6134
         LRYRhaCrWpQlin94RwpuoyV5/pvCjwGDXLkSWjkw7rInz/utmy2IdES9+0qdIT6U+/Kp
         adV4ctS6miq3eOX5NOUNz697Um8mRklyV7uzqZ+tb7v9CpWSdj2fOHhrUOOkMIRVQdug
         Lxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709809073; x=1710413873;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNxbMXYwIPnmt8O7zwgRdhBxxDwkUuvEtABz+BytD3g=;
        b=w5enOpHlcEQlddzCssATFrdZAZk+Z5GTxptlG4gPra/YETDcqfFyMF2SMZsajrbcOg
         EFT2vniQuSo7tW00xfP/qKVpN05Q6rQSix6hD7dWAQq6h6KX+26FdYHQZSSgngusQCuI
         7OW1sMMw691r48eYdJ0LPKAe0sVa4T8ElgBLMjGumnFwTX5VmwQIYbkk9OqkmVSs+5fa
         7IQEHDWc+j3d4qkpzfCUTjnea4Al4/JTWnsSrJG8u7Am/58N2M+CIdQ9inl1VU19KhcR
         jew0HmfwApCrG3SH1BlvuZe89W37yqgYcSNpUYFjt6Tl249YhUD1D/M1BXBCfVI3qAja
         hcvg==
X-Forwarded-Encrypted: i=1; AJvYcCW2tzxMWxXl1V4dKYEu2/gflpKRBBhbcH+ABuj6k2n2+JbiJ8k46mVJAM7n83j55sBiiJOagfcdu03+3+l3heOLz/P+IBoGnxj7iwv8
X-Gm-Message-State: AOJu0Yz0JekY5VunRtnmcO96V+hEFpUZsKYpO4oVi8kXe5KWaHN76tj4
	c9vjz9LAovlqprExnuj+0ugx1jWrZft41TodF63pqkQOTvollw1KMrGRSnla8rFTIYmVFeb8T+W
	dZEdOeWzriwOwl7tpgyh4JHxlhAIoEfJuyZ3wEg==
X-Google-Smtp-Source: AGHT+IEI8kispC//A1bCKjmVv5onGnRwEMCzuKG8Vfr/1UKLJdm/uHCFvoMXjzgrc6VtDDnVDrYtTnGU/SyINCrOfrc=
X-Received: by 2002:a25:83cd:0:b0:dd0:453b:485e with SMTP id
 v13-20020a2583cd000000b00dd0453b485emr9701343ybm.58.1709809072881; Thu, 07
 Mar 2024 02:57:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307085135.16245-1-amishin@t-argos.ru>
In-Reply-To: <20240307085135.16245-1-amishin@t-argos.ru>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 7 Mar 2024 11:57:16 +0100
Message-ID: <CAPDyKFoYRT=P+4L+5ciNPxEHcS7hoXPef__NQoodxkSy=39Teg@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix potential null pointer risk
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Wen Zhiwei <wenzhiwei@kylinos.cn>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 09:53, Aleksandr Mishin <amishin@t-argos.ru> wrote:
>
> In dw_mci_runtime_resume() 'host->slot' could be null, but check is not cover all corresponding code.
> Fix this bug by changing check place.

In fact host->slot can never be NULL in dw_mci_runtime_resume() or in
dw_mci_runtime_suspend().

A better fix would thus be to remove the redundant checks.

Kind regards
Uffe

>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 4a835afd808a (mmc: dw_mmc: Fix potential null pointer risk)
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/mmc/host/dw_mmc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 829af2c98a44..a4f124452abc 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3570,8 +3570,10 @@ int dw_mci_runtime_resume(struct device *dev)
>                    DW_MCI_ERROR_FLAGS);
>         mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
>
> +       if (!host->slot)
> +               goto err;
>
> -       if (host->slot && host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
> +       if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
>                 dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);
>
>         /* Force setup bus to guarantee available clock output */
> --
> 2.30.2
>
>

