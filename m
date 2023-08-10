Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2ED7780FF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbjHJTFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbjHJTFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:05:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F74AA8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691694274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f/d485k4GYGK+Hhxc7O7Vh9Y7TOuExVY3FHsGQcP80A=;
        b=UA26Acvs5m5DIj5YH57pEzZajCMh2sqSu+L7MVtvetMye9X/JyokPRfDsimg0DANwp4mNV
        VSOA9hiNFx4D3PMp6mE07IuMuMpyDosQwe/ezH/nKWjPtO4ydSXLdceTFkFIrI136eYhUk
        2LaTO18ZMnfC1PSQ+SDjoOHls3HikFs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-V4kOXhUzO7ySiuKm0IaBZQ-1; Thu, 10 Aug 2023 15:04:33 -0400
X-MC-Unique: V4kOXhUzO7ySiuKm0IaBZQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fe4bda379fso8134115e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691694272; x=1692299072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/d485k4GYGK+Hhxc7O7Vh9Y7TOuExVY3FHsGQcP80A=;
        b=K0VqZpMIKmeIN02RB9CyXOOVuTmHfeCpysBrc3tsFD5BBkeXZNGff7trOWmPahmt/P
         dTUwYM1kl6MAuwEaIjwWaKuhA7aVjk2B6KCRKHVjL5YwqGfLLnGX9NbVoUWwymnWvrQw
         CDZF25wcq33NDWE9f2miloKgUCPtK6kuMlpemHJgCr0agehvUEYAhegPaAoxpKq577Zr
         JC6zu9YMAJHZBukcxVWcEIQ5ONOh7JPQqwbBfaIqWzViJCMbbZ+reJHg9NhEy/w/CBil
         d3Moavu/vZxLTu54DC1yhNkMR59iPSMxqpwFsapWZeqSM/rKKgD9z6W5sn6SLZO76kcF
         8h7w==
X-Gm-Message-State: AOJu0Yz/WwJyqLX6K5k4TnsBTu5H9sbl49E2J9lsnJwp+KnbZf80kU5s
        XonSeL5ef5D7G3VENQf6UXXQRn+PBHlOKjuJkDaZwOGXr3bjWR0FHG0DWzds0l1ZZUONunON2sv
        XHO+Chq6wKaNO9V9zAfVVfucj
X-Received: by 2002:a1c:f716:0:b0:3fc:92:73d6 with SMTP id v22-20020a1cf716000000b003fc009273d6mr2665609wmh.11.1691694272142;
        Thu, 10 Aug 2023 12:04:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7XXbeFXHjJXPtbXknI7UArQUoxvGNLo3LCjH5yIBicBM7CJNAjsPriiFtN22BWjuicw51CA==
X-Received: by 2002:a1c:f716:0:b0:3fc:92:73d6 with SMTP id v22-20020a1cf716000000b003fc009273d6mr2665591wmh.11.1691694271848;
        Thu, 10 Aug 2023 12:04:31 -0700 (PDT)
Received: from redhat.com ([2.55.27.97])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c205000b003fe26bf65e7sm2928355wmg.13.2023.08.10.12.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:04:31 -0700 (PDT)
Date:   Thu, 10 Aug 2023 15:04:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     xieyongji@bytedance.com, jasowang@redhat.com,
        david.marchand@redhat.com, lulu@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Subject: Re: [PATCH v3 0/3] vduse: add support for networking devices
Message-ID: <20230810150347-mutt-send-email-mst@kernel.org>
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705100430.61927-1-maxime.coquelin@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 12:04:27PM +0200, Maxime Coquelin wrote:
> This small series enables virtio-net device type in VDUSE.
> With it, basic operation have been tested, both with
> virtio-vdpa and vhost-vdpa using DPDK Vhost library series
> adding VDUSE support using split rings layout (merged in
> DPDK v23.07-rc1).
> 
> Control queue support (and so multiqueue) has also been
> tested, but requires a Kernel series from Jason Wang
> relaxing control queue polling [1] to function reliably,
> so while Jason rework is done, a patch is added to disable
> CVQ and features that depend on it (tested also with DPDK
> v23.07-rc1).


So I can put this in next, the issue I think is
that of security: currently selinux can if necessary block
access to creating virtio block devices.
But if we have more than one type we need a way for selinux to
block specific types. Can be a patch on top but pls work to
address.

Another question is that with this userspace can inject
packets directly into net stack. Should we check CAP_NET_ADMIN
or such?



> [1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com/T/
> 
> v2 -> v3 changes:
> =================
> - Use allow list instead of deny list (Michael)
> 
> v1 -> v2 changes:
> =================
> - Add a patch to disable CVQ (Michael)
> 
> RFC -> v1 changes:
> ==================
> - Fail device init if it does not support VERSION_1 (Jason)
> 
> Maxime Coquelin (3):
>   vduse: validate block features only with block devices
>   vduse: enable Virtio-net device type
>   vduse: Temporarily disable control queue features
> 
>  drivers/vdpa/vdpa_user/vduse_dev.c | 51 +++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 4 deletions(-)
> 
> -- 
> 2.41.0

