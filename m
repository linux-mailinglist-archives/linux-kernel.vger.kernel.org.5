Return-Path: <linux-kernel+bounces-54978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A984184B5CB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2271F265AC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9596A12FF72;
	Tue,  6 Feb 2024 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyqXYk6y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E2912EBEB
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224418; cv=none; b=uczHD4u0Lh+W1CDi1KMyUggmOyqKxSI939lyz6EdWQGvyjjArik2+kpaNPZebXs6k73AWScIsYQY40mJ2B8UimKhnumgeYOw3heiPWI6B7m0twc+OEnQGhBNAso6CFOr2u/OoENk50SsbRJN4/Qks1SXwgrb42ZAqCzNgUYRya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224418; c=relaxed/simple;
	bh=abe9E3ueQx9G2fBlwjT7LMFmPpMhp9/GiSVQD4q8kh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Idn8XcLFXM8p9ebgleljUTmyyFSDWPBu15OKA7aU0Ak/dL//1FXMGiE956dda1F3wWhIeSjluAsbfI2bfYh461PUvQDHl32HpwJjN5yrFm/XWI0HjgDpevM6QznDlTlDgrjsbfMwLAiBKKLIb7UnlJzVQrjwqFXffc9i5kmJPvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EyqXYk6y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707224416;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=cmGxWZhgjlISLF6/RimgbvtGqlUWWkI9oFgV/zY1qL0=;
	b=EyqXYk6yMaEvdhGp1PjIypZEd/lvO/gPE5/oTHRNUxqNB4HfGcL4t0NmsbVJMk7HX9QhEr
	8gRfbvGseuDrqAQAYp13WLEvPxIKlAdFGwwQktt+vaIBzdsMDK4INRzzxfBVvzdzA4f6wR
	A9buZUHP3urx7cmhL+s8K779joKmivM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-OMpscAT4PcKefY_O_GnelQ-1; Tue, 06 Feb 2024 08:00:09 -0500
X-MC-Unique: OMpscAT4PcKefY_O_GnelQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE4E483B828;
	Tue,  6 Feb 2024 13:00:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DFDC1121312;
	Tue,  6 Feb 2024 13:00:05 +0000 (UTC)
Date: Tue, 6 Feb 2024 13:00:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. Greg" <greg@enjellic.com>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
Message-ID: <ZcItU5FKlIVEEVte@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20240130083007.1876787-2-kirill.shutemov@linux.intel.com>
 <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com>
 <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com>
 <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com>
 <Zbk6h0ogqeInLa_1@redhat.com>
 <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240206011247.GA29224@wind.enjellic.com>
 <ZcHoKUElwXGPzrWb@redhat.com>
 <20240206120445.GA1247@wind.enjellic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206120445.GA1247@wind.enjellic.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Tue, Feb 06, 2024 at 06:04:45AM -0600, Dr. Greg wrote:
> On Tue, Feb 06, 2024 at 08:04:57AM +0000, Daniel P. Berrang?? wrote:
> 
> Good morning to everyone.
> 
> > On Mon, Feb 05, 2024 at 07:12:47PM -0600, Dr. Greg wrote:
> > > 
> > > Actually, I now believe there is clear evidence that the problem is
> > > indeed Intel specific.  In light of our testing, it will be
> > > interesting to see what your 'AR' returns with respect to an official
> > > response from Intel engineering on this issue.
> > > 
> > > One of the very bright young engineers collaborating on Quixote, who
> > > has been following this conversation, took it upon himself to do some
> > > very methodical engineering analysis on this issue.  I'm the messenger
> > > but this is very much his work product.
> > > 
> > > Executive summary is as follows:
> > > 
> > > - No RDRAND depletion failures were observable with either the Intel
> > >   or AMD hardware that was load tested.
> > > 
> > > - RDSEED depletion is an Intel specific issue, AMD's RDSEED
> > >   implementation could not be provoked into failure.
> 
> > My colleague ran a multithread parallel stress test program on his
> > 16core/2HT AMD Ryzen (Zen4 uarch) and saw a 80% failure rate in
> > RDSEED.
> 
> Interesting datapoint, thanks for forwarding it along, so the issue
> shows up on at least some AMD platforms as well.
> 
> On the 18 core/socket Intel Skylake platform, the parallelized
> depletion test forces RDSEED success rates down to around 2%.  It
> would appear that your tests suggest that the AMD platform fairs
> better than the Intel platform.

Yes, given the speed of the AMD RDRAND/RDSEED ops, compared to my
Intel test platforms, their DRBG looks better able to keep up with
the demand for bits.

> Of course, the other variable may be how the parallelized stress test
> is conducted.  If you would like to share your implementation source
> we could give it a twirl on the systems we have access to.

It is just Jason's earlier test program, but moved into one thread
for each core....

$ cat cpurngstress.c
#include <stdio.h>
#include <immintrin.h>
#include <pthread.h>
#include <unistd.h>

/*
 * Gives about 25 seconds walllock time on my Alderlake CPU
 *
 * Probably want to reduce this x10, or possibly even x100
 * on AMD due to much slower ops.
 */
#define MAX_ITER 10000000

#define MAX_CPUS 4096

void *doit(void *f) {
    unsigned long long rand;
    unsigned int i, success_rand = 0, success_seed = 0;

    for (i = 0; i < MAX_ITER; ++i) {
        success_seed += !!_rdseed64_step(&rand);
    }
    for (i = 0; i < MAX_ITER; ++i) {
        success_rand += !!_rdrand64_step(&rand);
    }

    fprintf(stderr,
	    "RDRAND: %.2f%%, RDSEED: %.2f%%\n",
	    success_rand * 100.0 / MAX_ITER,
	    success_seed * 100.0 / MAX_ITER);

    return NULL;
}


int main(int argc, char *argv[])
{
    pthread_t th[MAX_CPUS];
    int nproc = sysconf(_SC_NPROCESSORS_ONLN);
    if (nproc > MAX_CPUS) {
      nproc = MAX_CPUS;
    }
    fprintf(stderr, "Stressing RDRAND/RDSEED across %d CPUs\n", nproc);

    for (int i = 0 ; i < nproc;i ++) {
      pthread_create(&th[i], NULL, doit,NULL);
    }

    for (int i = 0 ; i < nproc;i ++) {
      pthread_join(th[i], NULL);
    }

    return 0;
}

$ gcc -march=native -o cpurngstress cpurngstress.c


> If there is the possibility of over-harvesting randomness, why not
> design the implementations to be clamped at some per core value such
> as a megabit/second.  In the case of the documented RDSEED generation
> rates, that would allow the servicing of 3222 cores, if my math at
> 0530 in the morning is correct.
> 
> Would a core need more than 128 kilobytes of randomness, ie. one
> second of output, to effectively seed a random number generator?
> 
> A cynical conclusion would suggest engineering acquiesing to marketing
> demands... :-)

My assumption is that it was simply easier to not implement a
rate limiting feature at the CPU level and punt the starvation
problem to software :-)

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


