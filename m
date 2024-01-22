Return-Path: <linux-kernel+bounces-34164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5AE8374D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BE0288B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C4C47F51;
	Mon, 22 Jan 2024 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AirggS/7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3678647F44;
	Mon, 22 Jan 2024 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705957543; cv=none; b=CMn0T/BNDyS97WRC9mQ1fWNVQruaEdM+/3wwDe6tr9fXgLUo6M7zP6lHIHGZDE3+gXfteehUx+TdzbbVCOaQhe1B48x8TbuCcSY4lXffjzMeeB10LEOuwW8puvZtwGTzxm3goqnMLwiXofY6cMsbojPbQbe2tlKOzteBrkIAaOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705957543; c=relaxed/simple;
	bh=wJKg6MJTVUpbl5/q7sOSYMw2DJ7xmnzIkke3XzQ5k3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jL1yKOq8XDvGz7ZVmVFhexR4Ec5TP5jzOcXxeTpBRWpnwkCasnehwIHiHDmMjiGAMQfW8S2FFLc3bT/fy4ed6RpQNaxgxjk5Bw36h4kehZT5C8gPntP2bwDZ2BXC/iYwmjoidJfAf4vHXlQC7bKtyPDkMthFLZhOUdXFeBrUKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AirggS/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62D1C433F1;
	Mon, 22 Jan 2024 21:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705957542;
	bh=wJKg6MJTVUpbl5/q7sOSYMw2DJ7xmnzIkke3XzQ5k3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AirggS/7uEPAffpwg71n8Copbxwqi/bbwnrfCNb428JinqfAwgH58mtJiwOJnS6MH
	 2oU1BAJEQ9YZRSsGuKYK+oZZMFAXIPLKap+Pxey5omKg8jZcez/7lNVVTEO6IEyK0q
	 8+7egxnUdBgHPTlnTMNKFGJ9E0aEorIWJfCMQmQdFmKTC3SWkjrTxe+dTRkNj81Fwy
	 gwtePA43AgWyTnDIaIZBkANpNLgE8vvcBso1hnPWbUHve7oFarrN4+pb3gsjB0nja/
	 j+W0YPCgLFfuRYLbrOCpvC9XBV3TQPyzbddLzgdOBASoPj1O7QBQMvhEEeGegPPVx8
	 uJ9yMmAnpR+/w==
Date: Mon, 22 Jan 2024 21:05:38 +0000
From: Simon Horman <horms@kernel.org>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Taku Izumi <izumi.taku@jp.fujitsu.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fjes: fix memleaks in fjes_hw_setup
Message-ID: <20240122210538.GJ126470@kernel.org>
References: <20240122172445.3841883-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122172445.3841883-1-alexious@zju.edu.cn>

On Tue, Jan 23, 2024 at 01:24:42AM +0800, Zhipeng Lu wrote:
> In fjes_hw_setup, it allocates several memory and delay the deallocation
> to the fjes_hw_exit in fjes_probe through the following call chain:
> 
> fjes_probe
>   |-> fjes_hw_init
>         |-> fjes_hw_setup
>   |-> fjes_hw_exit
> 
> However, when fjes_hw_setup fails, fjes_hw_exit won't be called and thus
> all the resources allocated in fjes_hw_setup will be leaked. In this
> patch, we free those resources in fjes_hw_setup and prevents such leaks.
> 
> Fixes: 2fcbca687702 ("fjes: platform_driver's .probe and .remove routine")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>

Hi Zhipeng Lu,

It looks like the last non-trivial change to this driver was in 2016.
So perhaps it is better to leave it be.

But if not, this patch does look correct to me.

Reviewed-by: Simon Horman <horms@kernel.org>

..

> @@ -273,6 +277,25 @@ static int fjes_hw_setup(struct fjes_hw *hw)
>  	fjes_hw_init_command_registers(hw, &param);
>  
>  	return 0;
> +
> +free_epbuf:
> +	for (epidx = 0; epidx < hw->max_epid ; epidx++) {
> +		if (epidx == hw->my_epid)
> +			continue;
> +		fjes_hw_free_epbuf(&hw->ep_shm_info[epidx].tx);
> +		fjes_hw_free_epbuf(&hw->ep_shm_info[epidx].rx);
> +	}
> +	fjes_hw_free_shared_status_region(hw);
> +free_res_buf:
> +	kfree(hw->hw_info.res_buf);
> +	hw->hw_info.res_buf = NULL;
> +free_req_buf:
> +	kfree(hw->hw_info.req_buf);
> +	hw->hw_info.req_buf = NULL;
> +free_ep_info:
> +	kfree(hw->ep_shm_info);
> +	hw->ep_shm_info = NULL;
> +	return result;

FWIIW, I'm not sure it is necessary to set these pointers NULL,
although it doesn't do any harm.

Also, if this function returns an error,
does the caller (fjes_hw_init()) leak hw->hw_info.trace?

>  }
>  
>  static void fjes_hw_cleanup(struct fjes_hw *hw)
> -- 
> 2.34.1
> 

