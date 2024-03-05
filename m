Return-Path: <linux-kernel+bounces-92742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC1987255F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507F41F25B8B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D2814AB4;
	Tue,  5 Mar 2024 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c9uoTqoK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A68DDDA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658668; cv=none; b=l3FWOpMpF6aWEiadMLwEJaV1XT83r7Cj7uTgPGKfZipg5ZzpZaYwgQUfBE32t6KYRLstphd/0nwkugra7F+qYg9aZe8nq+EbTHBYrGJUKGrv7qMeEwc8EWArUlrGz0oGBEob0Zvc/WcdGMaSckjIHgjrVFXax+8CKbyrqgx1JSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658668; c=relaxed/simple;
	bh=k9sjd0GNqxaMmUTEUCKXYJVc16DKg4H6BxA33a0ErFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaTQAfRrqkdRY7jQwMM6kmtOTr4WGKXYaKv9NdzCB+cbNEl7Kx4m6ePsXe/uOq6pngu0ucp7ICmDUq+9su6sh1qcsFLHJFMDWIXwDOOjCWeTdPMGATCyXvrn0YYQiXMbGhGGKb9E682wpUjOIJf7JhBRMdZtN8iww/cjKDmvtLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c9uoTqoK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709658667; x=1741194667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k9sjd0GNqxaMmUTEUCKXYJVc16DKg4H6BxA33a0ErFg=;
  b=c9uoTqoKaovYSquNQPRP2mPpQ7xp7/UJVy7dgdKExwvWcnIrhZdY1bar
   nnXiA0zCdzaFQ2zJriCt2MSivefar+ztQKHx6SYaWeHI15fv/wKjPaS+h
   lQaWDss27S36baxuWkRn6nVx5MewHeULs6oldajDkdxWxhOZStTRSWVLT
   6KQkusMMGiIByv4XunVOyu2sAzhvjI08aKS81VORctgVvnH/y3FY8G6WR
   cTEB/DBiL1CXFYxNzyIeZypgFDktDOq0pkx2toke+JTaQy4chxaVI/V31
   OWc7/an3rn9MtcNwxbjt7uX0TVQkXmHWZ7q0xtL7laDCXi612O3lMcAbJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4088588"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4088588"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 09:11:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="914145506"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="914145506"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 09:11:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rhYJh-0000000A2g6-3xKe;
	Tue, 05 Mar 2024 19:11:01 +0200
Date: Tue, 5 Mar 2024 19:11:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Wentong Wu <wentong.wu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/3] mei: vsc: Don't use sleeping condition in
 wait_event_timeout()
Message-ID: <ZedSJcBGj89-XQWY@smile.fi.intel.com>
References: <20240219195807.517742-1-sakari.ailus@linux.intel.com>
 <20240219195807.517742-3-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219195807.517742-3-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 19, 2024 at 09:58:06PM +0200, Sakari Ailus wrote:
> vsc_tp_wakeup_request() called wait_event_timeout() with
> gpiod_get_value_cansleep() which may sleep, and does so as the
> implementation is that of gpio-ljca.
> 
> Move the GPIO state check outside the call.

..

> +#define VSC_TP_WAIT_FW_POLL_TIMEOUT		(2 * HZ)
> +#define VSC_TP_WAIT_FW_POLL_DELAY_US		(20 * USEC_PER_MSEC)

..

>  	ret = wait_event_timeout(tp->xfer_wait,
> -				 atomic_read(&tp->assert_cnt) &&
> -				 gpiod_get_value_cansleep(tp->wakeuphost),
> -				 VSC_TP_WAIT_FW_ASSERTED_TIMEOUT);
> +				 atomic_read(&tp->assert_cnt),
> +				 VSC_TP_WAIT_FW_POLL_TIMEOUT);

First of all, there is an API for such cases (wait_woken_up() IIRC).

>  	if (!ret)
>  		return -ETIMEDOUT;

..

> +	return read_poll_timeout(gpiod_get_value_cansleep, ret, ret,
> +				 VSC_TP_WAIT_FW_POLL_DELAY_US,
> +				 VSC_TP_WAIT_FW_POLL_TIMEOUT, false,

Second, this is a bug as you are using jiffies as microseconds. How had it been tested?

> +				 tp->wakeuphost);

-- 
With Best Regards,
Andy Shevchenko



