Return-Path: <linux-kernel+bounces-65921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B458553C2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3204B2AA77
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE7C13EFFD;
	Wed, 14 Feb 2024 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="HYafmwXJ"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5185D1339B6
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941506; cv=none; b=UPHdVSt5NufGbsTvjmoFDMLbGGswKagLuUpPJlY4eyHdavkUcWXnqnLjggeca+g6QBzuQsyAF/EFYhaFPLleXYOtwVVlDyGE624mWR6SD66wECC/0vvTvhsR5NmdzQ6IvC0gFZm/cdzu41Eii32+U9wHuHtZB5G8LvCanRc05h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941506; c=relaxed/simple;
	bh=/ZuOsvm+ugjogtnQYauwuHlqII7gJDAvZenPphyeOTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZF0jPjTwM7U/km4t96Il84JKcpAWCvxd8NUa1mCZ+Vj0+ApOC6uTvvA+pKN/4dptknb19vpkK5Ms/ejsEDIDFyPbTL3YvK9ga9oQM087AfMoJ7YUc6v7zlf5Yd6y4MLIdg85v6FYLKTkIlXskouI1YpXaxK+9yd7yGN0f5SO6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=HYafmwXJ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-68.bstnma.fios.verizon.net [173.48.116.68])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41EKB3RJ014249
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 15:11:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1707941467; bh=k5ul52OyszAycDp6xjgdUU0Nu7SKg7gxDb+aIqrDSBI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=HYafmwXJAanqRV3F6Jate0WgDdcDRPu0pIFja/hMZ28tgviDD++OMeLTNtgf+HDeJ
	 g41VJSsjje70O+TtSvGgQ1OSBx0m2oWKYO9Pf147HSWu8t/LzCc/VTYuiA2tGhtM5+
	 HAbM079BjsaAfsog53B8U6O4ErXO7m75oiUv44cp0AvzWnXAsjqEqR+BI780qHpxAS
	 fBVDGT5UyKrSY7oqLRogQ/O/0Ioj1F/fCdhgbnW+wq/PuZghACzy7WhxoChc9lN2Kg
	 SIfQ4QOxdbsRv/dPGk8nzqjSzvup36ekL7oeNGK53dE4mC9arYgTApphkJNhJWOm00
	 iq+wXxg2vW8Ug==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 755B615C0336; Wed, 14 Feb 2024 15:11:03 -0500 (EST)
Date: Wed, 14 Feb 2024 15:11:03 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
Message-ID: <20240214201103.GD394352@mit.edu>
References: <20240131171042.GA2371371@mit.edu>
 <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
 <20240201045710.GD2356784@mit.edu>
 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
 <DM8PR11MB57503A2BB6F74618D64CC44AE74E2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Zcz2r51Tbb44ywjl@zx2c4.com>
 <696a5d98-b6a2-43aa-b259-fd85f68a5707@amd.com>
 <CAHmME9pzOTdkNr=mM7yKKqLWApQ5cxjvb7R9C2eQ2QFeUEqT6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9pzOTdkNr=mM7yKKqLWApQ5cxjvb7R9C2eQ2QFeUEqT6A@mail.gmail.com>

On Wed, Feb 14, 2024 at 09:04:34PM +0100, Jason A. Donenfeld wrote:
> AMD people, Intel people: what are the fullest statements we can rely
> on here? Do the following two statements work?
> 
> 1) On newer chips, RDRAND never fails.
> 2) On older chips, RDRAND never fails if you try 10 times in a loop,
> unless you consider host->guest attacks, which we're not, because CoCo
> is only a thing on the newer chips.
> 
> If those hold true, then the course of action would be to just add a
> WARN_ON(!ok) but keep the loop as-is.

I think we may only want to do the WARN_ON in early boot.  Otherwise,
on older chips, if a userspace process executes RDRAND is a tight
loop, it might cause the WARN_ON to trigger, which is considered
undesirable (and is certainly going to be something that could result
in a syzbot complaint).

					- Ted

