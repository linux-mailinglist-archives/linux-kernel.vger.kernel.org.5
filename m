Return-Path: <linux-kernel+bounces-127937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DE38952FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB231F2580F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1118D78285;
	Tue,  2 Apr 2024 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6uGxGOM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB8C3611A;
	Tue,  2 Apr 2024 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061033; cv=none; b=K9QUMjUsr9tf+b1QV1ExclP4vGpX67c/jBfl5Pz8HaThWUaYeEWGBdq7EkoUPbYtrf5YYzUTi/GXFeZIl02sfIymsiocHeQ4uAQinSjvhPkAOM+KBeS2AqR/ebnjO/ROXv4C23Vnmw0OIjRinUrDdy67ZopBkPwCrC2SbIRmxMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061033; c=relaxed/simple;
	bh=ddqA/sogrh0pyj1HLmomLRqQ5T9jyI8YMNiLkUaOzcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTcNnmPqsqLp7xWqWs4vqv2qjSUKMbLwjmzxX1sMh2PY6Y9Rk4Ejvab1gaNIDfEsVadFIDAuleorRPwbBo4Bp0D04u/GVIB5YWjLvKcOTda6cCflk64X0zJ5dWTSJdOf0RlYusaUrUO/8TE334XXy/LLAfqsW1ZL8JjQN/6oUkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6uGxGOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9495FC433C7;
	Tue,  2 Apr 2024 12:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712061032;
	bh=ddqA/sogrh0pyj1HLmomLRqQ5T9jyI8YMNiLkUaOzcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L6uGxGOMQk52/JmF2EUy63XOCU5OVmz0jruepa9iYN8BIaRPWC4cQPUJVABnsPHCo
	 0V/dQn+qiBGttarE3gSJtHt+n65PcRWWOZ/ncPZ+9YMPf/vTlMGZjxDwuoOJnLnOw5
	 b01Hd3CE1m0ahH6nwzwV/ixQtfAb0jotPOEePH+lfXrt44kYyk/zrb99PFE7g22q3Q
	 g17+6aUxxgGtnb7nupU9HSfQovlZECjlgDVNTIEnlCvoauqcfkM7b3Ja2ms74di4Wc
	 LqwmIUeykZLTCNBdger75mNrnFgDlIx3otNqVb9uChA49IHevjsuS7GBJv7s7nsCg4
	 akGBBITEnJpJg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rrdHc-0000000050M-1X6I;
	Tue, 02 Apr 2024 14:30:32 +0200
Date: Tue, 2 Apr 2024 14:30:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Johan Hovold <johan+linaro@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Guru Das Srinagesh <quic_gurus@quicinc.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: qcom: uefisecapp: Fix memory related IO errors
 and crashes
Message-ID: <Zgv6aJ4byNiujmo-@hovoldconsulting.com>
References: <20240329201827.3108093-1-luzmaximilian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329201827.3108093-1-luzmaximilian@gmail.com>

On Fri, Mar 29, 2024 at 09:18:25PM +0100, Maximilian Luz wrote:
> It turns out that while the QSEECOM APP_SEND command has specific fields
> for request and response buffers, uefisecapp expects them both to be in
> a single memory region. Failure to adhere to this has (so far) resulted
> in either no response being written to the response buffer (causing an
> EIO to be emitted down the line), the SCM call to fail with EINVAL
> (i.e., directly from TZ/firmware), or the device to be hard-reset.
> 
> While this issue can be triggered deterministically, in the current form
> it seems to happen rather sporadically (which is why it has gone
> unnoticed during earlier testing). This is likely due to the two
> kzalloc() calls (for request and response) being directly after each
> other. Which means that those likely return consecutive regions most of
> the time, especially when not much else is going on in the system.
> 
> Fix this by allocating a single memory region for both request and
> response buffers, properly aligning both structs inside it. This
> unfortunately also means that the qcom_scm_qseecom_app_send() interface
> needs to be restructured, as it should no longer map the DMA regions
> separately. Therefore, move the responsibility of DMA allocation (or
> mapping) to the caller.
> 
> Fixes: 759e7a2b62eb ("firmware: Add support for Qualcomm UEFI Secure Application")
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Thanks for tracking this down. I can confirm that this fixes the
hypervisor reset I can trigger by repeatedly reading an EFI variable on
the X13s. Before it triggered within minutes, now I ran it for 3 hours
without any issues:

Tested-by: Johan Hovold <johan+linaro@kernel.org>

Even if the patch is a bit large it's straight-forward and fixes a
critical bug so I think this needs to go to stable as well:

Cc: stable@vger.kernel.org	# 6.7

A couple of comments below.

> @@ -277,10 +296,15 @@ static efi_status_t qsee_uefi_get_variable(struct qcuefi_client *qcuefi, const e
>  	unsigned long buffer_size = *data_size;
>  	efi_status_t efi_status = EFI_SUCCESS;
>  	unsigned long name_length;
> +	dma_addr_t cmd_buf_phys;

Throughout the patch, could you please refer to DMA addresses as DMA
addresses rather than physical addresses, for example, by using a "_dma"
rather than "_phys" suffix here?

> +	size_t cmd_buf_size;
> +	void *cmd_buf_virt;

I'd also prefer if you dropped the "_virt" suffix from the buffer
pointers.

> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 49ddbcab06800..fc59688227f43 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1579,46 +1579,26 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_get_id);
>  /**
>   * qcom_scm_qseecom_app_send() - Send to and receive data from a given QSEE app.
>   * @app_id:   The ID of the target app.
> - * @req:      Request buffer sent to the app (must be DMA-mappable).
> + * @req:      Physical address of the request buffer sent to the app.

DMA address

>   * @req_size: Size of the request buffer.
> - * @rsp:      Response buffer, written to by the app (must be DMA-mappable).
> + * @rsp:      Physical address of the response buffer, written to by the app.

DMA address

>   * @rsp_size: Size of the response buffer.
>   *
>   * Sends a request to the QSEE app associated with the given ID and read back
> - * its response. The caller must provide two DMA memory regions, one for the
> - * request and one for the response, and fill out the @req region with the
> + * its response. The caller must provide two physical memory regions, one for

DMA memory

> + * the request and one for the response, and fill out the @req region with the
>   * respective (app-specific) request data. The QSEE app reads this and returns
>   * its response in the @rsp region.
>   *
>   * Return: Zero on success, nonzero on failure.
>   */
> -int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
> -			      size_t rsp_size)
> +int qcom_scm_qseecom_app_send(u32 app_id, dma_addr_t req, size_t req_size,
> +			      dma_addr_t rsp, size_t rsp_size)

And similar throughout.

With that fixed, feel free to add:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan

