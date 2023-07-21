Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F36F75D58E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjGUUUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjGUUTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:19:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139C53C3C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 13:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689970689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0RGmyz1YClWe5oeSPHTFZ5N1VM0OIPODLNu2thu5Rsg=;
        b=PIFP2qGwfJw4x7usSEJwHYwdHCznEkv5psN3BB2InSI6fjNfDCisrKt3k/C7KIBKxTQdai
        dVBTMUNyVOH2Hn1WDpTxN0HFM2rDRwwoH7Og2LRKLmcCwWqBq30ytWvQgFhgbJ2mEjqdeZ
        X3vR4/gGTyAZdG0B8IMj5+VFrYTQZ2A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-W1m1jmxPN9eDPWD0u3VPmg-1; Fri, 21 Jul 2023 16:18:08 -0400
X-MC-Unique: W1m1jmxPN9eDPWD0u3VPmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CD16101A528;
        Fri, 21 Jul 2023 20:18:07 +0000 (UTC)
Received: from [10.39.208.41] (unknown [10.39.208.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 218531121314;
        Fri, 21 Jul 2023 20:18:04 +0000 (UTC)
Message-ID: <e3490755-35ac-89b4-b0fa-b63720a9a5c9@redhat.com>
Date:   Fri, 21 Jul 2023 22:18:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v4 2/2] virtio-net: add cond_resched() to the
 command waiting loop
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Shannon Nelson <shannon.nelson@amd.com>,
        Jason Wang <jasowang@redhat.com>, xuanzhuo@linux.alibaba.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
References: <20230720083839.481487-1-jasowang@redhat.com>
 <20230720083839.481487-3-jasowang@redhat.com>
 <e4eb0162-d303-b17c-a71d-ca3929380b31@amd.com>
 <20230720170001-mutt-send-email-mst@kernel.org>
 <263a5ad7-1189-3be3-70de-c38a685bebe0@redhat.com>
 <20230721104445-mutt-send-email-mst@kernel.org>
 <6278a4aa-8901-b0e3-342f-5753a4bf32af@redhat.com>
 <20230721110925-mutt-send-email-mst@kernel.org>
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <20230721110925-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/23 17:10, Michael S. Tsirkin wrote:
> On Fri, Jul 21, 2023 at 04:58:04PM +0200, Maxime Coquelin wrote:
>>
>>
>> On 7/21/23 16:45, Michael S. Tsirkin wrote:
>>> On Fri, Jul 21, 2023 at 04:37:00PM +0200, Maxime Coquelin wrote:
>>>>
>>>>
>>>> On 7/20/23 23:02, Michael S. Tsirkin wrote:
>>>>> On Thu, Jul 20, 2023 at 01:26:20PM -0700, Shannon Nelson wrote:
>>>>>> On 7/20/23 1:38 AM, Jason Wang wrote:
>>>>>>>
>>>>>>> Adding cond_resched() to the command waiting loop for a better
>>>>>>> co-operation with the scheduler. This allows to give CPU a breath to
>>>>>>> run other task(workqueue) instead of busy looping when preemption is
>>>>>>> not allowed on a device whose CVQ might be slow.
>>>>>>>
>>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>>>
>>>>>> This still leaves hung processes, but at least it doesn't pin the CPU any
>>>>>> more.  Thanks.
>>>>>> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
>>>>>>
>>>>>
>>>>> I'd like to see a full solution
>>>>> 1- block until interrupt
>>>>
>>>> Would it make sense to also have a timeout?
>>>> And when timeout expires, set FAILED bit in device status?
>>>
>>> virtio spec does not set any limits on the timing of vq
>>> processing.
>>
>> Indeed, but I thought the driver could decide it is too long for it.
>>
>> The issue is we keep waiting with rtnl locked, it can quickly make the
>> system unusable.
> 
> if this is a problem we should find a way not to keep rtnl
> locked indefinitely.

 From the tests I have done, I think it is. With OVS, a reconfiguration 
is performed when the VDUSE device is added, and when a MLX5 device is
in the same bridge, it ends up doing an ioctl() that tries to take the
rtnl lock. In this configuration, it is not possible to kill OVS because
it is stuck trying to acquire rtnl lock for mlx5 that is held by virtio-
net.

> 
>>>>> 2- still handle surprise removal correctly by waking in that case
>>>>>
>>>>>
>>>>>
>>>>>>> ---
>>>>>>>      drivers/net/virtio_net.c | 4 +++-
>>>>>>>      1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>>>>> index 9f3b1d6ac33d..e7533f29b219 100644
>>>>>>> --- a/drivers/net/virtio_net.c
>>>>>>> +++ b/drivers/net/virtio_net.c
>>>>>>> @@ -2314,8 +2314,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>>>>>>>              * into the hypervisor, so the request should be handled immediately.
>>>>>>>              */
>>>>>>>             while (!virtqueue_get_buf(vi->cvq, &tmp) &&
>>>>>>> -              !virtqueue_is_broken(vi->cvq))
>>>>>>> +              !virtqueue_is_broken(vi->cvq)) {
>>>>>>> +               cond_resched();
>>>>>>>                     cpu_relax();
>>>>>>> +       }
>>>>>>>
>>>>>>>             return vi->ctrl->status == VIRTIO_NET_OK;
>>>>>>>      }
>>>>>>> --
>>>>>>> 2.39.3
>>>>>>>
>>>>>>> _______________________________________________
>>>>>>> Virtualization mailing list
>>>>>>> Virtualization@lists.linux-foundation.org
>>>>>>> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>>>>>
>>>
> 

