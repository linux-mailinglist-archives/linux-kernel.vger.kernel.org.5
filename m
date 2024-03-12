Return-Path: <linux-kernel+bounces-100176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D27879300
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11FBEB2252C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F60579B85;
	Tue, 12 Mar 2024 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="suy3Kme3"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B8D20304
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710243021; cv=none; b=kvDf9ejMVrhiSXwiAQOEHIGpop6JM7390chPVVoKagoG292kW11HNQ+MhvMr8BXqgV8lg8SStHvhvi0gMNXDqtURNQzACqd1WPkO/phS0MyTu5ZtjtQt75SZjV0T7aDtsy6QtGnXk3M23JSwhsxWwzOHG+7vd7l0vNojgTqLqDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710243021; c=relaxed/simple;
	bh=l2WdSNUP4K3SIKsekSGXnuJXGSgpdVPTEVsLPobE8NU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVqhUZlgULsNkbGKw9Xsdd3I8tse3YBA/qmHJZ0PLFyvuLLR3ZQjSYJ4XzgG0ewf0X73oOuywssq6UR/LKHPqFsEgEU8myNSBMjyrQusMbjqR8mWhOnCc/jQY+Qzeqoml00WB835cqMJN3uOrJN2631rJUuIwsS2eGCxLNm+XgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=suy3Kme3; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56845954fffso4004351a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 04:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710243018; x=1710847818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CupxoLbqDAw0iGT/Dkpjp3a8L1C7qew16mx6r26LNOI=;
        b=suy3Kme3GoTwvuDvCo7FxdJ4a+X0G2nZQEYnirOqW84ejLh0FNsdIG/IdeyWsJwlFX
         D7PNR2xUj0GR783+HAHnN7+hHCRMgjBIInIpLdwnMdGTyCIy0biLlg9ycPQ+C9pTbhG7
         cRMhWL7iAUiWrhJNIC/aM7XMio4TxArzO1LvhDAQfOmTE+tcf3g7e89yzg3Kk6ileFgn
         fuchibVdIeFlJ0GcoP/jE8/vPo2mWCd5eaR38R7eyGJ2WJFoJpRxt3tD2PLWHrjjJeHY
         m4CIB/9GbXBcjcCJq4JQpGegS15S67nS7e58TjUSuj8Ft/+fg2noDGObneizeWuQ/uK/
         INoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710243018; x=1710847818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CupxoLbqDAw0iGT/Dkpjp3a8L1C7qew16mx6r26LNOI=;
        b=fXPelOHBVEwLPJMhrUqeAytHwvWkXC3QXM10WQVX284KAfMHV8MJbknbfmPux6w8X+
         z0tJYufaJi9KF9rJSKo54QqYmxJaDU4A05jXS6pQ8Qwuz5fQp4EV8IepgTl6gaYJf7s7
         ogJaSruVt2C+tid/H5p5RBbrkkOccyKKeCDXk4COCsQRAjRPdT5U6GP7GqDvnI4NJkRz
         6iJfwbPEh7QbxC4UH7FPqumRJTh9MKxACGHV0GrLOVTg6Exm5HmNINTwmWxVgxO6wta4
         IDxCsCvmtMfErET2cZu2QhLSU0ouq+Px+aUhjhYJffOkYKLpRHV4uct91oHNPU9YeYCI
         pqCw==
X-Forwarded-Encrypted: i=1; AJvYcCWDKbQSDmSm7Awmgp//3CIk6tBfRzOxe9qumM1ou0MYeVpKjsA+R8XCfY/czhzBe0aqAQPBA2Wliz0hcJyg1/Q6NFn5p000H4tTV5qw
X-Gm-Message-State: AOJu0YxzGCB9WdpLarPy5IC9pw0fT1CqkQ06hFY67GCzTiBtLOutER3/
	yaj0FZ1HVhVNSwWOolXXNtYsKlADUZ1OtBG1qcnEEJlsNTStKSdYyEWCO02Mbu+vndEZJE49en2
	7qZJqz0WA7/34Bn/ifjCgQiczp12VZIQaLhlfig==
X-Google-Smtp-Source: AGHT+IFHD9Ak/IwOC1zEHFPh2Kddo7eOh7ziL0ulLzgGW/R32C6TAxkb/xc28APd4ASLmM4PwNUPmk3IAYvFtC5rG5o=
X-Received: by 2002:a50:9e24:0:b0:565:1460:8447 with SMTP id
 z33-20020a509e24000000b0056514608447mr1438863ede.28.1710243018038; Tue, 12
 Mar 2024 04:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307085135.16245-1-amishin@t-argos.ru> <CAPDyKFoYRT=P+4L+5ciNPxEHcS7hoXPef__NQoodxkSy=39Teg@mail.gmail.com>
 <98dea36b-41dc-4d2e-aec6-56c849e1d58b@t-argos.ru>
In-Reply-To: <98dea36b-41dc-4d2e-aec6-56c849e1d58b@t-argos.ru>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Mar 2024 12:29:40 +0100
Message-ID: <CAPDyKFrJmoHA+HsfdC_VjJpah=8Pqi1zGbj0oABMn01go7CrbA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix potential null pointer risk
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Wen Zhiwei <wenzhiwei@kylinos.cn>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 20:07, Aleksandr Mishin <amishin@t-argos.ru> wrote:
>
>
>
> 07.03.2024 13:57, Ulf Hansson wrote:
> > On Thu, 7 Mar 2024 at 09:53, Aleksandr Mishin <amishin@t-argos.ru> wrote:
> >>
> >> In dw_mci_runtime_resume() 'host->slot' could be null, but check is not cover all corresponding code.
> >> Fix this bug by changing check place.
> >
> > In fact host->slot can never be NULL in dw_mci_runtime_resume() or in
> > dw_mci_runtime_suspend().
> >
> > A better fix would thus be to remove the redundant checks.
> >
> > Kind regards
> > Uffe
> >
> >>
> >> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >>
> >> Fixes: 4a835afd808a (mmc: dw_mmc: Fix potential null pointer risk)
> >> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> >> ---
> >>   drivers/mmc/host/dw_mmc.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> >> index 829af2c98a44..a4f124452abc 100644
> >> --- a/drivers/mmc/host/dw_mmc.c
> >> +++ b/drivers/mmc/host/dw_mmc.c
> >> @@ -3570,8 +3570,10 @@ int dw_mci_runtime_resume(struct device *dev)
> >>                     DW_MCI_ERROR_FLAGS);
> >>          mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
> >>
> >> +       if (!host->slot)
> >> +               goto err;
> >>
> >> -       if (host->slot && host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
> >> +       if (host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
> >>                  dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);
> >>
> >>          /* Force setup bus to guarantee available clock output */
> >> --
> >> 2.30.2
> >>
> >>
> >
>
> At the same time there are few checks such as "if (host->slot)" in
> dw_mci_runtime_resume() and commit
> 4a835afd808a3dbbac44bb399a902b822dc7445c message contains: "we
> previously assumed 'host->slot' could be null, null pointer judgment
> should be added" and replaces "if (host->slot->mmc->pm_flags &
> MMC_PM_KEEP_POWER)" with "if (host->slot && host->slot->mmc->pm_flags &
> MMC_PM_KEEP_POWER)"
> So where is the truth?

It looks to me that the runtime PM callbacks are prevented from being
called, unless we have a host->slot assigned.

Just adding checks because it looks like the code could need it, isn't
always the correct thing to do. I would rather try to remove the
checks altogether and give it some tests to see how it plays.

Kind regards
Uffe

