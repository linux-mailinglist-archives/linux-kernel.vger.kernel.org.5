Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDA47F1994
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjKTRQq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Nov 2023 12:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjKTRQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:16:44 -0500
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46655CD;
        Mon, 20 Nov 2023 09:16:40 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6cb552cf81dso194833b3a.0;
        Mon, 20 Nov 2023 09:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700500600; x=1701105400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrlyLEci4XBs3cTl1/rKqplG5QUr50JTh4pmxH9EL+M=;
        b=etjXTA7kES+jGB8FNVQ1fzgu2eSLIQRHp6dvNHgu2dJ2ID8IsmWP1EIHB6Zj0De1zE
         EWONWvyifxIHpdrlfJJ9cancNha9FTNB7Suug6FYRD9zcf2yhXBS6I2GFK7p8ABQNW35
         eI6u79Qceww2CENAjiB2P4B0Ge/Dv4lLnADuHxA0ch5etz0wsCSwKjXyIWOoykrOc6Nx
         kDHEPFTiC2HZKt/erKPUgw1iCTq5SmuqjQ+jGQ70xJYfPQoyXH1B1md11glVUVmKYCv0
         8f6zEcDfX5f7luAc/NYnXN9qEIwv59cz6iaov4PHFcE8km8s9MZzgARwMcCMXp90Or7V
         pL1A==
X-Gm-Message-State: AOJu0YzcCImZEwI0zyt3DlS/UCkMrEZ0Ry0yoSb6nEfhfDqWY8nzLcry
        a33qGaFL9D2U4Lxdl7J49Xo761zxnNRDTC6hWug=
X-Google-Smtp-Source: AGHT+IF6E944uB4eFKGxuV1kTrefp76X5NvMlqYRHmCkII6vGH5fly+fG98LZ3f/ZbvTEnssQzTcwe+qYGRAvMuyWsU=
X-Received: by 2002:a05:6a20:6f8b:b0:18a:716d:4d4 with SMTP id
 gv11-20020a056a206f8b00b0018a716d04d4mr4165573pzb.6.1700500599648; Mon, 20
 Nov 2023 09:16:39 -0800 (PST)
MIME-Version: 1.0
References: <20231107025838.2806500-1-ruanjinjie@huawei.com> <6c078e43-5dba-b980-5890-18c7b7cf7157@huawei.com>
In-Reply-To: <6c078e43-5dba-b980-5890-18c7b7cf7157@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Nov 2023 18:16:27 +0100
Message-ID: <CAJZ5v0hotAjpCOnGZLKsA+nhsRMX7hhE6ZxrPbWoc5qb8XD6BQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix CPU lowest Frequency bug when
 offline/online for passive
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, zhaowenhui8@huawei.com
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

On Mon, Nov 13, 2023 at 7:18 AM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Ping.

I see the problem, but I'm not sure if the approach taken in the patch
is the best one, as it has side effects.

> On 2023/11/7 10:58, Jinjie Ruan wrote:
> > There is a bug in passive mode for intel pstate when
> > CONFIG_X86_INTEL_PSTATE = y and configure intel_pstate = passive in command
> > line. On Ice Lake server, although the performance tuner is used, the CPU
> > have the lowest frequency in scaling_cur_freq after the CPU goes offline and
> > then goes online, running the same infinite loop load.
> >
> > How to reproduce:
> >
> > cat while_true.c
> >       #include <stdio.h>
> >       void main(void)
> >       {
> >               while(1);
> >       }
> >
> > [root@localhost freq_test]# cat test.sh
> >       #!/bin/bash
> >
> >       cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
> >       cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_governor
> >       taskset -c ${1} ./while_true &
> >       sleep 1s
> >
> >       cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
> >
> >       echo 0 > /sys/devices/system/cpu/cpu${1}/online
> >
> >       sleep 1s
> >       cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
> >
> >       sleep 1s
> >
> >       echo 1 > /sys/devices/system/cpu/cpu${1}/online
> >       cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
> >
> >       taskset -c ${1} ./while_true &
> >
> >       sleep 1s
> >       cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
> >
> >       sleep 1s
> >       cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
> >
> >       sleep 1s
> >       cat /sys/devices/system/cpu/cpu${1}/cpufreq/scaling_cur_freq
> >
> > The CPU frequency is adjusted to the minimum after offline and online:
> >
> > [root@localhost freq_test]# sh test.sh 20
> >       2300000
> >       performance
> >       2299977
> >       cat: /sys/devices/system/cpu/cpu20/cpufreq/scaling_cur_freq: Device or
> >       resource busy
> >       800000
> >       800000
> >       800000
> >       799992
> > [root@localhost freq_test]# sh test.sh 21
> >       2300000
> >       performance
> >       2300000
> >       cat: /sys/devices/system/cpu/cpu21/cpufreq/scaling_cur_freq: Device or
> >       resource busy
> >       800000
> >       800000
> >       800000
> >       800000
> >
> > As in __cpufreq_driver_target(), the cpufreq core will not call intel
> > cpufreq's target() callback if the target freq is equal with policy->cur
> > and do not set CPUFREQ_NEED_UPDATE_LIMITS flag, but the hardware also not
> > proactively keep CPU with the policy->cur frequency. So also set
> > CPUFREQ_NEED_UPDATE_LIMITS for passive mode. After applying this patch,
> > the CPU frequency is consistent as what performance tuner expected after
> > CPU offline and online as below:
> >
> > [root@localhost freq_test]# sh test.sh 20
> >       2300000
> >       performance
> >       2300000
> >       cat: /sys/devices/system/cpu/cpu20/cpufreq/scaling_cur_freq: Device or resource busy
> >       2300000
> >       2300000
> >       2299977
> >       2299977
> > [root@localhost freq_test]# sh test.sh 21
> >       2300000
> >       performance
> >       2300000
> >       cat: /sys/devices/system/cpu/cpu21/cpufreq/scaling_cur_freq: Device or resource busy
> >       2300000
> >       2300000
> >       2300000
> >       2300000
> > [root@localhost freq_test]# cat /sys/devices/system/cpu/intel_pstate/status
> >       passive
> >
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > ---
> >  drivers/cpufreq/intel_pstate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> > index a534a1f7f1ee..73403f1292b0 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -3091,7 +3091,7 @@ static int intel_cpufreq_suspend(struct cpufreq_policy *policy)
> >  }
> >
> >  static struct cpufreq_driver intel_cpufreq = {
> > -     .flags          = CPUFREQ_CONST_LOOPS,
> > +     .flags          = CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
> >       .verify         = intel_cpufreq_verify_policy,
> >       .target         = intel_cpufreq_target,
> >       .fast_switch    = intel_cpufreq_fast_switch,
