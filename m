Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D667BCF4D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 18:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344952AbjJHQ4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 12:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344915AbjJHQ4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 12:56:45 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED9EB6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 09:56:44 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-79fa416b7ffso166905339f.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1696784203; x=1697389003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HYq2iTngS95KbqS2CS0O2Qfomiij360b8kS784R56zw=;
        b=pAmADON3UE9ZCvG1LhipPnYmgNSvlJzGOOCdbPGbKtdpELx05OUKwLVhig3cwfWH/U
         wYf5eZM44hCwwB4SaKcQyCIABpDQ3xKLbq2yAJyN5YB6eE78dLo+ZulOQ05RXp52IFyo
         xv1hbCOEhFvdkxyXikDNu929XBs3AGcKlR2iY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696784203; x=1697389003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYq2iTngS95KbqS2CS0O2Qfomiij360b8kS784R56zw=;
        b=cnPzRGSR3kxBXCRNfnawajIJgWYY+39X5+/6Q7rVgY/ff+/yBxX+CnLks9v7mirHPw
         78qusEijGitYeSKKoSg9MU3hCOZMg60WWWQ7dU4Uv6z41pmhXpA8rCY8MuvSkLyjWgB2
         RMCfL+kVJqYbnkclb0Czgoe4INjeHD8rmg6evW4olG7AFRBoP93cZQYaSCAHeJVfLyXi
         3eSSmznL0kpLkjPE+BowpAULCyLoJdWT7bg+MCBDlDmLqd9/g6FQcmhyyUBXozqoDRNo
         qw4Gs6Vz2TGH8YdBuEJTBZcLZ8CQ/9i4dlU18Qh/TUZsavJk665+5SRrKpTt+3SUn2Pj
         L+lA==
X-Gm-Message-State: AOJu0YzA9hM71BcCYMF4xH11rtkBrBy1SVFTAZhRX0VL+cbgLVRAggUr
        eA4/JrilvOnTpeVA/S6NCgddkw==
X-Google-Smtp-Source: AGHT+IEkZFouqSYaQsnOsddemmbd1oV5gF2Rn8mjpk3KOIU27+6IlHWb1nfvjY7+Z40OOBF8pNaBXw==
X-Received: by 2002:a6b:4f0b:0:b0:783:5209:c01 with SMTP id d11-20020a6b4f0b000000b0078352090c01mr16573536iob.17.1696784203397;
        Sun, 08 Oct 2023 09:56:43 -0700 (PDT)
Received: from localhost (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id dk54-20020a0566384bf600b0043167542399sm1556420jab.99.2023.10.08.09.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 09:56:42 -0700 (PDT)
Date:   Sun, 8 Oct 2023 16:56:42 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/3] sched/nohz: Misc minor cleanups to the NOHZ idle
 balancing code
Message-ID: <20231008165642.GA2344751@google.com>
References: <20231006102518.2452758-1-mingo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006102518.2452758-1-mingo@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 12:25:15PM +0200, Ingo Molnar wrote:
> Noticed a few minor details while I was reading this code:
> 
> Ingo Molnar (3):
>   sched/nohz: Update idle load-balancing (ILB) comments
>   sched/nohz: Use consistent variable names in find_new_ilb() and kick_ilb()
>   sched/nohz: Remove weird error handling from find_new_ilb()

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> 
>  kernel/sched/fair.c | 45 +++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
> 
> -- 
> 2.39.2
> 
