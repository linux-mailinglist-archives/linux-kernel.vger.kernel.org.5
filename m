Return-Path: <linux-kernel+bounces-20124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D255D827A24
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB771F237B2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607CC56450;
	Mon,  8 Jan 2024 21:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Z1V784RG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92B15644D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 408Jahf5029291;
	Mon, 8 Jan 2024 21:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=ZufkvsNmBYIhf482lC8Wys9kgXuS94HzOt66ZnzeuNQ=;
 b=Z1V784RGrqKxUoLyAoTX1A1PLrBZWq5zZSqbaVJ09iS6YlILOJHD7Z2gJlsbN5ohsdKu
 Aj7heOgDxVRpY38SAkLDPmBPGWimMLa70j/dPNFaicaoXLpDdsJdkkeMYh1ZrzRG2Xar
 Uam8XG7djnh9O7PbsNU62X/Vpa5X2T55E5bUa7TcQrLwQBK+hsyFlKzkmui0dpfaNSer
 NGp4ToGsBONKNcyXZ9rd+9BhZQ+O1106JIYvXxByXpbXHBPVSqQYqkgzqsn81JnwXoRO
 43Z40xwzScAWM4Dw4vjxwFyZhaawdLMZRj8DpGHJhyXERGlnJGD2Bj7CqHqvSFD8Kb+W 3g== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3vgmnutdkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 21:21:11 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id B424C805E1F;
	Mon,  8 Jan 2024 21:21:10 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 48FB18065C5;
	Mon,  8 Jan 2024 21:21:08 +0000 (UTC)
Date: Mon, 8 Jan 2024 15:21:06 -0600
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH v2] x86/mm/ident_map: Use gbpages only where full GB page
 should be mapped.
Message-ID: <20240108212106.GA1571174@dog.eag.rdlabs.hpecorp.net>
References: <20231103190108.184817-1-steve.wahl@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103190108.184817-1-steve.wahl@hpe.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-GUID: QK5-pRRNz1n0EOJVcZF1eRRMp9Kc1Vjc
X-Proofpoint-ORIG-GUID: QK5-pRRNz1n0EOJVcZF1eRRMp9Kc1Vjc
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-08_10,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401080175

Gentle ping.  

We'd like to see this get in, we're finding the most likely time to
hit the problem seems to be when kexec'ing a kdump kernel, and we
don't get the dump we need to diagnose some other problem.

Thanks,

--> Steve Wahl

On Fri, Nov 03, 2023 at 02:01:08PM -0500, Steve Wahl wrote:
> Instead of using gbpages for all memory regions, which can include
> vast areas outside what's actually been requested, use them only when
> map creation requests include the full GB page of space; descend to
> using smaller 2M pages when only portions of a GB page are included in
> the request.
> 
> No attempt is made to coalesce mapping requests. If a request requires
> a map entry at the 2M (pmd) level, subsequent mapping requests within
> the same 1G region will also be at the pmd level, even if adjacent or
> overlapping such requests could theoretically have been combined to
> map a full gbpage.  Existing usage starts with larger regions and then
> adds smaller regions, so this should not have any great consequence.
> 
> When gbpages are used exclusively to create identity maps, large
> ranges of addresses not actually requested can be included in the
> resulting table.  On UV systems, this ends up including regions that
> will cause hardware to halt the system if accessed (these are marked
> "reserved" by BIOS).  Even though code does not actually make
> references to these addresses, including them in an active map allows
> processor speculation into this region, which is enough to trigger the
> system halt.
> 
> The kernel option "nogbpages" will disallow use of gbpages entirely
> and avoid this problem, but uses a lot of extra memory for page tables
> that are not really needed.
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> ---
> v2: per Dave Hanson review: Additional changelog info,
>     moved pud_large() check earlier in the code, and
>     improved the comment describing the conditions
>     that restrict gbpage usage.
>    
>  arch/x86/mm/ident_map.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
> index 968d7005f4a7..5c88c3a7d12a 100644
> --- a/arch/x86/mm/ident_map.c
> +++ b/arch/x86/mm/ident_map.c
> @@ -31,13 +31,23 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
>  		if (next > end)
>  			next = end;
>  
> -		if (info->direct_gbpages) {
> -			pud_t pudval;
> +		/* if this is already a gbpage, this portion is already mapped */
> +		if (pud_large(*pud))
> +			continue;
>  
> -			if (pud_present(*pud))
> -				continue;
> +		/*
> +		 * To be eligible to use a gbpage:
> +		 *   - gbpages must be enabled
> +		 *   - addr must be gb aligned (start of region)
> +		 *   - next must be gb aligned (end of region)
> +		 *   - PUD must be empty (nothing already mapped in this region)
> +		 */
> +		if (info->direct_gbpages
> +		    && !(addr & ~PUD_MASK)
> +		    && !(next & ~PUD_MASK)
> +		    && !pud_present(*pud)) {
> +			pud_t pudval;
>  
> -			addr &= PUD_MASK;
>  			pudval = __pud((addr - info->offset) | info->page_flag);
>  			set_pud(pud, pudval);
>  			continue;
> -- 
> 2.26.2
> 

