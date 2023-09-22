Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE94C7AB3ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjIVOly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjIVOle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:41:34 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3E6CD7;
        Fri, 22 Sep 2023 07:41:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id BF90341EF0;
        Fri, 22 Sep 2023 14:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1695393686; bh=lDhC+n6ls99EOxSEkF04q5kIJM1xdvRrM1BoHUoxzoE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=lCVyEpNKQCiOkwKuzEN7YClEr0FV8ee6fdpIoePu3wqo/BR8OYcIxVrlzVg4qKhcZ
         a+GZVHrQlbyWrxHoNQPd/nEn29qcX3iJBl4vFvA94HqjSirm18rNXwsYFEAVRhcYDT
         lzlioitv43db755lYVTG1TMvqwa1rRMN5TLTSSLVksCdDR7g8xMunzi32UpR6Jl5Hp
         7Iu/lHT25QI0iLFzhP0mHpIpQslyQ9XmmV8lobjqgeefXihivo7DMhZ/n1Zvqo9s9f
         XDIDcnV0k4wwslzsNRxZZHN0Fyjqm2JB7aOazFhacD+/2Ue5fOdmrqDodqzCjxtJFJ
         kHmXoAW0zU1vw==
Message-ID: <f8b9079f-8ba8-080a-9cbe-6a9fc6530172@marcan.st>
Date:   Fri, 22 Sep 2023 23:41:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH REGRESSION] iommu: Only allocate FQ domains for IOMMUs
 that support them
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Joerg Roedel <jroedel@suse.de>, Neal Gompa <neal@gompa.dev>,
        "Justin M. Forbes" <jforbes@fedoraproject.org>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, stable@vger.kernel.org,
        regressions@lists.linux.dev
References: <20230922-iommu-type-regression-v1-1-1ed3825b2c38@marcan.st>
 <2ea199a1-d20d-2fde-d1bd-76ecad14a68d@arm.com>
Content-Language: en-US
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <2ea199a1-d20d-2fde-d1bd-76ecad14a68d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2023 23.21, Robin Murphy wrote:
> On 22/09/2023 2:40 pm, Hector Martin wrote:
>> Commit a4fdd9762272 ("iommu: Use flush queue capability") hid the
>> IOMMU_DOMAIN_DMA_FQ domain type from domain allocation. A check was
>> introduced in iommu_dma_init_domain() to fall back if not supported, but
>> this check runs too late: by that point, devices have been attached to
>> the IOMMU, and the IOMMU driver might not expect FQ domains at
>> ops->attach_dev() time.
>>
>> Ensure that we immediately clamp FQ domains to plain DMA if not
>> supported by the driver at device attach time, not later.
>>
>> This regressed apple-dart in v6.5.
> 
> Apologies, I missed that apple-dart was doing something unusual here. 
> However, could we just fix that directly instead?
> 
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 2082081402d3..0b8927508427 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -671,8 +671,7 @@ static int apple_dart_attach_dev(struct iommu_domain 
> *domain,
>   		return ret;
> 
>   	switch (domain->type) {
> -	case IOMMU_DOMAIN_DMA:
> -	case IOMMU_DOMAIN_UNMANAGED:
> +	default:
>   		ret = apple_dart_domain_add_streams(dart_domain, cfg);
>   		if (ret)
>   			return ret;
> 
> 
> That's pretty much where we're headed with the domain_alloc_paging 
> redesign anyway - at the driver level, operations on a paging domain 
> should not need to know about the higher-level usage intent of that 
> domain. Ideally, blocking and identity domains should have their own 
> distinct ops now as well, but that might be a bit too big a change for 
> an immediate fix here.

Sure, but it sounded like if there's a capability for this the core
should probably use it and not expose the type at all to drivers that
can't support it :)

If you think defaulting to that branch in DART is correctly future-proof
I can make that change. It's not the only driver checking the domain
type in attach_dev(), but it might be the only one enumerating all the
options instead of checking for specific cases only (e.g. intel checks
for IOMMU_DOMAIN_IDENTITY).

- Hector

