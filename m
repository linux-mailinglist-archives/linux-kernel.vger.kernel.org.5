Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFD57E3529
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjKGGRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjKGGRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:17:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6A9126
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 22:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699337796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/2UQHWSjqglckUccpioOkcOlhzli4Nj6mkNpXIHnwec=;
        b=ABu/qVB7GC3M0Q19Jmu062Vvg/easzeUGLukNZlJDai+FSi2VLDKzHjJ/7wdI5uK/+rnGi
        bUtr+6Q8zEyLifeIcj+F7ETJNz2AZGg16iHY6HrYhDyuI/BsnLDre2CNVA4GHpQHQ/Bzf0
        tWWNy6AMZTrQ3L2Xa1Kc5bmWz3+0PUk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-cXKFLyC3OtydIsqZag85TQ-1; Tue, 07 Nov 2023 01:16:24 -0500
X-MC-Unique: cXKFLyC3OtydIsqZag85TQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9be601277c2so379748366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 22:16:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699337783; x=1699942583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2UQHWSjqglckUccpioOkcOlhzli4Nj6mkNpXIHnwec=;
        b=lUaoxocu13mn4yEXIGoVqIfOO0F3vl8EsVTEPQ9hS/7OwRdmjjrgNRKMdO410azGe5
         ajcOo+J1baFO1aiLyk+JTu0uvjsYOVUMsv92CE95Kor+E0hET9sZZdg2ktGC/WAVhK4J
         wukNd/em30k4AjgYh2MRw0D7UgbZsUKWCts1fOgXdS+wfPdhFdQKJf+CaEypxhJrcaL6
         w25Feq6OKwpxj9c+epiatdVdh2M9Aqk+5kBrDQgwde1sdJJRghOf8T9HtRoy/KMkkJBz
         c6JhBEshutiH0naNtHNulcE8A38fX15x19ggUswqu/Gfo2dQe2e4YB04b9PCae/nBP4V
         UsUA==
X-Gm-Message-State: AOJu0Yw9aeOiRKLkTYILab8yDJvus/EJZRmrbABpVFtnyMy+U5oiLkjg
        fr6i6mRqq0AgOmWfmQo8qTz47Vhfl6osXDDKmhswc6jt1UDDwLMzgvTB+rpF7HPWJy73RHsciEz
        04hY5S4gqaOLBLxKvz/TYWnGAzidb3WyTcoLzswjU
X-Received: by 2002:a17:907:97d5:b0:9cb:5a8a:b19d with SMTP id js21-20020a17090797d500b009cb5a8ab19dmr16071458ejc.5.1699337783726;
        Mon, 06 Nov 2023 22:16:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOmPUPuEOev3jI2GvZyE5M89BnJ4HD6j8Fr8R4rZmZ/Ig293uvxxyBNotmr8M7CvYlxy8nZngUJvGsS5szS6o=
X-Received: by 2002:a17:907:97d5:b0:9cb:5a8a:b19d with SMTP id
 js21-20020a17090797d500b009cb5a8ab19dmr16071441ejc.5.1699337783395; Mon, 06
 Nov 2023 22:16:23 -0800 (PST)
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-3-lulu@redhat.com>
 <0c710537-254f-48a7-b11d-3ee27c1f10f7@intel.com>
In-Reply-To: <0c710537-254f-48a7-b11d-3ee27c1f10f7@intel.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Tue, 7 Nov 2023 14:15:46 +0800
Message-ID: <CACLfguXZjpGE1XyBC+MuMdtuy8mEPnZND8zrxD17foXFcQxTrA@mail.gmail.com>
Subject: Re: [RFC v1 2/8] Kconfig: Add the new file vhost/iommufd
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 4:50=E2=80=AFPM Yi Liu <yi.l.liu@intel.com> wrote:
>
> On 2023/11/4 01:16, Cindy Lu wrote:
> > Change the makefile and Kconfig, to add the
> > new file vhost/iommufd.c
>
> why not merge it with patch 1?
>
sure will change this

thanks
cindy
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >   drivers/vhost/Kconfig  | 1 +
> >   drivers/vhost/Makefile | 1 +
> >   2 files changed, 2 insertions(+)
> >
> > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > index b455d9ab6f3d..a4becfb36d77 100644
> > --- a/drivers/vhost/Kconfig
> > +++ b/drivers/vhost/Kconfig
> > @@ -72,6 +72,7 @@ config VHOST_VDPA
> >       select VHOST
> >       select IRQ_BYPASS_MANAGER
> >       depends on VDPA
> > +     depends on IOMMUFD || !IOMMUFD
> >       help
> >         This kernel module can be loaded in host kernel to accelerate
> >         guest virtio devices with the vDPA-based backends.
> > diff --git a/drivers/vhost/Makefile b/drivers/vhost/Makefile
> > index f3e1897cce85..cda7f6b7f8da 100644
> > --- a/drivers/vhost/Makefile
> > +++ b/drivers/vhost/Makefile
> > @@ -12,6 +12,7 @@ obj-$(CONFIG_VHOST_RING) +=3D vringh.o
> >
> >   obj-$(CONFIG_VHOST_VDPA) +=3D vhost_vdpa.o
> >   vhost_vdpa-y :=3D vdpa.o
> > +vhost_vdpa-$(CONFIG_IOMMUFD) +=3D iommufd.o
> >
> >   obj-$(CONFIG_VHOST) +=3D vhost.o
> >
>
> --
> Regards,
> Yi Liu
>

