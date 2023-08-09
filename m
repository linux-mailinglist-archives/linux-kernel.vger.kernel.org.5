Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7757765D6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjHIQ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjHIQ7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:59:45 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86341BFE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:59:44 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bca3588edbso23437a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 09:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691600384; x=1692205184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XTEsQP1+0iumF877RP4qQLHej8hsu/9BpYuUN5Y2adY=;
        b=JzlC8Zw9WKivJVxz26FYwqB80WVfFZ6RDiS980y67gmTTNuF7ER+yz08CPVwASwoZM
         gKYV7BCMOa6zNvbbVCtWaxGDgfUkQ9qJmez94gYiktjPGpOmDjgkfsHiHTTFp/8xFTtf
         DlOmv8AX5zaHS9ih6o9Q7j0FIxPpPFcT2fnBsU92+V4kJRCVEuLVp/fzvl2N0bIbpxi6
         SuCTNor5R/pwn+u0oZ2YrCPUsrqYNzRV60a1T/LCyNBE3osy8HyYLEJM9ZV1+buUemOe
         avfBcqa5N4koDm2vxcyUqsSN8QgDCc9kjJFkgFvPN3JjT8qwQuRMo89sT9Pij82iX2I+
         3NtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600384; x=1692205184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTEsQP1+0iumF877RP4qQLHej8hsu/9BpYuUN5Y2adY=;
        b=OK1Q4jMSbLtBv9/R4lRVhDMoUsAVMd1gymwijMsq7THm0MTWlmsVteL5zIyWaEeLBK
         4KOLYfOUKVuG1DnVgFetncU304rygsoBt0AS8njibiY7ao5fTHIZ+akMyzwy0FW5R/Sl
         vOO7VvSvVD2PgKRyowku5hv+5rKpNoVKgbtFOtS9HaYTOK4kWMcwI7mYWog8v9HLLs84
         lDDsMFoiEk8phPJlV8hqMx84+eurEjp3Hrp4tPWebxofow75ekUHXxASDpqj6Xf8d5QT
         zniYaCfB7SmQj69gFJvRHyBwTs9xJ0/NEm6HjndK/7raH6VXG766CORs2r5MJYVlVMOX
         R96g==
X-Gm-Message-State: AOJu0Yyru1RGZBlwJseC8RUkXb+yMm5UA0sz/lsPLwKQfhsXIwud+0OG
        akkaIO3ruJF0VE/5cfOzyPKWpQ==
X-Google-Smtp-Source: AGHT+IEmzHenOJPDunw1cOZQzJjOj5rapAsmFJV0dYT4pA3Ve+ScUpS7lPR4AvRR0PMTnE+Xw/oiqw==
X-Received: by 2002:a05:6358:c18:b0:139:71af:ed0f with SMTP id f24-20020a0563580c1800b0013971afed0fmr2197432rwj.1.1691600384122;
        Wed, 09 Aug 2023 09:59:44 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id f6-20020ac81346000000b0040f200feb4fsm4152679qtj.80.2023.08.09.09.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:59:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qTmX8-00551w-Uh;
        Wed, 09 Aug 2023 13:59:42 -0300
Date:   Wed, 9 Aug 2023 13:59:42 -0300
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
Subject: Re: [PATCH v2 03/12] iommu: Remove unrecoverable fault data
Message-ID: <ZNPF/nA2JdqHMM10@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-4-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727054837.147050-4-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 01:48:28PM +0800, Lu Baolu wrote:
> The unrecoverable fault data is not used anywhere. Remove it to avoid
> dead code.
> 
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h | 70 +------------------------------------------
>  1 file changed, 1 insertion(+), 69 deletions(-)

Do we plan to bring this back in some form? A driver specific fault
report via iommufd?

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
