Return-Path: <linux-kernel+bounces-91098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7384687098D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A70D1F271E0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73686629E3;
	Mon,  4 Mar 2024 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODDTDWd5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8DD629ED;
	Mon,  4 Mar 2024 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577030; cv=none; b=tEWkQyonciv1x+ge0p8hUPoYEum3dmDuK/hEKKTmD6bybYOZ7tgj4RYlBR99XDPW/Vs6YkorsJv9pbUjq8ndlBXabnLoQr85L5sCKlRRviobqpwHPDLkhExepBmS2dvnR0HOSnyidZvmieH5qicXNt6xOVjru+60QaUVLWjIP1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577030; c=relaxed/simple;
	bh=ziA5WYvRRKeMAVzULW5DZrSwZgVRble6/Vv6u6klgFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfU9eMQy5078M2x200AFI/RN3zYMHvJlzPzd7YHIgJSRPsAB2XR9xpnfdGU52iB3yjiNKg/2bOz2tbIvrN6YlQdIxS4ZTgj2sHCZ1nt8q5sSz8/6/tWQdDJdQ13KYHzG5uab5na9AvxdYtHlKBOclr+rE641qcWsXoiO4CSrjt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODDTDWd5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6860C433F1;
	Mon,  4 Mar 2024 18:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709577030;
	bh=ziA5WYvRRKeMAVzULW5DZrSwZgVRble6/Vv6u6klgFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ODDTDWd5dsvBmvO6XdiAVMwH149tJPAqQaCPw0Vl8CLxF38gNQateBMMrjXbkSusd
	 vRQTWw9chXqiXtS5RHNoDboBDdQU30amnA0XAahk1ucXWPJuNtRl+eBk674JUjCzmP
	 q992pDkt6r9K/xiQ2sqtKTUh0Q45ZlqdOXNbw/csWEXgsEpFHhcM0pDdr0r31YvMzv
	 iFAvf5oD3BtuqkW5S/48K68MRC+ty7AmMOJ6+XbgUcvuulNgrEGXMOJrAd5YPnM5bT
	 odXJeudAONXhEyDF7uO2xmu2eCmYxhw2HygbVi12Jwt0NYSeCRn684FzVPAgaQnWf6
	 tgZXbBT6H7quw==
Date: Mon, 4 Mar 2024 12:30:27 -0600
From: Rob Herring <robh@kernel.org>
To: abdellatif.elkhlifi@arm.com
Cc: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Drew.Reed@arm.com,
	Adam.Johnston@arm.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 1/3] remoteproc: Add Arm remoteproc driver
Message-ID: <20240304183027.GA854977-robh@kernel.org>
References: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
 <20240301164227.339208-2-abdellatif.elkhlifi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301164227.339208-2-abdellatif.elkhlifi@arm.com>

On Fri, Mar 01, 2024 at 04:42:25PM +0000, abdellatif.elkhlifi@arm.com wrote:
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> 
> introduce remoteproc support for Arm remote processors
> 
> The supported remote processors are those that come with a reset
> control register and a reset status register. The driver allows to
> switch on or off the remote processor.
> 
> The current use case is Corstone-1000 External System (Cortex-M3).
> 
> The driver can be extended to support other remote processors
> controlled with a reset control and a reset status registers.
> 
> The driver also supports control of multiple remote processors at the
> same time.
> 
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> ---
>  MAINTAINERS                    |   6 +
>  drivers/remoteproc/Kconfig     |  18 ++
>  drivers/remoteproc/Makefile    |   1 +
>  drivers/remoteproc/arm_rproc.c | 395 +++++++++++++++++++++++++++++++++
>  4 files changed, 420 insertions(+)
>  create mode 100644 drivers/remoteproc/arm_rproc.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a69..54d6a40feea5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1764,6 +1764,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.yaml
>  F:	drivers/irqchip/irq-vic.c
>  
> +ARM REMOTEPROC DRIVER
> +M:	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> +L:	linux-remoteproc@vger.kernel.org
> +S:	Maintained
> +F:	drivers/remoteproc/arm_rproc.c
> +
>  ARM SMC WATCHDOG DRIVER
>  M:	Julius Werner <jwerner@chromium.org>
>  R:	Evan Benn <evanbenn@chromium.org>
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 48845dc8fa85..57fbac454a5d 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -365,6 +365,24 @@ config XLNX_R5_REMOTEPROC
>  
>  	  It's safe to say N if not interested in using RPU r5f cores.
>  
> +config ARM_REMOTEPROC
> +	tristate "Arm remoteproc support"

Too generic of a name. It should say Corstone or Corstone-1000. Here and 
everywhere you use just 'Arm'.

> +	depends on HAS_IOMEM && ARM64

depends on ARM64 || (HAS_IOMEM && COMPILE_TEST)

That gets us wider build coverage. You should check at least x86 
allmodconfig passes.

> +	default n

The default is already n, so drop.

> +	help
> +	  Say y here to support Arm remote processors via the remote
> +	  processor framework.
> +
> +	  The supported processors are those that come with a reset control register
> +	  and a reset status register. The design can be extended to support different
> +	  processors meeting these requirements.
> +	  The driver also supports control of multiple remote cores at the same time.
> +
> +	  Supported remote cores:
> +	      Corstone-1000 External System (Cortex-M3)
> +
> +	  It's safe to say N here.
> +
>  endif # REMOTEPROC
>  
>  endmenu
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index 91314a9b43ce..73126310835b 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -39,3 +39,4 @@ obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
>  obj-$(CONFIG_TI_K3_DSP_REMOTEPROC)	+= ti_k3_dsp_remoteproc.o
>  obj-$(CONFIG_TI_K3_R5_REMOTEPROC)	+= ti_k3_r5_remoteproc.o
>  obj-$(CONFIG_XLNX_R5_REMOTEPROC)	+= xlnx_r5_remoteproc.o
> +obj-$(CONFIG_ARM_REMOTEPROC)		+= arm_rproc.o
> diff --git a/drivers/remoteproc/arm_rproc.c b/drivers/remoteproc/arm_rproc.c
> new file mode 100644
> index 000000000000..6afa78ae7ad3
> --- /dev/null
> +++ b/drivers/remoteproc/arm_rproc.c
> @@ -0,0 +1,395 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2024 Arm Limited and/or its affiliates <open-source-office@arm.com>

We don't normally put OSO email in here.

> + *
> + * Authors:
> + *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

That's recorded in the commit message and by git, so no need to put it 
in the file.

> + */


