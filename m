Return-Path: <linux-kernel+bounces-70721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433BB859B89
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0BBF281A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37B91CF8D;
	Mon, 19 Feb 2024 05:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FS//woU5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0C1257D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 05:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708319565; cv=none; b=hVUGOyCwICUPRqRvUY1RNF0yJGZjDEhNOeSG2iB1FpDZcK+OFn2E3n1gcgt6CvQKCnt6cSkfvsQhMkvcOQKy1228XtsGIomlzIF/2HiUPxXH6mtA8O+xhaqGv/JpqhfZEqTC+wUukozlw1h/AaFKhwsH6ypd8zj7JQF46EdsmZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708319565; c=relaxed/simple;
	bh=NsrL4UL1lEvCwz0PuMP/EEk4p4JFEnR4E+woMMDvJdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtpR8W1A15RuL5MtuFN5tgq4Cns3unSG3geOeaPjQPtU5Gjws7oqUGpEk4ZEAhtXuWC5gYwHrjRTMnOw6Iht3gDv6khXy6XGpezv018kFHxN6DLwAuqFcKaTcfGwMRfNjQxTVRkXwf8vDvoSJgchCpAK7WBF9zqbCc1dTCxa3NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FS//woU5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708319562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ktsZLj5Do+hodpvfXmzkCkX+tlR+x9oS5L9mx60J7nU=;
	b=FS//woU5ZVuGU2vYF7aOwyTuqOyVLbQFdHm1Fp9PwPdUIvksj55n7CgmIte1xpb6wYyMxi
	ODHM9ZUx3EJ4+3gdv3pkaOCCutNOASwEL0AH9vAP+atgfffwq6L28BJ59Lk+TDBpoeGxrA
	/YPbsmRwl9qFmQzBUnX7fGWELa292VU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-lFVn_Kq_PiKmLn-f0QhQYg-1; Mon,
 19 Feb 2024 00:12:38 -0500
X-MC-Unique: lFVn_Kq_PiKmLn-f0QhQYg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EDA33C23FC7;
	Mon, 19 Feb 2024 05:12:37 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F236AC07;
	Mon, 19 Feb 2024 05:12:34 +0000 (UTC)
Date: Mon, 19 Feb 2024 13:12:32 +0800
From: Baoquan He <bhe@redhat.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 07/16] x86/mm: Return correct level from
 lookup_address() if pte is none
Message-ID: <ZdLjQCaxhOnR+GzX@MiWiFi-R3L-srv>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-8-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212104448.2589568-8-kirill.shutemov@linux.intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 02/12/24 at 12:44pm, Kirill A. Shutemov wrote:
> lookup_address() only returns correct page table level for the entry if
> the entry is not none.
> 
> Make the helper to always return correct 'level'. It allows to implement
> iterator over kernel page tables using lookup_address().
> 
> Add one more entry into enum pg_level to indicate size of VA covered by
> one PGD entry in 5-level paging mode.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/include/asm/pgtable_types.h | 1 +
>  arch/x86/mm/pat/set_memory.c         | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index 0b748ee16b3d..3f648ffdfbe5 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -548,6 +548,7 @@ enum pg_level {
>  	PG_LEVEL_2M,
>  	PG_LEVEL_1G,
>  	PG_LEVEL_512G,
> +	PG_LEVEL_256T,
>  	PG_LEVEL_NUM
>  };
>  
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index f92da8c9a86d..3612e3167147 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -666,32 +666,32 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>

By the way, we may need update the code comment above function
lookup_address_in_pgd() and function lookup_address() since they don't
reflect the latest behaviour of them.

>  	pud_t *pud;
>  	pmd_t *pmd;
>  
> -	*level = PG_LEVEL_NONE;
> +	*level = PG_LEVEL_256T;
>  
>  	if (pgd_none(*pgd))
>  		return NULL;
>  
> +	*level = PG_LEVEL_512G;
>  	p4d = p4d_offset(pgd, address);
>  	if (p4d_none(*p4d))
>  		return NULL;
>  
> -	*level = PG_LEVEL_512G;
>  	if (p4d_large(*p4d) || !p4d_present(*p4d))
>  		return (pte_t *)p4d;
>  
> +	*level = PG_LEVEL_1G;
>  	pud = pud_offset(p4d, address);
>  	if (pud_none(*pud))
>  		return NULL;
>  
> -	*level = PG_LEVEL_1G;
>  	if (pud_large(*pud) || !pud_present(*pud))
>  		return (pte_t *)pud;
>  
> +	*level = PG_LEVEL_2M;
>  	pmd = pmd_offset(pud, address);
>  	if (pmd_none(*pmd))
>  		return NULL;
>  
> -	*level = PG_LEVEL_2M;
>  	if (pmd_large(*pmd) || !pmd_present(*pmd))
>  		return (pte_t *)pmd;
>  
> -- 
> 2.43.0
> 


