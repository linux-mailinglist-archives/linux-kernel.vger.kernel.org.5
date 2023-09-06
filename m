Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2265B7933B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjIFCSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 22:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjIFCSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:18:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6977C1A8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 19:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693966668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FD+vLjAAIdNk4teegrZeS0DQ5lQFiDJrgRy8bBiAJTA=;
        b=NM4En8Rh2bD5jwcep1QEuhAAp319eoS7ym24iYXt+8qWc9NtdJgydqPWxvG/JoJUAXUVH0
        ct7PYdpeYTsmkvY3Ym+w0WQjEa5V3Soy4Nsw/N8TPnT5ZpMKd4Bw7ixijoE8e3cFBLXfuc
        pTuQssavqGAK3v+oWz7Nru6NDAyXRbg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-96-5Oc00MgOm89IiuGTfIg-1; Tue, 05 Sep 2023 22:17:44 -0400
X-MC-Unique: 96-5Oc00MgOm89IiuGTfIg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3B4418DA722;
        Wed,  6 Sep 2023 02:17:43 +0000 (UTC)
Received: from [10.22.16.120] (unknown [10.22.16.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF3C8493110;
        Wed,  6 Sep 2023 02:17:42 +0000 (UTC)
Message-ID: <6ee54d73-d838-bbd9-b3a2-2eac276a05ea@redhat.com>
Date:   Tue, 5 Sep 2023 22:17:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: ARM BCM53573 SoC hangs/lockups caused by locks/clock/random
 changes
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        openwrt-devel@lists.openwrt.org,
        bcm-kernel-feedback-list@broadcom.com
References: <a03a6e1d-e99c-40a3-bdac-0075b5339beb@gmail.com>
 <c98e6c5b-d334-075f-71b8-1c2a3b73b205@redhat.com>
 <ZPX6W6q4+ECPbBmq@shell.armlinux.org.uk>
 <3e573810-d50c-9b54-7ea3-f1d82a7ca5b5@gmail.com>
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <3e573810-d50c-9b54-7ea3-f1d82a7ca5b5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/23 16:07, Florian Fainelli wrote:
>
>
> On 9/4/2023 8:40 AM, Russell King (Oracle) wrote:
>> On Mon, Sep 04, 2023 at 11:25:57AM -0400, Waiman Long wrote:
>>>
>>> On 9/4/23 04:33, Rafał Miłecki wrote:
>>>> As those hangs/lockups are related to so many different changes it's
>>>> really hard to debug them.
>>>>
>>>> This bug seems to be specific to the slow arch clock that affects
>>>> stability only when kernel locking code and symbols layout trigger 
>>>> some
>>>> very specific timing.
>>>>
>>>> Enabling CONFIG_PROVE_LOCKING seems to make issue go away but it 
>>>> affects
>>>> so much code it's hard to tell why it actually matters.
>>>>
>>>> Same for disabling CONFIG_SMP. I noticed Broadcom's SDK keeps it
>>>> disabled. I tried it and it improves stability (I had 3 devices with 6
>>>> days of uptime and counting) indeed. Again it affects a lot of kernel
>>>> parts so it's hard to tell why it helps.
>>>>
>>>> Unless someone comes up with some magic solution I'll probably try
>>>> building BCM53573 images without CONFIG_SMP for my personal needs.
>>>
>>> All the locking operations rely on the fact that the instruction to 
>>> acquire
>>> or release a lock is atomic. Is it possible that it may not be the case
>>> under certain circumstances for this ARM BCM53573 SoC? Or maybe some 
>>> Kconfig
>>> options are not set correctly like missing some errata that are needed.
>>>
>>> I don't know enough about the 32-bit arm architecture to say whether 
>>> this is
>>> the case or not, but that is my best guess.
>>
>> So, BCM53573 is Cortex-A7, which is ARMv7, which has the exclusive
>> load/store instructions. Whether the SoC has the necessary exclusive
>> monitors to support these instructions is another matter, and I
>> suspect someone with documentation would need to check that.
>
> Finding documentation about this SoC has been very difficult 
> unfortunately...
>
> Would any of the lock or mutex debugging self test catch hardware 
> designed without proper support for exclusive monitors in the DRAM 
> controller? Keep in mind this is an uni-processor system however, does 
> that mean we may have issues in our SMP_ON_UP alternative patching?

Usually this kind of locking problem is timing related and it happens 
once in a while. It is not easy to have a test to reliably figure out if 
there is a problem. I am not sure about the SMP_ON_UP thing.

Cheers,
Longman


