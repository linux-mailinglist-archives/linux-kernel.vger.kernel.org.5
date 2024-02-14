Return-Path: <linux-kernel+bounces-64817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C88854336
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4672283BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1B8125AB;
	Wed, 14 Feb 2024 07:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L34iYylP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F32C125A1;
	Wed, 14 Feb 2024 07:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707894254; cv=none; b=dCe3aIrH5mOsaA+gFf0SuzWDgJBQ3Plut6M38kX/imU9m2LGHOK+jO6wvNJajahrTlAWoIqyMXGHMXLEpnx0aN6G9vgHYy79WczSzufoNKD1q4NB8C6sy8mqX+gUJVsFP/Tjm4M5//Zc43mlwZsziCtDuVBBYE15bVTKxPGihiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707894254; c=relaxed/simple;
	bh=66b8xVFu2JyPM24F8+jnCjp+uEAAbwzcELoS6iKrZDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aBwDokEfqH+eR1+1AKdlS6pfEsGof2RBfq8EThP6pffevrOwF18gY1ZR32dDjRnhL45U9WbdDodlp50+fJ+zgKO98GcoTDzaJom+GMA6T3JulFomxF4sPxzycwvPb2bz1VH+cAJo1STr89TLWdjGV950AK+3lZmVGsOefWfDx+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L34iYylP; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707894253; x=1739430253;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=66b8xVFu2JyPM24F8+jnCjp+uEAAbwzcELoS6iKrZDU=;
  b=L34iYylPCTMA3tAn5S5LzoqZdiTeSY3EanR3YMGfd9FZJ0s20oatz7It
   /sf3XFIj0Sh2PTJ4CI6dm3n3WfEWFHR9Fzr+NC5rQGU7NtsGvLdhQhNeI
   s6KTTiCoPt7RuShpV5dsf2dfcGO8dAK15Ixzi8YdLkVtDv9rBHUoeNDWS
   prn1ldbywjPkdhwdD7FJ/brgXIARVvnkyvxFJkpi7Zc3mLwtwoeXx/T2V
   oO99ki8eigbED0Ab99r9uKuc8mkQj8UdLNPuirWxXbrt6y6l/uVaNCMun
   AmpcBDBAzesUDiB9EDonBHCawzg2SKgwfw7b8tr4wZg1XtdravhQn6aYg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="12647082"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="12647082"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 23:04:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="3430569"
Received: from jhogande-desk.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orviesa007.jf.intel.com with ESMTP; 13 Feb 2024 23:04:10 -0800
Message-ID: <91bbea2c-b6f7-48cf-b540-83c73750d1d2@linux.intel.com>
Date: Wed, 14 Feb 2024 09:04:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] pwm: lpss: drop redundant runtime PM handles
Content-Language: en-US
To: Raag Jadav <raag.jadav@intel.com>, u.kleine-koenig@pengutronix.de,
 mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240212061037.4271-1-raag.jadav@intel.com>
 <20240212061037.4271-3-raag.jadav@intel.com>
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20240212061037.4271-3-raag.jadav@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/24 08:10, Raag Jadav wrote:
> We no longer need empty runtime PM handles for PCI devices after commit
> c5eb1190074c ("PCI / PM: Allow runtime PM without callback functions").
> Drop them and let PCI core take care of power state transitions.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/pwm/pwm-lpss-pci.c | 22 ----------------------
>   1 file changed, 22 deletions(-)
> 
Will this patch cause a regression if applied without your another patch 
to the drivers/pci/pci-driver.c?

https://lore.kernel.org/linux-pci/20240212063233.5599-1-raag.jadav@intel.com/

