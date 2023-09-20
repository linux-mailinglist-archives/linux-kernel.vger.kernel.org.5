Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7AE7A6FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 02:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjITApx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 20:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjITApw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 20:45:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EBFAF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 17:45:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-31c7912416bso5891640f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 17:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1695170740; x=1695775540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2+8zlxQwJEA7t1MVo44Fti+1eHyzS2WMrdTfT/YX8MY=;
        b=POh5IuMiUfLtcqoFHBoofe2Q/F3hfEdJ8mUqwWqw2/2OrCdhgZHOHMhaLjDOcD85i5
         jkG4YdttjmWcxHuL/tq+2lExKplSyFpdLbzDTVH0UALbJ7UzHHPGZtqVEQP9odRs/n+6
         C4hBYVEKxOKMKpw2VCo4dpwXnF/oKnX1cbXWOO0VLxWtYLcjElpulA0cR8EhUA+ImKVy
         22zOkETejDJC4NzIW60iId04oC2uX+zql39e2wJJNKXB3OXmejCA8lThAZim2vKeVEUk
         VOcNnMvUqalXsLqw1oFUcUW54F9JKQdYCK4qnNRXtDxI9SMPBAL905wePjwvafx9OLK5
         iCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695170740; x=1695775540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+8zlxQwJEA7t1MVo44Fti+1eHyzS2WMrdTfT/YX8MY=;
        b=R/PhMgv/ZwSmxOZOL7H0m2o2brvfSRu1jZ0WQrIa3b8G3Dj5pc/lLzlKJK/hp+kMdX
         bRY5G4hPIHPKUTx5Mnc9Z+2L2afj0El1VLVx4ODp6rmSXjZDgjq1MRLs1BdG0UNcIiPZ
         /qChE8522iwDD/xLy8bmqhNlP43rP9B5LAG9KBmAWTN1cJjlKKBykO2jKTR3O+/wQNY9
         30Br6r91mTLZfUZjm1iAIP82UqfjmtDfqYkevliIxioJubZ7r6QT0uLZDN7FWogSpVte
         Y/jjRooeEQKNWwIw4mkPTSNbGrfhqfrSuUJn/G4ilo+2VzXESuLrn/PYnNOVanpbrCe6
         lpTQ==
X-Gm-Message-State: AOJu0YwjUzLAHtnhvBNPRetl/s6HlYzu7I75AjaXBC9g3+hdB9yCJ+b7
        w7W+bxM61nNC36sEVBw14JiUzQ==
X-Google-Smtp-Source: AGHT+IEWqU81heczpxAeAkVkAn2y1FYeCb4aU298lRzCHNv4tdJXFShdiLlGGp1/IGSu7mr/G/g7eQ==
X-Received: by 2002:a5d:4a50:0:b0:31f:f99c:6013 with SMTP id v16-20020a5d4a50000000b0031ff99c6013mr886588wrs.61.1695170740004;
        Tue, 19 Sep 2023 17:45:40 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id t3-20020a05600001c300b003143b14848dsm16781254wrx.102.2023.09.19.17.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 17:45:39 -0700 (PDT)
Date:   Wed, 20 Sep 2023 01:45:37 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20230920004537.qv36vrirxmhjzp3x@airbuntu>
References: <20230915124354.416936110@noisy.programming.kicks-ass.net>
 <20230915124822.956946622@noisy.programming.kicks-ass.net>
 <20230919220708.l2llt2f5xullxzzz@airbuntu>
 <20230919223704.GG424@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230919223704.GG424@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/23 00:37, Peter Zijlstra wrote:
> On Tue, Sep 19, 2023 at 11:07:08PM +0100, Qais Yousef wrote:
> > On 09/15/23 14:43, peterz@infradead.org wrote:
> > > Allow applications to directly set a suggested request/slice length using
> > > sched_attr::sched_runtime.
> > 
> > I'm probably as eternally confused as ever, but is this going to be the latency
> > hint too? I find it hard to correlate runtime to latency if it is.
> 
> Yes. Think of it as if a task has to save up for it's slice. Shorter
> slice means a shorter time to save up for the time, means it can run
> sooner. Longer slice, you get to save up longer.

Okay, so bias toward latency (short runtime) or throughput (long runtime).

I revisited the paper and can appreciate the importance of the term 'request'
in here.

Is the 95%+ confidence part really mandatory? I can easily see runtime swings
between 2-4ms over a trace for example. Should this task request 4ms as runtime
then? If we request 2ms but we ended up needing 4ms, IIUC we'll be preempted
after 2ms as that's what we requested, right?

What is the penalty for lying if we request 4ms but end up needing 2ms?

> Some people really want longer slices to reduce cache trashing or
> held-lock-preemption like things. Oracle, Facebook, or virt thingies.
> 
> Other people just want very short activations but wants them quickly.

Is 3-5ms in the very short region? I think that's the average I see. There are
longer, and shorter, but nothing 'crazy' long.

If we have a bunch of very short tasks stuck on the same rq; IIUC the ones that
actually requested the shorter slice should win as the other will still have
sysctl_sched_base_slice as their request, hence the deadline will seem further
away in spite of not consuming their full slice. And somehow lag will sort
itself to ensure fairness if there were too many wake ups of short-request
tasks (latency wakeup storm).

With this interface it'd be sort of compulsory for users to keep their latency
sensitive tasks short; which maybe is a good thing. The question is how short
do they have to be. Is there a number that can be exposed or deduced/calculated
to help identify/advise users to stay within?

Silly question, do you think this interface is transferable if we move away
from EEVDF in the future for whatever reason? I feel I have to reason about how
EEVDF works to use it, which probably was my first stumbling point as I was
thinking in a more detached/abstract manner.

Sorry, too many questions..


Thanks!

--
Qais Yousef
