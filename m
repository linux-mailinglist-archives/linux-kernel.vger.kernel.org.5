Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE75978E411
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 02:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244404AbjHaA43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 20:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjHaA42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 20:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851ACC5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693443338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ddPWXyjeHrI19yJxQJKSFG8ckl/5yZrofT1cwTzp4OI=;
        b=VW6txTEtaY/nVQHDsQbw23eUUv+jV/g+SBAMJK/KZyTQ0zTBRfmgMxNPJHuYOFYkT/tqC7
        AoMuj9QRszYCIHohBFJyiYhxIotprwhv78GeaIN6hkXKyVv4pmrEBEuTwDOMJZNLqMmp+4
        MQE/j6MlRtBDGbFvdWx307UE3LrQJaI=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-33MCDG5cM2K1KcZOCppgxg-1; Wed, 30 Aug 2023 20:55:36 -0400
X-MC-Unique: 33MCDG5cM2K1KcZOCppgxg-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-55afcc54d55so1477268a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693443335; x=1694048135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddPWXyjeHrI19yJxQJKSFG8ckl/5yZrofT1cwTzp4OI=;
        b=Txdo9er9NVV3YcEu/wfJbpX6J/+A7ML+7MOcPE+gxqN7SqFGWqIrLKuuVO3Y+RLerk
         FOZY5f+XWS/av3p/RA4uCOkKndehvlmmdX6thNCrfxI/lh9JglZS/P2W0yrv7O97TmtU
         DDgRCKrGWyhTbGcpFDuLFpkCYYtSolKC+05jO4h29oripZ1l5OVSXL+VNr8f8C+XEdCg
         rs4rn1jE3AWu6EU+BfMb6MxVPvY2w/Ri9wX+SyNeBHUrwRk7yX7LeB901R7AFmubOr1c
         yVe+T6wfRXlEnvcw5XVvrHyc9mzgueNITgvV81aPigG3UMUjMzvZikfB9q0+O2In9PG0
         S4WQ==
X-Gm-Message-State: AOJu0YzAD0u8b5G9UDvyMsM/f29mhcQhw8tIHB57ZwxE83YwwMugQzlh
        7/a/OdpASpDiRWc53+ofXjNa+dJ563JqH5QoUDd7YIYCJz3FcsvV6qBp5prciLctu1MhC4VVaig
        aMCstvOskdjXwVeGReVDZi/4z
X-Received: by 2002:a05:6a20:3cab:b0:149:97e4:8ae4 with SMTP id b43-20020a056a203cab00b0014997e48ae4mr1735660pzj.0.1693443335524;
        Wed, 30 Aug 2023 17:55:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1F2T71Ojl1Jpdqpquexx1XTD8oeByqwPBqSl8BEi9B5Ecr+9kpxXOli0qBmMGEBS+lADhUQ==
X-Received: by 2002:a05:6a20:3cab:b0:149:97e4:8ae4 with SMTP id b43-20020a056a203cab00b0014997e48ae4mr1735645pzj.0.1693443335183;
        Wed, 30 Aug 2023 17:55:35 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id w20-20020a639354000000b00564be149a15sm205429pgm.65.2023.08.30.17.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 17:55:34 -0700 (PDT)
Message-ID: <eb8f274b-03d9-6b1c-5a4e-d004bdde2804@redhat.com>
Date:   Thu, 31 Aug 2023 10:55:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] virtio_balloon: Fix endless deflation and inflation on
 arm64
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com, mst@redhat.com,
        xuanzhuo@linux.alibaba.com, shan.gavin@gmail.com
References: <20230829015421.920511-1-gshan@redhat.com>
 <d2bf8d72-8d41-e26f-2dc7-d45973fe2164@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <d2bf8d72-8d41-e26f-2dc7-d45973fe2164@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/23 02:30, David Hildenbrand wrote:
