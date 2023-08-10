Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160D777801F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjHJSUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjHJSUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:20:10 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DC61982
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:20:10 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4103393a459so3183901cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691691609; x=1692296409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AXmx+3wOCZyKtOJ9UV8BupnM6hUAbNraEzN8cHZ1GF4=;
        b=E1ARSMdxCkr4+jcHFhO8dLLVCyuveqJnD1w4IRmhOVHRAt89TlOie5lu4GnI/SDppL
         eypA8Fb0zr9/R3D9nLVm26wl8Ms2xoZxj8hbX9HsaoRnL7D7ivQZyyzb2IgoV60yTa1I
         SmH+wJpfY8XS0GAF9H6BSjD4fn++6WcNcTNhKru1rrAI5BhB3VsHZ1BZjTHeGm/RLbxN
         K4c9Y/asghJG7cSWo9KiSMhvQ7b0SJkF7FVt9bWpZwZGx4/hi/dUg7konG4QNbRhfXx7
         tFQZ3KEa5Aiv/0xcK3vBBymfrPSwVqOQ6yGzvaQ8BaAotL9niirPiN8pjWuP3GsT/q3g
         OqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691691609; x=1692296409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXmx+3wOCZyKtOJ9UV8BupnM6hUAbNraEzN8cHZ1GF4=;
        b=OlZukA1ihTcFnUo5Ann0AkMm00PXOopJUprGh01ctJ4SIqf68P/RMzXlREZfKuTlkj
         zflDbFKn+w3WzSPL5OxAkS/g2f4o+wTtZ5kpk+NqhKq4T7id10blZ+pEUAmq3ZeUBpJV
         HN2kD69WqWAn0fa6qVrIFadw8FcE1DIS+S8WZMMwNRZUJj7JMH1aZeI5iYC4ZeFOMfBI
         5XYxZLDBtDkK0UAToLh4JQbu5lLKFkHKcJ0puP5uILGKm1IGZRd8crVxu8Xd/w35CNK3
         q2ulOs+K0E3Bwpcky5DO1uv2eT7OYMofu3zEIeY8DF0tumZvOWv386S9rGV+t06J8d52
         y6vA==
X-Gm-Message-State: AOJu0Yw88R0cs31/TKAOwv4yIIgegzGIMubbyQwWlbgxbdGrTilPZko7
        sxpzHYNtMMwgZCjF4M3fdxwJeA==
X-Google-Smtp-Source: AGHT+IGM/hUoXEwYhGIeNdIi+ksUWiqdR7FvNX1iIrgGhPeHR+9PMnIfVbvj2S3TUzJyh2+51QHwww==
X-Received: by 2002:a0c:cc0e:0:b0:63d:a05:256a with SMTP id r14-20020a0ccc0e000000b0063d0a05256amr2792632qvk.8.1691691609165;
        Thu, 10 Aug 2023 11:20:09 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id i5-20020a05620a074500b00767f00a9c67sm658732qki.95.2023.08.10.11.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 11:20:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qUAGV-005Hsi-57;
        Thu, 10 Aug 2023 15:20:07 -0300
Date:   Thu, 10 Aug 2023 15:20:07 -0300
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
Subject: Re: [PATCH v2 06/12] iommu: Make dev->fault_param static
Message-ID: <ZNUqV5Mte2AsVa1L@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-7-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727054837.147050-7-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 01:48:31PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4ba3bb692993..3e4ff984aa85 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -302,7 +302,15 @@ static int dev_iommu_get(struct device *dev)
>  		return -ENOMEM;
>  
>  	mutex_init(&param->lock);
> +	param->fault_param = kzalloc(sizeof(*param->fault_param), GFP_KERNEL);
> +	if (!param->fault_param) {
> +		kfree(param);
> +		return -ENOMEM;
> +	}
> +	mutex_init(&param->fault_param->lock);
> +	INIT_LIST_HEAD(&param->fault_param->faults);
>  	dev->iommu = param;

This allocation seems pointless?

If we always allocate the fault param then just don't make it a
pointer in the first place.

The appeal of allocation would be to save a few bytes in the common
case that the driver doesn't support faulting.

Which means the driver needs to make some call to enable faulting for
a device. In this case I'd continue to lazy free on release like this
patch does.

Jason
