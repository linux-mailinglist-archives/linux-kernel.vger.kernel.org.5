Return-Path: <linux-kernel+bounces-87339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 785D286D306
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0BA1F24D55
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777A413C9E1;
	Thu, 29 Feb 2024 19:23:37 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983FC2E3E1;
	Thu, 29 Feb 2024 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709234617; cv=none; b=i5kLBKAY5SX7cuhB3C2yXICaRj2n7Yk5aIU46m9aYKJh514eZ8CzOWtTx5smUrWwgRvaj39ACPGEthO++e93Vx/N8OUn0yTmFrASWGsjKQfOn0Ikfukl8V4D87BekvlaBg1H+YCAWU5JPEb9ihnVoXY96EUQgfLO0AJNCC7llv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709234617; c=relaxed/simple;
	bh=NS5lvKFQMunOW+vtSdt7RNYSiDnH4Z9HphPa0V7EW9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6hNjgaxn3VeEByrP1mi+MZmYuHipRyBuGFJ5V/q0uU5aPhPEUCZK1tZ8+GXVur7VhYJXTu6lGJDIb5CI8ve25I0YiN5gycv5j0xETCc5aj7EPQWMDtvhSsIciLffldGANPp1SHxa159eVqZ2Pzbri35zvu/miklBbV6EiQeBrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e45f7c63f4so174351a34.1;
        Thu, 29 Feb 2024 11:23:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709234614; x=1709839414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6NaLatfJwhBBr41fUTowNr9UwPZsNeg9XIMkONoPug=;
        b=pew2mhRbBhq7UfxYz7QBo4nMg+Mxv6W7kqOx57ER4Sj3Ff/MJFlj3NVGM6yTvWLei+
         uBYb9QhiWh+atUwVlnDiKBeqLMd/CkrS3oH2SxUZCWl+XW139N/lPg24tiZQQedvljsz
         ueVnA89PmzzDejMwXL0tPPZpyI3Dl3iQCM1WwZQ00hM/e2N5GuPNn68DsgS5QIbOaNyS
         BzMp/npQ6IPdfnvKAYdTGzOkmq1hZ0q0fQdnznP9rGXc71j3Cqffav5JOyGK/oMxWfcj
         IuoiIaL5nb0rllcJq0y7fubQ31Vxs61ZOKLsLYlK2LbCixPSB4H3AqR9DeTXDsJwCsSe
         JNgg==
X-Forwarded-Encrypted: i=1; AJvYcCWrPFhCUzC7jZSUCCVMyh48kHNG8K5zLl36Avb35mEAGsreVZI97ddxbc7Y0pZ7UytMQC8ncnt1ElWMqFIQQyzn6lnQVP2Mf0AxO6hS7vlbODeKkE1agCInVTsX41/EIdJr0vZHUYsGhzBDm4Mi0PgkJ6T8u3fVST+uXc+ZEGU=
X-Gm-Message-State: AOJu0YwKdjkpDIiLaemgt8HQJ1H2CTdcF/nCS7g1ggJZhxnKFG05hj47
	U7Il9cg7STFxTD32l1GxGlo7bkaChJIHWPUcyXR3556vn8kkuRc7RkS6LG6ydtsbv6BczI8fIpS
	PrQPHSAuebO98SL1tm/E9CWzvL3Y=
X-Google-Smtp-Source: AGHT+IFQvMsUReVhmZCvjt+VFT+sy7+vvELvnQ0LsSe8RZiBYiJkUTGj2VHnPsyJPeoQc6rs8cwJvOz6Ko0bpTGnYsQ=
X-Received: by 2002:a4a:a543:0:b0:5a0:ec66:b56b with SMTP id
 s3-20020a4aa543000000b005a0ec66b56bmr2200040oom.0.1709234614722; Thu, 29 Feb
 2024 11:23:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227091351.1144757-1-quic_kshivnan@quicinc.com>
In-Reply-To: <20240227091351.1144757-1-quic_kshivnan@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Feb 2024 20:23:23 +0100
Message-ID: <CAJZ5v0i_XYYxJpg9VFyFOj2VfEVeAknuLs=c6sRyVSj9qs+Hmw@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: Limit resolving a frequency to policy min/max
To: Shivnandan Kumar <quic_kshivnan@quicinc.com>
Cc: rafael@kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, 
	Vincent Donnefort <vincent.donnefort@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com, 
	quic_namajain@quicinc.com, quic_rgottimu@quicinc.com, 
	kernel <kernel@quicinc.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:15=E2=80=AFAM Shivnandan Kumar
<quic_kshivnan@quicinc.com> wrote:
>
> Resolving a frequency to an efficient one should not transgress policy->m=
ax
> (which can be set for thermal reason) and policy->min. Currently there is
> possibility where scaling_cur_freq can exceed scaling_max_freq when
> scaling_max_freq is inefficient frequency. Add additional check to ensure
> that resolving a frequency will respect policy->min/max.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 1f39fa0dccff ("cpufreq: Introducing CPUFREQ_RELATION_E")
> Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> --
>
> Changes in v2:
> -rename function name from cpufreq_table_index_is_in_limits to cpufreq_is=
_in_limits
> -remove redundant outer parenthesis in return statement
> -Make comment single line
>
> --
> ---
>  include/linux/cpufreq.h | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index afda5f24d3dd..7741244dee6e 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1021,6 +1021,19 @@ static inline int cpufreq_table_find_index_c(struc=
t cpufreq_policy *policy,
>                                                    efficiencies);
>  }
>
> +static inline bool cpufreq_is_in_limits(struct cpufreq_policy *policy,
> +                                                   int idx)
> +{
> +       unsigned int freq;
> +
> +       if (idx < 0)
> +               return false;
> +
> +       freq =3D policy->freq_table[idx].frequency;
> +
> +       return freq =3D=3D clamp_val(freq, policy->min, policy->max);
> +}
> +
>  static inline int cpufreq_frequency_table_target(struct cpufreq_policy *=
policy,
>                                                  unsigned int target_freq=
,
>                                                  unsigned int relation)
> @@ -1054,7 +1067,8 @@ static inline int cpufreq_frequency_table_target(st=
ruct cpufreq_policy *policy,
>                 return 0;
>         }
>
> -       if (idx < 0 && efficiencies) {
> +       /* Limit frequency index to honor policy->min/max */
> +       if (!cpufreq_is_in_limits(policy, idx) && efficiencies) {
>                 efficiencies =3D false;
>                 goto retry;
>         }
> --

Applied (with a whitespace adjustment and changelog edits) as 6.9
material, thanks!

