Return-Path: <linux-kernel+bounces-111873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F34448871F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686651F2450E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DFA5FDC2;
	Fri, 22 Mar 2024 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RzRQFc8/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867EC5FBA5;
	Fri, 22 Mar 2024 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711129241; cv=none; b=gL0aSS33jizyW/OMMWhNqJ7r0GBNjFdOPA9C5cIbZr0WKZtMOGe0WpmY/RTGVsm2jmITnCEYSedPM5NIblrOkrjLOp69rXho6RCP9TGgcxhYAjxu73ltBBbifUGJBgge/8cmCcy0xxLCF31pg4yrVAQ78tp5uvmflxr20e/mBWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711129241; c=relaxed/simple;
	bh=wFZI1PIUaOqlEpxFZyEcVJq0yyXGgKI3wtKeSznMuas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOZ5yOTRwaPJizeVPwgaQGorbCSTnG1li2EDpNEIiZ+as3rqSkEPcT5ecLpp3fzNWedOBuP7CSZCty/Cu3oex/UAO8/FYAQk7YgILn9F4nIXLreCv1kjd89CHjjN9mJe8g/3MZBNL5hIGqhp7mr/lwTH8fzogvM5HMU+0rIx+3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RzRQFc8/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711129239; x=1742665239;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wFZI1PIUaOqlEpxFZyEcVJq0yyXGgKI3wtKeSznMuas=;
  b=RzRQFc8/8bMkKO6l8J/TCuIHBB3/+TdmK8zzroUqNsZXBv+g8jK0rqLd
   s8l2cqGNiVzn2ZM060TeK7QXOe3CyLHoJkQKwHkLWSlPahfiqtyeS5M04
   X7i1Lm++g/bV7INToXcSufXscqJXTi1ocZY4hV4ZTfQgom0rDpJVMDwui
   Uac2K5waFk0DxtRx1tVFd5KqLmpVD7VTtrcVavOEyYHanI98D++6M0gNk
   JDF++JYKoWpVkj5KXwBzWY2QV7yz/a2M9trRgREI3CGe1u8zVTr9Q7chP
   WcbsJjyN4zXZCwsZ85etuRXfFI2EepYIx9P2i9CLvZFzXUmsMZtthZXq1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="28666081"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="28666081"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 10:40:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="19710803"
Received: from ashwanim-mobl.amr.corp.intel.com (HELO [10.209.56.241]) ([10.209.56.241])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 10:40:38 -0700
Message-ID: <2f8d726a-9800-4068-9c0c-6c4a79d69a85@intel.com>
Date: Fri, 22 Mar 2024 10:40:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm/ident_map: Use full gbpages in identity maps
 except on UV platform.
Content-Language: en-US
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Pavin Joseph <me@pavinjoseph.com>, stable@vger.kernel.org,
 Eric Hagberg <ehagberg@gmail.com>, Simon Horman <horms@verge.net.au>,
 Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
 Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
