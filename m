Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BED7A3F76
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 04:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbjIRC04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 22:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237014AbjIRC0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 22:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B778C124
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 19:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695003942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6J6FPRuAYlNopqGPl+03TlMLt+UQaKfy17hW4vC1zgg=;
        b=beA0Gyj/MRGpWsz0heA440sH1RLpqpAf7tWUB0NxuxBSLMtja22k6p6UWjVWfki4ru/7RA
        AuXDOstdK+PJT2neg2ov+ABB4CxsEG1FAw8OaC1JtrVN/oAC/oWqDXSFuWNn3JP9twXktP
        eAUeHsUcgRSbPBqUDNiXPgEL54TnipY=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-xu7wT8WPOGCj18vkTMk10Q-1; Sun, 17 Sep 2023 22:25:41 -0400
X-MC-Unique: xu7wT8WPOGCj18vkTMk10Q-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-68faf559913so3116253b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 19:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695003940; x=1695608740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6J6FPRuAYlNopqGPl+03TlMLt+UQaKfy17hW4vC1zgg=;
        b=F5AXlmptLjd2ycGwwRlMsuXMFUA1pfRgyjlCzGL7Phb1VbbZyw6Q0LIWdEu6QiYXzV
         QMLiQtf3vjMSlDCt+mDFG7NHzhTbuPOb1ET1vEGi+J46ICQqpyOgBcXrwpAhzdUc2QFy
         vCGmHLG5B7LFl5NfoiojqO0vNnEO3PwT6EWAsDw4A9Ny8rLWL1UH8KX/gHwT03D8gxiD
         856uRQqP0iRC02MvLbC2sL41qK1iWqzvmfkrcBrzEu7GseAfrw8CKrzfDmC+SLl5Qt/T
         bcAuOz5cYe881kCr2cNU8irfByLKMDnaDLlwpesUiZL9gIhkCidje6hAi+2NGIEzEMq6
         jIzQ==
X-Gm-Message-State: AOJu0YwhdqPVRBsynOIDfwdPs5aMBRwk32f9GVDJlSHA+ONKp155X/t2
        fAK2vEh6VEnLwXRqrv2f68HgtSZkR0gs0LhyMyhlN4xFp6ub9g8CFXs9723kAAsdRHUMUiRzyoM
        42mb+Xc/fK7yI7zfb23TZ4aWk
X-Received: by 2002:a05:6a00:1a11:b0:68e:2c2a:5172 with SMTP id g17-20020a056a001a1100b0068e2c2a5172mr9729380pfv.6.1695003940223;
        Sun, 17 Sep 2023 19:25:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6nJEBifUfB3yQM3Fhg9uIhnXl/ACXevuP6GWgj2dNLNcqKEJeDC9UpXX2DiUle5vKSIs/xQ==
X-Received: by 2002:a05:6a00:1a11:b0:68e:2c2a:5172 with SMTP id g17-20020a056a001a1100b0068e2c2a5172mr9729372pfv.6.1695003939933;
        Sun, 17 Sep 2023 19:25:39 -0700 (PDT)
Received: from [10.72.113.158] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c15-20020aa78c0f000000b0068fb5e44827sm6142327pfd.67.2023.09.17.19.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 19:25:39 -0700 (PDT)
Message-ID: <fe8ebbe4-87c0-1a50-de29-8a26354f0e3c@redhat.com>
Date:   Mon, 18 Sep 2023 10:25:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ceph: Annotate struct ceph_monmap with __counted_by
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, ceph-devel@vger.kernel.org,
        netdev@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20230915201510.never.365-kees@kernel.org>
 <3c4c7ca8-e1a2-fbb1-bda4-b7000eb9a8d9@redhat.com>
 <8455fd0c-1871-1e4d-3d46-0cc63f856ded@embeddedor.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <8455fd0c-1871-1e4d-3d46-0cc63f856ded@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/18/23 10:04, Gustavo A. R. Silva wrote:
>
>
> On 9/17/23 18:25, Xiubo Li wrote:
>>
>> On 9/16/23 04:15, Kees Cook wrote:
>>> Prepare for the coming implementation by GCC and Clang of the 
>>> __counted_by
>>> attribute. Flexible array members annotated with __counted_by can have
>>> their accesses bounds-checked at run-time checking via 
>>> CONFIG_UBSAN_BOUNDS
>>> (for array indexing) and CONFIG_FORTIFY_SOURCE (for 
>>> strcpy/memcpy-family
>>> functions).
>>>
>>> As found with Coccinelle[1], add __counted_by for struct ceph_monmap.
>>> Additionally, since the element count member must be set before 
>>> accessing
>>> the annotated flexible array member, move its initialization earlier.
>>>
>>> [1] 
>>> https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
>>>
>>> Cc: Ilya Dryomov <idryomov@gmail.com>
>>> Cc: Xiubo Li <xiubli@redhat.com>
>>> Cc: Jeff Layton <jlayton@kernel.org>
>>> Cc: "David S. Miller" <davem@davemloft.net>
>>> Cc: Eric Dumazet <edumazet@google.com>
>>> Cc: Jakub Kicinski <kuba@kernel.org>
>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>> Cc: ceph-devel@vger.kernel.org
>>> Cc: netdev@vger.kernel.org
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>>>   include/linux/ceph/mon_client.h | 2 +-
>>>   net/ceph/mon_client.c           | 2 +-
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/ceph/mon_client.h 
>>> b/include/linux/ceph/mon_client.h
>>> index b658961156a0..7a9a40163c0f 100644
>>> --- a/include/linux/ceph/mon_client.h
>>> +++ b/include/linux/ceph/mon_client.h
>>> @@ -19,7 +19,7 @@ struct ceph_monmap {
>>>       struct ceph_fsid fsid;
>>>       u32 epoch;
>>>       u32 num_mon;
>>> -    struct ceph_entity_inst mon_inst[];
>>> +    struct ceph_entity_inst mon_inst[] __counted_by(num_mon);
>>>   };
>>>   struct ceph_mon_client;
>>> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
>>> index faabad6603db..f263f7e91a21 100644
>>> --- a/net/ceph/mon_client.c
>>> +++ b/net/ceph/mon_client.c
>>> @@ -1136,6 +1136,7 @@ static int build_initial_monmap(struct 
>>> ceph_mon_client *monc)
>>>                      GFP_KERNEL);
>>>       if (!monc->monmap)
>>>           return -ENOMEM;
>>> +    monc->monmap->num_mon = num_mon;
>>>       for (i = 0; i < num_mon; i++) {
>>>           struct ceph_entity_inst *inst = &monc->monmap->mon_inst[i];
>>> @@ -1147,7 +1148,6 @@ static int build_initial_monmap(struct 
>>> ceph_mon_client *monc)
>>>           inst->name.type = CEPH_ENTITY_TYPE_MON;
>>>           inst->name.num = cpu_to_le64(i);
>>>       }
>>> -    monc->monmap->num_mon = num_mon;
>>
>> BTW, is this change related ?
>
> Yes, it is, and it's described in the changelog text.
>
> `num_mon` must be updated before the first access to flex-array 
> `mon_inst`.
> Otherwise the compiler cannot properly instrument the code to catch any
> out-of-bounds access to `mon_inst`.
>
Okay, got it.

Thanks

- Xiubo


> -- 
> Gustavo
>
>>
>>>       return 0;
>>>   }
>>
>> Else LGTM.
>>
>> Reviewed-by: Xiubo Li <xiubli@redhat.com>
>>
>> Thanks!
>>
>> - Xiubo
>>
>>
>

