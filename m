Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EFD7944C3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbjIFUx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjIFUx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:53:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D91180
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 13:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694033604; x=1725569604;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=D7gOiixl0ENFUoY4ewE9/3iOmtem3gu4LDwtsIt7nN0=;
  b=azSL7t+WwzJfWFjacwVzT5dXvPJWc5Yftpb18HwuWCroL8alTe1JwJS4
   ipMsf9/gL0IUMffySiFf8mJkGo65+0k0yxz6CSu64lfrZopGF98acUb7R
   9CzoI0eWFnGVX1rjZ56BOCdoXs35wIg+0gNKku2aEXEEyMW+Sz0nGQhCb
   TQGvPCCvppknP67PamcGHSs4bz5e798ZD6dg88ZUQsNvUOFesg/YvwJ0I
   328lUcYmaEJwrzH8GykLDDDbtkaEUkWCCPWk345DCE3U59ZkNcXZOqdcA
   +JW4T12t5GybDqLobQkeJ70bTcLkk9qpk0CEUos4g1awPX0kinEBJ/Lqm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="357494105"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="357494105"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 13:51:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="770960658"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="770960658"
Received: from cmabraha-mobl1.amr.corp.intel.com (HELO [10.209.95.171]) ([10.209.95.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 13:51:10 -0700
Message-ID: <ae216efc3a71c624fb70c071de4b5e3c096756b4.camel@linux.intel.com>
Subject: Re: [RFC PATCH 1/2] sched: Rate limit migrations to 1 per 2ms per
 task
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>, x86@kernel.org
Date:   Wed, 06 Sep 2023 13:51:10 -0700
In-Reply-To: <20230906094744.GE38741@noisy.programming.kicks-ass.net>
References: <20230905171105.1005672-1-mathieu.desnoyers@efficios.com>
         <20230905171105.1005672-2-mathieu.desnoyers@efficios.com>
         <cfc3de8fa3172cedf406ccef8c94ef4da0a00281.camel@linux.intel.com>
         <866f23cc-6725-fc74-099f-450939fc0dc4@efficios.com>
         <ae4b342c424b76dc3f8adafcc2da7c02b9755b10.camel@linux.intel.com>
         <20230906094744.GE38741@noisy.programming.kicks-ass.net>
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

On Wed, 2023-09-06 at 11:47 +0200, Peter Zijlstra wrote:
> On Tue, Sep 05, 2023 at 03:44:57PM -0700, Tim Chen wrote:
>=20
> > Reading up on sched_clock() documentation and seems like it should=C2=
=A0
> > indeed be monotonic.
>=20
> It tries very hard to be monotonic but cannot guarantee. The moment TSC
> is found unstable it's too late to fix up everything.
>=20

Yes, if TSC becomes unstable and could cause sched_clock to reset and go wa=
y backward.
Perhaps we can add the following check in Mathieu's original
patch to fix things up:

+static bool should_migrate_task(struct task_struct *p, int prev_cpu)
> +{
	/* sched_clock reset causing next migration time to be too far ahead */
	if (p->se.next_migration_time > sched_clock_cpu(prev_cpu) + SCHED_MIGRATIO=
N_RATELIMIT_WINDOW)
		p->se.next_migration_time =3D sched_clock_cpu(prev_cpu) + SCHED_MIGRATION=
_RATELIMIT_WINDOW;

> +	/* Rate limit task migration. */
> +	if (sched_clock_cpu(prev_cpu) < p->se.next_migration_time)
> +	       return false;
> +	return true;
> +}
> +

Tim
