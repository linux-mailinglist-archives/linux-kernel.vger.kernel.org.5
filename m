Return-Path: <linux-kernel+bounces-54470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 330A984AF98
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00201F23294
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC5612B179;
	Tue,  6 Feb 2024 08:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjRlTHnf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D3D12B16D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707206714; cv=none; b=XmQjHJUVnCPYsSD41t11pgtpXtdvlr7hyGewh3ZEKOH+03PI4nxXI0DYxMM/peG49NLHtaq4WkXdFjvw3l5nATgFm/3dezFTYDf+eCSCzSwDBqh1MB3LJye2tr7KnICL6NDjsuCizAaUICSKa14nPh9uefiZlsEiHGdSy6ckZbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707206714; c=relaxed/simple;
	bh=MsHf8cVdpuCFq4ctLxFOemRpS5F5u/extnlTkO7PvNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsE5qdXaOJaKCcgniG9zTek8UQ5RgiQMC5R+OYeERsbXfmhjMv/0b18UUW/1rjiEh433FiGf8XAibPigfzvgD9KBDiSmgaFhTGCxNKq9+hifxY84PZ8EwsKaUAcgnbIGKq/ocY2CrWhm+1R7QDKbQV9F9hZtFnDxwgkk84rWZME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjRlTHnf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707206712;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=VoG77iC4V8mtXCplQh9IiWyiocJNF7CpVFSOwa43ZiE=;
	b=WjRlTHnfXWY6Vw1QFvsuI4gM4LxpnlFzEuZ0IlNj+I56ctkg4dlUj8GOSkp+0+xspPEOft
	8VoTowKv6KACm4BGbf0227CgLXvXtnwd5u8ureQKMzkvpwXqAcMNqEmket6BOT0ThY7lX+
	cQVR67sxQcosonnLm+zgvIQwQPsaKLk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-IXlGMc1pNmqu9FkmToUdZQ-1; Tue, 06 Feb 2024 03:05:06 -0500
X-MC-Unique: IXlGMc1pNmqu9FkmToUdZQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85A4085A588;
	Tue,  6 Feb 2024 08:05:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AECA02166B32;
	Tue,  6 Feb 2024 08:05:00 +0000 (UTC)
Date: Tue, 6 Feb 2024 08:04:57 +0000
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
Message-ID: <ZcHoKUElwXGPzrWb@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <20240130083007.1876787-2-kirill.shutemov@linux.intel.com>
 <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com>
 <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com>
 <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com>
 <Zbk6h0ogqeInLa_1@redhat.com>
 <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240206011247.GA29224@wind.enjellic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206011247.GA29224@wind.enjellic.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Mon, Feb 05, 2024 at 07:12:47PM -0600, Dr. Greg wrote:
> 
> Actually, I now believe there is clear evidence that the problem is
> indeed Intel specific.  In light of our testing, it will be
> interesting to see what your 'AR' returns with respect to an official
> response from Intel engineering on this issue.
> 
> One of the very bright young engineers collaborating on Quixote, who
> has been following this conversation, took it upon himself to do some
> very methodical engineering analysis on this issue.  I'm the messenger
> but this is very much his work product.
> 
> Executive summary is as follows:
> 
> - No RDRAND depletion failures were observable with either the Intel
>   or AMD hardware that was load tested.
> 
> - RDSEED depletion is an Intel specific issue, AMD's RDSEED
>   implementation could not be provoked into failure.

My colleague ran a multithread parallel stress test program on
his 16core/2HT AMD Ryzen (Zen4 uarch) and saw a 80% failure rate
in RDSEED.

> - AMD's RDRAND/RDSEED implementation is significantly slower than
>   Intel's.

Yes, we also noticed the AMD impl is horribly slow compared to Intel,
had to cut test iterations x100

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


