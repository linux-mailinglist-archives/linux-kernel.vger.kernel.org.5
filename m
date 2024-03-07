Return-Path: <linux-kernel+bounces-96293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEA28759CD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660E62818A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B81613B7A6;
	Thu,  7 Mar 2024 21:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TffNXcT4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1105A20B38
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709848536; cv=none; b=YR9b/j6h3XEECcqL8o4ZYSyVxNwUP9RlZ9vGRctK3qZM2Bk/ymmp98o9KHRoRbcQxL2jYYRSz9vMOn8O2r5kwxD7tyguEjhVtOYp3t9IcIdQ/MmeY3DusYGgKmebqygBx61mudi3aTNwJqZRsyMjQP8DNYF7PjW40qc30BUpnfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709848536; c=relaxed/simple;
	bh=P0HjLdbd3mQX9mA06q2jWvBP5F/sHJM9fcxNfgf0HPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAixXoDHd+8k/EQ/yckhzCclRObYh0YEVQIRS//sCR8sUUaO6aSTi3FFxVC9Kr/CyiM6021ps/l3CJKhGMz88Yl3rrMIMJqaHRUC5TznpklB2axSXl5GmSe1ZV+UPP7NN9UFVAoFokRkkwDz6S3K1h4BuewwQWWt/4kgY2N3i3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TffNXcT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226D6C433F1;
	Thu,  7 Mar 2024 21:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709848535;
	bh=P0HjLdbd3mQX9mA06q2jWvBP5F/sHJM9fcxNfgf0HPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TffNXcT41XvSP1vBjz5bR7wAVGruhaGMd+XFGmUdD0cczGOdz1cWz2QrCgdL7Btl/
	 q4oMugr+U6hYKwOs1XmQ7Zhvc2jUrqrkxwNXruypSc4Xlz7SRd21pKiA7UR/MnMQmE
	 MOJtAtcA8R3vv6e/xKM+JctwUOOhNETCzHfRCPhw=
Date: Thu, 7 Mar 2024 21:55:33 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Vamsi Attunuru <vattunuru@marvell.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K DPI
 administrative driver
Message-ID: <2024030747-stove-helpful-33c1@gregkh>
References: <2024021913-aftermost-footnote-cd6e@gregkh>
 <20240228162141.1413171-1-vattunuru@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228162141.1413171-1-vattunuru@marvell.com>

