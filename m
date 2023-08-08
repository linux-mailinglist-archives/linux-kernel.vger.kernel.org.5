Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE88774F39
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 01:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjHHXUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 19:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjHHXUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 19:20:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5184219B6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 16:20:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691536809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BDRBfvZeiSTP1h6gDcENN+xIgQ/UkzF8VhG+WnIt7oI=;
        b=lv7upUUVfYsLvPfnNKeqdBy6ZB10rzjyILp3dEhd0T0FQiY7jR8arKkNWFvRHEst78pjc+
        8mzIGOzg19TED4AsVOI140DuQ7NYbd+zjWLQbBhVt9d5qM82W1zATO058LFACsTYiVhF83
        FGEfuFGx4ZUEXQEpUUpU5JJXa7rctuVwiH7BpY1jRkbMdhz10NjeVWSHCw6PY6aOmv8KV4
        9RIc6/9GE9MIWbmenAWIN1/p4YBs5RWADwnDyv/Ik2YkxRQyFJCFhvNEgr5a0I6ngqu1hO
        vyJbD11C4l+7hpVe05+uaW33vadSV6TG+Splg+kZuWKc2XkA9Ihjw66Je1hJtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691536809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BDRBfvZeiSTP1h6gDcENN+xIgQ/UkzF8VhG+WnIt7oI=;
        b=NZ0sFHv1IkdjTa9zUaQHDHf0oqbBcqvkSB+7ZAQ88s11FZ2mFcjkQlFZWezZq5zS2haPn6
        Zl3KRMKehhBkQ3Bw==
To:     Sohil Mehta <sohil.mehta@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [patch 00/53] x86/topology: The final installment
In-Reply-To: <ee7ee03c-43b0-a891-e94e-4a2eb7c5da64@intel.com>
References: <20230807130108.853357011@linutronix.de>
 <c8ca9e16-ce03-1fe0-cf9f-f6cc2302dbac@intel.com> <87h6p9l58u.ffs@tglx>
 <7ef60626-28ab-a4cc-2f24-4f35e3d946aa@intel.com> <87edkdl10w.ffs@tglx>
 <20230808221039.GH212435@hirez.programming.kicks-ass.net>
 <ee7ee03c-43b0-a891-e94e-4a2eb7c5da64@intel.com>
Date:   Wed, 09 Aug 2023 01:20:09 +0200
Message-ID: <87350tktp2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08 2023 at 15:58, Sohil Mehta wrote:

> On 8/8/2023 3:10 PM, Peter Zijlstra wrote:
>> It works better if you move this hunk into acpi_parse_x2apic() instead.
>> Then I can indeed confirm it works as advertised -- also having one of
>> them afflicted ivb-ep machines.
>> 
>
> I had a disappointed email typed up

Rightfully though as I'm clearly too tired and too grumpy to think
straight.
 
> and was about to send it when I saw this.

:)

> The inconsistency and warning on my system resolves with this. I lost
> 120 imaginary hotpluggable cpus but other than that everything seems
> fine :)

Sorry about that loss. :)

> CPU topo: Max. logical packages:   2
> CPU topo: Max. logical dies:       2
> CPU topo: Max. dies per package:   1
> CPU topo: Max. threads per core:   2
> CPU topo: Num. cores per package:    10
> CPU topo: Num. threads per package:  20
> CPU topo: Allowing 40 present CPUs plus 0 hotplug CPUs
> CPU topo: Thread    :    40
> CPU topo: Core      :    20
> CPU topo: Module    :     2
> CPU topo: Tile      :     2
> CPU topo: Die       :     2
> CPU topo: Package   :     2
>
> domain: Thread     shift: 1 dom_size:     2 max_threads:     2
> domain: Core       shift: 5 dom_size:    16 max_threads:    32
> domain: Module     shift: 5 dom_size:     1 max_threads:    32
> domain: Tile       shift: 5 dom_size:     1 max_threads:    32
> domain: Die        shift: 5 dom_size:     1 max_threads:    32
> domain: Package    shift: 5 dom_size:     1 max_threads:    32
>
> /sys/kernel/debug/x86/topo/cpus/39
> online:              1
> initial_apicid:      39
> apicid:              39
> pkg_id:              1
> die_id:              1
> cu_id:               255
> core_id:             12
> logical_pkg_id:      1
> logical_die_id:      1
> llc_id:              32
> l2c_id:              56
> amd_node_id:         0
> amd_nodes_per_pkg:   0
> num_threads:         20
> num_cores:           10
> max_dies_per_pkg:    1
> max_threads_per_core:2

That makes much more sense now.

Zhang, can you please follow up on:

  https://lore.kernel.org/all/613df280116378115585d0c483f7e186cffaeb58.camel@intel.com/

or otherwise I just polish up PeterZ's variant of it tomorrow.

Thanks,

        tglx
