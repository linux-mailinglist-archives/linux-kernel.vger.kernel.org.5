Return-Path: <linux-kernel+bounces-14202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7672882190B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FB4A282BBC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFAA79F3;
	Tue,  2 Jan 2024 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kfBQBv/l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5D4C8FD;
	Tue,  2 Jan 2024 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704188799; x=1735724799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bECZ7O/z8Tc/UmhXEp68O58/Z4Jph3I5VYLasVMhaxg=;
  b=kfBQBv/lrT7kBwX6xjDAwoTOEFfpoHvhizxG4ei8mpqp9aK0MoaAKNLj
   Bbws5UytIbY+a+1/LshMfymDpO1xhY2966ENSlLKeodRunvU8d/hSDvmF
   /BmJpFpYqixLQuZ32of7OgGN02Y46yBHLDX6EojXT3hUVHWhmN9bFQJst
   2hRwS7P3SRgNz/iOZyHh4t9TR8ggY45mHLTS1uNE8cEFayqWklHXDgMUI
   1oNOeYGrlfwpPAnec1RYqQlaWagpW7gQRchj0mUCNIJGA9P3J3LsX/Oq3
   I/HPNILtayGpEa8BOXFPnGp71NmhguDDzTg5yHVomAeak04UjlwrC4rPs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="400664998"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="400664998"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 01:46:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="923179865"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="923179865"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Jan 2024 01:46:35 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Jan 2024 11:46:34 +0200
Date: Tue, 2 Jan 2024 11:46:34 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Suniel Mahesh <sunil@amarulasolutions.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Kyle Tso <kyletso@google.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	USB list <linux-usb@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: USB PD TYPEC - FUSB302B port controller hard reset issue
Message-ID: <ZZPbeUbMM3J4pH/K@kuha.fi.intel.com>
References: <CAM+7aWvGerEdUnsKboUg9+EoL=66k3nULHCnQgHyxsWQhUwmpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM+7aWvGerEdUnsKboUg9+EoL=66k3nULHCnQgHyxsWQhUwmpw@mail.gmail.com>

Hi Suniel,

On Tue, Dec 26, 2023 at 04:14:48PM +0530, Suniel Mahesh wrote:
> Hi Guenter Roeck / Heikki Krogerus and all,
> 
> 1.
> I am testing USB TYPEC PD on a Rockchip Rk3399 SOC based target which has a
> FUSB302B TYPEC port controller.
> 
> 2.
> My source is a wall charger which is based on Gallium Nitride (GaN II)
> technology and has four ports as follows:
> 
> USB-C1: 100W PD3.0, 5V/3A, 9V/3A, 12V/3A, 15V/3A. 20V/5A. PPS: 3.3V-11V/4A
> USB-C2: 100W PD3.0. 5V/3A. 9V/3A. 12V/3A, 15V/3A. 20V/5A PPS:3.3-11V/4A
> USB-C3: 20W PD3.0, 5V/3A, 9V/2.22A, 12V/1.67A
> USB-A: 18W QC3.0. 5V/3A, 9V/2A, 12V/1.5A
> 
> 3.
> i am using latest linux-next and enabled all the relevant configs,
> especially:
> CONFIG_TYPEC=y
> CONFIG_TYPEC_TCPM=y
> CONFIG_TYPEC_FUSB302=y

Which kernel version?

> 4.
> DT node is as follows when i use USB-C1 of wall charger:
> 
>  connector {
>                         compatible = "usb-c-connector";
>                         label = "USB-C";
>                         data-role = "dual";
>                         power-role = "sink";
>                         try-power-role = "sink";
>                         op-sink-microwatt = <1000000>;
>                         sink-pdos = <PDO_FIXED(5000, 3000,
> PDO_FIXED_USB_COMM)
>                                     PDO_FIXED(12000, 3000,
> PDO_FIXED_USB_COMM)>;
>                 };

What do you mean by "when i use USB-C1..."? Why is the above valid
only then and not with the other PD contracts?

> Issue:
> The board power well most of the time, but may be in 1 out of 5 cold boots,
> FUSB302B is getting a hard reset, as
> FUSB302B INTERRUPTA register bit I_HARDRST is getting set.
> 
> After some digging, found out that the above behaviour is accounted to when
> something is wrong with the CRC of
> the received packet (SOP - Start of Packet)

How did you determine that the problem is a bad CRC?

> This behaviour is seen i.e. FUSB302B getting a hard reset more on the
> USB-C3 port.
> 
> Any pointers on how to solve this issue.

Guenter, do you have time to take a look at this?

thanks,

-- 
heikki

