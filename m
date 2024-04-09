Return-Path: <linux-kernel+bounces-136912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607F389D9BE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9114A1C2310E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B81912F381;
	Tue,  9 Apr 2024 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FsMZzB+h"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D11E12EBCA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667781; cv=none; b=XhRm23+/a5KCKTDRK45qFjeOglinNtCA/Yz6b3LHaaFjY+waxtHZZGAL5Av/4Jb5tTDdB1R4uZ80lE/GxSeXJkPjZws9fg+gIdLk3GRrnhvLsEozrtPYqhxLT7jBvuPeieLJtK2YL+Jy9Nuqu8GiONXQXSsPbGCUqCyOziUcQfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667781; c=relaxed/simple;
	bh=bxgbV2pkHGwpnIR6VtVXissqixb6J9Rx4J0av4i8oCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJziOZG5VLfOnymYvoRQGUia+ZPERdyorb5NSVq3wJmggpujA6Q+QPaw40JHhA5rppudUq6ngXpyO5ZGVKPQrcFbiCvRvRVw7A0Dv6qLmbkEHIzsUR8Nt2PeavyPKxO2ynlekvi8MNthSwQL4GK2nTiYbPugXvbhM8+uqvyNzYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FsMZzB+h; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712667780; x=1744203780;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bxgbV2pkHGwpnIR6VtVXissqixb6J9Rx4J0av4i8oCI=;
  b=FsMZzB+haUmS55TrnOVdCxk/pPFF6bNAVFPRB5Wq/CYAp8nploIoh9Kj
   oOMmdAc5XeQGV9hPTwyTpVttCUW+xEgraCnPigNe1SN3+HVwD63W7XJkU
   /Db4EZq0C6hdSgunpP/w5GrQ+g+p18qukmgb9OO0jx06ja4nXsIe4x+JR
   +qRwV2v8msU+bQtUANaYXqc9JvVj6GTeYZu4dvH242512IzT3TwK7jptM
   tCH9Hc6MCabJ0v8t/4km/TRCjhaQQTMq2ZtdZEl5J5kMY4T/9X701RcIw
   d1qfdF6utX4J6GPPHWWGLJ7rJ4sEkve3pE/jHMtmzhGo/2VF3y6yY9xVK
   g==;
X-CSE-ConnectionGUID: h42pXeUZR3+u1W6q8myD3g==
X-CSE-MsgGUID: IjLWBleUTu+moFXmWU7+Cg==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="11773722"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="11773722"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 06:02:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="915399305"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="915399305"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 06:02:56 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ruB7l-00000002oHW-0QzR;
	Tue, 09 Apr 2024 16:02:53 +0300
Date: Tue, 9 Apr 2024 16:02:52 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
	shenghao-ding@ti.com, navada@ti.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
	yung-chuan.liao@linux.intel.com, broonie@kernel.org, soyer@irl.hu
Subject: Re: [PATCH v2 1/3] ALSA: hda/tas2781: Modification for add tas2781
 driver for SPI
Message-ID: <ZhU8fCOLOlu4azGL@smile.fi.intel.com>
References: <20240409024816.1180-1-baojun.xu@ti.com>
 <20240409024816.1180-2-baojun.xu@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240409024816.1180-2-baojun.xu@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 09, 2024 at 10:48:13AM +0800, Baojun Xu wrote:
> Integrate tas2781 configs for HP Laptops. Every tas2781 in the laptop
> will work as a single speaker on SPI bus. The code support realtek as

Realtek

> the primary codec.

..

>  		{"INT33FE", },
>  		{"INT3515", },
>  		/* Non-conforming _HID for Cirrus Logic already released */
> +		{"TXNW2781", },

This seems wrong. The ID here is correct from ACPI specification perspective.
Can you elaborate why you think it's "non-conforming _HID"?

>  		{"CLSA0100", },
>  		{"CLSA0101", },

..

>  	/* Non-conforming _HID for Cirrus Logic already released */
>  	{ "CLSA0100", (unsigned long)&cs35l41_hda },
>  	{ "CLSA0101", (unsigned long)&cs35l41_hda },
> +	{ "TXNW2781", (unsigned long)&tas2781_hda },

Ditto.

>  	{ }

..

> @@ -39,6 +39,7 @@ snd-hda-scodec-cs35l56-spi-objs :=	cs35l56_hda_spi.o
>  snd-hda-cs-dsp-ctls-objs :=		hda_cs_dsp_ctl.o
>  snd-hda-scodec-component-objs :=	hda_component.o
>  snd-hda-scodec-tas2781-i2c-objs :=	tas2781_hda_i2c.o
> +snd-hda-scodec-tas2781-spi-objs :=	tas2781_hda_spi.o tas2781_spi_fwlib.o

Actually these 'objs' has to be 'y', can you fix it in the prerequisite patch?

Also wondering why fwlib is only a requirement for SPI. How does I²C work?

-- 
With Best Regards,
Andy Shevchenko



