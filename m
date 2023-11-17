Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24997EEC28
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 07:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjKQGOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 01:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQGOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 01:14:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D898E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 22:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700201678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VUpORj+rghvOURt2cqFiyla06XABC+gEGq3EdDN5tVc=;
        b=hko/7YvNTPLM94beQ49bfrSCKwzJvjJQ5uZ8Cd6VrVff6Hlglxt6HM02fs6kflTMdG+vYp
        3WuAfWtf0/qPOPtJg7a27jfVN/665OylcWmeJg4gLxhppi7BMxhMmCfv/CTndm8QH2pVCn
        97ArOF6j8C5pW5i7whjOqu1TCXWiDZA=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-CeXCHsTWM_Gf48nnNYDHlQ-1; Fri, 17 Nov 2023 01:14:36 -0500
X-MC-Unique: CeXCHsTWM_Gf48nnNYDHlQ-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6d3251109ebso1588728a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 22:14:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700201675; x=1700806475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUpORj+rghvOURt2cqFiyla06XABC+gEGq3EdDN5tVc=;
        b=GDN0o66y4Ugxk/Uix/qk15m+YvxBNi73u1KGxjL3xxCGMxnMeQ76RM3qBJSI50Nutk
         Yvjh4CKqCtefWALW9NrpCmbUrNA1QpGhlYKtaZdzApEpDrq/OtvCa1zc0WEwoRVDthHB
         g+nh9hp6fnnWOtYj8W0QMkvD0e4wq5Erl2q30v9T5lnoFWZhafVaPjWYGpOOMrnt847Q
         c/WsU5HPvtONoLg2l5W3o7mL+ahnNgZ2Rp/UqEsa8XYttMspSKoI09mqVSLfXZ5n7cdq
         aOqdJP3slCTQlm1GNZXfGe2I3oN6E93jW2YDyWokygQ8r+xZBXkKj4Hhf2PwCwug7TXp
         Fv3g==
X-Gm-Message-State: AOJu0YxjcZ6sZbJpBlAIn9s2PVLBqtcjS04ZOctopEXtBt/4QGiQzPmR
        oWfH6JkT6Arky7n1fhWM0eaGjte2bXY/TXXxZJX1p2sdbqzRbl0Zdb6ZHiIOz/pqdWjEu0N7O+l
        VUCkurSqQcM6u4xF9bWzLW/xZWODjaCukJOWUPg==
X-Received: by 2002:a05:6870:9e97:b0:1e9:e975:4418 with SMTP id pu23-20020a0568709e9700b001e9e9754418mr22149566oab.53.1700201675197;
        Thu, 16 Nov 2023 22:14:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbpEhYnOd6YVXR0s56harE9n9MMBuyNrOv+l9CBSaeEEkIcbXu6FSelq1K6MXJ95/SMSJlMg==
X-Received: by 2002:a05:6870:9e97:b0:1e9:e975:4418 with SMTP id pu23-20020a0568709e9700b001e9e9754418mr22149560oab.53.1700201674906;
        Thu, 16 Nov 2023 22:14:34 -0800 (PST)
Received: from [10.72.112.63] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x10-20020aa793aa000000b006c010ba44d9sm702594pff.164.2023.11.16.22.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 22:14:34 -0800 (PST)
Message-ID: <31d14ae5-8d79-6e79-2e29-203d4062de7e@redhat.com>
Date:   Fri, 17 Nov 2023 14:14:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ceph: quota: Fix invalid pointer access in
Content-Language: en-US
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
 <6824ece2-33ee-63f4-2c7a-7033556325cb@redhat.com>
 <3a0b72e0-0784-0882-c18b-6178ed597670@huawei.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <3a0b72e0-0784-0882-c18b-6178ed597670@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/23 15:09, Wenchao Hao wrote:
