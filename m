Return-Path: <linux-kernel+bounces-78125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0381F860F35
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7FF9B2261F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159185D46D;
	Fri, 23 Feb 2024 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q9PLMTgH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J0AapWKP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F315CDC2
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684064; cv=none; b=hrXzZEQNkAueA8JwyzjL9Dznk4N04e5yTP4qiSc1YzZR+OsMgxTW0kWYdyJ9f5b24RQyALlrtTzbAnFlNIBdrTp1t9SRq0hnfyyQgcglYnT/Qq/sWDy1ycljSaQ3N2c6hweQUc/MrTRLfTfOdop4PXcGoDt3C+BZPpKe/KOylIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684064; c=relaxed/simple;
	bh=Hp4iU0RpSl1jOuhbAjRjJHRj3gI5ZJJbentZQvmuQXg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nh0UXXKK77RvSOU65BKirZQEmzaofK1et4Ehyxk1k9NcRHUHOD/pKcdNuq4VOzXoH8kYsvcSR03xoDpwOtGBJvOWQ1vzbEr+TXZLI/xRWzlK1cnoAxBEIGC6YRSk+vC+SxgNsyJ0XUYhkzUf1U7CAw24U5e2xq8BXE+nAKaJxDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q9PLMTgH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J0AapWKP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708684061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hp4iU0RpSl1jOuhbAjRjJHRj3gI5ZJJbentZQvmuQXg=;
	b=q9PLMTgH044LFtrZQc9HnKc59Yqat+K46KNcyas32qsUQ8S8j/2cffl8YX5G/At57XdJzG
	/3aoI9qotr4zTqwQAvGhf9AM2QvqmXdRKyJ6pKxocfuAfJMxaH40ek9lXZLmPk0T1Ge7yo
	ZknvkVUPq5MqKqrJ8rDSjDSvqv8uJrBPfJmMFW0cnLk45KUpNRsY2a69eZgOjVSyYTB/q7
	sdxyL6/TEpdpXHh948cbtRi008CTkLORajfI4IvTAZY/9gFlZScBqATPLKSpBfGWLLhtxh
	1FVIuZgVkkcV9yndjhsmpvURmSuQfjRDKG+k2ieuE7B+RJVzprasjYuIlesq5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708684061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hp4iU0RpSl1jOuhbAjRjJHRj3gI5ZJJbentZQvmuQXg=;
	b=J0AapWKPuScDq3KYFaG/2adL+RRKtWu3BD+o4MFF+55cZ+53ALgCIoJ3MD7LoK5Xz/WbiO
	RIOipAnRmn/TRWAg==
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
Subject: Re: [PATCHv7 12/16] x86/acpi: Rename fields in
 acpi_madt_multiproc_wakeup structure
In-Reply-To: <20240212104448.2589568-13-kirill.shutemov@linux.intel.com>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-13-kirill.shutemov@linux.intel.com>
Date: Fri, 23 Feb 2024 11:27:40 +0100
Message-ID: <87plwncw6b.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 12 2024 at 12:44, Kirill A. Shutemov wrote:
> To prepare for the addition of support for MADT wakeup structure version
> 1, it is necessary to provide more appropriate names for the fields in
> the structure.
>
> The field 'mailbox_version' renamed as 'version'. This field signifies
> the version of the structure and the related protocols, rather than the
> version of the mailbox. This field has not been utilized in the code
> thus far.
>
> The field 'base_address' renamed as 'mailbox_address' to clarify the
> kind of address it represents. In version 1, the structure includes the
> reset vector address. Clear and distinct naming helps to prevent any
> confusion.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

