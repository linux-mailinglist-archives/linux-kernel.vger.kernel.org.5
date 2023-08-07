Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BA577179A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 02:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjHGA5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 20:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjHGA5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 20:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A26170E
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 17:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691369827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PBdt02jQJxYJLctZJ9NA+dTkM6X32fWZZU3BkW0cK0U=;
        b=cQ1d0vRrHQ7G8rIHzrTcsCBPfeV53OFrjX5Lah+4K//soTFGWDgH1y0xkEasJkKIF/vuc1
        sZxEdPHa2P20oFhpENUgjALRXIhN/9x+Esuqv5WghnSUG1ByVobtTOHxb4x+hcVcoI6wf9
        NawLqhj+R0LksXw+Dq7E9Xiu0m+1l5c=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-bEs09s5FPoqqpQux2rI3Xg-1; Sun, 06 Aug 2023 20:57:03 -0400
X-MC-Unique: bEs09s5FPoqqpQux2rI3Xg-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-348df33c423so37540275ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 17:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691369823; x=1691974623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBdt02jQJxYJLctZJ9NA+dTkM6X32fWZZU3BkW0cK0U=;
        b=lcOe/AFla3iRNyh4K1scnNW2lCknxbeYzWaYbKuEUsVm9/cFqSo1j9WaUyPufSLMxX
         0oGcSe0HoI3gbrQ3iZcSbAce4CWRWyo9BEzVUeREnFYaJPN+2BTSjjDpm0wb2ZSIBvXf
         SpWJAeF4a6HIz1ELeYevQIf/NhzoG062q0Pw/d0yJLMlgmGpcQ3hSM7xp415jRqNBZgX
         qnPj0r/UHONTyrAXoV9viWeatD+vIzQfyyRpGwrkWlHYIzZoXwGwt/SGQgM+1UAcNO/8
         1xruczTXO5xU/J84gtL/E+05yBg5hDUmDplxEaJxqGKDXGpS0OKt8nAxU3WrW+cj6ZeO
         bPJQ==
X-Gm-Message-State: AOJu0YwejwWIt0c77g0P24KtkETLEJtRZDkwEvQyU7EWzuapoUoAfi1Q
        oKXwLRNTxIR/8HWqL2AYZMNfM4VgMPEo9xmX+UJcV7wHPBzmY6pe7eS00T4DTA0UnucPu7oBCw6
        dRCOkLfvFxHiL8Qgnb+moa4aM
X-Received: by 2002:a05:6e02:d4f:b0:346:f30:ad58 with SMTP id h15-20020a056e020d4f00b003460f30ad58mr8853685ilj.24.1691369822857;
        Sun, 06 Aug 2023 17:57:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM4CL8iXTu6bA7Wj1nIAlAyA8MaOJtfr1zsFqLfAOZ6cA7i8mNd43NunVvYQViLnj2zN/r5w==
X-Received: by 2002:a05:6e02:d4f:b0:346:f30:ad58 with SMTP id h15-20020a056e020d4f00b003460f30ad58mr8853672ilj.24.1691369822594;
        Sun, 06 Aug 2023 17:57:02 -0700 (PDT)
Received: from [10.72.112.59] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k24-20020aa790d8000000b006829b28b393sm4841882pfk.199.2023.08.06.17.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 17:57:01 -0700 (PDT)
Message-ID: <7552e683-53ba-b6ef-7f86-9e8c2727072c@redhat.com>
Date:   Mon, 7 Aug 2023 08:56:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 03/12] ceph: handle idmapped mounts in
 create_request_message()
Content-Language: en-US
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com>
 <20230803135955.230449-4-aleksandr.mikhalitsyn@canonical.com>
 <71018b94-45a0-3404-d3d0-d9f808a72a00@redhat.com>
 <41ba61bf-3a45-cb20-1e4c-38dbd65bafa6@redhat.com>
 <CAEivzxcmurnArPRuLWXDjA2+qdicz4rnxA8ESTQprHJM1kKEnA@mail.gmail.com>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <CAEivzxcmurnArPRuLWXDjA2+qdicz4rnxA8ESTQprHJM1kKEnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/4/23 14:35, Aleksandr Mikhalitsyn wrote:
