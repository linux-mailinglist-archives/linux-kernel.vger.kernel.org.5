Return-Path: <linux-kernel+bounces-57992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7158884E00E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DADC285589
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AD96F53C;
	Thu,  8 Feb 2024 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kgn/J5XC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03935427E;
	Thu,  8 Feb 2024 11:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393262; cv=none; b=KcAfxgFyjaA/YVXwEBUU+tT4f9OaFcKZ8H6TvBMOtOW+l+d0rhpTXz0HV0RLG0g6Ktrc83ueSq+hX1aqEu36vN74ZcIWbmk+RrJWjhqJaQdJOSO9WoY57IOxvYgnZtNtxBcKRJD/vIA79x+QtT//Drgl+wKY77Oe10H7Bb01YMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393262; c=relaxed/simple;
	bh=uXOrZiz482AvVYpv/HDQooQIBOQg2tudhsP5/yy4RpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbcKvE93dqcEL9rFQJugQQMToTWuRHv1k8wGBx+z8IJ1sipLarKuM8cgiLWFyv402TZPzia+ACLie7iZgiJrX4HY0+H/L3LRVW1q0Q0KQpARCCoIc6aDl1NXAjyIdOxvER7Tv36WijoTadZShP9te4HahCORuiEaxvCA6uZ2tXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kgn/J5XC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707393261; x=1738929261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uXOrZiz482AvVYpv/HDQooQIBOQg2tudhsP5/yy4RpM=;
  b=Kgn/J5XCM+QdutdSms2CcakI0fYPMl0F951dhdRqb0Zt/NIMZ9eIMvH+
   qQbo4CKBL8+86bu2l+Xu4RUsJ5RO6DjHVK5nrFnsx/Gp2+2pVuHaLyudS
   dffK1kCRUlQvWoEBUCauQcp1niVSoNhPep6StkQJN5hdCYpIGNoKbCf++
   LRt5cHrs92fGkFm7tGFygs3Ul6oKqoJArGDfZ3QlnQVu3TSKUIH+zGv5T
   /DZtMSXHGOrw8Uvceje9ZJ6Eo/js9KvezfrhWFzg44R49TVcGBdBfBmu1
   1rpnJYpxsveUoJOHA20ULJYv1WXDuEfAHIH/s6srLsOqG7TXMPIStbD6/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="4985163"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="4985163"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 03:54:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="934111721"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="934111721"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 08 Feb 2024 03:54:14 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 08 Feb 2024 13:54:14 +0200
Date: Thu, 8 Feb 2024 13:54:14 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-usb@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH v3 3/6] usb: typec: qcom-pmic-typec: add support for
 PMI632 PMIC
Message-ID: <ZcTA5hbcladmKuLh@kuha.fi.intel.com>
References: <20240130-pmi632-typec-v3-0-b05fe44f0a51@linaro.org>
 <20240130-pmi632-typec-v3-3-b05fe44f0a51@linaro.org>
 <CAA8EJpqhfWsmUxwmBLtdtx-aFOmTo24erdNfRyz2ymi_y=yidw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpqhfWsmUxwmBLtdtx-aFOmTo24erdNfRyz2ymi_y=yidw@mail.gmail.com>

On Wed, Feb 07, 2024 at 11:54:50AM +0200, Dmitry Baryshkov wrote:
> On Tue, 30 Jan 2024 at 21:33, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > The PMI632 PMIC support Type-C port handling, but lacks USB
> > PowerDelivery support. The TCPM requires all callbacks to be provided
> > by the implementation. Implement a special, 'stub' Qcom PD PHY
> > implementation to enable the PMI632 support.
> >
> > Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sdm632-fairphone-fp3
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Heikki, Gunter, Gret, is there anything left on my side to get these patches in?

Nothing from me. Do you want Greg to pick these?

thanks,

-- 
heikki

