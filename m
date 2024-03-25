Return-Path: <linux-kernel+bounces-117476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ECE88B36B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2ADCC45EFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68600145FFB;
	Mon, 25 Mar 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGmn/RET"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB71145FE7;
	Mon, 25 Mar 2024 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384309; cv=none; b=jnImbsno4kaPJrQUqfQYb2Lfcwe23m11bt0q9n1gbcXEjXdVWP0gtauTFWKmfMmOisIPIurr33b8Cwz2MkqWhvMXj3Ijt9S1t3DKCgLfaOcwJWr75mcxQV8tifvaLAoSD2PJniRD20DJ2KRcWtH8+Csqr+uODPL4ylusRxDOWuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384309; c=relaxed/simple;
	bh=J6kX6hIi3srqIc3d27UOrwKWtKhvzO16N5KYIadUfQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lqo7jz9tPLYIP3m/0leNioPg7WhALSmCo8Cx4JieKTsVVPfEMffuocZZS7HqkHLBGz6KTOVl1JD4lAVDlf8uFRWA/sma5bX1jaCZsNwNb+dgM3B88WqTSncqXehbgmG+gRRPm4X6Fwe4P/f5p/1zd+o2+sbM8CqoO4yHqua2o8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGmn/RET; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711384308; x=1742920308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J6kX6hIi3srqIc3d27UOrwKWtKhvzO16N5KYIadUfQ8=;
  b=HGmn/RETqqLs0uFGchxojOJlycuOmbbLaGpsTDxcF13jopDA91rEzt/X
   7ke4wpHs9496Q+GuZeqKjB3SFjzKFHxkOS35ztAYzvX9aqYTdJ2fhIjyu
   TS4y/qYnyjxd0EuHd9EHMwezK4Ynb+M0V0esl6QFndXuyL6NUrd6XkOJ/
   efNhjhYADe1tC4kqxwVTsfzpYCvZ/KwjV8xpR3fLqi+5Cvaug8/H8N5qo
   ZQ7GggljOepFIEc/cp1KsWXlKNBUwciNOUQHpsvip2w4Xqz4C6wz+P9EW
   6XqMKFkvoEstYZuM44o6a+8AD1ztSInG0DcaS77G7MDtouVFf126LAxRm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17028592"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="17028592"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 09:31:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="914848517"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="914848517"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 09:31:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ronEb-0000000G2xE-2Yez;
	Mon, 25 Mar 2024 18:31:41 +0200
Date: Mon, 25 Mar 2024 18:31:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Kate Hsuan <hpa@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/6] platform: x86-android-tablets: other: Add swnode
 for Xiaomi pad2 indicator LED
Message-ID: <ZgGm7eDBQtwH37ya@smile.fi.intel.com>
References: <20240322033736.9344-1-hpa@redhat.com>
 <20240322033736.9344-2-hpa@redhat.com>
 <bb7536be-9bed-4557-b111-6409ebfe48f4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb7536be-9bed-4557-b111-6409ebfe48f4@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 25, 2024 at 04:02:54PM +0100, Hans de Goede wrote:
> On 3/22/24 4:37 AM, Kate Hsuan wrote:
> > There is a KTD2026 LED controller to manage the indicator LED for Xiaomi
> > pad2. The ACPI for it is not properly made so the kernel can't get
> > a correct description of it.
> > 
> > This work add a description for this RGB LED controller and also set a
> > trigger to indicate the chaging event (bq27520-0-charging). When it is
> > charging, the indicator LED will be turn on.
> > 
> > Signed-off-by: Kate Hsuan <hpa@redhat.com>
> 
> Thank you for your patch, I've applied this patch to my review-hans 
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> I will also merge [PATCH v5 6/6] platform: x86-android-tablets:
> others: Set the LED trigger to charging_red_full_green for Xiaomi pad2"
> 
> Once the new power_supply trigger patch this relies on has been
> accepted.
> 
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.

I believe I have commented on the "RESEND" version.

-- 
With Best Regards,
Andy Shevchenko



