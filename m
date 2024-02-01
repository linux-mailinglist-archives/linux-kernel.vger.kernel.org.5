Return-Path: <linux-kernel+bounces-48000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B368455FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E2528F975
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFAE15CD40;
	Thu,  1 Feb 2024 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F6O+QLgS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E382615B11A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706785708; cv=none; b=Kib4zGMCS8LXw3Dhgqc+JCRGkVZDJRhmwL95cajS6469AGrRCPA7CzuS8Apodyayb6dlBVMVvUb6XAJ4PApMddSJWB1/rGMAtJ5lOLIq9frRS08aEplRu05MwVlrEIzloj4gxLUj+SvcnmthXJfS3iFhuOcRG2fy96mb+y7h4o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706785708; c=relaxed/simple;
	bh=KfgcXYo0f/Af5r4OvmqFwbexL3jInyqjg5dLZ2bl3Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyxOAkwdaT79MpSGij3em6DamqtVAnnIrsLVxCOAYWjNlEg/8x52VX6KELT8/Uy3aWIyLvynnL1pBdewGH/XxLoiK8NX4SC5D9/GxA1oLYGGnbzIxBKpu+1o3Ypx74lDereYM5T2eA7fu5iS4DZXBoPhm3WFV0w51nCrFPUMROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F6O+QLgS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706785705;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=iqZ5JRJy43iWfp90Eqz1PBQSxSigu8T95uN4/9prhd8=;
	b=F6O+QLgSJx7e+yIH4EOit5qdwiRzSk1d8z+qoHiV34r94nwuhsKZtro1vWftiNNF/qwyjc
	uAig9AfdI7hlOuyHbPLa1EG8vhd06l98BGy0etHEn31LE4vlYWcuaNEKU0gDrsHmLjv7TA
	kdDdQNu22vpTs/KSfNyW02SSgqJN2+c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-Qiq-GBI2P5adnKvT_dnxVg-1; Thu,
 01 Feb 2024 06:08:19 -0500
X-MC-Unique: Qiq-GBI2P5adnKvT_dnxVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7D6F3C0BE48;
	Thu,  1 Feb 2024 11:08:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EF1682166B34;
	Thu,  1 Feb 2024 11:08:15 +0000 (UTC)
Date: Thu, 1 Feb 2024 11:08:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. Greg" <greg@enjellic.com>
Cc: Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"Hansen, Dave" <dave.hansen@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
Message-ID: <Zbt7mXg9p6IOdcqp@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com>
 <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com>
 <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com>
 <Zbk6h0ogqeInLa_1@redhat.com>
 <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9ps6W5snQrYeNVMFgfhMKFKciky=-UxxGFbAx_RrxSHoA@mail.gmail.com>
 <20240131203531.GA12035@wind.enjellic.com>
 <20240201044735.GC2356784@mit.edu>
 <20240201095451.GA17612@wind.enjellic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240201095451.GA17612@wind.enjellic.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Thu, Feb 01, 2024 at 03:54:51AM -0600, Dr. Greg wrote:
> I suspect that the achievable socket core count cannot effectively
> overwhelm the 1022x amplification factor inherent in the design of the
> RDSEED based seeding of RDRAND.

In testing I could get RDSEED down to < 3% success rate when
running on 20 cores in parallel on a laptop class i7. If that
failure rate can be improved by a little more than one order
of magnitude to 0.1% we're starting to get to the point where
it might be enough to make RDRAND re-seed fail.

Intel's Sierra Forest CPUs are said to have a variant with 288
cores per socket, which is an order of magnitude larger. It is
conceivable this might be large enough to demonstrate RDRAND
failure in extreme load. Then again who knows what else has
changed that might alter the equation, maybe the DRBG is also
better / faster. Only real world testing can say for sure.
One thing is certain though, core counts per socket keep going
up, so the potential worst case load on RDSEED will increase...

> We will see if Elena can come up with what Intel engineering's
> definition of 'astronomical' is.. :-)
> 
> > There's a special case with Confidential Compute VM's, since the
> > assumption is that you want to protect against even a malicious
> > hypervisor who could theoretically control all other sources of
> > timing uncertainty.  And so, yes, in that case, the only thing we
> > can do is Panic if RDRAND fails.
> 
> Indeed.
> 
> The bigger question, which I will respond to Elena with, is how much
> this issue calls the entire question of confidential computing into
> question.

A denial of service (from a panic on RDRAND fail) doesn't undermine
confidental computing. Guest data confidentiality is maintained by
panicing on RDRAND failure and DoS protection isn't a threat that CC
claims to be able to mitigate in general.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


