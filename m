Return-Path: <linux-kernel+bounces-140270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0418A1121
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2785A1C23A00
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66392146D47;
	Thu, 11 Apr 2024 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvJySiYW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFA8142624;
	Thu, 11 Apr 2024 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832040; cv=none; b=rk3eL6WlqirfEuLORvsPxpV8W5WwN7WNj0sEyrsNXiWdWdzUr3S1yBaY9Wgpxc7qExf5B5N/OMb6HLO0npt3TUKM1yOS8lHtwY+22aoRW4eM/TLW2UXrQU3PY/DwXRQicPNDrx9HNNNL8DvlYZ+7YXYfyk7uwJWjV/q51PULWfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832040; c=relaxed/simple;
	bh=nJ2jYnGwB3e8YxPRApDWAACUwQPgfcEtz5rNSG7skCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIsVmQ9LWOWyinG2B1Dh8ZUYpLWCqytpf/0fPZ5u3MWIT9jvvYm31n/1TX3rblwGBRiZoRy3ETLfUaXsPZu2JBgfvkHC8ARGbSHfAJ4Yz83ORyJolXXXpAvZL05ztT7j+WAAfkrh774AeEgVR5d09cMwGmMJEQ/vXKjsRSyXa+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvJySiYW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712832039; x=1744368039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nJ2jYnGwB3e8YxPRApDWAACUwQPgfcEtz5rNSG7skCc=;
  b=jvJySiYW9izPlYnpTrRFtsNze6kB5uBh5cbS84GzGGqjwBc18QJMc6BV
   mXTRGrDQ5LnrjGa3rMdkB4QaYkuhRiMvINwvqQMPMQCP1iv/GU9jP0ugL
   OCwz8AHtOnRViEY1qEWqzLOi60QiEudotA913jokBi61Y0AGTRpfxlM3z
   Jw7BmeYipG8hHNqvsh61WJdQ3tvQUGqs8AB4KC5WA5IUYPHoemSinfReg
   7ef71S3F7x5lMMH1sKiFGB2wOc4n5xsbEb0Q2tGegf5mPz2JtHVvncncb
   iozlY6deG9QZdEIUpppGteEtrliwYGdc6cs+0KIlW6d7jnFcttKUblTvt
   w==;
X-CSE-ConnectionGUID: YjWmECwGTj67H5hzmfqegQ==
X-CSE-MsgGUID: joY7EIGZSaurKWgweKWY5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8454134"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8454134"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 03:40:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915459920"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="915459920"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 03:40:36 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rurr8-00000003K8T-1IvC;
	Thu, 11 Apr 2024 13:40:34 +0300
Date: Thu, 11 Apr 2024 13:40:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Greg KH <greg@kroah.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the tty tree with the tty.current
 tree
Message-ID: <Zhe-IirD9U9b13hk@smile.fi.intel.com>
References: <20240411135735.58de7090@canb.auug.org.au>
 <20240411141711.63dbd8e9@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411141711.63dbd8e9@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 11, 2024 at 02:17:11PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Thu, 11 Apr 2024 13:57:35 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the tty tree got a conflict in:
> > 
> >   drivers/tty/serial/serial_core.c
> > 
> > between commit:
> > 
> >   9cf7ea2eeb74 ("serial: core: Clearing the circular buffer before NULLifying it")
> > 
> > from the tty.current tree and commit:
> > 
> >   1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
> > 
> > from the tty tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> > 
> > -- 
> > Cheers,
> > Stephen Rothwell
> > 
> > diff --cc drivers/tty/serial/serial_core.c
> > index 2247efe97250,a78ded8c60b5..000000000000
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@@ -1788,9 -1773,9 +1773,10 @@@ static void uart_tty_port_shutdown(stru
> >   	 * Free the transmit buffer.
> >   	 */
> >   	uart_port_lock_irq(uport);
> >  +	uart_circ_clear(&state->xmit);
> > - 	buf = state->xmit.buf;
> > - 	state->xmit.buf = NULL;
> > + 	buf = port->xmit_buf;
> > + 	port->xmit_buf = NULL;
> > + 	INIT_KFIFO(port->xmit_fifo);
> >   	uart_port_unlock_irq(uport);
> >   
> >   	free_page((unsigned long)buf);
> 
> That didn't work :-(

Yes, that's correct one, i.e. one from tty-next should be used.

Thank you!

-- 
With Best Regards,
Andy Shevchenko



