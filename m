Return-Path: <linux-kernel+bounces-49185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5138466EB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3DDFB21104
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37591EAEF;
	Fri,  2 Feb 2024 04:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdbHofBP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CB3E549;
	Fri,  2 Feb 2024 04:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706847558; cv=none; b=QJVjo8VdimQXutv89SVeA8o1XzRtUNRinx2f4+idlk9Q4CThEEZFzUe9sHyEbQgibmNIww+odAVtagRGbzt5b8ILlA2FPxq7I6phpZC4JCkilBbbZ1dRQrJElkdnvE/xkCkUt5FTBrQ6LfYQembXspmgJxLx8zYYKcqjaJ3CFDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706847558; c=relaxed/simple;
	bh=u3RNVotf+u/sSIA0AiKwHpc1rA1KTzE5j8nZ7SYlHAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzN+5sqINoIEHIPtXzkZT8BhOvRgAekr2/m2+5w8yAXRiCtbT/06WMTEoh98TjA6xP1daQARK0h7jVrbKVvUU1eCxcU6Nit5rJ2tabOk10Ye+oA3x+b18W2JvLtkCFlowE9WT+tvpnm7MXx9a+A8UUVoFB5nEtYiDw/JD5bvaoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdbHofBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138D1C433F1;
	Fri,  2 Feb 2024 04:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706847557;
	bh=u3RNVotf+u/sSIA0AiKwHpc1rA1KTzE5j8nZ7SYlHAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BdbHofBPLyDEKgksKVQoTno6fQlvfLG+5+xg+BtMsxf6FB7rAGYSC1qRH0Ri7mLhN
	 5HthX6rDsO6bcBWFkavVBT2tKGDlE7E8lUTZph18c2Iv7gOJuQmkuQg9uq29tAEYjA
	 NKKoLQleSTAbMcswFelfOtxekIg7NmgDa0Bw7C1W6HUUOagbqKREp9olWX1O3gkXH/
	 REFHyQHqdWROlTwnLO2yLwHpj1j5mm1PasAQb1FfoPKE1QEML419yPbsFOiM8ee9h9
	 K0hETD9jQ5bRq28sFjWu5ypwegPF0WCwsItHs3fWf9u2rqHGJObCnU/+GJWvlw74j4
	 9cOpw34Pid9Ww==
Date: Thu, 1 Feb 2024 22:19:15 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] thermal/of: Assume polling-delay(-passive) 0 when
 absent
Message-ID: <abgxh5s6e4w65iir2d3oncbwtmhufhg5xtyyukhsrrhe755gam@nhxeqsz35rxb>
References: <20240125-topic-thermal-v1-0-3c9d4dced138@linaro.org>
 <20240125-topic-thermal-v1-2-3c9d4dced138@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125-topic-thermal-v1-2-3c9d4dced138@linaro.org>

On Thu, Jan 25, 2024 at 01:11:16PM +0100, Konrad Dybcio wrote:
> Currently, thermal zones associated with providers that have interrupts
> for signaling hot/critical trips are required to set a polling-delay
> of 0 to indicate no polling. This feels a bit backwards.
> 
> Change the code such that "no polling delay" also means "no polling".
> 
> Suggested-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/thermal/thermal_of.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 4d6c22e0ed85..61bbd42aa2cb 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -225,14 +225,18 @@ static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdel
>  	int ret;
>  
>  	ret = of_property_read_u32(np, "polling-delay-passive", pdelay);
> -	if (ret < 0) {
> -		pr_err("%pOFn: missing polling-delay-passive property\n", np);
> +	if (ret == -EINVAL) {
> +		*pdelay = 0;
> +	} else if (ret < 0) {
> +		pr_err("%pOFn: Couldn't get polling-delay-passive: %d\n", np, ret);
>  		return ret;
>  	}
>  
>  	ret = of_property_read_u32(np, "polling-delay", delay);
> -	if (ret < 0) {
> -		pr_err("%pOFn: missing polling-delay property\n", np);
> +	if (ret == -EINVAL) {
> +		*delay = 0;
> +	} else if (ret < 0) {
> +		pr_err("%pOFn: Couldn't get polling-delay: %d\n", np, ret);
>  		return ret;
>  	}
>  
> 
> -- 
> 2.40.1
> 

