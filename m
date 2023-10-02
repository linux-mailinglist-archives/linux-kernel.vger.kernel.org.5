Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13E87B5D25
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 00:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjJBWbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 18:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjJBWa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 18:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3EA91
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 15:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696285809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wbn3fa8P8IewLiEX3rTDe+XOocXVePLBhJKPnZQf5kQ=;
        b=SIEOssgfUKW7Ijyo5dpVHhpExnCQEtQTkajeKd3ar/Jyn37qTRTCYUAm5nJEP7o66eR7/n
        N+0SSvOajgDtcLDSR/J1KiMeCMwfPvktAMBr4eBo+evhYUvudLyeMCexYKvzBxwnYsW0gN
        yw+NkoSke8pexQ/ee4anwExyTtfjdAo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-8kDE0oerPzerfPd-qeAqYQ-1; Mon, 02 Oct 2023 18:30:08 -0400
X-MC-Unique: 8kDE0oerPzerfPd-qeAqYQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40566c578b7so2302455e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 15:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696285807; x=1696890607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbn3fa8P8IewLiEX3rTDe+XOocXVePLBhJKPnZQf5kQ=;
        b=ekTp3jGclDoMkF8CjFtB+hr+fFEWvkxsZ5T8JMqneMhWtJwqdOWBXb1o/KrP7RofVR
         TX4NrqTnEiDCx7di/gwtu+4JQcQ++Or8KyKC8z74+QPpnwf2R653UZurI+OHG0IexJnz
         1ymxXjGeO+77dogmtMZfDuYzAHw+kgaOjzYbl7HY7aeM+H7ekScAZE0c513FdiJ1645b
         LqI4Rx6WdMm+ELozsQDGOsoknupDr9rXA17zIBJnKxPo6V699MdpH1mMeCS+G9diEgNV
         rHe1u9AXk1UhLAxRej1oVfTWq37wIVUH+hVAeYhRo+WKIO3SSswvYeFuW9sCffRJpKAe
         vmkA==
X-Gm-Message-State: AOJu0Yw2sMwtCd3GXjogRscmbrGxFI20NuxIXVDzLh+0SD4qNzxK4m8J
        B4glg9HMmNpfC51zBFJLqmqef+gzczwMkH8ympii3J3xpqmO6rGoxFeW8h8AIBt7SFGXO6mBpYJ
        HSI0OiAwp6LunsDTeEgXTwz7H
X-Received: by 2002:a05:600c:4750:b0:406:54e4:359c with SMTP id w16-20020a05600c475000b0040654e4359cmr12641734wmo.19.1696285806949;
        Mon, 02 Oct 2023 15:30:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuaDhgwpzMP426f7VT7kXKb83tbiFTeg7u1xIljSoODijtyJKX8UEdZEjc/1qbOO4XnQAdUw==
X-Received: by 2002:a05:600c:4750:b0:406:54e4:359c with SMTP id w16-20020a05600c475000b0040654e4359cmr12641718wmo.19.1696285806567;
        Mon, 02 Oct 2023 15:30:06 -0700 (PDT)
Received: from redhat.com ([2.52.132.27])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600c11cd00b00405c33a9a12sm117791wmi.0.2023.10.02.15.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 15:30:05 -0700 (PDT)
Date:   Mon, 2 Oct 2023 18:30:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Gavin Shan <gshan@redhat.com>,
        virtualization@lists.linux-foundation.org,
        xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
        zhenyzha@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v2] virtio_balloon: Fix endless deflation and inflation
 on arm64
Message-ID: <20231002182904-mutt-send-email-mst@kernel.org>
References: <20230831011007.1032822-1-gshan@redhat.com>
 <9efb4685-7c28-d51d-fd5b-aa2de8e5ded2@redhat.com>
 <53ec0cfb-37c8-f8e3-4cd3-53a390b2cd2b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53ec0cfb-37c8-f8e3-4cd3-53a390b2cd2b@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 01:50:45PM +0200, David Hildenbrand wrote:
> On 25.09.23 01:58, Gavin Shan wrote:
> > Hi David and Michael,
> > 
> > On 8/31/23 11:10, Gavin Shan wrote:
> > > The deflation request to the target, which isn't unaligned to the
> > > guest page size causes endless deflation and inflation actions. For
> > > example, we receive the flooding QMP events for the changes on memory
> > > balloon's size after a deflation request to the unaligned target is
> > > sent for the ARM64 guest, where we have 64KB base page size.
> > > 
> > >     /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
> > >     -accel kvm -machine virt,gic-version=host -cpu host          \
> > >     -smp maxcpus=8,cpus=8,sockets=2,clusters=2,cores=2,threads=1 \
> > >     -m 1024M,slots=16,maxmem=64G                                 \
> > >     -object memory-backend-ram,id=mem0,size=512M                 \
> > >     -object memory-backend-ram,id=mem1,size=512M                 \
> > >     -numa node,nodeid=0,memdev=mem0,cpus=0-3                     \
> > >     -numa node,nodeid=1,memdev=mem1,cpus=4-7                     \
> > >       :                                                          \
> > >     -device virtio-balloon-pci,id=balloon0,bus=pcie.10
> > > 
> > >     { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
> > >     {"return": {}}
> > >     {"timestamp": {"seconds": 1693272173, "microseconds": 88667},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> > >     {"timestamp": {"seconds": 1693272174, "microseconds": 89704},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> > >     {"timestamp": {"seconds": 1693272175, "microseconds": 90819},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> > >     {"timestamp": {"seconds": 1693272176, "microseconds": 91961},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> > >     {"timestamp": {"seconds": 1693272177, "microseconds": 93040},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
> > >     {"timestamp": {"seconds": 1693272178, "microseconds": 94117},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
> > >     {"timestamp": {"seconds": 1693272179, "microseconds": 95337},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> > >     {"timestamp": {"seconds": 1693272180, "microseconds": 96615},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
> > >     {"timestamp": {"seconds": 1693272181, "microseconds": 97626},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> > >     {"timestamp": {"seconds": 1693272182, "microseconds": 98693},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
> > >     {"timestamp": {"seconds": 1693272183, "microseconds": 99698},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> > >     {"timestamp": {"seconds": 1693272184, "microseconds": 100727},  \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> > >     {"timestamp": {"seconds": 1693272185, "microseconds": 90430},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> > >     {"timestamp": {"seconds": 1693272186, "microseconds": 102999},  \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
> > >        :
> > >     <The similar QMP events repeat>
> > > 
> > > Fix it by aligning the target up to the guest page size, 64KB in this
> > > specific case. With this applied, no flooding QMP events are observed
> > > and the memory balloon's size can be stablizied to 0x3ffe0000 soon
> > > after the deflation request is sent.
> > > 
> > >     { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
> > >     {"return": {}}
> > >     {"timestamp": {"seconds": 1693273328, "microseconds": 793075},  \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> > >     { "execute" : "query-balloon" }
> > >     {"return": {"actual": 1073610752}}
> > > 
> > > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > > Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>
> > > ---
> > > v2: Align @num_pages up to the guest page size in towards_target()
> > >       directly as David suggested.
> > > ---
> > >    drivers/virtio/virtio_balloon.c | 6 +++++-
> > >    1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > 
> > If the patch looks good, could you please merge this to Linux 6.6.rc4 since
> > it's something needed by our downstream. I hope it can land upstream as early
> > as possible, thanks a lot.
> 
> @MST, I cannot spot it in your usual vhost git yet. Should I pick it up or
> what are your plans?

Yes - I merged it but I'm still testing my tree. Will be in
the next pull request.

