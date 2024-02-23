Return-Path: <linux-kernel+bounces-78127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09738860F39
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9A61C219D7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EC25D472;
	Fri, 23 Feb 2024 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U11EX3Gs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zbZmICsw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1011A5CDC2
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684113; cv=none; b=lfXnyxDRTalH48D4+MJNLIkG1H79WImXTR0ZSCudI6UpJq+/Ge2na/aTDlJGXrZc+82Ir8bwNIiZZNAtTNoJBPJ0CPKZLRMNHaN8qcvwmhgeJ6ca1aUdzsH5nlaykkY7Dt5IvH+UrqN+iQQ4DXy2y1sLq/oxBEf1MAKm55DPtLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684113; c=relaxed/simple;
	bh=cl3yxDrq//HdjpH4tGpYeRfOCYCkzMKRoLj++ITknVc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HidrOPxTwtx707EowETc9lgfxRje3KuJzINFl6MA4S9PIKOF4bAzuPO7IpRLdAI8qnMkcn75ZTJQ2P0HL5omCYY6bnV0cAp6kjvdfba0HgpL1RmlGqw37EkhKyZeZgUOnPNr5007Qou33m7H36veP0RKi62C/HBrmxMxPfoLWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U11EX3Gs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zbZmICsw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708684109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rCkSqOHXuNZNZ4qVAhXnw7igAzpOyBDOC7OEqD/cJhc=;
	b=U11EX3Gs7FK3ddaIS5hLCrLHSqX9h8fgsM12+dEprj9QStdLmwDUXgmjR6ptTQ6s+nm5aC
	KQp49Cg6YVxaAjH/FggpkbntKzvEAHfW6bH19BZzDvAuGvdzB+03XUxRqSvmR2KFlIjX7S
	9Gfe8CkA4zwjNMOqiV5srnkr6hVd+9ayY9O3C8Cr80aK7dmjLqlS7hfTJ3Kiz3MKioJmpV
	BVSQrfb1dVuIo4kNHW7DeWpx9slJcF2TTTOtc0uEfH+u41wdotKzFo8PbmsAjdMlivK7zy
	kO1sbtUrK1bWMfz5VVUTE1/DrhsAVFxnaShTHZvnWn6cl1vs9bvbTe9exxnfgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708684109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rCkSqOHXuNZNZ4qVAhXnw7igAzpOyBDOC7OEqD/cJhc=;
	b=zbZmICswW00KhN+dV6Wcm66nBj+5YEQ3qEg6CAYuhnU5gj+g/sB9sxUv6UKb+ibV6/Tyl+
	xLqpn93b+a658eBw==
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
Subject: Re: [PATCHv7 13/16] x86/acpi: Do not attempt to bring up secondary
 CPUs in kexec case
In-Reply-To: <20240212104448.2589568-14-kirill.shutemov@linux.intel.com>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-14-kirill.shutemov@linux.intel.com>
Date: Fri, 23 Feb 2024 11:28:28 +0100
Message-ID: <87msrrcw4z.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 12 2024 at 12:44, Kirill A. Shutemov wrote:
> ACPI MADT doesn't allow to offline a CPU after it was onlined. This
> limits kexec: the second kernel won't be able to use more than one CPU.
>
> To prevent a kexec kernel from onlining secondary CPUs invalidate the
> mailbox address in the ACPI MADT wakeup structure which prevents a
> kexec kernel to use it.
>
> This is safe as the booting kernel has the mailbox address cached
> already and acpi_wakeup_cpu() uses the cached value to bring up the
> secondary CPUs.
>
> Note: This is a Linux specific convention and not covered by the
>       ACPI specification.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

