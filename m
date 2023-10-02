Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3107B51B8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbjJBLvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236697AbjJBLvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F05D3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696247449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mBrZhcB5nUcd1tpUxuWzIbaWMcBLbzzhsFdEDldJgN4=;
        b=Tb9SYzHe+NHJHYh9TtD03Btq4bNofLiJFctQX5GDs4IDqZZCOW/6PdRVmw88lgbyDbtFAo
        D+l3z/YY31Tj903h+7ZW7E2FOkeLTXXVRFkF0fSLoVbQdxD2HKavWGyiY0t/qH81QyP7Cw
        MpGFTtc+izxglBf77Pl0kmPlGIGBRno=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-5XFTyXsrM1Go9XXjYUe0Wg-1; Mon, 02 Oct 2023 07:50:48 -0400
X-MC-Unique: 5XFTyXsrM1Go9XXjYUe0Wg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32323283257so9306267f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 04:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696247447; x=1696852247;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBrZhcB5nUcd1tpUxuWzIbaWMcBLbzzhsFdEDldJgN4=;
        b=iRfmv6r62WdG1yb5jCwRcxU3cVcI7tiwTE9yKkjkDeWHFdG03UKsDeXb71n4AxaH6B
         /ODVkvLddlO3iJGaKsvsZEqQqiQb0p7kvgqseSS07+dg3aeLltb9BJy6Z4+4tB7glafz
         djPUGj1MWmqVOMORGM1lyeJ2hC8rN/40JpNHzA8iAuMCrMPDEblVTKSLvmSQiaaHAfC1
         Isa8dR8CBioM0XWKaOrL/3BDqpEXSB7KRCIMxvnv3J67wT5s8PnM3rWkH3AqYG574f5Q
         l66tgFkBwYUAhXCFLOiy2ITL2f96sfoZ0Hu36TibtC40+d4rNnZlfIZs6/UhJnIuvw1q
         jPRg==
X-Gm-Message-State: AOJu0YzHHWztYZqGAbxw7yKVSvyRlFaS9Pyzd3ev2m4kUspBeaD4m4gT
        MoTF3Hy6xL1MoVagZywP9GhruUnEOLtn2vCbIpD85MRXSYizCLmQCoEOefmmATVl7KgVqzTwIsR
        77C863mtyweDAfrvoZvgVTKT4PCYKtlJW
X-Received: by 2002:adf:e9c9:0:b0:319:79bb:980c with SMTP id l9-20020adfe9c9000000b0031979bb980cmr9786483wrn.64.1696247447635;
        Mon, 02 Oct 2023 04:50:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLNQHhxBlGvd3QBrupxsNSkpIsO/mIp/g907haHFJ/D8eLi4qV+cMl4rqxJw7Q8mpvESCurw==
X-Received: by 2002:adf:e9c9:0:b0:319:79bb:980c with SMTP id l9-20020adfe9c9000000b0031979bb980cmr9786464wrn.64.1696247447165;
        Mon, 02 Oct 2023 04:50:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:f200:cb49:cb8f:88fc:9446? (p200300cbc735f200cb49cb8f88fc9446.dip0.t-ipconnect.de. [2003:cb:c735:f200:cb49:cb8f:88fc:9446])
        by smtp.gmail.com with ESMTPSA id x13-20020adff64d000000b00325b29a6441sm7465254wrp.82.2023.10.02.04.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 04:50:46 -0700 (PDT)
Message-ID: <53ec0cfb-37c8-f8e3-4cd3-53a390b2cd2b@redhat.com>
Date:   Mon, 2 Oct 2023 13:50:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] virtio_balloon: Fix endless deflation and inflation on
 arm64
Content-Language: en-US
To:     Gavin Shan <gshan@redhat.com>,
        virtualization@lists.linux-foundation.org, mst@redhat.com
Cc:     xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
        zhenyzha@redhat.com, shan.gavin@gmail.com
References: <20230831011007.1032822-1-gshan@redhat.com>
 <9efb4685-7c28-d51d-fd5b-aa2de8e5ded2@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <9efb4685-7c28-d51d-fd5b-aa2de8e5ded2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.09.23 01:58, Gavin Shan wrote:
> Hi David and Michael,
> 
> On 8/31/23 11:10, Gavin Shan wrote:
>> The deflation request to the target, which isn't unaligned to the
>> guest page size causes endless deflation and inflation actions. For
>> example, we receive the flooding QMP events for the changes on memory
>> balloon's size after a deflation request to the unaligned target is
>> sent for the ARM64 guest, where we have 64KB base page size.
>>
>>     /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
>>     -accel kvm -machine virt,gic-version=host -cpu host          \
>>     -smp maxcpus=8,cpus=8,sockets=2,clusters=2,cores=2,threads=1 \
>>     -m 1024M,slots=16,maxmem=64G                                 \
>>     -object memory-backend-ram,id=mem0,size=512M                 \
>>     -object memory-backend-ram,id=mem1,size=512M                 \
>>     -numa node,nodeid=0,memdev=mem0,cpus=0-3                     \
>>     -numa node,nodeid=1,memdev=mem1,cpus=4-7                     \
>>       :                                                          \
>>     -device virtio-balloon-pci,id=balloon0,bus=pcie.10
>>
>>     { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
>>     {"return": {}}
>>     {"timestamp": {"seconds": 1693272173, "microseconds": 88667},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>     {"timestamp": {"seconds": 1693272174, "microseconds": 89704},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>     {"timestamp": {"seconds": 1693272175, "microseconds": 90819},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>     {"timestamp": {"seconds": 1693272176, "microseconds": 91961},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>     {"timestamp": {"seconds": 1693272177, "microseconds": 93040},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>>     {"timestamp": {"seconds": 1693272178, "microseconds": 94117},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>>     {"timestamp": {"seconds": 1693272179, "microseconds": 95337},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>     {"timestamp": {"seconds": 1693272180, "microseconds": 96615},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>>     {"timestamp": {"seconds": 1693272181, "microseconds": 97626},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>     {"timestamp": {"seconds": 1693272182, "microseconds": 98693},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>>     {"timestamp": {"seconds": 1693272183, "microseconds": 99698},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>     {"timestamp": {"seconds": 1693272184, "microseconds": 100727},  \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>     {"timestamp": {"seconds": 1693272185, "microseconds": 90430},   \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>     {"timestamp": {"seconds": 1693272186, "microseconds": 102999},  \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>>        :
>>     <The similar QMP events repeat>
>>
>> Fix it by aligning the target up to the guest page size, 64KB in this
>> specific case. With this applied, no flooding QMP events are observed
>> and the memory balloon's size can be stablizied to 0x3ffe0000 soon
>> after the deflation request is sent.
>>
>>     { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
>>     {"return": {}}
>>     {"timestamp": {"seconds": 1693273328, "microseconds": 793075},  \
>>      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>>     { "execute" : "query-balloon" }
>>     {"return": {"actual": 1073610752}}
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>
>> ---
>> v2: Align @num_pages up to the guest page size in towards_target()
>>       directly as David suggested.
>> ---
>>    drivers/virtio/virtio_balloon.c | 6 +++++-
>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>
> 
> If the patch looks good, could you please merge this to Linux 6.6.rc4 since
> it's something needed by our downstream. I hope it can land upstream as early
> as possible, thanks a lot.

@MST, I cannot spot it in your usual vhost git yet. Should I pick it up 
or what are your plans?

-- 
Cheers,

David / dhildenb

