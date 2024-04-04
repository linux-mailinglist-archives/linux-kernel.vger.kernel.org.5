Return-Path: <linux-kernel+bounces-131414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D44C89877D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D521F21476
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABCC128395;
	Thu,  4 Apr 2024 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oLVfSW2L"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B9127B72
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233581; cv=none; b=M/adh91fQ4bBh6P5SO0lrGAmYWPQFVrXEGezxPx+man/jwA38BIp1/H9epe8BTKmAxPLNeYrMl0v5M0b2PqS9J1FbWeLN8Xi405uG1prxF8zXJQqSNtbbgthlQBWC3lp3oP9BVIVRZG5Auy4hqnAyyfpaQOG4Q1uvl2EcxEAY5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233581; c=relaxed/simple;
	bh=nKbvlDRuwmkwDrYvvcFdwq4SEQBGtNcWvtLI6tBE8Fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jkh9m0fV0ZhEKA418S2c/JcDOBDVGFd6d/LKtWSSjy2ig9Mka4WyNlT6UKwmjxXxFUJ7jDZAQGXUaf0lVh201M6Gs0B8JiB2nGddiWjuh1pXyShYGIrYUaaREJ01BoqZFkvWtiza+QpCQU4z5nFBtFT2RTklMTaUOSnlukt/wvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oLVfSW2L; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a2784b2783so661516a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712233580; x=1712838380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y75OMFbL7vQmdGj4RKt16g/wSJzKHLW5zDKxEznWL8k=;
        b=oLVfSW2Lhue7hY60MbWn1Qjj1s8imN0PAlIxikGVIE6XoOvyeoMsUE3eIYz9Lfky/u
         WsLVrkJAVTlKUNi+k8SomN9/7p1hdBvZXuXADH4ZX8X6PJdW1iWUpYL94IXzaGmzOUuA
         nQ37YDhQGrZ1SdV7k+Jb8lQWvM4kovzlRdeNDCprFZ/qdrnfYXu1LNu3JZ9htqkvvz4r
         9Z4GtmCmBtNU79/P9g7Hozl4C3ZgaP24Z2f0WijPge4d9CASN1aaDQgwASmL6PSRJ/qG
         mG7Yy0nZy3nWhqi0MCWpQo+ydMjWQQs6pqKuqnPPPc2ZkqascJ0Bpvwgyac6iLfnff0C
         PCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233580; x=1712838380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y75OMFbL7vQmdGj4RKt16g/wSJzKHLW5zDKxEznWL8k=;
        b=i9ktPNY8cgoQfLB2Sml3CJG/moOAZ8RdiYAcvje8UUDXSMn3dlgmKDAv25vy2Bx0gU
         VSl36e2wPAoX/6dYBB67IXVbFwLxvycdl61owtHFefhRDFvq9cR5pkysjW+/jxhcRDGj
         hyUjQ2l+4FvrXa2HA0JzSIN5AQEOWnYh0mWVfmf6Aoa72czat+iwhkjY8PVSMTnPQ7vr
         YrNX6SKDM3DhUBOP+FXeYkhtzhHZBaNrPvGTNavbqJW/3QOUxbfp9nRsV7SsLmTtC2NJ
         CC2Fc5sfjqnRmDEkTSi8ZACtrXFThIVkuJ7YP251OmuXtFACmizhe2Vz23VR0AwsQtO+
         XtLA==
X-Forwarded-Encrypted: i=1; AJvYcCVa38bjZnyxZ98pJ49p7TbJ1T4CiHIpWDgTLR5Hb4dWtXoDv+o1SHw/AdDCb18Z4cn37cD8m1A/Frhar0AjbJBWtpVoo+XGZpgM5clp
X-Gm-Message-State: AOJu0YyEKD0Cc9lXegJMFju0DNpDfbv5dq6DLtNBMrbJ4idRqBz2BALy
	yvJocaghsB1D0PmGYzCU6njczwPbr9OI3Wivr5/N34ZrdBg+QKr2JvuQ368FVGBfYqgvrougq9J
	QkqMyjEgaH5JUbSpxLg47qxpbS+ahEAYjCpb7OgehBUFHT2Nn
X-Google-Smtp-Source: AGHT+IFjKdz3u/UVhyauvDpLc8hy4deCSYOJTjbvbQN7L+M2Y5bH505OVlIMuAZ8pblZGkxydM458USFDYheAtvG0Lg=
X-Received: by 2002:a17:90a:f283:b0:2a2:b32c:dc5b with SMTP id
 fs3-20020a17090af28300b002a2b32cdc5bmr2306195pjb.10.1712233579714; Thu, 04
 Apr 2024 05:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712147341.git.vitaly@bursov.com> <d9af90271748e6035c5f8bfc03b7bacdde357766.1712147341.git.vitaly@bursov.com>
In-Reply-To: <d9af90271748e6035c5f8bfc03b7bacdde357766.1712147341.git.vitaly@bursov.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 4 Apr 2024 14:26:08 +0200
Message-ID: <CAKfTPtDLGOvaBtdzxyetOWRFbZSq5mN5LY39AcvXkKMe90wp1Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] sched/debug: dump domains' level
To: Vitalii Bursov <vitaly@bursov.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Apr 2024 at 15:28, Vitalii Bursov <vitaly@bursov.com> wrote:
>
> Knowing domain's level exactly can be useful when setting
> relax_domain_level or cpuset.sched_relax_domain_level
>
> Usage:
> cat /debug/sched/domains/cpu0/domain1/level
> to dump cpu0 domain1's level.
>
> Signed-off-by: Vitalii Bursov <vitaly@bursov.com>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/debug.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 8d5d98a5834d..c1eb9a1afd13 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -425,6 +425,7 @@ static void register_sd(struct sched_domain *sd, struct dentry *parent)
>
>         debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
>         debugfs_create_file("groups_flags", 0444, parent, &sd->groups->flags, &sd_flags_fops);
> +       debugfs_create_u32("level", 0444, parent, (u32 *)&sd->level);
>  }
>
>  void update_sched_domain_debugfs(void)
> --
> 2.20.1
>

