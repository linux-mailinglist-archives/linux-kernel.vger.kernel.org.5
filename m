Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2938E78D26A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 05:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241808AbjH3DRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 23:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241812AbjH3DR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:17:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E2F8CCB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:17:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE4162F4;
        Tue, 29 Aug 2023 20:17:56 -0700 (PDT)
Received: from [10.163.58.191] (unknown [10.163.58.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D535F3F740;
        Tue, 29 Aug 2023 20:17:15 -0700 (PDT)
Message-ID: <c90a582d-37b9-4260-b82b-42cc7166773e@arm.com>
Date:   Wed, 30 Aug 2023 08:47:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm/mmap: Tighten up cmdline_parse_stack_guard_gap()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20230828052212.748872-1-anshuman.khandual@arm.com>
 <ZO3pz+3fAihhrtMU@casper.infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZO3pz+3fAihhrtMU@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/23 18:21, Matthew Wilcox wrote:
> On Mon, Aug 28, 2023 at 10:52:12AM +0530, Anshuman Khandual wrote:
>> -static int __init cmdline_parse_stack_guard_gap(char *p)
>> +static int __init cmdline_parse_stack_guard_gap(char *str)
>>  {
>>  	unsigned long val;
>> -	char *endptr;
>>  
>> -	val = simple_strtoul(p, &endptr, 10);
>> -	if (!*endptr)
>> -		stack_guard_gap = val << PAGE_SHIFT;
>> +	if (!str)
>> +		return 0;
> 
> Please explain how this function can be called with a NULL pointer.

This is an additional check just in case. We have similar constructs
in the following __setup() functions as well.

__setup("hashdist=", set_hashdist)
__setup("numa_balancing=", setup_numabalancing)
__setup("transparent_hugepage=", setup_transparent_hugepage)

Also it might be a better to warn, when returning unhandled with 0
like in those scenarios.

> 
>> -	return 1;
>> +	val = simple_strtoul(str, &str, 10);
>> +	if (!*str && val) {
>> +		stack_guard_gap = val << PAGE_SHIFT;
>> +		return 1;
>> +	}
>> +	return 0;
>>  }
> 
> Now you've removed the abillity for someone to say stack_guard_gap=0,
> which seems potentially useful.

In that case, should the following two scenarios be differentiated ?

* stack_guard_gap=	- Retains DEFAULT_STACK_GUARD_GAP
* stack_guard_gap=0	- Changes to 0 pages
