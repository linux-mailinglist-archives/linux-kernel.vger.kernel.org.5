Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CED78DE31
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjH3S7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343647AbjH3QbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:31:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B448D107
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693413031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aFrAeIckcxwdM3BGhgwY2df5vNbcEm/5Om84XOIOQVA=;
        b=iK7Zgf5Mz4uWuBMecbkL36Ivz1lK1rOmSV01hCiqRJdyMBNuMgAoUMhwX1pIuozEVbAnD7
        zREkdzexEukpCGzBzQDIwKh/i+8IY9H8CcnrLQyKdFzw6SJ3+noOLoY7cbU2zr8yj1JEBX
        /7M5EetXlQw2+2kMmiudWkQyUqApExo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-qqolbJ30Mw6xBe-koD_wGw-1; Wed, 30 Aug 2023 12:30:29 -0400
X-MC-Unique: qqolbJ30Mw6xBe-koD_wGw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31c5c55fd70so474471f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693413028; x=1694017828;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFrAeIckcxwdM3BGhgwY2df5vNbcEm/5Om84XOIOQVA=;
        b=LapNM8o7GbO55IEIZH9RBBdbiJ5mzW4gvuESBPhWqyHlKjp8PMyl0/FGQRE9W8gKqN
         KslUk/jDKVVD7RT4gXlPMO36pZNbcmifS4wK7jatd12cNwqD0vDo1v4Q3afUgx8lWXZc
         i0Mj86k0hhmJjlsJ+jkw4vgqU+lKQxbgHgSfQ+X2envZe09ck8JD8wftFtgTvI3vh9ed
         X4bhs+2sp7q0KVtpKmb0shIiswyl/od4UIw3LSQsAMzq04vZdyE0aSSQkEalLXif1wmN
         mkMKPxeXiYHEsMANMpMsqmpVVNmB7VBKh8m4Dr5RDdrAWW4+ELmJ140dnUJeCTf31C2R
         ap1Q==
X-Gm-Message-State: AOJu0YwrOfoFSfMS6wluSJGXv4W3fcHftOGyhYejgvL7BD44rq3eq7F9
        FAK2Os1igMaUUi9nzIp33YypOsigB+imq9JloMYYV3ievFmBqu+DoDtMCq/Tnzah4Ut4zIn37hz
        UR58gzd6yoeQDNz382fnzOXP0
X-Received: by 2002:a5d:4a8d:0:b0:30e:56b3:60fe with SMTP id o13-20020a5d4a8d000000b0030e56b360femr131950wrq.4.1693413028098;
        Wed, 30 Aug 2023 09:30:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXOzXnjzkCatETTts+G6EKS/KJiIlbcSxMP9jMzfgkBY6L4zKkYcXK5LkfkYMzCGwc/dBzyQ==
X-Received: by 2002:a5d:4a8d:0:b0:30e:56b3:60fe with SMTP id o13-20020a5d4a8d000000b0030e56b360femr131931wrq.4.1693413027716;
        Wed, 30 Aug 2023 09:30:27 -0700 (PDT)
Received: from [10.59.19.200] (pd956a06e.dip0.t-ipconnect.de. [217.86.160.110])
        by smtp.gmail.com with ESMTPSA id w12-20020a5d4b4c000000b0031416362e23sm17169032wrs.3.2023.08.30.09.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 09:30:27 -0700 (PDT)
Message-ID: <d2bf8d72-8d41-e26f-2dc7-d45973fe2164@redhat.com>
Date:   Wed, 30 Aug 2023 18:30:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] virtio_balloon: Fix endless deflation and inflation on
 arm64
Content-Language: en-US
To:     Gavin Shan <gshan@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com, mst@redhat.com,
        xuanzhuo@linux.alibaba.com, shan.gavin@gmail.com
References: <20230829015421.920511-1-gshan@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
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

On 29.08.23 03:54, Gavin Shan wrote:
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

We know that vb->num_pages is always multiples of 
VIRTIO_BALLOON_PAGES_PER_PAGE.

Why not simply align target down?

target = ALIGN(num_pages, VIRTIO_BALLOON_PAGES_PER_PAGE);
return target - vb->num_pages;


-- 
Cheers,

David / dhildenb

