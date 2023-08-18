Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD3678142C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 22:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379926AbjHRUMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 16:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379969AbjHRUMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 16:12:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E363C21
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 13:11:59 -0700 (PDT)
Received: from [IPV6:2001:861:4a40:8620:d901:c525:a85f:2da3] (unknown [IPv6:2001:861:4a40:8620:d901:c525:a85f:2da3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5B6116607258;
        Fri, 18 Aug 2023 21:11:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692389517;
        bh=RcFpcsfDPDN4mOQYH1rUm7zeWESMm9I//cj7N7OvWFE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nqiIjfCqUWZMEjYGR+ftRqsZtL4gFwYYJVRX6WJCxRikBLKl29bUqGoBXlnMtSxFl
         jeSRM++7KI8PNhBBpORtepuSA9vKv1sf+GsiYKILowCHvW4duMeemPimFZsrwHUrE5
         XhE2wBBSlnmKL9mS4w1tPK09pOcL0uu4tn5xOJtod3jN3cWWKn9I4CZqiC0ZsCpLqa
         mQND76skBt3hh6ltTmJdl7IdauQa9GOHwdjQLcNXatPr/UEWQIALFWyhzJE3bHkrg1
         MVH+4adf2DMiEEO75ERNzqhVtTL5UZeIhpM86wu4Qp2dtSdYC99i6R+/tQBrTlIWRt
         WMRus9Xf8QNCQ==
Message-ID: <517c702f-5b75-b999-2224-bc27951f03f3@collabora.com>
Date:   Fri, 18 Aug 2023 22:11:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: Kernel regression tracking/reporting initiatives and KCIDB
Content-Language: en-US
To:     =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
        kernelci@lists.linux.dev, gregkh@linuxfoundation.org,
        thorsten@leemhuis.info, regressions@lists.linux.dev
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>
References: <874jljhtmj.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me>
 <c7120c90-e40b-0433-0175-f23f928daa50@collabora.com>
 <87o7j4hjqc.fsf@collabora.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <87o7j4hjqc.fsf@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2023 09:50, Ricardo Cañuelo wrote:
> Hi,
> 
> On jue, ago 17 2023 at 15:32:21, Guillaume Tucker <guillaume.tucker@collabora.com> wrote:
>> With the new API, data is owned by the users who submit it so we can
>> effectively provide a solution for grouping data from multiple CI
>> systems like KCIDB does.
>>
>> The key thing here is that KernelCI as a project will be
>> providing a database with regression information collected from
>> any public CI system.
> 
> Does this mean that KernelCI will replace KCIDB? or will they both keep
> working separately?

Like I wrote, how it will be implemented is still being
discussed.  But I think we all agree it makes sense to have a
single database for KernelCI with an API to access it.  For
example, the new API could be directly based on the KCIDB schema
etc. or KCIDB could become a translation layer on top of the new
API.  Or something else could happen a bit later.  But that
doesn't matter as far as this discussion about regressions is
concerned, there should eventually be a single source of data for
regressions collected by KernelCI and that will be shared by what
we currently refer to as the new API and KCIDB.

>> So the topic of tracking regressions for the whole kernel is already
>> part of the roadmap for KernelCI, and if just waiting for CI systems
>> to push data is not enough we can have services that actively go and
>> look for regressions to feed them into the database under a particular
>> category (or user).
>> It would be good to align ideas you may have with KernelCI's
>> plans
> 
> Our ideas start by studying the required features and needs for
> regression analysis, reporting and tracking in a general and
> system-agnostic way. First the concepts, then the implementation. I
> think that analyzing the problem from the specific perspective of
> KernelCI (or any other CI system in particular). If we start with a
> general approach we can always specialize it later to a particular
> implementation, but starting a design with a restricted design in mind,
> tailored to a specific system, will probably tie it to that system
> permanently.
> 
> IMO the work we want to do with regressions should be higher-level,
> based on the data produced by a CI system (any of them) and not
> dependent on any particular implementation.

KernelCI is not any CI, it's designed to be the main system for
the upstream kernel.  So it already took the high-level approach
to look at all this after becoming an LF project and we came up
with KCIDB and now the new API as the community still needs
an "active" system and not just a database for collecting data
from other systems.

>> also please take into account the fact that the current
>> Regression tracker you've created relies on the legacy system
>> which is going to be retired in the coming months.
> 
> That's correct. The regression tracker started as a proof of concept to
> explore ideas and we based it on KernelCI test data. We're aware that
> the legacy system will be retired soon, that's why we want to look into
> KCIDB as a data source.

Right, except you might hit another deprecation hurdle if we
start changing how things are designed around KCIDB and the new
API.  There's no doubt KCIDB will be supported for a long time,
but taking into considerations all the new developments can save
you a lot of trouble.

>>> - did this test also fail on other hardware targets or with other kernel
>>>   configurations?
>>> - is it possible that the test failed because of an infrastructure
>>>   error?
>>
>> This should be treated as a false-positive failing test rather
>> than a "regression".  But yes of course we need to deal with
>> them, it's just slightly off-topic here I think.
> 
> Not regressions, that's right, but I don't think these should be simply
> categorized as false-positives. If we treated these two particular cases
> as false positives we would be hiding and missing important results:
> 
> - If the same test case on the same kernel version failed with different
>   configurations or in other boards, highlighting that information could
>   help narrow down the investigation or point it to the right
>   direction. There's definitely a failure (probablyl not a regression)
>   but the thing to fix might not be a kernel code commit but the
>   configuration used for the test. This can be submitted to the test
>   authors or the maintainers of the CI system running the test.
> 
> - If the test failed because of an infrastructure error, that's
>   something that can be reported to the lab maintainers to fix. This can
>   be done automatically.

Sure, these things are important too.  I just wanted to say
they're not regressions per se.  There are lots of other things
that can be done to report issues to "lab" owners or anyone in
charge or test infrastructure.  It's just a different category.

>>> - does the test fail consistently since that commit or does it show
>>>   unstable results?
>>> - does the test output show any traces of already known bugs?
>>> - has this regression been bisected and reported anywhere?
>>> - was the regression reported by anyone? If so, is there someone already
>>>   working on it?
>>
>> These are all part of the post-regression checks we've been
>> discussing to run as part of KernelCI.  Basically, extending from
>> the current automated bisection jobs we have and also taking into
>> account the notion of dynamic scheduling.  However, when
>> collecting data from other CI systems I don't think there is much
>> we can do if the data is not there.  But we might be able to
>> create collaborations to run extra post-regression checks in
>> other CI systems to tackle this.
> 
> This is why I think handling this at a higher level, once all the test
> data from multiple CI systems has been collected, could be the right
> strategy. Can't these post-regression checks be applied to a common DB
> with results aggregated from different CI systems? As long as the
> results are collected in a common and standard way, I mean.  We could
> have those checks implemented only once, in a centralized and generic
> way, instead of having a different implementation of the same process in
> each of the data sources.
> 
>> Experimenting with KCIDB now may be interesting, but depending on
>> the outcome of the discussions around having one central database
>> for KernelCI it might not be the optimal way to do it.
> 
> Why not? Sorry, I might not have the full context, can you or Nikolai
> give a bit more insight about the possible future status of KCIDB and
> KernelCI and the relationship between them?

We don't have such insight right now, as I explained earlier.
However, this means you could also play a role in shaping things
up based on your findings so far.  Everyone is welcome to join
the discussion.  It has been informal chats in weekly video calls
so far but we should start keeping track of things in a more
formal way soon.

My point here is that KernelCI started tackling this issue of
reporting kernel bugs several years ago at a very high level and
we've come up with some carefully engineered solutions for it, so
it looks like you're walking in our footsteps now.  The new web
dashboard, new API & Pipeline and KCIDB which pioneered working
outside the native realm of KernelCI provide some answers to the
challenges you're currently investigating.  So maybe it is
actually the best strategy for you to carry on doing things
independently, but it would seem to me like due diligence for
each of us to know what others are doing.  This email thread
contributes to it, and I can only thank you for starting it and
encourage more communication of this kind.

Thanks,
Guillaume
