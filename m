Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431567AB117
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjIVLmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjIVLmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:42:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C067100
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 04:42:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EC2E621A9E;
        Fri, 22 Sep 2023 11:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695382961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=65+lm7d+dGRTiOMAyApVmU/Xt+Gy4JHwF9IUeIK1m1Q=;
        b=yJPzw4jKA78/KuVPeDtJPzXDAGBL5vPvSoxnuXVCM8RAh2RYriDdPP+yZAKS1CutJLntVi
        FFh4Iud6erKaiL6VZAjIt13auEAuC/Ru/cFgGCnz0KDuU75TY/uTVxI288PcND9Fv3aST4
        gkCLkcAXbu43vZ1RiVGQ5jRQknt5Ec0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695382961;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=65+lm7d+dGRTiOMAyApVmU/Xt+Gy4JHwF9IUeIK1m1Q=;
        b=fLpi/29qParzWJqJjq1VQuYRYSpCWpAK2Bu9U9mzTnpOu+5h7/MOI5YeDEWFf+l3OCP1Wd
        cS4+u8sAD88kp2DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D311113478;
        Fri, 22 Sep 2023 11:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w6kLL7F9DWXnJAAAMHmgww
        (envelope-from <chrubis@suse.cz>); Fri, 22 Sep 2023 11:42:41 +0000
Date:   Fri, 22 Sep 2023 13:43:26 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Petr Vorel <pvorel@suse.cz>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <ZQ193uwifmWWbqSP@yuki>
References: <20230901154355.5351-1-chrubis@suse.cz>
 <20230901174529.GB364687@pevik>
 <ZPIqsmTbJh7z-LcO@yuki>
 <ZQ1iabFEs93OZMSE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQ1iabFEs93OZMSE@gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > > Documentation/scheduller/sched-rt-group.rst [1] specifies this as values from -1 to
> > > (INT_MAX - 1), I guess due int range. Looking into proc_dointvec_minmax() [2]
> > > even INT_MAX would pass the check. I suppose we can do nothing about that,
> > > because there is no value in sysctl_vals[] which would represent INT_MAX - 1.
> > > 
> > > And you specify in LTP test range: from -1 to INT_MAX.
> > > 
> > > But even much shorter value than INT_MAX fails:
> > > 
> > > $ echo 1234567 > /proc/sys/kernel/sched_rt_runtime_us
> > > sh: echo: write error: Invalid argument
> > 
> > That is because runtime_us must be < period_us by definition, since
> > runtime_us defines how much time is allocated from the period_us. I
> > guess that this is not described good enough in the kernel docs.
> 
> Mind adding a second patch to your series, clarifying 
> Documentation/scheduler/sched-rt-group.rst?

Yes, that is the plan. I've been working on LTP release for past two
weeks so this has been postponed. I will get to it hopefully next week.

-- 
Cyril Hrubis
chrubis@suse.cz