References: <20240322162135.3984233-1-steve.wahl@hpe.com>
 <003f1e83-fd93-4f4f-a316-d3e89e5a23a5@intel.com>
 <87le6ab2bn.fsf@email.froward.int.ebiederm.org>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzUVEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gKEludGVsIFdvcmsgQWRkcmVzcykgPGRhdmUuaGFuc2VuQGludGVs
 LmNvbT7CwXgEEwECACIFAlQ+9J0CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEGg1
 lTBwyZKwLZUP/0dnbhDc229u2u6WtK1s1cSd9WsflGXGagkR6liJ4um3XCfYWDHvIdkHYC1t
 MNcVHFBwmQkawxsYvgO8kXT3SaFZe4ISfB4K4CL2qp4JO+nJdlFUbZI7cz/Td9z8nHjMcWYF
 IQuTsWOLs/LBMTs+ANumibtw6UkiGVD3dfHJAOPNApjVr+M0P/lVmTeP8w0uVcd2syiaU5jB
 aht9CYATn+ytFGWZnBEEQFnqcibIaOrmoBLu2b3fKJEd8Jp7NHDSIdrvrMjYynmc6sZKUqH2
 I1qOevaa8jUg7wlLJAWGfIqnu85kkqrVOkbNbk4TPub7VOqA6qG5GCNEIv6ZY7HLYd/vAkVY
 E8Plzq/NwLAuOWxvGrOl7OPuwVeR4hBDfcrNb990MFPpjGgACzAZyjdmYoMu8j3/MAEW4P0z
 F5+EYJAOZ+z212y1pchNNauehORXgjrNKsZwxwKpPY9qb84E3O9KYpwfATsqOoQ6tTgr+1BR
 CCwP712H+E9U5HJ0iibN/CDZFVPL1bRerHziuwuQuvE0qWg0+0SChFe9oq0KAwEkVs6ZDMB2
 P16MieEEQ6StQRlvy2YBv80L1TMl3T90Bo1UUn6ARXEpcbFE0/aORH/jEXcRteb+vuik5UGY
 5TsyLYdPur3TXm7XDBdmmyQVJjnJKYK9AQxj95KlXLVO38lczsFNBFRjzmoBEACyAxbvUEhd
 GDGNg0JhDdezyTdN8C9BFsdxyTLnSH31NRiyp1QtuxvcqGZjb2trDVuCbIzRrgMZLVgo3upr
 MIOx1CXEgmn23Zhh0EpdVHM8IKx9Z7V0r+rrpRWFE8/wQZngKYVi49PGoZj50ZEifEJ5qn/H
 Nsp2+Y+bTUjDdgWMATg9DiFMyv8fvoqgNsNyrrZTnSgoLzdxr89FGHZCoSoAK8gfgFHuO54B
 lI8QOfPDG9WDPJ66HCodjTlBEr/Cwq6GruxS5i2Y33YVqxvFvDa1tUtl+iJ2SWKS9kCai2DR
 3BwVONJEYSDQaven/EHMlY1q8Vln3lGPsS11vSUK3QcNJjmrgYxH5KsVsf6PNRj9mp8Z1kIG
 qjRx08+nnyStWC0gZH6NrYyS9rpqH3j+hA2WcI7De51L4Rv9pFwzp161mvtc6eC/GxaiUGuH
 BNAVP0PY0fqvIC68p3rLIAW3f97uv4ce2RSQ7LbsPsimOeCo/5vgS6YQsj83E+AipPr09Caj
 0hloj+hFoqiticNpmsxdWKoOsV0PftcQvBCCYuhKbZV9s5hjt9qn8CE86A5g5KqDf83Fxqm/
 vXKgHNFHE5zgXGZnrmaf6resQzbvJHO0Fb0CcIohzrpPaL3YepcLDoCCgElGMGQjdCcSQ+Ci
 FCRl0Bvyj1YZUql+ZkptgGjikQARAQABwsFfBBgBAgAJBQJUY85qAhsMAAoJEGg1lTBwyZKw
 l4IQAIKHs/9po4spZDFyfDjunimEhVHqlUt7ggR1Hsl/tkvTSze8pI1P6dGp2XW6AnH1iayn
 yRcoyT0ZJ+Zmm4xAH1zqKjWplzqdb/dO28qk0bPso8+1oPO8oDhLm1+tY+cOvufXkBTm+whm
 +AyNTjaCRt6aSMnA/QHVGSJ8grrTJCoACVNhnXg/R0g90g8iV8Q+IBZyDkG0tBThaDdw1B2l
 asInUTeb9EiVfL/Zjdg5VWiF9LL7iS+9hTeVdR09vThQ/DhVbCNxVk+DtyBHsjOKifrVsYep
 WpRGBIAu3bK8eXtyvrw1igWTNs2wazJ71+0z2jMzbclKAyRHKU9JdN6Hkkgr2nPb561yjcB8
 sIq1pFXKyO+nKy6SZYxOvHxCcjk2fkw6UmPU6/j/nQlj2lfOAgNVKuDLothIxzi8pndB8Jju
 KktE5HJqUUMXePkAYIxEQ0mMc8Po7tuXdejgPMwgP7x65xtfEqI0RuzbUioFltsp1jUaRwQZ
 MTsCeQDdjpgHsj+P2ZDeEKCbma4m6Ez/YWs4+zDm1X8uZDkZcfQlD9NldbKDJEXLIjYWo1PH
 hYepSffIWPyvBMBTW2W5FRjJ4vLRrJSUoEfJuPQ3vW9Y73foyo/qFoURHO48AinGPZ7PC7TF
 vUaNOTjKedrqHkaOcqB185ahG2had0xnFsDPlx5y
In-Reply-To: <87le6ab2bn.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/24 10:31, Eric W. Biederman wrote:
>> I'd much rather add synthetic entries to the memory maps that have this
>> information than hack around it by assuming that things are within a
>> gigabyte.
> So this change is a partial revert of a change that broke kexec in
> existing configurations.  To fix a regression that breaks kexec.

Let's back up for a second:

 * Mapping extra memory on UV systems causes halts[1]
 * Mapping extra memory on UV systems breaks kexec (this thread)

So we're in a pickle.  I understand your concern for kexec.  But I'm
concerned that fixing the kexec problem will re-expose us to the [1]
problem.

Steve, can you explain a bit why this patch doesn't re-expose the kernel
to the [1] bug?

1. https://lore.kernel.org/all/20240126164841.170866-1-steve.wahl@hpe.com/



