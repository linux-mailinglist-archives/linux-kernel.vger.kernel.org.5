Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0125A7C7683
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441905AbjJLTPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344140AbjJLTPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:15:17 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14152C9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:15:16 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9c496c114so35035ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697138115; x=1697742915; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7FVN1xVN8dgYBYhWTJv0VkyIeHGCVKgQZwjH5bY01Q4=;
        b=gXw2Rx2cmU0gGUNI/bGgiv2Xi60Q+5g79I8QQdCEXZCbOjcdAafg1WnybsEMPob8xX
         1MgGSPLFSn3bGTSkOzDRHxm6zXRo21LbI8uiVOMUJvozMlmYanOYMF7Tc5ivweFwLuQZ
         +H4mg1b6reB49SM5WOhkorTEC9HmwnIvE2tFLJoXcixPXgegZ09BRkN9UtEU3679xaDS
         r8VZnEB64m2eptkdBZ/HIZ24ApYlLYWj2bkB3U4YGkamQj2MCFXbRrpUJ9VJPbHT85MZ
         BPezSppNFJCe2uAQ1gHgAKX3uPr6/4nvqv8OX8i1/2j+/quOsu2SX0ErqEm3kpZqbkuY
         UoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697138115; x=1697742915;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FVN1xVN8dgYBYhWTJv0VkyIeHGCVKgQZwjH5bY01Q4=;
        b=d2FehHVpbPIg5Bi+7A6+sSffI2+ougwVMfhVUdVDKDQ5IYHIrYQAvbyj8RpS8WYiiY
         yrVXDJGZQ1t+1nOwjpwSJBBj4H19WlyPktXF8GhBNyCqtn6hzESwMb4J4PcH5rIVpFqS
         VvySQjkgFQhoqYudafzybqM9RSIKStdPHaQaqG402zK+rEJdEJTqrKruHitDJvJlYaT+
         XKy/b+F/F+6mRkhyYXnOpWIbCPxuL3mg3AuKjaEuoqnVlB0n9PzfTjYS5ngz2zm7qB8Y
         WRna0wonRN5JnIAqzXYMMPAqZEsHvA9KOxjWqxegNrwL6jh9duGnmVO+/ZFZzhT41Muy
         O5fA==
X-Gm-Message-State: AOJu0YyncQk6wLt6A5Xh/KIMOfvDwGehkD/FHz2d9Fw3Yud2ppSuQ4IC
        c8YyWEYFuf+Yrfa+ULPITWHjaA==
X-Google-Smtp-Source: AGHT+IHGSXejP2DG05x1wI6dK6bShY/5E/oNEnK4lJcC7NjQ8GcPyO1eRwJbq/5fenDu6zwxhBtWGA==
X-Received: by 2002:a17:903:288:b0:1c9:b934:aa1b with SMTP id j8-20020a170903028800b001c9b934aa1bmr35997plr.4.1697138115361;
        Thu, 12 Oct 2023 12:15:15 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2a3:200:216e:4b3d:e8ab:f961])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902680600b001c55e13bf39sm2369813plk.275.2023.10.12.12.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:15:14 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Subject: Re: [PATCH 03/15] sched/fair: Add lag based placement
In-Reply-To: <20230531124603.794929315@infradead.org> (Peter Zijlstra's
        message of "Wed, 31 May 2023 13:58:42 +0200")
References: <20230531115839.089944915@infradead.org>
        <20230531124603.794929315@infradead.org>
Date:   Thu, 12 Oct 2023 12:15:12 -0700
Message-ID: <xm26fs2fhcu7.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> @@ -4853,49 +4872,119 @@ static void
>  place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
>  {
>  	u64 vruntime = avg_vruntime(cfs_rq);
> +	s64 lag = 0;
>  
> -	/* sleeps up to a single latency don't count. */
> -	if (!initial) {
> -		unsigned long thresh;
> +	/*
> +	 * Due to how V is constructed as the weighted average of entities,
> +	 * adding tasks with positive lag, or removing tasks with negative lag
> +	 * will move 'time' backwards, this can screw around with the lag of
> +	 * other tasks.
> +	 *
> +	 * EEVDF: placement strategy #1 / #2
> +	 */

So the big problem with EEVDF #1 compared to #2/#3 and CFS (hacky though
it is) is that it creates a significant perverse incentive to yield or
spin until you see yourself be preempted, rather than just sleep (if you
have any competition on the cpu). If you go to sleep immediately after
doing work and happen to do so near the end of a slice (arguably what
you _want_ to have happen overall), then you have to pay that negative
lag in wakeup latency later, because it is maintained through any amount
of sleep. (#1 or similar is good for reweight/migrate of course)

#2 in theory could be abused by micro-sleeping right before you are
preempted, but that isn't something tasks can really predict, unlike
seeing more "don't go to sleep, just spin, the latency numbers are so
much better" nonsense.
