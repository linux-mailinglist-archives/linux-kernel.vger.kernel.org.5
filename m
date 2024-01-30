Return-Path: <linux-kernel+bounces-45078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F7A842B72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47341F24262
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BF6155A4D;
	Tue, 30 Jan 2024 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bkIyaz+F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3E186AEB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637975; cv=none; b=awi2QdxQDM2ci5Xo3nJC2vLy658ximGPBxoFPeu/lyIt/IQ+gPgKJSuC9+s3lRjfGWULT4+4rwLryS7LHdsz7a7fM577fDrI6FR8gUfYVNqc0hkIqj1uKAw9Kqlid1OUvTXxSh2/leXTenzzAIh5fIZ0FUHA/nh8R6GE9LUEyJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637975; c=relaxed/simple;
	bh=zkh4gbx/89GnNbOgA+ve9IJXox6oRxmTjSJ398w+CDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihLgACZp2VGjGioVgzS1BJT0d8hT2C6xOaNZxD0dKct9vKQIfdS5EX58jFPs53qImRS0UDRiwxCAIIU13NbW+hDB7fa7Axx4acYmyynWq7xiA8h332SAFV7ZUWEIFVgkw8ggDro8xMlG/4VZNTj0PBjGBjUBUwFYW6/ALiSP4As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bkIyaz+F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706637972;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6NBBIOV0mk2VOcCkKd1idr5TUMKX7QhfRR0ebMmJ3Y=;
	b=bkIyaz+FogO8emnnMnEXY0vuqJAyaJp8hYt0R5BUB7Z9YbEm5Yb8rLqUgyLfrwOklp4QUN
	WVc6VmWY2qZM9Nh796YKoYEPjMlETLOqrVzhLULB6+ua+7heEKrwFdeeiR7RY/s7bZudvV
	FO8Wba1+FTdEy1kxVoZV0iw/mBCILcc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-aQRKw9BIOK-k7XQnCGSVeg-1; Tue, 30 Jan 2024 13:06:09 -0500
X-MC-Unique: aQRKw9BIOK-k7XQnCGSVeg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A5D1185A787;
	Tue, 30 Jan 2024 18:06:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 28B4A1C060B1;
	Tue, 30 Jan 2024 18:06:02 +0000 (UTC)
Date: Tue, 30 Jan 2024 18:05:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
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
Message-ID: <Zbk6h0ogqeInLa_1@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <20240130083007.1876787-2-kirill.shutemov@linux.intel.com>
 <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com>
 <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com>
 <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Tue, Jan 30, 2024 at 06:49:15PM +0100, Jason A. Donenfeld wrote:
> On Tue, Jan 30, 2024 at 6:32 PM Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 1/30/24 05:45, Reshetova, Elena wrote:
> > >> You're the Intel employee so you can find out about this with much
> > >> more assurance than me, but I understand the sentence above to be _way
> > >> more_ true for RDRAND than for RDSEED. If your informed opinion is,
> > >> "RDRAND failing can only be due to totally broken hardware"
> > > No, this is not the case per Intel SDM. I think we can live under a simple
> > > assumption that both of these instructions can fail not just due to broken
> > > HW, but also due to enough pressure put into the whole DRBG construction
> > > that supplies random numbers via RDRAND/RDSEED.
> >
> > I don't think the SDM is the right thing to look at for guidance here.
> >
> > Despite the SDM allowing it, we (software) need RDRAND/RDSEED failures
> > to be exceedingly rare by design.  If they're not, we're going to get
> > our trusty torches and pitchforks and go after the folks who built the
> > broken hardware.
> >
> > Repeat after me:
> >
> >         Regular RDRAND/RDSEED failures only occur on broken hardware
> >
> > If it's nice hardware that's gone bad, then we WARN() and try to make
> > the best of it.  If it turns out that WARN() was because of a broken
> > hardware _design_ then we go sharpen the pitchforks.
> >
> > Anybody disagree?
> 
> Yes, I disagree. I made a trivial test that shows RDSEED breaks easily
> in a busy loop. So at the very least, your statement holds true only
> for RDRAND.
> 
> But, anyway, if the statement "RDRAND failures only occur on broken
> hardware" is true, then a WARN() in the failure path there presents no
> DoS potential of any kind, and so that's a straightforward conclusion
> to this discussion. However, that really hinges on  "RDRAND failures
> only occur on broken hardware" being a true statement.

There's a useful comment here from an Intel engineer

https://web.archive.org/web/20190219074642/https://software.intel.com/en-us/blogs/2012/11/17/the-difference-between-rdrand-and-rdseed

  "RDRAND is, indeed, faster than RDSEED because it comes
   from a hardware-based pseudorandom number generator.
   One seed value (effectively, the output from one RDSEED
   command) can provide up to 511 128-bit random values
   before forcing a reseed"

We know we can exhaust RDSEED directly pretty trivially. Making your
test program run in parallel across 20 cpus, I got a mere 3% success
rate from RDSEED.

If RDRAND is reseeding every 511 values, RDRAND output would have
to be consumed significantly faster than RDSEED in order that the
reseed will happen frequently enough to exhaust the seeds.

This looks pretty hard, but maybe with a large enough CPU count
this will be possible in extreme load ?

So I'm not convinced we can blindly wave away RDRAND failures as
guaranteed to mean broken hardware.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


