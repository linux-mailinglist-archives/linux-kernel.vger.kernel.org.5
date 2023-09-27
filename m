Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B187B0E26
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 23:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjI0VgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 17:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0VgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:36:16 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Sep 2023 14:36:14 PDT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29ABD6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 14:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695850575; x=1727386575;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=D7qupsIENV9dgBtEuHbESk+G11qlO3bb6Yg4ZH5XZ0M=;
  b=SN4viWkxobwwybyQUznVHtlelUjAPCYqGlPu80XJJ4RDkwQLUBw8XN4u
   nsAjWfeLkr1F/LwOrU28ZvoYxfO6FQu32EMfz0NXW/XFzpR4qkaDrrXz1
   DNCt7jM46cvjslcZQa089Ju19tkfZNFtlOytVT1GHsBZZYizGFD8eQkFC
   ltj0HnaeKjgzCDFBvB5yXT4gY7SrUcf9Bpv5eohuiCnFCHgcCaOdJCM0g
   hoRf6kxEKCAdn7nsMYpPmrJHHJGKOdyGhZ09+LXvUXKW0ajeYddNXtH43
   4U9rFJpsJBNDv1xRD7E5hIEPLitcb/NIgwN5E2VxYg8JVtLiLs/O//2a5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="3477421"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="3477421"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 14:35:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="922964462"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="922964462"
Received: from vchippa-mobl.amr.corp.intel.com (HELO [10.212.190.215]) ([10.212.190.215])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 14:35:12 -0700
Message-ID: <01ab74767686f5a33a579b18a83392e92c312b93.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] Introduce SIS_CACHE to choose previous CPU during
 task wakeup
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Ingo Molnar <mingo@kernel.org>, Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.chen.surf@gmail.com>
Date:   Wed, 27 Sep 2023 14:34:59 -0700
In-Reply-To: <ZRPhC7b6OT1uFtNE@gmail.com>
References: <cover.1695704179.git.yu.c.chen@intel.com>
         <ZRPhC7b6OT1uFtNE@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-27 at 10:00 +0200, Ingo Molnar wrote:
> * Chen Yu <yu.c.chen@intel.com> wrote:
>=20
> > When task p is woken up, the scheduler leverages select_idle_sibling()
> > to find an idle CPU for it. p's previous CPU is usually a preference
> > because it can improve cache locality. However in many cases, the
> > previous CPU has already been taken by other wakees, thus p has to
> > find another idle CPU.
> >=20
> > Inhibit the task migration while keeping the work conservation of
> > scheduler could benefit many workloads. Inspired by Mathieu's
> > proposal to limit the task migration ratio[1], this patch considers
> > the task average sleep duration. If the task is a short sleeping one,
> > then tag its previous CPU as cache hot for a short while. During this
> > reservation period, other wakees are not allowed to pick this idle CPU
> > until a timeout. Later if the task is woken up again, it can find its
> > previous CPU still idle, and choose it in select_idle_sibling().
>=20
> Yeah, so I'm not convinced about this at this stage.
>=20
> By allowing a task to basically hog a CPU after it has gone idle already,
> however briefly, we reduce resource utilization efficiency for the sake
> of singular benchmark workloads.
>=20
> In a mixed environment the cost of leaving CPUs idle longer than necessar=
y
> will show up - and none of these benchmarks show that kind of side effect
> and indirect overhead.
>=20
> This feature would be a lot more convincing if it tried to measure overhe=
ad
> in the pathological case, not the case it's been written for.
>=20

Ingo,

Mathieu's patches on detecting overly high task migrations and then
rate limiting migration is a way to detect that tasks are getting=C2=A0
crazy doing CPU musical chairs and in a pathological state.

Will the migration rate be a reasonable indicator that we need to
do something to reduce pathological migrations like SIS_CACHE proposal so t=
he
tasks don't get jerked all over?
Or you have some other better indicators in mind?

We did some experiments on the OLTP workload on a 112 core 2 socket
SPR machine.  The OLTP workload have a mixture of threads
handling database updates on disks and handling transaction
queries over network.

For Mathieu's original task migration rate limit patches,
we saw 1.2% improvement and for Chen Yu's SIS_CACHE proposal, we=C2=A0
saw 0.7% improvement.  System is running at
~94% busy so is under high utilization.  The variation of this workload
is less than 0.2%. There are improvements for such mix workload
though it is not as much as the microbenchmarks.  These
data are perliminary and we are still doing more experiments.

For the OLTP experiments, each socket with 64 cores are divided
with sub-numa clusters of 4 nodes of 16 cores each so the scheduling
overhead in idle CPU search is much less if SNC is off. =20

Thanks.

Tim
