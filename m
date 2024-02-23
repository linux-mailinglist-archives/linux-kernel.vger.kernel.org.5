Return-Path: <linux-kernel+bounces-78134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36303860F5A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE77B1F270AE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66DF61674;
	Fri, 23 Feb 2024 10:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YiVSVT26";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="09ZIG2ZH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C3660EF5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684278; cv=none; b=GVBHp726z+N+4LWxyfGqzChwoblYTqAkBJsLGz4cwjQvtBzzRIEeSboSiRQfKa+ebs4i618ZDUg6TZ/HcUs683HwJKd4TmP9JcjUT48wvxjV+sNJw4z6GQekvC15JzeWjoBIrFSUY0aaIOL+SAZGWs+RnNTDy5vevzr59/5FQpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684278; c=relaxed/simple;
	bh=jkLLuHQoX7Qx5Fy5qJpixZOVOxqV9iRWh6D0pLconUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bxtn1PWTaKUVreKhD6Ei9hwiI99e93mdblOiqevJ3LnwT9tHzFWghRspzFeywCJMFn6NNK30IXk0/GvGtYO5+dNI04obysTpjUbF88hLGA/Gz+G54klnwpevMa/psOmi9NlFD9Os05wr0kNjT1eeOus1fAojE7HtxJglm2CwTbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YiVSVT26; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=09ZIG2ZH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708684273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jkLLuHQoX7Qx5Fy5qJpixZOVOxqV9iRWh6D0pLconUY=;
	b=YiVSVT263F5FBqEISJkPVpVsZcbfVYxujjjgmA68+1aW2JPWI88DfN/lemthMtK9Xk+BYk
	MgST4jZJNVsyNLdN4eVZOV+0A5SRkDYOTuZBmumyXO8//S4D7zAoBbMHxmutSMB6IyzpKP
	6cVUOYz1ScR4VuG/JeY+rJdfXl2Qx31iV/xfxnEoxFVON5ouD7AcLPZQ8RKmL+tcbOMWwk
	sLbKA9+9jJ5h22X1l0RdrMHbw8GbGhf3bivax/n/FQMPz/PCwW6apOB3mN6s/QXtukML1X
	yEIrYNmzz4LTBTjEwg+YsGUCkssgiC9EjzW1yV3N8Q6Wd5gEgzTwXYlVsO1PxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708684273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jkLLuHQoX7Qx5Fy5qJpixZOVOxqV9iRWh6D0pLconUY=;
	b=09ZIG2ZHx8YiIlTpa2V0EoiX45d9E+RxpvYkjsbD254Oww6TUCvu2V8tVDb1bx9jIP0dka
	Sl0WEcqgpr8YkrCg==
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
Subject: Re: [PATCHv7 16/16] x86/acpi: Add support for CPU offlining for
 ACPI MADT wakeup method
In-Reply-To: <20240212104448.2589568-17-kirill.shutemov@linux.intel.com>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-17-kirill.shutemov@linux.intel.com>
Date: Fri, 23 Feb 2024 11:31:12 +0100
Message-ID: <87jzmvcw0f.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 12 2024 at 12:44, Kirill A. Shutemov wrote:
> MADT Multiprocessor Wakeup structure version 1 brings support of CPU
> offlining: BIOS provides a reset vector where the CPU has to jump to
> for offlining itself. The new TEST mailbox command can be used to test
> whether the CPU offlined itself which means the BIOS has control over
> the CPU and can online it again via the ACPI MADT wakeup method.
>
> Add CPU offling support for the ACPI MADT wakeup method by implementing
> custom cpu_die(), play_dead() and stop_this_cpu() SMP operations.
>
> CPU offlining makes is possible to hand over secondary CPUs over kexec,
> not limiting the second kernel to a single CPU.
>
> The change conforms to the approved ACPI spec change proposal. See the
> Link.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Link: https://lore.kernel.org/all/13356251.uLZWGnKmhe@kreacher
> Acked-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

