Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8EE812C37
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443471AbjLNJkl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Dec 2023 04:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbjLNJkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:40:35 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63ED2127;
        Thu, 14 Dec 2023 01:40:41 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6d9db2f1ddfso1264409a34.0;
        Thu, 14 Dec 2023 01:40:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702546840; x=1703151640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1OZx1A3Thw17UWY5/qaKbogEfyh83NOJGFEXrtiXrE=;
        b=WIFVJjQRw7nVqUy4zaojWvKTi/iCqJ5zS69Q5sxAlC1nhPOfTJEkSpTWawsKJZNBBf
         gX9hN/oHRCzu0HUW1HfzK5aN/3mC3ndVTYyBnJJoO4+xfaEIyobkTAlB08L7yQCt7Lks
         wF/Tc+uSK/GPuqpsJe8XYPI6UHgVmSQlsWeaxN869lta71kXbsB/FTqx7CSLqFuFlRQi
         a3naNAo2wUMT2lzMuOhpJKaI+bN9dAZvd8SvB4K2NgZuc+HKOx0hK7bMopbhJsw3ckSe
         PNL5yLq3VS2qj/NNV9Jg9tXFCATiNdBHY/XU80ginIuOaprDjgwzyTSmdAyFjwWACBGM
         u/jg==
X-Gm-Message-State: AOJu0YyLpR04YY3OR1pyCZ2AVK6BnHa5Uqq+Jkua7F6L46YVeUtE+9xr
        nhHzzfErC8JNKsf1ZopvHeKspmz9r9NF6gLdjJ0=
X-Google-Smtp-Source: AGHT+IGHUduXQcHD2O5Tng3Q5UnNHqP8yiF83sJrBsdRPOlYb/JA4vb81uPB/5nIxcAvk34aTsUzHaD4Afvhx3kow3s=
X-Received: by 2002:a05:6871:2284:b0:1fb:648:5207 with SMTP id
 sd4-20020a056871228400b001fb06485207mr17709011oab.2.1702546840564; Thu, 14
 Dec 2023 01:40:40 -0800 (PST)
MIME-Version: 1.0
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
 <20231212142730.998913-2-vincent.guittot@linaro.org> <20231214054307.axl33gagxacidjbn@vireshk-i7>
 <CAKfTPtDam5eQO1DHxALsCaU53Rtawbfrvswy+z2unnV_eXeVLA@mail.gmail.com> <54f3b98c-1f7d-4205-9e3c-a4a19ad3d941@arm.com>
In-Reply-To: <54f3b98c-1f7d-4205-9e3c-a4a19ad3d941@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Dec 2023 10:40:28 +0100
Message-ID: <CAJZ5v0gD-utGhM3vN7JmPia1CVcSQa6RPnk2xMBXXc6asRTn=g@mail.gmail.com>
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq pressure feedback for the scheduler
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
        rafael@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, rui.zhang@intel.com,
        mhiramat@kernel.org, daniel.lezcano@linaro.org,
        amit.kachhap@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-trace-kernel@vger.kernel.org
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

On Thu, Dec 14, 2023 at 10:07 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> On 12/14/23 07:57, Vincent Guittot wrote:
> > On Thu, 14 Dec 2023 at 06:43, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >>
> >> On 12-12-23, 15:27, Vincent Guittot wrote:
> >>> @@ -2618,6 +2663,9 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> >>>        policy->max = __resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
> >>>        trace_cpu_frequency_limits(policy);
> >>>
> >>> +     cpus = policy->related_cpus;
> >>> +     cpufreq_update_pressure(cpus, policy->max);
> >>> +
> >>>        policy->cached_target_freq = UINT_MAX;
> >>
> >> One more question, why are you doing this from cpufreq_set_policy ? If
> >> due to cpufreq cooling or from userspace, we end up limiting the
> >> maximum possible frequency, will this routine always get called ?
> >
> > Yes, any update of a FREQ_QOS_MAX ends up calling cpufreq_set_policy()
> > to update the policy->max
> >
>
> Agree, cpufreq sysfs scaling_max_freq is also important to handle
> in this new design. Currently we don't reflect that as reduced CPU
> capacity in the scheduler. There was discussion when I proposed to feed
> that CPU frequency reduction into thermal_pressure [1].
>
> The same applies for the DTPM which is missing currently the proper
> impact to the CPU reduced capacity in the scheduler.
>
> IMHO any limit set into FREQ_QOS_MAX should be visible in this
> new design of capacity reduction signaling.
>
> [1] https://lore.kernel.org/lkml/20220930094821.31665-2-lukasz.luba@arm.com/

Actually, freq_qos_read_value(&policy->constraints, FREQ_QOS_MAX) will
return the requisite limit.
