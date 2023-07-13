Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B928752606
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjGMPEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjGMPEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:04:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3EA19B4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689260600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cFIn1CK6FnjNQCiz1JGiV9ILeppGAa06PwBz7dUeBjo=;
        b=OAMfVdC0JDbYJeBM5ADyx0vFjMNELCIRL7qnzo0hg6ZKd3uu0G3Nhhtw7z43gNIPKOdDfN
        Ma85reAP6UHJUu3TlXROWVxTQOKxet8cjsa5zgUVitjVYrdPD9Tsip3MbSBl8tMgbXjNGX
        lX3/iPmcexJwCnpNJrpcwHzRZfXmmxM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-y27eTUbnPx2DROIXZkVKRw-1; Thu, 13 Jul 2023 11:03:15 -0400
X-MC-Unique: y27eTUbnPx2DROIXZkVKRw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-314134f403fso542218f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689260592; x=1691852592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFIn1CK6FnjNQCiz1JGiV9ILeppGAa06PwBz7dUeBjo=;
        b=QllJq2AtBovfNyOPVnAA5wBhoP3D875LVseCQ6a7ZoI4lGfA6KtMRD4yHfKJV3l2so
         M+E1zJQgsqTyzhmdMyNgRNLzTsDoVKuny6jDgQ3HqFml6kt78IK0kHsxCb8D8/ZsUrE1
         /N1AL7+5C/JsyPwNMXhzbmHHh5HyLdDJCbV+qIr/uwYkxfW8UwRnTRdtYQRaybrfvyCP
         zG5MKGpCnB+cMJvSqLhKZKQJ3mzUPxNKNroJFoPL3ctvZrqJDnyF6d/R2CP2R1rnNT6N
         f1kHOYbp1znFzcxeoyPLpxt1vTRFSV9Be7G9QGwbX9R6Y3982Wr7bl0hrv9+yLcMVKQQ
         6Cyw==
X-Gm-Message-State: ABy/qLa8hltwhlvVFRsmhHi+F6p9jahlm1SFbVp5autoSd9XXv31KFDm
        q1LeE1SaAgK73I4ZBcD1CDKlCwC6jdgjoUt6DbFHgT+gwX/Vga5oqPT8TQmy8EtPRAmmgjD2uAD
        SAWV3VJZ3ZkLDo3wv/rbEPsnr
X-Received: by 2002:a5d:4990:0:b0:314:38e4:259f with SMTP id r16-20020a5d4990000000b0031438e4259fmr1715196wrq.37.1689260592554;
        Thu, 13 Jul 2023 08:03:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFaDnc8gCmS/iGE+xN/QIqC6uWksocY8EZzAU7Kes71J35fzl/XzIXfSkkw7EmyOclyba4XlQ==
X-Received: by 2002:a5d:4990:0:b0:314:38e4:259f with SMTP id r16-20020a5d4990000000b0031438e4259fmr1715172wrq.37.1689260592174;
        Thu, 13 Jul 2023 08:03:12 -0700 (PDT)
Received: from redhat.com ([2.52.158.233])
        by smtp.gmail.com with ESMTPSA id w8-20020adfd4c8000000b003141e629cb6sm8119734wrk.101.2023.07.13.08.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:03:11 -0700 (PDT)
Date:   Thu, 13 Jul 2023 11:03:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v1 0/4] virtio-mem: memory unplug/offlining related
 cleanups
Message-ID: <20230713110235-mutt-send-email-mst@kernel.org>
References: <20230713145551.2824980-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713145551.2824980-1-david@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 04:55:47PM +0200, David Hildenbrand wrote:
> Some cleanups+optimizations primarily around offline_and_remove_memory().
> 
> Patch #1 drops the "unsafe unplug" feature where we might get stuck in
> offline_and_remove_memory() forever.
> 
> Patch #2 handles unexpected errors from offline_and_remove_memory() a bit
> nicer.
> 
> Patch #3 handles the case where offline_and_remove_memory() failed and
> we want to retry later to remove a completely unplugged Linux memory
> block, to not have them waste memory forever.
> 
> Patch #4 something I had lying around for longer, which reacts faster
> on config changes when unplugging memory.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

This looks like something that's reasonable to put in this linux, right?
These are fixes even though they are for theoretical issues.

> David Hildenbrand (4):
>   virtio-mem: remove unsafe unplug in Big Block Mode (BBM)
>   virtio-mem: convert most offline_and_remove_memory() errors to -EBUSY
>   virtio-mem: keep retrying on offline_and_remove_memory() errors in Sub
>     Block Mode (SBM)
>   virtio-mem: check if the config changed before fake offlining memory
> 
>  drivers/virtio/virtio_mem.c | 168 ++++++++++++++++++++++++------------
>  1 file changed, 112 insertions(+), 56 deletions(-)
> 
> 
> base-commit: 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
> -- 
> 2.41.0

