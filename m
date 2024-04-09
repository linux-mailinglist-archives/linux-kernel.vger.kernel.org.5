Return-Path: <linux-kernel+bounces-137300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DD089E02B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B462B2EA5F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A657613DB9C;
	Tue,  9 Apr 2024 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PnLlylZW"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2783913DB88
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712679329; cv=none; b=THFhN5WWzDYiPzQn+IGVOFpEQjIaH03Y/32SWnYaxE2pyqmfcDMzmCnZ/qQrqujVIOem0c0bYeRiBwZ9j7Jcg0Ae5m/0rhwS/6RlBZnzNgqIePwFN+qfJYSeYPJGZVpsxJPQng1xTWON9vwl75LZOZrYuwdMCy0Jywp6B4o3S9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712679329; c=relaxed/simple;
	bh=X2xmHqO8gXKhPjxwaeID/utS/X/th0bZq4WUqjIW2sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQQ0m4sY7NB8Wjozrd9RJt+7JyfvkY5Zl1j/NZ7078wZsUC7dDEcUq0PrHQhivmIJWXHnhpGLmS+RKkrv7vvpPHQY+tlii7ZO1I4zq93hfxICinMCndmDqIU8cFQv140h5MvmrRpCOYepzs0mzq5LnQ0NDbGfRPIK2TBZeAKamA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PnLlylZW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34339f01cd2so4366495f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712679324; x=1713284124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NdZtD6irNdlXhmhm1A43aB93TmxueujQEV4FlCrB2O0=;
        b=PnLlylZW8d650+Zz6aE5XjDOJu1GVJxPKHLMx2TIxIiZXnuFEvT7ghEG75n5apt6/U
         Ay86pJkhPqWg+eGWHFYHCOO3vgKmOGcQ6c/wiCpif2VlR3z5pyGD/q7RmjillFzGZPQe
         Nh8XDj07n+YOrNaKTG8D0h/+ktSlI/iCZwD8JMi3AWcLnICJypedzf7A88xfTrYOdJcN
         tX5WPj4rrO4C+371kG58CoXNISHPXNhMZA/f3cnjbZl+dwqozvIVhJ5fhwDpq1OJMkew
         RjpaqQ1FFcYxLYawdjIpzmvsBWwubz2K3olNmiKuU5TNJu4Rtfu8kLYp9edJ+SHCqnJG
         Hvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712679324; x=1713284124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdZtD6irNdlXhmhm1A43aB93TmxueujQEV4FlCrB2O0=;
        b=GBcdBmANOIxcvv7+g95NuRXIvV1wdM/wI3My2oEHWxzcKMnmxl5wHxrhrY4Etj6iog
         n9k1efTYQ3jZc3nzCEDTe+RWzmLSTu3KiTjYL/ncGOoWecMCiQMNHb2zOYjqdfhKDlGl
         DRoSssOTxTRP0/v3by3tx5eLzVnMQii3HJmc07uSElBg0O8sBYdRLQU3GeZoC//fwnrL
         x+9HbI9exdsOwpoIaPSj0ltwumdx19qNJ1bwgMKRbSCUsO87EZOTkn9DM5exJR6EWSGK
         xN9vsZcABeB+INhaLAeh6mIWpGQexKt+niHJ2Xire+UFelDee0ax4BoUT43FxA2sZNmM
         VIQw==
X-Forwarded-Encrypted: i=1; AJvYcCU47cTy+Gj3v39sWV5OTSH+yMCDUzXxIAVZpChBqVawDr0txDt2Em4HUF6wSPH0/SaffozG2FR0UqATY//OclxKLKd4uEAQBK6LboWV
X-Gm-Message-State: AOJu0YxL0YfZDb1kuGPpgHncwirfpihbm5ipyKfuDzTUWWvOCfwBvdO1
	fzXJaJEoL8FeddK0czrgmIS1taMxRbUppE5JyJwIGDhxJEmadorUm/YSIZLPsg==
X-Google-Smtp-Source: AGHT+IGGfIBhxH5DQCjXOXjwLQSpl49ieGPZM+MwVbQZknp7RGIYrhHK/YQcv5YCidu4HTjG9iIDmQ==
X-Received: by 2002:a5d:5185:0:b0:33d:b376:8a07 with SMTP id k5-20020a5d5185000000b0033db3768a07mr118036wrv.8.1712679324100;
        Tue, 09 Apr 2024 09:15:24 -0700 (PDT)
Received: from google.com (161.126.77.34.bc.googleusercontent.com. [34.77.126.161])
        by smtp.gmail.com with ESMTPSA id z13-20020a056000110d00b0034174875850sm11895914wrw.70.2024.04.09.09.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 09:15:23 -0700 (PDT)
