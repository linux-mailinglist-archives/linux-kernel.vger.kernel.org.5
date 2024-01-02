Return-Path: <linux-kernel+bounces-14980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A073682259D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BDBD284566
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F9117984;
	Tue,  2 Jan 2024 23:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjQDDbVB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BFD1775E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 23:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704238933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UjYTBnUjGAihRalbH8/D8jyPDwibjRZBox8xXLoEF/I=;
	b=SjQDDbVBABgqWbKNeT/y3tSO76fD5asPKskBx4fJFHBtCDdLHWihnDTfshJr1xn/BX+Edx
	pCArvJT+lQYUBbxi6zaYSwc584DhALXgtW2UKiTju1I1pQmJZZB2j5+qV84X86/hm69pw4
	Mqsragj9v7dUjmIWsDh2dS7sRLA9lkg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-sSwRajKQN0aNxm2Hr1yK_A-1; Tue,
 02 Jan 2024 18:42:10 -0500
X-MC-Unique: sSwRajKQN0aNxm2Hr1yK_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E3871C5407F;
	Tue,  2 Jan 2024 23:42:09 +0000 (UTC)
Received: from localhost (unknown [10.72.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C24040C6EB9;
	Tue,  2 Jan 2024 23:42:08 +0000 (UTC)
Date: Wed, 3 Jan 2024 07:42:05 +0800
From: Baoquan He <bhe@redhat.com>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v2 3/3] crash_core: fix and simplify the logic of
 crash_exclude_mem_range()
Message-ID: <ZZSfTUUckEErqMGq@MiWiFi-R3L-srv>
References: <20240102144905.110047-1-ytcoode@gmail.com>
 <20240102144905.110047-4-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102144905.110047-4-ytcoode@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 01/02/24 at 10:49pm, Yuntao Wang wrote:
> The purpose of crash_exclude_mem_range() is to remove all memory ranges
> that overlap with [mstart-mend]. However, the current logic only removes
> the first overlapping memory range.
> 
> Commit a2e9a95d2190 ("kexec: Improve & fix crash_exclude_mem_range() to
> handle overlapping ranges") attempted to address this issue, but it did not
> fix all error cases.
> 
> Let's fix and simplify the logic of crash_exclude_mem_range().

Thanks, this makes the code logic much clearer and easier to follow.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  kernel/crash_core.c | 80 ++++++++++++++++-----------------------------
>  1 file changed, 29 insertions(+), 51 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index efe87d501c8c..c51d0a54296b 100644
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
> @@ -575,72 +574,51 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>  		p_start = mstart;
>  		p_end = mend;
>  
> -		if (mstart > end || mend < start)
> +		if (p_start > end)
>  			continue;
>  
> +		/*
> +		 * Because the memory ranges in mem->ranges are stored in
> +		 * ascending order, when we detect `p_end < start`, we can
> +		 * immediately exit the for loop, as the subsequent memory
> +		 * ranges will definitely be outside the range we are looking
> +		 * for.
> +		 */
> +		if (p_end < start)
> +			break;
> +
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


