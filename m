Return-Path: <linux-kernel+bounces-76376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE8B85F666
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8FAEB263D1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3C34207B;
	Thu, 22 Feb 2024 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BHmfZ+5k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50615219E8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599711; cv=none; b=gZkAHChOKZ1gjIPk2ElOzrEN3eFBJ6qdU1yMH+42IR3uoOS6cY5jN/+KXe/WbrqxoeFPmjE7lM23lQ5l1fINAynCk0j1lJkqt7fbk2XiTxLeDqM9ZD313js8GMXxzGmQq0Wu5mcisXCJDxvK64G0vmFv/FJ7/8hqu0BlFyW6y+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599711; c=relaxed/simple;
	bh=WI+8ToSVJ6JGQhk6slvgL1Ffo12svsX2MFuD22j76uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSYf08yzUJrAKZ6m+cbeOX0Q0i41pQoN22noKEKmTdq60epXhOvdWOq+Q/sorrlCbc9E6v6kQMBOTzXTp/NXjVbQW92T36vrX68AxRekciEd7fOesaiTzoN5bvadTmu3746owIDaxCPyxT1lJUMjzX8d+xGqeXEhU3r+F7sZTZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BHmfZ+5k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708599709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VFwcHVEtiDhTvRigoTq212XHeG8ky/6AjwT+KI1KNaQ=;
	b=BHmfZ+5kLckbl5zoDQxiMDySoLkFU2sNQvELgzltft8HofS6ou+7fvAIynPZcS0oAHCnJC
	A3z4h7cbYVEp+cSUXAG35DgayOjMQlire/KR36jCyIRSXxXxRJojAZ1jCp9SORN8QGdPSd
	L7mfzuJK0lLmFO1VviZVRLeMgYuY1E0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-OcOjjzq9PGa9bb85kAn-jA-1; Thu,
 22 Feb 2024 06:01:46 -0500
X-MC-Unique: OcOjjzq9PGa9bb85kAn-jA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26A20386A0A0;
	Thu, 22 Feb 2024 11:01:45 +0000 (UTC)
Received: from localhost (unknown [10.72.116.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 73904492BD7;
	Thu, 22 Feb 2024 11:01:44 +0000 (UTC)
Date: Thu, 22 Feb 2024 19:01:41 +0800
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
Message-ID: <ZdcplT8Xb5eevu/9@MiWiFi-R3L-srv>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-8-kirill.shutemov@linux.intel.com>
 <ZdLjQCaxhOnR+GzX@MiWiFi-R3L-srv>
 <zhbhgq27kjrhkdgbxomjykjez2i4hckguvmxyptvfvoftue5ca@zowl5qbl6psl>
 <ZdR+JzfHjES3zytp@MiWiFi-R3L-srv>
 <ic4v3q4muffjq2jhlkk3k4lg5xxvjwlw22hctzubl5573euzu2@er3m7ztog2a6>
 <ZdVh6efExdt687YY@MiWiFi-R3L-srv>
 <p34d7e5r3gkcj2xl5jycyldvpkmcllmhzioaqcmseeugl3eq73@plk43dd4luzu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p34d7e5r3gkcj2xl5jycyldvpkmcllmhzioaqcmseeugl3eq73@plk43dd4luzu>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 02/21/24 at 04:15pm, Kirill A. Shutemov wrote:
> On Wed, Feb 21, 2024 at 10:37:29AM +0800, Baoquan He wrote:
> > > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > > index 3612e3167147..425ff6e192e6 100644
> > > --- a/arch/x86/mm/pat/set_memory.c
> > > +++ b/arch/x86/mm/pat/set_memory.c
> > > @@ -657,7 +657,8 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
> > >  
> > >  /*
> > >   * Lookup the page table entry for a virtual address in a specific pgd.
> > > - * Return a pointer to the entry and the level of the mapping.
> > > + * Return a pointer to the entry and the level of the mapping (or NULL if
> > > + * the entry is none) and level of the entry.
> >                        ^ this right parenthesis may need be moved to the end.
> > 
> > 
> > =======
> >  * Return a pointer to the entry and the level of the mapping (or NULL if
> >  * the entry is none and level of the entry).
> > =======
> 
> Emm.. I like my variant more. We return level regardless if the entry none
> or not. I don't see a reason to repeat it twice.


 * Lookup the page table entry for a virtual address in a specific pgd.
 * Return a pointer to the entry and the level of the mapping (or NULL if
 * the entry is none) and level of the entry.

Hmm, I am confused. Why do we need to stress the level of the mapping
and level of the entry? Wondering what is the difference. I must miss
something.


