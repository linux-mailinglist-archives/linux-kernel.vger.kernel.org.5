Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3541762AE5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGZFj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjGZFj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:39:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B822693
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 22:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690349917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pfs3nnD/SOOUA7MFV9W94hwiVWoxJiHiqbutUMOkKZQ=;
        b=E81W2JoPqXZoVdmZWJQZTBzCOtCD9bksmEy1OmktNnXJ0ry8DW7oGBtVGp7FnEOx3u0p/E
        hM76DEL06Wq5sFTNsIIGAc67meSTKUoi2E2anUag//TAGXpVCZnP6SZ+v7PHoPNtb1GKQa
        rD+HrR6UdUc368CdE/2cEvEYrvawZxg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-gThW64d1ORyqJT9XQdyKhQ-1; Wed, 26 Jul 2023 01:38:36 -0400
X-MC-Unique: gThW64d1ORyqJT9XQdyKhQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9b820c94fso1848591fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 22:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690349915; x=1690954715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfs3nnD/SOOUA7MFV9W94hwiVWoxJiHiqbutUMOkKZQ=;
        b=L+a1OYQQS49ivoX1rxa5eREDv/WX6qMOrHRUF22oYTCtR2pGBGJp54Czik4O5fmCpL
         JcU+EzCHQVYQ38eI16jy8GuPZ04Y2xMcCeHeDpzjyI6N2WHolXCQG7c27wYq2Nz/RnWu
         iIeiCcXtAUTlrFjRvqQ1D/PcXa5THCRIk8DsVPVq4bopdieouUF/F7x/LGxSKKDSb7Z+
         e9q4qvk9jEu422CHCmfqQN3rQ2V0tbQJnOX05bubhdfuOxo9RI2jE7SbS9u8gXenX1mf
         nVRw6dhmrDcSbnV23RuYMt08mNGyvaLVOfgE7JMULsbZas/y2ee4DgrM+Z+CWQ4H9HSm
         dDYQ==
X-Gm-Message-State: ABy/qLbXBR0/e1OS+tzJ3oxoDF/LmPmHe3MxVEmhYZ65UzHbx2/knSEL
        A058yLyXywSwNTBLWul3GcON05H/rAWeML14fdDr3LB4C29jj8E8T6oedifSFrRZEsI/JKGJ1vz
        uOCxah36s5+VEPIDY2A76v2egR+2w7s4YQxP2orhJ
X-Received: by 2002:a2e:8042:0:b0:2b6:dd9a:e1d3 with SMTP id p2-20020a2e8042000000b002b6dd9ae1d3mr605685ljg.44.1690349914783;
        Tue, 25 Jul 2023 22:38:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHZ1ivRh44yxvv5AoW/k+bdQtpElC2pldw9fqqViy1tLZuooCCFV/0/FqgQ945tCdp+io30vgVHGutAPfdVtuA=
X-Received: by 2002:a2e:8042:0:b0:2b6:dd9a:e1d3 with SMTP id
 p2-20020a2e8042000000b002b6dd9ae1d3mr605673ljg.44.1690349914469; Tue, 25 Jul
 2023 22:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230705114505.63274-1-maxime.coquelin@redhat.com>
In-Reply-To: <20230705114505.63274-1-maxime.coquelin@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 26 Jul 2023 13:38:22 +0800
Message-ID: <CACGkMEtF9c0dL+bk0=JovcVs-ZVzEJJXdt9gx=_Lh+KtwFu9ig@mail.gmail.com>
Subject: Re: [PATCH] vduse: Use proper spinlock for IRQ injection
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     xieyongji@bytedance.com, mst@redhat.com, david.marchand@redhat.com,
        lulu@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 7:45=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> The IRQ injection work used spin_lock_irq() to protect the
> scheduling of the softirq, but spin_lock_bh() should be
> used.
>
> With spin_lock_irq(), we noticed delay of more than 6
> seconds between the time a NAPI polling work is scheduled
> and the time it is executed.
>
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Cc: xieyongji@bytedance.com
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index dc38ed21319d..df7869537ef1 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -935,10 +935,10 @@ static void vduse_dev_irq_inject(struct work_struct=
 *work)
>  {
>         struct vduse_dev *dev =3D container_of(work, struct vduse_dev, in=
ject);
>
> -       spin_lock_irq(&dev->irq_lock);
> +       spin_lock_bh(&dev->irq_lock);
>         if (dev->config_cb.callback)
>                 dev->config_cb.callback(dev->config_cb.private);
> -       spin_unlock_irq(&dev->irq_lock);
> +       spin_unlock_bh(&dev->irq_lock);
>  }
>
>  static void vduse_vq_irq_inject(struct work_struct *work)
> @@ -946,10 +946,10 @@ static void vduse_vq_irq_inject(struct work_struct =
*work)
>         struct vduse_virtqueue *vq =3D container_of(work,
>                                         struct vduse_virtqueue, inject);
>
> -       spin_lock_irq(&vq->irq_lock);
> +       spin_lock_bh(&vq->irq_lock);
>         if (vq->ready && vq->cb.callback)
>                 vq->cb.callback(vq->cb.private);
> -       spin_unlock_irq(&vq->irq_lock);
> +       spin_unlock_bh(&vq->irq_lock);
>  }
>
>  static bool vduse_vq_signal_irqfd(struct vduse_virtqueue *vq)
> --
> 2.41.0
>

