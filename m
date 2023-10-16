Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048947CADB5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjJPPiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbjJPPiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:38:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49106F2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:38:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41AAC433CA;
        Mon, 16 Oct 2023 15:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697470695;
        bh=wtC6ekFrSeHsJyDMoZcgF7d8+qu8m8xwaumKuPeAXd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ser5PMkz2wEu6pyX7zJkesK3olhWDPQ4oeeoGJj99lV5GcAFDrnMDo+icKrldb7kx
         aEFqF0XHEYyFFL1ORjedSayoa7Bwh6NSbTQvbUDmZs4RqEJb+YoLcqniFPdaaZ6Dzu
         sa0W7FSnlEYzY4sZ1sQjGcvtvDH1gn3aAMRa5hsEihRLFdwJJuQeRscnfhvZafHeGZ
         of13Z6JeNR1c/kiB1n8tadcPxj6U3FyR54MyCGSC1IN8G1Aubgxx89imFSzWZuYKyx
         n/jzwn8wUcOksYxi/RC93OSZ0uasjNtwVw9ifcYuseFWilggTw20ik/tYgVTwLv81y
         FrfB590iNn3tA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EE3B240016; Mon, 16 Oct 2023 12:38:12 -0300 (-03)
Date:   Mon, 16 Oct 2023 12:38:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3] perf bench sched pipe: Add -G/--cgroups option
Message-ID: <ZS1Y5PhXhp384ynY@kernel.org>
References: <20231016044225.1125674-1-namhyung@kernel.org>
 <ZS0D53ckVx356k4o@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS0D53ckVx356k4o@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 16, 2023 at 11:35:35AM +0200, Ingo Molnar escreveu:
> 
> 
> * Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > +	/* try cgroup v2 interface first */
> > +	if (threaded)
> > +		fd = openat(cgrp->fd, "cgroup.threads", O_WRONLY);
> > +	else
> > +		fd = openat(cgrp->fd, "cgroup.procs", O_WRONLY);
> > +
> > +	/* try cgroup v1 if failed */
> > +	if (fd < 0)
> > +		fd = openat(cgrp->fd, "tasks", O_WRONLY);
> > +
> > +	if (fd < 0) {
> > +		char mnt[PATH_MAX];
> > +
> > +		printf("Failed to open cgroup file in %s\n", cgrp->name);
> > +
> > +		if (cgroupfs_find_mountpoint(mnt, sizeof(mnt), "perf_event") == 0)
> > +			printf(" Hint: create the cgroup first, like 'mkdir %s/%s'\n",
> > +			       mnt, cgrp->name);
> 
> Ok, this works too I suppose.
> 
> Acked-by: Ingo Molnar <mingo@kernel.org>

I'm not getting that:

[root@five ~]# perf bench sched pipe -l 10000 -G AAA,BBB
# Running 'sched/pipe' benchmark:
no access to cgroup /sys/fs/cgroup/AAA
cannot open sender cgroup: AAA
 Usage: perf bench sched pipe <options>

    -G, --cgroups <SEND,RECV>
                          Put sender and receivers in given cgroups
[root@five ~]#

Its better now as it bails out, but it is not emitting any message that
helps with running the test, well, there is that /sys/fs/cgroup/AAA
path, lemme try doing a mkdir:

[root@five ~]# perf bench sched pipe -l 10000 -G AAA,BBB
# Running 'sched/pipe' benchmark:
no access to cgroup /sys/fs/cgroup/BBB
cannot open receiver cgroup: BBB
 Usage: perf bench sched pipe <options>

    -G, --cgroups <SEND,RECV>
                          Put sender and receivers in given cgroups
[root@five ~]#

[root@five ~]# perf bench sched pipe -l 10000 -G AAA,BBB
# Running 'sched/pipe' benchmark:
[root@five ~]#

It seems to be bailing out but doesn't run the test nor emits any
warning.

I'm using v3. I'll try to debug it a bit.

- Arnaldo
