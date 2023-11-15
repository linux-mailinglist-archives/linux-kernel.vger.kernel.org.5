Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66277EC375
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343897AbjKONRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343875AbjKONRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:17:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F40311D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700054255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F+dllCLAEC41jq93R276OiytSCxqMBHKzTo25Nwd4Ng=;
        b=NIW5E7C5IaEappdI2ZSmTrqB09ldWPGyoYLmRsoeUhRP19pQczJBFQG8XagXIUvHXSCYNt
        xUbQxECDEo4G/4Rj7LkdMeL200wEEqWGjlBmnX2QwwMVrO9cVGQIARN4qnVe26RHOkJZmp
        9xQpQd91leofLVFzDm/NYVEF3e2WL0Y=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-cXIT7N2vN7yMUUV5k9b3FA-1; Wed, 15 Nov 2023 08:17:34 -0500
X-MC-Unique: cXIT7N2vN7yMUUV5k9b3FA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5be0d0248e5so6383793a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 05:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700054253; x=1700659053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+dllCLAEC41jq93R276OiytSCxqMBHKzTo25Nwd4Ng=;
        b=D/zyMOfdPDGQ1IhMXK4qOaEODMpiBftcqYtw08hN6j1fCMENLFpCM8XAwBzzNizwAy
         HG/1NAU/CXi/V204iS9OMXw4n0z2SStGaA8c8Af2TEV2S+P8TOigp/7P6+a+vit7JeF8
         AtppYx2Fi6Z5peOuOz6bR3KPU5yjrEfRk+h77AyDkCtYEDuSOh+/vBOxUrGlKfWL8/zp
         y4YO7yhX8X2c2+/IP2BbilYUOtNuIyGlEELoSUtYQUQxAwPZ6JpAvlPaqnvIO8cXqDVW
         quX9czJmgcwT0/uuCVvgVxTo5JC02+mNRM4VRLsgU+LyV9hObkladXYfARDAVRzPp0iU
         DwKw==
X-Gm-Message-State: AOJu0Yz5eZI6kCP4Gb6r4jVYLGhl5F5WtQdPhlXXDe3bnjBvWW6qkHcd
        Kq4mFJpvBvxuRfHeoZIUYM56A29Y+Ulb/2MkKrkKNo7znTUuTg3m2CDaJluHcMDuIsEfc0+mDvn
        Qqj5Zy/csH+xX3St2wSleZWM9
X-Received: by 2002:a17:903:230f:b0:1ce:8ed:237f with SMTP id d15-20020a170903230f00b001ce08ed237fmr6445225plh.5.1700054252923;
        Wed, 15 Nov 2023 05:17:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlZR40mClyMi1gSrSdJNEiVzxlAuJuvn3BeShwoTTpKy/1jUow+38BXlhUZB25T3Jxdc3WUQ==
X-Received: by 2002:a17:903:230f:b0:1ce:8ed:237f with SMTP id d15-20020a170903230f00b001ce08ed237fmr6445204plh.5.1700054252587;
        Wed, 15 Nov 2023 05:17:32 -0800 (PST)
Received: from [10.72.112.63] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jd7-20020a170903260700b001ca222edc16sm7329376plb.135.2023.11.15.05.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 05:17:32 -0800 (PST)
Message-ID: <aeb8b9e7-c2ce-e758-1b45-67572e686e2c@redhat.com>
Date:   Wed, 15 Nov 2023 21:17:28 +0800
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
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAOi1vP9TnF+BWiEauddskmTO_+V2uvHiqpEg5EoxzZPKb0oEAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/15/23 20:32, Ilya Dryomov wrote:
> On Wed, Nov 15, 2023 at 1:35 AM Xiubo Li <xiubli@redhat.com> wrote:
>>
>> On 11/14/23 23:31, Wenchao Hao wrote:
>>> This issue is reported by smatch, get_quota_realm() might return
>>> ERR_PTR, so we should using IS_ERR_OR_NULL here to check the return
>>> value.
>>>
>>> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
>>> ---
>>>    fs/ceph/quota.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
>>> index 9d36c3532de1..c4b2929c6a83 100644
>>> --- a/fs/ceph/quota.c
>>> +++ b/fs/ceph/quota.c
>>> @@ -495,7 +495,7 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *fsc, struct kstatfs *buf)
>>>        realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root),
>>>                                QUOTA_GET_MAX_BYTES, true);
>>>        up_read(&mdsc->snap_rwsem);
>>> -     if (!realm)
>>> +     if (IS_ERR_OR_NULL(realm))
>>>                return false;
>>>
>>>        spin_lock(&realm->inodes_with_caps_lock);
>> Good catch.
>>
>> Reviewed-by: Xiubo Li <xiubli@redhat.com>
>>
>> We should CC the stable mail list.
> Hi Xiubo,
>
> What exactly is being fixed here?  get_quota_realm() is called with
> retry=true, which means that no errors can be returned -- EAGAIN, the
> only error that get_quota_realm() can otherwise generate, would be
> handled internally by retrying.

Yeah, that's true.

> Am I missing something that makes this qualify for stable?

Actually it's just for the smatch check for now.

IMO we shouldn't depend on the 'retry', just potentially for new changes 
in future could return a ERR_PTR and cause potential bugs.

If that's not worth to make it for stable, let's remove it.

Thanks

- Xiubo

>
> Thanks,
>
>                  Ilya
>

