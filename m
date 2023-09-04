Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C87791E24
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 22:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjIDURN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 16:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjIDURM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 16:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9432D187
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 13:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693858582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kGoBgsQFryqGjj7NkhmyfIdQDuJkRXBECyY4eqxV61U=;
        b=hDH8gqtTYYyLc4pW+9XYD1uBTnvXN/ifde+gde5lGyG1+ETE4aEo3aSyLGGhAhXeL8Enee
        DujN6waly7FidvrwPFqFuij3kR0mDYN4GOqXNVTkVn7Hqc/HC8Mz9PwD+Ps533RGKHwS20
        jnGtg3bSFg63GoqVKtb4OlT/90TqE3c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-nqZ8nfniN1qcoiVAW_bmIQ-1; Mon, 04 Sep 2023 16:16:17 -0400
X-MC-Unique: nqZ8nfniN1qcoiVAW_bmIQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFF9D8008A4;
        Mon,  4 Sep 2023 20:16:16 +0000 (UTC)
Received: from [10.22.8.119] (unknown [10.22.8.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AAE8140E966;
        Mon,  4 Sep 2023 20:16:15 +0000 (UTC)
Message-ID: <ad726bb4-fbd1-389c-4978-03eec77b4322@redhat.com>
Date:   Mon, 4 Sep 2023 16:16:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: ARM BCM53573 SoC hangs/lockups caused by locks/clock/random
 changes
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        openwrt-devel@lists.openwrt.org,
        bcm-kernel-feedback-list@broadcom.com
References: <a03a6e1d-e99c-40a3-bdac-0075b5339beb@gmail.com>
 <c98e6c5b-d334-075f-71b8-1c2a3b73b205@redhat.com>
 <ZPX6W6q4+ECPbBmq@shell.armlinux.org.uk>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZPX6W6q4+ECPbBmq@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/23 11:40, Russell King (Oracle) wrote:
> On Mon, Sep 04, 2023 at 11:25:57AM -0400, Waiman Long wrote:
>> On 9/4/23 04:33, Rafał Miłecki wrote:
>>> As those hangs/lockups are related to so many different changes it's
>>> really hard to debug them.
>>>
>>> This bug seems to be specific to the slow arch clock that affects
>>> stability only when kernel locking code and symbols layout trigger some
>>> very specific timing.
>>>
>>> Enabling CONFIG_PROVE_LOCKING seems to make issue go away but it affects
>>> so much code it's hard to tell why it actually matters.
>>>
>>> Same for disabling CONFIG_SMP. I noticed Broadcom's SDK keeps it
>>> disabled. I tried it and it improves stability (I had 3 devices with 6
>>> days of uptime and counting) indeed. Again it affects a lot of kernel
>>> parts so it's hard to tell why it helps.
>>>
>>> Unless someone comes up with some magic solution I'll probably try
>>> building BCM53573 images without CONFIG_SMP for my personal needs.
>> All the locking operations rely on the fact that the instruction to acquire
>> or release a lock is atomic. Is it possible that it may not be the case
>> under certain circumstances for this ARM BCM53573 SoC? Or maybe some Kconfig
>> options are not set correctly like missing some errata that are needed.
>>
>> I don't know enough about the 32-bit arm architecture to say whether this is
>> the case or not, but that is my best guess.
> So, BCM53573 is Cortex-A7, which is ARMv7, which has the exclusive
> load/store instructions. Whether the SoC has the necessary exclusive
> monitors to support these instructions is another matter, and I
> suspect someone with documentation would need to check that.

To clarify, it is not necessary to use atomic instruction as in x86, but 
the LL/SC style of synchronization instructions with proper hardware 
support should also be enough. Again the hardware needs to have the 
proper support for the correct operation of those synchronization 
instructions.

Cheers,
Longman

