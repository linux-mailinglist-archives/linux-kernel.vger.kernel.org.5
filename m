Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AA777853D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 04:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjHKCLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 22:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHKCLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 22:11:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DEF2D55
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 19:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691719845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u9oE7qA94MWDV5RlSnQcOTMO4BPmVWC7Dzv0qiGO5EM=;
        b=eKMbdn6OPkRXk7DIpr6Sd6WEmBRfm9xucS69WeB+V10ruigQCFBSJ5xzvX3ZcQ1EPOdWxe
        tX7GY2BOblM+bzrSnYZwRkDU5a+n2xn9iMkf1BMP4nEgbJtioIFM88vgY5Lvs+mXzo6YY4
        boGMz6TJNr6yG0JtjxlCk84YHOvMSAg=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-NEQnYB08PwGfRwtCztjFAg-1; Thu, 10 Aug 2023 22:10:42 -0400
X-MC-Unique: NEQnYB08PwGfRwtCztjFAg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b9ce397ef1so16539671fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 19:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691719840; x=1692324640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9oE7qA94MWDV5RlSnQcOTMO4BPmVWC7Dzv0qiGO5EM=;
        b=D12WjbtzDrvjh9MeSJJ3kM5XWyZY/l7TpXEmAQ2vwuXhzPD1sRCe2ilh7wh++8G3BN
         4tKJQc+JNJBhI0rZJwwKTVnHHqTMxepgBeyv/G90j/5a7kwkPuQws6WIQ6eNSKJ1FFR+
         kexNwHdp1sPhOhaWVshKjrE3f523mQxCLCOl9hXAmWwTRieN5LvOol2vG8vyaIRwrox2
         ck96JZU9GXGLpkGPeAJH00jrY1nOHyfsjA6pdjhEDn2OoPm5zhvFB6lOb30MmIfye7tj
         10McqQNomo2u9WGh3OW8eBpSVzgdcD13szqNBCxQYclHrlekfv15INFC2nE8oUc2Im6T
         RoBw==
X-Gm-Message-State: AOJu0Yz24/QE4v2C6MeoDoUW5pGTt7R1zv8scQPsJFX1e1m3B13zCL0b
        vw1hI4Q+1ZZ1BK0NuGcFgmXs4fUOuOQAgbN+9HwF7EeECPl2pXN3oJc45ESk1pIQtO6B2ZfFURH
        1Oy8HxgI7jBBl5MCT90KP323wgnBWfXIh9aEwX6p6
X-Received: by 2002:a2e:8744:0:b0:2b9:45ad:88b1 with SMTP id q4-20020a2e8744000000b002b945ad88b1mr599176ljj.2.1691719840609;
        Thu, 10 Aug 2023 19:10:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhpvZ7rov6Rv/KhWvHy2BiYAgjqCj2ZJRjGnCeZecKkhetRZera3i8cKkv/uDefp1Q4rLtEd1blLLmsf4EwLQ=
X-Received: by 2002:a2e:8744:0:b0:2b9:45ad:88b1 with SMTP id
 q4-20020a2e8744000000b002b945ad88b1mr599170ljj.2.1691719840271; Thu, 10 Aug
 2023 19:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230728070127.18452-1-quic_ajainp@quicinc.com> <20230810154334-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230810154334-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 11 Aug 2023 10:10:28 +0800
Message-ID: <CACGkMEvWE4bSzULPcMRx_UZ96Y+RzG8cL_P3zURwuaRCZRrx0A@mail.gmail.com>
Subject: Re: [PATCH] virtio_mmio: add suspend and resume calls for virtio_mmio devices
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Anvesh Jain P <quic_ajainp@quicinc.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Venkata Rao Kakani <quic_vkakani@quicinc.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 3:45=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Jul 28, 2023 at 12:31:27PM +0530, Anvesh Jain P wrote:
> > Handle suspend and resume calls for virtio mmio devices from
> > PM core. Expose these notifications to virtio drivers that can quiesce =
and
> > resume vq operations. Update virtio pm ops to handle freeze& restore an=
d
> > suspend & resume callbacks separately.
> >
> > Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
> > Signed-off-by: Venkata Rao Kakani <quic_vkakani@quicinc.com>
>
> okey but what is the motivation? does this addition of 200 LOC
> achieve something new? what is the issue fixed here?

