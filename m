Return-Path: <linux-kernel+bounces-70181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A3D85946A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419491C213A1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176A9184D;
	Sun, 18 Feb 2024 03:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOqKwDey"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E04315C0;
	Sun, 18 Feb 2024 03:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708227715; cv=none; b=M9pgisJYPt4z0x4gxsxKKjpOUAg7hCgS+VZiba5vupg5uhjbfoN2fNFOnaes7sS9fNdqU5VqOIRt0GhOwvCKriOii8vWWtWxvEjMo6PlkGV07eM/Y60qCsskVW5X+V8Ztb+ZJJ/jimYAf+afACYQDQ4Gx5hTbeHUGuOR5Qud940=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708227715; c=relaxed/simple;
	bh=quB6jphYgrvGzUWwxD7Z2Plo/0c4tpW8wYaTIvHRV3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ply8EnubC6iRxxLk0JBp5CNVWmZRoOEfBjRIzRVenOwUdbzHw51ULiXawv0zHkN/uDkPdwEe8n+FlNfd5YEuECArLSFJXH3BazKa8rr7UWdJF+wctne/3O90LpdLDSC12hjOoQI4nllnzEPJhFA7mmQ1h5sFt9vbLhSS16sMvGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOqKwDey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4EFC433C7;
	Sun, 18 Feb 2024 03:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708227714;
	bh=quB6jphYgrvGzUWwxD7Z2Plo/0c4tpW8wYaTIvHRV3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XOqKwDeyrhoP0rFR9e8DKe6z4kSrba3S4KT7u4Rfpxq2f+h/9rCAL3LNgw6F2IcfA
	 BOluf0a3Jw8dzXrTjd8S7Qedumohr2tv8heAXiDTRA8rjZm68+crwmj9VXlw5F2Jdi
	 /V1DEiNLsjnhsxPLjOiFpuZC/zpWyN4BfCr7diR8Ur0ICJTtqlTbiplYmyr0Y5LKTY
	 ksH522DAqzQPaX8oRMIy9vSg3GYCgc2ntT4ambW1LRB7eUQNejPX7aEDW78y8plJUb
	 7kcm0APY8MKpG0M2TtiVpoRRFDIoeVj1McLF7BZ4tqjlu0l13aG2fLkoYGt99EK5Ga
	 9WIv7uLUltaaQ==
Date: Sat, 17 Feb 2024 21:41:51 -0600
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
Subject: Re: [PATCH v7 10/12] firmware: qcom: tzmem: enable SHM Bridge support
Message-ID: <7pybw4wxlzxfl65yuqxzks5w7uq52hosyq53etlzas6i6o5l6d@vxd4sykcxora>
References: <20240205182810.58382-1-brgl@bgdev.pl>
 <20240205182810.58382-11-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205182810.58382-11-brgl@bgdev.pl>

On Mon, Feb 05, 2024 at 07:28:08PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a new Kconfig option for selecting the SHM Bridge mode of operation

The Kconfig option is the least significant bit of this patch. I guess
there isn't really a problem to describe, but let's at least mention
that we're switching TZ to shmbridge mode and all. 

> for the TrustZone memory allocator.
> 
> If enabled at build-time, it will still be checked for availability at
> run-time. If the architecture doesn't support SHM Bridge, the allocator
> will work just like in the default mode.

"default mode"...SHMBRIDGE is the default mode from this point onwards.

> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
> Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
> Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  drivers/firmware/qcom/Kconfig      | 10 +++++
>  drivers/firmware/qcom/qcom_tzmem.c | 65 +++++++++++++++++++++++++++++-
>  2 files changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index d24d83223867..af6f895c5adf 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -28,6 +28,16 @@ config QCOM_TZMEM_MODE_DEFAULT
>  	  Use the default allocator mode. The memory is page-aligned, non-cachable
>  	  and contiguous.
>  
> +config QCOM_TZMEM_MODE_SHMBRIDGE
> +	bool "SHM Bridge"
> +	help
> +	  Use Qualcomm Shared Memory Bridge. The memory has the same alignment as
> +	  in the 'Default' allocator but is also explicitly marked as an SHM Bridge
> +	  buffer.
> +
> +	  With this selected, all buffers passed to the TrustZone must be allocated
> +	  using the TZMem allocator or else the TrustZone will refuse to use them.

It's funny how this is the only place in the whole series I can find
this mentioned. One could from this statement guess that the eluding
scminvoke requires shmbridge and that this patch series exists solely
to facilitate the requirement stated in this paragraph.

Either this guess is correct and this should have been made clear in
the commit messages, or I'm guessing wrong here, in which case I need
some help to figure out why this series exists.

Regards,
Bjorn

> +
>  endchoice
>  
>  config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
> diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
> index 44a062f2abd4..1ca3773263e5 100644
> --- a/drivers/firmware/qcom/qcom_tzmem.c
> +++ b/drivers/firmware/qcom/qcom_tzmem.c
> @@ -55,7 +55,70 @@ static void qcom_tzmem_cleanup_pool(struct qcom_tzmem_pool *pool)
>  
>  }
>  
> -#endif /* CONFIG_QCOM_TZMEM_MODE_DEFAULT */
> +#elif IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE)
> +
> +#include <linux/firmware/qcom/qcom_scm.h>
> +
> +#define QCOM_SHM_BRIDGE_NUM_VM_SHIFT 9
> +
> +static bool qcom_tzmem_using_shm_bridge;
> +
> +static int qcom_tzmem_init(void)
> +{
> +	int ret;
> +
> +	ret = qcom_scm_shm_bridge_enable();
> +	if (ret == -EOPNOTSUPP) {
> +		dev_info(qcom_tzmem_dev, "SHM Bridge not supported\n");
> +		return 0;
> +	}
> +
> +	if (!ret)
> +		qcom_tzmem_using_shm_bridge = true;
> +
> +	return ret;
> +}
> +
> +static int qcom_tzmem_init_pool(struct qcom_tzmem_pool *pool)
> +{
> +	u64 pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags, ns_perms;
> +	int ret;
> +
> +	if (!qcom_tzmem_using_shm_bridge)
> +		return 0;
> +
> +	ns_perms = (QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ);
> +	pfn_and_ns_perm = (u64)pool->pbase | ns_perms;
> +	ipfn_and_s_perm = (u64)pool->pbase | ns_perms;
> +	size_and_flags = pool->size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
> +
> +	u64 *handle __free(kfree) = kzalloc(sizeof(*handle), GFP_KERNEL);
> +	if (!handle)
> +		return -ENOMEM;
> +
> +	ret = qcom_scm_shm_bridge_create(qcom_tzmem_dev, pfn_and_ns_perm,
> +					 ipfn_and_s_perm, size_and_flags,
> +					 QCOM_SCM_VMID_HLOS, handle);
> +	if (ret)
> +		return ret;
> +
> +	pool->priv = no_free_ptr(handle);
> +
> +	return 0;
> +}
> +
> +static void qcom_tzmem_cleanup_pool(struct qcom_tzmem_pool *pool)
> +{
> +	u64 *handle = pool->priv;
> +
> +	if (!qcom_tzmem_using_shm_bridge)
> +		return;
> +
> +	qcom_scm_shm_bridge_delete(qcom_tzmem_dev, *handle);
> +	kfree(handle);
> +}
> +
> +#endif /* CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE */
>  
>  /**
>   * qcom_tzmem_pool_new() - Create a new TZ memory pool.
> -- 
> 2.40.1
> 

