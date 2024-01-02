Return-Path: <linux-kernel+bounces-14342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE739821BA1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D806282AB0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970D6F9F3;
	Tue,  2 Jan 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MvWAYpJW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347C1F9D2;
	Tue,  2 Jan 2024 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704198648; x=1735734648;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=rtM5doXFq2NWibzp7OwFSY3PvLEqNSMtMBZ+d5jeVxk=;
  b=MvWAYpJWQAdH/qOacLAHCdqaMVKIj7KJaBhg4kL/AmJKEAqSkRDIAnk7
   lAw0umOyzh4ZhIPuVaOZibPIm/OPgYBKSxhhzEODHYcRtaVgMBg0+6WuE
   5cW/ZuAjouaQgUpafQy1LqHUQ3854XdKaBX1bVok3Fy6KKJ47BPZuIhkN
   fzEYZOu6TD0BnrnzU0bE+8G5HvuArtVlsqToTZvDaJVgQiXNODpMPZKbU
   Etop6uBeQH0vZ/gpSvAdwQVifzAMHBOSroZJDnrIWqIj15t4slTL+SiG7
   dTtmIeuAzXA6fZVJOUmtUz5CTxhfq5U1ozQp+7MR2/yBS6rq2N3I7DjTM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="377030763"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="377030763"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 04:30:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="1111033434"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="1111033434"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga005.fm.intel.com with ESMTP; 02 Jan 2024 04:30:45 -0800
Message-ID: <b88a9573-6ab5-ed86-dabc-dd07875f88f3@linux.intel.com>
Date: Tue, 2 Jan 2024 14:32:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Prashanth K <quic_prashk@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Mathias Nyman <mathias.nyman@intel.com>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, stable@vger.kernel.org
References: <20231212112521.3774610-1-quic_prashk@quicinc.com>
 <20231212112521.3774610-2-quic_prashk@quicinc.com>
 <2023121518-uncharted-riddance-7c58@gregkh>
 <849d0ea9-d4f7-c568-968c-88835f64fadf@quicinc.com>
 <2023122212-stellar-handlebar-2f70@gregkh>
 <43ff1971-aeb1-21e1-4700-9ee84cd5aede@quicinc.com>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v2 1/2] usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK
In-Reply-To: <43ff1971-aeb1-21e1-4700-9ee84cd5aede@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.12.2023 7.24, Prashanth K wrote:
> 
> 
> On 22-12-23 11:40 am, Greg Kroah-Hartman wrote:
>> On Fri, Dec 22, 2023 at 11:29:01AM +0530, Prashanth K wrote:
>>> On 15-12-23 06:12 pm, Greg Kroah-Hartman wrote:
>>>> On Tue, Dec 12, 2023 at 04:55:20PM +0530, Prashanth K wrote:
>>>>> Upstream commit bac1ec551434 ("usb: xhci: Set quirk for
>>>>> XHCI_SG_TRB_CACHE_SIZE_QUIRK") introduced a new quirk in XHCI
>>>>> which fixes XHC timeout, which was seen on synopsys XHCs while
>>>>> using SG buffers. But the support for this quirk isn't present
>>>>> in the DWC3 layer.
>>>>>
>>>>> We will encounter this XHCI timeout/hung issue if we run iperf
>>>>> loopback tests using RTL8156 ethernet adaptor on DWC3 targets
>>>>> with scatter-gather enabled. This gets resolved after enabling
>>>>> the XHCI_SG_TRB_CACHE_SIZE_QUIRK. This patch enables it using
>>>>> the xhci device property since its needed for DWC3 controller.
>>>>>
>>>>> In Synopsys DWC3 databook,
>>>>> Table 9-3: xHCI Debug Capability Limitations
>>>>> Chained TRBs greater than TRB cache size: The debug capability
>>>>> driver must not create a multi-TRB TD that describes smaller
>>>>> than a 1K packet that spreads across 8 or more TRBs on either
>>>>> the IN TR or the OUT TR.
>>>>>
>>>>> Cc: <stable@vger.kernel.org>
>>>>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
>>>>
>>>> What commit id does this fix?
>>>>
>>> This doesn't fix any commit as such, but adds the support for
>>> XHCI_SG_TRB_CACHE_SIZE_QUIRK (which is present in XHCI layer) to DWC3 layer.
>>
>> So this is a new feature?
>>
>> How does this fit into the stable kernel rules?
> 
> This isn't a new feature. To give some background, upstream commit bac1ec551434 ("usb: xhci: Set quirk for XHCI_SG_TRB_CACHE_SIZE_QUIRK")
> added a XHCI quirk which converts SG lists to CMA buffers/URBS if certain conditions aren't met. But they never enabled this xhci quirk
> since no issues were hit at that time. So, the support for the above mentioned quirk is added from 5.11 kernel onwards, but was never enabled anywhere.

I remember this now.
  
Original series had three patches, two adding the feature to xhci, and one for dwc3 enabling it.
The xhci patches were fine and got in.

https://marc.info/?l=linux-usb&m=160570849625065&w=2

The last dwc3 patch had issues and never apparently got in

https://marc.info/?l=linux-usb&m=161008968009766&w=2

As this feature hasn't been enabled and code not widely run I think it would be  better
to skip stable for now. Stable can be added later once this has been successfully running
in upstream for a while.

Thanks
Mathias



