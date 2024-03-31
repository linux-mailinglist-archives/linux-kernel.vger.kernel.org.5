Return-Path: <linux-kernel+bounces-126088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F79893204
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F861C219B7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 14:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAE91448E9;
	Sun, 31 Mar 2024 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PiHEYUrc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEEF2E40E;
	Sun, 31 Mar 2024 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711896906; cv=none; b=EJCKbIxq4jcad8X8ejuc0PUpJW6AkhdsJZSmcX1rI/oIV7VizHCN/nYnGRNKEcIT8BcJfED/NpKYAXFmZiCPvdOhUbbZgDZlUrd9DDo/JBSPgLY2QqJ3eP3fgi3lmpONCvAwVP/kL9BxYiBY42zHmVuBx+mueCbkOcNvOgeeBzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711896906; c=relaxed/simple;
	bh=K84N5CSaxnClho6b28SUC/t23z42Josx5Mag+aQ1Vnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poIgW6bKyDMFqHDEoOogPecCRHjoStWLyvGFGrGZLnT6nNrsow7tnBjHiiUb//PpvOk9IRqbqobHf/l5df5kQjeQV8ibspkpbxxdpqi0g6kyPZ4Bi6i2bMdBscvnSlHs32FJvuaI9uoyDKDlhEL9HhTn7v0VS8DCIH/GYjL3NgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PiHEYUrc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711896904; x=1743432904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K84N5CSaxnClho6b28SUC/t23z42Josx5Mag+aQ1Vnw=;
  b=PiHEYUrcagul1ex7CkzRWVkedITPDnveDZ/aNInUMDeTiu/G6PuCupxk
   wuG7szipqGi7D5w4ny7EtMzFpXHAOmJDhYdE8QAXSOaQrAj/igOzhVCsc
   7/I03V4ORxJ3r0snNJtBjq7bADtVu7ptPBd6N/rB7xvRWToBpCtY+BRck
   rLYbczqxTf1XKC/IaRz3GnBQ7/NmMQOev2uX4g0izzbVjlBfjt3/xKlbO
   W/cXipGn5BIOCwv/BCiDOd1lrjv4+iFvf74VVCfsOrJLg+tWStxu+8UX+
   6IYn5IgQXqez16DABd9ms0GLOUcL/3/SKBaQ8etUxFVj2YRhjxifyNcaW
   w==;
X-CSE-ConnectionGUID: fpyVp4h8SMm0t/CSgOjkwA==
X-CSE-MsgGUID: 843r2gO/QeSnza7c+hm00Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="17593989"
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="17593989"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 07:55:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,170,1708416000"; 
   d="scan'208";a="17546753"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa007.fm.intel.com with ESMTP; 31 Mar 2024 07:54:59 -0700
Date: Sun, 31 Mar 2024 22:50:11 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Charles Perry <charles.perry@savoirfairelinux.com>
Cc: mdf@kernel.org, avandiver@markem-imaje.com, bcody@markem-imaje.com,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>, linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 0/4] fpga: xilinx-selectmap: add new driver
Message-ID: <Zgl4I6rykg7shI2K@yilunxu-OptiPlex-7050>
References: <20240321220447.3260065-1-charles.perry@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321220447.3260065-1-charles.perry@savoirfairelinux.com>