> On 2023/11/16 11:06, Xiubo Li wrote:
>>
>> On 11/16/23 10:54, Wenchao Hao wrote:
>>> On 2023/11/15 21:34, Xiubo Li wrote:
>>>>
>>>> On 11/15/23 21:25, Ilya Dryomov wrote:
>>>>> On Wed, Nov 15, 2023 at 2:17 PM Xiubo Li <xiubli@redhat.com> wrote:
>>>>>>
>>>>>> On 11/15/23 20:32, Ilya Dryomov wrote:
>>>>>>> On Wed, Nov 15, 2023 at 1:35 AM Xiubo Li <xiubli@redhat.com> wrote:
>>>>>>>> On 11/14/23 23:31, Wenchao Hao wrote:
>>>>>>>>> This issue is reported by smatch, get_quota_realm() might return
>>>>>>>>> ERR_PTR, so we should using IS_ERR_OR_NULL here to check the 
>>>>>>>>> return
>>>>>>>>> value.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
>>>>>>>>> ---
>>>>>>>>>     fs/ceph/quota.c | 2 +-
>>>>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
>>>>>>>>> index 9d36c3532de1..c4b2929c6a83 100644
>>>>>>>>> --- a/fs/ceph/quota.c
>>>>>>>>> +++ b/fs/ceph/quota.c
>>>>>>>>> @@ -495,7 +495,7 @@ bool ceph_quota_update_statfs(struct 
>>>>>>>>> ceph_fs_client *fsc, struct kstatfs *buf)
>>>>>>>>>         realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root),
>>>>>>>>> QUOTA_GET_MAX_BYTES, true);
>>>>>>>>>         up_read(&mdsc->snap_rwsem);
>>>>>>>>> -     if (!realm)
>>>>>>>>> +     if (IS_ERR_OR_NULL(realm))
>>>>>>>>>                 return false;
>>>>>>>>>
>>>>>>>>> spin_lock(&realm->inodes_with_caps_lock);
>>>>>>>> Good catch.
>>>>>>>>
>>>>>>>> Reviewed-by: Xiubo Li <xiubli@redhat.com>
>>>>>>>>
>>>>>>>> We should CC the stable mail list.
>>>>>>> Hi Xiubo,
>>>>>>>
>>>>>>> What exactly is being fixed here?  get_quota_realm() is called with
>>>>>>> retry=true, which means that no errors can be returned -- 
>>>>>>> EAGAIN, the
>>>>>>> only error that get_quota_realm() can otherwise generate, would be
>>>>>>> handled internally by retrying.
>>>>>> Yeah, that's true.
>>>>>>
>>>>>>> Am I missing something that makes this qualify for stable?
>>>>>> Actually it's just for the smatch check for now.
>>>>>>
>>>>>> IMO we shouldn't depend on the 'retry', just potentially for new 
>>>>>> changes
>>>>>> in future could return a ERR_PTR and cause potential bugs.
>>>>> At present, ceph_quota_is_same_realm() also depends on it -- note how
>>>>> old_realm isn't checked for errors at all and new_realm is only 
>>>>> checked
>>>>> for EAGAIN there.
>>>>>
>>>>>> If that's not worth to make it for stable, let's remove it.
>>>>> Yes, let's remove it.  Please update the commit message as well, so
>>>>> that it's clear that this is squashing a static checker warning and
>>>>> doesn't actually fix any immediate bug.
>>>>
>>>> WenChao,
>>>>
>>>> Could update the commit comment and send the V2 ?
>>>>
>>>
>>> OK, I would update the commit comment as following:
>>>
>>> This issue is reported by smatch, get_quota_realm() might return
>>> ERR_PTR. It's not a immediate bug because get_quota_realm() is called
>>> with 'retry=true', no errors can be returned.
>>>
>>> While we still should check the return value of get_quota_realm() with
>>> IS_ERR_OR_NULL to avoid potential bugs if get_quota_realm() is changed
>>> to return other ERR_PTR in future.
>>>
>>> What's more, should I change the ceph_quota_is_same_realm() too?
>>>
>> Yeah, please. Let's fix them all.
>>
>
> is_same is return as true if both old_realm and new_realm are NULL, I 
> do not
> want to change the origin logic except add check for ERR_PTR, so 
> following
> is my change:
>
> 1. make sure xxx_realm is valid before calling ceph_put_snap_realm.
> 2. return false if new_realm or old_realm is ERR_PTR, this is newly added
>    and now we would always run with the else branch.
>
> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
> index c4b2929c6a83..8da9ffb05395 100644
> --- a/fs/ceph/quota.c
> +++ b/fs/ceph/quota.c
> @@ -290,16 +290,20 @@ bool ceph_quota_is_same_realm(struct inode *old, 
> struct inode *new)
>         new_realm = get_quota_realm(mdsc, new, QUOTA_GET_ANY, false);
>         if (PTR_ERR(new_realm) == -EAGAIN) {
>                 up_read(&mdsc->snap_rwsem);
> -               if (old_realm)
> +               if (!IS_ERR_OR_NULL(old_realm))
>                         ceph_put_snap_realm(mdsc, old_realm);
>                 goto restart;
>         }
> -       is_same = (old_realm == new_realm);
>         up_read(&mdsc->snap_rwsem);
>
> -       if (old_realm)
> +       if (IS_ERR(new_realm))
> +               is_same = false;
> +       else
> +               is_same = (old_realm == new_realm);
> +
> +       if (!IS_ERR_OR_NULL(old_realm))
>                 ceph_put_snap_realm(mdsc, old_realm);
> -       if (new_realm)
> +       if (!IS_ERR_OR_NULL(new_realm))
>                 ceph_put_snap_realm(mdsc, new_realm);
>
>         return is_same;
>
If we just to fix the smatch check, how about make get_quota_realm() to 
return a 'int' type value and at the same time add a 'realmp' parameter 
?  And just return '-EAGAIN' or '0' always.

