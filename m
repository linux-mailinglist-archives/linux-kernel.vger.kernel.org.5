Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578568129D2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjLNH5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjLNH5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:57:20 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A338F11B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:57:26 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6d0a679fca7so1775226b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702540646; x=1703145446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0d8h/X+8AJFqMWZqP9wn96fliaxprL1waPmEflLUD64=;
        b=pLRY7/iPobQt8nc/XA/Lr3Uj3wYFQMDpqZMrDv9trjYqrFRNT0Qvx8xpOSwywYqmoM
         TiDc0cqFx06eUlQRG38RgSix7R4SGPrJwwuq4sJRFRBb6XOX1CwX4mXgaFHlzkFFIqV2
         jSroyziipH+xBENtpTH2Qq1/JlbHGlriL92QeWbhFeQ0fE0FH5S5Ri5NONCcmvgtU2R8
         Kw4EMwXYaSpfgyPN4qE5uw9dKjofIzbOV0kNRuvHo5Ib9qdwPb+b6uexzVTbsFSrZHpO
         DO3lxPEy+gjPu005kUYaIsk0XnroXVUM48AgoTUan0kNaRIoJMQBx4QTnn480HXAfQ67
         Z2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702540646; x=1703145446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0d8h/X+8AJFqMWZqP9wn96fliaxprL1waPmEflLUD64=;
        b=J1T1JemslAZqGd5SZ75xAn9igV1F/3RGxRtcQF2E0u4TAasDpaHvFkoQyw9CaxfvZy
         rEOrL0Zr9tpbJXLHmKkXZz3n0JvLkFKedmj25pawGEYP+rKyE6Ems1It5VSSQ7xdNih/
         GucitknMwa+K2RNrkoPuxjCfkrbGx2837o1gkUZxANhz7BKofxp47kI/NC6uusSddPcJ
         W4xncbSb/6vQltP4RXU5HbtrUtGqEjBL5HktbZqEp/ltzPO870dl5TZB6odp9QKFOvI3
         lEYjY8nDeuh1y4UdhXYTdB0zo2Z6UGBkwl/B2pRv0gxEREfscUdjXJ60VcQvpo52HZE+
         HPkQ==
X-Gm-Message-State: AOJu0YyiJxp4IhTAoApNg42uuGVhHejbxA456odikHril+x3ldtM9Qav
        CkmTKGBShBwsaKtwQr6A3UPYd8biJ58MvhnPptNShQ==
X-Google-Smtp-Source: AGHT+IH5msB4lU5jvSKJG7KJS2c617v2cRX1YY8AQGHuGj64nDRHWqiH3MAFEuK6zjh/HPsVVTafJEwFkKzRP1G3l/M=
X-Received: by 2002:a05:6a00:b8e:b0:6ce:751c:c943 with SMTP id
 g14-20020a056a000b8e00b006ce751cc943mr4858088pfj.7.1702540645901; Wed, 13 Dec
 2023 23:57:25 -0800 (PST)
MIME-Version: 1.0
References: <20231212142730.998913-1-vincent.guittot@linaro.org>
 <20231212142730.998913-2-vincent.guittot@linaro.org> <20231214054307.axl33gagxacidjbn@vireshk-i7>
In-Reply-To: <20231214054307.axl33gagxacidjbn@vireshk-i7>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 14 Dec 2023 08:57:14 +0100
Message-ID: <CAKfTPtDam5eQO1DHxALsCaU53Rtawbfrvswy+z2unnV_eXeVLA@mail.gmail.com>
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq pressure feedback for the scheduler
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
        rafael@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, lukasz.luba@arm.com,
        rui.zhang@intel.com, mhiramat@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2023 at 06:43, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 12-12-23, 15:27, Vincent Guittot wrote:
> > @@ -2618,6 +2663,9 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> >       policy->max = __resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
> >       trace_cpu_frequency_limits(policy);
> >
> > +     cpus = policy->related_cpus;
> > +     cpufreq_update_pressure(cpus, policy->max);
> > +
> >       policy->cached_target_freq = UINT_MAX;
>
> One more question, why are you doing this from cpufreq_set_policy ? If
> due to cpufreq cooling or from userspace, we end up limiting the
> maximum possible frequency, will this routine always get called ?

Yes, any update of a FREQ_QOS_MAX ends up calling cpufreq_set_policy()
to update the policy->max


>
> --
> viresh
