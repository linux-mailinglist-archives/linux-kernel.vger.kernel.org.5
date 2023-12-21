Return-Path: <linux-kernel+bounces-9037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F2181BF7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207232854C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1667374087;
	Thu, 21 Dec 2023 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nw9Wlkhk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AD1745C7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703189584; x=1734725584;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PA2txARed54R/QQdGqV9jJaFmaCK/sHZ44SJ0NakNgg=;
  b=nw9WlkhkYc2EKtRkXNVclQKUpieKPr7nb8poRuri2AFRu7TOqZk4sNt3
   0AzB1mIK4LGQXtklJ5r1DNi79LGORcCFf5kPHHAM/fTdseBQ0ra/aaDc9
   M1/ckuBKxPlI7OxRLm0JAJ7lzglchwnFzeJYYJjaLQLteA8ckQyHb3q7T
   rCZvEfCypPw5sgM4VG57DqYGotwACEzelyTuzXWKieHr6X7IK9sxjMXrY
   BlYauTnKV77Wg25G/L3m7xkUPE2FMR9wVb0e6o2CmzH7YGUXMQvqHJVZa
   0Ri0S/iun189KZ8n+ovgfEwJAilhGqooVGeqcVEN/60xnb58cPszOs7SW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3265594"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="3265594"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 12:13:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="1023979772"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="1023979772"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 12:13:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGPPg-00000007xji-0ZBE;
	Thu, 21 Dec 2023 22:13:00 +0200
Date: Thu, 21 Dec 2023 22:12:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 0/2] Fix LPSS clock divider for XPS 9530
Message-ID: <ZYScS2bh9RzS_lxw@smile.fi.intel.com>
References: <20231221185142.9224-1-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221185142.9224-1-alex.vinarskis@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 07:51:40PM +0100, Aleksandrs Vinarskis wrote:
> Dell XPS 9530 (2023) uses spi-pxa2xx with clock-divider enabled from
> intel-lpss with the ratio of 1:32767 (Dell's firmware bug). This caps SPI
> controller's speed at very low value of 3051Hz, which makes the interface
> practically unusable. Since either spi-pxa2xx or intel-lpss should have
> clock divider enabled, not both, and SPI controller can have higher speed
> than requested by the device, it is preffered to disable intel-lpss
> clock-divider, and let SPI controller handle it.
> 
> Fixing this issue directly in Dell firmware by setting lpss divider to 1:1
> would've been the ideal solution, but is unlikely to ever happen.
> 
> Particular driver already implements customized solution for handling buggy
> ACPI tables for select Microsoft devices. This patch series converts it to
> a more generic quirk table, and adds a new quirk QUIRK_CLOCK_DIVIDER_UNITY
> which forces clock divider to be set to 1:1. In the future, devices with
> similar bug (if any) can be easily added to the same pci id lookup table.

LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



