Return-Path: <linux-kernel+bounces-49966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B7284722F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18EA1F2AAC6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04F514532B;
	Fri,  2 Feb 2024 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxGIDKUy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553473C0E;
	Fri,  2 Feb 2024 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885379; cv=none; b=jNQJ1y/2ikZvlNk7dhxTkKddymWScRSaCM1vfXjCPJECFwkdennfbpba4maudM+an5K2JQioeEIcdgQf4dR9XmUjQvvHOe5wQGFaGI2AeGdW3GSHr02gXDWRNt80JZdXZYo3cXWsRJdh2+V8MP4lLUP5lpBY3lHmWQJcIphcnjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885379; c=relaxed/simple;
	bh=GLWVv2wG1W5Docrd2ffJlZ62lITTa59KuRjNqA7Jq/Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=nHWr1fFFu28CkJafcvUnkXmxWZDoIbKtOzdUQCbue3qiOpRMYnTdLZVn3rpfcOw5BR8UiNyrlfL5VTQqqP+OafbNtqYq3ZYMVFqwWUnarVt5hW4A/gfkEeAlaMzklDxk+hC21bcd6I/o/tGIywozImSjlQMwPZvq+1nYdMXJ3hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gxGIDKUy; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706885377; x=1738421377;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=GLWVv2wG1W5Docrd2ffJlZ62lITTa59KuRjNqA7Jq/Q=;
  b=gxGIDKUy9IFQ6Z2iPyDi30ZpFLwxRk6tTjf0BIXWsL8Tu3A9pOff6smS
   9mR7VoRE3IYUyvI1tcJNLbiI9m5pLsADGzyO/bB7dGz0+9SECTtUDb4YM
   D8i0qMW696TbggIXqv4vLYfBBmLBjY56ujwIDHC0nJXgHyMOsDGSAVODP
   h36V0NLog3pbpE0nBu4jEqZKNgIbRIPL0MNWDcI6bf0r5dJv5R7mZm101
   UBjTbhcAmKhF89pr5svhvlHDzRpAsULTQI6XO214sQdRL1OwW73DV5Vkb
   4fG5o2+uanzSpcArTQdvIBBhdEYEsjripa6t/K767wVM6exaUyEhmaseR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="355827"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="355827"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 06:49:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="823227502"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="823227502"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2024 06:49:31 -0800
Message-ID: <70412f57-b59a-3a46-6853-4312991c19e5@linux.intel.com>
Date: Fri, 2 Feb 2024 16:51:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Guan-Yu Lin <guanyulin@google.com>, gregkh@linuxfoundation.org,
 mathias.nyman@intel.com, stern@rowland.harvard.edu, royluo@google.com,
 benjamin.tissoires@redhat.com, hadess@hadess.net,
 heikki.krogerus@linux.intel.com, grundler@chromium.org, oneukum@suse.com,
 dianders@chromium.org, yajun.deng@linux.dev
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 USB <linux-usb@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
References: <20240202084815.3064391-1-guanyulin@google.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH] usb: host: enable suspend-to-RAM control in userspace
In-Reply-To: <20240202084815.3064391-1-guanyulin@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2.2.2024 10.42, Guan-Yu Lin wrote:
> In systems with both a main processor and a co-processor, asynchronous
> controller management can lead to conflicts. For example, the main
> processor might attempt to suspend a USB device while the co-processor
> is actively transferring data. To address this, we introduce a new
> sysfs entry, "disable_suspend2ram", which allows userspace to control
> the suspend-to-RAM functionality of devices on a specific USB bus.
> Since the userspace has visibility into the activities of both
> processors, it can resolve potential conflicts.
> 
> Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
> ---

Doesn't setting this new disable_suspend2ram break system suspend on all
other systems except this one?

On any system with a PCI xHC we end up trying to suddenly stop the xHC
host with all connected usb devices still fully up and running.

In the xhci platform device case again nothing will be stopped or suspended,
but PM framework assumes everything is suspended correctly.

So then xHC either continues running and generates interrupts, or it might
be abruptly powered off if the bus above it suspends.
(For example if the xhci platform device is created by a PCI DWC3, and it
goes to D3 state)

EHCI and other hosts face similar issues with trying to suspend the
controller when the devices connected to it are fully up and running.

To me it looks like this whole co-processor case needs to be developed and
designed into the pm framework

Thanks
Mathias


