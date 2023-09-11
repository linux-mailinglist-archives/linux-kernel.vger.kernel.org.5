Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D1479C079
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345164AbjIKVPq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Sep 2023 17:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243919AbjIKSUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:20:19 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2565B110;
        Mon, 11 Sep 2023 11:20:14 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-56cae50792fso360977eaf.1;
        Mon, 11 Sep 2023 11:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694456413; x=1695061213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aevlgErgu6FzdtarTR4nASHCQw9tTbRMLCKzIvm0UPo=;
        b=EzI7xfdZ098cEH9SKpkItWnG1OsPvrDpJF5tA4hHyzSLuono3ZgQKwxTaIwSHnVO8x
         ZXNoxgjbn9QBGs+CeUvayleP01h9H+lwyuQOyUo79yv2D8//aC0FAju+ZznmVdNQk3Me
         m36k9cdhDEEQC1rVdgfCEo9+xiLealfowIlAAUinCNnan86nAZwE6naLSOc81OBVt6iZ
         u07Pbr1VzVeYnknZZr2mJX5DYcsiZrtdbaKNJF9eCntdimtGk3yKNrpQlKr+NbGwKofj
         xzOXtjf69Xky2EZK+L03pluxcRbIGuYGG7isGnyDp+1yZNw/jORUKoE5LdfQGiD6/AyN
         m5IQ==
X-Gm-Message-State: AOJu0Yz6BvASBoakrmvlneY+nZXa8ssc8MxL+I7EtONO5ves1isiecd3
        f3LUn67IphtPLoZDsGxphhbrgbXzYLU0/iX8uJg=
X-Google-Smtp-Source: AGHT+IGE2PHWPFPgDhP65oUUA8UCMPLu8awoRWAcKlrrqlu+Dp4ZWFkuPM/QouFfqpSHwDeHxo6hsjo77wGBQzNCx0Y=
X-Received: by 2002:a05:6870:70a6:b0:1bb:724f:2bca with SMTP id
 v38-20020a05687070a600b001bb724f2bcamr10790127oae.1.1694456413283; Mon, 11
 Sep 2023 11:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230907180207.3274207-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20230907180207.3274207-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Sep 2023 20:20:02 +0200
Message-ID: <CAJZ5v0jDXrhpQi1496Hspj3-_-EhT8dDcnG5vx1bJn+4FugUWw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix global turbo disable check
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, lenb@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Sep 7, 2023 at 8:02 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Setting global turbo flag based on CPU 0 P-state limits is problematic
> as it limits max P-state request on every CPU on the system just based
> on its P-state limits.
>
> There are two cases in which global.turbo_disabled flag is set:
> - When the MSR_IA32_MISC_ENABLE_TURBO_DISABLE bit is set to 1
> in the MSR MSR_IA32_MISC_ENABLE. This bit can be only changed by
> the system BIOS before power up.
> - When the max non turbo P-state is same as max turbo P-state for CPU 0.
>
> The second check is not a valid to decide global turbo state based on
> the CPU 0. CPU 0 max turbo P-state can be same as max non turbo P-state,
> but for other CPUs this may not be true.
>
> There is no guarantee that max P-state limits are same for every CPU. This
> is possible that during fusing max P-state for a CPU is constrained. Also
> with the Intel Speed Select performance profile, CPU 0 may not be present
> in all profiles. In this case the max non turbo and turbo P-state can be
> set to the lowest possible P-state by the hardware when switched to
> such profile. Since max non turbo and turbo P-state is same,
> global.turbo_disabled flag will be set.
>
> Once global.turbo_disabled is set, any scaling max and min frequency
> update for any CPU will result in its max P-state constrained to the max
> non turbo P-state.
>
> Hence remove the check of max non turbo P-state equal to max turbo P-state
> of CPU 0 to set global turbo disabled flag.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index dc50c9fb488d..a534a1f7f1ee 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -571,13 +571,9 @@ static void intel_pstate_hybrid_hwp_adjust(struct cpudata *cpu)
>  static inline void update_turbo_state(void)
>  {
>         u64 misc_en;
> -       struct cpudata *cpu;
>
> -       cpu = all_cpu_data[0];
>         rdmsrl(MSR_IA32_MISC_ENABLE, misc_en);
> -       global.turbo_disabled =
> -               (misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE ||
> -                cpu->pstate.max_pstate == cpu->pstate.turbo_pstate);
> +       global.turbo_disabled = misc_en & MSR_IA32_MISC_ENABLE_TURBO_DISABLE;
>  }
>
>  static int min_perf_pct_min(void)
> --

Applied as 6.7 material (under a slightly modified subject), thanks!
