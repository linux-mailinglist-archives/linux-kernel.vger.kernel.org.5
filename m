Return-Path: <linux-kernel+bounces-108020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8A48804DC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F830B230B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C55339879;
	Tue, 19 Mar 2024 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VEP7j94d"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7B13C00;
	Tue, 19 Mar 2024 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873103; cv=none; b=W9yVQmM7mjD6Bhllc/lE6MD8boyNpUX3E9vFD232NBNIuxa0/ihg/BZefAk6530ukFY3fehhjC/uDGumnCgC51ZBFbkrRSIabTOaM+2F8hYuHfYuhEv5JwFgw/b+674iZqBHEBX7cfzNaHw+Xz9QwBYXG85oN12dY6fsdG9aGMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873103; c=relaxed/simple;
	bh=J6C41V/nYcmkeLsc41+n8k3LnBrowCWX062IB4aM7xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pk9Q8QPIxYOJNdpFSU7QcMgv9E0aNgBcSNwxF93LmYJVCnS2+0XCA3e5+3suCeS6/AJD+nHkdnE3n+4CHLboTK9Zi060LltdgeTXHHqp56O9rSH63mg8i7siSZLK+s263CfyCcpPS4/mctA6YFzF2PT8Udj8ST2JsHvbFPtACF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VEP7j94d; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710873101; x=1742409101;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J6C41V/nYcmkeLsc41+n8k3LnBrowCWX062IB4aM7xs=;
  b=VEP7j94dOybjlSumlF59SRD3FALJHIlUe+7r6wNC9Qhqx+FTd7DPPSMW
   wqGFbcZPMP8VeCJ1f0PW5XtK0kWvVBJyxrSPYo9LVZEEtW7eIyQ9AG+Zk
   MWJNtHZSbqX5hA6Bc+JT06jyUE5kpIeCBeC7+MldwUr2rl2D/v9Og/kSd
   RdQeROqf/jpBKPA0kmCp4//2u9m2IFw+cCkM9DkeSv09zXzkeB3TWoWDh
   xXx4kKuUAyXhPaP5Qqlz3rx7uaVUjf2RebMCjOZsU6TA7Z++zI9sw0YYH
   hpv7oO3vVrsOvjtHzvVD8rvfO/IESHM1gvITxtGDFo95Ys5yE5xwZPWkF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="17173272"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="17173272"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 11:31:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="13975894"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.108.125]) ([10.212.108.125])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 11:31:39 -0700
Message-ID: <e589e7d5-c83a-4b33-8504-e3174cc4e534@intel.com>
Date: Tue, 19 Mar 2024 11:31:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cxl/mem: Fix for the index of Clear Event Record
 Handle
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, chenbaozi@phytium.com.cn
References: <20240318022928.509130-1-wangyuquan1236@phytium.com.cn>
 <20240318022928.509130-2-wangyuquan1236@phytium.com.cn>
 <20240318105748.000072c5@Huawei.com>
 <65f8de878e8e1_7702a294f4@dwillia2-xfh.jf.intel.com.notmuch>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <65f8de878e8e1_7702a294f4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/18/24 5:38 PM, Dan Williams wrote:
> Jonathan Cameron wrote:
>> On Mon, 18 Mar 2024 10:29:28 +0800
>> Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
>>
>>> The dev_dbg info for Clear Event Records mailbox command would report
>>> the handle of the next record to clear not the current one.
>>>
>>> This was because the index 'i' had incremented before printing the
>>> current handle value.
>>>
>>> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
>>> ---
>>>  drivers/cxl/core/mbox.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>>> index 9adda4795eb7..b810a6aa3010 100644
>>> --- a/drivers/cxl/core/mbox.c
>>> +++ b/drivers/cxl/core/mbox.c
>>> @@ -915,7 +915,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>>>  
>>>  		payload->handles[i++] = gen->hdr.handle;
>>>  		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
>>> -			le16_to_cpu(payload->handles[i]));
>>> +			le16_to_cpu(payload->handles[i-1]));
>> Trivial but needs spaces around the -. e.g.  [i - 1] 
>>
>> Maybe Dan can fix up whilst applying.
>>
>> Otherwise
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I have enlisted Dave to start wrangling CXL kernel patches upstream, and
> I will fall back to just reviewing.
> 
> Dave, you can add my:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> ...with the same caveat as above.

Applied, updated, and added 
Fixes: 6ebe28f9ec72 ("cxl/mem: Read, trace, and clear events on driver load")

> 

