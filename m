Return-Path: <linux-kernel+bounces-79017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A38B3861C4B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5BE11F21EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3949143C59;
	Fri, 23 Feb 2024 19:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVaOOIAU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23061D6B6
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708715302; cv=none; b=V2U7t5wGgFVPPhhtp5SLgApXigPVj4nSqy7xdAg23Wf0b7XQ2/9881wXKjmtrfG0ZgucvHW5uMBVvo++tYW6M0JIL9DIqZ5gyeh8I+EYWReiuPLStsLBdGEZFPQi+lg4K1lkvWfPv9mjZTm1ZynfyBfQsG9CKmA5YN/KN3+X14Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708715302; c=relaxed/simple;
	bh=7R9RCGEfnv7As+Ov4XdPpDS7BmdZlFCHr3jRKeBO7MA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VuHZsek4ODVSIggA3RXljzs2cEnX6+0xF7yBYVXRy9y9qQ9XPfrvaDtWIiZ+dpg4oGAxgzLhxcFJc7XMoOutT6sfcUxz8LzJ/9uf/7qQ0AudKpP1QwxR/hH77a/A901vrMShs0rR/hvzLVBiIFXqKLrG4bQ4xJBIQlOER63HAcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVaOOIAU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708715301; x=1740251301;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7R9RCGEfnv7As+Ov4XdPpDS7BmdZlFCHr3jRKeBO7MA=;
  b=TVaOOIAU+238cg/9AN1eGMPi+SRQn4iWX7W6uODZXoqBUwtwg8y9LXXe
   m/pruRBj7CHMAByyy7WAJK02wwdlYkKYQkgHfkGRJ9cUCvmyInu6qpzfm
   egDXAJ8jq9AiXAHEKd/vJ3aAlGvxcPURxQo+Yh5R0BHCbxsOvv5mCIHJn
   bmw/zw8wpzrNs9Edn17eu0j4p3Y12uCUey1ndssmRvdO79RkBEd7BLAHx
   hqMyZkN4CGYMwzkBe4chexQFp5NdT6SZ79DifrP2VYJPuag6RdJ7YAD8r
   gemqesVwz4XXfBnbf80pfIuhHwQec2h8uzl4iVozSzUI2ag9FANRCsmRt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="13746750"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="13746750"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 11:08:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="5979122"
Received: from gtkramer-mobl1.amr.corp.intel.com (HELO [10.209.82.163]) ([10.209.82.163])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 11:08:20 -0800
Message-ID: <a69a3d67-7352-4bf4-8766-a55ce97e46bd@intel.com>
Date: Fri, 23 Feb 2024 11:08:18 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 08/16] x86/tdx: Account shared memory
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-9-kirill.shutemov@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240212104448.2589568-9-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/24 02:44, Kirill A. Shutemov wrote:
> The kernel will convert all shared memory back to private during kexec.
> The direct mapping page tables will provide information on which memory
> is shared.
> 
> It is extremely important to convert all shared memory. If a page is
> missed, it will cause the second kernel to crash when it accesses it.
> 
> Keep track of the number of shared pages. This will allow for
> cross-checking against the shared information in the direct mapping and
> reporting if the shared bit is lost.
> 
> Include a debugfs interface that allows for the check to be performed at
> any point.

When I read this, I thought you were going to do some automatic
checking.  Could you make it more clear here that it's 100% up to the
user to figure out if the numbers in debugfs match and whether there's a
problem?  This would also be a great place to mention that the whole
thing is racy.

> +static atomic_long_t nr_shared;
> +
> +static inline bool pte_decrypted(pte_t pte)
> +{
> +	return cc_mkdec(pte_val(pte)) == pte_val(pte);
> +}

Name this pte_is_decrypted(), please.

>  /* Called from __tdx_hypercall() for unrecoverable failure */
>  noinstr void __noreturn __tdx_hypercall_failed(void)
>  {
> @@ -821,6 +829,11 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
>  	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc))
>  		return -EIO;
>  
> +	if (enc)
> +		atomic_long_sub(numpages, &nr_shared);
> +	else
> +		atomic_long_add(numpages, &nr_shared);
> +
>  	return 0;
>  }
>  
> @@ -896,3 +909,59 @@ void __init tdx_early_init(void)
>  
>  	pr_info("Guest detected\n");
>  }
> +
> +#ifdef CONFIG_DEBUG_FS
> +static int tdx_shared_memory_show(struct seq_file *m, void *p)
> +{
> +	unsigned long addr, end;
> +	unsigned long found = 0;
> +
> +	addr = PAGE_OFFSET;
> +	end  = PAGE_OFFSET + get_max_mapped();
> +
> +	while (addr < end) {
> +		unsigned long size;
> +		unsigned int level;
> +		pte_t *pte;
> +
> +		pte = lookup_address(addr, &level);
> +		size = page_level_size(level);
> +
> +		if (pte && pte_decrypted(*pte))
> +			found += size / PAGE_SIZE;
> +
> +		addr += size;
> +
> +		cond_resched();
> +	}

This is totally racy, right?  Nothing prevents the PTE from
flip-flopping all over the place.

> +	seq_printf(m, "Number of shared pages in kernel page tables:  %16lu\n",
> +		   found);
> +	seq_printf(m, "Number of pages accounted as shared:           %16ld\n",
> +		   atomic_long_read(&nr_shared));
> +	return 0;
> +}

Ditto with 'nr_shared'.  There's nothing to say that the page table walk
has anything to do with 'nr_shared' by the time we get down here.

That's not _fatal_ for a debug interface, but the pitfalls need to at
least be discussed.  Better yet would be to make sure this and the cpa
code don't stomp on each other.

