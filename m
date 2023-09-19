Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4367A6E59
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 00:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjISWIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 18:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbjISWIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:08:15 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACCEE6E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 15:07:25 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-404571cbb8dso65699605e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 15:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1695161231; x=1695766031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OBWyasyS//mUZkFAg8BJklLjd7VbvkVj1f9q0K/z6IU=;
        b=qbQxj5JdlVnPWHb8AteFFzIRMYRN4avNoURX9xRC97SWl8BPb2pr9aJ+3kLOsyfPwj
         zDv+skJ65cjAC7AIXQStBKBAG1ztm2AV9DEX9uSH09KO9JLsqTf0RHYrSrmaXo08rzpv
         4zGt68umN7CapGo68nrr2TClpIEMacFzsiaiWjMEoqkO9NMtkQd1/267YaUjo9XwlDC5
         c9VAE1vA9uXax0Q0b/TH8lZ3nBy1TnwNUdzMG2mUuf5oZp4p590Hm9Jfe+LpruzvYc0K
         /9nONHcdi0BBZHoqMR606m0HDaeAU3crYzlKgreMraTOFrxWKKRpM2f3TyNnFYAjQQhE
         k4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695161231; x=1695766031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBWyasyS//mUZkFAg8BJklLjd7VbvkVj1f9q0K/z6IU=;
        b=aSHofwXT9wp4Xg9bpJo54GsWYaPDIsbi4jN4AkIZuXocY9eSekWfxTaqUzHIA5Z41J
         0q13tcXJHQL1LlMlpZPgjRdJVvBvID55jZig9oEMd3j6wHpFLQeBkO3ABxU6LuOOoj9K
         QGBnLuQwkVUPvygAM1e7TqNJaoIjlUuJOmt/v8+7/B4zu/E3Iso1Vuz7I3oavbUW8cf7
         y0mqPGf/+rorwJ/9K/5SaMVhrv3nNe97dMdBebWMcs7S+Y4P6PouV0EcBykNio+Rw8xh
         L51sYUf/4bZWcQw67uQrMy7be0ddWTSpXskEUpUeWvaV+XnIiPlLEnfVaBe1vuyfIJpg
         H56Q==
X-Gm-Message-State: AOJu0YwYDJM7xlzrnMSOYC5z4CHFbzTL2xPeIYeoUtn6qrSAdWUelHJ/
        XU89mZAfcQ8phDyxA72br3lNXw==
X-Google-Smtp-Source: AGHT+IH0FJ/B8R83PqaZsEoh7x5qS4tlTWMnMvo1w7wJgo/L8wPe2fwvOoVyA20XLbvxME1vXNPeOg==
X-Received: by 2002:a7b:ce88:0:b0:401:b53e:6c39 with SMTP id q8-20020a7bce88000000b00401b53e6c39mr924743wmj.6.1695161230949;
        Tue, 19 Sep 2023 15:07:10 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id 23-20020a05600c025700b004047f3b73f9sm186040wmj.21.2023.09.19.15.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 15:07:10 -0700 (PDT)
Date:   Tue, 19 Sep 2023 23:07:08 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de,
        daniel.m.jordan@oracle.com
Subject: Re: [PATCH 2/2] sched/eevdf: Use sched_attr::sched_runtime to set
 request/slice suggestion
Message-ID: <20230919220708.l2llt2f5xullxzzz@airbuntu>
References: <20230915124354.416936110@noisy.programming.kicks-ass.net>
 <20230915124822.956946622@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230915124822.956946622@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/15/23 14:43, peterz@infradead.org wrote:
> Allow applications to directly set a suggested request/slice length using
> sched_attr::sched_runtime.

I'm probably as eternally confused as ever, but is this going to be the latency
hint too? I find it hard to correlate runtime to latency if it is.

> 
> The implementation clamps the value to: 0.1[ms] <= slice <= 100[ms]
> which is 1/10 the size of HZ=1000 and 10 times the size of HZ=100.
> 
> Applications should strive to use their periodic runtime at a high
> confidence interval (95%+) as the target slice. Using a smaller slice
> will introduce undue preemptions, while using a larger value will
> increase latency.

I can see this being hard to be used in practice. There's portability issue on
defining a runtime that is universal for all systems. Same workload will run
faster on some systems, and slower on others. Applications can't just pick
a value and must do some training to discover the right value for a particular
system. Add to that the weird impact HMP and DVFS can have on runtime from
wakeup to wakeup; things get harder. Shared DVFS policies particularly where
suddenly a task can find itself taking half the runtime because of a busy task
on another CPU doubling your speed.

(slice is not invariant, right?)

And a 95%+ confidence will be hard. A task might not know for sure what it will
do all the time before hand. There could be strong correlation for a short
period of time, but the interactive nature of a lot of workloads make this
hard to be predicted with such high confidence. And those transitions events
are what usually the scheduler struggles to handle well. All history is
suddenly erased and rebuilding it takes time; during which things get messy.

Binder tasks for example can be latency sensitive, but they're not periodic and
will be run on demand when someone asks for something. They're usually short
lived.

Actually so far in Android we just had the notion of something being sensitive
to wake up latency without the need to be specific about it. And if a set of
tasks got stuck on the same rq, they better run first as much as possible. We
did find the need to implement something in the load balancer to spread as
oversubscribe issues are unavoidable. I think the misfit path is the best to
handle this and I'd be happy to send patches in this effect once we land some
interface.

Of course you might find variations of this from different vendors with their
own SDKs for developers.

How do you see the proposed interface fits in this picture? I can't see how to
use it, but maybe I didn't understand it. Assuming of course this is indeed
about latency :-)


Thanks!

--
Qais Yousef
