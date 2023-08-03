Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FA476E54C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbjHCKMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbjHCKMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:12:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE5AE171B;
        Thu,  3 Aug 2023 03:12:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D8AB113E;
        Thu,  3 Aug 2023 03:13:25 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [10.57.78.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DA093F5A1;
        Thu,  3 Aug 2023 03:12:38 -0700 (PDT)
Date:   Thu, 3 Aug 2023 11:12:30 +0100
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     anna-maria@linutronix.de, rafael@kernel.org, tglx@linutronix.de,
        frederic@kernel.org, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, kajetan.puchalski@arm.com
Subject: Re: [RFC][PATCH v2 3/5] cpuidle/teo: Simplify a little
Message-ID: <ZMt9jooB4HV/5uXp@e126311.manchester.arm.com>
References: <20230802132431.254614419@infradead.org>
 <20230802132925.686745535@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802132925.686745535@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 03:24:34PM +0200, Peter Zijlstra wrote:
> Remove some of the early exit cases that rely on state_count, since we
> have the additional tick state. Declutters some of the next patches, can
> possibly be re-instated later if desired.

How does having that added tick state compensate for not checking the
amount of states that the governor can choose from in the first place?

[...]

> -	/* Check if there is any choice in the first place. */
> -	if (drv->state_count < 2) {
> -		idx = 0;
> -		goto end;
> -	}
> -	if (!dev->states_usage[0].disable) {
> -		idx = 0;
> -		if (drv->states[1].target_residency_ns > duration_ns)
> -			goto end;
> -	}
> -
> -	cpu_data->utilized = teo_cpu_is_utilized(dev->cpu, cpu_data);
> -	/*
> -	 * If the CPU is being utilized over the threshold and there are only 2
> -	 * states to choose from, the metrics need not be considered, so choose
> -	 * the shallowest non-polling state and exit.
> -	 */
> -	if (drv->state_count < 3 && cpu_data->utilized) {
> -		for (i = 0; i < drv->state_count; ++i) {
> -			if (!dev->states_usage[i].disable &&
> -			    !(drv->states[i].flags & CPUIDLE_FLAG_POLLING)) {
> -				idx = i;
> -				goto end;
> -			}
> -		}
> -	}

What exactly is the benefit of removing this part? On systems with 2
idle states this will just make the governor pointlessly execute the
metrics code when the result is already known regardless. Seems like
pure added overhead.

> -
>  	/*
>  	 * Find the deepest idle state whose target residency does not exceed
>  	 * the current sleep length and the deepest idle state not deeper than
> @@ -541,7 +512,7 @@ static int teo_select(struct cpuidle_dri
>  	 * If the CPU is being utilized over the threshold, choose a shallower
>  	 * non-polling state to improve latency
>  	 */
> -	if (cpu_data->utilized)
> +	if (teo_cpu_is_utilized(dev->cpu, cpu_data))
>  		idx = teo_find_shallower_state(drv, dev, idx, duration_ns, true);
>  
>  end:
> 
> 
