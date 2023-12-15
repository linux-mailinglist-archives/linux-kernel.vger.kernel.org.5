Return-Path: <linux-kernel+bounces-1195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8448814B88
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700AB2861D0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECAE3715E;
	Fri, 15 Dec 2023 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+HJko4f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6971364DA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702653320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xmBbuKgtcJTPsoI80iq/qmH5+IN/NVMKCIFpG3IS32o=;
	b=f+HJko4faCJiY4tIsQysHl1wYcHcsDlswAx0RGMMhbMv6FiqtgQVVP+zmjlFTqjVLgAtWZ
	5RaZV3/z7cc1kyafc6ENt3hBZsEiwHPOSQ1If/tLExOMiohqDjNJf/MTa9ktQ0BX0B6ND8
	WV5o8RKIVFY7bE46x7UGAeNGJ3lOjWw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-wXEn5tR-OSyoYd0oxYHwjQ-1; Fri, 15 Dec 2023 10:15:16 -0500
X-MC-Unique: wXEn5tR-OSyoYd0oxYHwjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1742D8432A4;
	Fri, 15 Dec 2023 15:15:15 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 064EE1C060B1;
	Fri, 15 Dec 2023 15:15:13 +0000 (UTC)
Date: Fri, 15 Dec 2023 23:15:10 +0800
From: Baoquan He <bhe@redhat.com>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Takashi Iwai <tiwai@suse.de>, Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH 3/3] crash_core: fix and simplify the logic of
 crash_exclude_mem_range()
Message-ID: <ZXxtfpXpuFXLd+ge@MiWiFi-R3L-srv>
References: <20231214163842.129139-1-ytcoode@gmail.com>
 <20231214163842.129139-4-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214163842.129139-4-ytcoode@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 12/15/23 at 12:38am, Yuntao Wang wrote:
> The purpose of crash_exclude_mem_range() is to remove all memory ranges
> that overlap with [mstart-mend]. However, the current logic only removes
> the first overlapping memory range.
> 
> Commit a2e9a95d2190 ("kexec: Improve & fix crash_exclude_mem_range() to
> handle overlapping ranges") attempted to address this issue, but it did not
> fix all error cases.

Hmm, this is a specific function for kdump kernel loading. So far it's
sufficiently meet demands. Say so because we only need to exclude
crashk_res and crashk_low_res when constructing elfcorehdr. region
crashk_res/crashk_low_res are digged out from system RAM region. That's
why the break is taken in the for loop in the current code. X86 needs
exclude low 1M, the low 1M could span several system RAM regions because
BIOS under low 1M reserved some spaces. And the elfcorehdr exluding from
crashkernel region taken in x86 is also a splitting.

Generally speaking, crashk_res/crashk_low_res is inside a big chunk of
continuous region. On x86, low 1M spans several complete region on x86,
elfcorehdr region is inside continuous crashk_res region.

You can see why crash_exclude_mem_range() looks like now it is. This patch
makes crash_exclude_mem_range() be a generic region removing function. I do
see the memmove can improve code readbility, while I have concern about the
while loop.

Imagine we have a crashkernel region 256M reserved under 4G, say [2G, 2G+256M].
Then after excluding the 256M from a region, it should stop. But now, this patch
will make it continue scanning. Not sure if it's all in my mind.

> 
> Let's fix and simplify the logic of crash_exclude_mem_range().
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  kernel/crash_core.c | 70 ++++++++++++---------------------------------
>  1 file changed, 19 insertions(+), 51 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index efe87d501c8c..0292a4c8bb2f 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -565,9 +565,8 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>  int crash_exclude_mem_range(struct crash_mem *mem,
>  			    unsigned long long mstart, unsigned long long mend)
>  {
> -	int i, j;
> +	int i;
>  	unsigned long long start, end, p_start, p_end;
> -	struct range temp_range = {0, 0};
>  
>  	for (i = 0; i < mem->nr_ranges; i++) {
>  		start = mem->ranges[i].start;
> @@ -575,72 +574,41 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>  		p_start = mstart;
>  		p_end = mend;
>  
> -		if (mstart > end || mend < start)
> +		if (p_start > end || p_end < start)
>  			continue;
>  
>  		/* Truncate any area outside of range */
> -		if (mstart < start)
> +		if (p_start < start)
>  			p_start = start;
> -		if (mend > end)
> +		if (p_end > end)
>  			p_end = end;
>  
>  		/* Found completely overlapping range */
>  		if (p_start == start && p_end == end) {
> -			mem->ranges[i].start = 0;
> -			mem->ranges[i].end = 0;
> -			if (i < mem->nr_ranges - 1) {
> -				/* Shift rest of the ranges to left */
> -				for (j = i; j < mem->nr_ranges - 1; j++) {
> -					mem->ranges[j].start =
> -						mem->ranges[j+1].start;
> -					mem->ranges[j].end =
> -							mem->ranges[j+1].end;
> -				}
> -
> -				/*
> -				 * Continue to check if there are another overlapping ranges
> -				 * from the current position because of shifting the above
> -				 * mem ranges.
> -				 */
> -				i--;
> -				mem->nr_ranges--;
> -				continue;
> -			}
> +			memmove(&mem->ranges[i], &mem->ranges[i + 1],
> +				(mem->nr_ranges - (i + 1)) * sizeof(mem->ranges[i]));
> +			i--;
>  			mem->nr_ranges--;
> -			return 0;
> -		}
> -
> -		if (p_start > start && p_end < end) {
> +		} else if (p_start > start && p_end < end) {
>  			/* Split original range */
> +			if (mem->nr_ranges >= mem->max_nr_ranges)
> +				return -ENOMEM;
> +
> +			memmove(&mem->ranges[i + 2], &mem->ranges[i + 1],
> +				(mem->nr_ranges - (i + 1)) * sizeof(mem->ranges[i]));
> +
>  			mem->ranges[i].end = p_start - 1;
> -			temp_range.start = p_end + 1;
> -			temp_range.end = end;
> +			mem->ranges[i + 1].start = p_end + 1;
> +			mem->ranges[i + 1].end = end;
> +
> +			i++;
> +			mem->nr_ranges++;
>  		} else if (p_start != start)
>  			mem->ranges[i].end = p_start - 1;
>  		else
>  			mem->ranges[i].start = p_end + 1;
> -		break;
> -	}
> -
> -	/* If a split happened, add the split to array */
> -	if (!temp_range.end)
> -		return 0;
> -
> -	/* Split happened */
> -	if (i == mem->max_nr_ranges - 1)
> -		return -ENOMEM;
> -
> -	/* Location where new range should go */
> -	j = i + 1;
> -	if (j < mem->nr_ranges) {
> -		/* Move over all ranges one slot towards the end */
> -		for (i = mem->nr_ranges - 1; i >= j; i--)
> -			mem->ranges[i + 1] = mem->ranges[i];
>  	}
>  
> -	mem->ranges[j].start = temp_range.start;
> -	mem->ranges[j].end = temp_range.end;
> -	mem->nr_ranges++;
>  	return 0;
>  }
>  
> -- 
> 2.43.0
> 


