Return-Path: <linux-kernel+bounces-3922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D52817528
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62E41F2401D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3F33A1C0;
	Mon, 18 Dec 2023 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HohRiaUo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5083788A;
	Mon, 18 Dec 2023 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702913009; x=1734449009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wO1eltBfVSVmXD8UanEjRjqynsVynOHtm8y/hkXYzsA=;
  b=HohRiaUoA5beDak/2jDVXDaWvCZuNOrmW35o+36Oo4xupbNt78SFij59
   8CE/xmgMlPW3Gd+7mz384B7+yG4m+gXoc9jKkOoWLjuLaZk4fK5zgu7Hx
   OFnn9z3I84HcphFdi2XNbI2oroEzujuj2zTkFu6lJof+34ZL6n/jOwUOF
   0GFlEJuuoOsK0anhw1yFjijD7ZCFfvv4hL3DwMx2LvWnEza63cDw+vERS
   uD0kEET/pfmFPYhoM+F3ylqSSH+45DHnPoNqhQrBCII7yggh4TGwlRfXc
   aKtJo5cdzv3t70ka1wXN2hOvlwuZ683ajr5Q2VxB8zP/KwCl0pzCEQiUM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="426654812"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="426654812"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 07:23:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="775613837"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="775613837"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 07:23:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rFFSj-00000006yMZ-0NMg;
	Mon, 18 Dec 2023 17:23:21 +0200
Date: Mon, 18 Dec 2023 17:23:20 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
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
Subject: Re: [RFC PATCH v5 5/6] serial: core: Handle serial console options
Message-ID: <ZYBj6J2-9VLzQI5z@smile.fi.intel.com>
References: <20231218071020.21805-1-tony@atomide.com>
 <20231218071020.21805-6-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218071020.21805-6-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 18, 2023 at 09:09:52AM +0200, Tony Lindgren wrote:
> In order to start moving the serial console quirks out of console_setup(),
> let's add parsing for the quirks to the serial core layer. We can use

> add_preferred_console_match() to handle the quirks.

While it's technically true, the code uses
serial_base_add_one_prefcon() wrapper.t grep

> Note that eventually we may want to set up driver specific console quirk
> handling for the serial port device drivers to use. But we need to figure
> out which driver(s) need to call the quirk. So for now, we just handle the
> sparc quirk directly.

-- 
With Best Regards,
Andy Shevchenko



