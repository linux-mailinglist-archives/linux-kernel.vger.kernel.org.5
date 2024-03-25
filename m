Return-Path: <linux-kernel+bounces-117547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FD888AC6D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467142E3E30
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DC513175E;
	Mon, 25 Mar 2024 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yc7K5wNQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564A0130AF5;
	Mon, 25 Mar 2024 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386497; cv=none; b=F+1F/40/lGDhgXoReRb2LD8AncYccLI0z8wNXxpzdD9HZa+IysvEX9YIYyKKuw51LI49mlXd1N9zRwLRMtMwAr+VrP/aiKNta4otifXaT+jWHuBn/gyssQz/Qw6+cvkUnXiWDQfrl6lADZKP7+4aAMhQ1+1ycKbJ8IMBPWzFr0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386497; c=relaxed/simple;
	bh=Qlv80kCO+uDiNVRydwsHmxe0wgfxC8bG6UI4phMkXz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exGr+9yCxRl1Dn2dPpmXvyOjy1LT5cGMfVli9tbcadHYu/uuqC7TSRRCBY7u5yeYdVWLvUWsw7x7f1CFUepEtRuCpVfYOTZoQBcO8FCPNHWmvauuGvReRDjYVnGBsx4tGekEm5gWTySH2ArKps+cwrbayLaMZZbdh4WXWBHkbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yc7K5wNQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711386496; x=1742922496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qlv80kCO+uDiNVRydwsHmxe0wgfxC8bG6UI4phMkXz4=;
  b=Yc7K5wNQ4o0kJBkkIXgeFUt0bIQAwtSdAiyoT+fF8ESa1vD2CaVNeMKm
   XWLZ5M8IvaiSMVArIAHep5/dVpLjmFow+NP8J4ZSusBKkanQMdwMCKVFh
   YHQpLZwU4AnvDVIGVA53Ka5LrKbhRil6QcgromH9G30ekuDoypbhFH4FK
   zWipeeP0jqoEqtLSysy3cU3KeHbtymd0GmGM7h3AcJJYlgCmzlElvXiEc
   Y6keGsUe0yYlJ3rNc1vh3yM7o51gByKSFngGUuYNvtdJPCbQI90gX6EH0
   O3e9hmqWn2JodYc9e4wviCJ07QGussNsDjLt7SRfDoL8COliKE2br9FGy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6267179"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6267179"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 10:08:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="914849410"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="914849410"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 10:08:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ronnu-0000000G3cO-3pE2;
	Mon, 25 Mar 2024 19:08:10 +0200
Date: Mon, 25 Mar 2024 19:08:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 1/1] ASoC: soc-jack: Get rid of legacy GPIO support
Message-ID: <ZgGvev-Wh7SkYnI7@smile.fi.intel.com>
References: <20240325143654.3305498-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325143654.3305498-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 25, 2024 at 04:33:50PM +0200, Andy Shevchenko wrote:
> No more users.

FSL code needs to be cleaned up (there is a leftover that makes this fail).
:-(

-- 
With Best Regards,
Andy Shevchenko



