Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15136752AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjGMT2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjGMT2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:28:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1622707;
        Thu, 13 Jul 2023 12:28:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67AFB61B24;
        Thu, 13 Jul 2023 19:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7CFC433C7;
        Thu, 13 Jul 2023 19:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689276530;
        bh=zDVMhROmojmbgyEs2EDFF1j/BJYI67as1OcXUNfcQPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xnARUZ0P4IJfcgcPMHZ9Y6DjTZcWfPEqfbjzO+3k0J7MGqLzYYWrIhzbHGrSDjTjP
         fkROjl9lPL8k4HfEQESuE7ohoRjDo/EzyxGcqEbIhCTW0a3enlxmyy8AFC4kRNnTHf
         gb37E6ir3PbH3oNe2jOpCLtGi0BIQ7W3ZZZXqmCM=
Date:   Thu, 13 Jul 2023 21:28:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        John Stultz <jstultz@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] misc: sram: Add DMA-BUF Heap exporting of SRAM areas
Message-ID: <2023071308-squeeze-hamster-d02f@gregkh>
References: <20230713191316.116019-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713191316.116019-1-afd@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 02:13:16PM -0500, Andrew Davis wrote:
> This new export type exposes to userspace the SRAM area as a DMA-BUF Heap,
> this allows for allocations of DMA-BUFs that can be consumed by various
> DMA-BUF supporting devices.

What devices exactly?

And what userspace tools/programs are going to use this api?

> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
> 
> Changes from v2:
>  - Make sram_dma_heap_allocate static (kernel test robot)
>  - Rebase on v6.5-rc1
> 
>  drivers/misc/Kconfig         |   7 +
>  drivers/misc/Makefile        |   1 +
>  drivers/misc/sram-dma-heap.c | 245 +++++++++++++++++++++++++++++++++++
>  drivers/misc/sram.c          |   6 +
>  drivers/misc/sram.h          |  16 +++
>  5 files changed, 275 insertions(+)
>  create mode 100644 drivers/misc/sram-dma-heap.c
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 75e427f124b28..ee34dfb61605f 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -448,6 +448,13 @@ config SRAM
>  config SRAM_EXEC
>  	bool
>  
> +config SRAM_DMA_HEAP
> +	bool "Export on-chip SRAM pools using DMA-Heaps"
> +	depends on DMABUF_HEAPS && SRAM
> +	help
> +	  This driver allows the export of on-chip SRAM marked as both pool
> +	  and exportable to userspace using the DMA-Heaps interface.

Module name?

>  config DW_XDATA_PCIE
>  	depends on PCI
>  	tristate "Synopsys DesignWare xData PCIe driver"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index f2a4d1ff65d46..5e7516bfaa8de 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -47,6 +47,7 @@ obj-$(CONFIG_VMWARE_VMCI)	+= vmw_vmci/
>  obj-$(CONFIG_LATTICE_ECP3_CONFIG)	+= lattice-ecp3-config.o
>  obj-$(CONFIG_SRAM)		+= sram.o
>  obj-$(CONFIG_SRAM_EXEC)		+= sram-exec.o
> +obj-$(CONFIG_SRAM_DMA_HEAP)	+= sram-dma-heap.o
>  obj-$(CONFIG_GENWQE)		+= genwqe/
>  obj-$(CONFIG_ECHO)		+= echo/
>  obj-$(CONFIG_CXL_BASE)		+= cxl/
> diff --git a/drivers/misc/sram-dma-heap.c b/drivers/misc/sram-dma-heap.c
> new file mode 100644
> index 0000000000000..c054c04dff33e
> --- /dev/null
> +++ b/drivers/misc/sram-dma-heap.c
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SRAM DMA-Heap userspace exporter
> + *
> + * Copyright (C) 2019-2022 Texas Instruments Incorporated - https://www.ti.com/
> + *	Andrew Davis <afd@ti.com>

It's 2023 :(

And this needs review from the dma-buf maintainers before I could do
anything with it.

thanks,

greg k-h
