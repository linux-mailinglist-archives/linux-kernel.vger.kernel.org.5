Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8B17566A0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjGQOkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGQOkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:40:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5393EC0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:39:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E50231FDA5;
        Mon, 17 Jul 2023 14:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689604796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rs9uvcUebUMYsasQ832t98i+yhYyEHbW41JV9UaUcj4=;
        b=QBXM1k8OERxN0iaIwVOM7k5vhYNab1sinEWQWfyhUl83K/x9qG83y7igJixZYo0pXzkdRI
        5HkMcCS+exn3+XJT8TeD1ciqGABcwi54XE0gtVhYEEzIfHl3cXGChEHXcjhR0a5c2RS2RZ
        FDmEsmwHRLip1xKgrlls4W7GMu2tHp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689604796;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rs9uvcUebUMYsasQ832t98i+yhYyEHbW41JV9UaUcj4=;
        b=KGjA6IXE8LIozekVLTJtjAkJ34AIUvQdps2KI5hNIjXUFlrW2wcysOtF5nQqqbWl6GfK9R
        MJAIbtaXHkBP/pCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5D67138F8;
        Mon, 17 Jul 2023 14:39:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w2FkLrxStWS4dQAAMHmgww
        (envelope-from <chrubis@suse.cz>); Mon, 17 Jul 2023 14:39:56 +0000
Date:   Mon, 17 Jul 2023 16:41:00 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Waiman Long <longman@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        yu.c.chen@intel.com, Peter Zijlstra <peterz@infradead.org>,
        aubrey.li@linux.intel.com, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Peter Hunt <pehunt@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, oe-lkp@lists.linux.dev,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        ltp@lists.linux.it, lkp@intel.com
Subject: Re: [LTP] [PATCH] sched/core: Use empty mask to reset cpumasks in
 sched_setaffinity()
Message-ID: <ZLVS_ANORaZO_ZIE@yuki>
References: <20230628211637.1679348-1-longman@redhat.com>
 <202307171539.3d8d0e8-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307171539.3d8d0e8-oliver.sang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> Running tests.......
> <<<test_start>>>
> tag=sched_setaffinity01 stime=1689382567
> cmdline="sched_setaffinity01"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
> sched_setaffinity01.c:83: TPASS: sched_setaffinity() failed: EFAULT (14)
> sched_setaffinity01.c:73: TFAIL: sched_setaffinity() succeded unexpectedly
> tst_test.c:1612: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> tst_test.c:1614: TBROK: Test killed! (timeout?)

So what the test does is that it sets empty affinity mask to
sched_setaffinity() and expects EINVAL. Instead it looks like the call
now succeeeds, the test stops getting schedulled and is killed by
timeout.

-- 
Cyril Hrubis
chrubis@suse.cz
