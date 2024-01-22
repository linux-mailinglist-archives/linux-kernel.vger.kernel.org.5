Return-Path: <linux-kernel+bounces-33580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93B0836BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A078B326A1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80355A7B1;
	Mon, 22 Jan 2024 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kCq97zwi"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B4F5A79B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936951; cv=none; b=GIuU6IGPj4edb8NAol/Q7bq4+b9RoJQ3Y7vAumk+bNieaVIIM2fvB/xzbsSrHZRmVMsmzOamwHMgxpLIEyaBI6xyywauWZfpWGLBuxClbbhK3k4q+jQPtKcW/2KGZsRAb4vBjdoX9+WVmyQMRN0v+oZyJfic0XE3v6GzwkhgKRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936951; c=relaxed/simple;
	bh=iehecb528leRzyo9EGBQ3VZAVNJQWB829o9SIxb+duk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItWyZZseKrfgqawePvBrBkar37splYUYNX51yrKalz5Cc4xMzDSeu0li4dDGkE2H6434xCBd7MB+0D8qdjNZ4AZ+UHrKlDZW8EOmebqs2teEwUemg5odMmY85ZV+tZ1y2dDD9WQTHHV5OhzWqmYQclFuaAnyJ30x1+69BYauZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kCq97zwi; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-600094c5703so6856477b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705936948; x=1706541748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JgiZtCrMuZLXNw6xrqc0GV9xSUaAfBF4r7Sl8Qdw7jA=;
        b=kCq97zwi56PjcBbUpc2uVv5/p+yY7J/+X7kx2/TSEz6Zv8TXuP4IPeywh+Q4HNvPdK
         hZy4KmtBwPh9b6k/Dk17TanTvkXLh60+vC7grNbN4Vpec1GmGj4rF9hJNZ7wDbp5YJDS
         1fylbaINnRILuz3VJTxP/6jbC95z6XCNBhKBjaffCNHth1/FXlOUfxLTd6Waqmg11cdk
         yw5UNbiNe+IDTVbernQbiDoKGQBSBBQsm3jRygr/ulKGT/g9AAvfgxuAa7FESu8LfPLG
         8BiDuPzCF6Qc9sjAF4aqnKLnsk66Yj302xvgiAfjNoWAita4VkE5Nd8aogI8/R2XKuCg
         DqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705936948; x=1706541748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JgiZtCrMuZLXNw6xrqc0GV9xSUaAfBF4r7Sl8Qdw7jA=;
        b=MbsC6E7Iw1loqv3ciKrFNiejiG8CUo6+CvicjtkClrFyf8Rsv5HXsG78WqVsUx+zJO
         xKgvW/W63WONvvdRRTlVtFZisYd279gJ/K7BJgQaNcIZrajPs8BnWjb/H46NfgeDstoT
         z05OVE9esdl7MyFg+YlDBkZ6iCJqCloiCtal9Cd2YeBiobocS76jvNxn5KcGUJonrZNz
         S91zqLwu5q8FzJ4UijC5kZUeCnVuJnK4NrxevA8iW+ZgDWjZYby0NZCjo2FClspza5dp
         UQw8jwQ09FzWb5Ok5eB078u042IHJXcPGh2i4F1wxynlld5V9f+8YNMz1mFbNMosQFQ6
         g9sQ==
X-Gm-Message-State: AOJu0YzH0cNL3bczM8tLXBJWGSNCf//q9LyDx6KpNAuZQQ5tr8pOm3J/
	w+RF5757A8rMB36m+eycBrBf1FSqirz8W+HHOCheEy7VioHU9Z7Qkcl9LFzbg0EALsYcKK+qSmD
	Zmdb2ejIQyKu5NmLKYkzH1D+FNrS60st2b7tRPw==
X-Google-Smtp-Source: AGHT+IHOaa3SNYwCf68k2MmEZ+Vul7ql0avy2YB111DnZq3iZ38/pX3VQpszd24XmWino4rYa0tTrsM3A3651pm14P8=
X-Received: by 2002:a81:9113:0:b0:5e3:320b:7c with SMTP id i19-20020a819113000000b005e3320b007cmr3683898ywg.37.1705936948280;
 Mon, 22 Jan 2024 07:22:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118054257.200814-1-chentao@kylinos.cn>
In-Reply-To: <20240118054257.200814-1-chentao@kylinos.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 22 Jan 2024 16:21:52 +0100
Message-ID: <CAPDyKFp=s7aOnpXti=rGTri=exW7sHdH693TEz7cQTiv=2gnFw@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: Add a null pointer check to the omap_prm_domain_init
To: Kunwu Chan <chentao@kylinos.cn>
Cc: nm@ti.com, ssantosh@kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jan 2024 at 06:43, Kunwu Chan <chentao@kylinos.cn> wrote:
>
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/ti/omap_prm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pmdomain/ti/omap_prm.c b/drivers/pmdomain/ti/omap_prm.c
> index c2feae3a634c..b8ceb3c2b81c 100644
> --- a/drivers/pmdomain/ti/omap_prm.c
> +++ b/drivers/pmdomain/ti/omap_prm.c
> @@ -695,6 +695,8 @@ static int omap_prm_domain_init(struct device *dev, struct omap_prm *prm)
>         data = prm->data;
>         name = devm_kasprintf(dev, GFP_KERNEL, "prm_%s",
>                               data->name);
> +       if (!name)
> +               return -ENOMEM;
>
>         prmd->dev = dev;
>         prmd->prm = prm;
> --
> 2.39.2
>

