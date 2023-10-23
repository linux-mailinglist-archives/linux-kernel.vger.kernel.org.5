Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C390E7D39FF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjJWOpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbjJWOp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926DF1735
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698072202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EY/dfoODqe4KZBPQl8Uid5gopBq/vqnIAJCIMWwL5kA=;
        b=ZcY0dq9JKDcHgueFL/WqQK7TiEUHqM7rs7uvdOMsiZr6wksogxGGWEQrJxziaOSeZShru+
        DOI4+4qI12nQSw8qfFlI3YVfhTDKXH8JZ+6H/5NFfr3vSY915aLfCfki8Kgn2TZbd7qfmQ
        WQPmAbeWtoQQe/CPLPcj016CQ9yzQlQ=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-Aq6JmeiwN2qVlWIfTdBEqQ-1; Mon, 23 Oct 2023 10:43:16 -0400
X-MC-Unique: Aq6JmeiwN2qVlWIfTdBEqQ-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7a64eb9c96aso399490339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072195; x=1698676995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EY/dfoODqe4KZBPQl8Uid5gopBq/vqnIAJCIMWwL5kA=;
        b=pRHpr1pcwsGY+MfXBPH/zohyrWe4x+zcQ/ycG5NSusgiAd0II9PfEVUtwugpP5VvtQ
         FS324ZpukrDBRAXkwFB+f9iNstMJB/Cc9QWBbZZD1wnY17M+Xdc/liW1lsmEiTFyPzqo
         SQvaVAyyNY5GUuF2UppfIYS87hqVpt4QQBmf9lQyouZJrwV8/vPw5chKDbMFCvGjkfqk
         Wrlgb4t3lNpT3ul4acYdjsFqpHjQixS8BWVg8G5iDRq2H2LNPq61QtUCxWzuUyS+ae8F
         DCeHDEoL70RYTZ48p0bcaDbHx+0YMaqnAjxAHZiuqZ8PVt8oJ3pv47O7Apjs/zVjrU/9
         +fIg==
X-Gm-Message-State: AOJu0YzPXbYG2d9r3J9zZACd3Q3scDrU3meDlGggy6gPLOFOg6fRNKVR
        AySO8rnxJJKTrU48OGKJlKmG/tVTmnSG25evPTMQ9aAZ5D/MktktHP0gksLv9X6kfBK+QBRAcNk
        +q+ky6Yg10GVK0kcx2dlJmFXy
X-Received: by 2002:a05:6e02:1a6c:b0:357:a272:dbc with SMTP id w12-20020a056e021a6c00b00357a2720dbcmr11030721ilv.9.1698072195627;
        Mon, 23 Oct 2023 07:43:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETQ/NKPL5aS7r/tBMY5aQ03fUPAyygLBa/RltaXqJiYNfjK+Gb4Ihw4y17lmg1ikWSIXQfgA==
X-Received: by 2002:a05:6e02:1a6c:b0:357:a272:dbc with SMTP id w12-20020a056e021a6c00b00357a2720dbcmr11030701ilv.9.1698072195310;
        Mon, 23 Oct 2023 07:43:15 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id o11-20020a02cc2b000000b0045c5908ddb7sm2309724jap.69.2023.10.23.07.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:43:14 -0700 (PDT)
Date:   Mon, 23 Oct 2023 08:43:12 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Ankit Agrawal <ankita@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Andy Currid <acurrid@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <danw@nvidia.com>,
        "Anuj Aggarwal (SW-GPU)" <anuaggarwal@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 1/1] vfio/nvgpu: Add vfio pci variant module for
 grace hopper
Message-ID: <20231023084312.15b8e37e.alex.williamson@redhat.com>
In-Reply-To: <BY5PR12MB3763356FC8CD2A7B307BD9AAB0D8A@BY5PR12MB3763.namprd12.prod.outlook.com>
References: <20231015163047.20391-1-ankita@nvidia.com>
        <20231017165437.69a84f0c.alex.williamson@redhat.com>
        <BY5PR12MB3763356FC8CD2A7B307BD9AAB0D8A@BY5PR12MB3763.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2023 12:48:22 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:

> > After looking at Yishai's virtio-vfio-pci driver where BAR0 is emulated
> > as an IO Port BAR, it occurs to me that there's no config space
> > emulation of BAR2 (or BAR3) here.=C2=A0 Doesn't this mean that QEMU reg=
isters
> > the BAR as 32-bit, non-prefetchable?=C2=A0 ie. VFIOBAR.type & .mem64 are
> > wrong? =20
>=20
> Maybe I didn't understand the question, but the PCI config space read/wri=
te
> would still be handled by vfio_pci_core_read/write() which returns the
> appropriate flags. I have checked that the device BARs are 64b and
> prefetchable in the VM.

vfio_pci_core_read/write() accesses the physical device, which doesn't
implement BAR2.  Why would an unimplemented BAR2 on the physical device
report 64-bit, prefetchable?

QEMU records VFIOBAR.type and .mem64 from reading the BAR register in
vfio_bar_prepare() and passes this type to pci_register_bar() in
vfio_bar_register().  Without an implementation of a config space read
op in the variant driver and with no physical implementation of BAR2 on
the device, I don't see how we get correct values in these fields.

> > We also need to decide how strictly variant drivers need to emulate
> > vfio_pci_config_rw with respect to BAR sizing, where the core code
> > provides emulation of sizing and Yishai's virtio driver only emulates
> > the IO port indicator bit. =20
>=20
> Sorry, it isn't clear to me how would resizable BAR is applicable in this
> variant driver as the BAR represents the device memory. Should we be
> exposing such feature as unsupported for this variant driver?

Bar SIZING, not resizing.  This is the standard in-band mechanism for
determining the BAR size as described in PCIe 6.0.1, 7.5.1.2.1.  QEMU
makes use of the region size but does rely on the BAR flags when
registering the BAR into QEMU as described above.  Additionally,
vfio-pci-core supports this in-band sizing mechanism for physical BARs.
A variant driver which does not implement config space BAR sizing for a
virtual BAR is arguably not presenting a PCI compatible config space
where a non-QEMU userspace may depend on standard PCI behavior here.
Thanks,

Alex

