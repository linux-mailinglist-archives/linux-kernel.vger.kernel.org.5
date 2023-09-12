Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEDB79D4FB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbjILPc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236451AbjILPct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:32:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A25C1996
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:32:24 -0700 (PDT)
Date:   Tue, 12 Sep 2023 17:32:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694532742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g/nR9JmjEhE/8Ce9fpNW1m2ZinVkMo73k+R7/ga65xo=;
        b=oZ4aEzRPdE5MOaJWRS23r2XVhOtk4Z2Z4kzBt+mxN7NFwiPUMd9Ngxx+RTlSMjy11gxCgV
        s9WHrJQT24mNDHhw8qcGCtkNondyVmWrrP/y4IJTARlXmG3zrC/IXytlJg1hepn5qXjsfk
        qEjdzdsh1Et/1YYR1JyN/NRHiwvmcrA5RMAX8wb+faCChLB3vSvNwkW0YWdoxoVyzq/GsK
        b9gW0BlharMSjbkigMay6k3D+uSL5joc3HEqDqcjPAgCz+40BnwrMDdC/BPfizx6i+JQLK
        pTLrhlAFq8risPcXjr8TpHksm2/J1KD4H5U+zJQpGJlX6bqdN/a3OkQ5msrQ7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694532742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g/nR9JmjEhE/8Ce9fpNW1m2ZinVkMo73k+R7/ga65xo=;
        b=g4CYkofUTPZYcoi6ZbZBbfnG7+CFbflFKJTZP84RO+4aW6zomtzPP87GoTtdM4xDvPIh84
        C/ZYbioPogTSyFAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
Subject: Re: [PATCH 07/15] sched/smp: Use lag to simplify cross-runqueue
 placement
Message-ID: <20230912153221.lSL8YgJJ@linutronix.de>
References: <20230531115839.089944915@infradead.org>
 <20230531124604.068911180@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230531124604.068911180@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-31 13:58:46 [+0200], Peter Zijlstra wrote:
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12492,22 +12440,9 @@ static void task_fork_fair(struct task_s
> =20
>  	cfs_rq =3D task_cfs_rq(current);
>  	curr =3D cfs_rq->curr;
> -	if (curr) {
> +	if (curr)
>  		update_curr(cfs_rq);
> -		se->vruntime =3D curr->vruntime;
> -	}
>  	place_entity(cfs_rq, se, 1);
> -
> -	if (sysctl_sched_child_runs_first && curr && entity_before(curr, se)) {

Since the removal of sysctl_sched_child_runs_first there is no user of
this anymore. There is still the sysctl file sched_child_runs_first with
no functionality.
Is this intended or should it be removed?

=E2=80=A6
>  	rq_unlock(rq, &rf);
>  }

Sebastian