On Wed, Feb 28, 2024 at 08:21:41AM -0800, Vamsi Attunuru wrote:
> Adds a misc driver for Marvell CN10K DPI(DMA Engine) device's physical
> function which initializes DPI DMA hardware's global configuration and
> enables hardware mailbox channels between physical function (PF) and
> it's virtual functions (VF). VF device drivers (User space drivers) use
> this hw mailbox to communicate any required device configuration on it's
> respective VF device. Accordingly, this DPI PF driver provisions the
> VF device resources.
> 
> At the hardware level, the DPI physical function (PF) acts as a management
> interface to setup the VF device resources, VF devices are only provisioned
> to handle or control the actual DMA Engine's data transfer capabilities.
> 
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> ---
> Changes V2 -> V3:
> - Added ioctl operation to the fops
> - Used managed version of kzalloc & request_irq
> - Addressed miscellaneous comments
> 
> Changes V1 -> V2:
> - Fixed return values and busy-wait loops
> - Merged .h file into .c file
> - Fixed directory structure
> - Removed module params
> - Registered the device as misc device
> 
>  MAINTAINERS                   |   5 +
>  drivers/misc/Kconfig          |  12 +
>  drivers/misc/Makefile         |   1 +
>  drivers/misc/mrvl_cn10k_dpi.c | 717 ++++++++++++++++++++++++++++++++++
>  4 files changed, 735 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 960512bec428..ab77232d583e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13104,6 +13104,11 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
>  F:	drivers/mmc/host/sdhci-xenon*
>  
> +MARVELL OCTEON CN10K DPI DRIVER
> +M:	Vamsi Attunuru <vattunuru@marvell.com>
> +S:	Maintained
> +F:	drivers/misc/mrvl_cn10k_dpi.c
> +
>  MATROX FRAMEBUFFER DRIVER
>  L:	linux-fbdev@vger.kernel.org
>  S:	Orphan
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 4fb291f0bf7c..58de5844ecef 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -574,6 +574,18 @@ config NSM
>  	  To compile this driver as a module, choose M here.
>  	  The module will be called nsm.
>  
> +config MARVELL_CN10K_DPI
> +	tristate "Octeon CN10K DPI driver"
> +	depends on ARM64 && PCI
> +	help
> +	  Enables Octeon CN10K DPI driver which intializes DPI PF device's global configuration
> +	  and its VFs resource configuration to enable DMA transfers. DPI PF device
> +	  does not have any data movement functionality, it only serves VF's resource
> +	  configuration requests.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called mrvl_cn10k_dpi.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index ea6ea5bbbc9c..8fa2fbf8670f 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -68,3 +68,4 @@ obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
>  obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
>  obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
>  obj-$(CONFIG_NSM)		+= nsm.o
> +obj-$(CONFIG_MARVELL_CN10K_DPI)	+= mrvl_cn10k_dpi.o
> diff --git a/drivers/misc/mrvl_cn10k_dpi.c b/drivers/misc/mrvl_cn10k_dpi.c
> new file mode 100644
> index 000000000000..3d33395feaa3
> --- /dev/null
> +++ b/drivers/misc/mrvl_cn10k_dpi.c
> @@ -0,0 +1,717 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell Octeon CN10K DPI driver
> + *
> + * Copyright (C) 2024 Marvell.
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/irq.h>
> +#include <linux/interrupt.h>
> +
> +#define DPI_DRV_NAME	"mrvl-cn10k-dpi"
> +
> +/* PCI device IDs */
> +#define PCI_DEVID_MRVL_CN10K_DPI_PF	0xA080
> +#define PCI_SUBDEVID_MRVL_CN10K_DPI_PF	0xBA00
> +
> +/* PCI BAR nos */
> +#define PCI_DPI_CFG_BAR	0
> +
> +/* MSI-X interrupts */
> +#define DPI_MAX_REQQ_INT 32
> +#define DPI_MAX_CC_INT   64
> +
> +/* MBOX MSI-X interrupt vector index */
> +#define DPI_MBOX_PF_VF_INT_IDX 0x75
> +
> +#define DPI_MAX_IRQS (DPI_MBOX_PF_VF_INT_IDX + 1)
> +
> +#define DPI_MAX_ENGINES 6
> +#define DPI_MAX_VFS	32
> +
> +#define DPI_ENGINE_MASK GENMASK(2, 0)
> +
> +#define DPI_DMA_IDS_DMA_NPA_PF_FUNC(x)		((u64)((x) & GENMASK(15, 0)) << 16)
> +#define DPI_DMA_IDS_INST_STRM(x)		((u64)((x) & GENMASK(7, 0)) << 40)
> +#define DPI_DMA_IDS_DMA_STRM(x)			((u64)((x) & GENMASK(7, 0)) << 32)
> +#define DPI_DMA_ENG_EN_MOLR(x)			((u64)((x) & GENMASK(9, 0)) << 32)
> +#define DPI_EBUS_PORTX_CFG_MPS(x)		((x) & GENMASK(2, 0) << 4)
> +#define DPI_DMA_IDS_DMA_SSO_PF_FUNC(x)		((x) & GENMASK(15, 0))
> +#define DPI_DMA_IDS2_INST_AURA(x)		((x) & GENMASK(19, 0))
> +#define DPI_DMA_IBUFF_CSIZE_CSIZE(x)		((x) & GENMASK(13, 0))
> +#define DPI_EBUS_PORTX_CFG_MRRS(x)		((x) & GENMASK(2, 0))
> +#define DPI_ENG_BUF_BLKS(x)			((x) & GENMASK(5, 0))
> +#define DPI_DMA_CONTROL_DMA_ENB			GENMASK_ULL(53, 48)
> +
> +#define DPI_DMA_CONTROL_O_MODE			BIT_ULL(14)
> +#define DPI_DMA_CONTROL_LDWB			BIT_ULL(32)
> +#define DPI_DMA_CONTROL_WQECSMODE1		BIT_ULL(37)
> +#define DPI_DMA_CONTROL_ZBWCSEN			BIT_ULL(39)
> +#define DPI_DMA_CONTROL_WQECSOFF(offset)	(((u64)offset) << 40)
> +#define DPI_DMA_CONTROL_WQECSDIS		BIT_ULL(47)
> +#define DPI_DMA_CONTROL_PKT_EN			BIT_ULL(56)
> +#define DPI_DMA_IBUFF_CSIZE_NPA_FREE		BIT(16)
> +
> +#define DPI_CTL_EN				BIT_ULL(0)
> +#define DPI_DMA_CC_INT				BIT_ULL(0)
> +#define DPI_DMA_QRST				BIT_ULL(0)
> +
> +#define DPI_REQQ_INT_INSTRFLT			BIT_ULL(0)
> +#define DPI_REQQ_INT_RDFLT			BIT_ULL(1)
> +#define DPI_REQQ_INT_WRFLT			BIT_ULL(2)
> +#define DPI_REQQ_INT_CSFLT			BIT_ULL(3)
> +#define DPI_REQQ_INT_INST_DBO			BIT_ULL(4)
> +#define DPI_REQQ_INT_INST_ADDR_NULL		BIT_ULL(5)
> +#define DPI_REQQ_INT_INST_FILL_INVAL		BIT_ULL(6)
> +#define DPI_REQQ_INT_INSTR_PSN			BIT_ULL(7)
> +
> +#define DPI_REQQ_INT \
> +	(DPI_REQQ_INT_INSTRFLT		| \
> +	DPI_REQQ_INT_RDFLT		| \
> +	DPI_REQQ_INT_WRFLT		| \
> +	DPI_REQQ_INT_CSFLT		| \
> +	DPI_REQQ_INT_INST_DBO		| \
> +	DPI_REQQ_INT_INST_ADDR_NULL	| \
> +	DPI_REQQ_INT_INST_FILL_INVAL	| \
> +	DPI_REQQ_INT_INSTR_PSN)
> +
> +#define DPI_PF_RAS_EBI_DAT_PSN	BIT_ULL(0)
> +#define DPI_PF_RAS_NCB_DAT_PSN	BIT_ULL(1)
> +#define DPI_PF_RAS_NCB_CMD_PSN	BIT_ULL(2)
> +
> +#define DPI_PF_RAS_INT \
> +	(DPI_PF_RAS_EBI_DAT_PSN  | \
> +	 DPI_PF_RAS_NCB_DAT_PSN  | \
> +	 DPI_PF_RAS_NCB_CMD_PSN)
> +
> +#define DPI_DMAX_IBUFF_CSIZE(x)	(0x0ULL | ((x) << 11))
> +#define DPI_DMAX_IDS(x)		(0x18ULL | ((x) << 11))
> +#define DPI_DMAX_IDS2(x)	(0x20ULL | ((x) << 11))
> +#define DPI_DMAX_QRST(x)	(0x30ULL | ((x) << 11))
> +
> +#define DPI_CTL		0x10010ULL
> +#define DPI_DMA_CONTROL 0x10018ULL
> +#define DPI_DMA_ENGX_EN(x) (0x10040ULL | ((x) << 3))
> +#define DPI_ENGX_BUF(x)	(0x100C0ULL | ((x) << 3))
> +
> +#define DPI_EBUS_PORTX_CFG(x) (0x10100ULL | ((x) << 3))
> +
> +#define DPI_PF_RAS 0x10308ULL
> +#define DPI_PF_RAS_ENA_W1C 0x10318ULL
> +
> +#define DPI_DMA_CCX_INT(x) (0x11000ULL | ((x) << 3))
> +#define DPI_DMA_CCX_INT_ENA_W1C(x) (0x11800ULL | ((x) << 3))
> +
> +#define DPI_REQQX_INT(x) (0x12C00ULL | ((x) << 5))
> +#define DPI_REQQX_INT_ENA_W1C(x) (0x13800ULL | ((x) << 5))
> +
> +#define DPI_MBOX_PF_VF_DATA0(x) (0x16000ULL | ((x) << 4))
> +#define DPI_MBOX_PF_VF_DATA1(x) (0x16008ULL | ((x) << 4))
> +
> +#define DPI_MBOX_VF_PF_INT 0x16300ULL
> +#define DPI_MBOX_VF_PF_INT_W1S 0x16308ULL
> +#define DPI_MBOX_VF_PF_INT_ENA_W1C 0x16310ULL
> +#define DPI_MBOX_VF_PF_INT_ENA_W1S 0x16318ULL
> +
> +#define DPI_WCTL_FIF_THR 0x17008ULL
> +
> +#define DPI_EBUS_MAX_PORTS 2
> +
> +#define DPI_EBUS_MRRS_MIN 128
> +#define DPI_EBUS_MRRS_MAX 1024
> +#define DPI_EBUS_MPS_MIN  128
> +#define DPI_EBUS_MPS_MAX  1024
> +
> +#define DPI_QUEUE_OPEN  0x1
> +#define DPI_QUEUE_CLOSE 0x2
> +#define DPI_REG_DUMP    0x3
> +#define DPI_GET_REG_CFG 0x4
> +#define DPI_QUEUE_OPEN_V2 0x5
> +
> +#define DPI_MAGIC_NUM	0xf
> +
> +struct dpi_mps_mrrs_cfg {
> +	u16 mrrs; /* Max read request size */
> +	u16 mps;  /* Max packet size */
> +	u8 port;  /* Ebus port */
> +};
> +
> +struct dpi_engine_cfg {
> +	u64 fifo_mask; /* FIFO size mask in KBytes */
> +	u16 molr[DPI_MAX_ENGINES];
> +	u8 update_molr; /* '1' to update engine MOLR */
> +};
> +
> +enum dpi_mbox_rsp_type {
> +	DPI_MBOX_TYPE_CMD,
> +	DPI_MBOX_TYPE_RSP_ACK,
> +	DPI_MBOX_TYPE_RSP_NACK,
> +};
> +
> +struct dpivf_config {
> +	u16 csize;
> +	u32 aura;
> +	u16 sso_pf_func;
> +	u16 npa_pf_func;
> +};
> +
> +struct dpipf_vf {
> +	u8 this_vfid;
> +	bool setup_done;
> +	struct dpivf_config vf_config;
> +};
> +
> +/* DPI device mailbox */
> +struct dpi_mbox {
> +	struct work_struct work;
> +	/* lock to serialize mbox requests */
> +	struct mutex lock;
> +	struct dpipf *pf;
> +	u8 __iomem *pf_vf_data_reg;
> +	u8 __iomem *vf_pf_data_reg;
> +};
> +
> +struct dpipf {
> +	struct miscdevice miscdev;
> +	void __iomem *reg_base;
> +	struct pci_dev *pdev;
> +	struct dpipf_vf vf[DPI_MAX_VFS];
> +	/* Mailbox to talk to VFs */
> +	struct dpi_mbox *mbox[DPI_MAX_VFS];
> +};
> +
> +union dpi_mbox_message_t {
> +	u64 u[2];
> +	struct dpi_mbox_message_s {
> +		/* VF ID to configure */
> +		u64 vfid           :8;
> +		/* Command code */
> +		u64 cmd            :4;
> +		/* Command buffer size in 8-byte words */
> +		u64 csize          :14;
> +		/* aura of the command buffer */
> +		u64 aura           :20;
> +		/* SSO PF function */
> +		u64 sso_pf_func    :16;
> +		/* NPA PF function */
> +		u64 npa_pf_func    :16;
> +		/* Work queue completion status enable */
> +		u64 wqecs	:1;
> +		/* Work queue completion status byte offset */
> +		u64 wqecsoff	:7;
> +		/* Reserved */
> +		u64 rsvd	:42;
> +	} s __packed;
> +};
> +
> +/* Set MPS & MRRS parameters */
> +#define DPI_MPS_MRRS_CFG _IOW(DPI_MAGIC_NUM, 0, struct dpi_mps_mrrs_cfg)
> +
> +/* Set Engine FIFO configuration */
> +#define DPI_ENGINE_CFG   _IOW(DPI_MAGIC_NUM, 1, struct dpi_engine_cfg)

How is an ioctl description living in a .c file?  This obviously isn't
tested and will not work :(

And those structures will also not work properly as an ioctl, please
read the kernel documentation for how to do this correctly.

thanks,

greg k-h

