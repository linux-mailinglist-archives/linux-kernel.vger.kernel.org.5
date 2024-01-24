Return-Path: <linux-kernel+bounces-36736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C652183A5E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D073B28AB1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E945E1802B;
	Wed, 24 Jan 2024 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9BuLsYz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7021417C9B;
	Wed, 24 Jan 2024 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706089533; cv=none; b=GUhcllpgsqa/sJfWlNQ97u/uw2bwlhJnxD+QJXecE2Y6h9cZ1K7oqQoNT8YsPJ05u+uAdmKb35N9kB9PBdASucbrovEcKUbGTHxRVuya+wZxyBt3LEzDIcou21BIm3feX57urcs+3r3qnvEyJ1Tai2RWSjFt64mhe9jhSPDr1rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706089533; c=relaxed/simple;
	bh=cIIOzQRiSdFQkTxX0AEROQNoDxQpnFGrLu2SLpayLcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGpTalwE2DEYN82H5sh3Yz50JnzUN6ArkH+STBAFL6nKMs7Vj7xNDha/DwvoJRn5d7JplPl8akdZapXCUtgjOMCfgRMi1eWERJSGHLVmMSO47MP4nYM5ipTa4L/vGf1PsEJxTjnJ8V1aXaxAdj/9H3vzUSgcd5LHEpvlYRwFv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F9BuLsYz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706089531; x=1737625531;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cIIOzQRiSdFQkTxX0AEROQNoDxQpnFGrLu2SLpayLcM=;
  b=F9BuLsYzaAwWZu8ZU9UTUxbhVKQUlqbVyQCkM8PKwGSiFe4LpSvJOfDZ
   3CjothxzyZvEKex0EwjSict5W7w+ivsaPHgUHd8iiSAeBLR00Shq0rBXU
   XhTJ2ckyXbZgwBoQ4rx+npNXh0P3XUUdyJ2aohc0v20q2+/Y/fBABoWLf
   24wODxy3exlM2nTQhxS/fBCbOu83rpGv9z98nHC3cLm0jqTcE2bznj1RD
   mzLCXMPxeqPtBOBrU5eCnTXG6zDZ0z2PSf7njWSaD9rQIr3R511OTxg71
   qIN8zEFM/WZL9f7wqIz6WVSX1tNtjbJWt+x1B+D58QbjwtWu3Vb3SIvFv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15320274"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15320274"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 01:45:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="856631572"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="856631572"
Received: from marquiz-s-2.fi.intel.com (HELO [10.237.72.58]) ([10.237.72.58])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jan 2024 01:45:27 -0800
Message-ID: <c8ec8205-f953-48ab-a38d-e1fd2f95e627@linux.intel.com>
Date: Wed, 24 Jan 2024 11:45:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] DesignWare PWM improvements
To: Raag Jadav <raag.jadav@intel.com>, u.kleine-koenig@pengutronix.de,
 mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
 lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240122030238.29437-1-raag.jadav@intel.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20240122030238.29437-1-raag.jadav@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 05:02, Raag Jadav wrote:
> This series adds 16 channel support for Intel Elkhart Lake and simplifies
> code using standard helpers in DesignWare PWM driver.
> 
> Raag Jadav (3):
>    pwm: dwc: Add 16 channel support for Intel Elkhart Lake
>    pwm: dwc: simplify error handling
>    pwm: dwc: use to_pci_dev() helper
> 
>   drivers/pwm/pwm-dwc.c | 71 +++++++++++++++++++++++++++++--------------
>   drivers/pwm/pwm-dwc.h |  5 +++
>   2 files changed, 54 insertions(+), 22 deletions(-)
> 
For the patchset:

Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

