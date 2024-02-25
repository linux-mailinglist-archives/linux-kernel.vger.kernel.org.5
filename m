Return-Path: <linux-kernel+bounces-80182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A5D862B71
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1C31C20F9D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906CA175B6;
	Sun, 25 Feb 2024 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="asg93LvR"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D903317736
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708877375; cv=none; b=tUvFtJrieH2G7GXqtVAM9Cvz95MhETv6RjXE8piylLco8EaP+nM+oyOhEmGBuKClzRoO2RVNgyo5f0S2MDNKt528oeajpLQYCmfLg2c2cQGOZnm/0vQCCTzd7HgbJc2iTbi6h51r8pMuf+4ewNRM4PXvBXAv3aYWCuagBvlC1pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708877375; c=relaxed/simple;
	bh=CXVFzfxGpn9qFW0iQ3fUvAoQ4Dnr+o7skXfAk4DfHeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlNu9krSfXOuXeAs5C+xNOIyEemRk63cpguAtUKbiYHyhShAOOt3CcJWwGfH5wtxkvFHqDTqzF2+WYizik/7wDnKN0KBA24VLa6IWj0GBoXj6p83qEPVbmq712BmzlrB0F/eJEFcJWPe/4FDQp2vN0vEDXyFlTtnZ+T5m8kz0z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=asg93LvR; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e4f45d4369so163081b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 08:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708877373; x=1709482173; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2cB6oxKBDQvRDzfa7GxlQ1uXrMwFDIwByZ0N4Dfmmns=;
        b=asg93LvRQqCxfd8oyh9AGARiAEXBHex8qNukHySCUNnHXpSy3WiVeU3i/nOy5O3Q5H
         ShSKa+bJ7ZNmfyGcAarfCfnDrtr+9PGtNgTbQoBJAYUKO+1o4DoUf9z5WiqiYlCpicm6
         OMYGmFjf9gIXkvsPxy4xMXyhk0/tNJFVk5EQ7sOZT0z4eIz10KHPnT7xBEGf/1X+o5Y1
         aN+YjgzlBIjZl4jcrNW2W2ewY/YaY2/h6HI6UDa7wRw7YHJDarPn/FgiZn7EjgiXjO/Y
         49Ozi1GnFdAUd+eMqMiz7cfoVi5UuHQl40qOoKWad2dL9Sz53xBJssCDbkhexsvF8tXk
         Yrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708877373; x=1709482173;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2cB6oxKBDQvRDzfa7GxlQ1uXrMwFDIwByZ0N4Dfmmns=;
        b=FnxuFMApueqeSmBddFJs1jF9ZSpMzBXLm0lbeCoIUttD0s1VsFgHx0kA3r6MxKFPZF
         Oj4+ndzOrfqePtU8N71NgTXCqYKmtvRDgF6ZSKqGFXu+rsKEc7v36TyLPsE3lWOwWtxU
         NgwljqlSXI4+nUQe7HWnPdeWNVckuFhtnPSE6IFHflByLMHJCBtKbgcvdGOy7hzRtJyR
         FxMEP7m/60pUkRQhBrfTZCxPiTdX/9lVKPglOdrueUaXGj2wnhtXGEGfyx/5NSn+jkKW
         KGxzy0XiTW8LpaGt/gCbrqb90R6mz0VxfvQ5jGFKB+Y4S/2147mjZTjQfeWOmTEw8wgO
         Zekw==
X-Forwarded-Encrypted: i=1; AJvYcCXAQ8FfPfzgaMuWj5XBM/eHZRKk7xWPqEnGSW+KBhYAlQe1f1gu3OZMBq8BAVRUSuQk+3wc0EN2M4gMlTdg0N4S7pWPiMAStDeLXV37
X-Gm-Message-State: AOJu0YxX42x4G1SONlHj15MDKTJpkvj+EokDukHDjTmMJ5PH49ZF8JvR
	0EnelM1dMBYdyySptrXUHtWAKS3e/7d8fALlwXGoxmrsLJw58gNsaGSN2WLpOQ==
X-Google-Smtp-Source: AGHT+IGQbcNzjmDRKIKLEdITzXTWaRNodmOp/SEhRlcPD3qZCwGAjUzjwC35n9gDwnqOyp00/kTIEA==
X-Received: by 2002:a05:6a20:9f03:b0:1a0:a61d:1230 with SMTP id mk3-20020a056a209f0300b001a0a61d1230mr4242673pzb.23.1708877373021;
        Sun, 25 Feb 2024 08:09:33 -0800 (PST)
Received: from thinkpad ([103.246.195.16])
        by smtp.gmail.com with ESMTPSA id f26-20020aa79d9a000000b006e4f0e2cc52sm2470639pfq.168.2024.02.25.08.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:09:32 -0800 (PST)
Date: Sun, 25 Feb 2024 21:39:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Shunsuke Mie <mie@igel.co.jp>,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/3] Add support for Block Passthrough Endpoint function
 driver
Message-ID: <20240225160926.GA58532@thinkpad>
References: <20240224210409.112333-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240224210409.112333-1-wafgo01@gmail.com>

