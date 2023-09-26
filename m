Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA047AF312
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjIZSj7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Sep 2023 14:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjIZSj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:39:58 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1495310A;
        Tue, 26 Sep 2023 11:39:52 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-57bf04841ccso220722eaf.0;
        Tue, 26 Sep 2023 11:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695753591; x=1696358391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqH8J6lTpK2M+bzzcxGFMsEPF/8uShQKGeKMcDCVBbo=;
        b=GCDwT56KQJ8gxkSbpJjcqCK+K9MVhOyCHHfgx1pRZnOhPrXEoz4diubNc8Yln70QK3
         ElnUVQjB5IIQcIlg5UlWrZlo4IdLflee39La9WLvQRPp743IJ0C5gJ6rx8MFgmOZ+nQ5
         +3MKavXPEYUCRl2s3weL4h6N9xMDXdljqJo4KfwtF0L6YDysOwzsjvvTyaraPZe2Jye+
         QrPUwbrHj6c7QMu0QjudVpuAn24+dLkqjPrH7f8nhpdz/KYz+6Gys0NFmPMefEpxvhBk
         3nMBESVRcMDb0iVKEiJZttgjDO9KCjIXnkPfEQCVAQUWa9/CZGxWcth6YH115tBTh9pu
         d3XA==
X-Gm-Message-State: AOJu0YwJBKLg6pFb9zjGbb8KOhKVZ9PcD1qVBOzFdek9Sb2xXiDpxqyS
        KAkGB0Ktge7JnybSxNs/M2erAAEcvLuxbrja138=
X-Google-Smtp-Source: AGHT+IHn5x6NKFJ0NIxGDOjTFHB3bf1b7k1LV0Mxfh9IsSJulttVCD75geLnmF+hdNPhm9REdjdLlyXid/siRCdoy7s=
X-Received: by 2002:a4a:de15:0:b0:57b:7804:9d72 with SMTP id
 y21-20020a4ade15000000b0057b78049d72mr9769263oot.1.1695753591340; Tue, 26 Sep
 2023 11:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230925081139.1305766-1-lukasz.luba@arm.com> <20230925081139.1305766-6-lukasz.luba@arm.com>
In-Reply-To: <20230925081139.1305766-6-lukasz.luba@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Sep 2023 20:39:40 +0200
Message-ID: <CAJZ5v0hyeKGuC5-jJDoxBpNksMg1cZ7eoCysjx7O8Ey1i8YSDg@mail.gmail.com>
Subject: Re: [PATCH v4 05/18] PM: EM: Refactor a new function em_compute_costs()
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
> Refactor a dedicated function which will be easier to maintain and re-use
> in future. The upcoming changes for the modifiable EM perf_state table
> will use it (instead of duplicating the code).
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

If I'm not mistaken, this patch by itself is not going to change the
observable functionality in any way and it would be good to say that
in the changelog.

This also applies to some other patches in this series.

> ---
>  kernel/power/energy_model.c | 72 ++++++++++++++++++++++---------------
>  1 file changed, 43 insertions(+), 29 deletions(-)
>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 3dafdd7731c4..7ea882401833 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -103,14 +103,52 @@ static void em_debug_create_pd(struct device *dev) {}
>  static void em_debug_remove_pd(struct device *dev) {}
>  #endif
>
> +static int em_compute_costs(struct device *dev, struct em_perf_state *table,
> +                           struct em_data_callback *cb, int nr_states,
> +                           unsigned long flags)
> +{
> +       unsigned long prev_cost = ULONG_MAX;
> +       u64 fmax;
> +       int i, ret;
> +
> +       /* Compute the cost of each performance state. */
> +       fmax = (u64) table[nr_states - 1].frequency;
> +       for (i = nr_states - 1; i >= 0; i--) {
> +               unsigned long power_res, cost;
> +
> +               if (flags & EM_PERF_DOMAIN_ARTIFICIAL) {
> +                       ret = cb->get_cost(dev, table[i].frequency, &cost);
> +                       if (ret || !cost || cost > EM_MAX_POWER) {
> +                               dev_err(dev, "EM: invalid cost %lu %d\n",
> +                                       cost, ret);
> +                               return -EINVAL;
> +                       }
> +               } else {
> +                       power_res = table[i].power;
> +                       cost = div64_u64(fmax * power_res, table[i].frequency);
> +               }
> +
> +               table[i].cost = cost;
> +
> +               if (table[i].cost >= prev_cost) {
> +                       table[i].flags = EM_PERF_STATE_INEFFICIENT;
> +                       dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
> +                               table[i].frequency);
> +               } else {
> +                       prev_cost = table[i].cost;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>                                 int nr_states, struct em_data_callback *cb,
>                                 unsigned long flags)
>  {
> -       unsigned long power, freq, prev_freq = 0, prev_cost = ULONG_MAX;
> +       unsigned long power, freq, prev_freq = 0;
>         struct em_perf_state *table;
>         int i, ret;
> -       u64 fmax;
>
>         table = kcalloc(nr_states, sizeof(*table), GFP_KERNEL);
>         if (!table)
> @@ -154,33 +192,9 @@ static int em_create_perf_table(struct device *dev, struct em_perf_domain *pd,
>                 table[i].frequency = prev_freq = freq;
>         }
>
> -       /* Compute the cost of each performance state. */
> -       fmax = (u64) table[nr_states - 1].frequency;
> -       for (i = nr_states - 1; i >= 0; i--) {
> -               unsigned long power_res, cost;
> -
> -               if (flags & EM_PERF_DOMAIN_ARTIFICIAL) {
> -                       ret = cb->get_cost(dev, table[i].frequency, &cost);
> -                       if (ret || !cost || cost > EM_MAX_POWER) {
> -                               dev_err(dev, "EM: invalid cost %lu %d\n",
> -                                       cost, ret);
> -                               goto free_ps_table;
> -                       }
> -               } else {
> -                       power_res = table[i].power;
> -                       cost = div64_u64(fmax * power_res, table[i].frequency);
> -               }
> -
> -               table[i].cost = cost;
> -
> -               if (table[i].cost >= prev_cost) {
> -                       table[i].flags = EM_PERF_STATE_INEFFICIENT;
> -                       dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
> -                               table[i].frequency);
> -               } else {
> -                       prev_cost = table[i].cost;
> -               }
> -       }
> +       ret = em_compute_costs(dev, table, cb, nr_states, flags);
> +       if (ret)
> +               goto free_ps_table;
>
>         pd->table = table;
>         pd->nr_perf_states = nr_states;
> --
> 2.25.1
>
