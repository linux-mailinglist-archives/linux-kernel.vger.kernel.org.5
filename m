Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EA57FA89F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjK0SIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjK0SIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:08:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B15019A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701108535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pbaYTtWJWKS2KvLXYln8ZZMnxtzCOD7lAAgVJfHHtZo=;
        b=htlwdGbOXQLaAxrKRuQusqZtxcBRtETWbrcNzAj/MZp5Y5YDTD8Tk+0E7nNdDdZoSKFlvD
        lMnTI4jtOyfFlcUiWQWeuEcyZBkidK1oEEahdlM9zkh2gg8fi+SxpLN1wbaBdijaUt0gZM
        BDYemy+PgcqVie/SYEBVRJH8Ch5D5Og=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-WvY8aOIjNamJKnsiE4zOLQ-1; Mon, 27 Nov 2023 13:08:54 -0500
X-MC-Unique: WvY8aOIjNamJKnsiE4zOLQ-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1fa1efb292bso2936914fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:08:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701108533; x=1701713333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbaYTtWJWKS2KvLXYln8ZZMnxtzCOD7lAAgVJfHHtZo=;
        b=lgfx4OjxdYGFG6AzgIIEvrpbRL8R19O2XPV1ePUJZE+bG4WDG+SpUQ+LuCYc+mCI17
         6QM1vwK4SBVjqvGiUBmhgVU3p3ThMBhlc7C/4l58tDTbZjwfMd7AIR8MIaGqL4shM5Cb
         KQQXIi6f9EjkpkJdNj8iPw1HNHfTV+6Z6eFyjf5NS+yVk3uZMgOjE9Hca2bJvFnur+pK
         6BfCz6gRVFeZmZixDYbRT/pz41pwj1GM7jeNTYmtElW4euY5gVCa86rvwlg/JweV8sgI
         1ZkWIhvwEuGSfqX1n8CHSMFR/3qukoBx4HQUEsLsStmSIRdCNefghm1xeJfHps2SgXhY
         xBsA==
X-Gm-Message-State: AOJu0YxKLkGDQEFcFKMSoNtW1I2c9sZyvwpsHa62/JYhLNal15xAbMha
        vK5pt9VYwdxiKSzUmF+ryeXAH0dvgBkiiFN7NJPdm6bwU/tP9DCgJN8EBAXU4XbcRGp1BUTB1Kn
        r9mQBWKocOYRODaInYrKR5bWjUZWZJF3f
X-Received: by 2002:a05:6870:55c9:b0:1fa:25de:2f6b with SMTP id qk9-20020a05687055c900b001fa25de2f6bmr8707394oac.23.1701108533453;
        Mon, 27 Nov 2023 10:08:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRy9elN/20CfXFz7tM/XZvEAQYE1oTnRgPx0meubDa212Hw6esHglbJqNzyGPKQ8N6pOMFVg==
X-Received: by 2002:a05:6870:55c9:b0:1fa:25de:2f6b with SMTP id qk9-20020a05687055c900b001fa25de2f6bmr8707374oac.23.1701108533094;
        Mon, 27 Nov 2023 10:08:53 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id pu2-20020a0568709e8200b001fa38179d1bsm1039033oab.56.2023.11.27.10.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 10:08:52 -0800 (PST)
Date:   Mon, 27 Nov 2023 11:08:50 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Brett Creeley <brett.creeley@amd.com>
Cc:     <jgg@ziepe.ca>, <yishaih@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shannon.nelson@amd.com>
Subject: Re: [PATCH v4 vfio 0/2] vfio/pds: Fixes for locking bugs
Message-ID: <20231127110850.3e4f527a.alex.williamson@redhat.com>
In-Reply-To: <20231122192532.25791-1-brett.creeley@amd.com>
References: <20231122192532.25791-1-brett.creeley@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 11:25:30 -0800
Brett Creeley <brett.creeley@amd.com> wrote:

> This series contains fixes for locking bugs in the recently introduced
> pds-vfio-pci driver. There was an initial bug reported by Dan Carpenter
> at:
> 
> https://lore.kernel.org/kvm/1f9bc27b-3de9-4891-9687-ba2820c1b390@moroto.mountain/
> 
> However, more locking bugs were found when looking into the previously
> mentioned issue. So, all fixes are included in this series.
> 
> v4:
> - Drop patch 1/3 since it added a spinlock_init that was later replaced
>   by a mutex_init anyway
> 
> v3:
> https://lore.kernel.org/kvm/20231027223651.36047-1-brett.creeley@amd.com/
> - Change reset lock from spinlock to mutex
> 
> v2:
> https://lore.kernel.org/kvm/20231011230115.35719-1-brett.creeley@amd.com/
> - Trim the OOPs in the patch commit messages
> - Rework patch 3/3 to only unlock the spinlock once
> - Destroy the state_mutex in the driver specific vfio_device_ops.release
>   callback
> 
> v1:
> https://lore.kernel.org/kvm/20230914191540.54946-1-brett.creeley@amd.com/
> 
> Brett Creeley (2):
>   vfio/pds: Fix mutex lock->magic != lock warning
>   vfio/pds: Fix possible sleep while in atomic context
> 
>  drivers/vfio/pci/pds/pci_drv.c  |  4 ++--
>  drivers/vfio/pci/pds/vfio_dev.c | 30 +++++++++++++++++++++---------
>  drivers/vfio/pci/pds/vfio_dev.h |  2 +-
>  3 files changed, 24 insertions(+), 12 deletions(-)
> 

Applied to vfio for-linus branch for v6.7.  Thanks,

Alex

