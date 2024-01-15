Return-Path: <linux-kernel+bounces-25813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1716D82D636
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49E6281B05
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962C0DDD0;
	Mon, 15 Jan 2024 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UKmgqObc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tvMa7edt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1A2D2F5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 09:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705311710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jW6EgVzQUaQoLb1vz2iTmsqFo+thhXthmccLpVlE5zo=;
	b=UKmgqObc2reVuU1aNJMeq5PbR/Q2+mVvQf5zbtNYEJlXVynUBzUtnRNTgu+u0ejC2LUh2G
	G00nUugBK6fuVikytVStJQMpkhWs+0rXVUElI8pxBnLgsIpAjXAGpEgLMnibzJvT57w5ZZ
	OJLVgkE0Kzfy/rDfFMneTVI1kBJIpmAcI0of0iZthB/OuAQlSfm1ifbicWEUvrfuPEVFNn
	DbGbHkAQ6Ur2PQU2w674Nm4tveLLxPF0kI2lTzaAzPvZOCQjqDJgT1okLl6d0lHWy172xj
	nWsPnlCNu0LqQZ0Y3QOyk6XFJp7WJVCW0c8uF+pRcELkJ14KP/paW/rH7x447A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705311710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jW6EgVzQUaQoLb1vz2iTmsqFo+thhXthmccLpVlE5zo=;
	b=tvMa7edtUMlBU2C77nC8PnxnizfC6UpwzAW3+5VEweD5czsZcl0lHLuBEUG164X7+ILAXf
	Fhjg/TXUGt67uyAQ==
To: "Zhang, Rui" <rui.zhang@intel.com>, "Brown, Len" <len.brown@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
In-Reply-To: <365568d9441d74516d0bfb802018ee0943b1b94b.camel@intel.com>
References: <20230807130108.853357011@linutronix.de>
 <20230807135028.381851690@linutronix.de>
 <7443f3200ef0be756566059e8c9b0657f3cefcff.camel@intel.com>
 <871qarlvub.ffs@tglx> <87y1czkdlg.ffs@tglx>
 <ff58623cdf63dc75fc245fd18ee776465f4bb3b8.camel@intel.com>
 <87frz5jmnl.ffs@tglx> <87a5pdjk54.ffs@tglx>
 <dbad0f6f9dee5851aa21ffae9e8877cf23645af5.camel@intel.com>
 <87edemimrj.ffs@tglx>
 <365568d9441d74516d0bfb802018ee0943b1b94b.camel@intel.com>
Date: Mon, 15 Jan 2024 10:41:49 +0100
Message-ID: <87a5p7gcgy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jan 13 2024 at 07:35, Zhang, Rui wrote:
> On Fri, 2024-01-12 at 16:39 +0100, Thomas Gleixner wrote:
>> It brings the effect that we can detect when we are not booting
>> (kexec
>> case) on the actual boot CPU because then the first enumerated APIC
>> ID
>> is not the same as the boot CPU APIC ID. No?
>
> Right.
> I was thinking in the way this patch series does, which just compares
> the boot CPU APIC ID and the lowest numbered APIC ID.

Yes, that's obviously not working when the lowest APIC ID is not the
actual boot CPU.

>> I agree that MADT is error prone too given the fact that not even
>> Intel
>> can get it right....
>
> For this MTL, I can raise an internal ticket to get it right.
>
> Are there quite some platforms with BSP not listed as the first entry
> in MADT?
> if so, we still have to live with the kexec boot parameter? :)

I haven't found one yet, but you might look through the P/E systems to
get a picture.

