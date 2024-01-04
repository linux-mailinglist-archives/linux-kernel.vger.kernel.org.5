Return-Path: <linux-kernel+bounces-17186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B121F82494C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603522856CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C9A2C681;
	Thu,  4 Jan 2024 19:56:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1A62C687;
	Thu,  4 Jan 2024 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59584f41f1eso108890eaf.1;
        Thu, 04 Jan 2024 11:56:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704398166; x=1705002966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+jZOMYAlf7is9OHtTiWtxt9LBNlP0KIxoNuDCX7eGw=;
        b=ka00fHg+gGnSMHt2MpAkqo0lvwXLkCReX9Ev8mKJungOXAUyz1L4/c7qh83wBJX85x
         NBsAfVkgRVtFhMEtOl6se6dm7fnjFLrTK8HJG+0sUOaf0b7PExJIuU/UwK6x9I6kb4Vl
         t2FKLsqFBWl77O0FdxFykIDlb2qphrEAjrFZ73MOCgh//RTIAVUCaeysc/QlU5Q4cwec
         OpRG9kCHtP7pAPh2Ti3CrnQ8IlphX5TrPMscyXvswpKp6RtJZNiCWcXGUmYdhNqbpfnw
         bLL8xPKG01rn9c6uMkt5GfzBu6CccCjsUjDCZpl9iHWxkQqLqv1c9/F21B8H2BoP12UD
         2UXg==
X-Gm-Message-State: AOJu0Yxr/hi8rEGKiWa6YAevG8rng5ucEKKGPHBuLeBOPudvVZ3AsGiT
	QufCy9wd2UX7mSRq0zdSSTLqSjv0rw6vzwpMBJ8=
X-Google-Smtp-Source: AGHT+IG8OOImNU59uiRw+dioLdXaq3scpbPnYlmlcGZOXofWISN5bID2e4BhtsEaYG+tgevyRhzLzz4PMn0E9Iojwi8=
X-Received: by 2002:a4a:ea90:0:b0:595:6028:d8cb with SMTP id
 r16-20020a4aea90000000b005956028d8cbmr2188042ooh.0.1704398165812; Thu, 04 Jan
 2024 11:56:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104171553.2080674-1-lukasz.luba@arm.com> <20240104171553.2080674-13-lukasz.luba@arm.com>
In-Reply-To: <20240104171553.2080674-13-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Jan 2024 20:55:54 +0100
Message-ID: <CAJZ5v0g9nEis2Bcvygn70vAT=iifHisZ_7_T4PcmQSU_=_Ymgg@mail.gmail.com>
Subject: Re: [PATCH v6 12/23] PM: EM: Add helpers to read under RCU lock the
 EM table
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org, 
	dietmar.eggemann@arm.com, rui.zhang@intel.com, amit.kucheria@verdurent.com, 
	amit.kachhap@gmail.com, daniel.lezcano@linaro.org, viresh.kumar@linaro.org, 
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, 
	wvw@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 6:15=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
> To use the runtime modifiable EM table there is a need to use RCU
> read locking properly. Add helper functions for the device drivers and
> frameworks to make sure it's done properly.
>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  include/linux/energy_model.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index f33257ed83fd..cfaf5d8b1aad 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -338,6 +338,20 @@ static inline int em_pd_nr_perf_states(struct em_per=
f_domain *pd)
>         return pd->nr_perf_states;
>  }
>
> +static inline struct em_perf_state *em_get_table(struct em_perf_domain *=
pd)
> +{
> +       struct em_perf_table __rcu *table;
> +
> +       rcu_read_lock();
> +       table =3D rcu_dereference(pd->em_table);
> +       return table->state;
> +}
> +
> +static inline void em_put_table(void)
> +{
> +       rcu_read_unlock();
> +}

The lack of symmetry between em_get_table() and em_put_table() is kind
of confusing.

I don't really like these wrappers.

IMO it would be better to use rcu_read_lock()/rcu_read_unlock()
directly everywhere they are needed and there can be a wrapper around
rcu_dereference(pd->em_table), something like

static inline struct em_perf_state *em_perf_state_from_pd(struct
em_perf_domain *pd)
{
        return rcu_dereference(pd->em_table)->state;
}

> +
>  #else
>  struct em_data_callback {};
>  #define EM_ADV_DATA_CB(_active_power_cb, _cost_cb) { }
> @@ -384,6 +398,11 @@ int em_dev_update_perf_domain(struct device *dev,
>  {
>         return -EINVAL;
>  }
> +static inline struct em_perf_state *em_get_table(struct em_perf_domain *=
pd)
> +{
> +       return NULL;
> +}
> +static inline void em_put_table(void) {}
>  #endif
>
>  #endif
> --

