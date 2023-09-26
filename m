Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156477AF301
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbjIZScw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Sep 2023 14:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjIZScv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:32:51 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69619BF;
        Tue, 26 Sep 2023 11:32:45 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-57b83ff7654so229527eaf.1;
        Tue, 26 Sep 2023 11:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695753164; x=1696357964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlwH9j7aEpiUK7f0oRPeOnDbGJAgp1YU3tyVHfKNU4A=;
        b=DNLhFY6mqrQsDfd2H/OQ/Vj8cPyqAbVLPlTccG56DjjMQJEeQAa1pLpALxogwyzDG4
         Lr7O1aBPn4CbdDw+KfRfWv6rIH70v1The8YrrvNcjfpVWQbCBBuPa9GzmXVBcXHsUdH+
         1cZvaNCZgyHiBNz1DPk6B59bZ/F/6pbI9XzJ9yLd1Tih+IsL5uKJeTjFQp0Lpnp+YnBo
         s4g62i9BMGPSflsNNZDHWf7fWwI5diIvcnlg5rYu88wDs6O2JI0zRIbloU/6w2trqLB2
         JS4J9DY16Jtx+vRvuRFcxisucMoPI9Cd1N0UqYhUWCnrA17gtHB7bVxW+7wCVlWtzJyw
         6deg==
X-Gm-Message-State: AOJu0YwmQW1NS+kuu15+BsBRabQM7zCW3EZM7/EN9zn0ZFkIkmVZcdPX
        TomjFdutJIpZ/gf/vrnoejusOUG78nLw9bn1NkrgVOhrGDc=
X-Google-Smtp-Source: AGHT+IGkCPrKsFdqWq8jZ/oj/t6RoME/zkN+juTACzc6huG5ngYBInlghjmtZJ8By9wpQnHKTelq3OGcXW2KvT1VBRk=
X-Received: by 2002:a05:6870:f689:b0:1d5:f814:56a3 with SMTP id
 el9-20020a056870f68900b001d5f81456a3mr9566114oab.2.1695753164734; Tue, 26 Sep
 2023 11:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230925081139.1305766-1-lukasz.luba@arm.com> <20230925081139.1305766-4-lukasz.luba@arm.com>
In-Reply-To: <20230925081139.1305766-4-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Sep 2023 20:32:33 +0200
Message-ID: <CAJZ5v0h6AsQCrtJ1b5VoWD_=yTKC=Y0e5KqSHy5GsFt-H7NFXA@mail.gmail.com>
Subject: Re: [PATCH v4 03/18] PM: EM: Find first CPU online while updating OPP efficiency
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:11 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> The Energy Model might be updated at runtime and the energy efficiency
> for each OPP may change. Thus, there is a need to update also the
> cpufreq framework and make it aligned to the new values. In order to
> do that, use a first online CPU from the Performance Domain.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/power/energy_model.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 42486674b834..3dafdd7731c4 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -243,12 +243,19 @@ em_cpufreq_update_efficiencies(struct device *dev, struct em_perf_state *table)
>         struct em_perf_domain *pd = dev->em_pd;
>         struct cpufreq_policy *policy;
>         int found = 0;
> -       int i;
> +       int i, cpu;
>
>         if (!_is_cpu_device(dev) || !pd)
>                 return;
>
> -       policy = cpufreq_cpu_get(cpumask_first(em_span_cpus(pd)));
> +       /* Try to get a CPU which is online and in this PD */
> +       cpu = cpumask_first_and(em_span_cpus(pd), cpu_active_mask);

The comment talks about "online" and cpu_active_mask is used.  Isn't
it a bit inconsistent?

> +       if (cpu >= nr_cpu_ids) {
> +               dev_warn(dev, "EM: No online CPU for CPUFreq policy\n");
> +               return;
> +       }
> +
> +       policy = cpufreq_cpu_get(cpu);
>         if (!policy) {
>                 dev_warn(dev, "EM: Access to CPUFreq policy failed\n");
>                 return;
> --
> 2.25.1
>
