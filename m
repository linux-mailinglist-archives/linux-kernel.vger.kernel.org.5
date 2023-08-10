Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8F877810C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbjHJTJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbjHJTJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:09:06 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0384E2713
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:09:06 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-63d0d38ff97so5997336d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691694545; x=1692299345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OBsV6+ts68b3MCiRcACqm+YmuoRBitbyDh+1vB9eOfo=;
        b=COIcEt0fqX73UeUlZllLXQvgTUm3SxDi7CEN7pJgTWDiV+EDp5lJjGdEZeRwUo8ba7
         PXaBP/ouioLF1NT142OLFuwkskZeDbXO8am2iRGaWKue9antxAodqBhuD/TywtShnwKD
         EGXqkqzWvQkbkbBw8ZPH3qHUIhOe/Z0FBdAvip6DPUp9uImmcB6DzdEwjuuqM4o5+eRk
         6i+/8cV93o0QKwhzUWti9awORJDqxqI09xY3Vnp8k7T2mOEdS8GrO2BaWkkmPvmXPR1F
         vjigqQ/CjxJhRXstDjJ8WoCVpCjWxVK9jAQ0airFucBdnmarCSvz80ZZGhCT3+IBIIPh
         TODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691694545; x=1692299345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBsV6+ts68b3MCiRcACqm+YmuoRBitbyDh+1vB9eOfo=;
        b=MiTAy+by1CpR+HO0krrx1wL/EuwwFUYdNtrFngsQLLatXIfFFCxspCAN/HtsAJDoYz
         6BSh07T5vXdXq1V8iOBd5xJgcF6KIO1cjEQmA/TgteH86wfdWfIvYubzScTdoODADDse
         HkGmkLxJTjB0CUtkphxUoPlHK9c4/Bvf40h6xqFHbnUgzZ7LpKcxYpqNULMUi8bQcDY0
         xTAo4l7UWdpWZB/Yfm+veCzk9NijODdKVf9O4i+22g1qr0iPIqpbYTxjKK5bR1UnMBEm
         rkwGweJMqfbHk+DcmlSn7Rd4wSkEXBKtNUBmvI3vYFvovFJi98DskEA3+/RRIOTdEkgF
         UFFg==
X-Gm-Message-State: AOJu0YzSsPha0OD8taHtuWdHmHraBOjWDCIfXW37zT70LMOgdjYQlilJ
        JVvP+42AvdrWmLDtaMKoBcXiLA==
X-Google-Smtp-Source: AGHT+IGbRBMB1G0DgtrN1Ti5jWBuKV+GQrt2F3rx7SFZCKQn9VB73jXia/E3+tJJ4ZW9NFFbohJcag==
X-Received: by 2002:a0c:f04c:0:b0:635:ea31:521a with SMTP id b12-20020a0cf04c000000b00635ea31521amr3605192qvl.7.1691694545156;
        Thu, 10 Aug 2023 12:09:05 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id l17-20020a0ce091000000b0061b5dbf1994sm659891qvk.146.2023.08.10.12.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 12:09:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qUB1r-005IlP-2Y;
        Thu, 10 Aug 2023 16:09:03 -0300
Date:   Thu, 10 Aug 2023 16:09:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/12] iommu: Separate SVA and IOPF in Makefile and
 Kconfig
Message-ID: <ZNU1zw1PDs6z9nv4@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-12-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727054837.147050-12-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 01:48:36PM +0800, Lu Baolu wrote:
> Add CONFIG_IOMMU_IOPF for page fault handling framework and select it
> from its real consumer. Move iopf function declaration from iommu-sva.h
> to iommu.h and remove iommu-sva.h as it's empty now.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h                         | 63 +++++++++++++++
>  drivers/iommu/iommu-sva.h                     | 80 -------------------
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  1 -
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  1 -
>  drivers/iommu/intel/iommu.c                   |  1 -
>  drivers/iommu/intel/svm.c                     |  1 -
>  drivers/iommu/iommu-sva.c                     |  3 +-
>  drivers/iommu/iommu.c                         |  2 -
>  drivers/iommu/Kconfig                         |  4 +
>  drivers/iommu/Makefile                        |  3 +-
>  drivers/iommu/intel/Kconfig                   |  1 +
>  11 files changed, 71 insertions(+), 89 deletions(-)
>  delete mode 100644 drivers/iommu/iommu-sva.h

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

At some point it would be a nice touch to split iommu.h into the
consumer and iommu driver interfaces

Jason
