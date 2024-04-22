Return-Path: <linux-kernel+bounces-153281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3898ACBDC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315B228709A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087F31465B5;
	Mon, 22 Apr 2024 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klOLCA3C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D0926AE6;
	Mon, 22 Apr 2024 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784817; cv=none; b=IvYlw1SFmJrNdCDScLVKeOTP6d7aU/CYBFgQWVT5Wzuwxnn9UUaVl4y0ZpV+z6646eOv6ysaYBF4Yu4v1P6Pk7HLl064HvaHj+Ka71gKZXJtmorwvdz84j23eCYKTaalm/kgHVyftlC7VIM5p+k4AHx8L8ODAgVbSZjoO+hrPMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784817; c=relaxed/simple;
	bh=peJlaEP3npLkD0x6snY34z5YAN5kJtFZrZZcayWj6tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rd2XVfFPgmL6E21HWWInvLJgvEaLL9tl74f4SL2E4b0WyThmNhVa9Y4d9g50SkWb60sCUaIKaFiDU37WNZzRyVQlceojVt3vgKKf61FJciGKVMPNJDihBFzLjePERQFI98CrL4HXamhHGZu7HDp+JfakcNeCG5cgQW2M0otxank=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klOLCA3C; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713784816; x=1745320816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=peJlaEP3npLkD0x6snY34z5YAN5kJtFZrZZcayWj6tU=;
  b=klOLCA3CQKuOhXq4yAnOgvEdhT+ZQlxqviJLI8bGdmLW+JjQccITDrs4
   wv3cv5N+YG39Jv+Zcy7rYOQcLbCXAytXFs1IEXGN94hY02rV6DmheaN2H
   XoqAOney1gYdg2zt79cc3oRNd/eHXpChmglTC5hmbzDhLVTElarmAJAWd
   0bUHdfv2fZ58tAp6KJh8gGjVsR4S3PvyiLg3ZV0obEElNaHv94oIAjnPG
   aSocdy101jOddTjcojxM15Wwh4FcA5DoteJEvgFyNCmHxkRU0likOK7TM
   5ssXofZhh6HriSih5WFBGRn+Ee8Bx87LpflJtKue45gYy31MaS9NGiJtn
   g==;
X-CSE-ConnectionGUID: f6X4ND2USwqEPyYO2opvTw==
X-CSE-MsgGUID: Q3mA5KnDQTqKiMRsuvVwBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="26767058"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="26767058"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 04:20:15 -0700
X-CSE-ConnectionGUID: LGv1o4TXRsqQ7yYIlkrABw==
X-CSE-MsgGUID: v7aEHxwfTd+40JFgQyNS1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="23955616"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa009.jf.intel.com with SMTP; 22 Apr 2024 04:20:12 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 22 Apr 2024 14:20:11 +0300
Date: Mon, 22 Apr 2024 14:20:11 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: typec: qcom-pmic: fix pdphy start() error
 handling
Message-ID: <ZiZH69N6xou4UXhR@kuha.fi.intel.com>
References: <20240418145730.4605-1-johan+linaro@kernel.org>
 <20240418145730.4605-3-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418145730.4605-3-johan+linaro@kernel.org>

On Thu, Apr 18, 2024 at 04:57:30PM +0200, Johan Hovold wrote:
> Move disabling of the vdd-pdphy supply to the start() function which
> enabled it for symmetry and to make sure that it is disabled as intended
> in all error paths of pmic_typec_pdphy_reset() (i.e. not just when
> qcom_pmic_typec_pdphy_enable() fails).
> 
> Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> index 6560f4fc98d5..5b7f52b74a40 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> @@ -475,10 +475,8 @@ static int qcom_pmic_typec_pdphy_enable(struct pmic_typec_pdphy *pmic_typec_pdph
>  
>  	qcom_pmic_typec_pdphy_reset_off(pmic_typec_pdphy);
>  done:
> -	if (ret) {
> -		regulator_disable(pmic_typec_pdphy->vdd_pdphy);
> +	if (ret)
>  		dev_err(dev, "pdphy_enable fail %d\n", ret);
> -	}
>  
>  	return ret;
>  }
> @@ -524,12 +522,17 @@ static int qcom_pmic_typec_pdphy_start(struct pmic_typec *tcpm,
>  
>  	ret = pmic_typec_pdphy_reset(pmic_typec_pdphy);
>  	if (ret)
> -		return ret;
> +		goto err_disable_vdd_pdhy;
>  
>  	for (i = 0; i < pmic_typec_pdphy->nr_irqs; i++)
>  		enable_irq(pmic_typec_pdphy->irq_data[i].irq);
>  
>  	return 0;
> +
> +err_disable_vdd_pdhy:
> +	regulator_disable(pmic_typec_pdphy->vdd_pdphy);
> +
> +	return ret;
>  }
>  
>  static void qcom_pmic_typec_pdphy_stop(struct pmic_typec *tcpm)
> -- 
> 2.43.2

-- 
heikki

