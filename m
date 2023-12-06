Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9241807902
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442824AbjLFTzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379411AbjLFTzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:55:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9E7BA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 11:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701892508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNtxqmUk2Bs7YzOVHZEViZ/O+MeQgcYuxCuXpozAJVI=;
        b=EXRJz7nrqHYl9sysJtmea2Ko2v3e/RDUwJDsquaBU//hfrYImAG7fzrqyLN8OwRGmeAWGK
        Mz0nmCHrKHis6Ya3f5H22/c8/ae72wYfaxtgm1Nt/csWGGM97tX8WDK4Wzsl+/COk0wCTw
        zFXuWXgLLIej5Ugds5gimTWmWz3RUNE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-ByAVxrI-NsefLpf8FgfzwA-1; Wed, 06 Dec 2023 14:55:05 -0500
X-MC-Unique: ByAVxrI-NsefLpf8FgfzwA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40c18e668faso1150315e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 11:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701892504; x=1702497304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNtxqmUk2Bs7YzOVHZEViZ/O+MeQgcYuxCuXpozAJVI=;
        b=O84UbhTdR3r+sA6hNYrrBijd6YVYTFb1Mh2PiT5go8mSQ8fi2Ke7pUdDcWBnUX/TMc
         xjSFkqiEycaQA9KSBLCBnWTWplES2YY0uGOuE+fOOFdgA3QG/yC78koyUgw0XVAW4sx7
         zu2LjlmzRMq4KO8OvtZ+aLpIV8UxAVISVeZfDTcWj/CAkf62xstBvKMpjF8+uO8l5Jwg
         ePe2rPcmoMfHyQ1rYOttv3jzhAmuchobbBoPNbTuuweLK6OdTMmW8NV+nyEO9Rl24+Q5
         Sv7NoIPwb7idfRrvA53wfwNkGqOvmdphDOGGQh3pNmaBeN4eAw08PxUae2pegqvsCt+h
         0Vuw==
X-Gm-Message-State: AOJu0YyuNrBTkyvkv6heNo8MMvx1m2A+oWr4IgtvL+NtledJcAl20Ki5
        DSZ1tbTw3SGKXHxLvNRDp/liNFl2+KSrpOTxssNHkWRB70cacO6SOYOR8eW4FGlez/zxjsL6emw
        XK+jPqfh1w4ZHfxS2V9FntYG7
X-Received: by 2002:a1c:7909:0:b0:40c:c1a:cfac with SMTP id l9-20020a1c7909000000b0040c0c1acfacmr568912wme.158.1701892503951;
        Wed, 06 Dec 2023 11:55:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHnky6uLpyWb8bqYMMFni4xX3EDvcb9YnlGZqz8FxzcndfpsjoChNLslaWPUEOk6wlicauAww==
X-Received: by 2002:a1c:7909:0:b0:40c:c1a:cfac with SMTP id l9-20020a1c7909000000b0040c0c1acfacmr568903wme.158.1701892503589;
        Wed, 06 Dec 2023 11:55:03 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id r19-20020a1709067fd300b00a1cbb289a7csm341617ejs.183.2023.12.06.11.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 11:55:03 -0800 (PST)
Message-ID: <580ecff0-b335-4cc0-b928-a99fe73741ca@redhat.com>
Date:   Wed, 6 Dec 2023 20:55:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] devm-helpers: introduce devm_mutex_init
Content-Language: en-US, nl
To:     George Stark <gnstark@salutedevices.com>, pavel@ucw.cz,
        lee@kernel.org, vadimp@nvidia.com, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        mazziesaccount@gmail.com, andy.shevchenko@gmail.com,
        jic23@kernel.org, peterz@infradead.org,
        Waiman Long <longman@redhat.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel@salutedevices.com
References: <20231204180603.470421-1-gnstark@salutedevices.com>
 <20231204180603.470421-2-gnstark@salutedevices.com>
 <81798fe5-f89e-482f-b0d0-674ccbfc3666@redhat.com>
 <29584eb6-fa10-4ce0-9fa3-0c409a582445@salutedevices.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <29584eb6-fa10-4ce0-9fa3-0c409a582445@salutedevices.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/6/23 19:58, George Stark wrote:
