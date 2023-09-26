Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4597AED34
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbjIZMtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbjIZMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:49:00 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778A7FB;
        Tue, 26 Sep 2023 05:48:53 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.39.103.33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 744923F1DB;
        Tue, 26 Sep 2023 12:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695732531;
        bh=gsf5Dcm+oBvt0OepvgcW/nShbExlI1OvGeUPMDjYhrI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=II5niPaDBIMHxuG6ai8j6A+VHw++umAb1/E4ACNhGAdkyVH69wgavwqr9ZPIjClHR
         GkhrpvCUh6Sin2lx08+/pC+RXzF0HBSDDicEpaWmCUDSZUjD8jfDv3zDsxjslbtY6h
         hr8z09Ow0rPItwwHeOTESsnnk8+4Fc8E4xfegqpIEV1mOldn5bgUhNKttg/k2/zTyv
         OPOfMkrjEAYnEIggXcNXOdje0KMrIGUgy++xBlAk99wZSB5lgKoUMMPJF+fWKMa6rw
         Y99dUivatZ1SI/YtvFM6C0czTelLMOLT2p3RBoY4ZKCvkjBsmjKQpanbiHUJnUv2i8
         IV/tgYC3HBivg==
Message-ID: <a3635704-3585-2d3e-8882-e7c9ce63a720@canonical.com>
Date:   Tue, 26 Sep 2023 05:48:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [apparmor] use per-cpu refcounts for apparmor labels?
Content-Language: en-US
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-kernel@vger.kernel.org
References: <CAGudoHFfG7mARwSqcoLNwV81-KX4Bici5FQHjoNG4f9m83oLyg@mail.gmail.com>
 <87a5t9bypm.fsf@intel.com>
 <c6379a39-42f2-b3f9-c835-bbebe516ba3a@canonical.com>
 <20230926063857.h3afce5hagnlkoob@f>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230926063857.h3afce5hagnlkoob@f>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/23 23:38, Mateusz Guzik wrote:
> On Mon, Sep 25, 2023 at 11:21:26PM -0700, John Johansen wrote:
>> On 9/25/23 16:49, Vinicius Costa Gomes wrote:
>>> Hi Mateusz,
>>>
>>> Mateusz Guzik <mjguzik@gmail.com> writes:
>>>
>>>> I'm sanity-checking perf in various microbenchmarks and I found
>>>> apparmor to be the main bottleneck in some of them.
>>>>
>>>> For example: will-it-scale open1_processes -t 16, top of the profile:
>>>>     20.17%  [kernel]                   [k] apparmor_file_alloc_security
>>>>     20.08%  [kernel]                   [k] apparmor_file_open
>>>>     20.05%  [kernel]                   [k] apparmor_file_free_security
>>>>     18.39%  [kernel]                   [k] apparmor_current_getsecid_subj
>>>> [snip]
>>>>
>>>> This serializes on refing/unrefing apparmor objs, sounds like a great
>>>> candidate for per-cpu refcounting instead (I'm assuming they are
>>>> expected to be long-lived).
>>>>
>>>> I would hack it up myself, but I failed to find a clear spot to switch
>>>> back from per-cpu to centalized operation and don't want to put
>>>> serious effort into it.
>>>>
>>>> Can you sort this out?
>>>
>>
>> I will add looking into it on the todo list. Its going to have to come
>> after some other major cleanups land, and I am not sure we can make
>> the semantic work well for some of these. For other we might get away
>> with switching to a critical section like Vinicius's patch has done
>> for apparmor_current_getsecid_subj.
>>
> 
> Is there an eta?
> 
sorry no

> I looked at dodging ref round trips myself, but then found that ref
> manipulation in apparmor_file_alloc_security and the free counterpart
> cannot be avoided. Thus per-cpu refs instead.
> 

right for file_aloc/free, I don't see a way around keeping a ref count.

> Perhaps making the label as stale would be a good enough switching
> point? Is it *guaranteed* to get labelled as stale before it gets freed?
> 
no. the stale flag only indicates the label has been replaced, and we
make no guarentees as to when it will get set/be in use beyond so
point after it happens.

> btw, __aa_proxy_redirect open-codes setting the flag.
> 
yes, I am aware.

>>> I was looking at this same workload, and proposed a patch[1] some time
>>> ago, see if it helps:
>>>
>>> https://lists.ubuntu.com/archives/apparmor/2023-August/012914.html
>>>
>>> But my idea was different, in many cases, we are looking at the label
>>> associated with the current task, and there's no need to take the
>>> refcount.
>>>
>>
>> yes, and thanks for that.
>>

