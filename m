Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E985812F74
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572890AbjLNLwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444241AbjLNLvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:51:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB0E181
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702554718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aS/6XnBRIdVtrYOp4wLHjvS6oz2atR3YP9ICgOB3iGg=;
        b=KPVCy4JoG5Zi1WZBbThBmgzcPQP47UmD0HsBh8Zw2DvPE6uG4/xs7xsl7dqZFNk5jhDT82
        VABqJBLUkJ/+IfkcrnTPMMzSi4OF0r5m3kewmYedQPYPLPTQWxB2F7sB2GB0ICJ4FX+tzP
        FPhWCy8+gLVhKkZaPapN01EcI3pVxq0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-vMFVh_K3OauNld3RDMOvjg-1; Thu, 14 Dec 2023 06:51:56 -0500
X-MC-Unique: vMFVh_K3OauNld3RDMOvjg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1eb3f3dc2eso219978766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:51:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554715; x=1703159515;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aS/6XnBRIdVtrYOp4wLHjvS6oz2atR3YP9ICgOB3iGg=;
        b=DPhDykDcBPW7Z0o1kmVVk2dGd2xQyOHvU1tx9C2hNa6fCrlAAemqWFt4zwSWWnGobj
         HLJYmpglZWZ8MjN+9/YqzIZPuMnAu5RXXGtxjYHCp0V3DYynRIyvqH5K9CHlIoT9ogx7
         7LjolmKnlRMiH6h2R4PIPkEZdQ/0Z7IzxSCcNOmf62oEpfTEtTFN142ip832hUzU0TyJ
         M1e4679D0Ec3+bhxegE1h1IpsiI7mCC+SOa+Y/nFFxtICa2tpe2wLcshH1AlZBVcyD9y
         Jo4ycw63P/yUXSlwpA/fEHDJCGnj6pV6rz/HeBEtK7A+QJDt9j1wP0U7+3OdCOHc2bHj
         xvZw==
X-Gm-Message-State: AOJu0Yz/AdIl48aT1bTXjV6Y3STwBLVDX6xYzN5W4g57nOOlnW80R7aD
        KyGA8aNNaqqefFNMWe/MmIR1i7o5bF8aGD2oim0kjGd34+pFw4ya2bneDJqjXnD4umNa/fNtUiF
        VJDcGDzJXiwJ6YJDk97T/DNG1
X-Received: by 2002:a17:906:10c7:b0:a1c:e980:3c3 with SMTP id v7-20020a17090610c700b00a1ce98003c3mr4066589ejv.28.1702554715590;
        Thu, 14 Dec 2023 03:51:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFL7HyiSYut4T02F873+WBU/5sTp49/HyQIdZ0Go18ospT2UlJqi27N9WVGJWziHpX9DdSow==
X-Received: by 2002:a17:906:10c7:b0:a1c:e980:3c3 with SMTP id v7-20020a17090610c700b00a1ce98003c3mr4066575ejv.28.1702554715217;
        Thu, 14 Dec 2023 03:51:55 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id se13-20020a170907a38d00b00a1f78048f08sm8487004ejc.146.2023.12.14.03.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 03:51:54 -0800 (PST)
Message-ID: <c8950992-9b3e-4740-8ad6-f22d5a043fb1@redhat.com>
Date:   Thu, 14 Dec 2023 12:51:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] devm-helpers: introduce devm_mutex_init
Content-Language: en-US, nl
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        George Stark <gnstark@salutedevices.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>,
        "vadimp@nvidia.com" <vadimp@nvidia.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "longman@redhat.com" <longman@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "nikitos.tr@gmail.com" <nikitos.tr@gmail.com>
Cc:     "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kernel@salutedevices.com" <kernel@salutedevices.com>
References: <20231213223020.2713164-1-gnstark@salutedevices.com>
 <20231213223020.2713164-4-gnstark@salutedevices.com>
 <80881d5d-3ae9-4580-84c1-f25b421cc518@csgroup.eu>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <80881d5d-3ae9-4580-84c1-f25b421cc518@csgroup.eu>
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

On 12/14/23 11:06, Christophe Leroy wrote:
> 
> 
> Le 13/12/2023 à 23:30, George Stark a écrit :
>> [Vous ne recevez pas souvent de courriers de gnstark@salutedevices.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Using of devm API leads to a certain order of releasing resources.
>> So all dependent resources which are not devm-wrapped should be deleted
>> with respect to devm-release order. Mutex is one of such objects that
>> often is bound to other resources and has no own devm wrapper.
>> Since mutex_destroy() actually does nothing in non-debug builds
>> frequently calling mutex_destroy() is just ignored which is safe for now
>> but wrong formally and can lead to a problem if mutex_destroy() is
>> extended so introduce devm_mutex_init().
> 
> So you abandonned the idea of using mutex.h ?
> 
> I can't see the point to spread mutex functions into devm-helpers.h
> 
> Adding a mutex_destroy macro for this purpose looks odd. And if someone 
> defines a new version of mutex_destroy() and forget the macro, it will 
> go undetected.
> 
> Usually macros of that type serve the purpose of defining a fallback 
> when the macro is not defined. In that case, when someone adds a new 
> version without defining the macro, it gets detected because if 
> conflicts with the fallback.
> But in your case it works the other way round, so I will just go undetected.
> 
> For me the best solution remains to use mutex.h and have 
> devm_mutex_init() defined or declared at the same place as mutex_destroy().

FWIW defining devm_mutex_init() in mutex.h is fine
with me and makes sense to me. I also agree that putting
it there would be better if that is acceptable for
the mutex maintainers.

devm-helpers.h is there for helpers which don't fit
in another place.

Regards,

Hans




> 
> 
>>
>> Signed-off-by: George Stark <gnstark@salutedevices.com>
>> ---
>>   include/linux/devm-helpers.h | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/include/linux/devm-helpers.h b/include/linux/devm-helpers.h
>> index 74891802200d..4043c3481d2e 100644
>> --- a/include/linux/devm-helpers.h
>> +++ b/include/linux/devm-helpers.h
>> @@ -24,6 +24,7 @@
>>    */
>>
>>   #include <linux/device.h>
>> +#include <linux/mutex.h>
>>   #include <linux/workqueue.h>
>>
>>   static inline void devm_delayed_work_drop(void *res)
>> @@ -76,4 +77,30 @@ static inline int devm_work_autocancel(struct device *dev,
>>          return devm_add_action(dev, devm_work_drop, w);
>>   }
>>
>> +#ifdef mutex_destroy
>> +static inline void devm_mutex_release(void *res)
>> +{
>> +       mutex_destroy(res);
>> +}
>> +#endif
>> +
>> +/**
>> + * devm_mutex_init - Resource-managed mutex initialization
>> + * @dev:       Device which lifetime mutex is bound to
>> + * @lock:      Pointer to a mutex
>> + *
>> + * Initialize mutex which is automatically destroyed when the driver is detached.
>> + *
>> + * Returns: 0 on success or a negative error code on failure.
>> + */
>> +static inline int devm_mutex_init(struct device *dev, struct mutex *lock)
>> +{
>> +       mutex_init(lock);
>> +#ifdef mutex_destroy
>> +       return devm_add_action_or_reset(dev, devm_mutex_release, lock);
>> +#else
>> +       return 0;
>> +#endif
>> +}
>> +
>>   #endif
>> --
>> 2.25.1
>>

