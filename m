Return-Path: <linux-kernel+bounces-32059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F2A8355DD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F24B2297C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD3336AF2;
	Sun, 21 Jan 2024 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLnJaiiR"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C08E3714C;
	Sun, 21 Jan 2024 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705841802; cv=none; b=B9VjdIvinCsJEV2CokidbTwQBKjPkvLKDmLH6FrMjyYn0J6QM4AwPFJokxDJTqvAfHdLfFRG1/lyiPMymxjQnhsCJScHorOKc0tGWU7wtkDg3BGmsvi2SepbLMPWyOECT+jtMTOgbxVE5H0X156Tnyi5199Lb7hxKTYWHUXU93w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705841802; c=relaxed/simple;
	bh=MFggLcNb6FnJrDnaHyePScPjFRJI9rDwfH1smuryGOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IT4R6yM6BR0qN+/ZhZe6Ke3iI4zfvzWGEPc3ZDtCtooedqa33HMousfqGCOFvRdQLPZgAKtJIjTYoC8BZENysYmNieSaRnEFhEVv29AB4yVfhTaazwGxJvSN163u+PYwwJRXOIpcOxbCXRgqInLPXh/4cdXEWQP1xSIfI3/DtIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLnJaiiR; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705841801; x=1737377801;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MFggLcNb6FnJrDnaHyePScPjFRJI9rDwfH1smuryGOk=;
  b=iLnJaiiRmIhyDDCleVG7b8ssVVRutUbiFfgfd/SG/ZNIgjTnKaMr1nss
   GK7vUeRQXpcPZjuwVlkE2FzJBU9r4Bkh4aGOTLxDsobrgZZNc6UzWyYTr
   ZApZRT9+cvgjQSXC9717wxpmpEypztyvPjEWDfKSwmdDM9UDILza7tsxD
   AqFCUR2mK/e2nW6ZbCuEUWdY0WtMnEalfjK3uF8NLzqAnulp2V9lZeUMP
   ehvDX1N0Qgsz3igAEBS87ulg7W7tC4pg/XqcZRjK2ZcEgmtBrn1OArOVj
   5p+JM6n0PJ8KQDYYWz/WXsRGapklzp9KO9R1xkZRC2xScB0JEWOJhVOns
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="398185464"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="398185464"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 04:56:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="875746374"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="875746374"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 04:56:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rRXJn-0000000Fcoe-0D1r;
	Sun, 21 Jan 2024 14:52:55 +0200
Date: Sun, 21 Jan 2024 14:52:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: subhajit.ghosh@tweaklogic.com, anshulusr@gmail.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, javier.carrasco.cruz@gmail.com,
	jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, marex@denx.de, matt@ranostay.sg,
	mazziesaccount@gmail.com, robh+dt@kernel.org,
	stefan.windfeldt-prytz@axis.com
Subject: Re: [PATCH v5 3/3] iio: light: Add support for APDS9306 Light Sensor
Message-ID: <Za0TpiKjDD27Vh_x@smile.fi.intel.com>
References: <20240121051735.32246-1-subhajit.ghosh@tweaklogic.com>
 <20240121051735.32246-4-subhajit.ghosh@tweaklogic.com>
 <8a7f03b6-caca-4fbb-8093-0ba87bd2e850@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a7f03b6-caca-4fbb-8093-0ba87bd2e850@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Jan 21, 2024 at 10:22:50AM +0100, Christophe JAILLET wrote:
> Le 21/01/2024 à 06:17, Subhajit Ghosh a écrit :

..

> > +#define APDS9306_ALS_THRES_VAL_MAX	(BIT(20) - 1)
> > +#define APDS9306_ALS_THRES_VAR_VAL_MAX	(BIT(3) - 1)
> > +#define APDS9306_ALS_PERSIST_VAL_MAX	(BIT(4) - 1)
> 
> Nit: GENMASK()?

I think no, these are plain numbers given in the form of BIT(x) - 1 to show the
HW limit on the values (in bits).

..

> > +	intg_time = iio_gts_find_int_time_by_sel(&data->gts, intg_time_idx);
> > +	if (intg_time < 0)
> > +		delay = apds9306_repeat_rate_period[repeat_rate_idx];
> 
> 'delay' is always overwritten by the line below.

Seems like entire conditional here is not needed as it's implied in the max().
And max() should take both signed or unsigned types, different types might have
a side effect.

> > +	/*
> > +	 * Whichever is greater - integration time period or
> > +	 * sampling period.
> > +	 */
> > +	delay = max(intg_time,
> > +		    apds9306_repeat_rate_period[repeat_rate_idx]);

-- 
With Best Regards,
Andy Shevchenko



