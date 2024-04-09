Return-Path: <linux-kernel+bounces-136287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F152989D243
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC683282A1C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E2D7442A;
	Tue,  9 Apr 2024 06:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cc1Iu3lk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B24524AF;
	Tue,  9 Apr 2024 06:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643709; cv=none; b=cNVIf7lz4A1gIhQJoB26QLawDH69n33lQl2g1SefVWgLVINHmJsWPc4B/MdXaiiOzSdNa7tfVf2555oUi0gdsQbdw2BIDhJ979cC+2/p5rsnu3vixGZiOkrx7jKb72eV889z/fYjot5gR12eaLTYDdxtdxE7ydJrueKufxFYuU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643709; c=relaxed/simple;
	bh=Ms85OtBRY5/th1IVEna3gfWVATxCC+stAFK8L5Q3J0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhRYya+FGFq++WAXiD9vm/lCgH57UrXHA/J4gAhxAre49epGcb+I9AxmrYx9v1G595+wPP7LZ4n9WMiaPoEccX4RK54/zYcr3x1uSf4y/6rCEfYCk4xjSHhMm+zRTZjtjj95ECctYbs7OtZrddCW5+vb373rUQhJfu6ENcLUU9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cc1Iu3lk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712643708; x=1744179708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ms85OtBRY5/th1IVEna3gfWVATxCC+stAFK8L5Q3J0U=;
  b=cc1Iu3lk0+8GeFLW7mt5UXkFm7x8LLJOGytMYzvCyor7pE0JOe+66b9x
   O/IGJ3jtch4jt3H+OqCzpmnDVFo7Sh5nsRjU7spOn4X2ew/CvnPkKbMFz
   EIzYMLVG6WerAh5kjEFBtWvvWlxMQLC5DGhHwamJJcH7+J2IgoQ0jd+a1
   szWyiP//YyRAcCCt7lPKyJenbrYpg9cHfionb1s/ci4B5Rr4O1HPdOigi
   UaYEug3WU2vivAz3W/xKAVZnCf1RkbjDLkKdHac92tXrzdG+ddTC19ikB
   wp4FJAbVCLCiBNlNiZWIO+cWTiv1ukh09hOjd1z+QPYzRH0nm7ccjxNbt
   w==;
X-CSE-ConnectionGUID: 4mWKPn8zQPe1iDtgmQmPUw==
X-CSE-MsgGUID: DXk42UIISY+4etfSbKyo0Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="18511227"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="18511227"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 23:21:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="937093063"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="937093063"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 08 Apr 2024 23:21:43 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 09 Apr 2024 09:21:43 +0300
Date: Tue, 9 Apr 2024 09:21:43 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: typec: ucsi_glink: enable the
 UCSI_DELAY_DEVICE_PDOS quirk on qcm6490
Message-ID: <ZhTed0fsJbYhMGrN@kuha.fi.intel.com>
References: <20240408-qcom-ucsi-fixes-bis-v1-0-716c145ca4b1@linaro.org>
 <20240408-qcom-ucsi-fixes-bis-v1-1-716c145ca4b1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408-qcom-ucsi-fixes-bis-v1-1-716c145ca4b1@linaro.org>

On Mon, Apr 08, 2024 at 04:04:15AM +0300, Dmitry Baryshkov wrote:
> Enable the UCSI_DELAY_DEVICE_PDOS quirk on Qualcomm QCM6490. This
> platform also doesn't correctly handle reading PD capabilities until PD
> partner is connected.
> 
> Fixes: 5da727f75823 ("usb: typec: ucsi_glink: enable the UCSI_DELAY_DEVICE_PDOS quirk")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index ef00a6563c88..9bd80a2218e4 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -316,7 +316,7 @@ static unsigned long quirk_sc8280xp = UCSI_NO_PARTNER_PDOS | UCSI_DELAY_DEVICE_P
>  static unsigned long quirk_sm8450 = UCSI_DELAY_DEVICE_PDOS;
>  
>  static const struct of_device_id pmic_glink_ucsi_of_quirks[] = {
> -	{ .compatible = "qcom,qcm6490-pmic-glink", .data = &quirk_sc8180x, },
> +	{ .compatible = "qcom,qcm6490-pmic-glink", .data = &quirk_sc8280xp, },
>  	{ .compatible = "qcom,sc8180x-pmic-glink", .data = &quirk_sc8180x, },
>  	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = &quirk_sc8280xp, },
>  	{ .compatible = "qcom,sm8350-pmic-glink", .data = &quirk_sc8180x, },
> 
> -- 
> 2.39.2

-- 
heikki