Then it will be something likes:


diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index c4b2929c6a83..f37f5324b6a1 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -211,10 +211,9 @@ void ceph_cleanup_quotarealms_inodes(struct 
ceph_mds_client *mdsc)
   * this function will return -EAGAIN; otherwise, the snaprealms 
walk-through
   * will be restarted.
   */
-static struct ceph_snap_realm *get_quota_realm(struct ceph_mds_client 
*mdsc,
-                                              struct inode *inode,
-                                              enum quota_get_realm 
which_quota,
-                                              bool retry)
+static int get_quota_realm(struct ceph_mds_client *mdsc, struct inode 
*inode,
+                          enum quota_get_realm which_quota,
+                          struct ceph_snap_realm **realmp, bool retry)
  {
         struct ceph_client *cl = mdsc->fsc->client;
         struct ceph_inode_info *ci = NULL;
@@ -222,8 +221,10 @@ static struct ceph_snap_realm 
*get_quota_realm(struct ceph_mds_client *mdsc,
         struct inode *in;
         bool has_quota;

+       if (realmp)
+               *realmp = NULL;
         if (ceph_snap(inode) != CEPH_NOSNAP)
-               return NULL;
+               return 0;

  restart:
         realm = ceph_inode(inode)->i_snap_realm;
@@ -250,7 +251,7 @@ static struct ceph_snap_realm 
*get_quota_realm(struct ceph_mds_client *mdsc,
                                 break;
                         ceph_put_snap_realm(mdsc, realm);
                         if (!retry)
-                               return ERR_PTR(-EAGAIN);
+                               return -EAGAIN;
                         goto restart;
                 }

@@ -259,8 +260,11 @@ static struct ceph_snap_realm 
*get_quota_realm(struct ceph_mds_client *mdsc,
                 iput(in);

                 next = realm->parent;
-               if (has_quota || !next)
-                      return realm;
+               if (has_quota || !next) {
+                       if (realmp)
+                               *realmp = realm;
+                      return 0;
+               }

                 ceph_get_snap_realm(mdsc, next);
                 ceph_put_snap_realm(mdsc, realm);
@@ -269,14 +273,15 @@ static struct ceph_snap_realm 
*get_quota_realm(struct ceph_mds_client *mdsc,
         if (realm)
                 ceph_put_snap_realm(mdsc, realm);

-       return NULL;
+       return 0;
  }

  bool ceph_quota_is_same_realm(struct inode *old, struct inode *new)
  {
         struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(old->i_sb);
-       struct ceph_snap_realm *old_realm, *new_realm;
+       struct ceph_snap_realm *old_realm = NULL, *new_realm = NULL;
         bool is_same;
+       int ret;

  restart:
         /*
@@ -286,9 +291,9 @@ bool ceph_quota_is_same_realm(struct inode *old, 
struct inode *new)
          * dropped and we can then restart the whole operation.
          */
         down_read(&mdsc->snap_rwsem);
-       old_realm = get_quota_realm(mdsc, old, QUOTA_GET_ANY, true);
-       new_realm = get_quota_realm(mdsc, new, QUOTA_GET_ANY, false);
-       if (PTR_ERR(new_realm) == -EAGAIN) {
+       get_quota_realm(mdsc, old, QUOTA_GET_ANY, &old_relam, true);
+       ret = get_quota_realm(mdsc, new, QUOTA_GET_ANY, &new_realm, false);
+       if (ret == -EAGAIN) {
                 up_read(&mdsc->snap_rwsem);
                 if (old_realm)
                         ceph_put_snap_realm(mdsc, old_realm);


Won't be this better ?

Thanks

- Xiubo




>
>> Thanks
>>
>> - Xiubo
>>
>>
>>> Thanks
>>>
>>>> Thanks
>>>>
>>>> - Xiubo
>>>>
>>>>
>>>>> Thanks,
>>>>>
>>>>>                  Ilya
>>>>>
>>>>
>>>
>>
>>
>

