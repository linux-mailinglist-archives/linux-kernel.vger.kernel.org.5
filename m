Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324CF767068
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbjG1PWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjG1PWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:22:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38F13592
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690557714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NA5x7LpmDsxwcFP3IyTHomLTdnzMLPsHmmR5ITWV0mk=;
        b=Ny7mbA2xBWNKyWpsDVQDGl8JT0eoWXzW6IlcJaE3M1hnLs1nkBktkRoodMDO21jQWU6+2F
        t1j+FeHPv0yHzzA08HK/EoaST6xsmxY6kVvq+pH2Doa6WN7F6mMWzgGrIOcn4mVDW4y+du
        7hb1qtLfjhw9GPFUYRgBKv+S9KqsnBA=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442--Nchrw5TOT6AQIu6-7t2Og-1; Fri, 28 Jul 2023 11:21:49 -0400
X-MC-Unique: -Nchrw5TOT6AQIu6-7t2Og-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-34603502e5aso15588735ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690557709; x=1691162509;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NA5x7LpmDsxwcFP3IyTHomLTdnzMLPsHmmR5ITWV0mk=;
        b=FgVlVTFLQhH5+a1FpcD+j7eff93DIGaqhRS1JEqoSqRlAmd+I/Q+zSEYlQkHupVWPp
         Ek7aVmUCz2vX1BMxNowrXCzdk34vQTYBlbNzxLv6XDX4KiX98OL8KoUbUutBpHVxSZSR
         Qbzq29CJFmRQ4y77MLJEA5Bh567CQTwT6RB0ocxdKl0wRT3uS8GpnF/hJZiDmJZZ7aqT
         vxf2lth+pxYdPwOkcTbEAI50cIkwpPq/jCHQWYkXCd7/Hoe67u3YNQobcMGt/acup/Wz
         n89A4mt9mmeE6+94T+UddZWou+0zN6hf1h0iPXJStDktsFQFa07Ut4wSxdv8TXGUi8RD
         2IQQ==
X-Gm-Message-State: ABy/qLaaS4SGDE2aWGj7emgRaTgjOfiMGDjceV6q2khytjGmcsamYgk1
        /QmqLYrm/ydRr/PSCjsn696laHOF4T3h2Cn7nNC0qD7zM65DIqB3usBD0UPtPl7hum6PyjsVgzD
        K95my2XWwOQOLKTOkUi24MNh3
X-Received: by 2002:a05:6e02:218f:b0:348:f152:e02b with SMTP id j15-20020a056e02218f00b00348f152e02bmr3938131ila.5.1690557708757;
        Fri, 28 Jul 2023 08:21:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGCJ88/+VCazNs+MFEDd6VJbnANeNNSEVCWvLa2pA4/pAaGx+AxRJTSvIjzmempoP2iYUVMmw==
X-Received: by 2002:a05:6e02:218f:b0:348:f152:e02b with SMTP id j15-20020a056e02218f00b00348f152e02bmr3938109ila.5.1690557708545;
        Fri, 28 Jul 2023 08:21:48 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id b2-20020a029a02000000b0042b37dda71asm1119387jal.136.2023.07.28.08.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:21:48 -0700 (PDT)
Date:   Fri, 28 Jul 2023 09:21:44 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Ankit Agrawal <ankita@nvidia.com>,
        Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Andy Currid <acurrid@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <danw@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/1] vfio/nvgpu: Add vfio pci variant module for
 grace hopper
Message-ID: <20230728092144.5f51343f.alex.williamson@redhat.com>
In-Reply-To: <ZMO1H/uepDTtAaet@nvidia.com>
References: <20230716174333.8221-1-ankita@nvidia.com>
        <20230727142937.536e7259.alex.williamson@redhat.com>
        <BY5PR12MB3763F22DF104E2B3BC65C628B006A@BY5PR12MB3763.namprd12.prod.outlook.com>
        <ZMO1H/uepDTtAaet@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 09:31:27 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Jul 28, 2023 at 04:36:05AM +0000, Ankit Agrawal wrote:
> >   
> > >> +static ssize_t nvgrace_gpu_vfio_pci_read(struct vfio_device *core_vdev,
> > >> +             char __user *buf, size_t count, loff_t *ppos)
> > >> +{
> > >> +     unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
> > >> +     struct nvgrace_gpu_vfio_pci_core_device *nvdev = container_of(
> > >> +             core_vdev, struct nvgrace_gpu_vfio_pci_core_device, core_device.vdev);
> > >> +     u64 offset = *ppos & VFIO_PCI_OFFSET_MASK;
> > >> +     u8 val = 0xFF;
> > >> +     size_t i;
> > >> +
> > >> +     /*
> > >> +      * Only the device memory present on the hardware is mapped, which may
> > >> +      * not be power-of-2 aligned. A read to the BAR2 region implies an
> > >> +      * access outside the available device memory on the hardware.
> > >> +      */  
> > >
> > > This is not true, userspace has no requirement to only access BAR2 via
> > > mmap.  This should support reads from within the coherent memory area.  
> > 
> > Just to confirm, the ask is to just update the comment to reflect the behavior,
> > right? (I missed to do that in this posting). Because we do redirect the call to
> > vfio_pci_core_read() here which will perform the read that is within the device
> > region. The read response to synthesize -1 is only for the range that is outside
> > the device memory region.  
> 
> This doesn't seem right, vfio_pci_core_read() will use pci_iomap() to
> get a mapping which will be a DEVICE mapping, this will make the
> access incoherent with any cachable mappings.

Right, but also vfio_pci_core_read() doesn't know anything about this
virtual BAR2, so any in-range BAR2 accesses will error the same as
trying to access an unimplemented BAR.  It's not just the comment,
there's no code here to handle a read(2) from in-bound BAR2 accesses.
Thanks,

Alex

