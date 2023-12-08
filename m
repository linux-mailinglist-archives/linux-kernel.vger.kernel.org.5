Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2C380AEF3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574782AbjLHVrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjLHVr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:47:29 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922C610E7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:47:35 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6d9f879f784so244983a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 13:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1702072055; x=1702676855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SynoD4CsgQ7zEfOXTEkXQ8TWW2MLXRoyTRAeaNDdrkg=;
        b=KIlg4QeU2/hWnjYLvIHPEW+1IkPr3vi4efrRTDNu/It3eQ4Z03ZmOdZ8pYfRuMXPCB
         7ZzJhJcor6XePd45KxLTqC0DjMYsa/oyJj6j2/j1tgaj3lT66p/J6Qm3poS3PsKVNPN+
         Y7LRRjwptWbA/WCRYQlKg2mf/Z/b7WwI9koj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702072055; x=1702676855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SynoD4CsgQ7zEfOXTEkXQ8TWW2MLXRoyTRAeaNDdrkg=;
        b=n31ll77L5zrol+qbE8fmuGiXe11Iy0/cZbfQcTwgYprN3f1b5OWJJ53nomFlE4q2bz
         zYX1ensFRhirF6l0O4JL8X+RoI5gTezZOCizmsoFCqcH7/vnTNxkwjjk21zrRzDY2Jjj
         qIWZf+EQecPaVsiKd/qtYB02vf4sHATqnCTwla9HTh7G+274Vht20+FPtBuPRUToiEuo
         X5JDfAdOc3lZ03ZKqoTtrbbnC+tQp1T1kt35+j7VQGOH7l2c34qKt3xpn8vuPG1P2KVT
         sPEvizSGxeod+CAEmPatxesWN+EzMxZhx3j5IJXzbVkYz/meUEP7ivIwuD5QdSltvIsG
         fZ6w==
X-Gm-Message-State: AOJu0Yxr+ZEYxCIP0d+J2jiSrOfVXArPRWiDHQKyutNa/xWq7wzLRy0u
        IdqXevRO5hLX32kKLo2E/5pX4Q==
X-Google-Smtp-Source: AGHT+IGgpRczxOrXChKNE1rZ0Da2+e/qtltzqNsYSx+tV4HvwnzQsWSdEh7gCeetOUoSQz+2dINgRg==
X-Received: by 2002:a05:6830:32a6:b0:6d9:a1c1:3ac6 with SMTP id m38-20020a05683032a600b006d9a1c13ac6mr752063ott.58.1702072054901;
        Fri, 08 Dec 2023 13:47:34 -0800 (PST)
Received: from localhost (150.254.86.34.bc.googleusercontent.com. [34.86.254.150])
        by smtp.gmail.com with ESMTPSA id v26-20020ac8729a000000b00421c31faf05sm1109403qto.1.2023.12.08.13.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:47:34 -0800 (PST)
Date:   Fri, 8 Dec 2023 21:47:33 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v5 0/7] SCHED_DEADLINE server infrastructure
Message-ID: <20231208214733.GA3448992@google.com>
References: <cover.1699095159.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699095159.git.bristot@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 11:59:17AM +0100, Daniel Bristot de Oliveira wrote:
> This is v5 of Peter's SCHED_DEADLINE server infrastructure
> implementation [1].
> 
> SCHED_DEADLINE servers can help fixing starvation issues of low priority
> tasks (e.g., SCHED_OTHER) when higher priority tasks monopolize CPU
> cycles. Today we have RT Throttling; DEADLINE servers should be able to
> replace and improve that.

Hello!
Just wanted to provide some ChromeOS data on these patches. There is
great improvement when using DL-sever along with RT for foreground Chrome's
display, audio and main threads. Once they are in the background, we set them
back to CFS (except audio). I think these patches are ready to move forward
as the data looks good to me. I see Peter picked up some of them already
which is nice.

