Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2840E785A71
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbjHWO1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjHWO1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:27:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBF1E68
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692800773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xnEXzn2y3iDWlgY1h5P4oZRrvMRBGOGB2OSW0swrWlM=;
        b=Z0e6oVj5sVtpoSpwclOqaFBWe5XMYQT1oHCurv4xaIbDn8oUuVqtlHgh/pUbtJt+/AZqyg
        BFvK2/o9kmEV72VV2vAHoXrfL/53dY8eB/jhfeR98vO+Aft64gWHKhTRZTdlJKHuncZu1j
        NdIIZdtakXm4XLEtDuLmkV8napAiPMM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-yr3Uv9cYPQSVnm7evCdl8g-1; Wed, 23 Aug 2023 10:26:11 -0400
X-MC-Unique: yr3Uv9cYPQSVnm7evCdl8g-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-786a6443490so522027939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:26:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692800771; x=1693405571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnEXzn2y3iDWlgY1h5P4oZRrvMRBGOGB2OSW0swrWlM=;
        b=LjfF3Aj2raDiNg9JqE7z02HnDErbLijgKRcJmeOrvPYKlxHC8+JFDp3d/W74pi53Gq
         Kb7/hrNfDqsGzt5Hu6gMDh8NKl4DUW2h6KVqcjOY685E9YnLgJIGJBQzSjhsOMyA5VjK
         w9CVcQrnTjyHWQb0Ep9xsx6sJhenckq6JkfiHi8Our38/UxuLkgZc1Y8aACa9np/4z6T
         Q8ECMQeI3jZZvwQGUZhB6MlGtMMA20p3wTiI6lhWAmQU/A/Sm9YIZRnwEO8jMEiAM1X9
         5ol7dDULL3xlP/870x7w+Bs3za4E0uXgy5nIEWyFLKNAtYNcBZ0tYBxMBL+0PbkQ62Zm
         u/Jg==
X-Gm-Message-State: AOJu0YzVS9MGVNx/QUXAn3Vkj8tVSS05oJQOZ2Jk7OGw88RuScpoB4xR
        o8Q+x5a+bSKcNhGyU8+4J7H8KvR+CGM+yTj17etRvmvpx9H3YS/02rcYLBy7py9mjjhgdSNT64M
        iPL+jyBDLsHkutYvWMsY1BB0F
X-Received: by 2002:a6b:720b:0:b0:787:8d2:e0c with SMTP id n11-20020a6b720b000000b0078708d20e0cmr3146128ioc.12.1692800770863;
        Wed, 23 Aug 2023 07:26:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF01ICWqFHwLoVEr+m4RVo7T8U8PPG+t9CKdbKB3dT5STz1Cr0meVQgpxup5diHeDwWcJElIw==
X-Received: by 2002:a6b:720b:0:b0:787:8d2:e0c with SMTP id n11-20020a6b720b000000b0078708d20e0cmr3146112ioc.12.1692800770642;
        Wed, 23 Aug 2023 07:26:10 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id eq8-20020a0566384e2800b0042b4437d857sm3872718jab.106.2023.08.23.07.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:26:10 -0700 (PDT)
Date:   Wed, 23 Aug 2023 08:26:08 -0600
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
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/1] vfio/nvgpu: Add vfio pci variant module for
 grace hopper
Message-ID: <20230823082608.2867b73e.alex.williamson@redhat.com>
In-Reply-To: <BY5PR12MB37635FB280AECC6A4CF59431B01CA@BY5PR12MB3763.namprd12.prod.outlook.com>
References: <20230822202303.19661-1-ankita@nvidia.com>
        <ZOYP92q1mDQgwnc9@nvidia.com>
        <BY5PR12MB37635FB280AECC6A4CF59431B01CA@BY5PR12MB3763.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2023 14:18:52 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:

> >> +
> >> +     /*
> >> +      * Handle read on the BAR2 region. Map to the target device memory
> >> +      * physical address and copy to the request read buffer.
> >> +      */
> >> +     if (copy_to_user(buf, (u8 *)addr + offset, read_count))
> >> +             return -EFAULT;  
> >
> > Just to verify, does this memory allow access of arbitrary alignment
> > and size?  
> 
> Please correct me if I'm wrong, but based on following gdb dump data on
> the corresponding MemoryRegion->ops, unaligned access isn't supported, and
> a read of size upto 8 may be done. 
> 
> (gdb) p/x *(mr->ops)
> $7 = {read = 0xaaab5e0b1c50, write = 0xaaab5e0b1a50, read_with_attrs = 0x0, write_with_attrs = 0x0,
>   endianness = 0x2, valid = {min_access_size = 0x1, max_access_size = 0x8, unaligned = 0x0, accepts = 0x0},
>   impl = {min_access_size = 0x1, max_access_size = 0x8, unaligned = 0x0}}

This is QEMU policy relative to this region, the kernel interface is
not exclusive to QEMU usage.  Thanks,

Alex

