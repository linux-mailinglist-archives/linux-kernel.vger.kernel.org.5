Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AAD772B63
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjHGQqv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Aug 2023 12:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjHGQqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:46:49 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76AF10DE;
        Mon,  7 Aug 2023 09:46:48 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1bc05bece1dso560009fac.1;
        Mon, 07 Aug 2023 09:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691426808; x=1692031608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cTkah9A+y0zHAsGnDn+WndtVM4Rfo0pn8/RM09YGig=;
        b=h86AVbFyP4Oz/bojwqqWvlsrTGwrhAa/20iXOW/pYIwe7rxHBGMSL6kxbClj4UA4ef
         F/pyTcKO2nfCMQ8Zs9HZhA1WFz41xwv2pvBfjQYLifOOSZTTJxfVPuVfl/1Fa1HqKL7f
         I8zLkc8g3zrDOh5KHZQF3ZrGlYA/tIfNklU+wdBugZuMKviqgPvJr8bOjevNCv7GOPW4
         o4ie+UUba571Z0Wj9CzeKzYNqK56Q6zs9fV5a3S1DQedZyim0Iwv+jgCYsF24jtsJFhE
         tkKfxVKuk4G4vo45+sVyP4o27E2gvkTQFrONEDq72a6xpsq63nPlSaKi5kI8rzMaclG4
         NkFA==
X-Gm-Message-State: ABy/qLZWmY4ER1qRWSorUUOMPQvJeArFR8LJVuovoW/TIHffHF+6sMrk
        6zMhAklOVcyeTCg4UewdLGZpjv7Zb7uHPSAqwv4=
X-Google-Smtp-Source: APBJJlHQJeYGLJWAa+24trXn3icoqVc7zTAQgWg2FFLoc77mae6UbDnZCN8ksd/IRnv93s4pmE3TqI89mAa2MmTFQAU=
X-Received: by 2002:a05:6870:d208:b0:192:6fce:d3be with SMTP id
 g8-20020a056870d20800b001926fced3bemr27399356oac.1.1691426808091; Mon, 07 Aug
 2023 09:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <5712331.DvuYhMxLoT@kreacher> <ZND5CL6Kl9RnDdhL@e126311.manchester.arm.com>
In-Reply-To: <ZND5CL6Kl9RnDdhL@e126311.manchester.arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Aug 2023 18:46:37 +0200
Message-ID: <CAJZ5v0hPHBEtkSVuB4GfTpFf9+Fs=_0=2HOeuf49bqM4NR3qeg@mail.gmail.com>
Subject: Re: [RFT][PATCH v2 0/3] cpuidle: teo: Do not check timers
 unconditionally every time
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kajetan,

On Mon, Aug 7, 2023 at 4:04 PM Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> Hi Rafael,
>
> On Thu, Aug 03, 2023 at 10:57:04PM +0200, Rafael J. Wysocki wrote:
> > Hi Folks,
> >
> > This is the second iteration of:
> >
> > https://lore.kernel.org/linux-pm/4511619.LvFx2qVVIh@kreacher/
> >
> > with an additional patch.
> >
> > There are some small modifications of patch [1/3] and the new
> > patch causes governor statistics to play a role in deciding whether
> > or not to stop the scheduler tick.
> >
> > Testing would be much appreciated!
> >
> > Thanks!
> >
>
> My test results including the v2 are below.
>
> 1. Geekbench 6
>
> +---------------------------+---------------+-----------------+-------------------+----------------------+
> |          metric           |      teo      |     teo_tick    |    teo_tick_rfc   |    teo_tick_rfc_v2   |
> +---------------------------+---------------+-----------------+-------------------+----------------------+
> |      multicore_score      | 3320.9 (0.0%) | 3303.3 (-0.53%) |  3293.6 (-0.82%)  |   3302.3 (-0.56%)    |
> |           score           | 1415.7 (0.0%) | 1417.7 (0.14%)  |  1423.4 (0.54%)   |    1425.8 (0.71%)    |
> |      CPU_total_power      | 2421.3 (0.0%) | 2429.3 (0.33%)  |  2442.2 (0.86%)   |    2461.9 (1.67%)    |
> |  latency (AsyncTask #1)   | 49.41μ (0.0%) | 51.07μ (3.36%)  |   50.1μ (1.4%)    |    50.76μ (2.73%)    |
> | latency (labs.geekbench6) | 65.63μ (0.0%) | 77.47μ (18.03%) | 55.82μ (-14.95%)  |    66.12μ (0.75%)    |
> | latency (surfaceflinger)  | 39.46μ (0.0%) | 36.94μ (-6.39%) |  35.79μ (-9.28%)  |    40.36μ (2.3%)     |
> +---------------------------+---------------+-----------------+-------------------+----------------------+
>
> +----------------------+-------------+------------+
> |         tag          |    type     | count_perc |
> +----------------------+-------------+------------+
> |         teo          |  too deep   |   2.034    |
> |       teo_tick       |  too deep   |    2.16    |
> |     teo_tick_rfc     |  too deep   |   2.071    |
> |    teo_tick_rfc_v2   |  too deep   |   2.548    |
> |         teo          | too shallow |   15.791   |
> |       teo_tick       | too shallow |   20.881   |
> |     teo_tick_rfc     | too shallow |   20.337   |
> |    teo_tick_rfc_v2   | too shallow |   19.886   |
> +----------------------+-------------+------------+
>
>
> 2. JetNews
>
> +-----------------+---------------+----------------+-----------------+-----------------+
> |     metric      |      teo      |    teo_tick    |  teo_tick_rfc   | teo_tick_rfc_v2 |
> +-----------------+---------------+----------------+-----------------+-----------------+
> |       fps       |  86.2 (0.0%)  |  86.4 (0.16%)  |  86.0 (-0.28%)  |  86.6 (0.41%)   |
> |    janks_pc     |  0.8 (0.0%)   |  0.8 (-0.66%)  |  0.8 (-1.37%)   |  0.7 (-11.37%)  |
> | CPU_total_power | 185.2 (0.0%)  | 178.2 (-3.76%) |  182.2 (-1.6%)  | 169.4 (-8.53%)  | <- very interesting
> +-----------------+---------------+----------------+-----------------+-----------------+
>
> +----------------------+-------------+--------------------+
> |         tag          |    type     |     count_perc     |
> +----------------------+-------------+--------------------+
> |         teo          |  too deep   |       0.992        |
> |       teo_tick       |  too deep   |       0.945        |
> |     teo_tick_rfc     |  too deep   |       1.035        |
> |    teo_tick_rfc_v2   |  too deep   |       1.127        |
> |         teo          | too shallow |       17.085       |
> |       teo_tick       | too shallow |       15.236       |
> |     teo_tick_rfc     | too shallow |       15.379       |
> |    teo_tick_rfc_v2   | too shallow |       15.34        |
> +----------------------+-------------+--------------------+
>
> All in all looks pretty good. Unfortunately there's a slightly larger
> percentage of too deep sleeps with the v2 (which is probably where the
> increase in GB6 power usage comes from) but the lower jank percentage +
> substantially lower power usage for the UI workload are very promising.
>
> Since we don't care about GB6 power usage as much as UI power usage, I'd
> say that the patchset looks good :)
>
> Tested-by: Kajetan Puchalski <kajetan.puchalski@arm.com>

Thanks a lot, much appreciated!
