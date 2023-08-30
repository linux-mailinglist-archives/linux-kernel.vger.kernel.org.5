Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0836178D2BA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 06:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241915AbjH3EZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 00:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239282AbjH3EZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 00:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563891A3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 21:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693369477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kj1j2W7Rncwakl8+uaZCa8ACzieIXsTkub/0MwTanec=;
        b=gq8AeV2W8TiDhQZBVZm1bQE71uiIDvVXV2qrWcyHI859CvyCrIhc6y9E4QjuwAKt2soNF4
        23hsjeXZVL3gTCJ6Cj+P1d32EvD5KVK1i/2szovfrBQft/OhfHjs4qFvACxfsPW0qVVe12
        o7Y6V/kuoDNtl6Ig3x3G6SfPSi3Qba4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-7uK2zf7zNL6inuxhMC4zMg-1; Wed, 30 Aug 2023 00:24:34 -0400
X-MC-Unique: 7uK2zf7zNL6inuxhMC4zMg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1c0a90de7a2so63714445ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 21:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693369473; x=1693974273;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kj1j2W7Rncwakl8+uaZCa8ACzieIXsTkub/0MwTanec=;
        b=hI6G27LIvlbIbiBv1MwlgkUzHc9U1UY+70SEusJIM8jR3SE6YTJHLVpUzXxM51LsOd
         wmIMHtjAbQPZjlbsmvsd2BdB8wuqMPtT/s/KxU5Ow3kKaZQK6pKIUClVH/SxlPv0sSVj
         dgh0/71rut9g8phLwtG+atAf+Mu7OpFxRWh9SBP8vF6FHXKCGPfRHQ6seQDTib/Hjid4
         TnpFgGiTNy728zUM0ZopdUZkddC7KQTqUeHOK92WJxiETNiNGQgt11s3nS7mt9zGJ0lB
         lixx4++zBFC+YWa/TEgpYQB1BKm/0+2m1iEch7P6pv4oRp9/wP6n9fPBJRtzGTZrW3cI
         DTSA==
X-Gm-Message-State: AOJu0YwX6B+NrDU4H3rJjC7RTo8zxqMd0mfKk420z3YWZz0x79n5Gtvn
        2/cWaEpM/uQ23ULThNMpjZqZrQXail9CRL3fSqfyvEVhKU0tyDGc2jFwf/0ohbdqJZEAVOkROtR
        jE0mF791YCyoQglm9Z5xGgLrY
X-Received: by 2002:a17:902:8f8e:b0:1bc:16cf:fc30 with SMTP id z14-20020a1709028f8e00b001bc16cffc30mr960181plo.63.1693369473711;
        Tue, 29 Aug 2023 21:24:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4oZ5RU+i1Ya/foOIIWYjMTJ1600KCLxPq/800allU07bEPXQNtyHlYba2jpFLQGMrX6HJ4A==
X-Received: by 2002:a17:902:8f8e:b0:1bc:16cf:fc30 with SMTP id z14-20020a1709028f8e00b001bc16cffc30mr960173plo.63.1693369473421;
        Tue, 29 Aug 2023 21:24:33 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id jw15-20020a170903278f00b001bc6536051bsm10130790plb.184.2023.08.29.21.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 21:24:32 -0700 (PDT)
Message-ID: <55cb12bf-12e4-8da6-629c-5518f8abe85e@redhat.com>
Date:   Wed, 30 Aug 2023 14:24:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] virtio_balloon: Fix endless deflation and inflation on
 arm64
Content-Language: en-US
From:   Gavin Shan <gshan@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     xuanzhuo@linux.alibaba.com, mst@redhat.com,
        linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
        David Hildenbrand <david@redhat.com>, jasowang@redhat.com,
        Zhenyu Zhang <zhenyzha@redhat.com>
References: <20230829015421.920511-1-gshan@redhat.com>
In-Reply-To: <20230829015421.920511-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/23 11:54, Gavin Shan wrote:
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
> Fix it by having the target aligned to the guest page size, 64KB
> in this specific case. With this applied, no flooding QMP event
> is observed and the memory balloon's size can be stablizied to
> 0x3ffe0000 soon after the deflation request is sent.
> 
>    { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
>    {"return": {}}
>    {"timestamp": {"seconds": 1693273328, "microseconds": 793075},  \
>     "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
>    { "execute" : "query-balloon" }
>    {"return": {"actual": 1073610752}}
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   drivers/virtio/virtio_balloon.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 

It was supposed to copy David, Jason and Zhenyu. I don't know how they have been
missed. My script may run into problems temporarily. Amending for it.

Thanks,
Gavin

> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 5b15936a5214..625caac35264 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -386,6 +386,17 @@ static void stats_handle_request(struct virtio_balloon *vb)
>   	virtqueue_kick(vq);
>   }
>   
> +static inline s64 align_pages_up(s64 diff)
> +{
> +	if (diff == 0)
> +		return diff;
> +
> +	if (diff > 0)
> +		return ALIGN(diff, VIRTIO_BALLOON_PAGES_PER_PAGE);
> +
> +	return -ALIGN(-diff, VIRTIO_BALLOON_PAGES_PER_PAGE);
> +}
> +
>   static inline s64 towards_target(struct virtio_balloon *vb)
>   {
>   	s64 target;
> @@ -396,7 +407,7 @@ static inline s64 towards_target(struct virtio_balloon *vb)
>   			&num_pages);
>   
>   	target = num_pages;
> -	return target - vb->num_pages;
> +	return align_pages_up(target - vb->num_pages);
>   }
>   
>   /* Gives back @num_to_return blocks of free pages to mm. */

