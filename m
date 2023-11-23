Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A5C7F55F8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 02:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjKWBj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 20:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjKWBj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 20:39:56 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B86191;
        Wed, 22 Nov 2023 17:39:59 -0800 (PST)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SbLLN1ZXKz1P8m6;
        Thu, 23 Nov 2023 09:36:28 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 Nov 2023 09:39:57 +0800
Message-ID: <df44a48b-898d-c6b1-19cf-c16e66bbd560@huawei.com>
Date:   Thu, 23 Nov 2023 09:39:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] ceph: quota: Fix invalid pointer access if
 get_quota_realm return ERR_PTR
To:     Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Luis Henriques <lhenriques@suse.de>,
        <ceph-devel@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20231120082637.2717550-1-haowenchao2@huawei.com>
 <d5eda932-dec0-ba2d-2f4d-a7edbbfa1f81@redhat.com>
Content-Language: en-US
From:   Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <d5eda932-dec0-ba2d-2f4d-a7edbbfa1f81@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/22 12:29, Xiubo Li wrote:
> 
> On 11/20/23 16:26, Wenchao Hao wrote:
>> This issue is reported by smatch that get_quota_realm() might return
>> ERR_PTR but we did not handle it. It's not a immediate bug, while we
>> still should address it to avoid potential bugs if get_quota_realm()
>> is changed to return other ERR_PTR in future.
>>
>> Set ceph_snap_realm's pointer in get_quota_realm()'s to address this
>> issue, the pointer would be set to NULL if get_quota_realm() failed
>> to get struct ceph_snap_realm, so no ERR_PTR would happen any more.
>>
>> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
>> ---
>> V2:
>>   - Fix all potential invalid pointer access caused by get_quota_realm
>>   - Update commit comment and point it's not a immediate bug
>>
>>   fs/ceph/quota.c | 41 +++++++++++++++++++++++------------------
>>   1 file changed, 23 insertions(+), 18 deletions(-)
>>
>> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
>> index 9d36c3532de1..e85a85b34a83 100644
>> --- a/fs/ceph/quota.c
>> +++ b/fs/ceph/quota.c
>> @@ -197,10 +197,10 @@ void ceph_cleanup_quotarealms_inodes(struct ceph_mds_client *mdsc)
>>   }
>>   /*
>> - * This function walks through the snaprealm for an inode and returns the
>> - * ceph_snap_realm for the first snaprealm that has quotas set (max_files,
>> + * This function walks through the snaprealm for an inode and set the
>> + * realmp with the first snaprealm that has quotas set (max_files,
>>    * max_bytes, or any, depending on the 'which_quota' argument).  If the root is
>> - * reached, return the root ceph_snap_realm instead.
>> + * reached, set the realmp with the root ceph_snap_realm instead.
>>    *
>>    * Note that the caller is responsible for calling ceph_put_snap_realm() on the
>>    * returned realm.
>> @@ -211,10 +211,9 @@ void ceph_cleanup_quotarealms_inodes(struct ceph_mds_client *mdsc)
>>    * this function will return -EAGAIN; otherwise, the snaprealms walk-through
>>    * will be restarted.
>>    */
>> -static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
>> -                           struct inode *inode,
>> -                           enum quota_get_realm which_quota,
>> -                           bool retry)
>> +static int get_quota_realm(struct ceph_mds_client *mdsc, struct inode *inode,
>> +               enum quota_get_realm which_quota,
>> +               struct ceph_snap_realm **realmp, bool retry)
>>   {
>>       struct ceph_client *cl = mdsc->fsc->client;
>>       struct ceph_inode_info *ci = NULL;
>> @@ -222,8 +221,10 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
>>       struct inode *in;
>>       bool has_quota;
>> +    if (realmp)
>> +        *realmp = NULL;
>>       if (ceph_snap(inode) != CEPH_NOSNAP)
>> -        return NULL;
>> +        return 0;
>>   restart:
>>       realm = ceph_inode(inode)->i_snap_realm;
>> @@ -250,7 +251,7 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
>>                   break;
>>               ceph_put_snap_realm(mdsc, realm);
>>               if (!retry)
>> -                return ERR_PTR(-EAGAIN);
>> +                return -EAGAIN;
>>               goto restart;
>>           }
>> @@ -259,8 +260,11 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
>>           iput(in);
>>           next = realm->parent;
>> -        if (has_quota || !next)
>> -               return realm;
>> +        if (has_quota || !next) {
>> +            if (realmp)
>> +                *realmp = realm;
>> +            return 0;
>> +        }
>>           ceph_get_snap_realm(mdsc, next);
>>           ceph_put_snap_realm(mdsc, realm);
>> @@ -269,14 +273,15 @@ static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client *mdsc,
>>       if (realm)
>>           ceph_put_snap_realm(mdsc, realm);
>> -    return NULL;
>> +    return 0;
>>   }
>>   bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
>>   {
>>       struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(old->i_sb);
>> -    struct ceph_snap_realm *old_realm, *new_realm;
>> +    struct ceph_snap_realm *old_realm = NULL, *new_realm = NULL;
> 
> Here you initialized it as NULL.
> 
>>       bool is_same;
>> +    int ret;
>>   restart:
>>       /*
>> @@ -286,9 +291,9 @@ bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
>>        * dropped and we can then restart the whole operation.
>>        */
>>       down_read(&mdsc->snap_rwsem);
>> -    old_realm = get_quota_realm(mdsc, old, QUOTA_GET_ANY, true);
>> -    new_realm = get_quota_realm(mdsc, new, QUOTA_GET_ANY, false);
>> -    if (PTR_ERR(new_realm) == -EAGAIN) {
>> +    get_quota_realm(mdsc, old, QUOTA_GET_ANY, &old_realm, true);
>> +    ret = get_quota_realm(mdsc, new, QUOTA_GET_ANY, &new_realm, false);
>> +    if (ret == -EAGAIN) {
>>           up_read(&mdsc->snap_rwsem);
>>           if (old_realm)
>>               ceph_put_snap_realm(mdsc, old_realm);
>> @@ -492,8 +497,8 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *fsc, struct kstatfs *buf)
>>       bool is_updated = false;
>>       down_read(&mdsc->snap_rwsem);
>> -    realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root),
>> -                QUOTA_GET_MAX_BYTES, true);
>> +    get_quota_realm(mdsc, d_inode(fsc->sb->s_root),
>> +                QUOTA_GET_MAX_BYTES, &realm, true);
> 
> While here you ignored it.
> 
> I think we can just ignore it and the 'get_quota_realm()' will help initialize it.

Yes, I would remove the initialization in ceph_quota_is_same_realm() then repost.

> 
> Thanks
> 
> - Xiubo
> 
>>       up_read(&mdsc->snap_rwsem);
>>       if (!realm)
>>           return false;
> 

