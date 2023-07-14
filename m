Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4BF753730
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbjGNJ4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjGNJ4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2138A7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689328532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kf132iRZ20EenuRtRXLIaAVz4mLH2YgT891kbbdMT6M=;
        b=SL3uT16hIKbhjOnnRKKbbBZVj1/FgJelEKWlzj0rvRc7vczXbcpFm4uCAbehtlwrAV+6Wf
        VAek4L43DACF8oJb3c/cCKf3Fht3gNANJzHS5X6oFx/bC3H6F8foAOua2NzrirUdUm9NPI
        OPlXyGIzvdC0qEyMGKEpv73lYYhcKIo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-CHRHn0HDOAqLS3Ur8nwQWQ-1; Fri, 14 Jul 2023 05:55:30 -0400
X-MC-Unique: CHRHn0HDOAqLS3Ur8nwQWQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31429e93f26so1136075f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689328529; x=1691920529;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kf132iRZ20EenuRtRXLIaAVz4mLH2YgT891kbbdMT6M=;
        b=ag0VhTD+JAsHd8iasIRBSRvEUJRzReQfCwAMVTjDVIb6hN/c3Q7acVRKAAsycRN4CE
         Tx5cdAqnx2Q7ilJUgvhD7KQY0/j5lCc6DTKMQwBw63FaeRYj8Vs8pkM1XhhId+FwysHL
         3e84wBJo8xqVUiWVKCA25aV+tAUooKPku8O1m1Ypalpml7Q1iq4Up03jlAr81WjbFpk7
         UJSordPMiYG6QZug670b08xO4qUlLnVygQfehwIGu1uky3UGpFz42H6oWrzR/9SGtTtG
         Meypt/6hkYVjL8fw+ZXxLaWcZDeAZWDGIz4y6j3rN2oMuWaxwNuYGvOtIDr6YUiiqJeX
         EHMA==
X-Gm-Message-State: ABy/qLb8wd7Vr64GMfiRmILycuLpVh4ayf2M3NLt+LPuDT5BZy9fjnTz
        iVaKSsRbIpYfnNwXRR/8Xog+nBv4tGMIuUrBiyiZHynMij53yZPe/VdDvAubvV/uP3oWqK+MV0J
        zvvazdg1OGbUDaX7X8Fi6GvdG
X-Received: by 2002:a5d:67d0:0:b0:313:fbd0:9813 with SMTP id n16-20020a5d67d0000000b00313fbd09813mr3466956wrw.28.1689328529634;
        Fri, 14 Jul 2023 02:55:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEdlUo+JN4v1o9lTJZqXuq/+tLZCVapgyI00wczrknXcEiLAc8BYt3hBc2KTjJX7LpL9n/i0g==
X-Received: by 2002:a5d:67d0:0:b0:313:fbd0:9813 with SMTP id n16-20020a5d67d0000000b00313fbd09813mr3466946wrw.28.1689328529256;
        Fri, 14 Jul 2023 02:55:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:4500:8a9e:a24a:133d:86bb? (p200300cbc70a45008a9ea24a133d86bb.dip0.t-ipconnect.de. [2003:cb:c70a:4500:8a9e:a24a:133d:86bb])
        by smtp.gmail.com with ESMTPSA id w16-20020a5d6810000000b003144b50034esm10371315wru.110.2023.07.14.02.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 02:55:28 -0700 (PDT)
Message-ID: <e609bed0-b6c2-1905-36a8-f94b85fd350b@redhat.com>
Date:   Fri, 14 Jul 2023 11:55:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 0/4] virtio-mem: memory unplug/offlining related
 cleanups
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230713145551.2824980-1-david@redhat.com>
 <20230713110235-mutt-send-email-mst@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230713110235-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.07.23 17:03, Michael S. Tsirkin wrote:
> On Thu, Jul 13, 2023 at 04:55:47PM +0200, David Hildenbrand wrote:
>> Some cleanups+optimizations primarily around offline_and_remove_memory().
>>
>> Patch #1 drops the "unsafe unplug" feature where we might get stuck in
>> offline_and_remove_memory() forever.
>>
>> Patch #2 handles unexpected errors from offline_and_remove_memory() a bit
>> nicer.
>>
>> Patch #3 handles the case where offline_and_remove_memory() failed and
>> we want to retry later to remove a completely unplugged Linux memory
>> block, to not have them waste memory forever.
>>
>> Patch #4 something I had lying around for longer, which reacts faster
>> on config changes when unplugging memory.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> 
> This looks like something that's reasonable to put in this linux, right?
> These are fixes even though they are for theoretical issues.

Yes, but these are not high-priority fixes+optimizations. So if you feel 
like we should be delaying them, fine with me.

On the other hand, getting them in now also shouldn't really hurt. 
Especially patch #1 might be better of just going in soner than later.

-- 
Cheers,

David / dhildenb

