Return-Path: <linux-kernel+bounces-1614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4056D8150E2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71C9AB20B58
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A13A4597D;
	Fri, 15 Dec 2023 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AgGTHkOV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dBGh1ObS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDED56384
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702670887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=901yYjGoVVKctXfDEcezEvC98dproV2+EzG1Mh+yZM0=;
	b=AgGTHkOV34ccu14DmKs2xRNtyh8yo6NK8Os/GA/oaKj5dJVO0iNqK3cc62YfKLntBxbx1E
	UjOXzyckYJzbxXGvFRgspqx1zO6uB+QM0Q3s/KUm6tcZndqIfJRDNSsnOfNdvweeYegV2X
	fRmI7JwL7c0aKPtI24kLIInpSa0omC+XyU11T7AK7pxoCY364HCXVjY2ef7DsW0PPE10bi
	z7ivC7FP+3SOS5r3Vqgx8zSRDzI0jwoJ8TRnilpeb8prw/2+KBL0bTCjooYpYZo4VuF8gt
	Lf33uLpWZXfUVlYbDTZIMf3We5jXqZSaiX6GQ/m1ZbB7USyrsAb3BySENDvgOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702670887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=901yYjGoVVKctXfDEcezEvC98dproV2+EzG1Mh+yZM0=;
	b=dBGh1ObS5w6jiyv0AKskvjWWTxQcRmMp8knq/NQOzQCNF43l0J5LmOMipb7DbsPhm1HVf7
	En8CAAG79zkWwiCQ==
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima
 <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, "Huang,
 Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv4 13/14] x86/acpi: Do not attempt to bring up secondary
 CPUs in kexec case
In-Reply-To: <20231205004510.27164-14-kirill.shutemov@linux.intel.com>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
 <20231205004510.27164-14-kirill.shutemov@linux.intel.com>
Date: Fri, 15 Dec 2023 21:08:06 +0100
Message-ID: <87a5qbmdp5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 05 2023 at 03:45, Kirill A. Shutemov wrote:
> ACPI MADT doesn't allow to offline CPU after it got woke up. It limits

to offline a CPU after it was onlined. This limits kexec: ...

> kexec: the second kernel won't be able to use more than one CPU.

... one CPU, which is enough to cover the kdump case.


> Now acpi_mp_wake_mailbox_paddr already has the mailbox address.
> The acpi_wakeup_cpu() will use it to bring up secondary cpus.
>
> Zero out mailbox address in the ACPI MADT wakeup structure to indicate
> that the mailbox is not usable.  This prevents the kexec()-ed kernel
> from reading a vaild mailbox, which in turn makes the kexec()-ed kernel
> only be able to use the boot CPU.
>
> This is Linux-specific protocol and not reflected in ACPI spec.
>
> Booting the second kernel with signle CPU is enough to cover the most
> common case for kexec -- kdump.

This is confusing at best and I doubt that kdump is the most common case
for every one.

  To prevent a kexec kernel from onlining secondary CPUs invalidate the
  mailbox address in the ACPI MADT wakeup structure which prevents a
  kexec kernel to use it.

  This is safe as the booting kernel has the mailbox address cached
  already and acpi_wakeup_cpu() uses the cached value to bring up the
  secondary CPUs.

  Note: This is a Linux specific convention and not covered by the
        ACPI specification.

Hmm?

> +	/*
> +	 * ACPI MADT doesn't allow to offline CPU after it got woke up.

to offline a CPU after it was onlined.

> +	 * It limits kexec: the second kernel won't be able to use more than

           This limits kexec: ...

> +	 * one CPU.
> +	 *
> +	 * Now acpi_mp_wake_mailbox_paddr already has the mailbox address.
> +	 * The acpi_wakeup_cpu() will use it to bring up secondary cpus.
> +	 *
> +	 * Zero out mailbox address in the ACPI MADT wakeup structure to
> +	 * indicate that the mailbox is not usable.  This prevents the
> +	 * kexec()-ed kernel from reading a vaild mailbox, which in turn
> +	 * makes the kexec()-ed kernel only be able to use the boot CPU.
> +	 *
> +	 * This is Linux-specific protocol and not reflected in ACPI spec.

See changelog comment...

> +	 */
> +	mp_wake->mailbox_address = 0;
> +
>  	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
>  
>  	return 0;

