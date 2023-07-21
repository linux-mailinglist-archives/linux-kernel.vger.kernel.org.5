Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2078E75CB8A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjGUPWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjGUPWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:22:00 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30A63A8E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:21:35 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-48147a5f0c0so725270e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689952888; x=1690557688;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kCexeoAq5WFou5O/MRG2hFsQoOlYTuihLodnFL02nHg=;
        b=RoI4XoW6aSQvP9Q8TIXeE+OOEjdFRCDb5vCkv39l0cVz+nN1XkGHe+kfutsTKJD3Yn
         K9EA33tFVnX6nMGiNfLaqLq6BPH9onR1FfYwtc61aWR58Y4ISItozVXJBpmwVx0WKbke
         kWA4KBDXbV2hUWcpwHyqaT/eOfar/9gB9G85I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689952888; x=1690557688;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kCexeoAq5WFou5O/MRG2hFsQoOlYTuihLodnFL02nHg=;
        b=B+WgOwXUaM4QvdfieEOf6zk1e+6jsZROzeDYaar6erHABmsWxb43wxl6Say0MP/QyE
         9Jk4/KrUvbUkfW8WRtPA2SA7ZNqSNtsIQmoEsUXjd2ty37sMrrJLq6CsXiMe+6SBxexG
         r9VoNhH8xLRKFISZvJwaxmUENC+YHVcXD9eMLDeiJlnYHKo6v7JqnRf6CuOy1UENmanv
         J0XDuM+7doWNpQ5/rDA8leynrlRHUnVIDlJFPHPnp5/mQ1bCSo2Sk2Quphjn71IEkjnX
         m+s4Ii8tE8BDMMsP49BA+gIpSlw8IkiYz1naRzpz7jRJoURTmzrfYlEpbyntVytFZdy9
         Bt/w==
X-Gm-Message-State: ABy/qLZByoJHXZZBaTZsqKrxJEtU/STJuRhEt/YtKMLNV8EGUEdN/Ikm
        X3VMYhv1bSOzyJ7i/ZKUTEnMoymm9duaYZzLyik=
X-Google-Smtp-Source: APBJJlFf1VC+mAzw0+PKkMHibS0p4yDHmiPMsps0CguK5DiWnKA7KpFGtyoPE7ky4Z9ArKM/pexs2Q==
X-Received: by 2002:a67:f244:0:b0:443:6792:38a with SMTP id y4-20020a67f244000000b004436792038amr208591vsm.34.1689952888401;
        Fri, 21 Jul 2023 08:21:28 -0700 (PDT)
Received: from [192.168.0.140] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id k30-20020a0cb25e000000b0063cdcd5699csm517512qve.118.2023.07.21.08.21.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 08:21:27 -0700 (PDT)
Message-ID: <cc9b292c-99b1-bec9-ba8e-9c202b5835cd@joelfernandes.org>
Date:   Fri, 21 Jul 2023 11:21:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
Content-Language: en-US
To:     Alan Huang <mmpgouride@gmail.com>
Cc:     Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rcu@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>, roman.gushchin@linux.dev
References: <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
 <1E0741E0-2BD9-4FA3-BA41-4E83315A10A8@joelfernandes.org>
 <1AF98387-B78C-4556-BE2E-E8F88ADACF8A@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <1AF98387-B78C-4556-BE2E-E8F88ADACF8A@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/23 10:27, Alan Huang wrote:
> 
>> 2023年7月21日 20:54，Joel Fernandes <joel@joelfernandes.org> 写道：
>>
>>
>>
>>> On Jul 20, 2023, at 4:00 PM, Alan Huang <mmpgouride@gmail.com> wrote:
>>>
>>> ﻿
>>>> 2023年7月21日 03:22，Eric Dumazet <edumazet@google.com> 写道：
>>>>
>>>>> On Thu, Jul 20, 2023 at 8:54 PM Alan Huang <mmpgouride@gmail.com> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> I noticed a commit c87a124a5d5e(“net: force a reload of first item in hlist_nulls_for_each_entry_rcu”)
>>>>> and a related discussion [1].
>>>>>
>>>>> After reading the whole discussion, it seems like that ptr->field was cached by gcc even with the deprecated
>>>>> ACCESS_ONCE(), so my question is:
>>>>>
>>>>>       Is that a compiler bug? If so, has this bug been fixed today, ten years later?
>>>>>
>>>>>       What about READ_ONCE(ptr->field)?
>>>>
>>>> Make sure sparse is happy.
>>>
>>> It caused a problem without barrier(), and the deprecated ACCESS_ONCE() didn’t help:
>>>
>>>    https://lore.kernel.org/all/519D19DA.50400@yandex-team.ru/
>>>
>>> So, my real question is: With READ_ONCE(ptr->field), are there still some unusual cases where gcc
>>> decides not to reload ptr->field?
>>
>> I am a bit doubtful there will be strong (any?) interest in replacing the barrier() with READ_ONCE() without any tangible reason, regardless of whether a gcc issue was fixed.
>>
>> But hey, if you want to float the idea…
> 
> We already had the READ_ONCE() in rcu_deference_raw().
> 
> The barrier() here makes me think we need write code like below:
> 	
> 	READ_ONCE(head->first);
> 	barrier();
> 	READ_ONCE(head->first);
> 
> With READ_ONCE (or the deprecated ACCESS_ONCE),
> I don’t think a compiler should cache the value of head->first.


Right, it shouldn't need to cache. To Eric's point it might be risky to remove 
the barrier() and someone needs to explain that issue first (or IMO there needs 
to be another tangible reason like performance etc). Anyway, FWIW I wrote a 
simple program and I am not seeing the head->first cached with the pattern you 
shared above:

#include <stdlib.h>

#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
#define barrier() __asm__ __volatile__("": : :"memory")

typedef struct list_head {
     int first;
     struct list_head *next;
} list_head;

int main() {
     list_head *head = (list_head *)malloc(sizeof(list_head));
     head->first = 1;
     head->next = 0;

     READ_ONCE(head->first);
     barrier();
     READ_ONCE(head->first);

     free(head);
     return 0;
}

On ARM 32-bit, 64-bit and x86_64, with -Os and then another experiment with -O2 
on new gcc versions.

