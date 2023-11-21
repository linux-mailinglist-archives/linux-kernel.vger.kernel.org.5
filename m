Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22E17F611B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345713AbjKWOKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345703AbjKWOKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:10:19 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E271B2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:10:26 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c887d1fb8fso11772991fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1700748624; x=1701353424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=43S2JKE+XlknJ7InMXn72r82rK7OdZlK6EXXoJcK908=;
        b=QaxrnGOPE1u1Bcz5geVkJpyyAk9FFayQKerfYtl5JPw9v8EEvs+WeooNyX/oB5lsdZ
         AxnrFHYtmPZqktmY8HByDMDGdANuNNnp0Rpai0FXCv35o6eIE7vH91Os2KoWd3HODdTe
         M/67FEYXkV+DojfdGF4gLZgd03M1t917bKN3FLFm+FIIMyoi9eUjKwQ0B/Tq9zGq1OJE
         tzEkCDwZEU8ARGMzKCALqMu3s9oGlsHw5cBnidqtZkQnK/ZJEYP24TwDcdQjIBkGv5GL
         aF470SyaNBwhWibJVE6cjdjXyfX1hhk0oKYEmv1/+YRL2a1LWuSzaXGJpuem32xJ4QWq
         YHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700748624; x=1701353424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43S2JKE+XlknJ7InMXn72r82rK7OdZlK6EXXoJcK908=;
        b=N4Jc24JcvttRMLA11EbqqACuvyJlCkeURUxpuDnoXYcEoDkLzqJDpy/gnyHLYtQCP+
         uyj3jQ1EuNxSjvFjkJxTOxP1t5raD6Dc95RpI/gESpQcsdL7XwKb4orLSrOm13dt6p4T
         aQLFcWGImXQ0u4UcpFTZ1BW4X03rYIQ/YoPJNJHe4WV4Uo4vlIElvT6T9UpqxbGzEwre
         +NklgV0owZv6jGGaWtYm+UAjo63M7a92x4PVioUigNVZxUjPigKi619c8K9IVFkLzezg
         mUxbKrlsh5PuoKk+r4fYXDiUnzr5pRIXDhijGYJfQzAbvGzkhWCf2a4cgOOp0/fn+Cjg
         m03w==
X-Gm-Message-State: AOJu0Yzjz3zD9JLP1kGSmTunT97LmDSu/Tb+kb43jG4L8gQCjT2vsuVN
        yQmQxZtyHJs+WX8pKql3sF4a4g==
X-Google-Smtp-Source: AGHT+IGR67MWtHuwOUSa+u9XjVDIwxf3b32UIItBRs2GxWoQZuo7TGo/Wf88EpY0wZmq4V317MYyOQ==
X-Received: by 2002:a2e:9842:0:b0:2c8:8025:1c8e with SMTP id e2-20020a2e9842000000b002c880251c8emr3716596ljj.17.1700748624167;
        Thu, 23 Nov 2023 06:10:24 -0800 (PST)
Received: from airbuntu (host109-151-228-202.range109-151.btcentralplus.com. [109.151.228.202])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c451100b0040b379e8526sm1386686wmo.25.2023.11.23.06.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 06:10:23 -0800 (PST)
Date:   Tue, 21 Nov 2023 23:01:50 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com
Subject: Re: [PATCH] sched/pelt: avoid underestimate of task utilization
Message-ID: <20231121230150.eq2kc72bvyn6ltur@airbuntu>
References: <20231122140119.472110-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122140119.472110-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/23 15:01, Vincent Guittot wrote:
> It has been reported that thread's util_est can significantly decrease as
> a result of sharing the CPU with other threads. The use case can be easily
> reproduced with a periodic task TA that runs 1ms and sleeps 100us.
> When the task is alone on the CPU, its max utilization and its util_est is
> around 888. If another similar task starts to run on the same CPU, TA will
> have to share the CPU runtime and its maximum utilization will decrease
> around half the CPU capacity (512) then TA's util_est will follow this new
> maximum trend which is only the result of sharing the CPU with others
> tasks. Such situation can be detected with runnable_avg wich is close or
> equal to util_avg when TA is alone but increases above util_avg when TA
> shares the CPU with other threads and wait on the runqueue.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---

So effectively if have two always running tasks on the same CPU their util_est
will converge to 1024 instead of 512 now, right?

I guess this is more accurate, yes. And I think this will hit the same
limitation we can hit with uclamp_max. If for example there are two tasks that
are 650 if they run alone, they would appear as 1024 now (instead of 512) if
they share the CPU because combined running there will be no idle time on the
CPU and appear like always running tasks, I think.

If I got it right, I think this should not be a problem in practice because the
only reason these two tasks will be stuck on the same CPU is because the load
balancer can't do anything about it to spread them; which indicates the system
must be busy anyway. Once there's more idle time elsewhere, they should be
spread and converge to 650 again.

Not my forte, but LGTM anyway.


Cheers

--
Qais Yousef
