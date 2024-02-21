Return-Path: <linux-kernel+bounces-73961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2748E85CE17
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6669284100
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8242F2837A;
	Wed, 21 Feb 2024 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GEDvp+FT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A1D249E4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 02:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483067; cv=none; b=AK3KVKlN+jEhyOGj3wi6KP16qLJjGDR9XNJ4RaYppAqfuau1eO0ZYmte7WymgSAHx+Wpr5zdCV6zhJO9B6GXTFDqtqCyHxtU9lEnlDDH/G3WpN9j2/ju8xhAizHmPlkiNuC0E/ytOwSf+A7b5VJN0JXS/pf5m+8zukZlJs6abdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483067; c=relaxed/simple;
	bh=pPTKCdY9creDjcLWMyQf0xXSOqUquqJnbrHQ99XuHvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBrx/ehK6Mt8AGNyg8QcNkYGjwwrpwkNLNALOUDsjGsf3hUthGILDi+DqEvNKrOU/PXa7VGOtLhXVsJNDWQcLBuqYFUvFTlSiR2B2Eh9en6l3KLJOZKkURKy/3xk6L6f3sJVnwQz87MTXKqeHKH53TthWfDyWOLxkCi/QkbQAUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GEDvp+FT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708483063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GIMDrzpnacEme9gLjUpWeDhxio/wVIn1riqvLCd96I4=;
	b=GEDvp+FTwyWEWP4kLtTDZt/SPCNC1sE8BJgPEuZbX7lJ4XAtL+ZctcfAiiKvrUVbfqcI3i
	9T28gOFhW6oL+JUwcsii6Qbkask0USbEogLlNpNglQ8ByRRl2n4hp4OlrQd0KudGQgfqDl
	JI38ibRHevfbwkYeEgPvd1+EklWBjzQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-Yf2dw5QQPkmYmsDRr--p_Q-1; Tue,
 20 Feb 2024 21:37:35 -0500
X-MC-Unique: Yf2dw5QQPkmYmsDRr--p_Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 875453C40B56;
	Wed, 21 Feb 2024 02:37:34 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AC77492BD7;
	Wed, 21 Feb 2024 02:37:32 +0000 (UTC)
Date: Wed, 21 Feb 2024 10:37:29 +0800
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
Message-ID: <ZdVh6efExdt687YY@MiWiFi-R3L-srv>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-8-kirill.shutemov@linux.intel.com>
 <ZdLjQCaxhOnR+GzX@MiWiFi-R3L-srv>
 <zhbhgq27kjrhkdgbxomjykjez2i4hckguvmxyptvfvoftue5ca@zowl5qbl6psl>
 <ZdR+JzfHjES3zytp@MiWiFi-R3L-srv>
 <ic4v3q4muffjq2jhlkk3k4lg5xxvjwlw22hctzubl5573euzu2@er3m7ztog2a6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ic4v3q4muffjq2jhlkk3k4lg5xxvjwlw22hctzubl5573euzu2@er3m7ztog2a6>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 02/20/24 at 02:36pm, Kirill A. Shutemov wrote:
> On Tue, Feb 20, 2024 at 06:25:43PM +0800, Baoquan He wrote:
> > > I am not sure what part of the comment you see doesn't reflect the
> > > behaviour. From my PoV, changed code matches the comment closer that
> > > original.
> > 
> > Oh, I didn't make it clear. I mean update the code comment for
> > lookup_address(), and add code comment for lookup_address_in_pgd() to
> > mention the level thing. Maybe it's a chance to do that.
> > 
> > ===1>
> > *
> >  * Lookup the page table entry for a virtual address. Return a pointer
> >  * to the entry and the level of the mapping.
> >  *
> >  * Note: We return pud and pmd either when the entry is marked large
> >                    ~~~~~~~~~~~ seems we return p4d too
> >  * or when the present bit is not set. Otherwise we would return a
> >  * pointer to a nonexisting mapping.
> >               ~~~~~~~~~~~~~~~ NULL?
> >  */                          
> > pte_t *lookup_address(unsigned long address, unsigned int *level)
> > {
> >         return lookup_address_in_pgd(pgd_offset_k(address), address, level);
> > }
> > EXPORT_SYMBOL_GPL(lookup_address);
> > ===
> > 
> > ===2>
> > /*
> >  * Lookup the page table entry for a virtual address in a specific pgd.
> >  * Return a pointer to the entry and the level of the mapping.
> >    ~~ also could return NULL if it's none entry. And do we need to
> > mention the level thing?
> >  */
> > pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
> >                              unsigned int *level)
> > ...
> > }
> > 
> 
> What about this fixup:

Some nitpicks.
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 3612e3167147..425ff6e192e6 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -657,7 +657,8 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
>  
>  /*
>   * Lookup the page table entry for a virtual address in a specific pgd.
> - * Return a pointer to the entry and the level of the mapping.
> + * Return a pointer to the entry and the level of the mapping (or NULL if
> + * the entry is none) and level of the entry.
                       ^ this right parenthesis may need be moved to the end.


=======
 * Return a pointer to the entry and the level of the mapping (or NULL if
 * the entry is none and level of the entry).
=======

>   */
>  pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
>  			     unsigned int *level)
> @@ -704,9 +705,8 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
>   * Lookup the page table entry for a virtual address. Return a pointer
>   * to the entry and the level of the mapping.
>   *
> - * Note: We return pud and pmd either when the entry is marked large
> - * or when the present bit is not set. Otherwise we would return a
> - * pointer to a nonexisting mapping.
> + * Note: the function returns p4d, pud and pmd either when the entry is marked
                                          ~~~
                                           ^ s/and/or/
> + * large or when the present bit is not set. Otherwise it returns NULL.
>   */
>  pte_t *lookup_address(unsigned long address, unsigned int *level)
>  {
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
> 


