Return-Path: <linux-kernel+bounces-119199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA2D88C576
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97C77B217C9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D544D13C3EE;
	Tue, 26 Mar 2024 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7U9Codm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5616ED9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464208; cv=none; b=b3XAdkXp8uCaSsJ1xNW29VJjYPICy+DjFoKcMU3rZGnQQI7RTPn7CRvJQVss7jnQOaSrQnbf2aTFOV3xKqfXl/LqkTP1W++Qk8znXdIfg79PHbAK1C/1McHqNYaOPMMmaICaa2bwmE2tfv/Ao3dGMGaWpHN5K+S5XWhGI5fkl6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464208; c=relaxed/simple;
	bh=bPqnX/yjZHJo0l77pmjevs928g1gLuLFPl0cLw5KQ6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JT8Suul3IsIK++guYnEA18X4h9/L60U+XAD31KETnUCpLFdZZnmrkl+4nTKEzLlT6A0PXq2aQ/wusV54A2tDVFFSZ8JRIjIqRjj7IY7mWxzBa1u+R1kgAmSFnPkKhQfaxtQ0vmk/Cu8L162DtQXsZCDt3h0rb0EdhP8f+nCSXnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7U9Codm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711464206; x=1743000206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bPqnX/yjZHJo0l77pmjevs928g1gLuLFPl0cLw5KQ6c=;
  b=J7U9CodmJrl85bZrCQnWc/sAzGuFjyrFsiY8ttCKI31an0cptjDJXn6t
   UkLb2hb2/GWHiBaXaMctYQKcU70RQ93q3AiSwl9A2tQaGpcPkV3e+abJh
   dlx+3bxiPmUqNGjXQtwPUjhgRODUsXYnyALYmCVFwCIFLGhSA8obyz10e
   aHcJ5umQloB5dE4KRXzBS2DBsJAyHIRGL1S53njZr0YUqbcoGw8Qrwpfi
   k+HCABHhJ7Mi9In6H4VtE2b++QfHesbNBjC6jSLSBa0aR9NjxTYWCMrCI
   Z8LgBB6HMbhwdXL1olUJa6cvCME679urG9QwHW1EMeZ01cgPhnIE3x2sV
   Q==;
X-CSE-ConnectionGUID: 0wbD8oXqTb+lDnqFg+y8RA==
X-CSE-MsgGUID: njK+nGf/TJyVV+s/9M0R1Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="28997856"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="28997856"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 07:43:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914882279"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914882279"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 07:43:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rp81J-0000000GKTG-2fcX;
	Tue, 26 Mar 2024 16:43:21 +0200
Date: Tue, 26 Mar 2024 16:43:21 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] driver core: Remove unused platform_notify,
 platform_notify_remove
Message-ID: <ZgLfCZ_mtxRvCRgc@smile.fi.intel.com>
References: <20240325221409.1457036-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325221409.1457036-1-helgaas@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 25, 2024 at 05:14:09PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The "platform_notify" and "platform_notify_remove" hooks have been unused
> since 00ba9357d189 ("ARM: ixp4xx: Drop custom DMA coherency and bouncing").
> 
> Remove "platform_notify" and "platform_notify_remove".  No functional
> change intended.

Less this invasive callbacks, better to maintain, thank you for the contribution!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>

Btw, can we start moving Cc list out of the commit messages?

> ---

You can simply put Cc here, and it will have the same effect (and being
archived on lore.kernel.org) while making commit messages less polluted.

-- 
With Best Regards,
Andy Shevchenko



