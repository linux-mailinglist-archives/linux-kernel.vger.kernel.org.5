Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B641F7FE13C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjK2Ukk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjK2Ukj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:40:39 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CC3D6E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:40:44 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6ce322b62aeso150325a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701290444; x=1701895244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i4is+UaFXgNmfUwcjSjgaiG0RVAiB9ug48COJL1kEfc=;
        b=FPRXhtOrAV5xg2ep6+npC90ZSnpQalIGR2w53QMKa3XLO/hG0KmMCeIAEJYG9nBJWa
         /XyyUlxnf8qxAxQaWmKVhby4s5m9Ta/R4x8QhtH8YfdNzl+p6aeapMOLXIPz8RLo/pjh
         IOpI2VD/QnYVyMPPrxjtdK9wv8Otlic/ctIvKNQMpTzekcCTjVogfQF4jR5thhHXsjCs
         XONtlIfvzyaZj/K/WAsdq3tTQWkbny+MdS0Xc+CJBzPOQ/LHxjv7V0aeigbx0nYcDG9u
         Gawbifm5xn+KRSCUaJc1fnk6/rBRvV8nKVVLyaEi4QZnJFHIJEs+ftWuSwbPhkVly6xB
         Ux/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701290444; x=1701895244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4is+UaFXgNmfUwcjSjgaiG0RVAiB9ug48COJL1kEfc=;
        b=dN8vtvpEdV48ZDr6LWRrKYrTHzydt5mycSQNVLGtpbsz9rAL33jR27N4rY1YbhYYD0
         y13XdQFscxcrtaEMWVCJ9AwF6fC3LeV1k4OnwUfufOwKZ8yHS8lJ2djrhOMwwID9ExRT
         V6f8nj47bBxKlqDlLanzF8AYIfpIXyt4S3xHwJ02fLsdsQVcRQN4/Yv2LnAvpakwdzLf
         5f7CH2Y+C/bVHhjW6OuElVa/PbDsSXAL1tdH8DNzX4NLW6TrepQhJRVgqWKP5vzpu/sP
         Hn1v3OtO1TFp1JrWHR7J5geNk/I54+Yo09h053v+Pm65NMOJ5FMr/LP34oTIWbDlSjek
         qS5g==
X-Gm-Message-State: AOJu0Yz5qwQwBKVe6F7jucNAbcxi3uQ/chFqjXU2+8Zr+xEChLNiAgbV
        Ge6ZO9bmcjisGQm6Entdh+XQLg==
X-Google-Smtp-Source: AGHT+IEnrq+40pWqc9tikvXUqS6Y6R2hs7giuPFXyADBt3dDnfao9L3w+T91fxfG4h2rkEvYDjFXYw==
X-Received: by 2002:a05:6830:1d41:b0:6d6:3ff8:aab7 with SMTP id p1-20020a0568301d4100b006d63ff8aab7mr19895331oth.1.1701290444152;
        Wed, 29 Nov 2023 12:40:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id e11-20020a9d560b000000b006d3161e612dsm2113398oti.30.2023.11.29.12.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:40:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r8RMQ-005pfu-R5;
        Wed, 29 Nov 2023 16:40:42 -0400
Date:   Wed, 29 Nov 2023 16:40:42 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/7] dma-mapping: Add helpers for dma_range_map bounds
Message-ID: <20231129204042.GP1312390@ziepe.ca>
References: <cover.1701268753.git.robin.murphy@arm.com>
 <b6626985d97ddc33a23b4b9fafa881b35001547e.1701268753.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6626985d97ddc33a23b4b9fafa881b35001547e.1701268753.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 05:43:01PM +0000, Robin Murphy wrote:
> Several places want to compute the lower and/or upper bounds of a
> dma_range_map, so let's factor that out into reusable helpers.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/loongarch/kernel/dma.c |  9 ++-------
>  drivers/acpi/arm64/dma.c    |  8 +-------
>  drivers/of/device.c         | 11 ++---------
>  include/linux/dma-direct.h  | 18 ++++++++++++++++++
>  4 files changed, 23 insertions(+), 23 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
