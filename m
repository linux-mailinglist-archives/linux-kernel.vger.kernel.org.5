Return-Path: <linux-kernel+bounces-139949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AA78A0980
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851481F22CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919DA13E03A;
	Thu, 11 Apr 2024 07:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M8zYD1zi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FB313DDDE;
	Thu, 11 Apr 2024 07:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819800; cv=none; b=t6ZzPjTcwdDGs1CXP+aiQRkHtCZQEG5ii54IHd6cTLc0ycAUtMwlov8Bx8Rwtd2vHP4KMHjeMr1/Gds989fSDq0RWefMxsdzPkasFIdzwKEoxFqwVd2sSE/fCTU0dzLq3EKUMS9sOqBoJCfV4m2phA3q1LkKkLj7PbVi6E/qm+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819800; c=relaxed/simple;
	bh=LlCn7vT9/Hjd8JMD5ZvA0fvusIumnfi+7RbeZ2ZFVDU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=hwmBVGX6tNMnxNWjUTyWFaUdkeCte8RNpoV9pTfkOg10mYkWbGVdV+GIEIXARgx4k8UKeFlNbPMNfxMggnsqyR0KXMdiuxgfB+il2qUSRmmWbhcir3DdKMd8rZCxx8v5ubDcVgRQUegMwhoehWMKfVPaAUTLPqqkrC1KxWCfyPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M8zYD1zi; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712819800; x=1744355800;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=LlCn7vT9/Hjd8JMD5ZvA0fvusIumnfi+7RbeZ2ZFVDU=;
  b=M8zYD1zig1ymI1W6usfUsoR/Orshhlvx6AKnZ1m/IpMczebmkczRKAWv
   3kv97f8VvM+ywFiyInY7VFQS7pXaOTWXs8CoxXbJgtpk1qqH4zyoegsCS
   q3qKKLQaXCoYPtWe05pbV+P+L9LLE8bgbn4zo1dF81JrjicYWT1D0tZY5
   pcU7BgyV87qChPZViN5D8y8jMivgPSeYnXoo7r/xSpTGLf+xqpp7Y4pXx
   J5IiL5oxBZ02eOuUQLUxn4ckApq0ZHn750nOFmVJ2+clkIqJP3+z5k03I
   hDTMdnw4x+0rl4+8ZDBeTUFaJ5dYcOKjXMr1WDu/zajPa2AVfsbHjgpga
   Q==;
X-CSE-ConnectionGUID: 5pATU9pjTROzAtT+nrK7dw==
X-CSE-MsgGUID: OyQqim6lQ12RAbf3xnxt/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8775168"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="8775168"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 00:16:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937096435"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="937096435"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 11 Apr 2024 00:16:18 -0700
Message-ID: <049c4850-fdb5-78fb-1d5e-0850dcd062aa@linux.intel.com>
Date: Thu, 11 Apr 2024 10:18:07 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>, =?UTF-8?Q?Micha=c5=82_Pecio?=
 <michal.pecio@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
 Niklas Neronin <niklas.neronin@linux.intel.com>
References: <58bca6f2-797a-4e20-a476-2294309afdd5@molgen.mpg.de>
 <20240405113247.743e34b2@foxbook>
 <7090d3af-18ce-40e1-8ac2-bf18152e5c4a@molgen.mpg.de>
 <20240406183659.3daf4fa0@foxbook>
 <c57f2116-8c42-44fb-9c32-6115ad88f914@molgen.mpg.de>
 <20240407142542.036fb02f@foxbook>
 <1f64af9a-0618-a7da-4acc-f043b6580308@linux.intel.com>
 <20240408210541.771253ff@foxbook>
 <82113c7d-0405-ba11-94d9-5673593cec50@linux.intel.com>
 <fca78115-209f-4090-b83b-acc684484587@molgen.mpg.de>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr not part
 of current TD ep_index 1 comp_code 1
