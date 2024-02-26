Return-Path: <linux-kernel+bounces-81224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95909867316
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F1FB371BA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F011D531;
	Mon, 26 Feb 2024 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EcqgKii1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5C61CD2F;
	Mon, 26 Feb 2024 10:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944748; cv=none; b=OTdzz6Ak1HiExwT4XQmV/OePmDr8vhLIv1rre0YiIQWPRBR2RpWdFFVbJ5N1QhXV4tUrLk7QlUTYTz7bXrnJMfvxxQebiywI8P03uMsAqwFJWDFdFeYxsuB06D5siwVIRWCfDFcnU66yZUrgMSMh0cbYMsBUhm+ResdOJGwR/VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944748; c=relaxed/simple;
	bh=ekKIocdQoec7SV7sHdadhD/DGm3snDu/b5yKeGLLLck=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=cv5na6GE1zBdUgD9mRfIt1HqoFEA1ByIA5HisBD9w7WRlh56Wubp7+l0z+6jt5gr6kyrGXfJx69DZmc+nZ8VjfLwd4VbBRR4TPxh3Sud5zyMBppniDXC4cjkGH4ybePMJxtbHuDspaRWX/WhZnj2uGoxYdEdeLLAsHbAKa5gQWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EcqgKii1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708944747; x=1740480747;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=ekKIocdQoec7SV7sHdadhD/DGm3snDu/b5yKeGLLLck=;
  b=EcqgKii1PoRnIiruPzyDmQij4HHJGAPE6YW5Os+E9hH2rw2IbeeodIXl
   stiX+LNmu694CCTCH7oE9Kxu3xFsHwn4LxQA919z3KZ2fKjCU9LBwnxal
   eUrYTBRJSzE2TC8qeXQnbVy3jMbGzOrbAMupRMf2sUdvoY/mvkquR7wC8
   Dk4an5HwItUWxpqeWk/zC/a+39TfT2yh2FJXaFw3nzN49iAsuLzyBLWS3
   cPds3USnf/0CLwGNqUUYBRfFbokU5cQUyo7BkL9zORQYO6V8jygjAI4Vd
   KeyKrl8K+hxBoXGJwsJfGXLKweQ2t/ry8Y/AmMmoNK1DZLaLAw4eFD3V0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="3367919"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3367919"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 02:52:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="937029783"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="937029783"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2024 02:52:23 -0800
Message-ID: <acc2b877-4b42-fd4d-867b-603dae95d09d@linux.intel.com>
Date: Mon, 26 Feb 2024 12:54:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Content-Language: en-US
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, niklas.neronin@linux.intel.com,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-x86_64@vger.kernel.org, netdev@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
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
 <4f34b6a8-4415-6ea4-8090-262847d606c6@linux.intel.com>
 <3ea25443-1275-4c67-90e0-b637212d32b5@leemhuis.info>
 <1e719367-01ae-565a-2199-0ff7e260422b@linux.intel.com>
 <410817b8-1cf9-4285-b20b-f1fa0513cee8@leemhuis.info>
From: Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: This is the fourth time I've tried to find what led to the
 regression of outgoing network speed and each time I find the merge commit
 8c94ccc7cd691472461448f98e2372c75849406c
In-Reply-To: <410817b8-1cf9-4285-b20b-f1fa0513cee8@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.2.2024 11.51, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 26.02.24 10:24, Mathias Nyman wrote:
>> On 26.2.2024 7.45, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> On 21.02.24 14:44, Mathias Nyman wrote:
>>>> On 21.2.2024 1.43, Randy Dunlap wrote:
>>>>> On 2/20/24 15:41, Randy Dunlap wrote:
>>>>>> {+ tglx]
>>>>>> On 2/20/24 15:19, Mikhail Gavrilov wrote:
>>>>>>> On Mon, Feb 19, 2024 at 2:41 PM Mikhail Gavrilov
>>>>>>> <mikhail.v.gavrilov@gmail.com> wrote:
>>>>>>> I spotted network performance regression and it turned out, this was
>>>>>>> due to the network card getting other interrupt. It is a side effect
>>>>>>> of commit 57e153dfd0e7a080373fe5853c5609443d97fa5a.
>>>>>> That's a merge commit (AFAIK, maybe not so much). The commit in
>>>>>> mainline is:
>>>>>>
>>>>>> commit f977f4c9301c
>>>>>> Author: Niklas Neronin <niklas.neronin@linux.intel.com>
>>>>>> Date:   Fri Dec 1 17:06:40 2023 +0200
>>>>>>
>>>>>>        xhci: add handler for only one interrupt line
>>>>>>
>>>>>>> Installing irqbalance daemon did not help. Maybe someone experienced
>>>>>>> such a problem?
>>>>>>
>>>>>> Thomas, would you look at this, please?
>>>>>>
>>>>>> A network device and xhci (USB) driver are now sharing interrupts.
>>>>>> This causes a large performance decrease for the networking device.
>>>>
>>>> Short recap:
>>>
>>> Thx for that. As the 6.8 release is merely two or three weeks away while
>>> a fix is nowhere near in sight yet (afaics!) I start to wonder if we
>>> should consider a revert here and try reapplying the culprit in a later
>>> cycle when this problem is fixed.
> 
> Thx for the reply.
> 
>> I don't think reverting this series is a solution.
>>
>> This isn't really about those usb xhci patches.
>> This is about which interrupt gets assigned to which CPU.
> 
> I know, but from my understanding of Linus expectations wrt to handling
> regressions it does not matter much if a bug existed earlier or
> somewhere else: what counts is the commit that exposed the problem.
> 
> But I might be wrong here. Anyway, not CCing Linus for this; but I'll
> likely point him to this direction on Sunday in my next weekly report,
> unless some fix comes into sight.
> 
>> Mikhail got unlucky when the network adapter interrupts on that system was
>> assigned to CPU0, clearly a more "clogged" CPU, thus causing a drop in max
>> bandwidth.
> 
> But maybe others will be just as "unlucky". Or is there anything to
> believe otherwise? Maybe some aspect of the .config or local setup that
> is most likely unique to Mikhail's setup?

I believe this is a zero-sum case.

Others got equally lucky due to this change.
Their devices end up interrupting less clogged CPUs and see a similar
performance increase.
  
Thanks
Mathias


