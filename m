Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D567901F1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241329AbjIASQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbjIASQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:16:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A10F2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 11:16:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 93957211CE;
        Fri,  1 Sep 2023 18:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693592206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SczNKaVL1iGLO0+CrAmVKlavPYKq/W/vUS1YtqrLUeA=;
        b=NS3n//SRONg/+5qwYUhU4v7EUfrYcHS6eBYWOfvhso+oKNwFKksOfTgCDTeUIwMwHBARnp
        h1kOIlxIZBBWNKUMr0xYYqdxJc0gMN5wN9x/5STfYZ9uxO/yoUn9xrkqTnz3rJBHn4KAsg
        j+mh+pMUG2KR/j5O0vh0nWMcsmSYzwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693592206;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SczNKaVL1iGLO0+CrAmVKlavPYKq/W/vUS1YtqrLUeA=;
        b=fMrgFtVvLdrPEqKIjJoDzcyLZuWrTbedHnbRrE/d58/WtNZWw5CYV+ftwQ2YFYm7xjUrAR
        N+pdmTTHgDR6UnCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77D1B13582;
        Fri,  1 Sep 2023 18:16:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +z3/G44q8mQ5SwAAMHmgww
        (envelope-from <chrubis@suse.cz>); Fri, 01 Sep 2023 18:16:46 +0000
Date:   Fri, 1 Sep 2023 20:17:22 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH] sched/rt: Disallow writing invalid values to
 sched_rt_period_us
Message-ID: <ZPIqsmTbJh7z-LcO@yuki>
References: <20230901154355.5351-1-chrubis@suse.cz>
 <20230901174529.GB364687@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901174529.GB364687@pevik>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> Documentation/scheduller/sched-rt-group.rst [1] specifies this as values from -1 to
> (INT_MAX - 1), I guess due int range. Looking into proc_dointvec_minmax() [2]
> even INT_MAX would pass the check. I suppose we can do nothing about that,
> because there is no value in sysctl_vals[] which would represent INT_MAX - 1.
> 
> And you specify in LTP test range: from -1 to INT_MAX.
> 
> But even much shorter value than INT_MAX fails:
> 
> $ echo 1234567 > /proc/sys/kernel/sched_rt_runtime_us
> sh: echo: write error: Invalid argument

That is because runtime_us must be < period_us by definition, since
runtime_us defines how much time is allocated from the period_us. I
guess that this is not described good enough in the kernel docs.

-- 
Cyril Hrubis
chrubis@suse.cz
