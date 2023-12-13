Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43279811EED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjLMTbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMTa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:30:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EBB129
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:31:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51784C433C8;
        Wed, 13 Dec 2023 19:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702495865;
        bh=ck/wlW7lhdixRCwMQVnEmgl26YYLiC5AomhVJrGXoWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=t50l+WwEfAt/LGh4Ix2wvMwsh/CHAo3nLKe60yRg+3qJWYBp/9vKdQ4ZZ9Bo+afXz
         0qsXAlRxqeVqvkrSOIdrn3AKeQaXAr/jdXZ+X9LMPyIosDKqE2gxI/XuBXGz7ewjl0
         nUaCBMhUlqExx00VdlFSxo3dA7fs28UMzU6ATnLQc2uV6He+KOYu6IJvSl/30LFuOy
         Krpox1tNxidH4FckA5pHM3Lg/OhhZXAt+hMHO713K1ygfLo1H0hT6tMDUMmFjkOQgn
         W3uvJwvSUKgBXgjILpjz+uE8xxVnfJxBXsD4SXjxdfwQ3YxMHBRn56FIb0ucV/1gT8
         2cjSXGEudvYZg==
Date:   Wed, 13 Dec 2023 13:31:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, kishon@kernel.org,
        bhelgaas@google.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] bus: mhi: ep: Add async read/write support
Message-ID: <20231213193103.GA1054774@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

Mani, do you want to merge this via your MHI tree?  If so, you can
include Krzysztof's Reviewed-by tags and my:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

If you think it'd be better via the PCI tree, let me know and we can
do that, too.

Bjorn