> On 29.08.23 03:54, Gavin Shan wrote:
>> The deflation request to the target, which isn't unaligned to the
>> guest page size causes endless deflation and inflation actions. For
>> example, we receive the flooding QMP events for the changes on memory
>> balloon's size after a deflation request to the unaligned target is
>> sent for the ARM64 guest, where we have 64KB base page size.
>>
>>    /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
>>    -accel kvm -machine virt,gic-version=host -cpu host          \
>>    -smp maxcpus=8,cpus=8,sockets=2,clusters=2,cores=2,threads=1 \
>>    -m 1024M,slots=16,maxmem=64G                                 \
>>    -object memory-backend-ram,id=mem0,size=512M                 \
>>    -object memory-backend-ram,id=mem1,size=512M                 \
>>    -numa node,nodeid=0,memdev=mem0,cpus=0-3                     \
>>    -numa node,nodeid=1,memdev=mem1,cpus=4-7                     \
>>      :                                                          \
>>    -device virtio-balloon-pci,id=balloon0,bus=pcie.10
>>
>>    { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
>>    {"return": {}}
>>    {"timestamp": {"seconds": 1693272173, "microseconds": 88667},   \
>>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>    {"timestamp": {"seconds": 1693272174, "microseconds": 89704},   \
>>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>    {"timestamp": {"seconds": 1693272175, "microseconds": 90819},   \
>>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>    {"timestamp": {"seconds": 1693272176, "microseconds": 91961},   \
>>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>    {"timestamp": {"seconds": 1693272177, "microseconds": 93040},   \
>>     "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>>    {"timestamp": {"seconds": 1693272178, "microseconds": 94117},   \
>>     "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>>    {"timestamp": {"seconds": 1693272179, "microseconds": 95337},   \
>>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>    {"timestamp": {"seconds": 1693272180, "microseconds": 96615},   \
>>     "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>>    {"timestamp": {"seconds": 1693272181, "microseconds": 97626},   \
>>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>    {"timestamp": {"seconds": 1693272182, "microseconds": 98693},   \
>>     "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>>    {"timestamp": {"seconds": 1693272183, "microseconds": 99698},   \
>>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>    {"timestamp": {"seconds": 1693272184, "microseconds": 100727},  \
>>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>    {"timestamp": {"seconds": 1693272185, "microseconds": 90430},   \
>>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>    {"timestamp": {"seconds": 1693272186, "microseconds": 102999},  \
>>     "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>>       :
>>    <The similar QMP events repeat>
>>
>> Fix it by having the target aligned to the guest page size, 64KB
>> in this specific case. With this applied, no flooding QMP event
>> is observed and the memory balloon's size can be stablizied to
>> 0x3ffe0000 soon after the deflation request is sent.
>>
>>    { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
>>    {"return": {}}
>>    {"timestamp": {"seconds": 1693273328, "microseconds": 793075},  \
>>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>    { "execute" : "query-balloon" }
>>    {"return": {"actual": 1073610752}}
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   drivers/virtio/virtio_balloon.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index 5b15936a5214..625caac35264 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -386,6 +386,17 @@ static void stats_handle_request(struct virtio_balloon *vb)
>>       virtqueue_kick(vq);
>>   }
>> +static inline s64 align_pages_up(s64 diff)
>> +{
>> +    if (diff == 0)
>> +        return diff;
>> +
>> +    if (diff > 0)
>> +        return ALIGN(diff, VIRTIO_BALLOON_PAGES_PER_PAGE);
>> +
>> +    return -ALIGN(-diff, VIRTIO_BALLOON_PAGES_PER_PAGE);
>> +}
>> +
>>   static inline s64 towards_target(struct virtio_balloon *vb)
>>   {
>>       s64 target;
>> @@ -396,7 +407,7 @@ static inline s64 towards_target(struct virtio_balloon *vb)
>>               &num_pages);
>>       target = num_pages;
>> -    return target - vb->num_pages;
> 
> We know that vb->num_pages is always multiples of VIRTIO_BALLOON_PAGES_PER_PAGE.
> 
> Why not simply align target down?
> 
> target = ALIGN(num_pages, VIRTIO_BALLOON_PAGES_PER_PAGE);
> return target - vb->num_pages;
> 

Good point. Thanks a lot, David. The code will be changed to what's suggested in
v2, to be posted soon. I will also add a comment to explain it a bit. Besides, ALIGN()
is align-up instead of align-down to give bias to deflation intentionally, to avoid
overrunning the machine's memory size if it's not aligned to 64KB. Further more,
the align-up causes deflation even user requests a 4KB diff. However, the outcome
of ALIGN_DOWN(4KB, 64KB) is zero and no deflation will be triggered.

Thanks,
Gavin

