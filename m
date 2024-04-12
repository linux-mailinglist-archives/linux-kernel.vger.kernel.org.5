Return-Path: <linux-kernel+bounces-142643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B268A2E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 050AA286CD4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BCF56B81;
	Fri, 12 Apr 2024 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yL9YLsZQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F4656B73
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712924814; cv=none; b=VwgVUbAR1PPEMHTKDlmFc/8seTstlnnbkS10QIAazAPJs00LiIZ9Qd0/wvt2S4o21W+YebPWPEYYwKD29wh9q8sUxkmv0ZRV+m2r+TwIjoxXnoGpU18zP53X1pxZmIIzyA3kDhIIQOSpIaeTn8eNUtBwOa04RXT7Gc/V/tOT8MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712924814; c=relaxed/simple;
	bh=mFlXd0dhK9hhZDrKKgOHHeKtkcq7FDGi2zmOZXw3Ldg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6aCDTTd2Tv4U0iUnjA83SWAckjmqK3hCjXydw4WpIKCY+PFQcM+yby70R73n+fIqJDoqty6nPNBgSmZ642CfwSWllsp8iMjCOSeR5siCHt2gervQ3NCkaiihPc9TWWks69ndZxCW1AFF3st4C4p0VhTGWCFPDLCgHZpoPo+JiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yL9YLsZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5645C2BD10;
	Fri, 12 Apr 2024 12:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712924814;
	bh=mFlXd0dhK9hhZDrKKgOHHeKtkcq7FDGi2zmOZXw3Ldg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yL9YLsZQuMLjcwy5w6DOIekiL81NS21sohO86yBowSf7HYXm+G2tcdyAeYjAc/mcq
	 d1imwTRp96XxlZ7mu2RM8WNH2isLIQjaXtBSlakVNO5o8N3sJ/XfL4qxVLvTtue9sr
	 crr0j4hZIMq1n76HH+N3f4Yd8MLNpiDt4Rf+qRK8=
Date: Fri, 12 Apr 2024 14:26:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vamsi Attunuru <vattunuru@marvell.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K DPI
 administrative driver
Message-ID: <2024041250-nursing-tidy-db7e@gregkh>
References: <MW4PR18MB5244C76290A15737DC94FFDBA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <20240412121005.1825881-1-vattunuru@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412121005.1825881-1-vattunuru@marvell.com>

On Fri, Apr 12, 2024 at 05:10:05AM -0700, Vamsi Attunuru wrote:
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

No pointer to the userspace code that uses this?  Why not?  How are we
supposed to be able to review this?

> +config MARVELL_CN10K_DPI
> +	tristate "Octeon CN10K DPI driver"
> +	depends on ARM64 && PCI
> +	help
> +	  Enables Octeon CN10K DPI driver which intializes DPI PF device's global configuration
> +	  and its VFs resource configuration to enable DMA transfers. DPI PF device
> +	  does not have any data movement functionality, it only serves VF's resource
> +	  configuration requests.

Did this pass checkpatch?  Please wrap your help text at the proper
boundry.

And what is "DPI"?  What is "PF"?  What is "VF"?  These are all terms
that need to be documented somewhere, right?

> --- /dev/null
> +++ b/include/uapi/misc/mrvl_cn10k_dpi.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +/*
> + * Marvell Octeon CN10K DPI driver
> + *
> + * Copyright (C) 2024 Marvell.
> + *
> + */
> +
> +#ifndef __MRVL_CN10K_DPI_H__
> +#define __MRVL_CN10K_DPI_H__
> +
> +#include <linux/types.h>
> +
> +#define DPI_MAX_ENGINES 6
> +
> +struct dpi_mps_mrrs_cfg {
> +	__u64 mrrs; /* Max read request size */
> +	__u64 mps;  /* Max packet size */

You can spell out variables with more characters :)

> +	__u64 port; /* Ebus port */
> +};
> +
> +struct dpi_engine_cfg {
> +	__u64 fifo_mask; /* FIFO size mask in KBytes */
> +	__u64 molr[DPI_MAX_ENGINES];

What is a "molr"?

> +	__u64 update_molr; /* '1' to update engine MOLR */

You "burn" a whole 64 for 1 bit?  That feels wrong, who on your end
reviewed this api to be correct?

> +#define DPI_MAGIC_NUM	0xB8

Did you document this api somewhere?

> +
> +/* Set MPS & MRRS parameters */
> +#define DPI_MPS_MRRS_CFG _IOW(DPI_MAGIC_NUM, 1, struct dpi_mps_mrrs_cfg)
> +
> +/* Set Engine FIFO configuration */
> +#define DPI_ENGINE_CFG   _IOW(DPI_MAGIC_NUM, 2, struct dpi_engine_cfg)
> +
> +#endif /* __MRVL_CN10K_DPI_H__ */
> -- 
> 2.25.1
> 

