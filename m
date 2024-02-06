Return-Path: <linux-kernel+bounces-54763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1886A84B367
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2C51C2308C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E640C12D148;
	Tue,  6 Feb 2024 11:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eov0V6IC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FDC12E1DC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218694; cv=none; b=kcnHchf1oAU6wqfNgsNGXrH/V0BDkIKQiJaqUTMH6rhHpWHMyV3XaIeydZ5NtLYJqOYR97NwbAhOc9oJfgTjYkncVwBtjh54V5l3g9+ezDm5jWpE8Clx4vXwPZjyUw5v82rAaaCDajlwUKjxvCB3MioPH+azyLODW0EvvCNr000=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218694; c=relaxed/simple;
	bh=KJDD0UdxR2Cvfde9iNwq5yVfSHv/ixq+s6XQ8Zuq8Do=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=BzX8LM122C3K9Td57xlkR8J+rDdR41+eJRXDGivqGbdul/x+S0JLKkjlmn8E9UNxMtDS/BTaoG57OIhVisRNmcADd5qkTrSzI9onMxy96dzooXpp4xOJvyuZRGxhUFtjLuvrdkg+B3XbqKYWBgFZEaOmGTI7tW9o7UiW7v6F814=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eov0V6IC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707218692; x=1738754692;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=KJDD0UdxR2Cvfde9iNwq5yVfSHv/ixq+s6XQ8Zuq8Do=;
  b=Eov0V6ICXutdzGG+O2zAMy4hUjfTpnuiPYFiy0NxecN6SayuElgqzhHR
   HueDJ40NJVIB0TUZUmHwJswtNbJV4o+2dpfm3OcydkjUm7KmID3C8Y9rI
   ihc82sN/ejn4RbMbfLxh961JYS55Uw9xUNCKNplF5CgX0QiavQabnTCiX
   J+7ChgecenNHyME68NG8n0JuUCraYolZfBwu90h83FGhNle6Vcsrq3PCi
   qkSjN5/d5h7EnpuRCcLdwHif5yN6oM7p487hEgkhQ61s/Mhi+oNA01xPw
   V7/YjP4FVXvWAa1nQJBhsPtPmxyb3ihr18HwalGAa2tnsfKvmfRquFP6U
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="613446"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="613446"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 03:24:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="824164642"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="824164642"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orsmga001.jf.intel.com with ESMTP; 06 Feb 2024 03:24:49 -0800
Message-ID: <e7b96819-edf7-1f9f-7b01-e2e805c99b33@linux.intel.com>
Date: Tue, 6 Feb 2024 13:26:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 "Christian A. Ehrhardt" <lk@c--e.de>, niklas.neronin@linux.intel.com
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 linux-netdev@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
 <Zb6D/5R8nNrxveAP@cae.in-ulm.de> <Zb/30qOGYAH4j6Mn@cae.in-ulm.de>
 <CABXGCsPu73D+JS9dpvzX78RktK2VOv_xT8vvuVaQ=B6zs2dMNQ@mail.gmail.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: =?UTF-8?Q?Re=3a_This_is_the_fourth_time_I=e2=80=99ve_tried_to_find_?=
 =?UTF-8?Q?what_led_to_the_regression_of_outgoing_network_speed_and_each_tim?=
 =?UTF-8?Q?e_I_find_the_merge_commit_8c94ccc7cd691472461448f98e2372c75849406?=
 =?UTF-8?Q?c?=
In-Reply-To: <CABXGCsPu73D+JS9dpvzX78RktK2VOv_xT8vvuVaQ=B6zs2dMNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5.2.2024 23.08, Mikhail Gavrilov wrote:
> On Mon, Feb 5, 2024 at 1:47 AM Christian A. Ehrhardt <lk@c--e.de> wrote:
> 
> Thanks for real help.
> Now I spotted a really bad commit.
> 
> 57e153dfd0e7a080373fe5853c5609443d97fa5a is the first bad commit
> commit 57e153dfd0e7a080373fe5853c5609443d97fa5a
> Author: Niklas Neronin <niklas.neronin@linux.intel.com>
> Date:   Fri Dec 1 17:06:40 2023 +0200
> 
>      xhci: add handler for only one interrupt line
> 
>      Current xHCI driver only supports one "interrupter", meaning we will
>      only use one MSI/MSI-X interrupt line. Thus, add handler only to the
>      first interrupt line.
> 
>      Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
>      Co-developed-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>      Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>      Link: https://lore.kernel.org/r/20231201150647.1307406-13-mathias.nyman@linux.intel.com
>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
>   drivers/usb/host/xhci-pci.c | 35 ++++++++++-------------------------
>   1 file changed, 10 insertions(+), 25 deletions(-)
> 
> Niklas, Mathias I spotted decreased network speed on sending when
> transferring files via sftp between my workstations in the local
> network.
> And bisection of issue leads me to this commit.
> My motherboard is MPG-B650I-EDGE-WIFI looks like it is related to the
> mentioned commit.
> https://www.msi.com/Motherboard/MPG-B650I-EDGE-WIFI
> 

This seems odd, not sure how this usb host change would impact your network speed.

Could you try reverting that patch from 6.8-rc1 and see if it helps?

There are some other patches on top of it that needs to be reverted first.
These should be enough:

36b24ebf9a04 xhci: minor coding style cleanup in 'xhci_try_enable_msi()
9831960df237 xhci: rework 'xhci_try_enable_msi()' MSI and MSI-X setup code
dfbf4441f2d3 xhci: change 'msix_count' to encompass MSI or MSI-X vectors
a795f708b284 xhci: refactor static MSI function
74554e9c2276 xhci: refactor static MSI-X function
f977f4c9301c xhci: add handler for only one interrupt line

That patch changes how we request MSI/MSI-X interrupt(s) for xhci.

Is there any change is /proc/interrupts between a good and bad case?
Such as xhci_hcd using MSI-X instead of MSI, or eth0 and xhci_hcd
interrupting on the same CPU?

Thanks
Mathias