> On Fri, Aug 4, 2023 at 5:24 AM Xiubo Li <xiubli@redhat.com> wrote:
>>
>> On 8/4/23 10:26, Xiubo Li wrote:
>>> On 8/3/23 21:59, Alexander Mikhalitsyn wrote:
>>>> From: Christian Brauner <brauner@kernel.org>
>>>>
>>>> Inode operations that create a new filesystem object such as ->mknod,
>>>> ->create, ->mkdir() and others don't take a {g,u}id argument explicitly.
>>>> Instead the caller's fs{g,u}id is used for the {g,u}id of the new
>>>> filesystem object.
>>>>
>>>> In order to ensure that the correct {g,u}id is used map the caller's
>>>> fs{g,u}id for creation requests. This doesn't require complex changes.
>>>> It suffices to pass in the relevant idmapping recorded in the request
>>>> message. If this request message was triggered from an inode operation
>>>> that creates filesystem objects it will have passed down the relevant
>>>> idmaping. If this is a request message that was triggered from an inode
>>>> operation that doens't need to take idmappings into account the initial
>>>> idmapping is passed down which is an identity mapping.
>>>>
>>>> This change uses a new cephfs protocol extension
>>>> CEPHFS_FEATURE_HAS_OWNER_UIDGID
>>>> which adds two new fields (owner_{u,g}id) to the request head structure.
>>>> So, we need to ensure that MDS supports it otherwise we need to fail
>>>> any IO that comes through an idmapped mount because we can't process it
>>>> in a proper way. MDS server without such an extension will use
>>>> caller_{u,g}id
>>>> fields to set a new inode owner UID/GID which is incorrect because
>>>> caller_{u,g}id
>>>> values are unmapped. At the same time we can't map these fields with an
>>>> idmapping as it can break UID/GID-based permission checks logic on the
>>>> MDS side. This problem was described with a lot of details at [1], [2].
>>>>
>>>> [1]
>>>> https://lore.kernel.org/lkml/CAEivzxfw1fHO2TFA4dx3u23ZKK6Q+EThfzuibrhA3RKM=ZOYLg@mail.gmail.com/
>>>> [2]
>>>> https://lore.kernel.org/all/20220104140414.155198-3-brauner@kernel.org/
>>>>
>>>> https://github.com/ceph/ceph/pull/52575
>>>> https://tracker.ceph.com/issues/62217
>>>>
>>>> Cc: Xiubo Li <xiubli@redhat.com>
>>>> Cc: Jeff Layton <jlayton@kernel.org>
>>>> Cc: Ilya Dryomov <idryomov@gmail.com>
>>>> Cc: ceph-devel@vger.kernel.org
>>>> Co-Developed-by: Alexander Mikhalitsyn
>>>> <aleksandr.mikhalitsyn@canonical.com>
>>>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>>>> Signed-off-by: Alexander Mikhalitsyn
>>>> <aleksandr.mikhalitsyn@canonical.com>
>>>> ---
>>>> v7:
>>>>      - reworked to use two new fields for owner UID/GID
>>>> (https://github.com/ceph/ceph/pull/52575)
>>>> v8:
>>>>      - properly handled case when old MDS used with new kernel client
>>>> ---
>>>>    fs/ceph/mds_client.c         | 46 +++++++++++++++++++++++++++++++++---
>>>>    fs/ceph/mds_client.h         |  5 +++-
>>>>    include/linux/ceph/ceph_fs.h |  4 +++-
>>>>    3 files changed, 50 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>>>> index 8829f55103da..7d3106d3b726 100644
>>>> --- a/fs/ceph/mds_client.c
>>>> +++ b/fs/ceph/mds_client.c
>>>> @@ -2902,6 +2902,17 @@ static void encode_mclientrequest_tail(void
>>>> **p, const struct ceph_mds_request *
>>>>        }
>>>>    }
>>>>    +static inline u16 mds_supported_head_version(struct
>>>> ceph_mds_session *session)
>>>> +{
>>>> +    if (!test_bit(CEPHFS_FEATURE_32BITS_RETRY_FWD,
>>>> &session->s_features))
>>>> +        return 1;
>>>> +
>>>> +    if (!test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID,
>>>> &session->s_features))
>>>> +        return 2;
>>>> +
>>>> +    return CEPH_MDS_REQUEST_HEAD_VERSION;
>>>> +}
>>>> +
>>>>    static struct ceph_mds_request_head_legacy *
>>>>    find_legacy_request_head(void *p, u64 features)
>>>>    {
>>>> @@ -2923,6 +2934,7 @@ static struct ceph_msg
>>>> *create_request_message(struct ceph_mds_session *session,
>>>>    {
>>>>        int mds = session->s_mds;
>>>>        struct ceph_mds_client *mdsc = session->s_mdsc;
>>>> +    struct ceph_client *cl = mdsc->fsc->client;
>>>>        struct ceph_msg *msg;
>>>>        struct ceph_mds_request_head_legacy *lhead;
>>>>        const char *path1 = NULL;
>>>> @@ -2936,7 +2948,7 @@ static struct ceph_msg
>>>> *create_request_message(struct ceph_mds_session *session,
>>>>        void *p, *end;
>>>>        int ret;
>>>>        bool legacy = !(session->s_con.peer_features &
>>>> CEPH_FEATURE_FS_BTIME);
>>>> -    bool old_version = !test_bit(CEPHFS_FEATURE_32BITS_RETRY_FWD,
>>>> &session->s_features);
>>>> +    u16 request_head_version = mds_supported_head_version(session);
>>>>          ret = set_request_path_attr(mdsc, req->r_inode, req->r_dentry,
>>>>                      req->r_parent, req->r_path1, req->r_ino1.ino,
>>>> @@ -2977,8 +2989,10 @@ static struct ceph_msg
>>>> *create_request_message(struct ceph_mds_session *session,
>>>>         */
>>>>        if (legacy)
>>>>            len = sizeof(struct ceph_mds_request_head_legacy);
>>>> -    else if (old_version)
>>>> +    else if (request_head_version == 1)
>>>>            len = sizeof(struct ceph_mds_request_head_old);
>>>> +    else if (request_head_version == 2)
>>>> +        len = offsetofend(struct ceph_mds_request_head, ext_num_fwd);
>>>>        else
>>>>            len = sizeof(struct ceph_mds_request_head);
>>> This is not what we suppose to. If we do this again and again when
>>> adding new members it will make the code very complicated to maintain.
>>>
>>> Once the CEPHFS_FEATURE_32BITS_RETRY_FWD has been supported the ceph
>>> should correctly decode it and if CEPHFS_FEATURE_HAS_OWNER_UIDGID is
>>> not supported the decoder should skip it directly.
>>>
>>> Is the MDS side buggy ? Why you last version didn't work ?
>>>
>> I think the ceph side is buggy. Possibly we should add one new `length`
>> member in struct `struct ceph_mds_request_head` and just skip the extra
>> bytes when decoding it.
> Hm, I think I found something suspicious. In cephfs code we have many
> places that
> call the DECODE_FINISH macro, but in our decoder we don't have it.
>
>  From documentation it follows that DECODE_FINISH purpose is precisely
> about this problem.
>
> What do you think?

Yeah, correct.

We also need to do it like this.

Thanks

- Xiubo


>> Could you fix it together with your ceph PR ?
>>
>> Thanks
>>
>> - Xiubo
>>
>>
>>> Thanks
>>>
>>> - Xiubo
>>>
>>>> @@ -3028,6 +3042,16 @@ static struct ceph_msg
>>>> *create_request_message(struct ceph_mds_session *session,
>>>>        lhead = find_legacy_request_head(msg->front.iov_base,
>>>>                         session->s_con.peer_features);
>>>>    +    if ((req->r_mnt_idmap != &nop_mnt_idmap) &&
>>>> +        !test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID,
>>>> &session->s_features)) {
>>>> +        pr_err_ratelimited_client(cl,
>>>> +            "idmapped mount is used and
>>>> CEPHFS_FEATURE_HAS_OWNER_UIDGID"
>>>> +            " is not supported by MDS. Fail request with -EIO.\n");
>>>> +
>>>> +        ret = -EIO;
>>>> +        goto out_err;
>>>> +    }
>>>> +
>>>>        /*
>>>>         * The ceph_mds_request_head_legacy didn't contain a version
>>>> field, and
>>>>         * one was added when we moved the message version from 3->4.
>>>> @@ -3035,17 +3059,33 @@ static struct ceph_msg
>>>> *create_request_message(struct ceph_mds_session *session,
>>>>        if (legacy) {
>>>>            msg->hdr.version = cpu_to_le16(3);
>>>>            p = msg->front.iov_base + sizeof(*lhead);
>>>> -    } else if (old_version) {
>>>> +    } else if (request_head_version == 1) {
>>>>            struct ceph_mds_request_head_old *ohead = msg->front.iov_base;
>>>>              msg->hdr.version = cpu_to_le16(4);
>>>>            ohead->version = cpu_to_le16(1);
>>>>            p = msg->front.iov_base + sizeof(*ohead);
>>>> +    } else if (request_head_version == 2) {
>>>> +        struct ceph_mds_request_head *nhead = msg->front.iov_base;
>>>> +
>>>> +        msg->hdr.version = cpu_to_le16(6);
>>>> +        nhead->version = cpu_to_le16(2);
>>>> +
>>>> +        p = msg->front.iov_base + offsetofend(struct
>>>> ceph_mds_request_head, ext_num_fwd);
>>>>        } else {
>>>>            struct ceph_mds_request_head *nhead = msg->front.iov_base;
>>>> +        kuid_t owner_fsuid;
>>>> +        kgid_t owner_fsgid;
>>>>              msg->hdr.version = cpu_to_le16(6);
>>>>            nhead->version = cpu_to_le16(CEPH_MDS_REQUEST_HEAD_VERSION);
>>>> +
>>>> +        owner_fsuid = from_vfsuid(req->r_mnt_idmap, &init_user_ns,
>>>> +                      VFSUIDT_INIT(req->r_cred->fsuid));
>>>> +        owner_fsgid = from_vfsgid(req->r_mnt_idmap, &init_user_ns,
>>>> +                      VFSGIDT_INIT(req->r_cred->fsgid));
>>>> +        nhead->owner_uid = cpu_to_le32(from_kuid(&init_user_ns,
>>>> owner_fsuid));
>>>> +        nhead->owner_gid = cpu_to_le32(from_kgid(&init_user_ns,
>>>> owner_fsgid));
>>>>            p = msg->front.iov_base + sizeof(*nhead);
>>>>        }
>>>>    diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
>>>> index e3bbf3ba8ee8..8f683e8203bd 100644
>>>> --- a/fs/ceph/mds_client.h
>>>> +++ b/fs/ceph/mds_client.h
>>>> @@ -33,8 +33,10 @@ enum ceph_feature_type {
>>>>        CEPHFS_FEATURE_NOTIFY_SESSION_STATE,
>>>>        CEPHFS_FEATURE_OP_GETVXATTR,
>>>>        CEPHFS_FEATURE_32BITS_RETRY_FWD,
>>>> +    CEPHFS_FEATURE_NEW_SNAPREALM_INFO,
>>>> +    CEPHFS_FEATURE_HAS_OWNER_UIDGID,
>>>>    -    CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_32BITS_RETRY_FWD,
>>>> +    CEPHFS_FEATURE_MAX = CEPHFS_FEATURE_HAS_OWNER_UIDGID,
>>>>    };
>>>>      #define CEPHFS_FEATURES_CLIENT_SUPPORTED {    \
>>>> @@ -49,6 +51,7 @@ enum ceph_feature_type {
>>>>        CEPHFS_FEATURE_NOTIFY_SESSION_STATE,    \
>>>>        CEPHFS_FEATURE_OP_GETVXATTR,        \
>>>>        CEPHFS_FEATURE_32BITS_RETRY_FWD,    \
>>>> +    CEPHFS_FEATURE_HAS_OWNER_UIDGID,    \
>>>>    }
>>>>      /*
>>>> diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
>>>> index 5f2301ee88bc..6eb83a51341c 100644
>>>> --- a/include/linux/ceph/ceph_fs.h
>>>> +++ b/include/linux/ceph/ceph_fs.h
>>>> @@ -499,7 +499,7 @@ struct ceph_mds_request_head_legacy {
>>>>        union ceph_mds_request_args args;
>>>>    } __attribute__ ((packed));
>>>>    -#define CEPH_MDS_REQUEST_HEAD_VERSION  2
>>>> +#define CEPH_MDS_REQUEST_HEAD_VERSION  3
>>>>      struct ceph_mds_request_head_old {
>>>>        __le16 version;                /* struct version */
>>>> @@ -530,6 +530,8 @@ struct ceph_mds_request_head {
>>>>          __le32 ext_num_retry;          /* new count retry attempts */
>>>>        __le32 ext_num_fwd;            /* new count fwd attempts */
>>>> +
>>>> +    __le32 owner_uid, owner_gid;   /* used for OPs which create
>>>> inodes */
>>>>    } __attribute__ ((packed));
>>>>      /* cap/lease release record */