+1

And I think we need an example that can use the new ops.

Thanks

>
>
> > ---
> >  drivers/virtio/virtio.c      | 112 +++++++++++++++++++++++++++++++++++
> >  drivers/virtio/virtio_mmio.c |  50 +++++++++++++++-
> >  include/linux/virtio.h       |  12 ++++
> >  3 files changed, 173 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index 3893dc29eb26..c6f25a267600 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -551,6 +551,118 @@ int virtio_device_restore(struct virtio_device *d=
ev)
> >       return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_device_restore);
> > +
> > +int virtio_device_suspend(struct virtio_device *dev)
> > +{
> > +     struct virtio_driver *drv =3D drv_to_virtio(dev->dev.driver);
> > +
> > +     virtio_config_disable(dev);
> > +
> > +     dev->failed =3D dev->config->get_status(dev) & VIRTIO_CONFIG_S_FA=
ILED;
> > +
> > +     if (drv && drv->suspend)
> > +             return drv->suspend(dev);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_device_suspend);
> > +
> > +int virtio_device_resume(struct virtio_device *dev)
> > +{
> > +     struct virtio_driver *drv =3D drv_to_virtio(dev->dev.driver);
> > +     int ret;
> > +
> > +     if (drv && drv->resume) {
> > +             ret =3D drv->resume(dev);
> > +             if (ret)
> > +                     goto err;
> > +
> > +             if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIV=
ER_OK))
> > +                     virtio_device_ready(dev);
> > +
> > +             virtio_config_enable(dev);
> > +     }
> > +
> > +     return 0;
> > +err:
> > +     virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_device_resume);
> > +
> > +int virtio_device_suspend_late(struct virtio_device *dev)
> > +{
> > +     struct virtio_driver *drv =3D drv_to_virtio(dev->dev.driver);
> > +
> > +     virtio_config_disable(dev);
> > +
> > +     dev->failed =3D dev->config->get_status(dev) & VIRTIO_CONFIG_S_FA=
ILED;
> > +
> > +     if (drv && drv->suspend_late)
> > +             return drv->suspend_late(dev);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_device_suspend_late);
> > +
> > +int virtio_device_resume_early(struct virtio_device *dev)
> > +{
> > +     struct virtio_driver *drv =3D drv_to_virtio(dev->dev.driver);
> > +     int ret;
> > +
> > +     if (drv && drv->resume_early) {
> > +             ret =3D drv->resume_early(dev);
> > +             if (ret)
> > +                     goto err;
> > +             if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIV=
ER_OK))
> > +                     virtio_device_ready(dev);
> > +
> > +             virtio_config_enable(dev);
> > +     }
> > +
> > +     return 0;
> > +err:
> > +     virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_device_resume_early);
> > +
> > +int virtio_device_suspend_noirq(struct virtio_device *dev)
> > +{
> > +     struct virtio_driver *drv =3D drv_to_virtio(dev->dev.driver);
> > +
> > +     virtio_config_disable(dev);
> > +
> > +     dev->failed =3D dev->config->get_status(dev) & VIRTIO_CONFIG_S_FA=
ILED;
> > +
> > +     if (drv && drv->suspend_noirq)
> > +             return drv->suspend_noirq(dev);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_device_suspend_noirq);
> > +
> > +int virtio_device_resume_noirq(struct virtio_device *dev)
> > +{
> > +     struct virtio_driver *drv =3D drv_to_virtio(dev->dev.driver);
> > +     int ret;
> > +
> > +     if (drv && drv->resume_noirq) {
> > +             ret =3D drv->resume_noirq(dev);
> > +             if (ret)
> > +                     goto err;
> > +             if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIV=
ER_OK))
> > +                     virtio_device_ready(dev);
> > +
> > +             virtio_config_enable(dev);
> > +     }
> > +
> > +     return 0;
> > +err:
> > +     virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(virtio_device_resume_noirq);
> >  #endif
> >
> >  static int virtio_init(void)
> > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.=
c
> > index a46a4a29e929..9385c7e65da9 100644
> > --- a/drivers/virtio/virtio_mmio.c
> > +++ b/drivers/virtio/virtio_mmio.c
> > @@ -596,9 +596,57 @@ static int virtio_mmio_restore(struct device *dev)
> >
> >       return virtio_device_restore(&vm_dev->vdev);
> >  }
> > +static int virtio_mmio_suspend(struct device *dev)
> > +{
> > +       struct virtio_mmio_device *vm_dev =3D dev_get_drvdata(dev);
> > +
> > +       return virtio_device_suspend(&vm_dev->vdev);
> > +}
> > +
> > +static int virtio_mmio_resume(struct device *dev)
> > +{
> > +       struct virtio_mmio_device *vm_dev =3D dev_get_drvdata(dev);
> > +
> > +       return virtio_device_resume(&vm_dev->vdev);
> > +}
> > +
> > +static int virtio_mmio_suspend_late(struct device *dev)
> > +{
> > +       struct virtio_mmio_device *vm_dev =3D dev_get_drvdata(dev);
> > +
> > +       return virtio_device_suspend_late(&vm_dev->vdev);
> > +}
> > +
> > +static int virtio_mmio_resume_early(struct device *dev)
> > +{
> > +       struct virtio_mmio_device *vm_dev =3D dev_get_drvdata(dev);
> > +
> > +       return virtio_device_resume_early(&vm_dev->vdev);
> > +}
> > +
> > +static int virtio_mmio_suspend_noirq(struct device *dev)
> > +{
> > +       struct virtio_mmio_device *vm_dev =3D dev_get_drvdata(dev);
> > +
> > +       return virtio_device_suspend_noirq(&vm_dev->vdev);
> > +}
> > +
> > +static int virtio_mmio_resume_noirq(struct device *dev)
> > +{
> > +       struct virtio_mmio_device *vm_dev =3D dev_get_drvdata(dev);
> > +
> > +       return virtio_device_resume_noirq(&vm_dev->vdev);
> > +}
> >
> >  static const struct dev_pm_ops virtio_mmio_pm_ops =3D {
> > -     SET_SYSTEM_SLEEP_PM_OPS(virtio_mmio_freeze, virtio_mmio_restore)
> > +       .freeze         =3D virtio_mmio_freeze,
> > +       .restore        =3D virtio_mmio_restore,
> > +       .suspend        =3D virtio_mmio_suspend,
> > +       .resume         =3D virtio_mmio_resume,
> > +       .suspend_late   =3D virtio_mmio_suspend_late,
> > +       .resume_early   =3D virtio_mmio_resume_early,
> > +       .suspend_noirq  =3D virtio_mmio_suspend_noirq,
> > +       .resume_noirq   =3D virtio_mmio_resume_noirq,
> >  };
> >  #endif
> >
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index de6041deee37..e88b321408e9 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -145,6 +145,12 @@ void virtio_config_changed(struct virtio_device *d=
ev);
> >  #ifdef CONFIG_PM_SLEEP
> >  int virtio_device_freeze(struct virtio_device *dev);
> >  int virtio_device_restore(struct virtio_device *dev);
> > +int virtio_device_suspend(struct virtio_device *dev);
> > +int virtio_device_resume(struct virtio_device *dev);
> > +int virtio_device_suspend_late(struct virtio_device *dev);
> > +int virtio_device_resume_early(struct virtio_device *dev);
> > +int virtio_device_suspend_noirq(struct virtio_device *dev);
> > +int virtio_device_resume_noirq(struct virtio_device *dev);
> >  #endif
> >  void virtio_reset_device(struct virtio_device *dev);
> >
> > @@ -187,6 +193,12 @@ struct virtio_driver {
> >  #ifdef CONFIG_PM
> >       int (*freeze)(struct virtio_device *dev);
> >       int (*restore)(struct virtio_device *dev);
> > +     int (*suspend)(struct virtio_device *dev);
> > +     int (*resume)(struct virtio_device *dev);
> > +     int (*suspend_late)(struct virtio_device *dev);
> > +     int (*resume_early)(struct virtio_device *dev);
> > +     int (*suspend_noirq)(struct virtio_device *dev);
> > +     int (*resume_noirq)(struct virtio_device *dev);
> >  #endif
> >  };
> >
> >
> > base-commit: 3f01e9fed8454dcd89727016c3e5b2fbb8f8e50c
> > --
> > 2.17.1
>