On Sat, Feb 24, 2024 at 10:03:59PM +0100, Wadim Mueller wrote:
> Hello,
> 
> This series adds support for the Block Passthrough PCI(e) Endpoint functionality.
> PCI Block Device Passthrough allows one Linux Device running in EP mode to expose its Block devices to the PCI(e) host (RC). The device can export either the full disk or just certain partitions.
> Also an export in readonly mode is possible. This is useful if you want to share the same blockdevice between different SoCs, providing each SoC its own partition(s).
> 
> 
> Block Passthrough
> ==================
> The PCI Block Passthrough can be a useful feature if you have multiple SoCs in your system connected
> through a PCI(e) link, one running in RC mode, the other in EP mode.
> If the block devices are connected to one SoC (SoC2 in EP Mode from the diagramm below) and you want to access
> those from the other SoC (SoC1 in RC mode below), without having any direct connection to
> those block devices (e.g. if you want to share an NVMe between two SoCs). An simple example of such a configurationis is shown below:
> 
> 
>                                                            +-------------+
>                                                            |             |
>                                                            |   SD Card   |
>                                                            |             |
>                                                            +------^------+
>                                                                   |
>                                                                   |
>     +--------------------------+                +-----------------v----------------+
>     |                          |      PCI(e)    |                                  |
>     |         SoC1 (RC)        |<-------------->|            SoC2 (EP)             |
>     | (CONFIG_PCI_REMOTE_DISK) |                |(CONFIG_PCI_EPF_BLOCK_PASSTHROUGH)|
>     |                          |                |                                  |
>     +--------------------------+                +-----------------^----------------+
>                                                                   |
>                                                                   |
>                                                            +------v------+
>                                                            |             |
>                                                            |    NVMe     |
>                                                            |             |
>                                                            +-------------+
> 
> 
> This is to a certain extent a similar functionality which NBD exposes over Network, but on the PCI(e) bus utilizing the EPC/EPF Kernel Framework.
> 
> The Endpoint Function driver creates parallel Queues which run on seperate CPU Cores using percpu structures. The number of parallel queues is limited
> by the number of CPUs on the EP device. The actual number of queues is configurable (as all other features of the driver) through CONFIGFS.
> 
> A documentation about the functional description as well as a user guide showing how both drivers can be configured is part of this series.
> 
> Test setup
> ==========
> 
> This series has been tested on an NXP S32G2 SoC running in Endpoint mode with a direct connection to an ARM64 host machine.
> 
> A performance measurement on the described setup shows good performance metrics. The S32G2 SoC has a 2xGen3 link which has a maximum Bandwidth of ~2GiB/s.
> With the explained setup a Read Datarate of 1.3GiB/s (with DMA ... without DMA the speed saturated at ~200MiB/s) was achieved using an 512GiB Kingston NVMe
> when accessing the NVMe from the ARM64 (SoC1) Host. The local Read Datarate accessing the NVMe dirctly from the S32G2 (SoC2) was around 1.5GiB.
> 
> The measurement was done through the FIO tool [1] with 4kiB Blocks.
> 
> [1] https://linux.die.net/man/1/fio
> 

Thanks for the proposal! We are planning to add virtio function support to
endpoint subsystem to cover usecases like this. I think your usecase can be
satisfied using vitio-blk. Maybe you can add the virtio-blk endpoint function
support once we have the infra in place. Thoughts?

- Mani

> Wadim Mueller (3):
>   PCI: Add PCI Endpoint function driver for Block-device passthrough
>   PCI: Add PCI driver for a PCI EP remote Blockdevice
>   Documentation: PCI: Add documentation for the PCI Block Passthrough
> 
>  .../function/binding/pci-block-passthru.rst   |   24 +
>  Documentation/PCI/endpoint/index.rst          |    3 +
>  .../pci-endpoint-block-passthru-function.rst  |  331 ++++
>  .../pci-endpoint-block-passthru-howto.rst     |  158 ++
>  MAINTAINERS                                   |    8 +
>  drivers/block/Kconfig                         |   14 +
>  drivers/block/Makefile                        |    1 +
>  drivers/block/pci-remote-disk.c               | 1047 +++++++++++++
>  drivers/pci/endpoint/functions/Kconfig        |   12 +
>  drivers/pci/endpoint/functions/Makefile       |    1 +
>  .../functions/pci-epf-block-passthru.c        | 1393 +++++++++++++++++
>  include/linux/pci-epf-block-passthru.h        |   77 +
>  12 files changed, 3069 insertions(+)
>  create mode 100644 Documentation/PCI/endpoint/function/binding/pci-block-passthru.rst
>  create mode 100644 Documentation/PCI/endpoint/pci-endpoint-block-passthru-function.rst
>  create mode 100644 Documentation/PCI/endpoint/pci-endpoint-block-passthru-howto.rst
>  create mode 100644 drivers/block/pci-remote-disk.c
>  create mode 100644 drivers/pci/endpoint/functions/pci-epf-block-passthru.c
>  create mode 100644 include/linux/pci-epf-block-passthru.h
> 
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

