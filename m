Return-Path: <linux-kernel+bounces-63845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84774853566
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416F2284970
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969595F867;
	Tue, 13 Feb 2024 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XaizkOgR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCD55F846;
	Tue, 13 Feb 2024 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839797; cv=none; b=AwUaCVzOyrzvc+PEbXnVFbB/5cGhRBYy845Z8HzviCB7yc8O5bYfwzPgtSjZOrax7FtIFkKuuNypebW/fs+TTy8TxKRWSKnxdIuZJkrTfrlRj+JZ4bDkoUk4pJ4F/UVSUB6we2vH6umEjAkvsfNNhJYNTunI35lfVfXWQMyhxCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839797; c=relaxed/simple;
	bh=PCShbNrnThKDCz7+yfYhrs+Gynx1qEZaMiqkRzVyOxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZyFfNJ0oH9GNQpojQDGhKpN8KYePuQgcMhW/8p+diIIqtceMyRhEHFXjr0KhtRp6xfPfoSMf5qH6Zjt088H8m0LFmFJQqMqXNplwv3jttN73lNUJofy6CjQQdqqAAMKe7cds8ZXh/Q8lguzl9WiYe6HIEn2egYt0aDchsnkJQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XaizkOgR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707839796; x=1739375796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PCShbNrnThKDCz7+yfYhrs+Gynx1qEZaMiqkRzVyOxA=;
  b=XaizkOgRcoIjTZq4+oXM2D8iGzARsfj9sufl5j5pPVqInEE+3BJNUfsy
   WDUTWpJgTUlcROMCnkn3bh6ub/WuhiGJ/ow0ftVSPTLNVuzaGqqCY6ijn
   a+k0aPvp1z4R8+aV2Vg6XcmWUpCpHdSHIfYVJInZd77heZUujhxJ5aF2u
   RPi7y4dOMBDELvREXeh1RsZA3dMZ54X2hPdxjkqqOqaTXUEH9GC2NTheo
   umqwuORTaUJCQThEumDpBqCbBxVjUVoVhhTi40fkVVJ0I0c3Le8FmaWT/
   kvGkKH0B6UqOJ66ql7o/0cRezNAgQ213NDmwY8vyIyzeuXzeeB1aiCdUy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1757705"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="1757705"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 07:56:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911816020"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="911816020"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 07:56:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZv92-00000004G5o-1wON;
	Tue, 13 Feb 2024 17:56:28 +0200
Date: Tue, 13 Feb 2024 17:56:28 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"David S . Miller" <davem@davemloft.net>,
	Dhruva Gole <d-gole@ti.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 5/6] serial: core: Handle serial console options
Message-ID: <ZcuRLBcXr7QQh3in@smile.fi.intel.com>
References: <20240213084545.40617-1-tony@atomide.com>
 <20240213084545.40617-6-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213084545.40617-6-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 13, 2024 at 10:45:12AM +0200, Tony Lindgren wrote:
> In order to start moving the serial console quirks out of console_setup(),
> let's add parsing for the quirks to the serial core layer. We can use
> serial_base_add_one_prefcon() to handle the quirks.
> 
> Note that eventually we may want to set up driver specific console quirk
> handling for the serial port device drivers to use. But we need to figure
> out which driver(s) need to call the quirk. So for now, we just handle the
> sparc quirk directly.

..

> +static int serial_base_add_sparc_console(const char *dev_name, int idx)
> +{
> +	const char *name = NULL;

Seems like redundant assignment.

> +	switch (idx) {
> +	case 0:
> +		name = "ttya";
> +		break;
> +	case 1:
> +		name = "ttyb";
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	return serial_base_add_one_prefcon(name, dev_name, idx);
> +}

..

> +	/* Handle ttyS specific options */
> +	if (str_has_prefix(name, "ttyS")) {

Recently I have learnt that we have strstarts() which returns boolean and suits
in cases like this. If you send a new version, you could switch to it.

> +	}

-- 
With Best Regards,
Andy Shevchenko



