Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAFA7E4EF9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbjKHChI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjKHChG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:37:06 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E5B184
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 18:37:04 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7a68b87b265so213445739f.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 18:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1699411023; x=1700015823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YiVVs5pe4QBJBFRBMFZQbCNICB0a7pk7mC2rDsdcHqE=;
        b=Rfm8UlsoRG2761CrxyfRIjYP9GyIBXA3xD4q/1iurNcQH/Bm+b/ooURNs4Ah7meF8M
         1bh315JSrqQZVW2T2fKvkeMQ8vEKw4M5l7hgf5RqhTyxYOYDeQJNf330LhuRzIFiXDAN
         o4GFKXuA6xY7j5ze1JO1cuLl15uvzO3Hs4jl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699411023; x=1700015823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiVVs5pe4QBJBFRBMFZQbCNICB0a7pk7mC2rDsdcHqE=;
        b=gUOTD3m1xeOCkr/Jtc7XS8pyQk17c0qQoWOLJ6CAyI7IYiVmLW157v2OCCOnlQMtim
         t/sf/kxKhxjzo4uW/T8zUjT4zQDcp3rqfo+Wk/w8VI2dmR7XRTuGNk06Mc51B+C2Aa6j
         nMooeukpPk46Wx8kWx/r/EDSEbbKb7KlWw+rOE+xK0YPuSastUFUcZ/YnJyOZ47rb/IA
         fH6bZmF+0Vggmc22OuWve3NkYEzuMfxq3ZnijiXzdo4eaapJNuFhKiEWBq6EMtZcVNCh
         pFP8M8shIn7XwsiqQNCzsddXEfpfgsm/IA/GiyJ0cBJXvwUjrEUTsFHnwB2eQwb1N9o9
         RiJQ==
X-Gm-Message-State: AOJu0YyYP77u9N6oUfhUKqXG0+4RaWY2q/U3fP4yE8ZQMu0LuhDTK8mi
        9oTEbUsNQ9aQiSSHrNQ4TTFqOtoQpxQVikUbQjA=
X-Google-Smtp-Source: AGHT+IGvJ2vBEBakwIwfrXi4GTePj6K5kZNlh3pZ/1F3QLz43MplOBYdNtawIB7O+xvxRvK9u/hX9w==
X-Received: by 2002:a5d:9319:0:b0:786:fff8:13c2 with SMTP id l25-20020a5d9319000000b00786fff813c2mr782500ion.11.1699411023339;
        Tue, 07 Nov 2023 18:37:03 -0800 (PST)
Received: from localhost (20.10.132.34.bc.googleusercontent.com. [34.132.10.20])
        by smtp.gmail.com with ESMTPSA id b2-20020a029582000000b004640159c92csm2161673jai.58.2023.11.07.18.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 18:37:02 -0800 (PST)
Date:   Wed, 8 Nov 2023 02:37:02 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
Message-ID: <20231108023702.GA2992223@google.com>
References: <cover.1699095159.git.bristot@kernel.org>
 <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
 <CAEXW_YS=PrWDx+YGVR7bmq0_SoKNztzGrreApCd9qk1yBLA5bA@mail.gmail.com>
 <CAEXW_YQ8kv3tXQJexLSguPuWi0bXiReKDyYNo9+A-Hgp=Zo1vA@mail.gmail.com>
 <CAEXW_YSjsZSrJK_RbGmbLNy4UrLCgu+7NPZjg-wiLuNbGOGr+w@mail.gmail.com>
 <20231107114732.5dd350ec@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107114732.5dd350ec@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 11:47:32AM -0500, Steven Rostedt wrote:
> On Mon, 6 Nov 2023 16:37:32 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > Say CFS-server runtime is 0.3s and period is 1s.
> > 
> > At 0.7s, 0-laxity timer fires. CFS runs for 0.29s, then sleeps for
> > 0.005s and wakes up at 0.295s (its remaining runtime is 0.01s at this
> > point which is < the "time till deadline" of 0.005s)
> > 
> > Now the runtime of the CFS-server will be replenished to the full 0.3s
> > (due to CBS) and the deadline
> > pushed out.
> > 
> > The end result is, the total runtime that the CFS-server actually gets
> > is 0.595s (though yes it did sleep for 5ms in between, still that's
> > tiny -- say if it briefly blocked on a kernel mutex). That's almost
> > double the allocated runtime.
> > 
> > This is just theoretical and I have yet to see if it is actually an
> > issue in practice.
> 
> Let me see if I understand what you are asking. By pushing the execution of
> the CFS-server to the end of its period, if it it was briefly blocked and
> was not able to consume all of its zerolax time, its bandwidth gets
> refreshed. Then it can run again, basically doubling its total time.

I think my assumption about what happens during blocking was wrong. If it
blocked, the server is actually stopped via dl_server_stop() and it starts
all over again on enqueue.

That makes me worry about the opposite issue now. If the server restarts
because it blocked briefly, that means again it starts in a throttled state
and has to wait to run till zero-lax time. If CFS is a 99% load but blocks
very briefly after getting to run a little bit (totalling 1% of the time),
then it wont get 30% because it will keep getting delayed to the new 0-lax
every time it wakes up from its very-brief nap. Is that really Ok?

> But this is basically saying that it ran for its runtime at the start of
> one period and at the beginning of another, right?

I am not sure if this can happen but I could be missing something. AFAICS,
there is no scenario where the DL server gets to run at the start of a new
period unless RT is not running. The way the patch is written AFAICS,
whenever the DL-server runs out of runtime, it gets throttled and a timer
fires to go off at the beginning of the next period.
(update_curr_dl_se() -> dl_runtime_exceeded() -> start_dl_timer()).

In this timer handler (which fired at next period beginning), it will
actually replenish_dl_entity() to refresh the runtime and push the period
forward. Then it will throttle the server till the 0-lax time. That  means we
always end up running at the 0-lax time when starting a new period if RT is
running, and never at the beginning. Did I miss something?

On the other hand, if it does not run out of runtime, it will keep running
within its 0-lax time. We know there is enough time within its 0-lax time for
it to run because when we unthrottled it, we checked for that.

Switching gears, another (most likely theoretical) concern I had is what if
the 0-lax timer interrupt gets delayed a little bit. Then we will always end
up not having enough 0-lax time and keep requeuing the timer, that means CFS
will be starved always as we keep pushing the execution to the next period's
0-lax time.

Anyway, I guess I better get to testing this stuff tomorrow and day after on
ChromeOS before LPC starts. Personally I feel this is a great first cut and
hope we can get v5 into mainline and iteratively improve. :)

thanks,

 - Joel