Date: Tue, 9 Apr 2024 17:15:20 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Sebastian Ene <sebastianene@google.com>
Cc: catalin.marinas@arm.com, james.morse@arm.com, jean-philippe@linaro.org,
	maz@kernel.org, oliver.upton@linux.dev, qperret@google.com,
	qwandor@google.com, sudeep.holla@arm.com, suzuki.poulose@arm.com,
	tabba@google.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Add support for FFA_PARTITION_INFO_GET
Message-ID: <ZhVpmF2js1NJp1qF@google.com>
References: <20240409151908.541589-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409151908.541589-1-sebastianene@google.com>

Hi Seb,

On Tue, Apr 09, 2024 at 03:19:08PM +0000, Sebastian Ene wrote:
> Handle the FFA_PARTITION_INFO_GET host call inside the pKVM hypervisor
> and copy the response message back to the host buffers. Save the
> returned FF-A version as we will need it later to interpret the response
> from the TEE.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/ffa.c | 49 +++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> index 320f2eaa14a9..72fc365bc7a8 100644
> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> @@ -67,6 +67,7 @@ struct kvm_ffa_buffers {
>   */
>  static struct kvm_ffa_buffers hyp_buffers;
>  static struct kvm_ffa_buffers host_buffers;
> +static u32 ffa_version;
>  
>  static void ffa_to_smccc_error(struct arm_smccc_res *res, u64 ffa_errno)
>  {
> @@ -640,6 +641,49 @@ static bool do_ffa_features(struct arm_smccc_res *res,
>  	return true;
>  }
>  
> +static void do_ffa_part_get(struct arm_smccc_res *res,
> +			    struct kvm_cpu_context *ctxt)
> +{
> +	DECLARE_REG(u32, uuid0, ctxt, 1);
> +	DECLARE_REG(u32, uuid1, ctxt, 2);
> +	DECLARE_REG(u32, uuid2, ctxt, 3);
> +	DECLARE_REG(u32, uuid3, ctxt, 4);
> +	DECLARE_REG(u32, flags, ctxt, 5);
> +	u32 off, count, sz, buf_sz;
> +
> +	hyp_spin_lock(&host_buffers.lock);
> +	if (!host_buffers.rx) {
> +		ffa_to_smccc_res(res, FFA_RET_INVALID_PARAMETERS);
> +		goto out_unlock;
> +	}
> +
> +	arm_smccc_1_1_smc(FFA_PARTITION_INFO_GET, uuid0, uuid1,
> +			  uuid2, uuid3, flags, 0, 0,
> +			  res);
> +
> +	if (res->a0 != FFA_SUCCESS)
> +		goto out_unlock;
> +
> +	count = res->a2;
> +	if (!count)
> +		goto out_unlock;

Looking at the table 13.34, it seems what's in "count" depends on the flag.
Shouldn't we check its value, and only memcpy into the host buffers if the flag
is 0?

> +
> +	if (ffa_version > FFA_VERSION_1_0) {
> +		buf_sz = sz = res->a3;
> +		if (sz > sizeof(struct ffa_partition_info))
> +			buf_sz = sizeof(struct ffa_partition_info);

What are you trying to protect against here? We have to trust EL3 anyway, (as
other functions do).

The WARN() could be kept though to make sure we won't overflow our buffer. But
it could be transformed into an error? FFA_RET_ABORTED?


> +	} else {
> +		/* FFA_VERSION_1_0 lacks the size in the response */
> +		buf_sz = sz = 8;
> +	}
> +
> +	WARN_ON((count - 1) * sz + buf_sz > PAGE_SIZE);
> +	for (off = 0; off < count * sz; off += sz)
> +		memcpy(host_buffers.rx + off, hyp_buffers.rx + off, buf_sz);
> +out_unlock:
> +	hyp_spin_unlock(&host_buffers.lock);
> +}
> +
>  bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
>  {
>  	struct arm_smccc_res res;
> @@ -686,6 +730,9 @@ bool kvm_host_ffa_handler(struct kvm_cpu_context *host_ctxt, u32 func_id)
>  	case FFA_MEM_FRAG_TX:
>  		do_ffa_mem_frag_tx(&res, host_ctxt);
>  		goto out_handled;
> +	case FFA_PARTITION_INFO_GET:
> +		do_ffa_part_get(&res, host_ctxt);
> +		break;
>  	}
>  
>  	if (ffa_call_supported(func_id))
> @@ -726,6 +773,8 @@ int hyp_ffa_init(void *pages)
>  	if (FFA_MAJOR_VERSION(res.a0) != 1)
>  		return -EOPNOTSUPP;
>  
> +	ffa_version = res.a0;
> +
>  	arm_smccc_1_1_smc(FFA_ID_GET, 0, 0, 0, 0, 0, 0, 0, &res);
>  	if (res.a0 != FFA_SUCCESS)
>  		return -EOPNOTSUPP;
> -- 
> 2.44.0.478.gd926399ef9-goog
> 

