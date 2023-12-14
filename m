Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D6E812DE3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444000AbjLNK4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443847AbjLNKz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:55:59 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B67D4C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:55:14 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b844357f7cso6201728b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702551314; x=1703156114; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IfG/ysGevH7N1+fittwEeggjkDoQ9clr+IHO2E1aJ/Y=;
        b=eV2lu8zHrNORcFeXmgxQb2QFeyr/GSPmcwMPHWAMh2GUyiaTAYXpdF/5b2Faq2n2v0
         4GIpUAh5Iq7AZOugR75bFsvikFYpgn0SVQYLA+lOtU62Do8tNKQXyHbdf/elMLa/dQld
         ZfIuMFltbSIf5xoaWZxUTL8U5a3lpW/YNS1BSuEs09fJ+0dFXojQVOVNnbMASCzhCGuD
         GxTe3+4KECYO1NAGSJ40S4qMVNsR5mPB3IA6P3uSyHvDC694ebQZMfjdKYf6EJksqE+N
         28ZCWJLGKvdbbtoBGB34DLq0UU0wRF9S2FvKXVWjvikLFkEUYOGV5uCh8iMNm0zZCVE7
         fwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702551314; x=1703156114;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfG/ysGevH7N1+fittwEeggjkDoQ9clr+IHO2E1aJ/Y=;
        b=cizb3MQzn8BptyYEV+KD4ZhatWktSVHg5Mv4cFAEhQg4rUlpIatv/lTR63n/pQ3Qu1
         V5nyeIXrSRb86nuZO3DuznGZMAPjuuZSoHxJZytv2RJ/MErEqKfFl7Q95WCTuPkPIuD3
         gpsDe8AZqhqSacfpwTgAR/aNwdv1CNRxQE2xE8SmT/MeNB5lesFfnjNOpXCV6IGHCxhi
         A6FO1W270z9RBfxWDAh0Dhnf4ZZvK7cQ4I3lJ+8RdBmshG6IRWHVUTuThFGMGToSJpa3
         g5cDGpitKrxKS78LyAxxppaFt5ETpnweSVyc6CqXysmp1ZEo7PcvkpfOFMMLLXW/+YS2
         0oxg==
X-Gm-Message-State: AOJu0YxHTjyBpo5mpjO3dAxFZs+N2ZE/Eg2MM1NFkjBsyVgwXF0QuCu1
        obI9kmF1xygi73OKaMp/UxpD
X-Google-Smtp-Source: AGHT+IH9dKZ7weDdopz65PuRKkbO/Mp6K8kuMEeI2h6VFnM6F5xt5c41hlBPLlHFALw9Ax8DidTESA==
X-Received: by 2002:a05:6808:1690:b0:3ba:3234:a068 with SMTP id bb16-20020a056808169000b003ba3234a068mr970504oib.110.1702551313755;
        Thu, 14 Dec 2023 02:55:13 -0800 (PST)
Received: from thinkpad ([117.216.120.87])
        by smtp.gmail.com with ESMTPSA id g25-20020aa78759000000b006d0951e74cbsm6780784pfo.178.2023.12.14.02.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:55:13 -0800 (PST)
Date:   Thu, 14 Dec 2023 16:25:06 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] bus: mhi: ep: Add async read/write support
Message-ID: <20231214105506.GA48078@thinkpad>
References: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 06:15:20PM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> This series add async read/write support for the MHI endpoint stack by
> modifying the MHI ep stack and the MHI EPF (controller) driver.
> 
> Currently, only sync read/write operations are supported by the stack,
> this resulting in poor data throughput as the transfer is halted until
> receiving the DMA completion. So this series adds async support such
> that the MHI transfers can continue without waiting for the transfer
> completion. And once the completion happens, host is notified by sending
> the transfer completion event.
> 
> This series brings iperf throughput of ~4Gbps on SM8450 based dev platform,
> where previously 1.6Gbps was achieved with sync operation.
> 

Applied to mhi-next with reviews from Bjorn and Krzysztof for PCI EPF patches.

- Mani

> - Mani
> 
> Manivannan Sadhasivam (9):
>   bus: mhi: ep: Pass mhi_ep_buf_info struct to read/write APIs
>   bus: mhi: ep: Rename read_from_host() and write_to_host() APIs
>   bus: mhi: ep: Introduce async read/write callbacks
>   PCI: epf-mhi: Simulate async read/write using iATU
>   PCI: epf-mhi: Add support for DMA async read/write operation
>   PCI: epf-mhi: Enable MHI async read/write support
>   bus: mhi: ep: Add support for async DMA write operation
>   bus: mhi: ep: Add support for async DMA read operation
>   bus: mhi: ep: Add checks for read/write callbacks while registering
>     controllers
> 
>  drivers/bus/mhi/ep/internal.h                |   1 +
>  drivers/bus/mhi/ep/main.c                    | 256 +++++++++------
>  drivers/bus/mhi/ep/ring.c                    |  41 +--
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 314 ++++++++++++++++---
>  include/linux/mhi_ep.h                       |  33 +-
>  5 files changed, 485 insertions(+), 160 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
