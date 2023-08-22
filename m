Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23C7783E96
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjHVLMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjHVLME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:12:04 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917721BE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 04:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1692702717;
        bh=6DDrD0tadqQZRrlLeU9jrF0T7tQr9NcgEa3Wy4ILh9Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kKF1t7IUonOyU04CNWQ0kE9nrFIdz8pkPhpuiRsMXqfSDzvJO1zi88v09buynQ7X+
         nHO5IThZc61JPkYejZzglH3TW7f3jqJF6ZRWuo3D+Kk5KmFSFDdsaoP4F/I+1nmy1a
         rlmpDCVPBGVuLdAaKNpzY1IdglJ+1Ylmw8N/PVOJDosSMPSXEyOwPj8r7WtvYsmr0a
         dOYiUa5tntOd/EOp7o9txiR+2rP0tW3Y54kSu43afLhezcf02h3PhAQ+KAX78LWkyO
         nLmEbjJ9Z6M+9vmBGM7sMv910+7HM06l63em7bHw8bViCWFGWtRsk+w8VHbIbir37Q
         n4Cm/K8WviRRg==
Received: from [192.168.18.201] (unknown [142.120.205.109])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RVRWK4QRsz1MGH;
        Tue, 22 Aug 2023 07:11:57 -0400 (EDT)
Message-ID: <e9310fe3-5094-6409-4aa8-e96ff69b67ef@efficios.com>
Date:   Tue, 22 Aug 2023 07:12:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC PATCH v2 2/3] sched: Introduce cpus_share_l2c
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>, x86@kernel.org
References: <20230818153027.202017-2-mathieu.desnoyers@efficios.com>
 <20230819123155.275094-1-mathieu.desnoyers@efficios.com>
 <20230822075801.GA76894@ziqianlu-dell>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230822075801.GA76894@ziqianlu-dell>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/23 03:58, Aaron Lu wrote:
> On Sat, Aug 19, 2023 at 08:31:55AM -0400, Mathieu Desnoyers wrote:
>> +#ifdef TOPOLOGY_CLUSTER_SYSFS
>> +static int cpu_get_l2c_info(int cpu, int *l2c_size, int *l2c_id)
>> +{
>> +	const struct cpumask *cluster_mask = topology_cluster_cpumask(cpu);
>> +
>> +	*l2c_size = cpumask_weight(cluster_mask);
>> +	*l2c_id = cpumask_first(cluster_mask);
>> +	return 0;
>> +}
>> +#else
>> +static int cpu_get_l2c_info(int cpu, int *l2c_size, int *l2c_id)
>> +{
>> +	return -1;
>> +}
>> +#endif
>> +
>>   static void update_top_cache_domain(int cpu)
>>   {
>>   	struct sched_domain_shared *sds = NULL;
>>   	struct sched_domain *sd;
>> -	int id = cpu;
>> -	int size = 1;
>> +	int id = cpu, size = 1, l2c_id, l2c_size;
>>   
>>   	sd = highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
>>   	if (sd) {
>> @@ -686,6 +704,14 @@ static void update_top_cache_domain(int cpu)
>>   		sds = sd->shared;
>>   	}
>>   
>> +	if (cpu_get_l2c_info(cpu, &l2c_id, &l2c_size)) {
> 
> Should be:  cpu_get_l2c_info(cpu, &l2c_size, &l2c_id)

Good point! Thanks for spotting it. I will fix it in a v3.

Mathieu

> 
>> +		/* Fallback on using LLC. */
>> +		l2c_size = size;
>> +		l2c_id = id;
>> +	}
>> +	per_cpu(sd_l2c_size, cpu) = l2c_size;
>> +	per_cpu(sd_l2c_id, cpu) = l2c_id;
>> +
>>   	rcu_assign_pointer(per_cpu(sd_llc, cpu), sd);
>>   	per_cpu(sd_llc_size, cpu) = size;
>>   	per_cpu(sd_llc_id, cpu) = id;
>> -- 
>> 2.39.2
>>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

