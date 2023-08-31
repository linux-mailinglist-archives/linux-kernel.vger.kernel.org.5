Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287EF78E7AF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244611AbjHaIMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjHaIMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:12:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D718E49
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693469452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z566ZZFlUEIUNPV4JZS2b3O9kCxmD4O/UFGD6TWNjL0=;
        b=Uk2ngrnZVWx6E2jM/+DC8skGxdMRqeBqd5nkcy0PqpRFs0ZjjgWeluLtERLq/g+i/oVjou
        sg049DGlrs89yZcOIA+2595DG6cL4mJ/Pb19xcINfJawm0SbLkKNk5gxQ4How5W6b9TlD0
        eGg0Jo4OJbfgwUVdUOzrZJ/j79baPMw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-wPWU-RNwMmadDfOJIqi3Mg-1; Thu, 31 Aug 2023 04:10:50 -0400
X-MC-Unique: wPWU-RNwMmadDfOJIqi3Mg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2bcc1e0dfe5so7643181fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693469449; x=1694074249;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z566ZZFlUEIUNPV4JZS2b3O9kCxmD4O/UFGD6TWNjL0=;
        b=BbHoavxY76791ekNqAyZduWycwK8UqZew1d1DzsQFc0Ty/YKtgPxJKLvZzNffc/6P9
         fJ3VRd89xzrwlT0mnw3uSGcPSnLLxQuqNh0nyx3dMNHhfIQAb3ZdujCsXhRlNVY1v+D2
         YG4vK4hfPtNiCKrLOEYTphneN2W/sIvPJmOBBfu3sbj4DZs1l0REhrUEV83JCL73WsA/
         ohvxY1LPKo7XMCAjMujmXqgO1LGaCZ/SoUmK6WsB/fM934m0q3nzSuOaTrGpRJVU8/Kn
         EKEYTNiMdj4eBMQUtMPFVGyDtYHg0hbv/EKyMs50RsGP8wBI/sXsLQnCbvjzixsGMc98
         BaVA==
X-Gm-Message-State: AOJu0Yz4gbj36qtzM7FA/6Y+gx7fvjPgCFmCOJxImaqKv2f0eqQn6XW4
        yLRq+Nnr2wsA8gE3TojcOfjHnPdrZRhh/Yls/zlabFbGNXvgLSjjQC4TCfgYRoNh5K9WZixIrLL
        3PMnmJTPbHRSWOqZdUZCqNI5c
X-Received: by 2002:a2e:9397:0:b0:2bc:e1a3:fbaa with SMTP id g23-20020a2e9397000000b002bce1a3fbaamr3873703ljh.22.1693469449481;
        Thu, 31 Aug 2023 01:10:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0fmltGXq6qnXi49mnyirGvJlhacFpekfh2qsAEaM19VNcfoz1PP7C20+IbtMCtQkR2mQbqQ==
X-Received: by 2002:a2e:9397:0:b0:2bc:e1a3:fbaa with SMTP id g23-20020a2e9397000000b002bce1a3fbaamr3873688ljh.22.1693469449110;
        Thu, 31 Aug 2023 01:10:49 -0700 (PDT)
Received: from [10.59.19.200] (pd956a06e.dip0.t-ipconnect.de. [217.86.160.110])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c299300b003fe539b83f2sm4318770wmd.42.2023.08.31.01.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 01:10:48 -0700 (PDT)
Message-ID: <688b18aa-f648-7973-5dda-cc1afdc2c5f5@redhat.com>
Date:   Thu, 31 Aug 2023 10:10:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] virtio_balloon: Fix endless deflation and inflation on
 arm64
Content-Language: en-US
To:     Gavin Shan <gshan@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, zhenyzha@redhat.com,
        shan.gavin@gmail.com
References: <20230831011007.1032822-1-gshan@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230831011007.1032822-1-gshan@redhat.com>
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

On 31.08.23 03:10, Gavin Shan wrote:
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

Thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

