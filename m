Return-Path: <linux-kernel+bounces-73028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C4185BC50
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4FB1F23EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8783060867;
	Tue, 20 Feb 2024 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+cvAyCi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A135B5CE
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432616; cv=none; b=JhzPN6I8+Tj2RxrPOMZIKZIEOW5Moe0YFWWf6JiDsjSJ6xez8nXsdL3uHQE6O5n+DYZ/o1Onu/VAkSUuAiEvGUtkeVOpNIRUVM04d2tuoAYo7WXLq04/55hSdKhioZOhyZ5dciWta44Nfkug63o9DSaA8yEXjnXLRA87BuM0n3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432616; c=relaxed/simple;
	bh=iNBAnZuBMR9OpFb371kjh23uca3k0nUqZwIq/GwOHag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeVNYc2mvNAkq3iktLP2ZICd9ZZp5ka68YEqk0cF7CPsgQXDA0lpBmVyOguXIGZ+xDdmJ+IecC7dQuqhMOBBI/7XrhwwD0QCKyV3QU9zo/MOYCxM3eiZSwM3fxNqU+ldNCZRufN3FPuPHswYX2K4NGJZXWeEycOEl0OcqyjEqQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+cvAyCi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708432615; x=1739968615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iNBAnZuBMR9OpFb371kjh23uca3k0nUqZwIq/GwOHag=;
  b=j+cvAyCiqxCy8DpmyDqx8X2VDyDElKFIRVQ/yEcOwYEBKUUIdqxofUdo
   nis0wAiLBLZOQTQzr9njWjXfGhPkHn9qfi+xqfKhUtj3CCKO6oHRmJag3
   Yi0ZqiAnyD6qPYYzprpqFUGqZZeSxopaARlirK/yW+mGmj/aCoRQM6/2d
   O7LxRxprmbcvaekKvzN5HgUdhOosRVD3TEsL5dTqoTGA9Cdm49jDfjTSf
   Brus8vOFM1IMmRedHLU1yQ5W1agpFrr1iC5PZPnWXd6Lgx8jGfllC8bqW
   LTzC3yfACGlMQkWYU22tvVb32V74pJ9fVuNp85Nfk5mDI3ahN17sX/NbC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2395636"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2395636"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 04:36:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="936448238"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="936448238"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2024 04:36:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id D0CCE305; Tue, 20 Feb 2024 14:36:48 +0200 (EET)
Date: Tue, 20 Feb 2024 14:36:48 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 07/16] x86/mm: Return correct level from
 lookup_address() if pte is none
Message-ID: <ic4v3q4muffjq2jhlkk3k4lg5xxvjwlw22hctzubl5573euzu2@er3m7ztog2a6>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-8-kirill.shutemov@linux.intel.com>
 <ZdLjQCaxhOnR+GzX@MiWiFi-R3L-srv>
 <zhbhgq27kjrhkdgbxomjykjez2i4hckguvmxyptvfvoftue5ca@zowl5qbl6psl>
 <ZdR+JzfHjES3zytp@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdR+JzfHjES3zytp@MiWiFi-R3L-srv>

On Tue, Feb 20, 2024 at 06:25:43PM +0800, Baoquan He wrote:
> > I am not sure what part of the comment you see doesn't reflect the
> > behaviour. From my PoV, changed code matches the comment closer that
> > original.
> 
> Oh, I didn't make it clear. I mean update the code comment for
> lookup_address(), and add code comment for lookup_address_in_pgd() to
> mention the level thing. Maybe it's a chance to do that.
> 
> ===1>
> *
>  * Lookup the page table entry for a virtual address. Return a pointer
>  * to the entry and the level of the mapping.
>  *
>  * Note: We return pud and pmd either when the entry is marked large
>                    ~~~~~~~~~~~ seems we return p4d too
>  * or when the present bit is not set. Otherwise we would return a
>  * pointer to a nonexisting mapping.
>               ~~~~~~~~~~~~~~~ NULL?
>  */                          
> pte_t *lookup_address(unsigned long address, unsigned int *level)
> {
>         return lookup_address_in_pgd(pgd_offset_k(address), address, level);
> }
> EXPORT_SYMBOL_GPL(lookup_address);
> ===
> 
> ===2>
> /*
>  * Lookup the page table entry for a virtual address in a specific pgd.
>  * Return a pointer to the entry and the level of the mapping.
>    ~~ also could return NULL if it's none entry. And do we need to
> mention the level thing?
>  */
> pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
>                              unsigned int *level)
> ...
> }
> 

What about this fixup:

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 3612e3167147..425ff6e192e6 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -657,7 +657,8 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 
 /*
  * Lookup the page table entry for a virtual address in a specific pgd.
- * Return a pointer to the entry and the level of the mapping.
+ * Return a pointer to the entry and the level of the mapping (or NULL if
+ * the entry is none) and level of the entry.
  */
 pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 			     unsigned int *level)
@@ -704,9 +705,8 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
  * Lookup the page table entry for a virtual address. Return a pointer
  * to the entry and the level of the mapping.
  *
- * Note: We return pud and pmd either when the entry is marked large
- * or when the present bit is not set. Otherwise we would return a
- * pointer to a nonexisting mapping.
+ * Note: the function returns p4d, pud and pmd either when the entry is marked
+ * large or when the present bit is not set. Otherwise it returns NULL.
  */
 pte_t *lookup_address(unsigned long address, unsigned int *level)
 {
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

