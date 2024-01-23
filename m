Return-Path: <linux-kernel+bounces-35743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35EE8395D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F200829492D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF8981AB2;
	Tue, 23 Jan 2024 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuL/nTaK"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DBD81AA8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029251; cv=none; b=ghIEJdyinYyQB0ctabulByBcSrOB8w2b4nSdT2Hv0FqLGZE3l7PFtypuMRGS6kihTrm4gRnvio5X56D/Fpc8s1YqyDon30psbnHio735dp1X5gZ2EvlxrcqmWBFtbv6ZsNVuT5C0N/mJwCcpUl0TgJ19ZWqRPRSLHymxHtNwVEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029251; c=relaxed/simple;
	bh=yFf76mF6MHvjP7qOKecUFTqNvS+JlUcJHnmCWixyXW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIfdX7joIWaURKhVUHc4f+jRIRedA/hNtE3149wBs/jLI0bw0UpHacBdoH2j/n3l/7y/cLM9NaqEOWj5x1K3Rq0fzwwsDEFKn2aFptuWwpvg7e7FG3KYU4bNuMR9TeN5pjEAgXUmKes/6V3jAtGGftUp9v5iX8uFB4mkZkOZSUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuL/nTaK; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706029249; x=1737565249;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yFf76mF6MHvjP7qOKecUFTqNvS+JlUcJHnmCWixyXW8=;
  b=iuL/nTaKa8AzuBW2JUOrcFIem+S8I7Oa7ElnOxTWiXPxp9gsJS94qUV7
   SFsrmLinwkoEGTi6CHNTDwNDMoghYoRD3V3Qx20B4D3cGLY99FQg0GHiX
   pV7U3ax7KnLKA2IpzdLjXkmlyxKodhR+HOS4xgjdwJX8EvEVZxLM7gn/f
   Ea4cG4oevC5+Oi6ilzDBJH4WSLNW2h4mePCfcAeFK2eeSmSmlI36gHm6y
   GhRukrbsxx5mt8PeqGvIMm1iiab8PE70Wl8YMqJyyE0K5wN00jXrc70Q+
   Mbgnk8ioybje90Jr1drDEM68c1RrAPSPNRZKgrOWBv+mXYVwv3jMkGb1C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="401242325"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="401242325"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 09:00:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="1590369"
Received: from gsrivast-mobl.amr.corp.intel.com (HELO [10.212.204.58]) ([10.212.204.58])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 09:00:46 -0800
Message-ID: <784a6843-c5fb-46eb-a472-5d96101478a9@intel.com>
Date: Tue, 23 Jan 2024 09:00:45 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: Simplify redundant overlap calculation
Content-Language: en-US
To: David Binderman <dcb314@hotmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
References: <20240123163623.1342917-1-dave.hansen@linux.intel.com>
 <AS8PR02MB10217E3448DF6D70285CA3D1D9C742@AS8PR02MB10217.eurprd02.prod.outlook.com>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <AS8PR02MB10217E3448DF6D70285CA3D1D9C742@AS8PR02MB10217.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/23/24 08:54, David Binderman wrote:
>> Remove the second condition.  It is exactly the same as the first.
> I don't think the first condition is sufficient. I suspect something like
> 
>        return (r2_start <= r1_start && r1_start <= r2_end) ||
>                (r2_start <= r1_end && r1_end <= r2_end);
> 
> Given the range [r2_start .. r2_end], then if r1_start or r1_end
> are in that range, you have overlap.
> 
> Unless you know different.

First of all, I've gotten these bounds checks wrong in code more times
than I can count.  I have zero trust that I'll get them right. :)

But the compiler seems to know different at least:

int  overlaps1(unsigned long r1_start, unsigned long r1_end,
	      unsigned long r2_start, unsigned long r2_end)
{
	return  (r1_start <= r2_end && r1_end >= r2_start) ||
		(r2_start <= r1_end && r2_end >= r1_start);
}

int  overlaps2(unsigned long r1_start, unsigned long r1_end,
	      unsigned long r2_start, unsigned long r2_end)
{
	return (r1_start <= r2_end && r1_end >= r2_start);
}

Results in:

0000000000001180 <overlaps1>:
    1180:	f3 0f 1e fa          	endbr64
    1184:	48 39 cf             	cmp    %rcx,%rdi
    1187:	49 89 d0             	mov    %rdx,%r8
    118a:	0f 96 c2             	setbe  %dl
    118d:	31 c0                	xor    %eax,%eax
    118f:	4c 39 c6             	cmp    %r8,%rsi
    1192:	0f 93 c0             	setae  %al
    1195:	21 d0                	and    %edx,%eax
    1197:	c3                   	ret
    1198:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    119f:	00

00000000000011a0 <overlaps2>:
    11a0:	f3 0f 1e fa          	endbr64
    11a4:	48 39 cf             	cmp    %rcx,%rdi
    11a7:	49 89 d0             	mov    %rdx,%r8
    11aa:	0f 96 c2             	setbe  %dl
    11ad:	31 c0                	xor    %eax,%eax
    11af:	4c 39 c6             	cmp    %r8,%rsi
    11b2:	0f 93 c0             	setae  %al
    11b5:	21 d0                	and    %edx,%eax
    11b7:	c3                   	ret
    11b8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    11bf:	00

I also wrote a quick program to throw random numbers into both versions
and see if they differ.  They never did, which they obviously can't if
they're the exact same instructions.

