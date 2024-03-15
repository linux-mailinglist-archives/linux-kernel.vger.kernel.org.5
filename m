Return-Path: <linux-kernel+bounces-104580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A58AD87D066
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77501C217FD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8033F8D1;
	Fri, 15 Mar 2024 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R1JqKkC4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DEB1946C;
	Fri, 15 Mar 2024 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710516876; cv=none; b=eRKt3lV+07R/sZzbz+qO0qtwAEoIYRNXp6uqogoiDZ3tomxc/iVX2ok71Hho9tP6g7ZuprVWbTnqhcpuNUcEIqUgzwVRRA3QxcoxIT0ksNFJ/EPcusvb0iXoJTFwtJFvQG3EQgrs7PTfNMRw98gFOIbA+xNxAOf8xMxs5HIDPMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710516876; c=relaxed/simple;
	bh=kloGycDSopUOMJZAJlHEKTFM7/I+pN2yYqHLiFNx4vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glW19IG2JUK8SfNnO0VX2mrdIh3Dnt/NGNj2VTDYR/aDW1n05lwO17wQwx9L/wHp+kJb+lvSFZeQSfnRToQqHAv8WgS+bxuwmPjuw02ZCwyLqK/CqQSxlXjxaBgB6vrGpWqMlbv5yHukns3Ep42//WmuxAO3dueDg4pPjoXstYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R1JqKkC4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710516875; x=1742052875;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kloGycDSopUOMJZAJlHEKTFM7/I+pN2yYqHLiFNx4vc=;
  b=R1JqKkC43ZhZpRsbnQIKz4Xp0CPsLEnY+BFEFIUs77vfzBIuUUIjWcFf
   ixmH2RjVv0T+5rPkX1AhmrH7FwkeMpoyThTfIoyd1LLJYwpgkEPY2xFe3
   fCkNi4vIZVHJd3u4ATD2/qe/1WXy1/V0+lgWCqW/SWKnL3UGIA3hoV8LF
   /xIRX2Ovj2wwZutJWUfLv6PeOGle1czcaXc6V86xRMtqURxk65/PmQlbU
   Urd5K5OJZv8gHZNcXHGqnfpQtua/u3kqhCTTKAMLP57QfWSbqEsqadGIK
   F619K5WNhaFoCI9syEiQkK8dAXxYDQqBMNxQvi9iR0VEEQENMYJjzh8Q2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="5257549"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5257549"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 08:34:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="937057705"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="937057705"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2024 08:34:32 -0700
Message-ID: <2a3ab595-80b2-fd4a-8748-c823fa5ec098@linux.intel.com>
Date: Fri, 15 Mar 2024 17:36:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH] usb: usb-acpi: fix uninitialized variable in
 usb_acpi_get_connect_type()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <fdd4f94d-fb8c-44a0-9472-3485a567caca@moroto.mountain>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <fdd4f94d-fb8c-44a0-9472-3485a567caca@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.3.2024 17.21, Dan Carpenter wrote:
> The "pld" pointer is uninitialized if acpi_get_physical_device_location()
> fails.  Initialize it to NULL.
> 
> Fixes: f3ac348e6e04 ("usb: usb-acpi: Set port connect type of not connectable ports correctly")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

I sent a similar patch a week ago, just before merge window opened.
looks like it didn't make it.

https://lore.kernel.org/linux-usb/20240308113425.1144689-1-mathias.nyman@linux.intel.com/

Thanks
Mathias


