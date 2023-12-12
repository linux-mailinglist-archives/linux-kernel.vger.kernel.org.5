Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9205280FB9F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377493AbjLLX5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjLLX5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:57:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18E9B2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:57:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD86CC433C8;
        Tue, 12 Dec 2023 23:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702425431;
        bh=SuBNtpwXRuXuAk6i9Jjme9Aya8cKB5MGJ2ffLAtpOxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Er3wa+iHzVEwSzheJJ0GWEsxVVCY5FDU9fGqxa7NDhmT0aXDvOoyLQXv3BJgIygat
         kugiBHCoH9XgFewNSExe9tfQlKXecjZKGyGkZz+0pc6ENp+Jz0W21/T4PRP0Tg0NGR
         ceAuEbvd9nuVXqGmsMbL5I3VZ4hl7Q95flxPn6JhimdWS6SSRpWhKLzVtzGWmjEU2c
         7BvMlI3c2PP//XsG6VaLTUbcOGTBsR51teFvlLR1gT/sOTyGCxbdxsGLsBW5FeNffy
         VG4aq1DCFVodv0f/ovFHrRBBUyi2d3rqgr+3mGChb2/kdWdi5KrkBb+eCkieh7VphP
         Bjy8QUPf6PFLg==
Date:   Wed, 13 Dec 2023 00:57:08 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Gianfranco Dutka <gianfranco.dutka@arista.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, vincent.guittot@linaro.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        Phil Auld <pauld@redhat.com>,
        Cestmir Kalina <ckalina@redhat.com>
Subject: Re: Modifying isolcpus, nohz_full, and rcu_nocb kernel parameters at
 runtime
Message-ID: <ZXjzVKAM7Xt3eeAQ@lothringen>
References: <76587DD3-2A77-41A3-9807-6AEE4398EBA6@arista.com>
 <CAKfTPtAkhfAhFouCGTy7m4swCeeEsu1VdWEX_ahOVDq1U594Dg@mail.gmail.com>
 <ZXJKAnrRjBUmKx1V@slm.duckdns.org>
 <d46834f4-a490-4a4a-9e95-cca4a6316570@redhat.com>
 <25E6E1E4-DC16-490E-B907-A3236FB9317A@arista.com>
 <ZXhf3A0FNjFZaZGK@lothringen>
 <7e3bf653-d3ea-48b0-b808-d92a3c5f2c5b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e3bf653-d3ea-48b0-b808-d92a3c5f2c5b@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 03:18:43PM -0500, Waiman Long wrote:
> 
> On 12/12/23 08:27, Frederic Weisbecker wrote:
> > On Fri, Dec 08, 2023 at 09:18:53AM -0500, Gianfranco Dutka wrote:
> > > > The isolcpus, nohz_full and rcu_nocbs are boot-time kernel parameters. I am in the process of improving dynamic CPU isolation at runtime. Right now, we are able to do isolcpus=domain with the isolated cpuset partition functionality. Other aspects of CPU isolation are being looked at with the goal of reducing the gap of what one can do at boot time versus what can be done at run time. It will certain take time to reach that goal.
> > > > 
> > > > Cheers,
> > > > Longman
> > > > 
> > > Thank you Waiman for the response. It would seem that getting similar
> > > functionality through cgroups/cpusets is the only option at the moment. Is it
> > > completely out of the question to possibly patch the kernel to modify these
> > > parameters at runtime? Or would that entail a significant change that might
> > > not be so trivial to accomplish? For instance, the solution wouldn’t be as
> > > simple as patching the kernel to make these writeable and then calling the
> > > same functions which run at boot-time when these parameters are originally
> > > written?
> > As for nohz_full (which implies rcu_nocb), it's certainly possible to make it
> > tunable at runtime via cpusets. If people really want it, I'm willing to help.
> 
> As said by Phil, your help in in enabling dynamic rcu_nocb will be greatly
> appreciated.

rcu_nocb is already ready for that. The not yet ready part is nohz_full and its
several components (tick, remote tick, [hr-]timers affinity, workqueues affinity, kthreads
affinity, vmstat, buffer head, etc...). Last debate on plumbers suggested that
nohz_full should be dynamically turned on/off only on offline CPUs. That will
indeed simplify the problem.

> My current thought is to have a root level
> cpuset.cpus.isolation_control file to enable additional CPU isolation like
> rcu_nocb to be applied to CPUs in isolated partitions.

Last time I tried that, Peter Zijlstra was more in favour of an isolate all or nothing
switch by default for nohz_full that would include rcu_nocb. And then if people
are interested in something more finegrained, introduce such a file to control
individual features (see
https://lore.kernel.org/lkml/YpIwsiaY2IPK96WO@hirez.programming.kicks-ass.net/ )

But so far I never heard about the need for such a finegrained isolation. Users of
nohz_full= seem to want to isolate everything out.

Thanks.
