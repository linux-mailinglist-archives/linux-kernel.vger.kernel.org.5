Return-Path: <linux-kernel+bounces-72817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4361F85B8F7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D6A285997
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA7F612CA;
	Tue, 20 Feb 2024 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UD8WrMEv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F90E612E2
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424754; cv=none; b=JwIk2xl/JtK7CL+a7Cvq5MmzEpWVIg0vvAgDuAS3fDqXOHlJY3Cmx4kkGkWZ6lgghVU9CErFNVGpis2MHQE36v9xcP7pcuggQJewQWwLKx17lehWNKaaxaCXMta9hHikmc2FtCcE1x8Gv7WtrcqxtuB1VxtZmosliHazSdPgXPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424754; c=relaxed/simple;
	bh=wg6VDrurtGdejNdwTV9KCdi+jcJpnILodt2ZkcTdixE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdN93NBeC5HB/BE7AQck6dZCxXUW0V2ZXnT1CoTDOU2CnHGX8raLSrWnBbnOF8WTXZdkG8u5jfNvGWJk8GQe5JTnILOFNr3IR/YiHEuQ0Hw/drIGHFSKySQy28aGf/OiNmnKooPFFyIqgaM70y7i9eXEVFEuhv6cFcAgmpbh4g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UD8WrMEv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708424751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6CJmYxHjSreu7pvbpR786lmw2JKf71InmDGqh/N4n8g=;
	b=UD8WrMEvo84noisVDfbIuXXNyIfuYKCLmSPM1wrvplq/mnuBGVFhGo+Muje4ca7BaXX09q
	PrFPwy7aEVxyEz75/8hICijwJXA36MP58ET2lkV/FD2kDXbGeofntbCUHbQLzVjm08hRy0
	Sq1EKLJImseO94N81VvxKoLA/4ic7Ek=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-IBasa97ZNHaPfAgAfWH0zw-1; Tue, 20 Feb 2024 05:25:48 -0500
X-MC-Unique: IBasa97ZNHaPfAgAfWH0zw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC57585A589;
	Tue, 20 Feb 2024 10:25:47 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EDB91121306;
	Tue, 20 Feb 2024 10:25:46 +0000 (UTC)
Date: Tue, 20 Feb 2024 18:25:43 +0800
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
Message-ID: <ZdR+JzfHjES3zytp@MiWiFi-R3L-srv>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-8-kirill.shutemov@linux.intel.com>
 <ZdLjQCaxhOnR+GzX@MiWiFi-R3L-srv>
 <zhbhgq27kjrhkdgbxomjykjez2i4hckguvmxyptvfvoftue5ca@zowl5qbl6psl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zhbhgq27kjrhkdgbxomjykjez2i4hckguvmxyptvfvoftue5ca@zowl5qbl6psl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 02/19/24 at 03:52pm, Kirill A. Shutemov wrote:
> On Mon, Feb 19, 2024 at 01:12:32PM +0800, Baoquan He wrote:
> > On 02/12/24 at 12:44pm, Kirill A. Shutemov wrote:
> > > lookup_address() only returns correct page table level for the entry if
> > > the entry is not none.
> > > 
> > > Make the helper to always return correct 'level'. It allows to implement
> > > iterator over kernel page tables using lookup_address().
> > > 
> > > Add one more entry into enum pg_level to indicate size of VA covered by
> > > one PGD entry in 5-level paging mode.
> > > 
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > > ---
> > >  arch/x86/include/asm/pgtable_types.h | 1 +
> > >  arch/x86/mm/pat/set_memory.c         | 8 ++++----
> > >  2 files changed, 5 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> > > index 0b748ee16b3d..3f648ffdfbe5 100644
> > > --- a/arch/x86/include/asm/pgtable_types.h
> > > +++ b/arch/x86/include/asm/pgtable_types.h
> > > @@ -548,6 +548,7 @@ enum pg_level {
> > >  	PG_LEVEL_2M,
> > >  	PG_LEVEL_1G,
> > >  	PG_LEVEL_512G,
> > > +	PG_LEVEL_256T,
> > >  	PG_LEVEL_NUM
> > >  };
> > >  
> > > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > > index f92da8c9a86d..3612e3167147 100644
> > > --- a/arch/x86/mm/pat/set_memory.c
> > > +++ b/arch/x86/mm/pat/set_memory.c
> > > @@ -666,32 +666,32 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
> > 
> > LGTM,
> > 
> > Reviewed-by: Baoquan He <bhe@redhat.com>
> > 
> > By the way, we may need update the code comment above function
> > lookup_address_in_pgd() and function lookup_address() since they don't
> > reflect the latest behaviour of them.
> 
> I am not sure what part of the comment you see doesn't reflect the
> behaviour. From my PoV, changed code matches the comment closer that
> original.

Oh, I didn't make it clear. I mean update the code comment for
lookup_address(), and add code comment for lookup_address_in_pgd() to
mention the level thing. Maybe it's a chance to do that.

===1>
*
 * Lookup the page table entry for a virtual address. Return a pointer
 * to the entry and the level of the mapping.
 *
 * Note: We return pud and pmd either when the entry is marked large
                   ~~~~~~~~~~~ seems we return p4d too
 * or when the present bit is not set. Otherwise we would return a
 * pointer to a nonexisting mapping.
              ~~~~~~~~~~~~~~~ NULL?
 */                          
pte_t *lookup_address(unsigned long address, unsigned int *level)
{
        return lookup_address_in_pgd(pgd_offset_k(address), address, level);
}
EXPORT_SYMBOL_GPL(lookup_address);
===

===2>
/*
 * Lookup the page table entry for a virtual address in a specific pgd.
 * Return a pointer to the entry and the level of the mapping.
   ~~ also could return NULL if it's none entry. And do we need to
mention the level thing?
 */
pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
                             unsigned int *level)
..
}


