Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B8F80EB9E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346433AbjLLMXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjLLMXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:23:38 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C67C3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:23:44 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-336210c34ebso2012742f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702383822; x=1702988622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYhz0XOUOt14gyC7LrC7D+c8iRf0ZpwsoryRayowx4U=;
        b=a+EPx4/8v4diSab3QuQ7HeW6b/f8rr98gwP9e8dZqXZya5mR91zlQTCp0bLoksgi2j
         R8g7HAqfmkRhHzXAjvcjhPj0u89hAXdJJkzHtGWqwO0vAAH1oOTCySV/fkLa6Jm7ZAY/
         cw31TvheEDD6LUuDfWHspta3oLKifnEQKHZ/5FsfEP3HBf/QTW4Sp7StZBLck1fkvvqw
         Qc7Mhb0howN6vWOJ3XYepCG7VNxx1sIrJkE3RIr0lluygpLpXMkUG+jYlJmAevBrZ0PG
         7M8Bnwemn7WOlpskdY1dDPvdzwsNgoLmdArj/4/jIRHRHjuviv4VFDMU6Yt65EmQsSuF
         +EFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702383822; x=1702988622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYhz0XOUOt14gyC7LrC7D+c8iRf0ZpwsoryRayowx4U=;
        b=u6wI4bQunbmSs2DZuqJtEOnM+reDrs0/vAPGRbQ0IYJUWvKRbv+qI+jeIOoJeFg6rs
         iAwT4Y33zffutXbLEyu9ed3Pqq8Sj+DgTMmWUJVfdiV+5zLaT3FO0I6byYrZGsbxFNHG
         Ocv9d9/l0GIW4UYzPApXOI/9IUx543yGbpXTCCUSvGTBfxbaECCO60iUWbNXNHyp5fNm
         yW91xZYUoxTkfDI2draHstxl9SGsqNiD/ybvywFzRNQWbMM4fOLpzlNmzOVFV2hC77Fp
         s5kjy6+XD4VDdDQj52NiFX7ZMpnuXnNAMN9H9zD9ySL2OIqIvigUYWbw7T15MMbYGRs9
         Or+Q==
X-Gm-Message-State: AOJu0YzApibc7DiaFfPrmK1Gguk9TYqv8PSMc7X5dkC9tBKjmTliRTO9
        O7o2O9c9ccZR26Ra9qn3Ksk7Sg==
X-Google-Smtp-Source: AGHT+IEFxpriRDEi0v9aK9vmbk6+8njH5MaiygNoFKJAEbbjiErInjS6wX7ry9vE8PTEf4UTC3huIA==
X-Received: by 2002:adf:e2d1:0:b0:336:170f:9048 with SMTP id d17-20020adfe2d1000000b00336170f9048mr1565747wrj.16.1702383822412;
        Tue, 12 Dec 2023 04:23:42 -0800 (PST)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id m11-20020a056000008b00b0033332524235sm10672453wrx.82.2023.12.12.04.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 04:23:42 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:23:40 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Hongyan Xia <hongyan.xia2@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Rick Yiu <rickyiu@google.com>,
        Chung-Kai Mei <chungkai@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH 3/4] sched/schedutil: Ignore update requests for short
 running tasks
Message-ID: <20231212122340.sus7sbfqqkd4dxoh@airbuntu>
References: <20231208015242.385103-1-qyousef@layalina.io>
 <20231208015242.385103-4-qyousef@layalina.io>
 <f61a3329-4223-4995-8732-030430d19ea4@arm.com>
 <20231210222225.ukocvimws6ecgsmy@airbuntu>
 <a6c13b56-3ad9-419d-a22c-5a2e302200e0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6c13b56-3ad9-419d-a22c-5a2e302200e0@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 11:15, Hongyan Xia wrote:
> > If the rq->util_avg is 1024, then for any task that is running, the requested
> > frequency should be max. If there's a task that is capped by uclamp_max, then
> > this task should not run at max.
> > 
> > So other tasks should have run at max; why you don't want them to run at max?
> 
> Because it saves power. If there's a 1024 task capped at 300 and a true 300
> task without uclamp on the same rq, there's no need to run the CPU at more
> than 600. Running it at 1024 ignores the uclamp_max and burns battery when
> it's not needed.

To fix this problem of tasks that are not 1024 but appearing 1024 the solution
doesn't lie on how the combined tasks perf hints are treated.

Note that tasks stuck on a CPU with small capacity (due to affinity or
extremely long balance_interval) can still appear as 1024 the same way
UCLAMP_MAX induces.

> > Is it only the documentation what triggered this concern about this corner
> > case? I'm curious what have you seen.
> 
> This is not a corner case. Having a uclamp_max task and a normal task on the
> same rq is fairly common. My concern isn't the 'frequency spike' problem
> from documentation. My concern comes from benchmarks, which is
> high-frequency square waves. An occasional spike isn't worrying, but the
> square waves are.

Fairly common in practice or you synthetic test setup to trigger it? We haven't
hit this problem in practice. Again, the solution is not related to how the
performance hints are applied.

Note if you have busy tasks running and sharing the CPU, the CPU should run at
max for non capped tasks. Please differentiate between the two problems.

> 
> > So worth a fix, not related to handling performance requests for multiple
> > tasks, and not urgently needed as nothing is falling apart because of it for
> > the time being at least.
> 
> Also, I think there's still an unanswered question. If there's a 1024 task

If there's a 1024 tasks on the rq then it'd run at max frequency and the system
will be overutilized and EAS disabled and work is spread according to load.

Cheers

--
Qais Yousef

> with a uclamp_min of 300 and a 300-util task with default uclamp on the same
> rq, which currently under max aggregation switches between highest and
> lowest OPP, should we filter out the high OPP or the low one? Neither is a
> short-running task. We could designate this as a corner case (though I don't
> think so), but wouldn't it be nice if we don't have any of these problems in
> the first place?
> 
> Hongyan
