Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB86575B555
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjGTRPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjGTRPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:15:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290C82135
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689873289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6dS9MqSSp9voaLhT32kd9eEdqfQVkZ98uR/QeW4LDZE=;
        b=eclkqvDz9q1qaMjKkGyQvso4GQILYgQD8P5j+y3kPAFGC5t1RXENR/0mivS2AlUiEUgQ4V
        ML5tFNqJfCCxMBcMowl3Z0vdQz9cDw39Ypujkw4+5Fgx8PdzeRqvwali4fWa0lKY72l8Dy
        0RpZOF34ObRvhXkwZashvIq63u0WUUk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-9uQwqO2hPeeRhnAL8CVvZA-1; Thu, 20 Jul 2023 13:14:47 -0400
X-MC-Unique: 9uQwqO2hPeeRhnAL8CVvZA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fa979d0c32so5702055e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689873286; x=1690478086;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6dS9MqSSp9voaLhT32kd9eEdqfQVkZ98uR/QeW4LDZE=;
        b=OxSSWETFgSVQ36cM6SsRMW1gR+2LGuz0DE51in25TdtuF4GhoQD4v2UgVbO/6cQQ14
         ynV8nre0wKnS2UowPwoSZuilhq2feRnofKs8nUVnCje4ymN1WBNMxr4IdxiLkP/gB7Am
         czappK+9V2jEjLIpp6mT84UTqfZNWiHMWjTGJhaPdf9xXHPrf29MBvUhr4xTIZggKw7C
         fqIZ7ZQlEbDE7UMo9wxVJfAodshRI7W5EW64fg8bGI0BdeN63pvBQSowLe2VJlJnA/I4
         +LRzwqu9iAEFceC+HZAAJ7KMgE5XA5EBU/SA1bnr/A+T9GHj/hYaDBbQs37fyyX6GZ8a
         97ug==
X-Gm-Message-State: ABy/qLaIjINjxsyZ/L3FVCR92k8NIMD//SeHVhurgLVnpGPOX7VZZQHa
        xfIP0tVmw36RfGr3GzyUTG+r8zOUmdtl9Xb7TrQJKV213HP2TVG/oa2I2h9cG8QRDq9wZKRavkK
        Ozf3L1anBMgSIbeGj+ok2+PxB
X-Received: by 2002:a1c:4c13:0:b0:3fb:b1bf:7df3 with SMTP id z19-20020a1c4c13000000b003fbb1bf7df3mr2199604wmf.16.1689873286281;
        Thu, 20 Jul 2023 10:14:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFAgJO3NxYviKlK+X6t6HgIiN+C/pcRVYIxatfLo7cgnANyyz1Ib3buESEGZUGAVckH6rGlPA==
X-Received: by 2002:a1c:4c13:0:b0:3fb:b1bf:7df3 with SMTP id z19-20020a1c4c13000000b003fbb1bf7df3mr2199588wmf.16.1689873285921;
        Thu, 20 Jul 2023 10:14:45 -0700 (PDT)
Received: from redhat.com ([2.52.16.41])
        by smtp.gmail.com with ESMTPSA id m24-20020a056000181800b003143ac73fd0sm1892991wrh.1.2023.07.20.10.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 10:14:45 -0700 (PDT)
Date:   Thu, 20 Jul 2023 13:14:41 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Feng Liu <feliu@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Bodong Wang <bodong@nvidia.com>,
        Parav Pandit <parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH v1] virtio-pci: Fix legacy device flag setting error in
 probe
Message-ID: <20230720131423-mutt-send-email-mst@kernel.org>
References: <20230719154550.79536-1-feliu@nvidia.com>
 <CACGkMEv1b698NcpZHxpDoNokWH0gEs07D2eYSAjsiF1efhxORw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEv1b698NcpZHxpDoNokWH0gEs07D2eYSAjsiF1efhxORw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 10:27:04AM +0800, Jason Wang wrote:
> On Wed, Jul 19, 2023 at 11:46 PM Feng Liu <feliu@nvidia.com> wrote:
> >
> > The 'is_legacy' flag is used to differentiate between legacy vs modern
> > device. Currently, it is based on the value of vp_dev->ldev.ioaddr.
> > However, due to the shared memory of the union between struct
> > virtio_pci_legacy_device and struct virtio_pci_modern_device, when
> > virtio_pci_modern_probe modifies the content of struct
> > virtio_pci_modern_device, it affects the content of struct
> > virtio_pci_legacy_device, and ldev.ioaddr is no longer zero, causing
> > the 'is_legacy' flag to be set as true. To resolve issue, when legacy
> > device is probed, mark 'is_legacy' as true, when modern device is
> > probed, keep 'is_legacy' as false.
> >
> > Fixes: 4f0fc22534e3 ("virtio_pci: Optimize virtio_pci_device structure size")
> > Signed-off-by: Feng Liu <feliu@nvidia.com>
> > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > ---
> >  drivers/virtio/virtio_pci_common.c | 2 --
> >  drivers/virtio/virtio_pci_legacy.c | 1 +
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index a6c86f916dbd..c2524a7207cf 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -557,8 +557,6 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
> >
> >         pci_set_master(pci_dev);
> >
> > -       vp_dev->is_legacy = vp_dev->ldev.ioaddr ? true : false;
> > -
> >         rc = register_virtio_device(&vp_dev->vdev);
> >         reg_dev = vp_dev;
> >         if (rc)
> > diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> > index 2257f1b3d8ae..d9cbb02b35a1 100644
> > --- a/drivers/virtio/virtio_pci_legacy.c
> > +++ b/drivers/virtio/virtio_pci_legacy.c
> > @@ -223,6 +223,7 @@ int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
> >         vp_dev->config_vector = vp_config_vector;
> >         vp_dev->setup_vq = setup_vq;
> >         vp_dev->del_vq = del_vq;
> > +       vp_dev->is_legacy = true;
> 
> This seems break force_legacy for modern device:
> 
>         if (force_legacy) {
>                 rc = virtio_pci_legacy_probe(vp_dev);
>                 /* Also try modern mode if we can't map BAR0 (no IO space). */
>                 if (rc == -ENODEV || rc == -ENOMEM)
>                         rc = virtio_pci_modern_probe(vp_dev);
> 
> Thanks

don't see the breakage here - can you explain a bit more?

> >
> >         return 0;
> >  }
> > --
> > 2.37.1 (Apple Git-137.1)
> >

