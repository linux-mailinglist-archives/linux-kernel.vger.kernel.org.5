Return-Path: <linux-kernel+bounces-58456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAFE84E6B8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB601F27DA9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B2C82D76;
	Thu,  8 Feb 2024 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b6f4PEtj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DD282D6E;
	Thu,  8 Feb 2024 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413167; cv=none; b=jkX08W7pOgozdm6k5eqXnxu+dQGVfYm2rnR79zuSMSW6eAEZq9gZIbgEmZs+PcQYWQAYwfsA060gWH+e1+3tiIGmoafp2lR5cAvIbkZQXWs9FEMF9sJZorSJP5yTmXE4svsiqjjPZoZb9GLmCOupYb+c0BL0i5IqdFqxjv5Rz00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413167; c=relaxed/simple;
	bh=zUGBL4281PBOFneM50uIa24QDg/JxNi7g4I6JIFlawk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiDpgAWLEIcb4CmKI1El1xkGbFLZ02xjIrteneD7TKHle3xOZUa3jlvhSN36GkydPND/A78sFVBFdIezkHWP9z3EE5xGWjBvzmS4YLxYYrQjR1LzyoaSMis0WalOUuWr0FPuQgqQRZpy5kVwt9h9kKScm+T5/zzaSh8zJHXoH3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b6f4PEtj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707413166; x=1738949166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zUGBL4281PBOFneM50uIa24QDg/JxNi7g4I6JIFlawk=;
  b=b6f4PEtjda3/g5FBBbZymD6PMRSyI9BYaIglZdvYIMK5XTviVPpn1Lil
   edysTQF2LWzyvv0Iguwp8DKwdhZixTZDzOKxaR5QdRVn/Ddg822FQ+M6f
   F17yJkbqdVDsiY00l9jYczgpoDmOBnn1ymnlSgPJoGqYFTgjQE/VneOMt
   ndnvMFg/m7gV9+Kgas24DtYve0qfhI+JBpIiFnAd/pqZu7moGc7lzIO4K
   lIk2MxodBJKKitPK11RruuTRY5fk8ft9PNiCrxFDxOMEhbgWBF/+PUM3b
   Ormsy4LiZH3TZkLhzGwdigSzy+7e642wFBuZMdbRPkxSFxo2Z/FygNPq9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="11844250"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="11844250"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:26:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910434842"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910434842"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 09:26:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rY89v-00000002w7w-3HpU;
	Thu, 08 Feb 2024 19:25:59 +0200
Date: Thu, 8 Feb 2024 19:25:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Yicong Yang <yangyicong@huawei.com>, gregkh@linuxfoundation.org,
	tony@atomide.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, john.ogness@linutronix.de,
	tglx@linutronix.de, yangyicong@hisilicon.com, linuxarm@huawei.com,
	prime.zeng@hisilicon.com, jonathan.cameron@huawei.com,
	fanghao11@huawei.com
Subject: Re: [PATCH v3] serial: port: Don't suspend if the port is still busy
Message-ID: <ZcUOp60BX8njHQ4Q@smile.fi.intel.com>
References: <20240208075216.48915-1-yangyicong@huawei.com>
 <beb599e2-ebc5-4b26-82c3-908830effd5a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beb599e2-ebc5-4b26-82c3-908830effd5a@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 09:27:57AM +0100, Jiri Slaby wrote:
> On 08. 02. 24, 8:52, Yicong Yang wrote:

..

> >   static int __serial_port_busy(struct uart_port *port)
> >   {
> > -	return !uart_tx_stopped(port) &&
> > -		uart_circ_chars_pending(&port->state->xmit);
> > +	if (uart_tx_stopped(port))
> > +		return 0;
> > +
> > +	if (uart_circ_chars_pending(&port->state->xmit))
> > +		return -EBUSY;
> 
> Why do you do this change at all? If anything, __serial_port_busy() should
> be made to return a bool and not to return an error. Look how it is named --
> returning EBUSY is sort of unexpected in my eyes. And if this needed to be
> done, it should have been in a separate patch anyway.

I proposed that with a renaming, so it won't look as boolean.
And I also implied (sorry if it was unclear) that this has to be
done separately, so we are on the same page about this.

-- 
With Best Regards,
Andy Shevchenko



