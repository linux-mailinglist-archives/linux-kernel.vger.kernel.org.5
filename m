Return-Path: <linux-kernel+bounces-103510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D26187C06D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43152282A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E79971B45;
	Thu, 14 Mar 2024 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBzO52ak"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9AB71B20;
	Thu, 14 Mar 2024 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430632; cv=none; b=M0P6HujxLI0sESybZ6G8Y4TMf2ynbDPrnWNk0T5nwVvGin8kSO/PowsWE0TykiCSBi7bsog0ia9ccWLtENdm4jHaiaPT1foIKWzdn+0rHor/P+AZgRLE2ravlBIYZPqJNMQVF5Xf5L4Ih2YJQjsXjFTCha1cRJwOAkxyAlWXevw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430632; c=relaxed/simple;
	bh=QDmSjFlGrU6Hd3mA2yDfUAmJpqa2FZnvH3/fn2q3Dj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s/9aiXbjEdrtZD8/ahgFUstqVC201i8PxouzsIijiJv6nnewU9ThxriQHxzseAxgEFLZU0tJtAaZgEjD2TG6V/JejIccUmLy6Lv16pdEfDmSgo9cNwKhm5s6q+/m+2P1Ar7E8s574LLfznffBrzGVZGGzaebE5WhwNRezbVid3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBzO52ak; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710430630; x=1741966630;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QDmSjFlGrU6Hd3mA2yDfUAmJpqa2FZnvH3/fn2q3Dj0=;
  b=KBzO52akjhf1QrFZSYhyYm54tiaznhmwHRsG1gqzsH418xAwZare5fH0
   WTgTt3NTljoR43zBE3E+48wMGUEeB0BMO/oqBJdfc2rFMnqUBmRcKsMby
   jolS4a1v3xB6ScXPr4si0KDf/LsrMF9ey45HH48TkWs9y+hhmAUNOMRxk
   0FmMxsVIainpUHvVQnnQgZp2hV11sgvJjAYO4tQiRa0Vq4FZlZ3gAxtq5
   3MuSgY0EjjECDHAxbc1lx9j280N4bM2YheHsK2yHDw5Y4ZQJB9cS4Cpxv
   AKY8Ap0+mjJihUwv7nUUIowOwya1mYJrdO5fGFlKVueTK+iAiwqM+awGr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="15981634"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="15981634"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 08:37:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="49752855"
Received: from laallen-mobl.amr.corp.intel.com (HELO [10.209.21.198]) ([10.209.21.198])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 08:37:09 -0700
Message-ID: <dd54d6de-0bcc-4b2e-a420-b1a429b06246@intel.com>
Date: Thu, 14 Mar 2024 08:37:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/elf: Add a new .note section containing Xfeatures
 information to x86 core files
Content-Language: en-US
To: Vignesh Balasubramanian <vigbalas@amd.com>, linux-kernel@vger.kernel.org,
 linux-toolchains@vger.kernel.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, ebiederm@xmission.com,
 keescook@chromium.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, bpetkov@amd.com, jinisusan.george@amd.com, matz@suse.de,
 binutils@sourceware.org, jhb@FreeBSD.org, felix.willgerodt@intel.com
References: <20240314112359.50713-1-vigbalas@amd.com>
 <20240314112359.50713-2-vigbalas@amd.com>
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
In-Reply-To: <20240314112359.50713-2-vigbalas@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/24 04:23, Vignesh Balasubramanian wrote:
> Add a new .note section containing type, size, offset and flags of
> every xfeature that is present.

Mechanically, I'd much rather have all of that info in the cover letter
in the actual changelog instead.

I'd also love to see a practical example of what an actual example core
dump looks like on two conflicting systems:

   * Total XSAVE size
   * XCR0 value
   * XSTATE_BV from the core dump
   * XFEATURE offsets for each feature

Do you have any information about what other OSes are doing in this
area?  I thought Windows, for instance, was even less flexible about the
XSAVE format than Linux is.

Why didn't LWP cause this problem?

From the cover letter:

> But this patch series depends on heuristics based on the total XSAVE
> register set size and the XCR0 mask to infer the layouts of the
> various register blocks for core dumps, and hence, is not a foolproof
> mechanism to determine the layout of the XSAVE area.

It may not be theoretically foolproof.  But I'm struggling to think of a
case where it would matter in practice.  Is there any CPU from any
vendor where this is actually _needed_?

Sure, it's ugly as hell, but these notes aren't going to be available
universally _ever_, so it's not like the crummy heuristic code gets to
go away.

Have you seen the APX spec?

>
https://www.intel.com/content/www/us/en/developer/articles/technical/advanced-performance-extensions-apx.html

It makes this even more fun because it adds a new XSAVE state component,
but reuses the MPX offsets.

> This information will be used by the debuggers to understand the XSAVE
> layout of the machine where the core file is dumped, and to read XSAVE
> registers, especially during cross-platform debugging.

This is pretty close to just a raw dump of the XSAVE CPUID leaves.
Rather than come up with an XSAVE-specific ABI that depends on CPUID
*ANYWAY* (because it dumps the "flags" register aka. ECX), maybe we
should just bite the bullet and dump out (some of) the raw CPUID space.



