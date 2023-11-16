Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C277E7EDBC7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjKPHJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjKPHJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:09:36 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DD8182;
        Wed, 15 Nov 2023 23:09:32 -0800 (PST)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SWB0021jSzsR5m;
        Thu, 16 Nov 2023 15:06:08 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 16 Nov 2023 15:09:29 +0800
Message-ID: <3a0b72e0-0784-0882-c18b-6178ed597670@huawei.com>
Date:   Thu, 16 Nov 2023 15:09:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] ceph: quota: Fix invalid pointer access in
Content-Language: en-US
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
CC:     Jeff Layton <jlayton@kernel.org>, <ceph-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>
References: <20231114153108.1932884-1-haowenchao2@huawei.com>
 <af8549c8-a468-6505-6dd1-3589fc76be8e@redhat.com>
 <CAOi1vP9TnF+BWiEauddskmTO_+V2uvHiqpEg5EoxzZPKb0oEAQ@mail.gmail.com>
 <aeb8b9e7-c2ce-e758-1b45-67572e686e2c@redhat.com>
 <CAOi1vP-H9zHJEthzocxv7D7m6XX67sE2Dy1Aq=hP9GQRN+qj_g@mail.gmail.com>
 <5a1766c6-d923-a4e5-c5be-15b953372ef5@redhat.com>
 <5eb54f3e-3438-ba47-3d43-baf6b27aad0e@huawei.com>
 <6824ece2-33ee-63f4-2c7a-7033556325cb@redhat.com>
From:   Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <6824ece2-33ee-63f4-2c7a-7033556325cb@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/16 11:06, Xiubo Li wrote:
> 
> On 11/16/23 10:54, Wenchao Hao wrote:
>> On 2023/11/15 21:34, Xiubo Li wrote:
>>>
>>> On 11/15/23 21:25, Ilya Dryomov wrote:
>>>> On Wed, Nov 15, 2023 at 2:17 PM Xiubo Li <xiubli@redhat.com> wrote:
>>>>>
>>>>> On 11/15/23 20:32, Ilya Dryomov wrote:
>>>>>> On Wed, Nov 15, 2023 at 1:35 AM Xiubo Li <xiubli@redhat.com> wrote:
>>>>>>> On 11/14/23 23:31, Wenchao Hao wrote:
>>>>>>>> This issue is reported by smatch, get_quota_realm() might return
>>>>>>>> ERR_PTR, so we should using IS_ERR_OR_NULL here to check the return
>>>>>>>> value.
>>>>>>>>
>>>>>>>> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
>>>>>>>> ---
>>>>>>>>     fs/ceph/quota.c | 2 +-
>>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
>>>>>>>> index 9d36c3532de1..c4b2929c6a83 100644
>>>>>>>> --- a/fs/ceph/quota.c
>>>>>>>> +++ b/fs/ceph/quota.c
>>>>>>>> @@ -495,7 +495,7 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *fsc, struct kstatfs *buf)
>>>>>>>>         realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root),
>>>>>>>>                                 QUOTA_GET_MAX_BYTES, true);
>>>>>>>>         up_read(&mdsc->snap_rwsem);
>>>>>>>> -     if (!realm)
>>>>>>>> +     if (IS_ERR_OR_NULL(realm))
>>>>>>>>                 return false;
>>>>>>>>
>>>>>>>> spin_lock(&realm->inodes_with_caps_lock);
>>>>>>> Good catch.
>>>>>>>
>>>>>>> Reviewed-by: Xiubo Li <xiubli@redhat.com>
>>>>>>>
>>>>>>> We should CC the stable mail list.
>>>>>> Hi Xiubo,
>>>>>>
>>>>>> What exactly is being fixed here?  get_quota_realm() is called with
>>>>>> retry=true, which means that no errors can be returned -- EAGAIN, the
>>>>>> only error that get_quota_realm() can otherwise generate, would be
>>>>>> handled internally by retrying.
>>>>> Yeah, that's true.
>>>>>
>>>>>> Am I missing something that makes this qualify for stable?
>>>>> Actually it's just for the smatch check for now.
>>>>>
>>>>> IMO we shouldn't depend on the 'retry', just potentially for new changes
>>>>> in future could return a ERR_PTR and cause potential bugs.
>>>> At present, ceph_quota_is_same_realm() also depends on it -- note how
>>>> old_realm isn't checked for errors at all and new_realm is only checked
>>>> for EAGAIN there.
>>>>
>>>>> If that's not worth to make it for stable, let's remove it.
>>>> Yes, let's remove it.  Please update the commit message as well, so
>>>> that it's clear that this is squashing a static checker warning and
>>>> doesn't actually fix any immediate bug.
>>>
>>> WenChao,
>>>
>>> Could update the commit comment and send the V2 ?
>>>
>>
>> OK, I would update the commit comment as following:
>>
>> This issue is reported by smatch, get_quota_realm() might return
>> ERR_PTR. It's not a immediate bug because get_quota_realm() is called
>> with 'retry=true', no errors can be returned.
>>
>> While we still should check the return value of get_quota_realm() with
>> IS_ERR_OR_NULL to avoid potential bugs if get_quota_realm() is changed
>> to return other ERR_PTR in future.
>>
>> What's more, should I change the ceph_quota_is_same_realm() too?
>>
> Yeah, please. Let's fix them all.
> 

is_same is return as true if both old_realm and new_realm are NULL, I do not
want to change the origin logic except add check for ERR_PTR, so following
is my change:

1. make sure xxx_realm is valid before calling ceph_put_snap_realm.
2. return false if new_realm or old_realm is ERR_PTR, this is newly added
    and now we would always run with the else branch.

diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index c4b2929c6a83..8da9ffb05395 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -290,16 +290,20 @@ bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
         new_realm = get_quota_realm(mdsc, new, QUOTA_GET_ANY, false);
         if (PTR_ERR(new_realm) == -EAGAIN) {
                 up_read(&mdsc->snap_rwsem);
-               if (old_realm)
+               if (!IS_ERR_OR_NULL(old_realm))
                         ceph_put_snap_realm(mdsc, old_realm);
                 goto restart;
         }
-       is_same = (old_realm == new_realm);
         up_read(&mdsc->snap_rwsem);
  
-       if (old_realm)
+       if (IS_ERR(new_realm))
+               is_same = false;
+       else
+               is_same = (old_realm == new_realm);
+
+       if (!IS_ERR_OR_NULL(old_realm))
                 ceph_put_snap_realm(mdsc, old_realm);
-       if (new_realm)
+       if (!IS_ERR_OR_NULL(new_realm))
                 ceph_put_snap_realm(mdsc, new_realm);
  
         return is_same;


> Thanks
> 
> - Xiubo
> 
> 
>> Thanks
>>
>>> Thanks
>>>
>>> - Xiubo
>>>
>>>
>>>> Thanks,
>>>>
>>>>                  Ilya
>>>>
>>>
>>
> 
> 

