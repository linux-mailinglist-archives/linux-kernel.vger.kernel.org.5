Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBC17FC25B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345602AbjK1ORb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Nov 2023 09:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346077AbjK1OR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:17:27 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250CBD53;
        Tue, 28 Nov 2023 06:17:33 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1fa364b147dso354175fac.1;
        Tue, 28 Nov 2023 06:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701181052; x=1701785852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRGoQyo/qsOxZBEdcNrITTBVpKcTeeXC0RVRkpQMWcc=;
        b=DX+GzVg7G4cnUNM6VX53uBl46XooZGjkdqyEFVM6x9GIohl4sWNz9rDwHDpO++MStb
         npOwsQcRk+5rYVIL4oFdV6kRkTSNaKKGxJMLJo93k37K5Li4rvEU2r05pXl8jyxkHXmF
         YZ7oRzO4G1VXaXYrbknZsWtDeAzUlytaeVihNm+EtPXEp1HH9v8kRsl+FNW1rr0F9IXY
         r37Zz1D+PsGtYaHrvVBy2BW65mMdcS7/+U5Iwj1dr7r5+xoNw1HJ/700pLKiqRZQcY7v
         VZ5YONfrcUnOZNYBRSROdJDTNNQqFIBTdnhFvzO4GG/pdifP3rDbFqGZx1S552UOtSq8
         vqZw==
X-Gm-Message-State: AOJu0YzS77xrEHkXWPGZidDFYIqxyJjSXnW0+vX89+eKe2OmuqpEoo20
        XJMynQnmpcJUmZMqVvfAIfUlzV5ZX1fJ9s5Op6Smz+Rw
X-Google-Smtp-Source: AGHT+IHK5jlORTPJ4Yi2JZLbahqxmCAW3UTalor5HpTR9Edfy3RrLMPh0+L9de/6FsZfb1R4r5wSfybebBHvgi/RV+Q=
X-Received: by 2002:a05:6870:d0a:b0:1f9:5346:2121 with SMTP id
 mk10-20020a0568700d0a00b001f953462121mr16981047oab.4.1701181052390; Tue, 28
 Nov 2023 06:17:32 -0800 (PST)
MIME-Version: 1.0
References: <20231127092819.2019744-1-lukasz.luba@arm.com>
In-Reply-To: <20231127092819.2019744-1-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Nov 2023 15:17:21 +0100
Message-ID: <CAJZ5v0hun3D29w0DMgaSoaGpLNLP4dWN-mYpRHYESdFwP6iRsQ@mail.gmail.com>
Subject: Re: [PATCH] powercap: DTPM: Fix unneeded conversion to micro-Watts
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, rafael@kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 10:27 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> The Power values coming from the Energy Model are already in uW.
> The PowerCap and DTPM framework operate on uW, thus all places should
> just use the values from EM. Fix the code which left and still does
> the unneeded conversion.
>
> Fixes: ae6ccaa65038 (PM: EM: convert power field to micro-Watts precision and align drivers)
> Cc: <stable@vger.kernel.org> # v5.19+
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> Hi Daniel,
>
> I have found an issue due to the uW in the EM. My apologies for that.

No need to apologize, you are making the code better.

> I have check those with the Rockpi dev board with your DTPM module there.
> BTW, if you like to check the DTPM_devfreq there, you can apply that
> patch. It should create EM for your GPU there and setup DTPM GPU:
> https://lore.kernel.org/all/20231127081511.1911706-1-lukasz.luba@arm.com/
>
> Regards,
> Lukasz
>
>
>  drivers/powercap/dtpm_cpu.c     |  6 +-----
>  drivers/powercap/dtpm_devfreq.c | 11 +++--------
>  2 files changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
> index 2ff7717530bf..8a2f18fa3faf 100644
> --- a/drivers/powercap/dtpm_cpu.c
> +++ b/drivers/powercap/dtpm_cpu.c
> @@ -24,7 +24,6 @@
>  #include <linux/of.h>
>  #include <linux/pm_qos.h>
>  #include <linux/slab.h>
> -#include <linux/units.h>
>
>  struct dtpm_cpu {
>         struct dtpm dtpm;
> @@ -104,8 +103,7 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
>                 if (pd->table[i].frequency < freq)
>                         continue;
>
> -               return scale_pd_power_uw(pd_mask, pd->table[i].power *
> -                                        MICROWATT_PER_MILLIWATT);
> +               return scale_pd_power_uw(pd_mask, pd->table[i].power);
>         }
>
>         return 0;
> @@ -122,11 +120,9 @@ static int update_pd_power_uw(struct dtpm *dtpm)
>         nr_cpus = cpumask_weight(&cpus);
>
>         dtpm->power_min = em->table[0].power;
> -       dtpm->power_min *= MICROWATT_PER_MILLIWATT;
>         dtpm->power_min *= nr_cpus;
>
>         dtpm->power_max = em->table[em->nr_perf_states - 1].power;
> -       dtpm->power_max *= MICROWATT_PER_MILLIWATT;
>         dtpm->power_max *= nr_cpus;
>
>         return 0;
> diff --git a/drivers/powercap/dtpm_devfreq.c b/drivers/powercap/dtpm_devfreq.c
> index 91276761a31d..612c3b59dd5b 100644
> --- a/drivers/powercap/dtpm_devfreq.c
> +++ b/drivers/powercap/dtpm_devfreq.c
> @@ -39,10 +39,8 @@ static int update_pd_power_uw(struct dtpm *dtpm)
>         struct em_perf_domain *pd = em_pd_get(dev);
>
>         dtpm->power_min = pd->table[0].power;
> -       dtpm->power_min *= MICROWATT_PER_MILLIWATT;
>
>         dtpm->power_max = pd->table[pd->nr_perf_states - 1].power;
> -       dtpm->power_max *= MICROWATT_PER_MILLIWATT;
>
>         return 0;
>  }
> @@ -54,13 +52,10 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
>         struct device *dev = devfreq->dev.parent;
>         struct em_perf_domain *pd = em_pd_get(dev);
>         unsigned long freq;
> -       u64 power;
>         int i;
>
>         for (i = 0; i < pd->nr_perf_states; i++) {
> -
> -               power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
> -               if (power > power_limit)
> +               if (pd->table[i].power > power_limit)
>                         break;
>         }
>
> @@ -68,7 +63,7 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
>
>         dev_pm_qos_update_request(&dtpm_devfreq->qos_req, freq);
>
> -       power_limit = pd->table[i - 1].power * MICROWATT_PER_MILLIWATT;
> +       power_limit = pd->table[i - 1].power;
>
>         return power_limit;
>  }
> @@ -110,7 +105,7 @@ static u64 get_pd_power_uw(struct dtpm *dtpm)
>                 if (pd->table[i].frequency < freq)
>                         continue;
>
> -               power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
> +               power = pd->table[i].power;
>                 power *= status.busy_time;
>                 power >>= 10;
>
> --

Applied as 6.7-rc material, thanks!
