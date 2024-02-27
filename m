Return-Path: <linux-kernel+bounces-83445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC35A869964
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A991C21398
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19865149DE3;
	Tue, 27 Feb 2024 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evodVOok"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6D31474B0;
	Tue, 27 Feb 2024 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045742; cv=none; b=TbqD3+Mdry68r1WFyGbaIJjP+sqQ8KvOVX57RD9fRABXOr10UqATGfY7fb5xVEp5sC6M9XLhehZDcb/meEq09j2RPMOBUQhe18WczIstXFEXZQ3qmR9WPoz7ERU4Q/FQWH3ar9LJV6DvoPQcRXeS9Cfpt/f2JOSptZUP6acCHFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045742; c=relaxed/simple;
	bh=oDC1PgzmL9mgKX+1+lda1htyATJjhYL0q5N6OZj/SJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObJbCiIyYFCfs0jJ/5WNUM08i5EL0HVpitMxQsluF293qks3CoU6Y5qoxD7apxmlnD42jL20ljhJSvYuEDyyE0yamc0Cfb/M5cmJCeHdtCE2OlDSwcZl7w84exZOA7pQZUlude8XUUbw9iIO33rG8znmAN2omz+O32KwXTGUDoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evodVOok; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709045740; x=1740581740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oDC1PgzmL9mgKX+1+lda1htyATJjhYL0q5N6OZj/SJY=;
  b=evodVOokAKtIqFWVr4N2beSfFKJqG2GSB1MTBGRfSQOrbUlPe7eNyV9Z
   2iGo1riZII0mHvhIvsqJOcy+vAweHLBcbC0GkaqfI0vSIiqvELLGTTgYP
   cmpkB2f21w/QQeHf99NqdYN2JwRfRzwlaPzCXFNr66cSuP2FHflym8t6G
   YzstYxvsKE+3LaU8ciXouRBOhREbWhueJ6bCptcHVVW+br7VCQlvqS6At
   +nJ7JGgmeg+eCMOwOvUpNGT6r5IMFHV9yPvcDiSif5Lf1mvHcCWAS9qdt
   y8g/Fywdq0hktdf5IbOXaYbz/a9Wbp/yJihLehcbWixKUHtZJ3NyOR8rt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14537591"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="14537591"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 06:55:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="913914293"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="913914293"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 06:55:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1reyri-00000007yFl-0rGB;
	Tue, 27 Feb 2024 16:55:30 +0200
Date: Tue, 27 Feb 2024 16:55:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-rpi-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org, linux-tegra@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 14/14] serial: 8250_uniphier: Switch to use
 uart_read_port_properties()
Message-ID: <Zd334bOasYXT37gW@smile.fi.intel.com>
References: <20240226142514.1485246-1-andriy.shevchenko@linux.intel.com>
 <20240226142514.1485246-15-andriy.shevchenko@linux.intel.com>
 <2cb457a6-0039-e4fe-3668-690e6355771d@socionext.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cb457a6-0039-e4fe-3668-690e6355771d@socionext.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 27, 2024 at 06:43:51PM +0900, Kunihiko Hayashi wrote:
> Hi,
> 
> On 2024/02/26 23:19, Andy Shevchenko wrote:
> > Since we have now a common helper to read port properties
> > use it instead of sparse home grown solution.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I confirmed that it works properly.
> 
> Reviewed-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Tested-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you for testing!

-- 
With Best Regards,
Andy Shevchenko