In-Reply-To: <fca78115-209f-4090-b83b-acc684484587@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.4.2024 10.59, Paul Menzel wrote:
> Dear Mathias, dear Michał,
> 
> 
> Am 09.04.24 um 13:22 schrieb Mathias Nyman:
>> On 8.4.2024 22.05, Michał Pecio wrote:
>>>> It's also possible this TD/TRB was cancelled due to the disconnect.
>>>> Could be that even if driver removes the TD from the list and cleans
>>>> out the TRB from the ring buffer (turns TRB to no-op) hardware may
>>>> have read ahead and cached the TRB, and process it anyway.
>>>
>>> I thought about it, but my debug patch says that the missing TD was
>>> freed by finish_td(), which is called on TDs considered completed by
>>> hardware. A cancelled TD would show giveback_invalidated_tds().
>>>
>>> Anyway, we now have new information from the reporter. My v2 patch
>>> keeps a log of the last five events processed on each transfer ring
>>> and dumps the log on TRB mismatch errors.
>>>
>>> Unfortunately, it looks like the host controller is broken and signals
>>> completion of those transfers twice. The log below shows two distinct
>>> events for TRB 32959a1c0 and that the coresponding TD has just been
>>> freed by finish_td().
>>
>> The trace confirms this, we get double completion events for several
>> Isoc TRBs. These double completions are seen after a transaction
>> error on the same device (different endpoint). >
>> Transfer events for TRB ..a1c0 twice, with a transaction error in between:
>>   <idle>-0       [000] d.h2. 33819.709897: xhci_handle_event: EVENT: TRB 000000032959a1c0 status 'Success' len 0 slot 6 ep 2 type 'Transfer Event' flags e:c
>>   <idle>-0       [000] d.h2. 33819.709904: xhci_handle_event: EVENT: TRB 000000041547d010 status 'USB Transaction Error' len 4 slot 6 ep 15 type 'Transfer Event' flags e:c
>>   systemd-journal-395     [000] d.H1. 33819.711886: xhci_handle_event: EVENT: TRB 000000032959a1c0 status 'Success' len 0 slot 6 ep 2 type 'Transfer Event' flags e:c
>>
>> Transfer events for TRB ..a1d0 twice (the next TRB)
>>   systemd-journal-395     [000] d.H1. 33819.712001: xhci_handle_event: EVENT: TRB 000000032959a1d0 status 'Success' len 0 slot 6 ep 2 type 'Transfer Event' flags e:c
>>   systemd-journal-395     [000] d.H1. 33819.712059: xhci_handle_event: EVENT: TRB 000000032959a1d0 status 'Success' len 0 slot 6 ep 2 type 'Transfer Event' flags e:c
>>
>> Transfer events for TRB ..a1e0 twice
>>   systemd-journal-395     [000] d.H1. 33819.712139: xhci_handle_event: EVENT: TRB 000000032959a1e0 status 'Success' len 0 slot 6 ep 2 type 'Transfer Event' flags e:c
>>   systemd-journal-395     [000] d.h1. 33819.712871: xhci_handle_event: EVENT: TRB 000000032959a1e0 status 'Success' len 0 slot 6 ep 2 type 'Transfer Event' flags e:c
>>
>> etc..
>>
>> Driver can cope with these extra events, but if this is common we should
>> probably handle it silently and not concern users with that ERROR message.
> 
> Thank you for the detailed analysis. Excuse my ignorance, but do you have an idea, what this Sennheiser USB headset does differently than other USB devices? Additionally, is this a known problem with this Intel xHCI controller, meaning, is there an errata about this problem?

There are a few related erratas in older 9 series chipsets that possibly
could explain this, but those issues are no longer listed for newer chipsets.

The Sennheiser headset is a full-speed (FS) device that use 192 byte Isoch transfers.

Series 9 chipset xHC has issues with exactly those FS Isoch transfers over 189 bytes, see
" 1. USB Isoch In Transfer Error Issue"

There are some issues related to FS device removal:
" 13. USB Full-/low-speed Device Removal Issue"

And some related to resending transfer events for "chached" TRBs after FS device
disconnect/reconnect.
"25. USB xHCI may Execute a Stale Transfer Request Block (TRB)"

https://www.intel.co.jp/content/dam/www/public/us/en/documents/specification-updates/9-series-chipset-pch-spec-update.pdf

Thanks
Mathias


