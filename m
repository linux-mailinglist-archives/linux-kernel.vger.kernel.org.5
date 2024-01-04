Return-Path: <linux-kernel+bounces-17141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAEA8248D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFAAA1C22718
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776062C19C;
	Thu,  4 Jan 2024 19:16:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75D52C18C;
	Thu,  4 Jan 2024 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5962dd690d3so37657eaf.0;
        Thu, 04 Jan 2024 11:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704395767; x=1705000567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t00RBDrtTyl0DfdRD/pORXC3D/0so4Mo4Rl4fO0OIVo=;
        b=GFelVZVVgBkk6Jymfgm8lIkLxoOIsuNlhkC/FobzC3t+pEY/AlVQxgmZVDr1jGP0CV
         nXbgcWbDeWBN/i/MDcBd3LaA/lZoo+FyBeJA00kNAGz56m58S2mFxQ1xSpaM64hgq6di
         LulvM7DCiR4Bup08GM7QoliL9evj7TbBq0IIy+OG7W1j/HVpOkaWJf5Q1eSlCHSeNxfb
         0zPikVsx+XKyx13p2venYXlX8z4u3b+Iohu9o/shbE45iuxZw1Bre+Vu/vAQ+RvWCPGr
         JNgvsBkWWTR69AZkFz9plBydp2smXjcnmEUXIaCu8lT4eMkinp3ljWeWRZySOulDgTEi
         La6A==
X-Gm-Message-State: AOJu0YwsKFRpgroBpxbZs8ngd5q9iOuFb9YFgAyQUHWGOVx+5DWusOFL
	k3N/aHFOyxknLrE+fMZ/grvryP1LCYiGxaXN/Gg=
X-Google-Smtp-Source: AGHT+IG5JZvfneOXQ56b0CCdpviJzF2lPNh5VMuPb5X6o7xTWMYyLsmntyRo7Lq0ldtLzXIUvRYk/h0CsqebUB3YVHc=
X-Received: by 2002:a4a:ea90:0:b0:595:6028:d8cb with SMTP id
 r16-20020a4aea90000000b005956028d8cbmr2095008ooh.0.1704395767584; Thu, 04 Jan
 2024 11:16:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104171553.2080674-1-lukasz.luba@arm.com> <20240104171553.2080674-6-lukasz.luba@arm.com>
In-Reply-To: <20240104171553.2080674-6-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Jan 2024 20:15:56 +0100
Message-ID: <CAJZ5v0ij2aMzzhC3Ur0y0LSdnT0TypeH0DGSnsUPaxm6bDXcXw@mail.gmail.com>
Subject: Re: [PATCH v6 05/23] PM: EM: Refactor a new function em_compute_costs()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org, 
	dietmar.eggemann@arm.com, rui.zhang@intel.com, amit.kucheria@verdurent.com, 
	amit.kachhap@gmail.com, daniel.lezcano@linaro.org, viresh.kumar@linaro.org, 
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, 
	wvw@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here, I would say "Introduce em_compute_costs()" in the subject and then ->

On Thu, Jan 4, 2024 at 6:15=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
> Refactor a dedicated function which will be easier to maintain and re-use

-> "Move the EM costs computation code into a new dedicated function,
em_compute_costs(), that can be reused in other places in the future."

> in future. The upcoming changes for the modifiable EM perf_state table
> will use it (instead of duplicating the code).
>
> This change is not expected to alter the general functionality.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/power/energy_model.c | 72 ++++++++++++++++++++++---------------
>  1 file changed, 43 insertions(+), 29 deletions(-)
>
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index aa7c89f9e115..3bea930410c6 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c
> @@ -103,14 +103,52 @@ static void em_debug_create_pd(struct device *dev) =
{}
>  static void em_debug_remove_pd(struct device *dev) {}
>  #endif
>
> +static int em_compute_costs(struct device *dev, struct em_perf_state *ta=
ble,
> +                           struct em_data_callback *cb, int nr_states,
> +                           unsigned long flags)
> +{
> +       unsigned long prev_cost =3D ULONG_MAX;
> +       u64 fmax;
> +       int i, ret;
> +
> +       /* Compute the cost of each performance state. */
> +       fmax =3D (u64) table[nr_states - 1].frequency;
> +       for (i =3D nr_states - 1; i >=3D 0; i--) {
> +               unsigned long power_res, cost;
> +
> +               if (flags & EM_PERF_DOMAIN_ARTIFICIAL) {
> +                       ret =3D cb->get_cost(dev, table[i].frequency, &co=
st);
> +                       if (ret || !cost || cost > EM_MAX_POWER) {
> +                               dev_err(dev, "EM: invalid cost %lu %d\n",
> +                                       cost, ret);
> +                               return -EINVAL;
> +                       }
> +               } else {
> +                       power_res =3D table[i].power;
> +                       cost =3D div64_u64(fmax * power_res, table[i].fre=
quency);
> +               }
> +
> +               table[i].cost =3D cost;
> +
> +               if (table[i].cost >=3D prev_cost) {
> +                       table[i].flags =3D EM_PERF_STATE_INEFFICIENT;
> +                       dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
> +                               table[i].frequency);
> +               } else {
> +                       prev_cost =3D table[i].cost;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int em_create_perf_table(struct device *dev, struct em_perf_domai=
n *pd,
>                                 int nr_states, struct em_data_callback *c=
b,
>                                 unsigned long flags)
>  {
> -       unsigned long power, freq, prev_freq =3D 0, prev_cost =3D ULONG_M=
AX;
> +       unsigned long power, freq, prev_freq =3D 0;
>         struct em_perf_state *table;
>         int i, ret;
> -       u64 fmax;
>
>         table =3D kcalloc(nr_states, sizeof(*table), GFP_KERNEL);
>         if (!table)
> @@ -154,33 +192,9 @@ static int em_create_perf_table(struct device *dev, =
struct em_perf_domain *pd,
>                 table[i].frequency =3D prev_freq =3D freq;
>         }
>
> -       /* Compute the cost of each performance state. */
> -       fmax =3D (u64) table[nr_states - 1].frequency;
> -       for (i =3D nr_states - 1; i >=3D 0; i--) {
> -               unsigned long power_res, cost;
> -
> -               if (flags & EM_PERF_DOMAIN_ARTIFICIAL) {
> -                       ret =3D cb->get_cost(dev, table[i].frequency, &co=
st);
> -                       if (ret || !cost || cost > EM_MAX_POWER) {
> -                               dev_err(dev, "EM: invalid cost %lu %d\n",
> -                                       cost, ret);
> -                               goto free_ps_table;
> -                       }
> -               } else {
> -                       power_res =3D table[i].power;
> -                       cost =3D div64_u64(fmax * power_res, table[i].fre=
quency);
> -               }
> -
> -               table[i].cost =3D cost;
> -
> -               if (table[i].cost >=3D prev_cost) {
> -                       table[i].flags =3D EM_PERF_STATE_INEFFICIENT;
> -                       dev_dbg(dev, "EM: OPP:%lu is inefficient\n",
> -                               table[i].frequency);
> -               } else {
> -                       prev_cost =3D table[i].cost;
> -               }
> -       }
> +       ret =3D em_compute_costs(dev, table, cb, nr_states, flags);
> +       if (ret)
> +               goto free_ps_table;
>
>         pd->table =3D table;
>         pd->nr_perf_states =3D nr_states;
> --
> 2.25.1
>

