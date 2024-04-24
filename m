Return-Path: <linux-kernel+bounces-157169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C81878B0DAE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A971B29C35
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F82A15F303;
	Wed, 24 Apr 2024 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pVGfFKG4"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6789915E1F5;
	Wed, 24 Apr 2024 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971511; cv=none; b=Ud+9JIN1MmQ7bBg8KLh76roaxbGOItIYCrvaADoRzlCWXtz3RArD3rU6DMC1OpYI+7uzUo6yjEZh2mlbCSMn+XNfIzcw7EI6nayLeDzbSiDPjOMoF+ap9LmR1755PQPHKhZa6RvZC3Hcb+Q33MRzFWVkzXk8wcS9qZAqRkd5AeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971511; c=relaxed/simple;
	bh=sGf5KeOvU8gGZ4+R+esrn6WEfp7xeYgJH0s+dTSO4k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbuVApypUTlkK1cVyIyNSBOf2MYlnYil1OTuuyfPw+zhsTmR4i1YkL9suv/7vGU/fRVgWouA7TCbHLlmsI+fI48I8WWCvXtMEoIXQ4h4TIDunxOWO19rsy6u1Mny1xoSKlqb5C3IICf4MnGvJE+l73CZmIub4Me9tTMuxFWO63Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pVGfFKG4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EkBE66CT6crj6GkqyX5V53CXIn7FtqQLU888aU+APFw=; b=pVGfFKG43UpmS74CNpKosVr5aW
	DiWq78bfE/4XpvD6h++sMM7pvdJKjA8UOxzoT7aLqgK7wZaHJ+nbEA3Nc9XKmElw8EL6cEbeyoIIm
	ccRUoz7uUY0OrHfgDHqvVw1lXK7iT7mUgNT1EQzTmRxqscWpsG207rz33DabNMrsUc9mar0BuL5Ku
	0PG8jBvtTxrk8wl80BfvKMLzUlsffHyjR/9ZpZveIqAVomDlFkK8mQzDaUM8LzboXOzb/rdONx1SY
	YFFTBziyw63gs/sXKceSMYFTE1TRYwUIdqMtNrY/bXgCF31DJfi6cJPV3sC8K5+u/BVX9o77r5qE1
	O78+0gHA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzeHV-000000018cB-3diq;
	Wed, 24 Apr 2024 15:11:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8368C30043E; Wed, 24 Apr 2024 17:11:33 +0200 (CEST)
Date: Wed, 24 Apr 2024 17:11:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH V2 04/19] math64: Tidy mul_u64_u32_shr()
Message-ID: <20240424151133.GR30852@noisy.programming.kicks-ass.net>
References: <20240325064023.2997-1-adrian.hunter@intel.com>
 <20240325064023.2997-5-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325064023.2997-5-adrian.hunter@intel.com>

On Mon, Mar 25, 2024 at 08:40:08AM +0200, Adrian Hunter wrote:
> Put together declaration and initialization of local variables.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---

Nothing wrong with this patch, but it is highly unlikely this code is
actually tested much. Most (sane) architectures will use the __int128
version.

>  include/linux/math64.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/include/linux/math64.h b/include/linux/math64.h
> index bf74478926d4..fd13622b2056 100644
> --- a/include/linux/math64.h
> +++ b/include/linux/math64.h
> @@ -179,16 +179,12 @@ static __always_inline u64 mul_u64_u64_shr(u64 a, u64 mul, unsigned int shift)
>  #ifndef mul_u64_u32_shr
>  static __always_inline u64 mul_u64_u32_shr(u64 a, u32 mul, unsigned int shift)
>  {
> -	u32 ah, al;
> +	u32 ah = a >> 32, al = a;
>  	u64 ret;
>  
> -	al = a;
> -	ah = a >> 32;
> -
>  	ret = mul_u32_u32(al, mul) >> shift;
>  	if (ah)
>  		ret += mul_u32_u32(ah, mul) << (32 - shift);
> -
>  	return ret;
>  }
>  #endif /* mul_u64_u32_shr */
> -- 
> 2.34.1
> 