> 
> Hello Hans
> 
> Thanks for the review.
> 
> On 12/6/23 18:01, Hans de Goede wrote:
>> Hi George,
>>
>> On 12/4/23 19:05, George Stark wrote:
>>> Using of devm API leads to certain order of releasing resources.
>>> So all dependent resources which are not devm-wrapped should be deleted
>>> with respect to devm-release order. Mutex is one of such objects that
>>> often is bound to other resources and has no own devm wrapping.
>>> Since mutex_destroy() actually does nothing in non-debug builds
>>> frequently calling mutex_destroy() is just ignored which is safe for now
>>> but wrong formally and can lead to a problem if mutex_destroy() is
>>> extended so introduce devm_mutex_init().
>>>
>>> Signed-off-by: George Stark <gnstark@salutedevices.com>
>>> ---
>>>   include/linux/devm-helpers.h | 18 ++++++++++++++++++
>>>   1 file changed, 18 insertions(+)
>>>
>>> diff --git a/include/linux/devm-helpers.h b/include/linux/devm-helpers.h
>>> index 74891802200d..2f56e476776f 100644
>>> --- a/include/linux/devm-helpers.h
>>> +++ b/include/linux/devm-helpers.h
>>> @@ -76,4 +76,22 @@ static inline int devm_work_autocancel(struct device *dev,
>>>       return devm_add_action(dev, devm_work_drop, w);
>>>   }
>>>   +static inline void devm_mutex_release(void *res)
>>> +{
>>> +    mutex_destroy(res);
>>> +}
>>> +
>>> +/**
>>> + * devm_mutex_init - Resource-managed mutex initialization
>>> + * @dev:    Device which lifetime work is bound to
>>> + * @lock:    Pointer to a mutex
>>> + *
>>> + * Initialize mutex which is automatically destroyed when driver is detached.
>>> + */
>>> +static inline int devm_mutex_init(struct device *dev, struct mutex *lock)
>>> +{
>>> +    mutex_init(lock);
>>> +    return devm_add_action_or_reset(dev, devm_mutex_release, lock);
>>> +}
>>> +
>>>   #endif
>>
>> mutex_destroy() only actually does anything if CONFIG_DEBUG_MUTEXES
>> is set, otherwise it is an empty inline-stub.
>>
>> Adding a devres resource to the device just to call an empty inline
>> stub which is a no-op seems like a waste of resources. IMHO it
>> would be better to change this to:
>>
>> static inline int devm_mutex_init(struct device *dev, struct mutex *lock)
>> {
>>     mutex_init(lock);
>> #ifdef CONFIG_DEBUG_MUTEXES
>>     return devm_add_action_or_reset(dev, devm_mutex_release, lock);
>> #else
>>     return 0;
>> #endif
>> }
>>
>> To avoid the unnecessary devres allocation when
>> CONFIG_DEBUG_MUTEXES is not set.
> 
> Honestly saying I don't like unnecessary devres allocation either but the proposed approach has its own price:
> 
> 1) we'll have more than one place with branching if mutex_destroy is empty or not using  indirect condition. If suddenly mutex_destroy is extended for non-debug code (in upstream branch or e.g. by someone for local debug) than there'll be a problem.
> 
> 2) If mutex_destroy is empty or not depends on CONFIG_PREEMPT_RT option too. When CONFIG_PREEMPT_RT is on mutex_destroy is always empty.
> 
> As I see it only the mutex interface (mutex.h) has to say definitely if mutex_destroy must be called. Probably we could add some define to include/linux/mutex.h,like IS_MUTEX_DESTROY_REQUIRED and declare it near mutex_destroy definition itself.

That (a  IS_MUTEX_DESTROY_REQUIRED define) is an interesting idea. Lets see for v3 if the mutex maintainers will accept that and if not then I guess we will just need to live with the unnecessary devres allocation.

Regards,

Hans


