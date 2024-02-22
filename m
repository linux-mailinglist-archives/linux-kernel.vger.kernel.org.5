Return-Path: <linux-kernel+bounces-76787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2784085FC93
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A21286915
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15CD14F9CF;
	Thu, 22 Feb 2024 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWE1EkAr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFED314A093
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616292; cv=none; b=avYnVkkKzXVbXghvSY4n9xUNTdoSVLWxzanc+J660cUw0Uaqs/wx8ou75wkwqiKC7DIvGMD77Ky4X28/Wde0RzrcCCdSGvvJQj4rP6yOc4n+pHkIeOxwm7vh9wRhm6exEuh66bBiOOFU/lASIxgiFC1NA5fZXML4FUVfGNxEK+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616292; c=relaxed/simple;
	bh=SjlZWaZo4IOCJl163JtnSm92bFyN5RFQkXSgAX+7pwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kmtz0l7Z1pGvCTGGpQ/i9/Z2ebwdL4rZJE/C5s4NXqaxKy3rFNuFsuSFbgLjyrpqH90AebvKEfGsIb/YFjnVZQjIy2XoE1UBwYKweP37SPSmhAJ8pKDXJFzX1inWbDDWDykBGY2EFs6t3OnphmabKd+fnyi7rg33GznsjQDgx48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jWE1EkAr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708616289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2zLTzF/EaarbV0Ayz1K5vhiNlvZJ6XriwzG+FJ76a8=;
	b=jWE1EkArz38yYcyDG0IRa27xxwOBHIi2Iq7lfZMxKInlIUURZc+/NlTSAwoBc3f5fq8+kr
	dVzVrEKMfZfNUEcEpLEzTa1S7wB6EtN2kA5DYnZg1IDyeHU67HiZabTknfTS0m3p4+zaZL
	sPK7Wa/LC0ckNqpsHkTPeL1iudCw8c4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-SDpRsDIIPQCfsD-HL-3ZTA-1; Thu, 22 Feb 2024 10:38:07 -0500
X-MC-Unique: SDpRsDIIPQCfsD-HL-3ZTA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85A6B830DCC;
	Thu, 22 Feb 2024 15:38:03 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C5F8F40C94A7;
	Thu, 22 Feb 2024 15:38:02 +0000 (UTC)
Date: Thu, 22 Feb 2024 23:37:59 +0800
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
Message-ID: <ZddqV4bCtcW0wJWi@MiWiFi-R3L-srv>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-8-kirill.shutemov@linux.intel.com>
 <ZdLjQCaxhOnR+GzX@MiWiFi-R3L-srv>
 <zhbhgq27kjrhkdgbxomjykjez2i4hckguvmxyptvfvoftue5ca@zowl5qbl6psl>
 <ZdR+JzfHjES3zytp@MiWiFi-R3L-srv>
 <ic4v3q4muffjq2jhlkk3k4lg5xxvjwlw22hctzubl5573euzu2@er3m7ztog2a6>
 <ZdVh6efExdt687YY@MiWiFi-R3L-srv>
 <p34d7e5r3gkcj2xl5jycyldvpkmcllmhzioaqcmseeugl3eq73@plk43dd4luzu>
 <ZdcplT8Xb5eevu/9@MiWiFi-R3L-srv>
 <k33hshbceai3tb7qe6id6kx3iqf7kjhlyvdijvmuf6knv32krs@kwo3m7dkn5sm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k33hshbceai3tb7qe6id6kx3iqf7kjhlyvdijvmuf6knv32krs@kwo3m7dkn5sm>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 02/22/24 at 04:04pm, Kirill A. Shutemov wrote:
> On Thu, Feb 22, 2024 at 07:01:41PM +0800, Baoquan He wrote:
> > On 02/21/24 at 04:15pm, Kirill A. Shutemov wrote:
> > > On Wed, Feb 21, 2024 at 10:37:29AM +0800, Baoquan He wrote:
> > > > > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > > > > index 3612e3167147..425ff6e192e6 100644
> > > > > --- a/arch/x86/mm/pat/set_memory.c
> > > > > +++ b/arch/x86/mm/pat/set_memory.c
> > > > > @@ -657,7 +657,8 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
> > > > >  
> > > > >  /*
> > > > >   * Lookup the page table entry for a virtual address in a specific pgd.
> > > > > - * Return a pointer to the entry and the level of the mapping.
> > > > > + * Return a pointer to the entry and the level of the mapping (or NULL if
> > > > > + * the entry is none) and level of the entry.
> > > >                        ^ this right parenthesis may need be moved to the end.
> > > > 
> > > > 
> > > > =======
> > > >  * Return a pointer to the entry and the level of the mapping (or NULL if
> > > >  * the entry is none and level of the entry).
> > > > =======
> > > 
> > > Emm.. I like my variant more. We return level regardless if the entry none
> > > or not. I don't see a reason to repeat it twice.
> > 
> > 
> >  * Lookup the page table entry for a virtual address in a specific pgd.
> >  * Return a pointer to the entry and the level of the mapping (or NULL if
> >  * the entry is none) and level of the entry.
> > 
> > Hmm, I am confused. Why do we need to stress the level of the mapping
> > and level of the entry? Wondering what is the difference. I must miss
> > something.
> 
> My bad. This is way I meant to write:
> 
>  * Lookup the page table entry for a virtual address in a specific pgd.
>  * Return a pointer to the entry (or NULL if the entry does not exist) and
>  * the level of the entry.

ACK. Thanks.


