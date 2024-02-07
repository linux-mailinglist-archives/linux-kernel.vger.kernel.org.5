Return-Path: <linux-kernel+bounces-56329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E08084C8C7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77741F24D5F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4797014AA3;
	Wed,  7 Feb 2024 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i0dbnjRo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB751429A;
	Wed,  7 Feb 2024 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302367; cv=none; b=ntl9CbECRmxONQqZd2mjRT7y6dkSg7SsEJzlEzSbDKlxVKI/pLIBeH6SALVmgn02RykJrZGLbEpqmhPwaA6VQwRdd8t8ATOlqXPdA/Tw+fSSgr7/1mwksRxa1i7fr2rfdNcbaYL4hdBLhPbIHa3s5e58KG2G8YiphOagdSGVGQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302367; c=relaxed/simple;
	bh=6Lh2sf+u9C2LnxdPcmlX2E9wL8aJD0elq4IyaQrMH+A=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=e+cDB05WZP4J/vyXgcmPFLStCMgcViXeNO29JgQqfHeO2JyWIWrudTMGeQv7xDlY2wFblpsEZviUjeWtn/PZcuDe0TrBUpSokV9/2sHdex90uGRyuXnQbKCXJW/1jX7FCbgThgqQ/5xxlZArSFh25nYuxLIWCztJ86CA/iTXdM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i0dbnjRo; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707302366; x=1738838366;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=6Lh2sf+u9C2LnxdPcmlX2E9wL8aJD0elq4IyaQrMH+A=;
  b=i0dbnjRo8uo8bamfuIM/wnCM0Mcry8wE8qqISpPmjULFPFKn93wvGAg8
   nhvKeMQTZsuNS6fbBWW2/bLjGk1G2MNkNT++z8l1D2XhJk01IqLaVQNHN
   lwr0iKY1WWW3JMw/2EdpXFrCV0T0fZfS74pYQ9oCUsBfNfWXUxoqcKenW
   bJOb2/ZuZbG5n8bpvglr2U4hYHa2v88Fk5eg0Gk+mSN5sSTFs9w3OKpVf
   pupi7Wx2g6rm6xpUpR2g/eNDaHk5EoqOTxAniMtzyyHJ9m7OybfARk8Vy
   yjD0FnI6PMxBLHZ322jmezxk/MYnZ8HDExosDuKMmGTYtS3dG8Buzz/3F
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="870385"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="870385"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 02:39:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="933738390"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="933738390"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2024 02:39:22 -0800
Message-ID: <2d87509a-1515-520c-4b9e-bba4cd4fa2c6@linux.intel.com>
Date: Wed, 7 Feb 2024 12:40:57 +0200
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
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: =?UTF-8?Q?Re=3a_This_is_the_fourth_time_I=e2=80=99ve_tried_to_find_?=
 =?UTF-8?Q?what_led_to_the_regression_of_outgoing_network_speed_and_each_tim?=
 =?UTF-8?Q?e_I_find_the_merge_commit_8c94ccc7cd691472461448f98e2372c75849406?=
 =?UTF-8?Q?c?=
In-Reply-To: <CABXGCsPjW_Gr4fGBzYSkr_4tsn0fvuT72G-YJYXcb1a4kX=CQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6.2.2024 18.12, Mikhail Gavrilov wrote:
> On Tue, Feb 6, 2024 at 4:24 PM Mathias Nyman
> <mathias.nyman@linux.intel.com> wrote:
> 
> I confirm after reverting all listed commits and 57e153dfd0e7
> performance of the network returned to theoretical maximum.
> 
>> That patch changes how we request MSI/MSI-X interrupt(s) for xhci.
>>
>> Is there any change is /proc/interrupts between a good and bad case?
>> Such as xhci_hcd using MSI-X instead of MSI, or eth0 and xhci_hcd
>> interrupting on the same CPU?
> 
> On the good kernel I have - 32 xhci_hcd, and bad only - 4.
> In both scenarios using PCI-MSIX.
> I attached both interrupt output as archives to this message.
> 


Thanks,

Looks like your network adapter ends up interrupting CPU0 in the bad case due
to the change in how many interrupts are requested by xhci_hcd before it.

bad case:
	CPU0	CPU1	...	CPU31
87:	18213809 0	... 	0	IR-PCI-MSIX-0000:0e:00.0    0-edge      enp14s0

Does manually changing it to some other CPU help? picking one that doesn't already
handle a lot of interrupts. CPU0 could also in general be more busy, possibly spending
more time with interrupts disabled.

For example change to CPU23 in the bad case:

echo 800000 > /proc/irq/87/smp_affinity

Check from proc/interrupts that enp14s0 interrupts actually go to CPU23 after this.

Thanks
Mathias


