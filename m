Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A85A7CF415
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345094AbjJSJaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjJSJaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:30:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAA8119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697707772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mx3Pdx/5UxTV/mUBo8ksE0Th8GY1fEKYUtualo3AWr0=;
        b=SOOnoIKFAJsyS5gIH/CZOZD5elRC/AYVkHkt+28Gkeehz6FhiJXm2xwhGxcZECGb1vSxyE
        DdmJ9kSetbGs6oVCyYv1DsndSAF1xK33RG9uusNzKyWPCIrxk2Ld7U4YqUfHE4K9m5C4ls
        2BYJJyO9HyX1oEnN3IobhvqBJbtv3SM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-ki1ZbgNeOLyiPr7pUVJ84g-1; Thu, 19 Oct 2023 05:29:28 -0400
X-MC-Unique: ki1ZbgNeOLyiPr7pUVJ84g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a681c3470fso566709866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697707767; x=1698312567;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mx3Pdx/5UxTV/mUBo8ksE0Th8GY1fEKYUtualo3AWr0=;
        b=M9r6lEBM64bybF8uZRE+DDs5W0CnpixQtZ+PXAM5jBik/jo2vJQrpx2EGcm9uDEUzm
         1YtFTdvM4AMhD79yCKVKzIg2XPp+Z1oGU6QEVn6t9UKLh99FeNYi5REtVLLJA05oOdxC
         NFJxkyoe/YoMVV9chhrrIZiX2fD1qahf+z/4XHNmd1jYRyq7RrbMKpCXQx9tOlVNXZp9
         XFIPz+teZqekKaCbdl1cVo+rMOXJHuZJwQKyYVSCzLuudhIvr7E9QUFLYq7hISQ2fmeY
         hIu8OX83F/u2h3hmBAyUmg70NaIFEAndv0CWNXpM+vAeJ9feZaSMyvG1jVu3Wfi827hH
         xn4w==
X-Gm-Message-State: AOJu0Yy1cEt2amXpoFP59TlikNLIVfBtYpPFrJfUljI6KmG569gQs5yA
        HKXbpn1D/M1ul4C5kwu+CwFsLHaIp4qNRBXFa638OdCac+C8l+7hQhFEKZ1hEiVdPvWjVwflloQ
        8quWF+Gqb3qsJIIp3htZ0wnL8LPe2P/EA
X-Received: by 2002:a17:906:fe45:b0:9b2:ba73:65c9 with SMTP id wz5-20020a170906fe4500b009b2ba7365c9mr1152549ejb.51.1697707766764;
        Thu, 19 Oct 2023 02:29:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzy+4e2qL/a0tcDC4Rk0nRYhr0TQQFYprqC2F+Xh8rwsGxecveMhL7mCqTov1hFoMvwsjj0Q==
X-Received: by 2002:a17:906:fe45:b0:9b2:ba73:65c9 with SMTP id wz5-20020a170906fe4500b009b2ba7365c9mr1152537ejb.51.1697707766395;
        Thu, 19 Oct 2023 02:29:26 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it. [87.12.185.56])
        by smtp.gmail.com with ESMTPSA id c8-20020a17090603c800b0098ec690e6d7sm3193334eja.73.2023.10.19.02.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 02:29:25 -0700 (PDT)
Date:   Thu, 19 Oct 2023 11:29:18 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 PATCH] vdpa_sim: implement .reset_map support
Message-ID: <tqjrjw64l7pqphaagskys4zmkknkv46w7fxojic75b5dwbtq7m@dgq3xgryqz6f>
References: <1697605893-30313-1-git-send-email-si-wei.liu@oracle.com>
 <becui44lhdptriz4ds7r2b22kazofwo7i44rydacjssnwb7mrq@f6sa74zjhlfp>
 <171a1147-2099-46da-81f1-fc953e9410e2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171a1147-2099-46da-81f1-fc953e9410e2@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 04:47:48PM -0700, Si-Wei Liu wrote:
>
>
>On 10/18/2023 1:05 AM, Stefano Garzarella wrote:
>>On Tue, Oct 17, 2023 at 10:11:33PM -0700, Si-Wei Liu wrote:
>>>RFC only. Not tested on vdpa-sim-blk with user virtual address.
>>>Works fine with vdpa-sim-net which uses physical address to map.
>>>
>>>This patch is based on top of [1].
>>>
>>>[1] https://lore.kernel.org/virtualization/1696928580-7520-1-git-send-email-si-wei.liu@oracle.com/
>>>
>>>Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>
>>>---
>>>RFC v2:
>>> - initialize iotlb to passthrough mode in device add
>>
>>I tested this version and I didn't see any issue ;-)
>Great, thank you so much for your help on testing my patch, Stefano!

You're welcome :-)

>Just for my own interest/curiosity, currently there's no vhost-vdpa 
>backend client implemented for vdpa-sim-blk

Yep, we developed libblkio [1]. libblkio exposes common API to access 
block devices in userspace. It supports several drivers.
The one useful for this use case is `virtio-blk-vhost-vdpa`. Here [2] 
some examples on how to use the libblkio test suite with the 
vdpa-sim-blk.

Since QEMU 7.2, it supports libblkio drivers, so you can use the 
following options to attach a vdpa-blk device to a VM:

   -blockdev node-name=drive_src1,driver=virtio-blk-vhost-vdpa,path=/dev/vhost-vdpa-0,cache.direct=on \
   -device virtio-blk-pci,id=src1,bootindex=2,drive=drive_src1 \

For now only what we called slow-path [3][4] is supported, since the VQs 
are not directly exposed to the guest, but QEMU allocates other VQs 
(similar to shadow VQs for net) to support live-migration and QEMU 
storage features. Fast-path is on the agenda, but on pause for now.

>or any vdpa block device in userspace as yet, correct? 

Do you mean with VDUSE?
In this case, yes, qemu-storage-daemon supports it, and can implement a 
virtio-blk in user space, exposing a disk image thorough VDUSE.

There is an example in libblkio as well [5] on how to start it.

>So there was no test specific to vhost-vdpa that needs to be exercised, 
>right?
>

I hope I answered above :-)
This reminded me that I need to write a blog post with all this 
information, I hope to do that soon!

Stefano

[1] https://gitlab.com/libblkio/libblkio
[2] https://gitlab.com/libblkio/libblkio/-/blob/main/tests/meson.build?ref_type=heads#L42
[3] https://kvmforum2022.sched.com/event/15jK5/qemu-storage-daemon-and-libblkio-exploring-new-shores-for-the-qemu-block-layer-kevin-wolf-stefano-garzarella-red-hat
[4] https://kvmforum2021.sched.com/event/ke3a/vdpa-blk-unified-hardware-and-software-offload-for-virtio-blk-stefano-garzarella-red-hat
[5] https://gitlab.com/libblkio/libblkio/-/blob/main/tests/meson.build?ref_type=heads#L58

