Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EE97E0187
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343808AbjKCHMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 03:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343653AbjKCHMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 03:12:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9641B4
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 00:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698995515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q9uFf83rvzhktE7lGMKnnskYRJKaK9VyflImr9Uq3gw=;
        b=MsBdEMxu61vFE4zycULwP4eMIyS64EiSnOET5YFdnVDmFcGgN7aFL1xbukS/EHZCIsk2lT
        XsyImumhLARCXwBtUV0/4JHaEi3P3fNikQQIBmD4Hl2sIQOiUU0GHuv8IMKaobU/tYiEXw
        XO025jcw0rPWX5GBvujv1IWX16sdLzE=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-vke6Al1VNcSSDBqZ42dFRQ-1; Fri, 03 Nov 2023 03:11:48 -0400
X-MC-Unique: vke6Al1VNcSSDBqZ42dFRQ-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-da2b8af7e89so2130763276.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 00:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698995507; x=1699600307;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q9uFf83rvzhktE7lGMKnnskYRJKaK9VyflImr9Uq3gw=;
        b=jRZOlqCIjcW9b0EKr2jut2D3z3Wo86f7pGxpYU8ftKC7huEbcJPaqu0ngleLzU00MX
         88HLyZieD6oPY7waZv4p/KFK5SXOPeSwuVP+ZcglS3gfVRAtimnFqax/P7UBrZWReHbK
         KdFZDFJAHMVtC+uB6/qPVjq6wOKJkTUEiSJ+aAqhw5HmcIZfHDa5SP8v9STx01AheqBN
         Euoaf/2e0AdkS1mFOs1s3sNFEXwOt7emeeIEGsBXc79cg8paI4KIB8bbC3vUH6XBPa9P
         2xKcseRnUdtwSINb4PNPIpO4agHh3tvDHzCNXX6YnXfC++79klDo+o5ArNekASmujjIh
         o7HA==
X-Gm-Message-State: AOJu0Yw5iu5mmeJmuMINbKt+jFPxPVJzAGRFw2Xu9NbkrTLwRo+TybtW
        bnFGzxijxfH27WYYoDTFGCbbrENrU0G7Z4mPZ20Px6pX/qbenBgEqfIlqcV4xVXYS0TYlrjanRR
        r7AtfSzDBwNV9EmKILu7B9zsq
X-Received: by 2002:a25:b217:0:b0:da0:3cfa:ba89 with SMTP id i23-20020a25b217000000b00da03cfaba89mr18638375ybj.2.1698995507383;
        Fri, 03 Nov 2023 00:11:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOU1B4EyY/NhcayH1LIoExzn9UiHWktnqOrtNZdKBe8CUrHH3VAetOmatJBCijJqPmghUURQ==
X-Received: by 2002:a25:b217:0:b0:da0:3cfa:ba89 with SMTP id i23-20020a25b217000000b00da03cfaba89mr18638361ybj.2.1698995507058;
        Fri, 03 Nov 2023 00:11:47 -0700 (PDT)
Received: from localhost.localdomain ([151.29.128.41])
        by smtp.gmail.com with ESMTPSA id u5-20020a0cea45000000b00670bd5a3720sm488346qvp.97.2023.11.03.00.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 00:11:46 -0700 (PDT)
Date:   Fri, 3 Nov 2023 08:11:40 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        John Stultz <jstultz@google.com>, Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH 1/3] sched/core: Provide a method to check if a task
 is PI-boosted.
Message-ID: <ZUSdLMQn0GZ+/T1E@localhost.localdomain>
References: <20230804113039.419794-1-bigeasy@linutronix.de>
 <20230804113039.419794-2-bigeasy@linutronix.de>
 <ZUNsSqHiYu8WTHBb@localhost.localdomain>
 <20231102160319.4rjz7ujq@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231102160319.4rjz7ujq@linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/23 17:03, Sebastian Andrzej Siewior wrote:
> On 2023-11-02 10:30:50 [+0100], Juri Lelli wrote:
> > Hi,
> Hi,
> 
> > Apologies for noticing only now, but I believe this is still part of the
> > 6.6-rt patches and I've got the below question to ask.
> 
> I'm not sure if we want this. I do have an alternative solution in the
> meantime.

Ah, OK. Guess what below is moot then. :) Will be watching for the
alternative solution to show up.
> 
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -8886,6 +8886,21 @@ static inline void preempt_dynamic_init(void) { }
> > >  
> > >  #endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
> > >  
> > > +/*
> > > + * task_is_pi_boosted - Check if task has been PI boosted.
> > > + * @p:	Task to check.
> > > + *
> > > + * Return true if task is subject to priority inheritance.
> > > + */
> > > +bool task_is_pi_boosted(const struct task_struct *p)
> > > +{
> > > +	int prio = p->prio;
> > > +
> > > +	if (!rt_prio(prio))
> > > +		return false;
> > > +	return prio != p->normal_prio;
> > 
> > Does this need to also take DEADLINE tasks into consideration? We don't
> > change priority when they are boosted, only pi_se changes (please check
> > is_dl_boosted()).
> 
> If we want this, then probably yes.
> Isn't task_struct::prio for the DL (boosted) task set to 0? While the RT
> priority go from 1…MAX_RT_PRIO - 1.

But then we can also have DL on DL boosting and in this case only the
pi_se changes while prio stays the same. But, again, looks like this is
moot anyway.

Thanks!
Juri

