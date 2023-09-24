Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093BC7ACCFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 01:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjIXX7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 19:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjIXX7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 19:59:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56463E8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 16:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695599925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ets5PYkEN00cN7wgOm2RwQsLcoaUgwsPfQGHKYG1F6g=;
        b=N0VUEXtr0AZhVLjjPVU4v94tWsDLMCxSn9xIIhBXdJ7/NqmCwlWsmj2YTXiRhlyEEnAkHu
        AmvcR2WlJvH0Em3LdVZ7ZCXk6g9AII+NSce2r+WpQUiFGCQpI5BkOEWSjYuvkGsak32Puy
        3pZ12SpE5wA6aAKMTMDveczR0tsm4LA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-wLJ9tVN7O06TolqwfWoeIA-1; Sun, 24 Sep 2023 19:58:43 -0400
X-MC-Unique: wLJ9tVN7O06TolqwfWoeIA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2748327f37dso3715990a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 16:58:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695599922; x=1696204722;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ets5PYkEN00cN7wgOm2RwQsLcoaUgwsPfQGHKYG1F6g=;
        b=Np5SkTWBKkeVUvBbD/UQI+tEK2zrdg/q/r/+JWt89hXLT+6VgDTn2zU4oVhuzIyxXj
         yQiiV0Au5Tur7U/DtOPEOT3th4SScFQSgc2tRi/TZRqK7Xhsch7ldXtBuRlKSaYBdiFG
         8Xt+2G/rWeOTa85nS/QRbmZS/EWH2pn7cnuIFfZ0HiuRkLaP+fxsbUApAvRUoPsVC/Zx
         sXJYM/gyonoFUQEBg83C8f/dv/ccOCkJ1drc6x4+d35/ULLE984Jbe0sEUAGxDRd/I4V
         34p1+Ykh5rhLgeWjp3sBthhUcv+P9GAor7LSSmf0xL5RBBrpj4Kgke3cfh4Pz14kThhI
         CQhw==
X-Gm-Message-State: AOJu0YzshuflS5wbQSw1fBTNmxQS6a0a99RimlKSYjaflZlFn5tnuHI7
        z0gUzftQAsofA2MBBkp9fkPcDWfyekokG6pSux8vMHbcsuJQ/nsTD8hZirYCp4ULB/r1iZVU1nf
        XTAv4p2QHRybMWG8COnxUKIRyMK6MzJyA
X-Received: by 2002:a17:90a:2ca1:b0:26d:ae3:f6a6 with SMTP id n30-20020a17090a2ca100b0026d0ae3f6a6mr2819269pjd.18.1695599922199;
        Sun, 24 Sep 2023 16:58:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDUhf4oGjVLqD6nDiU8Yq56LBZmA3ph1fj5hxXW40AUTIUnA8R3a4yi1/uEa5ZPgJxtHjHow==
X-Received: by 2002:a17:90a:2ca1:b0:26d:ae3:f6a6 with SMTP id n30-20020a17090a2ca100b0026d0ae3f6a6mr2819265pjd.18.1695599921841;
        Sun, 24 Sep 2023 16:58:41 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090a16c900b002772faee740sm1216900pje.5.2023.09.24.16.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 16:58:40 -0700 (PDT)
Message-ID: <9efb4685-7c28-d51d-fd5b-aa2de8e5ded2@redhat.com>
Date:   Mon, 25 Sep 2023 09:58:35 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] virtio_balloon: Fix endless deflation and inflation on
 arm64
Content-Language: en-US
From:   Gavin Shan <gshan@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     xuanzhuo@linux.alibaba.com, mst@redhat.com,
        linux-kernel@vger.kernel.org, zhenyzha@redhat.com,
        shan.gavin@gmail.com, David Hildenbrand <david@redhat.com>
References: <20230831011007.1032822-1-gshan@redhat.com>
In-Reply-To: <20230831011007.1032822-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David and Michael,

On 8/31/23 11:10, Gavin Shan wrote:
> The deflation request to the target, which isn't unaligned to the
> guest page size causes endless deflation and inflation actions. For
> example, we receive the flooding QMP events for the changes on memory
> balloon's size after a deflation request to the unaligned target is
> sent for the ARM64 guest, where we have 64KB base page size.
> 
>    /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
>    -accel kvm -machine virt,gic-version=host -cpu host          \
>    -smp maxcpus=8,cpus=8,sockets=2,clusters=2,cores=2,threads=1 \
>    -m 1024M,slots=16,maxmem=64G                                 \
>    -object memory-backend-ram,id=mem0,size=512M                 \
>    -object memory-backend-ram,id=mem1,size=512M                 \
>    -numa node,nodeid=0,memdev=mem0,cpus=0-3                     \
>    -numa node,nodeid=1,memdev=mem1,cpus=4-7                     \
>      :                                                          \
>    -device virtio-balloon-pci,id=balloon0,bus=pcie.10
> 
>    { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
>    {"return": {}}
>    {"timestamp": {"seconds": 1693272173, "microseconds": 88667},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    {"timestamp": {"seconds": 1693272174, "microseconds": 89704},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    {"timestamp": {"seconds": 1693272175, "microseconds": 90819},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    {"timestamp": {"seconds": 1693272176, "microseconds": 91961},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    {"timestamp": {"seconds": 1693272177, "microseconds": 93040},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>    {"timestamp": {"seconds": 1693272178, "microseconds": 94117},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>    {"timestamp": {"seconds": 1693272179, "microseconds": 95337},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    {"timestamp": {"seconds": 1693272180, "microseconds": 96615},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>    {"timestamp": {"seconds": 1693272181, "microseconds": 97626},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    {"timestamp": {"seconds": 1693272182, "microseconds": 98693},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>    {"timestamp": {"seconds": 1693272183, "microseconds": 99698},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    {"timestamp": {"seconds": 1693272184, "microseconds": 100727},  \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    {"timestamp": {"seconds": 1693272185, "microseconds": 90430},   \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    {"timestamp": {"seconds": 1693272186, "microseconds": 102999},  \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
>       :
>    <The similar QMP events repeat>
> 
> Fix it by aligning the target up to the guest page size, 64KB in this
> specific case. With this applied, no flooding QMP events are observed
> and the memory balloon's size can be stablizied to 0x3ffe0000 soon
> after the deflation request is sent.
> 
>    { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
>    {"return": {}}
>    {"timestamp": {"seconds": 1693273328, "microseconds": 793075},  \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    { "execute" : "query-balloon" }
>    {"return": {"actual": 1073610752}}
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>
> ---
> v2: Align @num_pages up to the guest page size in towards_target()
>      directly as David suggested.
> ---
>   drivers/virtio/virtio_balloon.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 

If the patch looks good, could you please merge this to Linux 6.6.rc4 since
it's something needed by our downstream. I hope it can land upstream as early
as possible, thanks a lot.

> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 5b15936a5214..2d5d252ef419 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -395,7 +395,11 @@ static inline s64 towards_target(struct virtio_balloon *vb)
>   	virtio_cread_le(vb->vdev, struct virtio_balloon_config, num_pages,
>   			&num_pages);
>   
> -	target = num_pages;
> +	/*
> +	 * Aligned up to guest page size to avoid inflating and deflating
> +	 * balloon endlessly.
> +	 */
> +	target = ALIGN(num_pages, VIRTIO_BALLOON_PAGES_PER_PAGE);
>   	return target - vb->num_pages;
>   }
>   

Thanks,
Gavin

