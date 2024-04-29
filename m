Return-Path: <linux-kernel+bounces-162446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9CB8B5B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9D91C20FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC7B7D413;
	Mon, 29 Apr 2024 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="exItxLQS"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84727C08D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401171; cv=none; b=ATqKceTRLGlG/gAh3V4MUyKjloft1e8TBVYNnkTxf2yB7F8Ded4B8dDXcXKr2pPO/bAkfkSQYkg8AbwjwLejCly9mwuSyFrq85m1Bqg++Qvdwfie67a/ukqc/9xViDZPcPLZUdMg9r2rUs7AyqyUL00Qjns0fGgfW+lrp5mnXGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401171; c=relaxed/simple;
	bh=R2IJ9jbUicExWITAu21Rr1F4xMn9UPsD0Wt8cWLIB7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dy0rsqBmgJQa3zQas6HblJ5/nKQSSMVS0UWjVq9m+lCNLA4epnAIjHEFp35qSV0/rG2RplcIy4tDsd16gVnqFC2MCjnMib1wPQlDcbxZ78IwMO7CRATvYtIeVHbCYZMwLEi5lm6DuMmfSpJ7ckNjUX8j2MZ6NMdg/eqxGxyOrFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=exItxLQS; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de5d439b729so1477988276.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714401168; x=1715005968; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EVa516LbuT5UPv0iKw28ApHoF3832BvwsWW0h9ARp8c=;
        b=exItxLQSm5XRIr5ydxIfSgt/51niY/fRD+vg94ZJdWajh1MMPUydG2wGsCLcLENC8k
         uj/ykogPzVx+5NyCjBRg9nZigRiAjFEjIh5q5UHmQlaxJ2Szps/4ERc0kpoMx8QW0yxU
         Amh5+SahA8MDQCl8RPq+8ZWs06MRoAtoNomDtCBKZbBGB34FwSPAoa0CZceNPevVdajH
         nmThvV/EGgKqZvA4+ydxLe0ZX8O7bLriY1sQSBRqLIGAmskBete3D6eh6vmhkFQ6BUC5
         IhNHCPY9QoQjg5UQCdYao7+uPYKmwmSkQPnd3IUa32p02BhojhCoz6LzMTbt4sVPWzXe
         zE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714401168; x=1715005968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EVa516LbuT5UPv0iKw28ApHoF3832BvwsWW0h9ARp8c=;
        b=BMawRWD69dJ/cCp0m8Cckymdh/l6DkIpf2jn5DxVZizzTyLXSygxL1dHAj4uFE60YV
         cElCAlgjhHiQfLiwi9WEd6SbUwwFj8FVwlZcovguDzh2Zr7rtqbmIWE7bnvUhRwlHrZY
         8SJGBac2Ci2T1ndC00PfAurLRUBzk6/yn1pdWqWLV7mkjFmoGdwsz+avy1tAmNunwTFq
         +vNGh8y8dtaiGtKC5/K+n2yLMkeX8f/vg7Ut2DVheJXXybX7X+xAOJyajaMMkueNoMaE
         Xua+tr9bAQQia1He+wYrI7MJ/BE255QhXGvBsY/WQ1oHkCGoB26O7aL0DSD8FlR/TeBn
         kXig==
X-Forwarded-Encrypted: i=1; AJvYcCWizqOFickkZXqWaAUTG30IdCcy0z2fKlBEIA9tModTIZ7FxapbZWIa03GYx6hsq2WWZB6hqa0vHXHdoy4Y+ozPa54CVuVFfoNERTSK
X-Gm-Message-State: AOJu0YwUIabShYC5/gY81XaxK17nFsm2Si5/ECBlTLNgI0n1zUgDG/Qa
	Svimcd067wEI5TGEZ0ZDtzoimjVwR8JEs1m0oZZFxZF/RW0PVpt7T9idU5OLfiGYvRgKK+USf2t
	XFx0Td4pwHvrYoZEPJCYOp8cYXd00XAhIvKzXaA==
X-Google-Smtp-Source: AGHT+IEBhQrtCQ31Q1yBqSjyByUL2jVr1xrFTj8kOrfHtAdw8Xnv7g9ncuR5kGy6Y4r51HFP6z0R1OWCL4HGDGIqLfs=
X-Received: by 2002:a05:6902:2788:b0:ddd:7a62:59b0 with SMTP id
 eb8-20020a056902278800b00ddd7a6259b0mr5454757ybb.15.1714401168659; Mon, 29
 Apr 2024 07:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226065113.1690534-1-nick.hu@sifive.com>
In-Reply-To: <20240226065113.1690534-1-nick.hu@sifive.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 29 Apr 2024 16:32:12 +0200
Message-ID: <CAPDyKFph3WsZMmALnzBQKE4S_80Ji5h386Wi0vHda37QUsjMtg@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Add cluster_pm_enter()/exit()
To: Nick Hu <nick.hu@sifive.com>, palmer@dabbelt.com
Cc: anup@brainfault.org, rafael@kernel.org, daniel.lezcano@linaro.org, 
	paul.walmsley@sifive.com, linux-pm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	zong.li@sifive.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Feb 2024 at 07:51, Nick Hu <nick.hu@sifive.com> wrote:
>
> When the cpus in the same cluster are all in the idle state, the kernel
> might put the cluster into a deeper low power state. Call the
> cluster_pm_enter() before entering the low power state and call the
> cluster_pm_exit() after the cluster woken up.
>
> Signed-off-by: Nick Hu <nick.hu@sifive.com>

I was not cced this patch, but noticed that this patch got queued up
recently. Sorry for not noticing earlier.

If not too late, can you please drop/revert it? We should really move
away from the CPU cluster notifiers. See more information below.

> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
> index e8094fc92491..298dc76a00cf 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -394,6 +394,7 @@ static int sbi_cpuidle_pd_power_off(struct generic_pm_domain *pd)
>  {
>         struct genpd_power_state *state = &pd->states[pd->state_idx];
>         u32 *pd_state;
> +       int ret;
>
>         if (!state->data)
>                 return 0;
> @@ -401,6 +402,10 @@ static int sbi_cpuidle_pd_power_off(struct generic_pm_domain *pd)
>         if (!sbi_cpuidle_pd_allow_domain_state)
>                 return -EBUSY;
>
> +       ret = cpu_cluster_pm_enter();
> +       if (ret)
> +               return ret;

Rather than using the CPU cluster notifiers, consumers of the genpd
can register themselves to receive genpd on/off notifiers.

In other words, none of this should be needed, right?

[...]

Kind regards
Uffe

