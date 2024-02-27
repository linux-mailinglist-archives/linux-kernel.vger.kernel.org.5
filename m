Return-Path: <linux-kernel+bounces-82604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFE98686F2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293A21C287BC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262A712B75;
	Tue, 27 Feb 2024 02:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TcDdyb+C"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7E810A34
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709000643; cv=none; b=Ixx+J6mA3nqw4Z6BjXX15QMMhEpNUnRbo24YYCWBidGjOdWDntfdJc7qZEw2hGfxXec+YTxC513916dILzTVaQ7RDng2kZ4cvBPYGGyRA+gj5lyETKMpsw+0l2NwjsGSnc6nEReemr3AFDr1SMumOXM9WsyGViuuLDxeLuUQ4q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709000643; c=relaxed/simple;
	bh=59jraz7IPbx7CVkNLinizRJ4IOD7c4ts6XvoEuy84f4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aihdeZH/89tpjMDjTBSbspaYdd27U49k4jtNwbXrWOf0iwCd9JdHdHfcJNEZg172AtSdAOlAlkJmkziK7ojCFqD0LM+ajRy3hG5yFkSbHI01+dSDs4fIjMQGqR/C5uvovWKwBheyLQlf5BELrT5oc39krGkzNe98Wuh6c9oB92g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TcDdyb+C; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709000641; x=1740536641;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=59jraz7IPbx7CVkNLinizRJ4IOD7c4ts6XvoEuy84f4=;
  b=TcDdyb+CJjAvLKF6TqgbXRZdyRy3N9F1i8nHs4fn8bzcfuOB0G4gDRQj
   GiHk71Qkplg8cvIl36Sh6lu1ghWFyyILLjCskEuMe709yHa5xR/mdsEE7
   aPa/BahjlEW1j81+FDpNpGEfCZyu9hQN6MM4M6ZHl1RDLKG5u/Cs5mbC7
   yDZ+hg+fB2qx/e47T3yB6+ibw4xgFLk3pjL8nptIla+dsIJa+elqIdjHg
   ju4+BZK0JUYQEgWh683YlIk/k7wjlWgUpndPW0i9SMktnP9h7B8699NkF
   duC2n/wJU6vnZH44wnNQhRyMmRkN53ezhNP2t7n+PoL6l6Dvx+nu0+lzB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="28764016"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="28764016"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 18:24:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="44371632"
Received: from tvereenx-mobl.amr.corp.intel.com (HELO [10.251.5.170]) ([10.251.5.170])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 18:24:00 -0800
Message-ID: <d95be5da-151c-4f16-ae75-ac2fe27e1259@linux.intel.com>
Date: Mon, 26 Feb 2024 18:24:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] virt: tdx-guest: Handle GetQuote request error code
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20240225224244.2072245-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <65dd3c87680e7_1138c729433@dwillia2-xfh.jf.intel.com.notmuch>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <65dd3c87680e7_1138c729433@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/26/24 5:36 PM, Dan Williams wrote:
> Kuppuswamy Sathyanarayanan wrote:
>> The tdx-guest driver marshals quote requests via hypercall to have a
>> quoting enclave sign attestation evidence about the current state of
>> the TD. There are 2 possible failures, a transport failure (failure
>> to communicate with the quoting agent) and payload failure (a failed
>> quote). The driver only checks the former, update it to consider the
>> latter payload errors as well.
>>
>> Fixes: f4738f56d1dc ("virt: tdx-guest: Add Quote generation support using TSM_REPORTS")
>> Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Closes: https://lore.kernel.org/linux-coco/6bdf569c-684a-4459-af7c-4430691804eb@linux.intel.com/T/#u
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Acked-by: Kai Huang <kai.huang@intel.com>
> Looks good to me:
>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>
> ...if you decide you need a debug print here, or to differentiate the
> error codes based on transport vs payload error that can be a follow-on
> change.
Yes, will do. I will submit a pr_err() cleanup patch soon.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


