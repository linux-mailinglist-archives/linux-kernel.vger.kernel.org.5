Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6CC7631E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjGZJZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjGZJZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8686B1985
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690363365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sk/PJvGKnh/DBuIKg5Yct3fF7G6zPABpNJl6TJTyRnA=;
        b=L5bMqMN4vBySdMeXN3wy89GBhQyjs6tdPlKHJcjyQfsM2LYz0UHjmUO5aEGp4r2xwT7vKy
        vWdSUGDRdjtJSsV1J+XjXs/kITyLyPYY+UxYjjRFEUuR6Bf2QF63Vz4R5P9siCP3t70S4r
        4kz0dtM2Coy/I/5DDuEIl8IYOz4BKEA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-7Zv4_6GaNWe-JXkn8zqAiQ-1; Wed, 26 Jul 2023 05:22:44 -0400
X-MC-Unique: 7Zv4_6GaNWe-JXkn8zqAiQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9932e8e76b9so532783266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:22:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690363363; x=1690968163;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sk/PJvGKnh/DBuIKg5Yct3fF7G6zPABpNJl6TJTyRnA=;
        b=IcEIDV9Fjpv1Z64dq6TuSOmnH65b7RHcbzCiZHVzTeDR3KXtZm2stUTVjD2M65Z+Zh
         1ao+JT6TBQfRNawnm308viVHFRRAxWwBwEoNKk5MHSeBAH7CDu5yvSHbExw7ROoTQgiO
         vXn3gxrqFlUk9fRID+TKDXMDTCtKUpyoDzezJSotjjmaIw+Z7MyLLVEc9w5Ds+CI27Sq
         nZT0yJSEDSdeb86+JV6rYC1oYRnKG78au2r4lBuAcVpTeW/SaAjlR1aMO682LcrIYFHp
         uLadfrpHeyjYGp487jV9fguQboIcs7VpsLFVS+eowXa7StQpsbg5g3FJi0z5XQT2G749
         Ah8Q==
X-Gm-Message-State: ABy/qLZVCRmkcBp2Z38FDImj20S26epu2w0UrTos+cpZrgAmtiANQwI1
        bCgbt/6lURZqdL3C5uP+SEIZNpHJX6Jj85MRD0owbgewwcSnkOf0TahwgntsIg0Jg3L1AB5dPJ2
        LpO31yBxBJu9SzOIhd6gHULCw
X-Received: by 2002:a17:906:7a57:b0:994:4e16:d430 with SMTP id i23-20020a1709067a5700b009944e16d430mr1366791ejo.20.1690363363453;
        Wed, 26 Jul 2023 02:22:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFxJiPkcQtMLhAVgg8mHrSnrgOR7Jaaj/757VyQ9wgV7p4JZKyo7863vYBZ/msQVa/a9QHdjw==
X-Received: by 2002:a17:906:7a57:b0:994:4e16:d430 with SMTP id i23-20020a1709067a5700b009944e16d430mr1366773ejo.20.1690363363145;
        Wed, 26 Jul 2023 02:22:43 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090629c700b009887f4e0291sm9211263eje.27.2023.07.26.02.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 02:22:42 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <6396223c-6008-0e1b-e6ed-79c04c87a5e0@redhat.com>
Date:   Wed, 26 Jul 2023 11:22:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com, Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Paul Rosswurm <paulros@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        Long Li <longli@microsoft.com>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH V3,net-next] net: mana: Add page pool for RX buffers
Content-Language: en-US
To:     Haiyang Zhang <haiyangz@microsoft.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <1689966321-17337-1-git-send-email-haiyangz@microsoft.com>
 <1af55bbb-7aff-e575-8dc1-8ba64b924580@redhat.com>
 <PH7PR21MB3116F8A97F3626AB04915B96CA02A@PH7PR21MB3116.namprd21.prod.outlook.com>
 <PH7PR21MB311675E57B81B49577ADE98FCA02A@PH7PR21MB3116.namprd21.prod.outlook.com>
 <729b360c-4d79-1025-f5be-384b17f132d3@redhat.com>
 <PH7PR21MB3116F5612AA8303512EEBA4CCA03A@PH7PR21MB3116.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB3116F5612AA8303512EEBA4CCA03A@PH7PR21MB3116.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/07/2023 21.02, Haiyang Zhang wrote:
> 
>> -----Original Message-----
>> From: Jesper Dangaard Brouer <jbrouer@redhat.com>
>> Sent: Tuesday, July 25, 2023 2:01 PM
>>>>
>>>> Our driver is using NUMA 0 by default, so I implicitly assign NUMA node id
>>>> to zero during pool init.
>>>>
>>>> And, if the IRQ/CPU affinity is changed, the page_pool_nid_changed()
>>>> will update the nid for the pool. Does this sound good?
>>>>
>>>
>>> Also, since our driver is getting the default node from here:
>>> 	gc->numa_node = dev_to_node(&pdev->dev);
>>> I will update this patch to set the default node as above, instead of implicitly
>>> assigning it to 0.
>>>
>>
>> In that case, I agree that it make sense to use dev_to_node(&pdev->dev),
>> like:
>> 	pprm.nid = dev_to_node(&pdev->dev);
>>
>> Driver must have a reason for assigning gc->numa_node for this hardware,
>> which is okay. That is why page_pool API allows driver to control this.
>>
>> But then I don't think you should call page_pool_nid_changed() like
>>
>> 	page_pool_nid_changed(rxq->page_pool, numa_mem_id());
>>
>> Because then you will (at first packet processing event) revert the
>> dev_to_node() setting to use numa_mem_id() of processing/running CPU.
>> (In effect this will be the same as setting NUMA_NO_NODE).
>>
>> I know, mlx5 do call page_pool_nid_changed(), but they showed benchmark
>> numbers that this was preferred action, even-when sysadm had
>> "misconfigured" the default smp_affinity RX-processing to happen on a
>> remote NUMA node.  AFAIK mlx5 keeps the descriptor rings on the
>> originally configured NUMA node that corresponds to the NIC PCIe slot.
> 
> In mana_gd_setup_irqs(), we set the default IRQ/CPU affinity to gc->numa_node
> too, so it won't revert the nid initial setting.
> 
> Currently, the Azure hypervisor always indicates numa 0 as default. (In
> the future, it will start to provide the accurate default dev node.) When a
> user manually changes the IRQ/CPU affinity for perf tuning, we want to
> allow page_pool_nid_changed() to update the pool. Is this OK?
> 

If I were you, I would wait with the page_pool_nid_changed()
"optimization" and do a benchmark mark to see if this actually have a
benefit.  (You can do this in another patch).  (In a Azure hypervisor
environment is might not be the right choice).

This reminds me, do you have any benchmark data on the improvement this
patch (using page_pool) gave?

--Jesper

