Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F907CEC30
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjJRXhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjJRXhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:37:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A7DB6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697672188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wwq4pN/s/i/zMbfkzPRCH3hAZNaKCKuiLB6gGgcmPE4=;
        b=NeqSbm79lHMVqtsJZPN9Np0ED2Qm5jMmwtBk4CgbIEa0/Wxg8pfxAmKgzHkhcStNoOHlDE
        zmaNvNW8+W4bPKq+Uv99YPCqtSEAuBGUQ1EKf5jXe9++5vLrgrpknFfnyx3Sx2xvEi0EiB
        AmVtzFPpt8X3c1VzPxvusadSjh/LNmg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-a6SJAMdfM66h7ABiJ1K0Ig-1; Wed, 18 Oct 2023 19:36:26 -0400
X-MC-Unique: a6SJAMdfM66h7ABiJ1K0Ig-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7789405320fso131335385a.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697672186; x=1698276986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwq4pN/s/i/zMbfkzPRCH3hAZNaKCKuiLB6gGgcmPE4=;
        b=gCZaUB474L1tw5UE3YmGkJre0RKokBdvkXQSTm2o/0LJxN0+7WucblQIdH35laRWcL
         3JVplxBARCOn2jVS+scxJUopPqmfaOxGArbmnKQ6G22FO3WIfRX3fWd2ofuBL5S/IMVI
         E+ZGRU5eK9vJE+9VEO0HZl4vHitkicPdkEqANwXEUVGYjnDtV1CTZ6HUgLLkxhRr2nrv
         XEdGG47H/sSWZ9GxW9ONi/D+ft5hU/u9fq7hmSWtfGFHcNus+mqmsUviRthykLL91qUT
         v4vwt71OdqP7RAMil5mNKAqUwx4qx1Grai5iVMOMwEHHW4qUsqGwGiG4I3umk4t6xuxR
         poOQ==
X-Gm-Message-State: AOJu0YxpKmgUNZQlb8VJKQlgNkc8/QbYEwD22KCkOyJO4hHma57bAxK/
        d3X2s9etbubHWw9eBGsMVRLG5cagXlT+g1OeKBS7N0FNAccTOElaGqlfPIv9b8+dLBt2Db7LI7n
        uAnaNKoLcLyslInSFlboq2ntV
X-Received: by 2002:a05:620a:469f:b0:776:fad0:cc3b with SMTP id bq31-20020a05620a469f00b00776fad0cc3bmr723756qkb.1.1697672186298;
        Wed, 18 Oct 2023 16:36:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPO7Vqth8t9yy/v3L0mG5MziEBsmxEMVxzKc33ywKWfOCVkngG2TzL+rbFxuOxZ3T5/4javQ==
X-Received: by 2002:a05:620a:469f:b0:776:fad0:cc3b with SMTP id bq31-20020a05620a469f00b00776fad0cc3bmr723743qkb.1.1697672186039;
        Wed, 18 Oct 2023 16:36:26 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id bl11-20020a05620a1a8b00b00773fe8971bbsm324650qkb.90.2023.10.18.16.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:36:25 -0700 (PDT)
Date:   Wed, 18 Oct 2023 16:36:24 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 6/7] iommu: Retire bus ops
Message-ID: <63s3zurkwuq66szkc6wnvzbh75d5vxek3fzzsxbufd4ytdnkke@2gnfjb3b6ufk>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <2411f20c801140b3cff37193ec2c08393a754997.1697047261.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2411f20c801140b3cff37193ec2c08393a754997.1697047261.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 07:14:53PM +0100, Robin Murphy wrote:
> With the rest of the API internals converted, it's time to finally
> tackle probe_device and how we bootstrap the per-device ops association
> to begin with. This ends up being disappointingly straightforward, since
> fwspec users are already doing it in order to find their of_xlate
> callback, and it works out that we can easily do the equivalent for
> other drivers too. Then shuffle the remaining awareness of iommu_ops
> into the couple of core headers that still need it, and breathe a sigh
> of relief.
> 
> Ding dong the bus ops are gone!
> 
> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> v4: Don't forget new reference in iommu_device_register_bus()
> ---
>  drivers/iommu/iommu.c       | 31 ++++++++++++++++++-------------
>  include/acpi/acpi_bus.h     |  2 ++
>  include/linux/device.h      |  1 -
>  include/linux/device/bus.h  |  5 -----
>  include/linux/dma-map-ops.h |  1 +
>  5 files changed, 21 insertions(+), 19 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

