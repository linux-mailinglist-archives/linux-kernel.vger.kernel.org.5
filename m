Return-Path: <linux-kernel+bounces-89556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7C386F1F9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E475DB220E9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A08C3FBA6;
	Sat,  2 Mar 2024 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JE0xQNfp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE9C1E50B;
	Sat,  2 Mar 2024 18:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709405871; cv=none; b=qmbb5Ttd8CsfT38MdyZuW8YYACD6Jxc94Qj4jRci2TSFJ4etnUN3Ahyg30k49sunaEIdBL9zDldzBYUnvT9dhueWp2g5Cuw3wv3SqLdx1wYanpxM8e57pPql5PM5yHN6K9Vxjv7V4+DZoTKYsUp4arrjQ1R+Gy+CRYjIRGCP1Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709405871; c=relaxed/simple;
	bh=Y5on3xL5P+E7c3LfCjkUCKQkUwFWI0Su800NNToFbok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0JbvBgaSFogsSsQM8EvVzcuj+xdrAUNXJWBx0u7W3lKBvAT7sirgyjBpM1KxWA5jkjezUi1nNaDTekNXMZSenFDhwPYbHxDRS1bEBUHs4rJRwcdIditj6dk5Vl0gUN2vRxCbGmWCfhYLPe9F86vblqBJoSIgBCAHRk/2Zbd6oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JE0xQNfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3D3C433F1;
	Sat,  2 Mar 2024 18:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709405870;
	bh=Y5on3xL5P+E7c3LfCjkUCKQkUwFWI0Su800NNToFbok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JE0xQNfpCD/rNyi4EFTh9nMVNIRIC4GnEoDFX6KPKsHBMAODKkDktGfi7gD1DWuAB
	 1o/qt+XkC2qASfUancjFUgZa+Oe5n3UgIW5wUEMQsMVZKHcH4lVYBDfqWJlxhRCNyV
	 7HnFdRvGJ003jnkx+CNMvOWoM2XDvAt/BhuWpCMKyOO/BreISDpWnyqc8p4Egz0eVK
	 vPosRN1VipC4MkC9LOe6SGvEbhvQVlwvfEQK/9a8/dqf98XPgs+uQ2guU0vdgjaS6e
	 lg7MpIITQyuph5aFNSWxfjwiVMOKJHR8Qd1rhPThDgslbvzAQ/ki6qa5+ckLCudTrA
	 a/UBquQWxlzGQ==
Date: Sat, 2 Mar 2024 12:57:47 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linus.walleij@linaro.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v12 8/9] firmware: qcom: scm: Add check to prevent Null
 pointer dereference
Message-ID: <vouu7wme3guxivbvphafehazewq2gqw5xvazj6wq5pgmsct55a@r5cabs6qy3kj>
References: <20240227155308.18395-1-quic_mojha@quicinc.com>
 <20240227155308.18395-9-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227155308.18395-9-quic_mojha@quicinc.com>

On Tue, Feb 27, 2024 at 09:23:07PM +0530, Mukesh Ojha wrote:
> There are multiple place in SCM driver __scm->dev is being
> accessed without checking if it is valid

Why is this a problem?

> or not and all
> not all of function needs the device but it is needed
> for some cases when the number of argument passed is more
> and dma_map_single () api is used.
> 

Why can't we just always pass NULL in these cases then?

> Add a NULL check for the cases when it is fine even to pass
> device as NULL and add qcom_scm_is_available() check for
> cases when it is needed for DMA api's.
> 

It could be argued that returning an error for this scenario could be
making things more robust. But I can see no scenario where the calling
driver would be able to react in a suitable way when getting
-EPROBE_DEFERRED back.

Our current philosophy is that the client will do probe deferral by
invoking qcom_scm_is_available() at probe time. Please provide an
adequate description of the problem that you're solving by introducing
all these checks.

And pick a return value that is appropriate for the context these
functions are being expected to be called in.


PS. Why are you extending the scope of this series? You're just making
sure that your original patches aren't getting merged.

Regards,
Bjorn

> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 88 ++++++++++++++++++++++++--------
>  1 file changed, 66 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 6f14254c0c10..a1dce417e6ec 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -465,7 +465,7 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
>  	struct qcom_scm_res res;
>  	int ret;
>  
> -	ret = qcom_scm_call(__scm->dev, &desc, &res);
> +	ret = qcom_scm_call(__scm ? __scm->dev : NULL, &desc, &res);
>  
>  	return ret ? : res.result[0];
>  }
> @@ -591,6 +591,9 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
>  	};
>  	struct qcom_scm_res res;
>  
> +	if (!qcom_scm_is_available())
> +		return -EPROBE_DEFER;
> +
>  	/*
>  	 * During the scm call memory protection will be enabled for the meta
>  	 * data blob, so make sure it's physically contiguous, 4K aligned and
> @@ -637,6 +640,9 @@ EXPORT_SYMBOL_GPL(qcom_scm_pas_init_image);
>   */
>  void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx)
>  {
> +	if (!qcom_scm_is_available())
> +		return -EPROBE_DEFER;
> +
>  	if (!ctx->ptr)
>  		return;
>  
> @@ -671,6 +677,9 @@ int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr, phys_addr_t size)
>  	};
>  	struct qcom_scm_res res;
>  
> +	if (!qcom_scm_is_available())
> +		return -EPROBE_DEFER;
> +
>  	ret = qcom_scm_clk_enable();
>  	if (ret)
>  		return ret;
> @@ -706,6 +715,9 @@ int qcom_scm_pas_auth_and_reset(u32 peripheral)
>  	};
>  	struct qcom_scm_res res;
>  
> +	if (!qcom_scm_is_available())
> +		return -EPROBE_DEFER;
> +
>  	ret = qcom_scm_clk_enable();
>  	if (ret)
>  		return ret;
> @@ -740,6 +752,9 @@ int qcom_scm_pas_shutdown(u32 peripheral)
>  	};
>  	struct qcom_scm_res res;
>  
> +	if (!qcom_scm_is_available())
> +		return -EPROBE_DEFER;
> +
>  	ret = qcom_scm_clk_enable();
>  	if (ret)
>  		return ret;
> @@ -776,11 +791,11 @@ bool qcom_scm_pas_supported(u32 peripheral)
>  	};
>  	struct qcom_scm_res res;
>  
> -	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
> +	if (!__qcom_scm_is_call_available(__scm ? __scm->dev : NULL, QCOM_SCM_SVC_PIL,
>  					  QCOM_SCM_PIL_PAS_IS_SUPPORTED))
>  		return false;
>  
> -	ret = qcom_scm_call(__scm->dev, &desc, &res);
> +	ret = qcom_scm_call(__scm ? __scm->dev : NULL, &desc, &res);
>  
>  	return ret ? false : !!res.result[0];
>  }
> @@ -840,7 +855,7 @@ int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val)
>  	int ret;
>  
>  
> -	ret = qcom_scm_call_atomic(__scm->dev, &desc, &res);
> +	ret = qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, &res);
>  	if (ret >= 0)
>  		*val = res.result[0];
>  
> @@ -859,7 +874,7 @@ int qcom_scm_io_writel(phys_addr_t addr, unsigned int val)
>  		.owner = ARM_SMCCC_OWNER_SIP,
>  	};
>  
> -	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
> +	return qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, NULL);
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_io_writel);
>  
> @@ -871,7 +886,8 @@ EXPORT_SYMBOL_GPL(qcom_scm_io_writel);
>   */
>  bool qcom_scm_restore_sec_cfg_available(void)
>  {
> -	return __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_MP,
> +	return __qcom_scm_is_call_available(__scm ? __scm->dev : NULL,
> +					    QCOM_SCM_SVC_MP,
>  					    QCOM_SCM_MP_RESTORE_SEC_CFG);
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_restore_sec_cfg_available);
> @@ -889,7 +905,7 @@ int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare)
>  	struct qcom_scm_res res;
>  	int ret;
>  
> -	ret = qcom_scm_call(__scm->dev, &desc, &res);
> +	ret = qcom_scm_call(__scm ? __scm->dev : NULL, &desc, &res);
>  
>  	return ret ? : res.result[0];
>  }
> @@ -907,7 +923,7 @@ int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size)
>  	struct qcom_scm_res res;
>  	int ret;
>  
> -	ret = qcom_scm_call(__scm->dev, &desc, &res);
> +	ret = qcom_scm_call(__scm ? __scm->dev : NULL, &desc, &res);
>  
>  	if (size)
>  		*size = res.result[0];
> @@ -930,7 +946,7 @@ int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare)
>  	};
>  	int ret;
>  
> -	ret = qcom_scm_call(__scm->dev, &desc, NULL);
> +	ret = qcom_scm_call(__scm ? __scm->dev : NULL, &desc, NULL);
>  
>  	/* the pg table has been initialized already, ignore the error */
>  	if (ret == -EPERM)
> @@ -951,7 +967,7 @@ int qcom_scm_iommu_set_cp_pool_size(u32 spare, u32 size)
>  		.owner = ARM_SMCCC_OWNER_SIP,
>  	};
>  
> -	return qcom_scm_call(__scm->dev, &desc, NULL);
> +	return qcom_scm_call(__scm ? __scm->dev : NULL, &desc, NULL);
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_iommu_set_cp_pool_size);
>  
> @@ -973,7 +989,7 @@ int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
>  	};
>  	struct qcom_scm_res res;
>  
> -	ret = qcom_scm_call(__scm->dev, &desc, &res);
> +	ret = qcom_scm_call(__scm ? __scm->dev : NULL, &desc, &res);
>  
>  	return ret ? : res.result[0];
>  }
> @@ -1038,6 +1054,9 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
>  	int ret, i, b;
>  	u64 srcvm_bits = *srcvm;
>  
> +	if (!qcom_scm_is_available())
> +		return -EPROBE_DEFER;
> +
>  	src_sz = hweight64(srcvm_bits) * sizeof(*src);
>  	mem_to_map_sz = sizeof(*mem_to_map);
>  	dest_sz = dest_cnt * sizeof(*destvm);
> @@ -1093,7 +1112,8 @@ EXPORT_SYMBOL_GPL(qcom_scm_assign_mem);
>   */
>  bool qcom_scm_ocmem_lock_available(void)
>  {
> -	return __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_OCMEM,
> +	return __qcom_scm_is_call_available(__scm ? __scm->dev : NULL,
> +					    QCOM_SCM_SVC_OCMEM,
>  					    QCOM_SCM_OCMEM_LOCK_CMD);
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_ocmem_lock_available);
> @@ -1120,7 +1140,7 @@ int qcom_scm_ocmem_lock(enum qcom_scm_ocmem_client id, u32 offset, u32 size,
>  		.arginfo = QCOM_SCM_ARGS(4),
>  	};
>  
> -	return qcom_scm_call(__scm->dev, &desc, NULL);
> +	return qcom_scm_call(__scm ? __scm->dev : NULL, &desc, NULL);
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_ocmem_lock);
>  
> @@ -1143,7 +1163,7 @@ int qcom_scm_ocmem_unlock(enum qcom_scm_ocmem_client id, u32 offset, u32 size)
>  		.arginfo = QCOM_SCM_ARGS(3),
>  	};
>  
> -	return qcom_scm_call(__scm->dev, &desc, NULL);
> +	return qcom_scm_call(__scm ? __scm->dev : NULL, &desc, NULL);
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_ocmem_unlock);
>  
> @@ -1155,9 +1175,11 @@ EXPORT_SYMBOL_GPL(qcom_scm_ocmem_unlock);
>   */
>  bool qcom_scm_ice_available(void)
>  {
> -	return __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_ES,
> +	return __qcom_scm_is_call_available(__scm ? __scm->dev : NULL,
> +					    QCOM_SCM_SVC_ES,
>  					    QCOM_SCM_ES_INVALIDATE_ICE_KEY) &&
> -		__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_ES,
> +		__qcom_scm_is_call_available(__scm ?__scm->dev : NULL,
> +					     QCOM_SCM_SVC_ES,
>  					     QCOM_SCM_ES_CONFIG_SET_ICE_KEY);
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_ice_available);
> @@ -1184,7 +1206,7 @@ int qcom_scm_ice_invalidate_key(u32 index)
>  		.owner = ARM_SMCCC_OWNER_SIP,
>  	};
>  
> -	return qcom_scm_call(__scm->dev, &desc, NULL);
> +	return qcom_scm_call(__scm ?__scm->dev : NULL, &desc, NULL);
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_ice_invalidate_key);
>  
> @@ -1228,6 +1250,9 @@ int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
>  	dma_addr_t key_phys;
>  	int ret;
>  
> +	if (!qcom_scm_is_available())
> +		return -EPROBE_DEFER;
> +
>  	/*
>  	 * 'key' may point to vmalloc()'ed memory, but we need to pass a
>  	 * physical address that's been properly flushed.  The sanctioned way to
> @@ -1262,7 +1287,12 @@ EXPORT_SYMBOL_GPL(qcom_scm_ice_set_key);
>  bool qcom_scm_hdcp_available(void)
>  {
>  	bool avail;
> -	int ret = qcom_scm_clk_enable();
> +	int ret;
> +
> +	if (!qcom_scm_is_available())
> +		return -EPROBE_DEFER;
> +
> +	ret = qcom_scm_clk_enable();
>  
>  	if (ret)
>  		return ret;
> @@ -1307,6 +1337,9 @@ int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp)
>  	};
>  	struct qcom_scm_res res;
>  
> +	if (!qcom_scm_is_available())
> +		return -EPROBE_DEFER;
> +
>  	if (req_cnt > QCOM_SCM_HDCP_MAX_REQ_CNT)
>  		return -ERANGE;
>  
> @@ -1335,7 +1368,7 @@ int qcom_scm_iommu_set_pt_format(u32 sec_id, u32 ctx_num, u32 pt_fmt)
>  		.owner = ARM_SMCCC_OWNER_SIP,
>  	};
>  
> -	return qcom_scm_call(__scm->dev, &desc, NULL);
> +	return qcom_scm_call(__scm ? __scm->dev : NULL, &desc, NULL);
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_iommu_set_pt_format);
>  
> @@ -1351,13 +1384,15 @@ int qcom_scm_qsmmu500_wait_safe_toggle(bool en)
>  	};
>  
>  
> -	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
> +	return qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, NULL);
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_qsmmu500_wait_safe_toggle);
>  
>  bool qcom_scm_lmh_dcvsh_available(void)
>  {
> -	return __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_LMH, QCOM_SCM_LMH_LIMIT_DCVSH);
> +	return __qcom_scm_is_call_available(__scm ? __scm->dev : NULL,
> +					    QCOM_SCM_SVC_LMH,
> +					    QCOM_SCM_LMH_LIMIT_DCVSH);
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh_available);
>  
> @@ -1371,7 +1406,7 @@ int qcom_scm_lmh_profile_change(u32 profile_id)
>  		.owner = ARM_SMCCC_OWNER_SIP,
>  	};
>  
> -	return qcom_scm_call(__scm->dev, &desc, NULL);
> +	return qcom_scm_call(__scm ? __scm->dev : NULL, &desc, NULL);
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_lmh_profile_change);
>  
> @@ -1394,6 +1429,9 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
>  		.owner = ARM_SMCCC_OWNER_SIP,
>  	};
>  
> +	if (!qcom_scm_is_available())
> +		return -EPROBE_DEFER;
> +
>  	payload_buf = dma_alloc_coherent(__scm->dev, payload_size, &payload_phys, GFP_KERNEL);
>  	if (!payload_buf)
>  		return -ENOMEM;
> @@ -1568,6 +1606,9 @@ int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id)
>  	char *name_buf;
>  	int status;
>  
> +	if (!qcom_scm_is_available())
> +		return -EPROBE_DEFER;
> +
>  	if (app_name_len >= name_buf_size)
>  		return -EINVAL;
>  
> @@ -1638,6 +1679,9 @@ int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size, void *rsp,
>  	dma_addr_t rsp_phys;
>  	int status;
>  
> +	if (!qcom_scm_is_available())
> +		return -EPROBE_DEFER;
> +
>  	/* Map request buffer */
>  	req_phys = dma_map_single(__scm->dev, req, req_size, DMA_TO_DEVICE);
>  	status = dma_mapping_error(__scm->dev, req_phys);
> -- 
> 2.43.0.254.ga26002b62827
> 

