Return-Path: <linux-kernel+bounces-117130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6700688A7A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F521F3E30F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FBE13DBB7;
	Mon, 25 Mar 2024 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bEDmjmWO"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A49137744
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372753; cv=none; b=EWFPIHlPuWm79oKGIZbWt/YuTDCUssZb1h2A9PIpWb4bBLm3X/GWpPCDyPiDVTXifcZr0IqIfQK6wVozLOn7D9oJRIpFyiObLIg5bb3yZN+LLGGZyQMLSrnVfOBQ5cGOuznWBIds5MUHuGCRu6kGrn07mDEZS1s38cXGG+aUG5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372753; c=relaxed/simple;
	bh=gAXmZJZ7JPBYyLYvwXEjCgYPbJ+nziJz1EoVZFfYBxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6G17tbODKp0HpqV9SSY9GqeZgmNlKqgeym+gwFue/aQOSdvWPrVjlu6mpIBOugVHGtQ1/trU1YeO7qx66rhg2vQN6inUxXf4wNGS8GPikah+//6nVpb3nKu01YeH6ss54K6taGBk8GWuB2odjSyLT1LePXoppnTEwO8cZwNCos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bEDmjmWO; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso4226268276.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372751; x=1711977551; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FRJs/xxex33QkTbsCV8od3MYvkVpVGCKzchYiYGgxF4=;
        b=bEDmjmWOdFzt6qmzyF5yUupxP98K9Zf3Bj3n0pI3jJ7D1ApN4kNu44xnKJ3uI6UqzP
         4iCHOduFs85wWvPc389bDbwu5TsY/hmJ2XmoyIn0/QcMw3tzc8I+zMujUVRBwH5PsRAD
         UHjUAip5pUFiChSfpU+i/3fRedVjOSQCxWCgfjYZj+i7NlvaJFHcdtVDD8iLVeBOhCp0
         ctEB6gcSmb0keG/4TWFivGKAgvbxT+yRFoU694g4jO0CUdJJtgHi2EBb8jo1/JqIdsn1
         WPZvvjwDyS7SWosnesE4l/hoCDMo7KUd24JuyZ/f2PF4SqCkhm2rvBsNI/OgFe8m7nAa
         S3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372751; x=1711977551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRJs/xxex33QkTbsCV8od3MYvkVpVGCKzchYiYGgxF4=;
        b=IiI6hHnUdpLDRz6qUgQvNtATK4u1QngfudXwnE5PBMBLsGeIHgsqpKaYykA5NRdT3+
         tcaYl3C0/BP88vKtbVD9XM70n96aCsxQsI5E5TpJsCO+iZT45uEwb7tgA9cxfvEnzQMR
         +esaXleXWg8Md1vN6LDPrnRVrNAXg9kHRKjUO7Ov/l2gDN7WH3ZilcuRW9g3KAZNJUy8
         sYsmbBqcEKcopuJYQXlCwrUEQkt2MfciartELzmERMBQDaB9x5dh5DNalP7KeKdTQG+7
         KplmC4XKj5HyNviJGW58QP/KAydNPCzs80+uJjtHEfnmJd9kzocUI7DC8+PnISDT134t
         C8rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS7FNl5nLJXd8ElW1rDBfbO/g43swJ6Z1TeBcZWp6gNkTOdqtyU0WIb7FKC0mZb+cQdcDhWyTrEUL/5THeE6YP+xOmdsTWckKybQaq
X-Gm-Message-State: AOJu0Yw9rQ4/r2Ylt8tkTSh2xgV/rL515SR+pV8RskeuAOZ8t5XLBKQY
	ZDidzHbesH/qF9SZJLifcMIfJng7xJ1vBth4SzBeMQmyA4g7RgrAZdEm9J2fsSLFVzVQqU1o+6v
	GRfL8sPisZOU5QQKEeWT5m68KvCu3XT4tDKtWdQ==
X-Google-Smtp-Source: AGHT+IG2xBt6Vvh6SED5qGZRekkF3bhfFw7W0QPkk8DRIa7/EdrIKglIsJQC7D4muCETLEynNq4MclW5IGDlO/oijkU=
X-Received: by 2002:a25:8381:0:b0:dcc:ebb4:fdc0 with SMTP id
 t1-20020a258381000000b00dccebb4fdc0mr4315085ybk.65.1711372751176; Mon, 25 Mar
 2024 06:19:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307145013.2721326-1-usama.anjum@collabora.com>
In-Reply-To: <20240307145013.2721326-1-usama.anjum@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:18:34 +0100
Message-ID: <CAPDyKFqE1bEPfye7PSLXALE29XoTT3Y4UyMLDUWorLuKCbSG5w@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: remove unneeded assignment
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, tianshuliang <tianshuliang@hisilicon.com>, 
	Shawn Guo <shawn.guo@linaro.org>, Jiancheng Xue <xuejiancheng@hisilicon.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, kernel@collabora.com, 
	kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 15:49, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> The err is being set to 0 and replaced every time after this
> assignment. Remove this assignment as it is extraneous.
>
> Fixes: e382ab741252 ("mmc: dw_mmc: add support for hi3798cv200 specific extensions of dw-mshc")

I don't think we need a fixes tag here, so I have dropped it.

> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Applied for next and by amending the commit message prefix to "mmc:
dw_mmc-hi3798cv200", thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-hi3798cv200.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
> index 61923a5183693..6099756e59b3c 100644
> --- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
> +++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
> @@ -87,7 +87,6 @@ static int dw_mci_hi3798cv200_execute_tuning(struct dw_mci_slot *slot,
>                         goto tuning_out;
>
>                 prev_err = err;
> -               err = 0;
>         }
>
>  tuning_out:
> --
> 2.39.2
>

