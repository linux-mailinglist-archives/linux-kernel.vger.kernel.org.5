Return-Path: <linux-kernel+bounces-109329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E5B8817B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1807284912
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24E785284;
	Wed, 20 Mar 2024 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ezm4psoI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B970C85623
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710961921; cv=none; b=HzELKSuMoerCbIHrjx8+6eCqzGraBCkJyAE3XuyTl6HVOHC3lkNgzpUfOICZRsOQFdgrNa3I9pUnNuNw0yVZ3sOSf4fsCd79giAq0d/rNUvjdkzXs0o4XPWsJcuVrq9mOd6ZMa7uKZ7RBsZCDCB7/ffG87IQST1sHAF/nwUm/PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710961921; c=relaxed/simple;
	bh=wSvcPIoWz7sDAd12lh4qNgUxEOepxCpDUmRv5msijDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8sSPzs4E2aXUzYjDGS0vXo2emy7pC3TuRx4GXjYwqmH65UZNjRvB9evYdcsTxR3sgyuDfumt4gN30W8gTDXWhimD8GYENEql3XrolSTJ79cbe3ayaYd04GFouU2JyCWXuzS2H3nwGKMrH/nD3x7MDLVbrEPBFnIUdJipeNpeUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ezm4psoI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710961919; x=1742497919;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wSvcPIoWz7sDAd12lh4qNgUxEOepxCpDUmRv5msijDw=;
  b=Ezm4psoI6Ohn5qA1brFgWVPFnrx5mbuP4f0eOEaY96eDG5ZGNMWdzikv
   xR9hmxrwBINYbEPAc6I60OJ/DUfcHlpFs/i6nQFPGUUg7AcXLTXY2RTi1
   XihjAr3sMA5bY9FZmknPdeaWtR14lckJl9lpx1VwwZJM1THzCD55xLirY
   isjmBbijFevp49RgoOX06XqVy5NQ6JJdbhQL2s4lOOvdwugPYbcgfJbA3
   C2WaKbFVdOI/vzeOEzjgFn0jNjcs1SYnpo5wkGNRTGkk1ePoAAhrWRpn+
   brjPvvVJDgEaB4s6r1BZFxq0tRGHKW+UbdXEKW4nPKZnxu80EiTrtqyw9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6120387"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="6120387"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 12:11:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="18889911"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.72.188])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 12:11:57 -0700
Date: Wed, 20 Mar 2024 12:11:55 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Felix N. Kimbu" <felixkimbu1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: pi433: Correct comment typos in pi433_if.c
Message-ID: <Zfs0+0C7nzKiBjGy@aschofie-mobl2>
References: <Zfk0UfLh3rRf6qDv@MOLeToid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfk0UfLh3rRf6qDv@MOLeToid>

On Tue, Mar 19, 2024 at 07:44:33AM +0100, Felix N. Kimbu wrote:
> Correct typos in pi433_if.c comments to address the following checkpatch checks;
> 
> CHECK: 'interace' may be misspelled - perhaps 'interface'?
> #13: FILE: drivers/staging/pi433/pi433_if.c:13:
> + * HopeRf with a similar interace - e. g. RFM69HCW, RFM12, RFM95, ...
>                           ^^^^^^^^
> 
> CHECK: 'ebedded' may be misspelled - perhaps 'embedded'?
> #71: FILE: drivers/staging/pi433/pi433_if.c:71:
> + * so we have just one rx config, ebedded in device struct
>                                    ^^^^^^^
> 
> CHECK: 'reenabled' may be misspelled - perhaps 're-enabled'?
> #650: FILE: drivers/staging/pi433/pi433_if.c:650:
> +                * irq will be reenabled after tx config is set
>                                ^^^^^^^^^
> 
> CHECK: 'pendig' may be misspelled - perhaps 'pending'?
> #926: FILE: drivers/staging/pi433/pi433_if.c:926:
> +               /* during pendig read request, change of config not allowed */
>                           ^^^^^^
> 
> Signed-off-by: Felix N. Kimbu <felixkimbu1@gmail.com>

Hi Felix,

This commit msg and log can be trimmed. Please take a look at samples in
staging or here on the Outreachy list like this:
https://lore.kernel.org/outreachy/00be5f2a97b0c899279bd8f9cd27634186b77b9d.1666299151.git.drv@mailo.com/

Checkpatch complained:

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#311: 
Correct typos in pi433_if.c comments to address the following checkpatch checks;

WARNING: Commit log lines starting with '#' are dropped by git as comments
#314: 
#13: FILE: drivers/staging/pi433/pi433_if.c:13:

WARNING: 'interace' may be misspelled - perhaps 'interface'?
#315: 
+ * HopeRf with a similar interace - e. g. RFM69HCW, RFM12, RFM95, ...
                          ^^^^^^^^

WARNING: Commit log lines starting with '#' are dropped by git as comments
#319: 
#71: FILE: drivers/staging/pi433/pi433_if.c:71:

WARNING: 'ebedded' may be misspelled - perhaps 'embedded'?
#320: 
+ * so we have just one rx config, ebedded in device struct
                                   ^^^^^^^

WARNING: Commit log lines starting with '#' are dropped by git as comments
#324: 
#650: FILE: drivers/staging/pi433/pi433_if.c:650:

WARNING: 'reenabled' may be misspelled - perhaps 're-enabled'?
#325: 
+                * irq will be reenabled after tx config is set
                               ^^^^^^^^^

WARNING: Commit log lines starting with '#' are dropped by git as comments
#329: 
#926: FILE: drivers/staging/pi433/pi433_if.c:926:

WARNING: 'pendig' may be misspelled - perhaps 'pending'?
#330: 
+               /* during pendig read request, change of config not allowed */
                          ^^^^^^

total: 0 errors, 9 warnings, 0 checks, 32 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/cxluser/patches/outreachy/felix-spell.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




> ---
>  drivers/staging/pi433/pi433_if.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> index b6c4917d515e..81de98c0245a 100644
> --- a/drivers/staging/pi433/pi433_if.c
> +++ b/drivers/staging/pi433/pi433_if.c
> @@ -10,7 +10,7 @@
>   * devices, basing on HopeRfs rf69.
>   *
>   * The driver can also be extended, to support other modules of
> - * HopeRf with a similar interace - e. g. RFM69HCW, RFM12, RFM95, ...
> + * HopeRf with a similar interface - e. g. RFM69HCW, RFM12, RFM95, ...
>   *
>   * Copyright (C) 2016 Wolf-Entwicklungen
>   *	Marcus Wolf <linux@wolf-entwicklungen.de>
> @@ -68,7 +68,7 @@ static const struct class pi433_class = {
>   */
>  /*
>   * rx config is device specific
> - * so we have just one rx config, ebedded in device struct
> + * so we have just one rx config, embedded in device struct
>   */
>  struct pi433_device {
>  	/* device handling related values */
> @@ -647,7 +647,7 @@ static int pi433_tx_thread(void *data)
>  
>  		/*
>  		 * prevent race conditions
> -		 * irq will be reenabled after tx config is set
> +		 * irq will be re-enabled after tx config is set
>  		 */
>  		disable_irq(device->irq_num[DIO0]);
>  		device->tx_active = true;
> @@ -923,7 +923,7 @@ static long pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	case PI433_IOC_WR_RX_CFG:
>  		mutex_lock(&device->rx_lock);
>  
> -		/* during pendig read request, change of config not allowed */
> +		/* during pending read request, change of config not allowed */
>  		if (device->rx_active) {
>  			mutex_unlock(&device->rx_lock);
>  			return -EAGAIN;
> -- 
> 2.34.1
> 
> 

