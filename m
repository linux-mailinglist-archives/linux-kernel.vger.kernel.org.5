Return-Path: <linux-kernel+bounces-22403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17B7829D37
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946B01C2201F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A940D4BAB6;
	Wed, 10 Jan 2024 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TU9tom3t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LE8tyCvo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0EE4A99D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704899655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DYxPD8fW6h0wbUUVw6JrkcqjQHlAPF5MkYZvHwp5j/I=;
	b=TU9tom3tTpdrkhNIJmNMPy4y9LPdmMMSH8yUM2P8PmJLU5qUEodyIh/PEZsMJBCerSJnAC
	gBzL+5wj9416oW7jUHqqZJbrkzGiOTWJq0wd0j4emI/wlpq7JOAZuYOyJbAbHKYEuwQGef
	vl57Rk6mBG7PZFbINihwfqzMkkUpVd+jemUz5rjXHYipmAGPqYuyHjeVMw0Ca0O3qz7Qcp
	x+cyCvcRDEVIOi3IOwqMfYHlWHeTdEOdFlsMrNl6n9rWsVtESqyggtUd8za/1plTEpHRgI
	3HoKbFSGy73uKQ1W/S0PbQH32UNZtN8IeQbFqlLmWkAsG0UlMSwjCNgIm2IOHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704899655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DYxPD8fW6h0wbUUVw6JrkcqjQHlAPF5MkYZvHwp5j/I=;
	b=LE8tyCvoVRPo6vazb4xNYFvY4Hkp5+yJNjMVDjlxDfjFihA9xBiQQoSvzM5Oc8b6BT9kKU
	jss/dlBJ4tMtoHBw==
To: "Zhang, Rui" <rui.zhang@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Cc: "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>,
 "arjan@linux.intel.com" <arjan@linux.intel.com>, "kprateek.nayak@amd.com"
 <kprateek.nayak@amd.com>, "Tang, Feng" <feng.tang@intel.com>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "ray.huang@amd.com"
 <ray.huang@amd.com>, "andrew.cooper3@citrix.com"
 <andrew.cooper3@citrix.com>, "Sivanich, Dimitri"
 <dimitri.sivanich@hpe.com>, "paulmck@kernel.org" <paulmck@kernel.org>,
 "Mehta, Sohil" <sohil.mehta@intel.com>, "andy@infradead.org"
 <andy@infradead.org>
Subject: Re: [patch 37/53] x86/cpu: Detect real BSP on crash kernels
In-Reply-To: <87frz5jmnl.ffs@tglx>
References: <20230807130108.853357011@linutronix.de>
 <20230807135028.381851690@linutronix.de>
 <7443f3200ef0be756566059e8c9b0657f3cefcff.camel@intel.com>
 <871qarlvub.ffs@tglx> <87y1czkdlg.ffs@tglx>
 <ff58623cdf63dc75fc245fd18ee776465f4bb3b8.camel@intel.com>
 <87frz5jmnl.ffs@tglx>
Date: Wed, 10 Jan 2024 16:14:15 +0100
Message-ID: <87a5pdjk54.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 10 2024 at 15:19, Thomas Gleixner wrote:
>> This is the order in MADT,
>> $ cat apic.dsl  | grep x2Apic
>> [030h 0048   4]          Processor x2Apic ID : 00000010
>> [040h 0064   4]          Processor x2Apic ID : 00000011
..
>> and this is the order in Linux (from CPU0 to CPUN)
>>       x2APIC ID of logical processor = 0x20 (32)
>>       x2APIC ID of logical processor = 0x10 (16)
>
> What a mess...

And clearly not according to the spec

  "The second is that platform firmware should list the boot processor
   as the first processor entry in the MADT."

Oh well. There are reasons why this is written the way it is.

