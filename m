Return-Path: <linux-kernel+bounces-70178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54287859462
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D13F1B21B3A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75423322A;
	Sun, 18 Feb 2024 03:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryZhzndb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B697F1848;
	Sun, 18 Feb 2024 03:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708226715; cv=none; b=a9dTIyjeE+DCfqc0aH7EMAOE8ylrRwmw+UyVWD33vYTz8Tx2kSRKQGyYC6HsljiOaN+/dN3QF/5nBAXlt0+C/LmkHbWcL36GO7m+haFn1fpfooJj/q46xQpKpdG6ZwIshB066M4OCodv2Q+DlzN3BYFXlbMwXBgkn12hZ92YN3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708226715; c=relaxed/simple;
	bh=mSWLc4sSN134G7gn1rRMq9O57FqrO4Jhs8fU+bv3Rfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMu9f8WFsXR43w2SYo3NgN5A7D/tYT8goMNYCO7zBXpMT4iaGYR4lMA3/Gn+TdfO8Or+hpM+3rJ5hzd6CYDA8KArjUEB0WheTK2C/awbY057EwFhcwCV2J+BocUaLf+CrWuwOdqLH1y1KIClvlODATJVUlp5/5PiMItkPycwEns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryZhzndb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058EBC433F1;
	Sun, 18 Feb 2024 03:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708226715;
	bh=mSWLc4sSN134G7gn1rRMq9O57FqrO4Jhs8fU+bv3Rfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ryZhzndb5eonUXEh55cTcGp11eNSU8/OYbjY0+SakYLYQ8pj1fyKTkrmqKOazqcMN
	 GKBuUQKfakDIb8jXgBmIbAo/nZwUUSrFnnRZDWcQBzUEOvb14QqwdUgxvKXVXDsk3/
	 WkZhT+YZnzKkOoIsCB9TKop2uZNjGolPIin/D/kW6wy8vM4hIXL4pp2I2JmhYLqIz/
	 NcLxn5QOKVmFh6tc2SjSwlzJQ0rk4TF73swFMsuGKn9N4KocJQ2h4ntEbfqxSThIon
	 xiN2rFee3/YeLunngIg2QmgecM+xG7HWlsTOGc4ThicoJwNRx+OgxCPtcZXnSYBZFE
	 IkWWRQlJED4SQ==
Date: Sat, 17 Feb 2024 21:25:12 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Guru Das Srinagesh <quic_gurus@quicinc.com>, 
	Andrew Halaney <ahalaney@redhat.com>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: Re: [PATCH v7 02/12] firmware: qcom: scm: enable the TZ mem allocator
Message-ID: <tnylagkmj36lve2ub5voumtkqjdy6j3hr6yyk4mqkaabvc3gdv@voaiu2oqi73o>
References: <20240205182810.58382-1-brgl@bgdev.pl>
 <20240205182810.58382-3-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205182810.58382-3-brgl@bgdev.pl>

On Mon, Feb 05, 2024 at 07:28:00PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Select the TrustZone memory allocator in Kconfig and create a pool of
> memory shareable with the TrustZone when probing the SCM driver.
> 
> This will allow a gradual conversion of all relevant SCM calls to using
> the dedicated allocator.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
> Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
> Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  drivers/firmware/qcom/Kconfig    |  1 +
>  drivers/firmware/qcom/qcom_scm.c | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index f18686edf415..d24d83223867 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -7,6 +7,7 @@
>  menu "Qualcomm firmware drivers"
>  
>  config QCOM_SCM
> +	select QCOM_TZMEM
>  	tristate
>  
>  config QCOM_TZMEM
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 520de9b5633a..0d4c028be0c1 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -8,8 +8,10 @@
>  #include <linux/completion.h>
>  #include <linux/cpumask.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/firmware/qcom/qcom_scm.h>
> +#include <linux/firmware/qcom/qcom_tzmem.h>
>  #include <linux/init.h>
>  #include <linux/interconnect.h>
>  #include <linux/interrupt.h>
> @@ -20,9 +22,11 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset-controller.h>
> +#include <linux/sizes.h>
>  #include <linux/types.h>
>  
>  #include "qcom_scm.h"
> +#include "qcom_tzmem.h"
>  
>  static bool download_mode = IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
>  module_param(download_mode, bool, 0);
> @@ -41,6 +45,8 @@ struct qcom_scm {
>  	int scm_vote_count;
>  
>  	u64 dload_mode_addr;
> +
> +	struct qcom_tzmem_pool *mempool;
>  };
>  
>  struct qcom_scm_current_perm_info {
> @@ -1887,6 +1893,16 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  	if (of_property_read_bool(pdev->dev.of_node, "qcom,sdi-enabled"))
>  		qcom_scm_disable_sdi();
>  
> +	ret = qcom_tzmem_enable(__scm->dev);
> +	if (ret)
> +		return dev_err_probe(__scm->dev, ret,
> +				     "Failed to enable the TrustZone memory allocator\n");
> +
> +	__scm->mempool = devm_qcom_tzmem_pool_new(__scm->dev, SZ_256K);

As we're not moving from the callers freely allocating what they need,
to a fixed sized pool of 256kb. Please document why 256kb was choosen,
so that we have something to fall back on when someone runs out of this
space, or wonders "why not 128kb?".

Regards,
Bjorn

> +	if (IS_ERR(__scm->mempool))
> +		return dev_err_probe(__scm->dev, PTR_ERR(__scm->mempool),
> +				     "Failed to create the SCM memory pool\n");
> +
>  	/*
>  	 * Initialize the QSEECOM interface.
>  	 *
> -- 
> 2.40.1
> 