One of the key metrics for us is event latency. We have a test that measures
various latency metrics with typing happening on a Google docs in one window
and a 16-person Google meet call happening on the other. This is a very
complex test but gets us close to what the user experiences (as is typical -
meeting attendees in a Google meet call take notes in a Google doc). As a
result, getting stable numbers requires a lot of care which is why I used
P-value to measure the statistical significance of the results. The P-value
for some metrics show lower significance, so we can ignore those but I still
provided it in the table.

The test is run on a Chromebook with 4 cores (Intel(R) Celeron(R) N4100 CPU @
1.10GHz) and 16GB of RAM. No Hyperthreading.

All units are microseconds. The average is calculated as the average of 20
runs with and without "Chrome using RT + DL-server". The 5% every 1 second
default does not work for us, so I changed the DL server parameters to 5ms
every 30ms. This allows CFS to run more often.

This test runs for 6 hours. Total test time for both before and after is 12 hours:

---------------------------------------------------------------------------------------------------------
| MetricName                                      | Average Before | Average After | Change % | P-value |
---------------------------------------------------------------------------------------------------------
| Ash.EventLatency.Core.TotalLatency              | 90.19          | 78.22         | 13.27%   | 0.03    |
---------------------------------------------------------------------------------------------------------
| Ash.EventLatency.KeyReleased.TotalLatency       | 90733.76       | 78602.72      | 13.37%   | 0.03    |
---------------------------------------------------------------------------------------------------------
| Ash.EventLatency.TotalLatency                   | 90.19          | 78.22         | 13.27%   | 0.03    |
---------------------------------------------------------------------------------------------------------
| Docs.EventLatency.KeyPressed.TotalLatency       | 68269.21       | 63310.99      | 7.26%    | 0.00    |
---------------------------------------------------------------------------------------------------------
| Docs.EventLatency.MousePressed.TotalLatency     | 192080.44      | 179264.31     | 6.67%    | 0.26    |
---------------------------------------------------------------------------------------------------------
| Docs.EventLatency.TotalLatency                  | 68795.99       | 63860.04      | 7.17%    | 0.00    |
---------------------------------------------------------------------------------------------------------
| EventLatency.GestureScrollUpdt.Wheel.TotalLat   | 63420.88       | 59394.18      | 6.35%    | 0.02    |
---------------------------------------------------------------------------------------------------------
| EventLatency.KeyPressed.TotalLatency            | 68269.21       | 63310.99      | 7.26%    | 0.00    |
---------------------------------------------------------------------------------------------------------
| EventLatency.MouseDragged.TotalLatency          | 106393.09      | 104152.50     | 2.11%    | 0.57    |
---------------------------------------------------------------------------------------------------------
| EventLatency.MouseMoved.TotalLatency            | 129225.65      | 113268.48     | 12.35%   | 0.01    |
---------------------------------------------------------------------------------------------------------
| EventLatency.MousePressed.TotalLatency          | 192080.44      | 179264.31     | 6.67%    | 0.26    |
---------------------------------------------------------------------------------------------------------
| EventLatency.MouseReleased.TotalLatency         | 152366.33      | 140309.50     | 7.91%    | 0.44    |
---------------------------------------------------------------------------------------------------------
| EventLatency.TotalLatency                       | 68795.99       | 63862.45      | 7.17%    | 0.00    |
---------------------------------------------------------------------------------------------------------
| EventLatency.TotalLatency_ash-Chrome            | 68795.99       | 63862.45      | 7.17%    | 0.00    |
---------------------------------------------------------------------------------------------------------

I also did another test where I measure the CFS maximum latency (using perf
sched) while a YouTube video is playing, and the CFS max latency looks great
too. In fact, with the vanilla RT throttling, our CFS tasks are doing really
badly (perhaps because of depending on RT tasks due to locks or such). So we
definitely need the DL-server to use RT properly!

We are testing dlserver with 5ms/50ms and 5ms/100ms as well to see the
impact. But at the moment, 5ms/30ms is looking good.

Thanks for all of your work, here's to better Linux and better Chromebooks ;)

 - Joel

