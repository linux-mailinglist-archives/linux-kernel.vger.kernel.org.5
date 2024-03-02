Return-Path: <linux-kernel+bounces-89560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C41186F20E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 20:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00531B21F19
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08F83FE42;
	Sat,  2 Mar 2024 19:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKx14BmR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2942D179BC;
	Sat,  2 Mar 2024 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709406994; cv=none; b=iI1/wICHjIyYZDOIqENf8zC87eLwZ/zwItNJ89lYNGoBsTmfqrf2GZYqotbY2nieqN7rgowMQWqiVA3rY4ofnrrwFFM1IVOFJiccvZ0d1y5/Qi7EBhaJCxQq+qhSzZeTO9t/MjGkwlZqhjsHoAtVi8KuRLYyMKwKLC47MJGgkHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709406994; c=relaxed/simple;
	bh=6uKqzesLvqHEgYebIyWInu24CBcwI/5c3amNwqZbR74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfwpLwAINjNCaIumCoSzCcjZHt7lqCqc+mnrIhe19IPS7Skf3YGn46KxE5XsIZ5WV6REXbRQBqliRLCmRrZt3uj34C3QqsWstCzt15KpfN4HQGci1g9KkwBgNSPrudqqULL62hiNWo39+nAeB1VnUEVuYoBrDuyXEnfRO5xaVCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKx14BmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14880C433C7;
	Sat,  2 Mar 2024 19:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709406993;
	bh=6uKqzesLvqHEgYebIyWInu24CBcwI/5c3amNwqZbR74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GKx14BmRhXilLbwt7DTSz8ViSleklHQZGY7bpm6WjUFmHbCGf3VPoZyx+E5WvysI3
	 2OHN9sQXTdIAvcZv1uXjO4yh8lfgnL5iQJuGwttGvhZRRouX6ylmg7pVrOndKESbX4
	 73pxBh7UKtMLXQI0mmPAHBJMABSZY5CmVbXK17gTiTki3M4K4ABx6/u2zojz3OrNe4
	 zS1Iq9z+2TM84q83EhVFfdLTPoeUOc52HD9QMZIH4dp0m/6ISS7ZCkAwHzJoNjxIpO
	 wtRC5s4mzFM1vYCyjxa+0Qarl+so2hEoC0Uro4RIMPg38g4zI5bAFr5AkoIeSNTgqE
	 a/g08jyVagDCA==
Date: Sat, 2 Mar 2024 13:16:31 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH v12 4/9] firmware: qcom: scm: Rework dload mode
 availability check
Message-ID: <bmwswdvzqldse4dgbcev7hcyktkzffur3pcs6ogwnekxrklgiu@hridh2l2hhgk>
References: <20240227155308.18395-1-quic_mojha@quicinc.com>
 <20240227155308.18395-5-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227155308.18395-5-quic_mojha@quicinc.com>

On Tue, Feb 27, 2024 at 09:23:03PM +0530, Mukesh Ojha wrote:
> QCOM_SCM_BOOT_SET_DLOAD_MODE was only valid for very older
> target and firmware and for recent targets there is dload
> mode tcsr registers available to set the download mode.
> 

I presume this implies that it will always return false, so what's the
actual problem with that? Presumably you want this because it takes
unnecessary time to make that call, if so please say so.


Content of the patch looks good.

Regards,
Bjorn

> So, it is better to keep it as fallback check instead of
> checking its availability and failing it always.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index bd6bfdf2d828..3fd89cddba3b 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -540,18 +540,16 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>  static void qcom_scm_set_download_mode(bool enable)
>  {
>  	u32 val = enable ? QCOM_DLOAD_FULLDUMP : QCOM_DLOAD_NODUMP;
> -	bool avail;
>  	int ret = 0;
>  
> -	avail = __qcom_scm_is_call_available(__scm->dev,
> -					     QCOM_SCM_SVC_BOOT,
> -					     QCOM_SCM_BOOT_SET_DLOAD_MODE);
> -	if (avail) {
> -		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
> -	} else if (__scm->dload_mode_addr) {
> +	if (__scm->dload_mode_addr) {
>  		ret = qcom_scm_io_rmw(__scm->dload_mode_addr,
>  				      QCOM_DLOAD_MASK,
>  				      FIELD_PREP(QCOM_DLOAD_MASK, val));
> +	} else if (__qcom_scm_is_call_available(__scm->dev,
> +						QCOM_SCM_SVC_BOOT,
> +						QCOM_SCM_BOOT_SET_DLOAD_MODE)) {
> +		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>  	} else {
>  		dev_err(__scm->dev,
>  			"No available mechanism for setting download mode\n");
> -- 
> 2.43.0.254.ga26002b62827
> 

