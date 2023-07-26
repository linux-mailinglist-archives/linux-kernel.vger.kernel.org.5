Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A34763F52
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjGZTPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGZTPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:15:50 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C262717
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 12:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1690398947;
        bh=bmzxxv67tO74PHxuba7Soe8mJqMyNYizlfnKxsPM08M=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Slz40rBcNg5VBnPJlKmJcQgcc8zXDXXHfi6GWanPrskFbpWCnLbrOfXifHHKsJI6i
         dZc19fNna8rfODN/zP4QJldpojme4UPn93dg2dDy0Z88M95iT0oMXL5uwvLOZ8x3Ai
         Y9psfhQ2en9M2jm7p5YX7KWX8btM+e5r85mtch1VCzH87wMGgbd++0SJGjgsviyUKG
         ev9SJLRAjLsYnvz8xp1fiKOQslL5lRIHsFax/UGqPO9GLh4gH/oBrOSc19u7MJRqlA
         jatlWQqBFtvtsRLvHq5/atYit2VYplL2v0AbGqBntIL6uOV28qgX1zF6lqBUYeC7gC
         8KLxl2bh7Ex7g==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RB3X25JQJz1JsM;
        Wed, 26 Jul 2023 15:15:46 -0400 (EDT)
Message-ID: <934429dc-03d7-f7d4-8828-723e756f1411@efficios.com>
Date:   Wed, 26 Jul 2023 15:16:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 1/1] sched: Extend cpu idle state for 1ms
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20230725193048.124796-1-mathieu.desnoyers@efficios.com>
 <69076f8e-191b-2e3e-d810-ea72d8ff18bb@linux.vnet.ibm.com>
 <79fa8a62-a74e-2623-9f03-1f1af85b6c07@efficios.com>
 <cab82676-27fd-b4e1-2cd8-3d8d26b44aa0@linux.vnet.ibm.com>
 <447f756c-9c79-f801-8257-a97cc8256efe@efficios.com>
In-Reply-To: <447f756c-9c79-f801-8257-a97cc8256efe@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 14:56, Mathieu Desnoyers wrote:
> On 7/26/23 13:40, Shrikanth Hegde wrote:
[...]
>> Do you have SMT here? What is the system utilization when you are running
>> this workload?
> 
> Yes, SMT is enabled, which brings the number of logical cpus to 384.

Here is an additional interesting data point with nosmt=force on
6.4.4:

hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100

baseline:                       90s
with idle-delay+nr_running<=4:  87s (3% speedup)

hackbench -g 16 -f 20 --threads --pipe -l 480000 -s 100

baseline:                       52s
with idle-delay+nr_running<=4:  32s (38% speedup)

So the impact of the patch appears to depend on how much the
system actually reaches idle, which does make sense.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

