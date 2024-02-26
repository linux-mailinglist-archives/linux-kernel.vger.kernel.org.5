Return-Path: <linux-kernel+bounces-80944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12AC866E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31A51C23E55
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B7A5A7A3;
	Mon, 26 Feb 2024 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AAXuhphx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B35B59B73;
	Mon, 26 Feb 2024 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937098; cv=none; b=pS0BVOkrpDqw7VH1T6VyWfBVo88xRO4bzbckhUde1wazH+97Fj3UcuWmq6bwuTwElMEvlu3Ndlg2Cs5e71NsaTlsg3fssTPc0wB4mQhoHbjRIFmHJxCKNWPFv/n1ui69ES/u/qSxrxHRpObXlPriO4qYY6pXpRp8k4QncbLyz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937098; c=relaxed/simple;
	bh=54vlDP3Fhi6fRB4B/nA0vEoDKYSZvhP6W39zIROQxNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdFhp5/Uq0burQ3jBOIURvJEQvGB4x4avRA0RSQ1kZqU7LgFxQi/NfnqALXoWqkHy3+t8TWBHvDPIQ3SUDHRyPybGtGC9b5UVqnRdTa9wxO/RNpsBqQ0NH4KjlKHbE0oXH/UutuvYu0mvecrcqTvVK+YgKgA7xBid7dpfCtfm9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AAXuhphx; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708937096; x=1740473096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=54vlDP3Fhi6fRB4B/nA0vEoDKYSZvhP6W39zIROQxNY=;
  b=AAXuhphxwo623AAxtNhP7TAUsLHrBNX6wSXx3kPTIn7cbI0ugu8xu1Jc
   Pa9V9HjbqfimhmMW/jfrYyTDnyqmRe/1nUeuoqm74eJQUX9yeNJlt31CD
   h4xRCCC1kn75R7kabR/ys33TmEsDGXspcbygQQ4k4M0KA6l216Ux9ns1J
   uT3gZXeo/vp45nTtLh2laZ9owYhyxRW0U4rhZQrW12HL5AoepmK/ygcZ1
   2YwrabKBatxrlskIB88eR3NSrCnaggOyAl310BdYt8ureIT5l7RPWsaad
   YgYbUqaVRmlv47K1gkxi1abUZjU1zDtbofqsCAHEWhf5AeVTHywOqk7NP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="6995146"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6995146"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 00:44:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029553"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029553"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 26 Feb 2024 00:44:52 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 26 Feb 2024 10:44:51 +0200
Date: Mon, 26 Feb 2024 10:44:51 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: fix UCSI on SM8550 & SM8650 Qualcomm
 devices
Message-ID: <ZdxPg0+DHX7/zede@kuha.fi.intel.com>
References: <20240223-topic-sm8550-upstream-ucsi-no-pdos-v1-1-8900ad510944@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-topic-sm8550-upstream-ucsi-no-pdos-v1-1-8900ad510944@linaro.org>

On Fri, Feb 23, 2024 at 10:40:40AM +0100, Neil Armstrong wrote:
> On SM8550 and SM8650 Qualcomm platforms a call to UCSI_GET_PDOS for
> non-PD partners will cause a firmware crash with no
> easy way to recover from it.
> 
> Add UCSI_NO_PARTNER_PDOS quirk for those platform until we find
> a way to properly handle the crash.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 0bd3f6dee678..932e7bf69447 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -302,6 +302,7 @@ static const struct of_device_id pmic_glink_ucsi_of_quirks[] = {
>  	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
>  	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
>  	{ .compatible = "qcom,sm8350-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
> +	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
>  	{}
>  };
>  
> 
> ---
> base-commit: 33e1d31873f87d119e5120b88cd350efa68ef276
> change-id: 20240223-topic-sm8550-upstream-ucsi-no-pdos-62fdad669f90
> 
> Best regards,
> -- 
> Neil Armstrong <neil.armstrong@linaro.org>

-- 
heikki

