Return-Path: <linux-kernel+bounces-76915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B43685FE8E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257402836B3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C6F15444C;
	Thu, 22 Feb 2024 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3WXcIlo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C330153BEF;
	Thu, 22 Feb 2024 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620996; cv=none; b=DwQFtA1e0MP+ytqngINsawfMCaC/OeRJtzf0/Iymb9KNCz+Sm0cLhbofrGawv2rIPZIxLPoiAK6Q5uaprOcDdwL5aF7mVbEmDGs7cUq8EpqXkFvAXa56hi7VZCCIC2PPsIwQ/6lS+8BoLlBQC4nrBv4Rfpf5aiI3BeyiLaUkbDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620996; c=relaxed/simple;
	bh=huc/iR8sXK46IqfaL7hOgtCi7xC9fXmaG1/DxLXN/s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESwzwX/rMz/vgawqsIE+YUDnyS88hjKtXZmYpOPzhuBHhIsbPcJMkE9WyWaBSAHG19zVYhx2rVqqmzghUEbLTmthkFfFPysKLeotXGQTkRdGP/iJSN4rcr0ePeZWbKhiwnbxWKzfcy+nYto72RjJ6cB+CL92Ku1AqJme8XYstQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3WXcIlo; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708620993; x=1740156993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=huc/iR8sXK46IqfaL7hOgtCi7xC9fXmaG1/DxLXN/s4=;
  b=Q3WXcIloCTEEw4Gqv9rwrkWJ0ItkqCbChOIQzBp44uVQMxqaNPtijI7c
   SarZoyKUjq80qq80i2wBBmoRyrLSRS1qeWkWw6Gz3+8adJAWIZxJFcbii
   t/6xKcNaUwRLu7uAUXRAUWLyqCLflULqarfnLkeBAV7nGhZ1tvEtDs8WU
   sLoQw81wm9oj3Db9swe3o+LZ9cptUPlzpLecjsd1enlEsHeKMb4Vx+LpI
   2XpAfGUBqaSwAJSH0SrId4Hnvm4kmOYPrSxiDz9XC/EMxK9s/dBq9pKNI
   7Ypvfgbkqi0U0hGdmjNM7z02XgV/raZOS0HQwzMLjTypMJZznjj4fIYmD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="6679422"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6679422"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 08:56:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="913555622"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="913555622"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 08:56:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdCN0-00000006gK3-18Lx;
	Thu, 22 Feb 2024 18:56:26 +0200
Date: Thu, 22 Feb 2024 18:56:26 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>,
	Mark Brown <broonie@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 1/5] net: wan: Add support for QMC HDLC
Message-ID: <Zdd8ukxdhH16vRDJ@smile.fi.intel.com>
References: <20240222142219.441767-1-herve.codina@bootlin.com>
 <20240222142219.441767-2-herve.codina@bootlin.com>
 <ZddoQTg32unJJ_qP@smile.fi.intel.com>
 <20240222174501.4cbe03ab@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222174501.4cbe03ab@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 05:45:01PM +0100, Herve Codina wrote:
> On Thu, 22 Feb 2024 17:29:05 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Feb 22, 2024 at 03:22:14PM +0100, Herve Codina wrote:

..

> > > +	spin_lock_irqsave(&qmc_hdlc->tx_lock, flags);  
> > 
> > Why not using cleanup.h from day 1?
> 
> I don't know about cleanup.h.
> Can you tell me more ?
> How should I use it ?
> 
> > > +end:  
> > 
> > This label, in particular, will not be needed with above in place.
> > 
> > > +	spin_unlock_irqrestore(&qmc_hdlc->tx_lock, flags);
> > > +	return ret;
> > > +}  

Here are the examples:
6191e49de389 ("pinctrl: baytrail: Simplify code with cleanup helpers")
1d1b4770d4b6 ("platform/x86/intel/vsec: Use cleanup.h")
e2eeddefb046 ("pstore: inode: Convert mutex usage to guard(mutex)")

Some advanced stuff:
ced085ef369a ("PCI: Introduce cleanup helpers for device reference counts and locks")

Hope this helps.

-- 
With Best Regards,
Andy Shevchenko



