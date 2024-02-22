Return-Path: <linux-kernel+bounces-76818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869F085FD0C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A053289ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A31D14E2EC;
	Thu, 22 Feb 2024 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hrYERGc/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD7C14E2C0;
	Thu, 22 Feb 2024 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617064; cv=none; b=h5b2dRzXhIBf3ttsgR49cuiZfwuaWHiSUPxpHNk3JDfU6FM4FUxRgTwbTmV1t222eXKM2vXY4IpTKh705ZH1WEMZ4gJ9Y/3k/mjooL8OJVhD2VJhSsfeLRi0iMkKw+FUQkITHG24ugiJ9CXRyb5bchSWVgpwiKRxLj6VRX6S6qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617064; c=relaxed/simple;
	bh=KjE1vIoN7SoFZLLZpkr8IOhC7YTfwuA/dlp47TzC+bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WS0xMtCwplaMDZFLH6ZQ+wCyhOCE6M5A3ymG37RYbvOdD1ep/ek+N1coyn1Xefon2nFfn5Bi5PmqWnrvo8fWp+010LY/DleXSu0WAM6S7a+h7gW2DHlWFYYBvPE+awsP93BMG3TE426wWvOgTYO6amB2RCeq36PpfbS3rD3DJiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hrYERGc/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708617063; x=1740153063;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KjE1vIoN7SoFZLLZpkr8IOhC7YTfwuA/dlp47TzC+bQ=;
  b=hrYERGc/04QhgEGS+IvgC1yLNsoaWeurEqgQLyXZjvGMzD+XboRygDPa
   KUCHcj4Va1VwcJlHO5u48XZXop8klEnAHvkj7qlrPjTAstkRKiUX2jNaD
   SepU6XDqKhWhUJp0os3WeH7WcJy4qMm3pe8XXmd7bT41/1AQSZsCgctzY
   q/OTQL8XReZfNR0abDWesNXMoyP+hWe1SKHbECocc5+15U+bCTo4enPDO
   HjejMeHRG3JLpKH1cwjaW60ptcR5jIK1vI3lx6MULMaaFrEcpSKbRIMpW
   o6+aTAaOlsUXs4arRQfOK09zxe327EZ9gWuyfoBzRNP9IsN7bbWv66ygf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2721436"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2721436"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:51:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10208817"
Received: from jwbates1-mobl.amr.corp.intel.com (HELO [10.209.48.22]) ([10.209.48.22])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:51:02 -0800
Message-ID: <f6135f2c-bc8f-41c3-9c6a-8346d685e4dc@intel.com>
Date: Thu, 22 Feb 2024 07:51:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/5] sbm: fix up calls to dynamic memory allocators
Content-Language: en-US
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Xin Li <xin3.li@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Kees Cook <keescook@chromium.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Pengfei Xu <pengfei.xu@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ze Gao <zegao2021@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Brian Gerst <brgerst@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <jroedel@suse.de>, "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Tina Zhang <tina.zhang@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org,
 Petr Tesarik <petr.tesarik1@huawei-partners.com>
References: <fb4a40c7-af9a-406a-95ab-406595f3ffe5@intel.com>
 <20240222131230.635-1-petrtesarik@huaweicloud.com>
 <20240222131230.635-5-petrtesarik@huaweicloud.com>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240222131230.635-5-petrtesarik@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/22/24 05:12, Petr Tesarik wrote:
>  static const struct sbm_fixup fixups[] =
>  {
> +	/* kmalloc() and friends */
> +	{ kmalloc_trace, proxy_alloc3 },
> +	{ __kmalloc, proxy_alloc1 },
> +	{ __kmalloc_node, proxy_alloc1 },
> +	{ __kmalloc_node_track_caller, proxy_alloc1 },
> +	{ kmalloc_large, proxy_alloc1 },
> +	{ kmalloc_large_node, proxy_alloc1 },
> +	{ krealloc, proxy_alloc2 },
> +	{ kfree, proxy_free },
> +
> +	/* vmalloc() and friends */
> +	{ vmalloc, proxy_alloc1 },
> +	{ __vmalloc, proxy_alloc1 },
> +	{ __vmalloc_node, proxy_alloc1 },
> +	{ vzalloc, proxy_alloc1 },
> +	{ vfree, proxy_free },
> +
>  	{ }
>  };

Petr, thanks for sending this.  This _is_ a pretty concise example of
what it means to convert kernel code to run in your sandbox mode.  But,
from me, it's still "no thanks".

Establishing and maintaining this proxy list will be painful.  Folks
will change the code to call something new and break this *constantly*.

That goes for infrastructure like the allocators and for individual
sandbox instances like apparmor.

It's also telling that sandboxing a bit of apparmor took four fixups.
That tells me we're probably still only looking at the tip of the icebeg
if we were to convert a bunch more sites.

That's on top of everything I was concerned about before.

