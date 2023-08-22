Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10846783FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbjHVLsZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Aug 2023 07:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbjHVLsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:48:25 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F5DCF4;
        Tue, 22 Aug 2023 04:47:57 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b9cd6876bbso1150850a34.1;
        Tue, 22 Aug 2023 04:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692704775; x=1693309575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7u+tVATkyR9TopllPsPyWrgo7wbCnZAY5KeZRAKErs=;
        b=fYBYZF+QBKTET8EU18hXhSHDRpACK/Y8laQ6cBMrjQJM7ZX/Sxo5heR8pp1HeQjIPT
         HpVPuOrVo71kmj8lkfQu/cuXr4dhSUTWfNrcJyKKI6CHnm60xqpCxteh9i38Ejd1Yg+H
         +kceec33utg8Nmc3zRsxmokDhKWR8V4iyHuq4Upks3nN8UhmQ8pfPDbIhMl8LxNM1O1d
         pjgQ4koSJO7wVPGd5OYlzhRL8aQ4QsOwhVYJF8uzKJPAvEDERtcgicfR7kMCmJsInOYj
         2+lXFPErfVxpTBUoaWgJW8W4R40aMUcZNRY/34Nyv2PZhL3efv3gUSPDkjd6/OWe1bxs
         OgRg==
X-Gm-Message-State: AOJu0YwtFGWspBTTWD0f/ZVEzwMbt3tQDqIIVOuvH1znNxHKSG5X4/GI
        Nl4jYx3qoCkzLL8JIQcq45WLzFtYVc6iB5e5eplVB/8z
X-Google-Smtp-Source: AGHT+IGWlZQ4G1HOEeubKL8xUdbNvbEszjfcNSDx8X+wo9LdrzY6RcILaZiAHAqd/iGYHo1AJ8ZpLt926DA/Tq/N9tY=
X-Received: by 2002:a4a:e741:0:b0:56e:94ed:c098 with SMTP id
 n1-20020a4ae741000000b0056e94edc098mr8769210oov.0.1692704775454; Tue, 22 Aug
 2023 04:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <001d01d9d3a7$71736f50$545a4df0$@telus.net>
In-Reply-To: <001d01d9d3a7$71736f50$545a4df0$@telus.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Aug 2023 13:46:04 +0200
Message-ID: <CAJZ5v0g=TEY0+dL9AGh1cYNnwQ=L6G8CRxXVD0AyWsaK5aDsdA@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: set stale CPU frequency to minimum
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yang.jie@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 10:46 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> The intel_pstate CPU frequency scaling driver does not
> use policy->cur and it is 0.
> When the CPU frequency is outdated arch_freq_get_on_cpu()
> will default to the nominal clock frequency when its call to
> cpufreq_quick_getpolicy_cur returns the never updated 0.
> Thus, the listed frequency might be outside of currently
> set limits. Some users are complaining about the high
> reported frequency, albeit stale, when their system is
> idle and/or it is above the reduced maximum they have set.
>
> This patch will maintain policy_cur for the intel_pstate
> driver at the current minimum CPU frequency.
>
> Reported-by: Yang Jie <yang.jie@linux.intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217597
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> ---
>
> v1 -> v2:
>    * v1 was a completely different approach, programming around
>      the issue rather than fixing it at the source.
>      reference:
>      https://patchwork.kernel.org/project/linux-pm/patch/006901d9be8c$f4439930$dccacb90$@telus.net/
>    * v2 does not fix an issue with the intel_cpufreq CPU scaling
>      driver (A.K.A. the intel_pstate driver in passive mode) and
>      the schedutil CPU frequency scaling governor when HWP is enabled
>      where limit changes are not reflected in the stale listed frequencies.
>      A fix for that will be some future patch.
>
> ---
>  drivers/cpufreq/intel_pstate.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 8ca2bce4341a..08284dee583a 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2609,6 +2609,11 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>                         intel_pstate_clear_update_util_hook(policy->cpu);
>                 intel_pstate_hwp_set(policy->cpu);
>         }
> +       /* policy current is never updated with the intel_pstate driver
> +        * but it is used as a stale frequency value. So, keep it within
> +        * limits.
> +        */
> +       policy->cur = policy->min;
>
>         mutex_unlock(&intel_pstate_limits_lock);
>
> --

Applied as 6.6 material, with some mailer-induced white space damage
fixed and the new comment adjusted to the kernel coding style.

Thanks!