On Thu, Mar 21, 2024 at 06:04:32PM -0400, Charles Perry wrote:
> Hello,
> 
> This patchset adds a new driver for the 7 series FPGA's SelectMAP
> interface.
> 
> The SelectMAP interface shares a common GPIO protocol with the SPI
> interface which is already in the kernel (drivers/fpga/xilinx-spi.c).
> The approach proposed in this patchset is to refactor xilinx-spi.c into
> xilinx-core.c which would handle the common GPIO protocol. This is then
> used to build two drivers, the already existing xilinx-spi.c driver and
> a newly added xilinx-selectmap.c driver.
> 
> The SelectMAP driver proposed only supports 8 bit mode. This is because
> the 16 and 32 bits mode have limitations with regards to compressed
> bitstream support as well as introducing endianness considerations.
> 
> I'm testing xilinx-selectmap.c on a custom i.MX6 board connected to an
> Artix 7 FPGA. Flashing a 913K bitstream takes 0.44 seconds.
> 
> Changes since v5: (from Yilun review)
>  * xilinx-core.h: remove private fields kernel-doc
>  * xilinx-spi.c: rename conf into core in xilinx_spi_probe
>  * xilinx-core.c: introduce the new gpio names in patch 4/4
>  * xilinx-core.c: remove kernel-doc on xilinx_core_devm_gpiod_get()
>  * xilinx-selectmap.c:
>    * reorder includes in alphabetical order
>    * xilinx_selectmap_probe(): remove unused resource *r variable
>    * xilinx_selectmap_probe(): use a single gpio_desc* temporary
>    * xilinx_selectmap_probe(): declare variables in reverse xmas tree
> 
> Changes since v4: (from Yilun and Krzysztof review)
>  * xilinx-core: use sizeof() instead of hardcoded immediate
>  * xilinx-core: fix module compilation (EXPORT_SYMBOL_GPL, MODULE_LICENSE,
>    MODULE_AUTHOR, MODULE_DESCRIPTION)
>  * xilinx-core: add private/public qualifiers for struct xilinx_fpga_core
>  * xilinx-spi: remove struct xilinx_spi_conf. This struct isn't needed as
>    the struct spi_device* can be retrieved from the struct device*.
>  * dt-bindings: remove usage of "_b" and "-b" for the new driver. We
>    agreed that the spi and selectmap driver will use different bindings
>    which will be handled by the driver core and that the legacy names will
>    be used only for the spi compatible.
>  * xilinx-core: select between prog/init and prog_b/init-b
> 
> Changes since v3: (from Rob Herring review)
>  * Fix an error in the DT binding example compatible.
>  * Drop the renaming of "prog_b" to "prog" and "init-b" to "init".
>    Patches 2 and 3 are removed.
> 
> Changes since v2:
>  * Inserted patch 2 and 3 which rename "prog_b" and "init-b" into "prog"
>    and "init" for the SPI driver.
>  * From Krzysztof Kozlowski review's:
>    * Use more specific compatible names
>    * Remove other missing occurences of the slave word missed in v2.
>  * From Xu Yilun review's:
>    * Fix vertical whitespace in get_done_gpio().
>    * Combine write() and write_one_dummy_byte() together.
>    * Eliminate most of the xilinx_core_probe() arguments, the driver
>      needs to populate those directly into the xilinx_fpga_core struct.
>      Added some documentation to struct xilinx_fpga_core to clarify
>      this.
>    * Removed typedefs from xilinx-core.h.
>    * Moved null checks in xilinx_core_probe() to first patch.
>    * Move csi_b and rdwr_b out of xilinx_selectmap_conf as they are not
>      used out of the probe function.
> 
> Changes since v1: (from Krzysztof Kozlowski review's)
>   * Use more conventional names for gpio DT bindings
>   * fix example in DT bindings
>   * add mc-peripheral-props.yaml to DT bindings
>   * fix various formatting mistakes
>   * Remove all occurences of the "slave" word.
> 
> Charles Perry (4):
>   fpga: xilinx-spi: extract a common driver core
>   dt-bindings: fpga: xlnx,fpga-selectmap: add DT schema
>   fpga: xilinx-selectmap: add new driver
>   xilinx-core: add new gpio names for prog and init
> 
>  .../bindings/fpga/xlnx,fpga-selectmap.yaml    |  86 +++++++
>  drivers/fpga/Kconfig                          |  12 +
>  drivers/fpga/Makefile                         |   2 +
>  drivers/fpga/xilinx-core.c                    | 229 ++++++++++++++++++
>  drivers/fpga/xilinx-core.h                    |  27 +++
>  drivers/fpga/xilinx-selectmap.c               |  95 ++++++++
>  drivers/fpga/xilinx-spi.c                     | 224 ++---------------
>  7 files changed, 466 insertions(+), 209 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>  create mode 100644 drivers/fpga/xilinx-core.c
>  create mode 100644 drivers/fpga/xilinx-core.h
>  create mode 100644 drivers/fpga/xilinx-selectmap.c

Applied this series to for-next with a nit.

Thanks,
Yilun

> 
> --
> 2.43.0
> 

