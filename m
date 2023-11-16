Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A05E7ED9D8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344493AbjKPDHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPDHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:07:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB75FBD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700104019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m0gSEf7JiRv42BybUzT0POwhSlpfuDNjghSiOqfLdfM=;
        b=KsxV6tlcKM+07/hn/yKn450ue1V3KKcGU7nsXIWhIi4KodlxT8aea5TNx3kTPawZYJunqA
        g2qaMW83Ng7ZGrWAke3Mb9EVn5IWAzoVf3WtMJoFh6qL3blKUS7FD0OiqxjlA0b0j7FAFN
        9jziQMfSbqQQ/cBHcTDL1AhlO+CwT8g=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-ugDTUKtaO0WSKMd6eXEpEg-1; Wed, 15 Nov 2023 22:06:58 -0500
X-MC-Unique: ugDTUKtaO0WSKMd6eXEpEg-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-58a8142a7a7so324789eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:06:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700104018; x=1700708818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m0gSEf7JiRv42BybUzT0POwhSlpfuDNjghSiOqfLdfM=;
        b=hpdw8V/m/LqENsD3ndb83wj8la5U+nni5ojxg82UILFkHw4T00ZGGYHkUW082tvDJc
         Km+X3sYlbI0rscvDvT70cmLYM/2wr3SvyJ/yQoe9xeADdar342rHy/FEBwGemfmgynMA
         64K+IMgfK6oNJtuc57MtKndUlPROVAUE2YPqspr58WP2dcsReY+NO/UolFXPFLUAFYRu
         wfhZi9gmlp/W+jFWyG+CFkn1hM3N8rANgK6NQM1ZL0DdbRiSJY1+bGyadV+Kw5bgz+80
         vGwZ1MONyyNuk6NnnFAD7e2QahtYYJgEwqTUmXjrSoYhS05kK2S+JiCJczssJTTXwUqx
         Wmvg==
X-Gm-Message-State: AOJu0Yw/jOQoR75aMAOmBeC/1g060ZazwGEe/l/SNBlPOcQAuEMkpdwo
        yth6iWbMaMCMquUaHhH/oY4yQS4M+F0zCeCkOmzzoDNHTUoEL92AQYwEcB5iomCgQnRX5OPMkkS
        GLQ00iNGZYDi/7Jl7y7cUBtk4
X-Received: by 2002:a05:6870:6b0a:b0:1eb:192b:e75a with SMTP id mt10-20020a0568706b0a00b001eb192be75amr18651331oab.22.1700104017775;
        Wed, 15 Nov 2023 19:06:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErzNsGbCi7cjJQfz8wbVjXhVOQ0dECg1zpdO2r2Bt7c8VxU6b+geNP4XQVFJ78DQarXuGJFQ==
X-Received: by 2002:a05:6870:6b0a:b0:1eb:192b:e75a with SMTP id mt10-20020a0568706b0a00b001eb192be75amr18651319oab.22.1700104017506;
        Wed, 15 Nov 2023 19:06:57 -0800 (PST)
Received: from [10.72.112.63] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d15-20020a17090a110f00b0028018af8dc2sm625368pja.23.2023.11.15.19.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 19:06:57 -0800 (PST)
Message-ID: <6824ece2-33ee-63f4-2c7a-7033556325cb@redhat.com>
Date:   Thu, 16 Nov 2023 11:06:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ceph: quota: Fix invalid pointer access in
To:     Wenchao Hao <haowenchao2@huawei.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, louhongxiang@huawei.com
References: <20231114153108.1932884-1-haowenchao2@huawei.com>
 <af8549c8-a468-6505-6dd1-3589fc76be8e@redhat.com>
 <CAOi1vP9TnF+BWiEauddskmTO_+V2uvHiqpEg5EoxzZPKb0oEAQ@mail.gmail.com>
 <aeb8b9e7-c2ce-e758-1b45-67572e686e2c@redhat.com>
 <CAOi1vP-H9zHJEthzocxv7D7m6XX67sE2Dy1Aq=hP9GQRN+qj_g@mail.gmail.com>
 <5a1766c6-d923-a4e5-c5be-15b953372ef5@redhat.com>
 <5eb54f3e-3438-ba47-3d43-baf6b27aad0e@huawei.com>
