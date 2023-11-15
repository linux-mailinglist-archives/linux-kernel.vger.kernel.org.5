Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF1B7EC3BE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343913AbjKONfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343698AbjKONfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:35:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C69A1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700055303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C5Wd1lbN9UwH8wwz4rHuiEBNarPN7m4x8APn6ZM32KA=;
        b=gazJH08V6Qncus2zWF1VJtEzD8Ci7zygoTXOW/k5bKBuw0hba5Wb31DVOg7crQf5vRHbL2
        hCoPA88JcoH0LA6v0tKtl+1oU4mI/5G7iIxllVgK9Wr+xRpNRND0ivU3Nw2yPN2OG7GaYN
        5MouAg5IPPe0AR4x+ZusS0AvcSGunEI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-RI5PzjZGMNyt3O9GnnaC6g-1; Wed, 15 Nov 2023 08:35:01 -0500
X-MC-Unique: RI5PzjZGMNyt3O9GnnaC6g-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6c334d2fd40so8930127b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:35:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700055301; x=1700660101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5Wd1lbN9UwH8wwz4rHuiEBNarPN7m4x8APn6ZM32KA=;
        b=RmlFT+CiBTTddM0H/wkdvzIdOs5FipUFZdRKyBIuJJN/f/rjLhqOAvOJ//aAWgaony
         3U7GK55cdQqt9EjO5fkJU0HS/eSg7NmjED9OPccaBOS4GU7Ex5YGYFGN+/fxfW7u5bFQ
         QjWQSRow3LHKSO0vPioS/l8g5vwQvf4yDcBRGv5owt7i7sBKyGU2DKKwvpCxApAgMIOG
         jRSncwyQPW3Vvdm18rSJ0OJoPrLGGTJwJ23jAiU1g47A0CKOfG/E/5pfiymBlEjDQpNn
         Y4acBKEuG5KteGlXHZevEbVNKA7xk/dhdb9ovi/y7a3dmpkraIQ0lI6WRcKFyMrX5dns
         JgbA==
X-Gm-Message-State: AOJu0YyyR+vb+CaZo7dCaOSexPmQbzqv1Qzx58kHtHcuMYQ5mzKhf0v0
        BMKlPElu/MMc82MG7/h3UmrKCyE1kIdTakISdrj+AHd3mUqkj42lH6e77Qoakb8SVEamCE/yTtb
        cEmhwrom9hZcPhO80PEmCSQp3
X-Received: by 2002:aa7:8816:0:b0:690:fa09:61d3 with SMTP id c22-20020aa78816000000b00690fa0961d3mr12496415pfo.15.1700055300711;
        Wed, 15 Nov 2023 05:35:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFV0xAg6w3slKf/hsLSWfwMemwWRQ/ao1u2QENn9rUHeBxEkEiPk3CaXPzANGIt7t1i7kGs2g==
X-Received: by 2002:aa7:8816:0:b0:690:fa09:61d3 with SMTP id c22-20020aa78816000000b00690fa0961d3mr12496392pfo.15.1700055300321;
        Wed, 15 Nov 2023 05:35:00 -0800 (PST)
Received: from [10.72.112.63] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j1-20020aa78d01000000b00694fee1011asm2778075pfe.208.2023.11.15.05.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 05:34:59 -0800 (PST)
Message-ID: <5a1766c6-d923-a4e5-c5be-15b953372ef5@redhat.com>
Date:   Wed, 15 Nov 2023 21:34:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ceph: quota: Fix invalid pointer access in
Content-Language: en-US
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Wenchao Hao <haowenchao2@huawei.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, louhongxiang@huawei.com
References: <20231114153108.1932884-1-haowenchao2@huawei.com>
 <af8549c8-a468-6505-6dd1-3589fc76be8e@redhat.com>
 <CAOi1vP9TnF+BWiEauddskmTO_+V2uvHiqpEg5EoxzZPKb0oEAQ@mail.gmail.com>
 <aeb8b9e7-c2ce-e758-1b45-67572e686e2c@redhat.com>
 <CAOi1vP-H9zHJEthzocxv7D7m6XX67sE2Dy1Aq=hP9GQRN+qj_g@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAOi1vP-H9zHJEthzocxv7D7m6XX67sE2Dy1Aq=hP9GQRN+qj_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/15/23 21:25, Ilya Dryomov wrote:
> On Wed, Nov 15, 2023 at 2:17 PM Xiubo Li <xiubli@redhat.com> wrote:
>>
>> On 11/15/23 20:32, Ilya Dryomov wrote:
>>> On Wed, Nov 15, 2023 at 1:35 AM Xiubo Li <xiubli@redhat.com> wrote:
>>>> On 11/14/23 23:31, Wenchao Hao wrote:
>>>>> This issue is reported by smatch, get_quota_realm() might return
>>>>> ERR_PTR, so we should using IS_ERR_OR_NULL here to check the return
>>>>> value.
>>>>>
>>>>> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
>>>>> ---
>>>>>     fs/ceph/quota.c | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
>>>>> index 9d36c3532de1..c4b2929c6a83 100644
>>>>> --- a/fs/ceph/quota.c
>>>>> +++ b/fs/ceph/quota.c
>>>>> @@ -495,7 +495,7 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *fsc, struct kstatfs *buf)
>>>>>         realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root),
>>>>>                                 QUOTA_GET_MAX_BYTES, true);
>>>>>         up_read(&mdsc->snap_rwsem);
>>>>> -     if (!realm)
>>>>> +     if (IS_ERR_OR_NULL(realm))
>>>>>                 return false;
>>>>>
>>>>>         spin_lock(&realm->inodes_with_caps_lock);
>>>> Good catch.
>>>>
>>>> Reviewed-by: Xiubo Li <xiubli@redhat.com>
>>>>
>>>> We should CC the stable mail list.
>>> Hi Xiubo,
>>>
>>> What exactly is being fixed here?  get_quota_realm() is called with
>>> retry=true, which means that no errors can be returned -- EAGAIN, the
>>> only error that get_quota_realm() can otherwise generate, would be
>>> handled internally by retrying.
>> Yeah, that's true.
>>
>>> Am I missing something that makes this qualify for stable?
>> Actually it's just for the smatch check for now.
>>
>> IMO we shouldn't depend on the 'retry', just potentially for new changes
>> in future could return a ERR_PTR and cause potential bugs.
> At present, ceph_quota_is_same_realm() also depends on it -- note how
> old_realm isn't checked for errors at all and new_realm is only checked
> for EAGAIN there.
>
>> If that's not worth to make it for stable, let's remove it.
> Yes, let's remove it.  Please update the commit message as well, so
> that it's clear that this is squashing a static checker warning and
> doesn't actually fix any immediate bug.

WenChao,

Could update the commit comment and send the V2 ?

Thanks

- Xiubo


> Thanks,
>
>                  Ilya
>

