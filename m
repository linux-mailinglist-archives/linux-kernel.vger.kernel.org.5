Return-Path: <linux-kernel+bounces-44765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBCE842717
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00EE1F284A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5567C0B1;
	Tue, 30 Jan 2024 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpP07AUB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B86C846B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625811; cv=none; b=JuGtalHhS/VnZXdpm8fTYcLCO3xPMeoBQI9uoeKzjeEUglp8HMpzmkXSSi4WTULaSqD3iNOPNUjkC/dHUU/+mDI7zNDkoRQJpcJJCBpY9Bkp9Ic/ICnPAalSAOOYQLGTgKKB1I7Htc8zSGCo3UARcto6vv+gq77AVIUD/sVSIgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625811; c=relaxed/simple;
	bh=/5SL87WwijxzN6C1Ml+S3tPaPqexhCvXWCZXZXhoHiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3V8CjdEyDrYcYLtsvup+O8BGU7eJx+Wen/4J/R4V9xLEa9irQTSh2HiWzmaNR9/BRc4iS5Db+KvVRCdIw/j//kVJfvxBZOUa14YqErvFEWJjhb6K5hSymZPdjKC2vSamGzDFV91B8jv5/ZzMwRnWJvq0uiJlIuvzNi2Zl9tFwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FpP07AUB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706625808;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=jRW+7BPDkpJOfSPsAAPyhv359GDriIgfSBM3vPDMKM4=;
	b=FpP07AUBh2CO7zF5bqa2ciVEjUvO0pJsVruGKl3ct2wZyIaoJb+fxrEykCc4Lxi96Hp0hD
	qSgLKy+nDSwVavbvvSKw0miKcva9a1SeyuiJj5lFAv98eN8r55DQJ/zWcNGJsNz4b6AWY9
	bS584dX9QlCnAWZLCo4O40OXytCAFqY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-EpcxHYDJM0uAtLf6ZZO_-g-1; Tue, 30 Jan 2024 09:43:25 -0500
X-MC-Unique: EpcxHYDJM0uAtLf6ZZO_-g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76C2384AE41;
	Tue, 30 Jan 2024 14:43:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 18D4440C122E;
	Tue, 30 Jan 2024 14:43:21 +0000 (UTC)
Date: Tue, 30 Jan 2024 14:43:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>,
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
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
Message-ID: <ZbkLBwLlTNMFZ-2B@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <CAHmME9pOt=uEmuBzBpgUHw9DqAD2FZTZ3v53AOZbQ3Cd2p97xQ@mail.gmail.com>
 <DM8PR11MB5750E38A8B2BCE66AF7F9812E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9qMO7=RDR60bKJvpDTRokcKed_i0+7BbFD53_7o2OJ6-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9qMO7=RDR60bKJvpDTRokcKed_i0+7BbFD53_7o2OJ6-g@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Tue, Jan 30, 2024 at 03:06:14PM +0100, Jason A. Donenfeld wrote:
> Is that an accurate summary? If it is, then the actual problem is that
> the hardware provided to solve this problem doesn't actually solve it
> that well, so we're caught deciding between guest-guest DoS (some
> other guest on the system uses all RDRAND resources) and cryptographic
> failure because of a malicious host creating a deterministic
> environment.

In a CoCo VM environment, a guest DoS is not a unique threat
scenario, as it is unrelated to confidentiality. Ensuring
fair subdivision of resources between competeing guests is
just a general VM threat. There are many easy ways a host
admin can stop a guest making computational progress. Simply
not scheduling the guest vCPU threads is one. CoCo doesn't
try to solve this problem.

Preserving confidentiality is the primary aim of CoCo.

IOW, if the guest boot is stalled because the kernel is spinning
waiting on RDRAND to return data, that's fine. If the kernel
panics after "n" RDRAND failures in a row that's fine too. They
are both just yet another DoS scenario. 

If the kernel ignores the RDRAND failure and lets it boot with
degraded RNG state there were susceptible to attacks, that would
not be OK for CoCo. 

> But I have two questions:
> 
> 1) Is this CoCo VM stuff even real? Is protecting guests from hosts
> actually possible in the end? Is anybody doing this? I assume they
> are, so maybe ignore this question, but I would like to register my
> gut feeling that on the Intel platform this seems like an endless
> whack-a-mole problem like SGX.

It is real, but it is also not perfect. I expect it /will/ be an
endless whack-a-mole problem though.

None the less, it is a significant layer of defence, as compared
to traditional VMs where the guest RAM is nothing more than a
'cat' command away from host admin exposure.

> 2) Can a malicious host *actually* create a fully deterministic
> environment? One that'll produce the same timing for the jitter
> entropy creation, and all the other timers and interrupts and things?
> I imagine the attestation part of CoCo means these VMs need to run on
> real Intel silicon and so it can't be single stepped in TCG or
> something, right? So is this problem actually a real one? And to what
> degree? Any good experimental research on this?
> 
> Either way, if you're convinced RDRAND is the *only* way here, adding
> a `WARN_ON(is_in_early_boot)` to the RDRAND (but not RDSEED) failure
> path seems a fairly lightweight bandaid. I just wonder if the hardware
> people could come up with something more reliable that we wouldn't
> have to agonize over in the kernel.

If RDRAND failure is more of a theoretical problem than a practical
real world problem, I'd be inclined to just let the kernel loop on
RDRAND failure until it suceeds, with a WARN after 'n' iterations to
aid diagnosis of the stall in the unlikely even it did hit.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


