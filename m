Return-Path: <linux-kernel+bounces-57741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7275384DCE2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979C51C261E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC96C6EB67;
	Thu,  8 Feb 2024 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JcJ27kWS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958DA6BB5B;
	Thu,  8 Feb 2024 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384229; cv=none; b=mhlNT4ghs3kNABX28kxtMkbtj7GSZnChR2e30zy/tnEkYcH/W3UBJV+Pyn5ZTTfT5rZoP2Ioh3GZDQYOKkgcdwJZdjr/g55phZAz9fciuXMVqOs4jWL5ByTcJxMwp06lopJFE4FKxRWrAtGzzsUSEjg+rWsOlwW2BN1mfZEPHLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384229; c=relaxed/simple;
	bh=FjB8knGU2+4T4/a7gzKnYsp/3ZyeYcYxARRsy/pFxzw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=bIzwq0HilX6/WveE4rrblgpaduc713K/RXVLWYrjosDk6ViP0gtwFk1AH0qBk8DhacpdaSUH1ArSrqMUobMLgzvqnPSxuP7/+fJSxLchd5fMNRsX+hkScHnENRDO6+8Hx4KoGnlSMdVt7E8ijoF6Aeh57xExD8dPDq92ijIka+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JcJ27kWS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707384227; x=1738920227;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=FjB8knGU2+4T4/a7gzKnYsp/3ZyeYcYxARRsy/pFxzw=;
  b=JcJ27kWSyqTBc1uqCbFrt1u8uU1CY0ybq3SLjwZYwXihSlvdUutHVKr2
   MpfgBsKk9F3gts4JGJKh30JrtDUibi+r1aMM1ohvc1jazn0E2Ojpk8FMe
   GxmXe/9BpgwP4AIEMGO76+dC9twcSZgK7/oYUxDS2t7sLcNJ4yZ7N9EFz
   wfot4O8/k+DU0PTXA+Im8y/UwJWg2JszNdv4Sr+o15lkbCe61KPNcUT8s
   pYkIfDHu0TS2XPwOMuBFS/xWFwM5HSWv1cs6rcsvEfp6w3OYPc71oBnXl
   w25whTerGgbB4GosYh6zt87/3V/XxL0IO399OROKGTPVfDWkNgqocZyYX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1079490"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1079490"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 01:23:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="934074730"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="934074730"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 08 Feb 2024 01:23:44 -0800
Message-ID: <1126ed0a-bfc1-a752-1b5e-f1339d7a8aa5@linux.intel.com>
Date: Thu, 8 Feb 2024 11:25:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, niklas.neronin@linux.intel.com,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
 <Zb6D/5R8nNrxveAP@cae.in-ulm.de> <Zb/30qOGYAH4j6Mn@cae.in-ulm.de>
 <CABXGCsPu73D+JS9dpvzX78RktK2VOv_xT8vvuVaQ=B6zs2dMNQ@mail.gmail.com>
 <e7b96819-edf7-1f9f-7b01-e2e805c99b33@linux.intel.com>
 <CABXGCsPjW_Gr4fGBzYSkr_4tsn0fvuT72G-YJYXcb1a4kX=CQw@mail.gmail.com>
 <2d87509a-1515-520c-4b9e-bba4cd4fa2c6@linux.intel.com>
 <CABXGCsPdXqRG6v97KDGy+o59xc3ayaq3rLj267veC7YcKVp8ww@mail.gmail.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: =?UTF-8?Q?Re=3a_This_is_the_fourth_time_I=e2=80=99ve_tried_to_find_?=
 =?UTF-8?Q?what_led_to_the_regression_of_outgoing_network_speed_and_each_tim?=
 =?UTF-8?Q?e_I_find_the_merge_commit_8c94ccc7cd691472461448f98e2372c75849406?=
 =?UTF-8?Q?c?=
In-Reply-To: <CABXGCsPdXqRG6v97KDGy+o59xc3ayaq3rLj267veC7YcKVp8ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7.2.2024 13.55, Mikhail Gavrilov wrote:
> On Wed, Feb 7, 2024 at 3:39 PM Mathias Nyman
> <mathias.nyman@linux.intel.com> wrote:
>>
>> Thanks,
>>
>> Looks like your network adapter ends up interrupting CPU0 in the bad case due
>> to the change in how many interrupts are requested by xhci_hcd before it.
>>
>> bad case:
>>          CPU0    CPU1    ...     CPU31
>> 87:     18213809 0      ...     0       IR-PCI-MSIX-0000:0e:00.0    0-edge      enp14s0
>>
>> Does manually changing it to some other CPU help? picking one that doesn't already
>> handle a lot of interrupts. CPU0 could also in general be more busy, possibly spending
>> more time with interrupts disabled.
>>
>> For example change to CPU23 in the bad case:
>>
>> echo 800000 > /proc/irq/87/smp_affinity
>>
>> Check from proc/interrupts that enp14s0 interrupts actually go to CPU23 after this.
>>
>> Thanks
>> Mathias
>>
> 
> root@secondary-ws ~# iperf3 -c primary-ws.local -t 5 -p 5000 -P 1
> Connecting to host primary-ws.local, port 5000
> [  5] local 192.168.1.130 port 49152 connected to 192.168.1.96 port 5000
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec  70.9 MBytes   594 Mbits/sec    0    376 KBytes
> [  5]   1.00-2.00   sec  72.4 MBytes   607 Mbits/sec    0    431 KBytes
> [  5]   2.00-3.00   sec  73.1 MBytes   613 Mbits/sec    0    479 KBytes
> [  5]   3.00-4.00   sec  72.4 MBytes   607 Mbits/sec    0    501 KBytes
> [  5]   4.00-5.00   sec  73.2 MBytes   614 Mbits/sec    0    501 KBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-5.00   sec   362 MBytes   607 Mbits/sec    0             sender
> [  5]   0.00-5.00   sec   360 MBytes   603 Mbits/sec                  receiver
> 
> iperf Done.
> root@secondary-ws ~# echo 800000 > /proc/irq/87/smp_affinity
> root@secondary-ws ~# iperf3 -c primary-ws.local -t 5 -p 5000 -P 1
> Connecting to host primary-ws.local, port 5000
> [  5] local 192.168.1.130 port 37620 connected to 192.168.1.96 port 5000
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec   111 MBytes   934 Mbits/sec    0    621 KBytes
> [  5]   1.00-2.00   sec   109 MBytes   913 Mbits/sec    0    621 KBytes
> [  5]   2.00-3.00   sec   110 MBytes   920 Mbits/sec    0    621 KBytes
> [  5]   3.00-4.00   sec   110 MBytes   924 Mbits/sec    0    621 KBytes
> [  5]   4.00-5.00   sec   109 MBytes   917 Mbits/sec    0    621 KBytes
> - - - - - - - - - - - - - - - - - - - - - - - - -
> [ ID] Interval           Transfer     Bitrate         Retr
> [  5]   0.00-5.00   sec   549 MBytes   921 Mbits/sec    0             sender
> [  5]   0.00-5.00   sec   547 MBytes   916 Mbits/sec                  receiver
> 
> iperf Done.
> 
> Very interesting, is CPU0 slower than CPU23 by 30%?
> 

My guess is that CPU0 spends more time with interrupts disabled than other CPUs.
Either because it's handling interrupts from some other hardware, or running
code that disables interrupts (for example kernel code inside spin_lock_irq),
and thus not able to handle network adapter interrupts at the same rate as CPU23

Thanks
Mathias


