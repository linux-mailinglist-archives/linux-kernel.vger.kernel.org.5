Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4607B84B1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243235AbjJDQMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243260AbjJDQMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:12:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB94810EC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696435875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XiFNZxESte6xiokxDPwUzmpBYy6wkjDyf6f7P3Qz3QU=;
        b=REcRXKWbeIB/GFRiRv0t9wa6hic8yk1wrqAvF/CN5B2wD34bIrYMQrVAfRH1Jv6DSQh0X1
        Ms3loTQF5tqqWeBbMs8gUFzSm9kk7BBs9Mc3PgHZYlzMVW2b/RO6oZHgMOpj9E8ASzrbX7
        OUda86CH+JWpgtaIZvbT0i6rP79G9Oo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-Zq4VPg1SNhu54lA5yoBgFg-1; Wed, 04 Oct 2023 12:11:07 -0400
X-MC-Unique: Zq4VPg1SNhu54lA5yoBgFg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8E1B3804068;
        Wed,  4 Oct 2023 16:11:05 +0000 (UTC)
Received: from [10.22.32.136] (unknown [10.22.32.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A52D51004042;
        Wed,  4 Oct 2023 16:11:04 +0000 (UTC)
Message-ID: <946e6723-9635-1db1-d636-0a7904c40d40@redhat.com>
Date:   Wed, 4 Oct 2023 12:11:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 0/4] x86/speculation: Disable IBRS when idle
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org,
        Robin Jarry <rjarry@redhat.com>, Joe Mario <jmario@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20230727184600.26768-1-longman@redhat.com>
 <ZR1RePXx6/zZueI8@gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZR1RePXx6/zZueI8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/23 07:50, Ingo Molnar wrote:
> * Waiman Long <longman@redhat.com> wrote:
>
>> For Intel processors that need to turn on IBRS to protect against
>> Spectre v2 and Retbleed, the IBRS bit in the SPEC_CTRL MSR affects
>> the performance of the whole core even if only one thread is turning
>> it on when running in the kernel. For user space heavy applications,
>> the performance impact of occasionally turning IBRS on during syscalls
>> shouldn't be significant. Unfortunately, that is not the case when the
>> sibling thread is idling in the kernel. In that case, the performance
>> impact can be significant.
>>
>> When DPDK is running on an isolated CPU thread processing network packets
>> in user space while its sibling thread is idle. The performance of the
>> busy DPDK thread with IBRS on and off in the sibling idle thread are:
>>
>>                                  IBRS on         IBRS off
>>                                  -------         --------
>>    packets/second:                  7.8M           10.4M
>>    avg tsc cycles/packet:         282.26          209.86
>>
>> This is a 25% performance degradation. The test system is a Intel Xeon
>> 4114 CPU @ 2.20GHz.
> Ok, that's a solid improvement, and the feature has no obvious
> downsides, so I've applied your series to tip:sched/core with a few
> edits here and there.

Thanks!

-Longman

