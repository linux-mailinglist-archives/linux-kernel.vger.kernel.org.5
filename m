Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEF3778049
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbjHJSd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjHJSd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:33:57 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED8E26BA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:33:57 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-4475af775c7so511134137.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691692436; x=1692297236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iS/Prf0uZRyER4yw6CK3K10VBvAKS1eThkp8nNBAT68=;
        b=evGcRu2+HFFc2q2yBwYT9DIUAlzZW+04mOxnRs9oVvmlPKMpjtg/akgaGFTNGRCezC
         owS2PQrvYXD+j13HL4urjHZ7ZJ4+C2k42UBCaI2UPqzwrvpPonW8atuasa3oSK3hbi8j
         u9RK1G8Rex5ZMehuNcbXcxtDnAqzqNUXHloN5u/XdOGTZ0v8DL6vdpRB62CAx88hboYW
         txx0gUDWWOI73nAQKbrhFlB/kdSUsqSGQzTcvT5tBW0yxfks0Fjd4RKeHjbzgw/RNX0Y
         wsrZInZZ2Ot5wCzJ56OuaTqTAgZsWGUyQ0yGsfXVgN1PrEMbwz64IjD88ovrOi0UJffQ
         C8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691692436; x=1692297236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iS/Prf0uZRyER4yw6CK3K10VBvAKS1eThkp8nNBAT68=;
        b=i8QOv94g54y12i5LiF4FN9qm887OWzaiRHTZfhgCUnTVra3rLw44d27BKl6XmnRCSk
         nh6AV8N6OiAXA9VrISH7F7D2HxS21+noniZRaiRU+F98BjI4hCJcti2qZsPQcbFqVDmo
         Fk1sZqxb26kvWxCCwJwKKz2NLCdEIgr/LpqqCPunsxfn2ew4FFHSxOtvmoC1UT16fPSo
         k7p7NKxHtl2vULZ2/abSdBnYtwtU0p58Z2HFnLr1C9wV2pBQ74QqI9TTGqhUUWs0+2OJ
         tw5VxSQWsvg0uL8olI2EhxRJCbtL2OU+bpUmDp8qlrgNOOOGhZjZHmAlxFeJRWsfDdVa
         F0cQ==
X-Gm-Message-State: AOJu0Yw675xD+HlxArNLjgKHp/Douxx5TW/X0V5ulsy0Viv1BOW6VZy5
        rUX+f3pxhG+dClefAheuU0vy+Dbja7uozGc96hc=
X-Google-Smtp-Source: AGHT+IFs5Jon13TN7iGbJbDF1FdmsGHcDUJAFFT9T2ikHmRv3TZExjSqIKY5whXUkeFcw4V6VqgS/w==
X-Received: by 2002:a67:db95:0:b0:447:4520:43b1 with SMTP id f21-20020a67db95000000b00447452043b1mr2680208vsk.7.1691692436396;
        Thu, 10 Aug 2023 11:33:56 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id p14-20020a0ccb8e000000b0063d245c00b5sm669270qvk.0.2023.08.10.11.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 11:33:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qUATq-005IHE-95;
        Thu, 10 Aug 2023 15:33:54 -0300
Date:   Thu, 10 Aug 2023 15:33:54 -0300
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
Subject: Re: [PATCH v2 04/12] iommu: Replace device fault handler with
 iommu_queue_iopf()
Message-ID: <ZNUtkjRhi5c/W8pD@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-5-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727054837.147050-5-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 01:48:29PM +0800, Lu Baolu wrote:
> The individual iommu drivers report iommu faults by calling
> iommu_report_device_fault(), where a pre-registered device fault handler
> is called to route the fault to another fault handler installed on the
> corresponding iommu domain.
> 
> The pre-registered device fault handler is static and won't be dynamic
> as the fault handler is eventually per iommu domain. Replace calling
> device fault handler with iommu_queue_iopf().
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4352a149a935..00309f66153b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1381,7 +1381,7 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
>  		mutex_unlock(&fparam->lock);
>  	}
>  
> -	ret = fparam->handler(&evt->fault, fparam->data);
> +	ret = iommu_queue_iopf(&evt->fault, dev);

Also fix the function signature at this point:

int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)

It should not be 'void *cookie' anymore, it is just 'struct device *dev'

Jason
