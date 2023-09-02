Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0A9790983
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 22:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjIBUWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 16:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjIBUWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 16:22:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9FCE54
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 13:22:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9929D1F385;
        Sat,  2 Sep 2023 20:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693686135;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K3V4+tJ8iZkq5pdmvFAYXipZkqIlqMU2Z13b7c9+Pio=;
        b=Hhn7++5C+jcS2+Fg3jtpIzFUtQZlHWaaB9yoElRY9JSXCQZSE7hKYO+dbMpTglqSiB81LQ
        mh26Vy0dM8GrcQBURr6unMKY/Dl/tfhKuqgjpbPmCT1EYc7zKYBZc9ZYcHsD2GdQPPDPCx
        AgVd1I8bsbNvcM2xw5U9b3Wl/DfWFRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693686135;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K3V4+tJ8iZkq5pdmvFAYXipZkqIlqMU2Z13b7c9+Pio=;
        b=N1gHEAcMhHkDLwQTo/RjLi8kizoQUqkSGYDtWH4exbASX75nV6/wY+tSTDra0GDr6KU9Sf
        66tGAsBM5RAY6VDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1060813440;
        Sat,  2 Sep 2023 20:22:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I15rAneZ82QxAgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Sat, 02 Sep 2023 20:22:15 +0000
Date:   Sat, 2 Sep 2023 22:22:13 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>
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
Message-ID: <20230902202213.GA418654@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20230901154355.5351-1-chrubis@suse.cz>
 <20230901174529.GB364687@pevik>
 <ZPIqsmTbJh7z-LcO@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPIqsmTbJh7z-LcO@yuki>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi!
> > Documentation/scheduller/sched-rt-group.rst [1] specifies this as values from -1 to
> > (INT_MAX - 1), I guess due int range. Looking into proc_dointvec_minmax() [2]
> > even INT_MAX would pass the check. I suppose we can do nothing about that,
> > because there is no value in sysctl_vals[] which would represent INT_MAX - 1.

> > And you specify in LTP test range: from -1 to INT_MAX.

> > But even much shorter value than INT_MAX fails:

> > $ echo 1234567 > /proc/sys/kernel/sched_rt_runtime_us
> > sh: echo: write error: Invalid argument

> That is because runtime_us must be < period_us by definition, since
> runtime_us defines how much time is allocated from the period_us. I
> guess that this is not described good enough in the kernel docs.

Thanks for clarification. +1 for docs update.

Kind regards,
Petr
