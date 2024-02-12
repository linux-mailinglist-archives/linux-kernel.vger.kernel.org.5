Return-Path: <linux-kernel+bounces-61933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6862385189E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FAF4283D26
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA11F3D0DB;
	Mon, 12 Feb 2024 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="aa6I/7nJ"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DE93CF7C
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753853; cv=none; b=Ihdt5OKwMRM0fMV4faMQDr4/Z8b91fuK5MlAjRqKx4i5BRJgLFYX4t+NOh/0PaI5DRJzqW8UXhJk1FU6rfHoziC3YxXwslNUQ1yGv0Z0tA20jsYhheuZ5oQ9hQ5BcoOTSrBbyDh0Ec+wnCQX3OsiP5lLKcgB/WWCt6L2l6kHmPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753853; c=relaxed/simple;
	bh=rl/yyVjmBu4nkntx95NTjP9MeBqwIZs3VgXZpyBSGGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pw+8PrBzvSR5G2ie4ZQi/Qj/I6wtrXoPZxjBpVjgTnNxrRPMdSmXYun9JiE5TnGZUVv7VI9sfAuymEncs/3XnLfX4VNSOgijRSyE741aw+xSLtFZ/bZEqMAhyvuRsaUyB9LuDebhJGjAHxlTdgwokpv8Q2BDjgxxVLIqtx+FPW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=aa6I/7nJ; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CG2VcP029891;
	Mon, 12 Feb 2024 16:03:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=sFUZ1ZPFZ/WDyHllg7SZ7uHP4YihqPe1LFWLeuVzMlk=;
 b=aa6I/7nJCtMDWox5l/XN0Mno+JoipZHShRa2/Lp+CnnaXpuvCe5S1YjmVjYK7sKk4uMm
 VmR1zkG2L6buf+Ij7D21wBfZEx6GhMr+UOa9bdu2yblvZ4/9Scqimcc87ACGHESjtjBL
 k8hlnaydbRDr9KSSQLCUkcb97tewOYbHWyuQgtJjumLZ8qfM+ulyGa6zoK7w07ylekxA
 WFs5If4wuK5Tlq6Bnk6VWHd8d05hWuG28ac6aQHgWLGPlbP7wg1W9mKoiM1YTDzxJ4nJ
 S2tPjtVXJewliOVHR6abcNd/799qqA6oCYDxpgAAvKlAi1e/AstIUfcK+cBbPrKFxtuW 7Q== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3w7p7r0ads-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 16:03:29 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 14FDD132DB;
	Mon, 12 Feb 2024 16:03:25 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 60BEC80162E;
	Mon, 12 Feb 2024 16:03:23 +0000 (UTC)
Date: Mon, 12 Feb 2024 10:03:21 -0600
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH v3] x86/mm/ident_map: Use gbpages only where full GB page
 should be mapped.
Message-ID: <20240212160321.GA1508687@dog.eag.rdlabs.hpecorp.net>
References: <20240126164841.170866-1-steve.wahl@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126164841.170866-1-steve.wahl@hpe.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-ORIG-GUID: ARyePb20hroSPz7YuULDTLQnDM6LJ6b0
X-Proofpoint-GUID: ARyePb20hroSPz7YuULDTLQnDM6LJ6b0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_13,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120121

Gentle Ping... Thanks

--> Steve Wahl

On Fri, Jan 26, 2024 at 10:48:41AM -0600, Steve Wahl wrote:
> When ident_pud_init() uses only gbpages to create identity maps, large
> ranges of addresses not actually requested can be included in the
> resulting table; a 4K request will map a full GB.  On UV systems, this
> ends up including regions that will cause hardware to halt the system
> if accessed (these are marked "reserved" by BIOS).  Even though code
> does not actually make references to these addresses, including them
> in an active map allows processor speculation into this region, which
> is enough to trigger the system halt.
> 
> Instead of using gbpages for all memory regions, which can include
> vast areas outside what's actually been requested, use them only when
> map creation requests include the full GB page of space; descend to
> using smaller 2M pages when only portions of a GB page are included in
> the request.
> 
> No attempt is made to coalesce mapping requests. If a request requires
> a map entry at the 2M (pmd) level, subsequent mapping requests within
> the same 1G region will also be at the pmd level, even if adjacent or
> overlapping such requests could have been combined to map a full
> gbpage.  Existing usage starts with larger regions and then adds
> smaller regions, so this should not have any great consequence.
> 
> The existing kernel option "nogbpages" would disallow use of
> gbpages entirely and avoid this problem, but uses a lot of extra
> memory for page tables that are not really needed.
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> ---
> 
> v3: per Dave Hansen review, re-arrange changelog info,
>     refactor code to use bool variable and split out conditions.
> 
> v2: per Dave Hansen review: Additional changelog info,
>     moved pud_large() check earlier in the code, and
>     improved the comment describing the conditions
>     that restrict gbpage usage.
>    
>  arch/x86/mm/ident_map.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
> index 968d7005f4a7..f50cc210a981 100644
> --- a/arch/x86/mm/ident_map.c
> +++ b/arch/x86/mm/ident_map.c
> @@ -26,18 +26,31 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
>  	for (; addr < end; addr = next) {
>  		pud_t *pud = pud_page + pud_index(addr);
>  		pmd_t *pmd;
> +		bool use_gbpage;
>  
>  		next = (addr & PUD_MASK) + PUD_SIZE;
>  		if (next > end)
>  			next = end;
>  
> -		if (info->direct_gbpages) {
> -			pud_t pudval;
> +		/* if this is already a gbpage, this portion is already mapped */
> +		if (pud_large(*pud))
> +			continue;
> +
> +		/* Is using a gbpage allowed? */
> +		use_gbpage = info->direct_gbpages;
>  
> -			if (pud_present(*pud))
> -				continue;
> +		/* Don't use gbpage if it maps more than the requested region. */
> +		/* at the begining: */
> +		use_gbpage &= ((addr & ~PUD_MASK) == 0);
> +		/* ... or at the end: */
> +		use_gbpage &= ((next & ~PUD_MASK) == 0);
> +
> +		/* Never overwrite existing mappings */
> +		use_gbpage &= !pud_present(*pud);
> +
> +		if (use_gbpage) {
> +			pud_t pudval;
>  
> -			addr &= PUD_MASK;
>  			pudval = __pud((addr - info->offset) | info->page_flag);
>  			set_pud(pud, pudval);
>  			continue;
> -- 
> 2.26.2
> 

