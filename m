Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D735E7FE0D0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjK2UNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjK2UNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:13:20 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0972D67
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:13:26 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1f9decb7446so49127fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 12:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701288806; x=1701893606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bmvK7iHRPD4drkhDHPt0FzrLQ9Gqv9eBxE9BLp7oDgo=;
        b=ENFWgvo3fwf80ZbQRvuBEqdA/QoMEZHjYYTy0dLvz2Bl2DrHTqLK8hg2mNiUK4IgEm
         FZlNKGbZhvZfz6MUFMH0sQ1CGN3CvWc947QBtgi3PIwKWY1tsikIAzhe473ZT7bav9jd
         s7m4F9OaWkhJDoTkhd3AeUu2ueW0bFgEZB3QrAmhaL31KfMYbW6fQWNWWK747jNxWJpT
         ci1oUQRzdn9zIDKb1WH0NkFvw2M95kThZ3t6ADsgd8a4Poaogw7kAIerTG3YS9Db5AXq
         Wb16y3Rlh/cly56esjGoENLAySICrPTG2VNsKamU1IauUV88tH2cSU0mpqFUMouwGDkE
         aFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701288806; x=1701893606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmvK7iHRPD4drkhDHPt0FzrLQ9Gqv9eBxE9BLp7oDgo=;
        b=aMepXQnBtwBh77oVBvltSVA2q8qWFjcRyv/Y52MHF0GQKHUdgLYEcEvO5JcMRob0t9
         qFiWBvBTT9/KTDMLRccXPWT3zncEgMYRkdeytuGP2WsHig2yytM3+qi/iGxO9bihZkvF
         9MnG5k6nngKcHJw9T7FI4HKpYLKE0ZpTNk+XxUNrPfIF5aGXe50E1xjxYQfwtPgdsisB
         is2vNTUhzji8sVACowBra7xU/sWlaCJUtqi0YiFVhpeqRvAuFD+jzMOiiZyo5TNb2UO9
         GfrQqRoB1DLGSlLV6jOrGiXDJdObSGKJJwuCHS0XVAGyDeoiKyXEbZ/249PDbrF1cWw1
         jdAg==
X-Gm-Message-State: AOJu0YzTR+wS/5AW8YBUxb5FaA1HxotSnvQ4ZE2frfGn+3hB5qjSBJen
        sE4AiU++Ancv3hqcUkw2qO0GRg==
X-Google-Smtp-Source: AGHT+IHDvOIdEFEEYA5mpwqmFFuD4VQhNSBzRUUw32RQyjUEYG/3aTKK4gbxat50WL0ewYuq2y3Y1A==
X-Received: by 2002:a05:6870:d88d:b0:1fa:25df:4031 with SMTP id oe13-20020a056870d88d00b001fa25df4031mr20698625oac.4.1701288805852;
        Wed, 29 Nov 2023 12:13:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id lk7-20020a0568703e0700b001fa35df2cb7sm2226220oab.6.2023.11.29.12.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:13:25 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r8Qw0-005pRb-Cz;
        Wed, 29 Nov 2023 16:13:24 -0400
Date:   Wed, 29 Nov 2023 16:13:24 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Disable PCI ATS in legacy passthrough
 mode
Message-ID: <20231129201324.GL1312390@ziepe.ca>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114011036.70142-3-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 09:10:35AM +0800, Lu Baolu wrote:
> When IOMMU hardware operates in legacy mode, the TT field of the context
> entry determines the translation type, with three supported types (Section
> 9.3 Context Entry):
> 
> - DMA translation without device TLB support
> - DMA translation with device TLB support
> - Passthrough mode with translated and translation requests blocked
> 
> Device TLB support is absent when hardware is configured in passthrough
> mode.
> 
> Disable the PCI ATS feature when IOMMU is configured for passthrough
> translation type in legacy (non-scalable) mode.

Oh.. That is the same horrible outcome that ARM has :(

The issue is what to do if the RID translation is in identity but a
PASID is attached that should be using ATS - eg do you completely
loose SVA support if the RID is set to the optimized identity mode?

I vote no. We should make the drivers aware that they should not use
ATS on their RIDs instead :(

Jason
