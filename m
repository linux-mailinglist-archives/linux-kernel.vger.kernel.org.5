Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4BB7EC13A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 12:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343597AbjKOLZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 06:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343564AbjKOLZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 06:25:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA73F5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 03:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700047508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wqbAxW2GAT8nJitK9StpM8khtVuzEK0iC8oZKl6SFWw=;
        b=FlwLYe6kdXCkOkGNAF56/7dHi/aHRYR7QmOK8np7Uf8phjYgnKIYaJW5hCrFB1KSbRG6O/
        8Dsc9/UpD/QtOgc9sbFHwJaYrEsPr+QEDWGa5P9r7I5crJ6Y9Xtg8pix3oP/6qfyPUggHg
        nKpprKlFGq+mq4FAjD83IejYgMFuYFY=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448--eed9CG_P--lIlBKDJgnOQ-1; Wed, 15 Nov 2023 06:25:07 -0500
X-MC-Unique: -eed9CG_P--lIlBKDJgnOQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6d3251109ebso7034366a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 03:25:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700047506; x=1700652306;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqbAxW2GAT8nJitK9StpM8khtVuzEK0iC8oZKl6SFWw=;
        b=KPaUfAFQmfeAwy6Fxw1WQSGCjYf+XRlGDN/wLZFI0xOD+H099DpbxJTZrAe1JCiaRT
         F54Os28eL6ehGc72ssyROLXBhA5/O0YSdqDMpFVRLqGJUY1wX80/PlysPMGE4/A/wqkx
         H2WvUVlmPDnsOPdbbfi3TaKbccDTsdpy6i5UKlEBzUociHdess+ng/Mp5FV49cW7qb6N
         MKYf9Mhp82c1QJLNtSsX8FIvoS70V1v73CGne0UAy75Gk3bNoPI5e2qtUpbLXFCC/oks
         VnyESijauXHgAkodx6AryaaigmxQN3zSZZTL7vIMPKWXvbNWOwDLsPVp5XY29ep1Y5WB
         M6cQ==
X-Gm-Message-State: AOJu0Yxx+4A7KgKGd8gOFJb4enuFYL47v7LHG04phokZP4irT/QaE9ha
        unS18jf7xxQ4+vtEkRbJalrl7B1fJcebmzCndHYBIZ4gnMZWUNFNOXNHxCh366hR1rzVnfOYiJm
        SZw6Ia+GzgZYxLBLKW2GQAbwgODWenebOExQ=
X-Received: by 2002:a05:6870:7f0e:b0:1e9:e063:ca6b with SMTP id xa14-20020a0568707f0e00b001e9e063ca6bmr14402550oab.32.1700047506525;
        Wed, 15 Nov 2023 03:25:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFY82T2RMO59Te4c7OF3TdHRYkC0Lhptd39Gk4hWYviUMnyR0+TL9x/XCnEtJ/DZqFORMiVdg==
X-Received: by 2002:a05:6870:7f0e:b0:1e9:e063:ca6b with SMTP id xa14-20020a0568707f0e00b001e9e063ca6bmr14402537oab.32.1700047506288;
        Wed, 15 Nov 2023 03:25:06 -0800 (PST)
Received: from [10.72.112.63] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j16-20020a056a00131000b006c4d2479bf8sm2636454pfu.51.2023.11.15.03.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 03:25:05 -0800 (PST)
Message-ID: <93f049f1-f409-0759-f2a9-0c32d88130fd@redhat.com>
Date:   Wed, 15 Nov 2023 19:25:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ceph: quota: Fix invalid pointer access in
Content-Language: en-US
To:     Luis Henriques <lhenriques@suse.de>,
        Wenchao Hao <haowenchao2@huawei.com>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, louhongxiang@huawei.com
References: <20231114153108.1932884-1-haowenchao2@huawei.com>
 <875y238drx.fsf@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
In-Reply-To: <875y238drx.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/15/23 19:19, Luis Henriques wrote:
> Wenchao Hao <haowenchao2@huawei.com> writes:
>
>> This issue is reported by smatch, get_quota_realm() might return
>> ERR_PTR, so we should using IS_ERR_OR_NULL here to check the return
>> value.
>>
>> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
>> ---
>>   fs/ceph/quota.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
>> index 9d36c3532de1..c4b2929c6a83 100644
>> --- a/fs/ceph/quota.c
>> +++ b/fs/ceph/quota.c
>> @@ -495,7 +495,7 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *fsc, struct kstatfs *buf)
>>   	realm = get_quota_realm(mdsc, d_inode(fsc->sb->s_root),
>>   				QUOTA_GET_MAX_BYTES, true);
>>   	up_read(&mdsc->snap_rwsem);
>> -	if (!realm)
>> +	if (IS_ERR_OR_NULL(realm))
>>   		return false;
>>   
>>   	spin_lock(&realm->inodes_with_caps_lock);
>> -- 
>>
>> 2.32.0
>>
> This looks right to me, the issue was introduced by commit 0c44a8e0fc55
> ("ceph: quota: fix quota subdir mounts").  FWIW:
>
> Reviewed-by: Luis Henriques <lhenriques@suse.de>

Thanks Luis. I have updated the testing branch.

- Xiubo


> Cheers,