Content-Language: en-US
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <5eb54f3e-3438-ba47-3d43-baf6b27aad0e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/23 10:54, Wenchao Hao wrote:
> On 2023/11/15 21:34, Xiubo Li wrote:
>>
>> On 11/15/23 21:25, Ilya Dryomov wrote:
>>> On Wed, Nov 15, 2023 at 2:17 PM Xiubo Li <xiubli@redhat.com> wrote:
>>>>
>>>> On 11/15/23 20:32, Ilya Dryomov wrote:
>>>>> On Wed, Nov 15, 2023 at 1:35 AM Xiubo Li <xiubli@redhat.com> wrote:
>>>>>> On 11/14/23 23:31, Wenchao Hao wrote:
>>>>>>> This issue is reported by smatch, get_quota_realm() might return
>>>>>>> ERR_PTR, so we should using IS_ERR_OR_NULL here to check the return
>>>>>>> value.
>>>>>>>
>>>>>>> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
>>>>>>> ---
>>>>>>>     fs/ceph/quota.c | 2 +-
>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
>>>>>>> index 9d36c3532de1..c4b2929c6a83 100644
>>>>>>> --- a/fs/ceph/quota.c
>>>>>>> +++ b/fs/ceph/quota.c
>>>>>>> @@ -495,7 +495,7 @@ bool ceph_quota_update_statfs(struct 
>>>>>>> ceph_fs_client *fsc, struct kstatfs *buf)
>>>>>>>         realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root),
>>>>>>>                                 QUOTA_GET_MAX_BYTES, true);
>>>>>>>         up_read(&mdsc->snap_rwsem);
>>>>>>> -     if (!realm)
>>>>>>> +     if (IS_ERR_OR_NULL(realm))
>>>>>>>                 return false;
>>>>>>>
>>>>>>> spin_lock(&realm->inodes_with_caps_lock);
>>>>>> Good catch.
>>>>>>
>>>>>> Reviewed-by: Xiubo Li <xiubli@redhat.com>
>>>>>>
>>>>>> We should CC the stable mail list.
>>>>> Hi Xiubo,
>>>>>
>>>>> What exactly is being fixed here?  get_quota_realm() is called with
>>>>> retry=true, which means that no errors can be returned -- EAGAIN, the
>>>>> only error that get_quota_realm() can otherwise generate, would be
>>>>> handled internally by retrying.
>>>> Yeah, that's true.
>>>>
>>>>> Am I missing something that makes this qualify for stable?
>>>> Actually it's just for the smatch check for now.
>>>>
>>>> IMO we shouldn't depend on the 'retry', just potentially for new 
>>>> changes
>>>> in future could return a ERR_PTR and cause potential bugs.
>>> At present, ceph_quota_is_same_realm() also depends on it -- note how
>>> old_realm isn't checked for errors at all and new_realm is only checked
>>> for EAGAIN there.
>>>
>>>> If that's not worth to make it for stable, let's remove it.
>>> Yes, let's remove it.  Please update the commit message as well, so
>>> that it's clear that this is squashing a static checker warning and
>>> doesn't actually fix any immediate bug.
>>
>> WenChao,
>>
>> Could update the commit comment and send the V2 ?
>>
>
> OK, I would update the commit comment as following:
>
> This issue is reported by smatch, get_quota_realm() might return
> ERR_PTR. It's not a immediate bug because get_quota_realm() is called
> with 'retry=true', no errors can be returned.
>
> While we still should check the return value of get_quota_realm() with
> IS_ERR_OR_NULL to avoid potential bugs if get_quota_realm() is changed
> to return other ERR_PTR in future.
>
> What's more, should I change the ceph_quota_is_same_realm() too?
>
Yeah, please. Let's fix them all.

Thanks

- Xiubo


> Thanks
>
>> Thanks
>>
>> - Xiubo
>>
>>
>>> Thanks,
>>>
>>>                  Ilya
>>>
>>
>

