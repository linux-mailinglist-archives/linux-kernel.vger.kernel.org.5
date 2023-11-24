Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82677F69F6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 01:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjKXAuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 19:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXAuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 19:50:50 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894749A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:50:57 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2857670af8cso585813a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700787057; x=1701391857; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=piQpuYTqH+J7lxu3cwi0uq00ermNbpD/YlwWp9S3Z1M=;
        b=WUsvUW7BbQxuG9gwQgUdOsYQk1doOAhXiJFYYb88M8AZx6bgh7sixP3b3xKDpy+P5t
         zypTj6SAdn9Kgfdp81ulOUstMTMZF1gO8BakNz/pVxv2CFEG7AV2YeLUiYUHKyq6eqYh
         iDA8SIsk+18HrlK5SpQf8lWaU5lZxNE6x6ZdoiPzxznkwmizTxgxY//WQfarpoatAx8u
         xMwR0a9FawFfLWuwaItueXiZUg9jXfQlBBkr/5OnBpZYrAEYr4+uiFjWvTqrHnGMaSvL
         zuu+twquHyCy6nSQ/6dMJtehOYa0g92gJ4M/Hx7UFjjDKTRfS/+zEEWa2rfXKi5rkf47
         6EnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700787057; x=1701391857;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=piQpuYTqH+J7lxu3cwi0uq00ermNbpD/YlwWp9S3Z1M=;
        b=xDgHtGgGUTWmRnZio4dFRpXFq9y17KUyxtRmnj+Sd/UYwyxfolb38Uqyavf1EDyuz3
         fMyx07SZqjDLtOcfbx8mxXOCXp5p4z1u10+1PEsv7mpu5zXIv15kEmeKTQPjcHgrEpxU
         EJNyI6t+dzuALiEjUnuF/Z8Hb0LsAoekAS3qNIjrKr4jIs8kY2DPF9M97JKjycihVE6Y
         FFbuzhRPzYB9flL+jXRLwIyLyg5IJd0SqmIMw6lstZ4461mabEZy8bDzVA6CneQodi58
         KZ+8gX0Er/w1C+4QvhuKRw+E2olncAGQKlx6MglfKffQJermSu0iwyYFQlnVzpLWUCkj
         TDqw==
X-Gm-Message-State: AOJu0YzMyPCtAix0EQ7dXobbvgNWR00BQLjyUEqVeJ5FvbNHQemNNcSP
        ucfOP+qFC6oeyXSXnCYb7ktUlg==
X-Google-Smtp-Source: AGHT+IHJvSQSfgjEzzJTfEx6cU1dr4dQbDjvRgTV2vIwi8KvNwhQodyz/T1DMT5ifw7WkZ/EfCLTOg==
X-Received: by 2002:a17:90b:1001:b0:285:6f1a:4a71 with SMTP id gm1-20020a17090b100100b002856f1a4a71mr1025529pjb.32.1700787056706;
        Thu, 23 Nov 2023 16:50:56 -0800 (PST)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a031900b0027d0af2e9c3sm2313689pje.40.2023.11.23.16.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:50:56 -0800 (PST)
Date:   Fri, 24 Nov 2023 00:50:52 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH 1/3] perf/core: Update perf_adjust_freq_unthr_context()
Message-ID: <ZV_zbDuva31kh9IH@google.com>
References: <20231120221932.213710-1-namhyung@kernel.org>
 <CAP-5=fWFeqEK4woCj2ngjxMi4B4EZ3y0gLN+qNu4oNfp4wG8xA@mail.gmail.com>
 <ZVvqj0pR2ZebBF3L@google.com>
 <CAM9d7cgAPxyNxMTz-uoPExcg4e1h5iXCuR5ZOy7UUt5gjbd2VA@mail.gmail.com>
 <ZV024X0VKUwExQio@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZV024X0VKUwExQio@google.com>
X-Spam-Status: No, score=-16.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023, Mingwei Zhang wrote:
> On Tue, Nov 21, 2023, Namhyung Kim wrote:
> 
> 
> Hi Namhyung,
> 
> > Hi Mingwei,
> > 
> > On Mon, Nov 20, 2023 at 3:24 PM Mingwei Zhang <mizhang@google.com> wrote:
> > >
> > > On Mon, Nov 20, 2023, Ian Rogers wrote: > > > > On Mon, Nov 20, 2023 at 2:19 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > >
> > > > > It was unnecessarily disabling and enabling PMUs for each event.  It
> > > > > should be done at PMU level.  Add pmu_ctx->nr_freq counter to check it
> > > > > at each PMU.  As pmu context has separate active lists for pinned group
> > > > > and flexible group, factor out a new function to do the job.
> > > > >
> > > > > Another minor optimization is that it can skip PMUs w/ CAP_NO_INTERRUPT
> > > > > even if it needs to unthrottle sampling events.
> > > > >
> > > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > >
> > > > Series:
> > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > >
> > > Can we have "Cc: stable@vger.kernel.org" for the whole series? This
> > > series should have a great performance improvement for all VMs in which
> > > perf sampling events without specifying period.
> > 
> > I was not sure if it's ok to have this performance fix in the stable series.
> > 
> 
> Critical performance bug fix is ok to be added to stable tree, as the
> requirements are mentioned here:
> 
> https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst
> 
> In particular, this patch satisfies the 2nd sub-bullet of the forth
> bullet.
> 
> But let me step back. Only this patch is needed with stable tag instead
> of the whole series. This patch impact 69 lines of code. It satisfies
> the rule of within 100 lines (bullet 3).
> 
> I will give a try and test it today or tomorrow and make sure we satisfy
> bullet 2.
> 
> Once it gets in, bullet 1 will be satisfied as well.
> 
> Overall, the intention is to improve PMU performance in VM as early as
> we can since we don't control the schedule of distro kernel upgrade and
> we don't control when end customers upgrade their running kernel. So I
> presume even adding to the stable tree may take years to see the result
> change. But if we don't do it, it may take way longer (since it does not
> contain a "Fixes" tag as well).
> 
> Thanks.
> -Mingwei
> 

I have tested the code. Yes profiling results in the VM shows that it
removes perf_adjust_freq_unthr_contex() as the hot spot. However, when
running perf with sufficient events in frequency mode that triggers
multiplexing. The overall performance overhead still reaches 60% per
CPU (this overhead is invisible to vCPU).

At the host level, I have been monitoring the write MSRs and found that
the repeated writes to 0x38f disappeared, indicating that this patch is
indeed working. But on the other hand, I have noticed more frequent
overflows and PMIs.

The more frequent overflows is shown in the writes to MSR 0x390 and
reads to MSR 0x38e. I infer the more frequent PMIs from the much longer
execution of 'vmx_vmexit()' shown in flamegraph.

Because of the above observation, it seems to me that this patch no
longer satisfies the requirements of Ccing "stable@vger.kernel.org". I
will double check and follow up on this one.

Thanks.
-Mingwei

