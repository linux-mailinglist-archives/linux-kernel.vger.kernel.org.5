Return-Path: <linux-kernel+bounces-22344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4725F829C67
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569A41C25492
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB484A9BE;
	Wed, 10 Jan 2024 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eaIAFrcw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0iTrUNQ6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB2A495DA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704896399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gIIsLuC5UCWneXX0tQDeQvYudGCnylpj0YRWl2ecGtY=;
	b=eaIAFrcwce/4g8eKcKKjA4Uz64jhBUVS2XZiCIRjiOdFSPxrv7/6tRHj5bLVzG6XQRAl7W
	oeq2VAhrbfZ+1WgVgVfjlwGbmhZBU5CYFNY0i/q4ShBITGazDQR8UA1nPqgAMZ4VokVrCD
	rGXRmqRZcj4qLsQFsgYreNGzF1uqb8u0L6xgRZy6UVDhkaoWybiMCtnyyZym31tELyQSYl
	qEj+2KCq/NXn684dIIG4nAqKttMqUvq986RB79A3coSQYyWWCtZR7Gc/QVaIsAeabV2RDM
	vsAYak46xCvulkdjZrmN09w/1aMasVGtbjEI6FUc997FA2xsdxaOZrxTXaP4vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704896399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gIIsLuC5UCWneXX0tQDeQvYudGCnylpj0YRWl2ecGtY=;
	b=0iTrUNQ6l4NIP8XjvYvraasjplrChq/8Z4KSKHWY4LE2uYt3WBWoGwvSN8dG1ALxqzPERA
	hJ2gRIxaPt/Pr4AQ==
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
In-Reply-To: <ff58623cdf63dc75fc245fd18ee776465f4bb3b8.camel@intel.com>
References: <20230807130108.853357011@linutronix.de>
 <20230807135028.381851690@linutronix.de>
 <7443f3200ef0be756566059e8c9b0657f3cefcff.camel@intel.com>
 <871qarlvub.ffs@tglx> <87y1czkdlg.ffs@tglx>
 <ff58623cdf63dc75fc245fd18ee776465f4bb3b8.camel@intel.com>
Date: Wed, 10 Jan 2024 15:19:58 +0100
Message-ID: <87frz5jmnl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 09 2024 at 01:54, Zhang, Rui wrote:
> On Mon, 2024-01-08 at 17:13 +0100, Thomas Gleixner wrote:
>> > > Unfortunately this causes a regression on Intel Meteorlake
>> > > platform,
>> > > where the BSP APIC ID is NOT the lowest numbered APIC ID
>> > > (instead,
>> > > CPU12, the first Ecore CPU, has APIC ID 0).
>> > 
>> > Bah. Let me think about that.
>> 
>> In which order are the APICs/CPUs enumerated by ACPI?
>
>
> This is the order in MADT,
> $ cat apic.dsl  | grep x2Apic
> [030h 0048   4]          Processor x2Apic ID : 00000010
> [040h 0064   4]          Processor x2Apic ID : 00000011
> [050h 0080   4]          Processor x2Apic ID : 00000018
> [060h 0096   4]          Processor x2Apic ID : 00000019
> [070h 0112   4]          Processor x2Apic ID : 00000020
> [080h 0128   4]          Processor x2Apic ID : 00000021
> [090h 0144   4]          Processor x2Apic ID : 00000028
> [0A0h 0160   4]          Processor x2Apic ID : 00000029
> [0B0h 0176   4]          Processor x2Apic ID : 00000030
> [0C0h 0192   4]          Processor x2Apic ID : 00000031
> [0D0h 0208   4]          Processor x2Apic ID : 00000038
> [0E0h 0224   4]          Processor x2Apic ID : 00000039
> [0F0h 0240   4]          Processor x2Apic ID : 00000000
> [100h 0256   4]          Processor x2Apic ID : 00000002
> [110h 0272   4]          Processor x2Apic ID : 00000004
> [120h 0288   4]          Processor x2Apic ID : 00000006
> [130h 0304   4]          Processor x2Apic ID : 00000008
> [140h 0320   4]          Processor x2Apic ID : 0000000A
> [150h 0336   4]          Processor x2Apic ID : 0000000C
> [160h 0352   4]          Processor x2Apic ID : 0000000E
> [170h 0368   4]          Processor x2Apic ID : 00000040
> [180h 0384   4]          Processor x2Apic ID : 00000042
>
> and this is the order in Linux (from CPU0 to CPUN)
>       x2APIC ID of logical processor = 0x20 (32)
>       x2APIC ID of logical processor = 0x10 (16)
>       x2APIC ID of logical processor = 0x11 (17)
>       x2APIC ID of logical processor = 0x18 (24)
>       x2APIC ID of logical processor = 0x19 (25)
>       x2APIC ID of logical processor = 0x21 (33)
>       x2APIC ID of logical processor = 0x28 (40)
>       x2APIC ID of logical processor = 0x29 (41)
>       x2APIC ID of logical processor = 0x30 (48)
>       x2APIC ID of logical processor = 0x31 (49)
>       x2APIC ID of logical processor = 0x38 (56)
>       x2APIC ID of logical processor = 0x39 (57)
>       x2APIC ID of logical processor = 0x0 (0)
>       x2APIC ID of logical processor = 0x2 (2)
>       x2APIC ID of logical processor = 0x4 (4)
>       x2APIC ID of logical processor = 0x6 (6)
>       x2APIC ID of logical processor = 0x8 (8)
>       x2APIC ID of logical processor = 0xa (10)
>       x2APIC ID of logical processor = 0xc (12)
>       x2APIC ID of logical processor = 0xe (14)
>       x2APIC ID of logical processor = 0x40 (64)
>       x2APIC ID of logical processor = 0x42 (66)

What a mess...

