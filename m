Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25FA80F218
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjLLQNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjLLQNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:13:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F49F101
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702397633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uuy6fJEq9VcrZk+5OcRbC+0CsDirfz4cGt+s4ZDOS6A=;
        b=etb+LAKhqTdwR/9AOqnAJgvDKNDPF62JkyPosYFage8YsBigtQGbuUZeXHWeT1QuEprRTo
        khPTG7mSx1Qw4SfsTbmAW2bnUbpd8JSrQTmRg5vFokgox6YOG4pLx/vM6iLY06vZOJLGRQ
        bjGd7NOVqKeQ8/tnwL+NdH1xfY6H76Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-vaLCDbmaNVm1LOD8wBR_yw-1; Tue, 12 Dec 2023 11:13:51 -0500
X-MC-Unique: vaLCDbmaNVm1LOD8wBR_yw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40c1d2b1559so42173845e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:13:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397630; x=1703002430;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuy6fJEq9VcrZk+5OcRbC+0CsDirfz4cGt+s4ZDOS6A=;
        b=Zbn2XvdPyrycY/pl7PT7JLygEAy/Umcfy1vMtP+EzntVx4Ys8z6UwnMfmmsXVdkeOv
         deqGMOXbgKgYnZYCwp7pjMPWqRArET/1nVxABfk1ZJui1Tn6Lgh41vEw9gAYJPQik4HF
         SIMZxjMJbPbE4KSbfszkLNdNX67wDyDe1iEOazy4HVFA/tvkUJWcI1NOLy7DXwuLOtMy
         v8AN73H2eZBH8hwJSh0/QHILyuElCDz6w1kXi/pulblmX7HB+DeDhV0mfDOHTcTTsVuI
         1aWZEEmxi6s6YQdsLjwMv7PSR5lNuHiuEmmfKD3M+gRseIk4UypEgi3aKxBI1T+2/o5I
         QIFQ==
X-Gm-Message-State: AOJu0Yw65eCL7GObF/SefyXKhhOdtt6zPf728UlnyYt0lMWi8PXtGxHf
        s7UaGCSuXLy4SaBtD7VS0HlWcTtaSTwzeiuilOB0tD3OjnfuHgOUvAfAMe+ijf91+UpPtwkY5dk
        tKLkel/j0TXb2npHUrRGE7Vt5gP0BY2fC
X-Received: by 2002:a05:600c:861b:b0:40b:5e59:c557 with SMTP id ha27-20020a05600c861b00b0040b5e59c557mr3364972wmb.129.1702397630189;
        Tue, 12 Dec 2023 08:13:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfUc4xfhTLTS5rbpUv86c4E0o2kWCp80gyTVZYIY86ryUM/Xq1XffDjqEM45VPyAYPelpzqg==
X-Received: by 2002:a05:600c:861b:b0:40b:5e59:c557 with SMTP id ha27-20020a05600c861b00b0040b5e59c557mr3364962wmb.129.1702397629813;
        Tue, 12 Dec 2023 08:13:49 -0800 (PST)
Received: from redhat.com ([2.52.23.105])
        by smtp.gmail.com with ESMTPSA id t4-20020adff044000000b0033340937da6sm11036564wro.95.2023.12.12.08.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 08:13:49 -0800 (PST)
Date:   Tue, 12 Dec 2023 11:13:46 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     David Stevens <stevensd@chromium.org>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio: Add support for no-reset virtio PCI PM
Message-ID: <20231212111323-mutt-send-email-mst@kernel.org>
References: <20231208070754.3132339-1-stevensd@chromium.org>
 <20231211113710-mutt-send-email-mst@kernel.org>
 <CACGkMEs_MajTFxGVcK5R8oqQzTxuL4Pm=uUnOonDczWzqaucsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEs_MajTFxGVcK5R8oqQzTxuL4Pm=uUnOonDczWzqaucsw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:01:53AM +0800, Jason Wang wrote:
> On Tue, Dec 12, 2023 at 12:37 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Dec 08, 2023 at 04:07:54PM +0900, David Stevens wrote:
> > > If a virtio_pci_device supports native PCI power management and has the
> > > No_Soft_Reset bit set, then skip resetting and reinitializing the device
> > > when suspending and restoring the device. This allows system-wide low
> > > power states like s2idle to be used in systems with stateful virtio
> > > devices that can't simply be re-initialized (e.g. virtio-fs).
> > >
> > > Signed-off-by: David Stevens <stevensd@chromium.org>
> >
> > tagged, thanks!
> > I'm still debating with myself whether we can classify this
> > as a bugfix ... better not risk it I guess.
> 
> It might be suitable if there's a hypervisor that advertises
> no_soft_reset (but it seems Qemu doesn't).
> 
> Thanks

Yea... so a bugfix but no rush to merge it I think.

> >
> > > ---
> > > v1 -> v2:
> > >  - Check the No_Soft_Reset bit
> > >
> > >  drivers/virtio/virtio_pci_common.c | 34 +++++++++++++++++++++++++++++-
> > >  1 file changed, 33 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > > index c2524a7207cf..3a95ecaf12dc 100644
> > > --- a/drivers/virtio/virtio_pci_common.c
> > > +++ b/drivers/virtio/virtio_pci_common.c
> > > @@ -492,8 +492,40 @@ static int virtio_pci_restore(struct device *dev)
> > >       return virtio_device_restore(&vp_dev->vdev);
> > >  }
> > >
> > > +static bool vp_supports_pm_no_reset(struct device *dev)
> > > +{
> > > +     struct pci_dev *pci_dev = to_pci_dev(dev);
> > > +     u16 pmcsr;
> > > +
> > > +     if (!pci_dev->pm_cap)
> > > +             return false;
> > > +
> > > +     pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > > +     if (PCI_POSSIBLE_ERROR(pmcsr)) {
> > > +             dev_err(dev, "Unable to query pmcsr");
> > > +             return false;
> > > +     }
> > > +
> > > +     return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
> > > +}
> > > +
> > > +static int virtio_pci_suspend(struct device *dev)
> > > +{
> > > +     return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_freeze(dev);
> > > +}
> > > +
> > > +static int virtio_pci_resume(struct device *dev)
> > > +{
> > > +     return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_restore(dev);
> > > +}
> > > +
> > >  static const struct dev_pm_ops virtio_pci_pm_ops = {
> > > -     SET_SYSTEM_SLEEP_PM_OPS(virtio_pci_freeze, virtio_pci_restore)
> > > +     .suspend = virtio_pci_suspend,
> > > +     .resume = virtio_pci_resume,
> > > +     .freeze = virtio_pci_freeze,
> > > +     .thaw = virtio_pci_restore,
> > > +     .poweroff = virtio_pci_freeze,
> > > +     .restore = virtio_pci_restore,
> > >  };
> > >  #endif
> > >
> > > --
> > > 2.43.0.472.g3155946c3a-goog
> >

