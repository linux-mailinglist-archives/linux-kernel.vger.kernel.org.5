Return-Path: <linux-kernel+bounces-32058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDBA8355DA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D159B1F224B2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E311C37169;
	Sun, 21 Jan 2024 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBkIyFi4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83107364A7;
	Sun, 21 Jan 2024 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705841795; cv=none; b=Cb3MaaEoPtbfVpqlGJHUGkmlNQADBg7zKPXde/2srC3lPsKRudSsnZC09h2sTtLQzll8PeUcxATu0lj+TdzAS0zYQKBKx6dnH2uqvLHWZBkMCxNvrifHiMyVOGS4H9PtAnoInQzPcdSUwW5FZpRK5ruNsxlUJhIVV4YgYdIbguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705841795; c=relaxed/simple;
	bh=CU8CVt0gIhATyZrqsZlQzuxnGQAXF7t8casXv8CS7Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIWSyWUmlgg9eMv2Q1SlplWUuHZwb284NnQ2dYL7MmS1eUJdhqowxizuJVbwHjiJ3CvMGndeEfDJAYPkednsw5piLHl4owncGbg30pHxdNwx8mYmEk4iyyWxexdJ1N2H6fuYULVRlLQlzJCkufu/o1BwZi29Fqs2oVbX0aE2Skg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBkIyFi4; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705841794; x=1737377794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CU8CVt0gIhATyZrqsZlQzuxnGQAXF7t8casXv8CS7Go=;
  b=JBkIyFi4xXgSeiLUFHzyf7qCHYVmNybE3t9VIGiFODsjoVDrvaEuknL6
   IIym4B6Op/N64Vlv5kRIs8ntkLlKZ+xyEClMBoF55RKx8bwjm1U2bVvXh
   88lDVcjwLhFnNZz81Da9HmshFsCjycf0hYLXIc8Y9L3+w2KVFs8V2oWgk
   o3UgeAo5JOm6JfGkpFm+6RvUZ2LEJYXLCzoa07SAFY7rKDgl9R56F2+2X
   RVCjHM1DE/9N0Y+0Nrkd4h5Uyp+Lu15ctsCUNs5LlQnwHScCt/TZ6V+YJ
   VS8ejrIG/NZ25G2wrXeKr2IfxkFP7kxTq1kqQeFWc7DRf4op3BgDlxSyn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="7705119"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="7705119"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 04:56:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="1032341043"
X-IronPort-AV: E=Sophos;i="6.05,209,1701158400"; 
   d="scan'208";a="1032341043"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 04:56:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rRXND-0000000Fcqz-0jn9;
	Sun, 21 Jan 2024 14:56:27 +0200
Date: Sun, 21 Jan 2024 14:56:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	linux-acpi@vger.kernel.org, stable@vger.kernel.org,
	George Melikov <mail@gmelikov.ru>
Subject: Re: [PATCH] gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-04
Message-ID: <Za0UenM4CweUNZhW@smile.fi.intel.com>
References: <20240117142942.5924-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117142942.5924-1-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jan 17, 2024 at 08:29:42AM -0600, Mario Limonciello wrote:
> Spurious wakeups are reported on the GPD G1619-04 which
> can be absolved by programming the GPIO to ignore wakeups.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


-- 
With Best Regards,
Andy Shevchenko



