Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29CD812B70
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbjLNJQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbjLNJQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:16:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3446D112
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702545412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aSXTliSLRPJwWKgirD+ynnpgvILXx2haTFF7t0rHIEw=;
        b=Nx5uV3a4jMfbpeuoFxbTM1pY9iPITeaqSUs7sbSOnrp+2fQxTe1LGlAu2SuxYJxHFYmLnk
        OcvFmZ47izKgCkQ9RFuEV2//E2xuT82q6mLe7KdH6vewF6+BVbDYjitqvN2ACf6vDtw/Yn
        zzxAAv6DTugGwp9SlHtVNgWeBNg40PE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-DsH53_qdPEKXl44Rh_xE1Q-1; Thu, 14 Dec 2023 04:16:50 -0500
X-MC-Unique: DsH53_qdPEKXl44Rh_xE1Q-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-55223b294e0so724052a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:16:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702545409; x=1703150209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSXTliSLRPJwWKgirD+ynnpgvILXx2haTFF7t0rHIEw=;
        b=atWf53smRfwpHyrvwOIcPrbxFEyz4DvG03HfQTFuf86PB0Vj9VWMyz3UVuXda8fD9Z
         F3C/8rHC0VGqmOlE7Et++zv1q+0MxYKXJriAwKmljEyLAHiEOwXnmZQj4JpSCWb6KnVd
         1jbX9NZDOYhXeZaw6r9H/LSjaB1fhb08n6r5eYz5ReL7hZDv+K9g1lg49xBzRm6Pw2IS
         6usWfBVhnrMtHO8vE4oAXqDZseB+rv7HWKJE5v1BLNEKBw/9jyKvhoIYoA+mbidSp3TJ
         fE/U8F9DOTbcCE2BKxYy/4bZSsK9kDc76DcejTmX5jLuCwEsPdsjluNM2dIqQCzsS9JZ
         IJQg==
X-Gm-Message-State: AOJu0Yzg9w/PneZVa86WNLjab7sEvEzXKtOjmnF1RVASGpWswGIMwV8x
        A1Vp/6lVm916f5crknZl5rjS2xL7iSdlNu+HBbawy1BMLWZC7NNediHntowxcINLBa2rctIacPN
        TmAmVknWaccSAoOyhQ8YWPzsI
X-Received: by 2002:a17:907:268e:b0:a1d:b7b9:3263 with SMTP id bn14-20020a170907268e00b00a1db7b93263mr2986289ejc.164.1702545409802;
        Thu, 14 Dec 2023 01:16:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVQE/9DmmfQQ7JcgUanGLiAM3AoyRWgj4qusaFgzl7bO8ELi8lg6GnTyvH3KcEx592UQ4ElQ==
X-Received: by 2002:a17:907:268e:b0:a1d:b7b9:3263 with SMTP id bn14-20020a170907268e00b00a1db7b93263mr2986277ejc.164.1702545409439;
        Thu, 14 Dec 2023 01:16:49 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id tq14-20020a170907c50e00b00a1f83646eb6sm7701080ejc.149.2023.12.14.01.16.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 01:16:48 -0800 (PST)
Message-ID: <56e74264-6f98-4216-9f9a-e8f718375602@redhat.com>
Date:   Thu, 14 Dec 2023 10:16:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] devm-helpers: introduce devm_mutex_init
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        George Stark <gnstark@salutedevices.com>
Cc:     pavel@ucw.cz, lee@kernel.org, vadimp@nvidia.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        mazziesaccount@gmail.com, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        nikitos.tr@gmail.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kernel@salutedevices.com
References: <20231213223020.2713164-1-gnstark@salutedevices.com>
 <20231213223020.2713164-4-gnstark@salutedevices.com>
 <CAHp75Vc1zZFWB8PPrg8oeAKz9aHnQrrSjdGyGd8mWcmeZdJ9qA@mail.gmail.com>
 <CAHp75Vdxa5k-CLhL+PmK0iTPTNSpP77DA6ooWnxfViwSKiEOSw@mail.gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75Vdxa5k-CLhL+PmK0iTPTNSpP77DA6ooWnxfViwSKiEOSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/13/23 23:38, Andy Shevchenko wrote:
> On Thu, Dec 14, 2023 at 12:36 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Thu, Dec 14, 2023 at 12:30 AM George Stark <gnstark@salutedevices.com> wrote:
>>>
>>> Using of devm API leads to a certain order of releasing resources.
>>> So all dependent resources which are not devm-wrapped should be deleted
>>> with respect to devm-release order. Mutex is one of such objects that
>>> often is bound to other resources and has no own devm wrapper.
>>> Since mutex_destroy() actually does nothing in non-debug builds
>>> frequently calling mutex_destroy() is just ignored which is safe for now
>>> but wrong formally and can lead to a problem if mutex_destroy() is
>>> extended so introduce devm_mutex_init().
> 
> ...
> 
>>> +#ifdef mutex_destroy
>>> +static inline void devm_mutex_release(void *res)
>>> +{
>>> +       mutex_destroy(res);
>>> +}
>>> +#endif
>>> +
>>> +/**
>>> + * devm_mutex_init - Resource-managed mutex initialization
>>> + * @dev:       Device which lifetime mutex is bound to
>>> + * @lock:      Pointer to a mutex
>>> + *
>>> + * Initialize mutex which is automatically destroyed when the driver is detached.
>>> + *
>>> + * Returns: 0 on success or a negative error code on failure.
>>> + */
>>> +static inline int devm_mutex_init(struct device *dev, struct mutex *lock)
>>> +{
>>> +       mutex_init(lock);
>>> +#ifdef mutex_destroy
>>> +       return devm_add_action_or_reset(dev, devm_mutex_release, lock);
>>> +#else
>>> +       return 0;
>>> +#endif
>>> +}
>>
>> If this is going to be accepted, you may decrease the amount of ifdeffery.
>>
>> #ifdef ...
>> #else
>> #define devm_mutex_init(dev, lock)  mutex_init(lock)
> 
> More precisely ({ mutex_init(lock); 0; }) or as a static inline...

With a static inline we are pretty much back to the original
v3 patch.

I believe the best way to reduce the ifdef-ery is to remove
the #ifdef around devm_mutex_release() having unused
static inline ... functions in .h files is quite common,
so this one does not need a #ifdef around it and with
that removed we are down to just one #ifdef so just
removing the #ifdef around devm_mutex_release() seems
the best fix.

With that fixed you may add my:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

to the patch and I'm fine with this being routed
upstream through whatever tree is convenient.

Regards,

Hans



