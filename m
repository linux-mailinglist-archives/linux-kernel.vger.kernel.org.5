Return-Path: <linux-kernel+bounces-38121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2138383BB23
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD718287537
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D937117579;
	Thu, 25 Jan 2024 08:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Svi2Txuq"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB56179AB;
	Thu, 25 Jan 2024 08:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169604; cv=none; b=cgpsSUFYtllLSP1r7BYP9yOmvJPGoMaGIrlLb0I+DmdZ/d2C0DfoqjU1xLwMjjAbVX9EML9ybjvKY/4j9JFFBecX5Pe2avGP8hm3L2fh5lVe2UugHL0NRjd8AGwZb+NrZGr47ZzMXhrtTYOYbjPPlxYTXeNKpmXl/pxV4RD7HRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169604; c=relaxed/simple;
	bh=z+VAqBghFB7YwJJVRmjHIb/J1jBpR0/SN3VAkD9JHMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4eK/IeBJIb4TWIpYq00wEociohm5GW6Hb7Jm1QbAS52EgrBEOYKnuNWxzXA7T0iZ2Qnh1olZttGp3CJ5CF+EUhU7PA2EXhhZziBoHetU9Qi2FfqwLCS1OEyk/TrQRrKMheBZWFEDi8lFRhmXa36ROAQO3y3jPvn+qLCXbU3io4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Svi2Txuq; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706169602; x=1737705602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z+VAqBghFB7YwJJVRmjHIb/J1jBpR0/SN3VAkD9JHMA=;
  b=Svi2TxuqvyaboLK0avbQqYUpArqnY+B21wZmanEK7CNlX93KkdU+np7S
   ntqxcC9CAAzm+AvzfCvrIxd8/szj55C1rbFXxGKh3jVtxIz9RTGgUm7G3
   DYShK2tq0zDhZFyonEDVQaD/TFqfg1emZDwdSoqZyqKdgTIBtQV4pglBT
   jr5IEsAi6+mYcfrhnFP+9C+UeJYvW+N/PR970GdxNqF2Rpnca3PskFFmK
   esMeiTwKcPUfNGujRMgW/srHMSp8cOFoPY2MBMCBJww0eSFHYJ1I6Zcun
   VBAt15tBp/0j4ug+vvbTx6kS/HI/Gw2fOHav6hkxykPGE7tc8tt4ILjCS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="405838370"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="405838370"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 00:00:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="28399670"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.119])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 00:00:00 -0800
Date: Thu, 25 Jan 2024 08:59:57 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 08/12] PM: sleep: stats: Use locking in
 dpm_save_failed_dev()
Message-ID: <ZbIU/WbnXDO3pSAb@linux.intel.com>
References: <5760158.DvuYhMxLoT@kreacher>
 <3798847.kQq0lBPeGt@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3798847.kQq0lBPeGt@kreacher>

On Mon, Jan 22, 2024 at 12:33:53PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because dpm_save_failed_dev() may be called simultaneously by multiple
> failing device PM functions, the state of the suspend_stats fields
> updated by it may become inconsistent.
> 
> Prevent that from happening by using a lock in dpm_save_failed_dev().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

> ---
>  kernel/power/main.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> Index: linux-pm/kernel/power/main.c
> ===================================================================
> --- linux-pm.orig/kernel/power/main.c
> +++ linux-pm/kernel/power/main.c
> @@ -323,13 +323,18 @@ struct suspend_stats {
>  };
>  
>  static struct suspend_stats suspend_stats;
> +static DEFINE_MUTEX(suspend_stats_lock);
>  
>  void dpm_save_failed_dev(const char *name)
>  {
> +	mutex_lock(&suspend_stats_lock);
> +
>  	strscpy(suspend_stats.failed_devs[suspend_stats.last_failed_dev],
>  		name, sizeof(suspend_stats.failed_devs[0]));
>  	suspend_stats.last_failed_dev++;
>  	suspend_stats.last_failed_dev %= REC_FAILED_NUM;
> +
> +	mutex_unlock(&suspend_stats_lock);
>  }
>  
>  void dpm_save_failed_step(enum suspend_stat_step step)
> 
> 
> 
> 

