Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6450E805EE1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjLETyp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 14:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLETyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:54:43 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD7FA5;
        Tue,  5 Dec 2023 11:54:49 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1fb155ca04bso581560fac.0;
        Tue, 05 Dec 2023 11:54:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701806089; x=1702410889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPGxsQoxPpHlL6Ppz0lS+ug6RWxWQAf1JLFDoILOKxk=;
        b=lv+OiBl5zo7w3ILusbHF0+pFabQAoBIz+oIC4vI4lR3hfRiD5QV9fBr1Ka5VYlRnNv
         cQIYZdV59OeMXaUSaZawvGN8qWlTLk3nMpca4XGDj1I3Sgi9jHlTS++76lIc6A4idwcJ
         iWKrCUrCdOFf7Srek8tc8Hsni1b950FcifPKCasDDs2tZZPGPguj4lbgmTjoXApDb1Yh
         q4l/uwguMBUK7dG9ZEDvYaHQZ1ZnjwPPE0xqhHFMVnB5rEl8g4kewPEqGIvZGjlp9T1z
         cOBUmJL5GkEMZ3fhcpgGDzLj9kFaBSAD41jNundsQU6NguUHTN5mzOEVy1XBFLRFRqdg
         EVdA==
X-Gm-Message-State: AOJu0YyuxJS9BJ8oq2r3+bPKmDI373ykWk27iog9SW24mfyoYeOix6tD
        jd+m7GG5oFI4dODi4dd+DCYWEX5pwQPAnSvsFFg=
X-Google-Smtp-Source: AGHT+IEhx6WPaNGbt7d2ljM1iILKgZIiYOO/438XhxCPllpYfT29IloMq+viVAgZzWlXPNQOIxlPEfgR0ONDceOMJoA=
X-Received: by 2002:a05:6870:75cd:b0:1fb:136e:fa93 with SMTP id
 de13-20020a05687075cd00b001fb136efa93mr12559032oab.0.1701806089143; Tue, 05
 Dec 2023 11:54:49 -0800 (PST)
MIME-Version: 1.0
References: <20231201123205.1996790-1-lukasz.luba@arm.com>
In-Reply-To: <20231201123205.1996790-1-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Dec 2023 20:54:38 +0100
Message-ID: <CAJZ5v0gYfvJCQ6Tk2Jh8ZYtaJM=sq3Qb6dq28rjYjMNPfJBT_Q@mail.gmail.com>
Subject: Re: [PATCH] powercap: DTPM: Fix the missing cpufreq_cpu_put() calls
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, rafael@kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 1:31 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> The policy returned by cpufreq_cpu_get() has to be released with
> the help of cpufreq_cpu_put() to balance its kobject reference counter
> properly.
>
> Add the missing calls to cpufreq_cpu_put() in the code.
>
> Fixes: 0aea2e4ec2a2 ("powercap/dtpm_cpu: Reset per_cpu variable in the release function")
> Fixes: 0e8f68d7f048 ("powercap/drivers/dtpm: Add CPU energy model based support")
> Cc: <stable@vger.kernel.org> # v5.10+
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/powercap/dtpm_cpu.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 45bb7e2849d7..aac278e162d9 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -152,6 +152,8 @@ static void pd_release(struct dtpm *dtpm)
>         if (policy) {
>                 for_each_cpu(dtpm_cpu->cpu, policy->related_cpus)
>                         per_cpu(dtpm_per_cpu, dtpm_cpu->cpu) = NULL;
> +
> +               cpufreq_cpu_put(policy);
>         }
>
>         kfree(dtpm_cpu);
> @@ -204,12 +206,16 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
>                 return 0;
>
>         pd = em_cpu_get(cpu);
> -       if (!pd || em_is_artificial(pd))
> -               return -EINVAL;
> +       if (!pd || em_is_artificial(pd)) {
> +               ret = -EINVAL;
> +               goto release_policy;
> +       }
>
>         dtpm_cpu = kzalloc(sizeof(*dtpm_cpu), GFP_KERNEL);
> -       if (!dtpm_cpu)
> -               return -ENOMEM;
> +       if (!dtpm_cpu) {
> +               ret = -ENOMEM;
> +               goto release_policy;
> +       }
>
>         dtpm_init(&dtpm_cpu->dtpm, &dtpm_ops);
>         dtpm_cpu->cpu = cpu;
> @@ -231,6 +237,7 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
>         if (ret)
>                 goto out_dtpm_unregister;
>
> +       cpufreq_cpu_put(policy);
>         return 0;
>
>  out_dtpm_unregister:
> @@ -242,6 +249,8 @@ static int __dtpm_cpu_setup(int cpu, struct dtpm *parent)
>                 per_cpu(dtpm_per_cpu, cpu) = NULL;
>         kfree(dtpm_cpu);
>
> +release_policy:
> +       cpufreq_cpu_put(policy);
>         return ret;
>  }
>
> --

Applied as 6.7-rc material with the Cc: stable tag fixed.

Thanks!
