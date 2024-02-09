Return-Path: <linux-kernel+bounces-59492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F37CC84F7E6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F671F22CB4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D700A6BB4A;
	Fri,  9 Feb 2024 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYmiVhO5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E084D112;
	Fri,  9 Feb 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490272; cv=none; b=H4+2aVnpdfO0VLk8HY4XZ1pULVBvqJxsWhW5QLdrAX7mhy8MGOjyUTt/jtD74ALOix066D3Jo/rUaP9rFoXiGD/IVJpYgCo8tOPwIoD5iOabg+hHfYyzw6WD1ul9bpx21GxWIzdkhcUjsVQOdTCkYMo/0D2JzjVXMYOm6erZfFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490272; c=relaxed/simple;
	bh=Tp+05UpwvuQCoFdpfbx5LDpMhP9gvJiGX6QH0bCn8ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkmXs4f5MPzfVCd4zebuMCW0+nxOD+foRC6E7skJLG3uxOLHnjx021tU8xrgBWA0WEi+iKYXS7R/GGQJcG0aP408pcFkXEEJ1iEvtuihlVRDDGivNOEpzZ4ZcvCW2ee27thxP8kHoD0gqDf6ctPp6iGIOBnELj5sKajfX0TZE2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYmiVhO5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707490269; x=1739026269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tp+05UpwvuQCoFdpfbx5LDpMhP9gvJiGX6QH0bCn8ms=;
  b=VYmiVhO5xViMFNkoErkB91rNmR+WxhSilvSfKXn6nD79WuwUr4ABay2f
   teLBA81TqsO8m3ZNOIz5NaXyZlfehyHT4rq8ghizcwe20SlP9sJ41WRtm
   WQ2mpd0labc8Hp2YOyd7pI8g4rnB627ReSzYSDezmR0GMrbId4H4EzCpw
   1OfkjrmxYfusyhzcXSnAygsKIkPW4xtI0McC8bOd2lGN2uCZ4Pg4q+1xt
   Gw3724AxJBrhrBx9GxyFkN0rA68Ck6LLsjqJ0dyX+hOp6+MKtdUFMEMRe
   1THqZlulUO3DD0Fz6F7pqFb2AuX0ktUrU0Mo4pRgINw9HfGCczZuzrNYV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="18947404"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="18947404"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:51:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="6602477"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.43.96])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 06:51:05 -0800
Date: Fri, 9 Feb 2024 15:51:03 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v1] thermal: sysfs: Fix up white space in
 trip_point_temp_store()
Message-ID: <ZcY71xqqYxl10OpY@linux.intel.com>
References: <2743507.mvXUDI8C0e@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2743507.mvXUDI8C0e@kreacher>

On Fri, Feb 09, 2024 at 02:49:49PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Remove an excess tab character from an otherwise empty code line.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
>  drivers/thermal/thermal_sysfs.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> @@ -136,7 +136,7 @@ trip_point_temp_store(struct device *dev
>  
>  unlock:
>  	mutex_unlock(&tz->lock);
> -	
> +
>  	return ret ? ret : count;
>  }
>  
> 
> 
> 

