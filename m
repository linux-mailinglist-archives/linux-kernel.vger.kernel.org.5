Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6607FE519
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 01:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343802AbjK3AqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 19:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjK3AqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 19:46:00 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECFDD54
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 16:46:05 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1f9e0e44fecso168272fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 16:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701305165; x=1701909965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DGfesKWk6hIGgQDOksuxdOXdV/4i0gK7DjvWJInD9Kc=;
        b=TGmOsoongOJ3mRPh4D7y7BkjcC+Ovj+n8PtFRQ5xqzhbN6VxHK1FYnmCON6QSr1KrS
         YHDqY7Ux1uRrcyuQF8GIbPifdXJriHEkq0awWaZJvwFPB2KJc1hgqhB9i3dretRTqaK+
         fv8XVoDFy7vPm1MQRjreU2JAQbgzEhfWbhfoAYIF4prP1euOnnbZ1i43DkEhaiseCCid
         pGk+EP4XiHzMfE6K8D4Nfv44zVAHM+2NEea5duFO59VyeKGP9yucR71saRuDwllsa5Fx
         Dxhe+GOb2B3Hhk5jytTjcAaHg9/b+vqs0AcwJR2sOnaPvhKAVBTfQH0PhZMDYnPd2uc8
         j6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701305165; x=1701909965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGfesKWk6hIGgQDOksuxdOXdV/4i0gK7DjvWJInD9Kc=;
        b=KZjZ6CfdV7RSevXJ46kRApAMdGbSVvACap1YNNeEwPa+C+kAWkfD9/WQrCt6z1hw/v
         t8LlnsIZx6SZ+V1gHYLYIa5dJaXXvKu2F2ntpQFCLoOvYW3Mz9FrPUgBj13o/SjhkgRe
         z2trJwuH8wGvMV62kEA+vxkS4yTRO2has57Qwhd4Hb0zEh10VYzQqPh7HvQJEoX2WG2H
         PQ0lckzXxcABenAFRCTHECRH6bNTKISY/x1nngDM5LNyvBMEXcm/GkeE3OXI9/LliFnA
         KHsprcCvB7RCaFbejbqyJ63Ua+CQrAZLO3FlajU3HhVz75pK5rgnjAf8Z07/vaYZYnMJ
         U/rg==
X-Gm-Message-State: AOJu0Yzly2RULr+Nzh7chaDuC3/QcGrKkVnoBmhtxAh/hVg9KqRJS+OI
        /IMFeLf4Ds2LBiOX5GfS7kb+9A==
X-Google-Smtp-Source: AGHT+IH0QnaZj4Srt21JiVw/aqbEQCLMM8IUp7yXueL4iz88oaZRnRpsZVc5esr77Xqw2FDtMOcfOA==
X-Received: by 2002:a05:6870:3326:b0:1fa:2b51:cc8b with SMTP id x38-20020a056870332600b001fa2b51cc8bmr18739526oae.32.1701305164620;
        Wed, 29 Nov 2023 16:46:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id mn13-20020a0568700c8d00b001fa3ab0a3bdsm2224484oab.31.2023.11.29.16.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 16:46:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r8VBr-005r2g-CG;
        Wed, 29 Nov 2023 20:46:03 -0400
Date:   Wed, 29 Nov 2023 20:46:03 -0400
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
Subject: Re: [PATCH 2/7] OF: Simplify DMA range calculations
Message-ID: <20231130004603.GB1394392@ziepe.ca>
References: <cover.1701268753.git.robin.murphy@arm.com>
 <73becf4a75f15662b2dda5fba7cfeacdf3d866f8.1701268753.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73becf4a75f15662b2dda5fba7cfeacdf3d866f8.1701268753.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 05:42:59PM +0000, Robin Murphy wrote:
> Juggling start, end, and size values for a range is somewhat redundant
> and a little hard to follow. Consolidate down to just using inclusive
> start and end, which saves us worrying about size overflows for full
> 64-bit ranges (note that passing a potentially-overflowed value through
> to arch_setup_dma_ops() is benign for all current implementations, and
> this is working towards removing that anyway).

In iommu code I've been trying to use consistent language with other
parts of the kernel like interval tree and maple tree:

 * In this file the term 'last' indicates an inclusive and closed interval, eg
 * [0,0] refers to a single PFN. 'end' means an open range, eg [0,0) refers to
 * no PFNs.

Here I think you've swapped end to mean last?

Regardless the change looks correct

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
