Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C55F780F66
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378245AbjHRPjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378271AbjHRPjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:39:06 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4CF2D58
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1692373141;
        bh=f3GFZTKBPPgbTBG9uqbhkRDmV77fsx2Y6fqXVVYpaTI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DIlPG9Li0AyjiKbIIcSBY9VWJYYNtPx3jNkC3LpO8TwmwXFTJQULAwN9PSDTFHjBB
         N9uDinE1oLIeSfy79SxQyxgg3n1UK+Gr1fNzgw84vb0oVzu3S/1KdQ1CW9cwLs/DIj
         2kQIIhgTwPNIc42l5XmK8pLSEmG+KK3kxnyRVSr1DQXVrVNh2takTpMY6t1MevW0Rg
         jIU9GufYC/SjA10gieQIGFyN3lE3ViRJMSlU3OT8gcThlhBAMWHdjfLWicCKAfarXV
         0l5Gt+6OUm2Y48cwGjiDf6kvU+aFZSrKczGYw6tiqcr2BU46Oe8Vchv2R7cxO/RBAT
         IbNdfSYxOOJ6A==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RS5dK2Vw7z1LfG;
        Fri, 18 Aug 2023 11:39:01 -0400 (EDT)
Message-ID: <21d002b1-442b-737d-6837-677256549435@efficios.com>
Date:   Fri, 18 Aug 2023 11:40:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH 2/3] sched: Introduce cpus_share_l2c
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>, x86@kernel.org
References: <20230818153027.202017-1-mathieu.desnoyers@efficios.com>
 <20230818153027.202017-2-mathieu.desnoyers@efficios.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230818153027.202017-2-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/23 11:30, Mathieu Desnoyers wrote:
[...]
>   
> +	cluster_mask = topology_cluster_cpumask(cpu);
> +	l2c_size = cpumask_weight(cluster_mask);
> +	if (l2c_size == 1) {
> +		/* Fallback on using LLC. */
> +		l2c_size = size;
> +		l2c_id = id;
> +	}

For the fallback case, this should be:

         cluster_mask = topology_cluster_cpumask(cpu);
         l2c_size = cpumask_weight(cluster_mask);
         if (l2c_size == 1) {
                 /* Fallback on using LLC. */
                 l2c_size = size;
                 l2c_id = id;
         } else {
                 l2c_id = cpumask_first(cluster_mask);
         }
         per_cpu(sd_l2c_id, cpu) = l2c_id;
         per_cpu(sd_l2c_size, cpu) = l2c_size;

Thanks,

Mathieu


> +	l2c_id = cpumask_first(cluster_mask);
> +	per_cpu(sd_l2c_id, cpu) = l2c_id;
> +	per_cpu(sd_l2c_size, cpu) = l2c_size;
> +
>   	rcu_assign_pointer(per_cpu(sd_llc, cpu), sd);
>   	per_cpu(sd_llc_size, cpu) = size;
>   	per_cpu(sd_llc_id, cpu) = id;

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

