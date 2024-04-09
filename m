Return-Path: <linux-kernel+bounces-136289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E691F89D246
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233501C2264D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71A474E09;
	Tue,  9 Apr 2024 06:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1zECHv1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B506B6FE06;
	Tue,  9 Apr 2024 06:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643739; cv=none; b=psXJIEyyeUC3uiOzQ2MuDhi3SOsOBrQg7dMGusJwG30lIMRbP9ehXmb41v7pRMs3Z0dmk8OvxqF7Zv9GWf7afRSGPfBciPckr8n9pBiD3AJkJdxw6aLAQwvXkP3fn9Tl8G3yq3fVNVV4vB4ZpmX4t6IHvv/jmS53buehLfQxGyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643739; c=relaxed/simple;
	bh=Nh8lnA3q14jQOsBsRSAuQstUEjJVkvUUo3UxrFXpQPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUGZrzCKhukFL+JRGV5aIUGyZ/2FkwIJ6+3npyk8I4LUdTj7XJicPQKk0fpgrjAX9Ikmyzcd1mC58y6tMQ7uTDrDybXUzLYmX9DdnKN2hRBpr823F0CyQAkowv6MaY9G8gGMcwosGeoTYQSbBq2k7oqyBmBwES+r1MTVSGvLuAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1zECHv1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712643738; x=1744179738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nh8lnA3q14jQOsBsRSAuQstUEjJVkvUUo3UxrFXpQPo=;
  b=M1zECHv1T1pF+wFA8rdb1/4htbCYVH9AY4I0XkjduzMGTVt7K141tym8
   2KftaYSkP5yxDbJKyByAef0/huR5Hc7EnNyvDMDCVCvfrUX4g7/taO+1S
   pirOUscmJUz1m48iEKK8UKNJefFhPjM1UmY+bMRFniBXY3cQR51RCDzHQ
   Sb2U1G5NvQGUofDVpOxdmd5yXmjtyR6xIo4KfCqudch4Ske8+XQqHRomk
   nQ3rCcs9GuQi3pQMMg8hxf2wpEcPfswRPGVnoXwTte1BZoIxTkcCm6wWD
   NAE4EL3Inx//4UkGNg/n3qvCGLlHLvGBvznOjs1NgpchKBKTUQLMmkcyd
   Q==;
X-CSE-ConnectionGUID: o/Nhe3o5Rweq0fIidCc+0Q==
X-CSE-MsgGUID: jwJ9sZjIQYed/uuNs+KJxg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="18511266"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="18511266"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 23:22:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="937093064"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="937093064"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 08 Apr 2024 23:22:14 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 09 Apr 2024 09:22:13 +0300
Date: Tue, 9 Apr 2024 09:22:13 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/3] usb: typec: ucsi_glink: drop NO_PARTNER_PDOS quirk
 for sm8550 / sm8650
Message-ID: <ZhTelXC4GGj5mzM/@kuha.fi.intel.com>
References: <20240408-qcom-ucsi-fixes-bis-v1-0-716c145ca4b1@linaro.org>
 <20240408-qcom-ucsi-fixes-bis-v1-2-716c145ca4b1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408-qcom-ucsi-fixes-bis-v1-2-716c145ca4b1@linaro.org>

On Mon, Apr 08, 2024 at 04:04:16AM +0300, Dmitry Baryshkov wrote:
> The Qualcomm SM8550 (and via a fallback compat SM8650) firmware properly
> handles the GET_PDOS command, it sends the CCI_BUSY notification,
> and then follows with the CCI_COMMAND_COMPLETE event. Stop using the quirk
> for those two platforms.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 9bd80a2218e4..9ffea20020e7 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -321,7 +321,7 @@ static const struct of_device_id pmic_glink_ucsi_of_quirks[] = {
>  	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = &quirk_sc8280xp, },
>  	{ .compatible = "qcom,sm8350-pmic-glink", .data = &quirk_sc8180x, },
>  	{ .compatible = "qcom,sm8450-pmic-glink", .data = &quirk_sm8450, },
> -	{ .compatible = "qcom,sm8550-pmic-glink", .data = &quirk_sc8280xp, },
> +	{ .compatible = "qcom,sm8550-pmic-glink", .data = &quirk_sm8450, },
>  	{}
>  };
>  
> 
> -- 
> 2.39.2

-- 
heikki

