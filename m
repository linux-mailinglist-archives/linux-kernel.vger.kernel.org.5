Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1CF7A26C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbjIOTAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbjIOS7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:59:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7F5D106
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694804341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ghzt0gMUW66V7NRyUGXJr6A3y8erfYE/z3VgzfOC+I0=;
        b=C7+hsTRCKZKzJFP7og6zFqkkCxVUrxi1zvFE/odTGGpnOSXDNcw2o1T0xabConRxmxZQCJ
        ejzVJ3u1+6AjWacjS24FfyyAUF+IJRuOgdkqn3E6nIt62Vc1TbBB3K2KqFlFZcnakJ2YJ8
        Rab6xI2qh3SZcjaAzwN2I3rYveNg+h0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-7PqY9IbOP9mVttjBgF8OOA-1; Fri, 15 Sep 2023 14:59:00 -0400
X-MC-Unique: 7PqY9IbOP9mVttjBgF8OOA-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7983537d6c1so216450239f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 11:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694804339; x=1695409139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ghzt0gMUW66V7NRyUGXJr6A3y8erfYE/z3VgzfOC+I0=;
        b=uUJOzfIMv3uT9AK+cDB3lH1zAQLophn3n6Lv2cIFdRVvsFWviaEhUlfFMkFgicRUAc
         IA9Gz1gfxF/9n1NMlhEbXL2sfparHaDRqn8wEMWsf7RsBVGoh5RnBtDJPB6oDYWdB68r
         O3WjMKYbDzkSsbarnAPBozSV+OH39L6Fw+NnQv2h2MlXdqLtaqBDSe7qRynw/3NJEE2w
         zN6SL0JbH13/pEgUJJa5PmyI/9ohqCorEPuZyXWLtvK4orcL8ElcaFjDWZtV+BLprh3i
         1EuJkrc82GGTj9FVYArbFiURQ5y35uE6NBeW/ZjNeIYa7az5fjOElqrUg3+w0liV1KIA
         s2Tg==
X-Gm-Message-State: AOJu0Yzm79WnIgWdZqW62ynVstj78UL+vDKgJG3PAfbJhOKl+47/ToNN
        hlbb4QVMI44vFTpwa41aWnxazBLYwqlOQ6wEKIdePoOVag1T7kMetyLnT9BVF5WdG76ZCwkxCW7
        UOBdClpK03h7iO6ZR2IFFs1kP
X-Received: by 2002:a92:6e11:0:b0:348:f4c1:4817 with SMTP id j17-20020a926e11000000b00348f4c14817mr2860638ilc.6.1694804339642;
        Fri, 15 Sep 2023 11:58:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/9dB1xKUUwpY6U9DzMEfcWwczlL+tvIN6z3KHXC0qPn5dpdT5/w5R10+8v2kZCO5wv48MFw==
X-Received: by 2002:a92:6e11:0:b0:348:f4c1:4817 with SMTP id j17-20020a926e11000000b00348f4c14817mr2860624ilc.6.1694804339412;
        Fri, 15 Sep 2023 11:58:59 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id l12-20020a056e020dcc00b0034f3220c086sm500944ilj.12.2023.09.15.11.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 11:58:58 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:58:58 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     oushixiong <oushixiong@kylinos.cn>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Brett Creeley <brett.creeley@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio/pds: Use proper PF device access helper
Message-ID: <20230915125858.72b75a16.alex.williamson@redhat.com>
In-Reply-To: <20230914021332.1929155-1-oushixiong@kylinos.cn>
References: <20230914021332.1929155-1-oushixiong@kylinos.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023 10:13:32 +0800
oushixiong <oushixiong@kylinos.cn> wrote:

> From: Shixiong Ou <oushixiong@kylinos.cn>
> 
> The pci_physfn() helper exists to support cases where the physfn
> field may not be compiled into the pci_dev structure. We've
> declared this driver dependent on PCI_IOV to avoid this problem,
> but regardless we should follow the precedent not to access this
> field directly.
> 
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
> 
> This patch changes the subject line and commit log, and the previous 
> patch's links is:
> 	https://patchwork.kernel.org/project/kvm/patch/20230911080828.635184-1-oushixiong@kylinos.cn/

Kevin & Jason,

I assume your R-b's apply to this version as well.  Thanks,

Alex

> 
>  drivers/vfio/pci/pds/vfio_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/pds/vfio_dev.c b/drivers/vfio/pci/pds/vfio_dev.c
> index b46174f5eb09..649b18ee394b 100644
> --- a/drivers/vfio/pci/pds/vfio_dev.c
> +++ b/drivers/vfio/pci/pds/vfio_dev.c
> @@ -162,7 +162,7 @@ static int pds_vfio_init_device(struct vfio_device *vdev)
>  	pci_id = PCI_DEVID(pdev->bus->number, pdev->devfn);
>  	dev_dbg(&pdev->dev,
>  		"%s: PF %#04x VF %#04x vf_id %d domain %d pds_vfio %p\n",
> -		__func__, pci_dev_id(pdev->physfn), pci_id, vf_id,
> +		__func__, pci_dev_id(pci_physfn(pdev)), pci_id, vf_id,
>  		pci_domain_nr(pdev->bus), pds_vfio);
>  
>  	return 0;

