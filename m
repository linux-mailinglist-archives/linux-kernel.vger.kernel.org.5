Return-Path: <linux-kernel+bounces-99665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 223EB878B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A293B281FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176115A103;
	Mon, 11 Mar 2024 23:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ta9S1zjh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4665059B48
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710200080; cv=none; b=drLTb7fkv5F0bZGVsfwHgWkTo91ogOPuVBX3t9zsrZVsuSs/xWJ5VYFVjZvjzYL1BJlhTPcL+nz4WmN6ye6AYI7ndty61YPWfuqt+XvRVy/elkQmx4AZgKWj/HrIeIN4JbrQSzAOaJs9wwsCeNs8YqyyR3gPrxinnufAIyyxeew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710200080; c=relaxed/simple;
	bh=10qejgMBcinR13l9lIVU4NzpIgEqrpAcOEd3gHCEwfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KNoRiDhmC+1xmw9orbpynpmLr6ufdOcJUPllK8tQzxuc9u2wS4Hpd0smpG+YuetUT7b7HagJokiOFT2E7HrEybWuoEgWPsePWUNWpehKdtuogwCU03FfNz2tmV+bzaMtYY6UOf0yWw0rCNOzr1FBGRWis61VVuF0XZMT88Pp9t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ta9S1zjh; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710200078; x=1741736078;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=10qejgMBcinR13l9lIVU4NzpIgEqrpAcOEd3gHCEwfo=;
  b=Ta9S1zjhVa+t2PY3JUu1MGknxy9Q4/STrlB9QkPy3ciUlHQN7K5J1h3J
   JR7VmVkrfPOFOchIpWjjzRZ20Cx0W5veU0zMNfSSln4ecIlKJrLck0KhU
   YMCL+yzDmDY4dPecDdKrjN0np5czS0S330BUrLvsp9arX8FUIRnoduOij
   hvRrHeQDbwL5p/uifWRt0kf3/1mKEQrgIlYXGFOwPvcFmFr6X9lBEafoS
   8RJZ/Gis5R9B4IZ2mo9LQ8hs+IJdOjZzqjsK3pYF/3d+qROrpHYeM7gwr
   XoXGPOlVGVyVHo3DRO4QhyN6QXjvCh5QA/b++7XOikDcJ8TPYqhJ7i1fI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="8707420"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="8707420"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 16:34:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="11919484"
Received: from siverson-mobl1.amr.corp.intel.com (HELO [10.209.94.13]) ([10.209.94.13])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 16:34:35 -0700
Message-ID: <bedfa55b-b1d0-4e59-8c94-dbc5f8485a7f@intel.com>
Date: Mon, 11 Mar 2024 16:34:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 11/14] x86: add support for Dynamic Kernel Stacks
Content-Language: en-US
To: Andy Lutomirski <luto@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 the arch/x86 maintainers <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Christian Brauner <brauner@kernel.org>, bristot@redhat.com,
 Ben Segall <bsegall@google.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 dianders@chromium.org, dietmar.eggemann@arm.com, eric.devolder@oracle.com,
 hca@linux.ibm.com, "hch@infradead.org" <hch@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, jpoimboe@kernel.org,
 Joerg Roedel <jroedel@suse.de>, juri.lelli@redhat.com,
 Kent Overstreet <kent.overstreet@linux.dev>, kinseyho@google.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, lstoakes@gmail.com,
 mgorman@suse.de, mic@digikod.net, michael.christie@oracle.com,
 Ingo Molnar <mingo@redhat.com>, mjguzik@gmail.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Petr Mladek <pmladek@suse.com>, Rick P Edgecombe
 <rick.p.edgecombe@intel.com>, Steven Rostedt <rostedt@goodmis.org>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>,
 vincent.guittot@linaro.org, vschneid@redhat.com
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-12-pasha.tatashin@soleen.com>
 <3e180c07-53db-4acb-a75c-1a33447d81af@app.fastmail.com>
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
In-Reply-To: <3e180c07-53db-4acb-a75c-1a33447d81af@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/24 15:17, Andy Lutomirski wrote:
> I *think* that all x86 implementations won't fill the TLB for a
> non-accessed page without also setting the accessed bit,

That's my understanding as well.  The SDM is a little more obtuse about it:

> Whenever the processor uses a paging-structure entry as part of
> linear-address translation, it sets the accessed flag in that entry
> (if it is not already set).

but it's there.

But if we start needing Accessed=1 to be accurate, clearing those PTEs
gets more expensive because it needs to be atomic to lock out the page
walker.  It basically needs to start getting treated similarly to what
is done for Dirty=1 on userspace PTEs.  Not the end of the world, of
course, but one more source of overhead.


