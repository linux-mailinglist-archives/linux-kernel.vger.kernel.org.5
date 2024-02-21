Return-Path: <linux-kernel+bounces-74815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F36485DB9E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A35B26E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB587BAFB;
	Wed, 21 Feb 2024 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d8E2wc0M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F3078B4F;
	Wed, 21 Feb 2024 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708522993; cv=none; b=RDKAEDfMrPPHF2ePEkY6NBBdnV+mcWeCkc7Dcyk1bYbGxiyUViwTZET63gqWamIs9x7NdheT9l9R036+EiTLMJFhgCOSwrdeeQZyeb0ouwj3CcJO2p5FtekCY0mJU+xhZME1OqhPu2oB3PDuYTpzv8GOat1Vhw8d2MtAuUsznAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708522993; c=relaxed/simple;
	bh=iimaZygvldYflluURjK6iRBjSOBNYxNVe8gQ5ptDwEk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=Q0GUNQrStuL1jZb8psv6nQuEeIGvVObaLiyVexG0qjOvkrE51eydmhpgl7/3J0u46SImXTwL8Czq6jtF60nRaHiY3mcjMZT1iGk6H7HZXxoIE2ADAGOyfqDMoJT1dfE4xIxDsALgUW7CfPXHyvoRS5UxaYq6d67cOY+ffI5jeyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d8E2wc0M; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708522992; x=1740058992;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=iimaZygvldYflluURjK6iRBjSOBNYxNVe8gQ5ptDwEk=;
  b=d8E2wc0MX+nZpWLjsRBslQY8qDRaMsDHnWC7kZ4f1XYBGh21NPrRZZH+
   nAXQnQthbbZNOCjm6IjdPCJcQUfYH98KuN+XNSn1yl6fFm9o1UneLdKxl
   Di0qD+yEICJn4yrZM0EgYrgrHnFNQfaKUTGnLIyYZf3subq76cBhJRAfL
   awU8VjNZLAdcX8cdrzN5gOzYyreUno7av6whni7M4tZl4xg+YReSsl56z
   kqrj9WAjO1qPisQRnmeXJfId3nebVC5J/62XoRkgQA2LbHYj7CwsG+xod
   nhFYjJQAoFJDh7r4fw6OBuRGCeB13apae3c35WOAYJbQwLWXuV/Jr1vRn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2822316"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2822316"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 05:43:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="936647876"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="936647876"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2024 05:43:08 -0800
Message-ID: <4f34b6a8-4415-6ea4-8090-262847d606c6@linux.intel.com>
Date: Wed, 21 Feb 2024 15:44:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, niklas.neronin@linux.intel.com,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-x86_64@vger.kernel.org, netdev@vger.kernel.org
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
 <Zb6D/5R8nNrxveAP@cae.in-ulm.de> <Zb/30qOGYAH4j6Mn@cae.in-ulm.de>
 <CABXGCsPu73D+JS9dpvzX78RktK2VOv_xT8vvuVaQ=B6zs2dMNQ@mail.gmail.com>
 <e7b96819-edf7-1f9f-7b01-e2e805c99b33@linux.intel.com>
 <CABXGCsPjW_Gr4fGBzYSkr_4tsn0fvuT72G-YJYXcb1a4kX=CQw@mail.gmail.com>
 <2d87509a-1515-520c-4b9e-bba4cd4fa2c6@linux.intel.com>
 <CABXGCsPdXqRG6v97KDGy+o59xc3ayaq3rLj267veC7YcKVp8ww@mail.gmail.com>
 <1126ed0a-bfc1-a752-1b5e-f1339d7a8aa5@linux.intel.com>
 <CABXGCsN5_O3iKDOyYxtsGTGDA6fw4962CjzXLSnOK3rscELq+Q@mail.gmail.com>
 <a026ecd8-6fba-017d-d673-0d0759a37ed8@linux.intel.com>
 <CABXGCsOgy8H4GGcNU1jRE+SzRqwnPeNuy_3xBukjwB-bPxeZrQ@mail.gmail.com>
 <CABXGCsOd=E428ixUOw+msRpnaubgx5-cVU7TDXwRUCdrM5Oicw@mail.gmail.com>
 <34d7ab1b-ab12-489d-a480-5e6ccc41bfc3@infradead.org>
 <10487018-49b8-4b27-98a1-07cee732290d@infradead.org>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: =?UTF-8?Q?Re=3a_This_is_the_fourth_time_I=e2=80=99ve_tried_to_find_?=
 =?UTF-8?Q?what_led_to_the_regression_of_outgoing_network_speed_and_each_tim?=
 =?UTF-8?Q?e_I_find_the_merge_commit_8c94ccc7cd691472461448f98e2372c75849406?=
 =?UTF-8?Q?c?=
In-Reply-To: <10487018-49b8-4b27-98a1-07cee732290d@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21.2.2024 1.43, Randy Dunlap wrote:
> 
> 
> On 2/20/24 15:41, Randy Dunlap wrote:
>> {+ tglx]
> 
> (this time for real)
> 
>>
>> On 2/20/24 15:19, Mikhail Gavrilov wrote:
>>> On Mon, Feb 19, 2024 at 2:41 PM Mikhail Gavrilov
>>> <mikhail.v.gavrilov@gmail.com> wrote:
>>>>
>>>> I installed irqbalance daemon and nothing changed.
>>>> So who is responsible for irq balancing?
>>>
>>> Sorry for the noise. Can anyone give me an answer?
>>> Who is responsible for distributing interrupts in Linux?
>>> I spotted network performance regression and it turned out, this was
>>> due to the network card getting other interrupt. It is a side effect
>>> of commit 57e153dfd0e7a080373fe5853c5609443d97fa5a.
>>
>> That's a merge commit (AFAIK, maybe not so much). The commit in mainline is:
>>
>> commit f977f4c9301c
>> Author: Niklas Neronin <niklas.neronin@linux.intel.com>
>> Date:   Fri Dec 1 17:06:40 2023 +0200
>>
>>      xhci: add handler for only one interrupt line
>>
>>> Installing irqbalance daemon did not help. Maybe someone experienced
>>> such a problem?
>>>
>>
>> Thomas, would you look at this, please?
>>
>> A network device and xhci (USB) driver are now sharing interrupts.
>> This causes a large performance decrease for the networking device.

Short recap:

xhci (USB) and network device didn't share interrupts, or even interrupt the
same CPU in either good or bad case.

A change in how many interrupts xhci driver requests changed which CPU
the network device interrupts.

In the bad case Mikhail Gavrilovs network device was interrupting CPU0
together with:
- IR-IO-APIC    2-edge      timer
- IR-PCI-MSIX-0000:07:00.0    1-edge      nvme1q1

In the good case network device was interrupting CPU27 together with:
- IR-PCI-MSIX-0000:04:00.0   27-edge      nvme0q27
- IR-PCI-MSIX-0000:07:00.0   28-edge      nvme1q28

Manually moving network device irq 87 from CPU0 to CPU23 helped.
(echo 800000 > /proc/irq/87/smp_affinity)

Thanks
-Mathias


