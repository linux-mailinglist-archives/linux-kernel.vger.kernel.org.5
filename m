Return-Path: <linux-kernel+bounces-1576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD8F815053
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E73E1C237FC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030AF4184F;
	Fri, 15 Dec 2023 19:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kgt0xfRm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P32Og1Dm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B13445BE7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702669421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fnR64pgj00xG9grPwYFHOKVlCFbwaYrlZk02qWdUZAA=;
	b=kgt0xfRmhuK8TFd05T85uIRNK0k2JRjRCjaQ5z/Ynj6fRkvdzDCU60BpE78ztG8qtJPw0E
	oqD3osiwAhgN0R5HtEWRSBVsKDDSmIUEJvhlgXI8GX6+G5TsLKF/wIABGB6P+VCUrfNwnl
	NGc0TMmHaH+cEYBuo+GTXZIhzZDzaOHhE8A6/6VVfdyL5ZlndNg6jiGNQTLQUz9g++xaKM
	ms1ld4fO896dqZ17MvHpEDWHQtI7DAahZu/mJbkBJPp2kXBxYWSE96R2gLiHXoVq0NLe3l
	XevrclGGyloxxGJicNFfSthEtx0pjxOOwK2zJxB8XvFQTj66/gkHJQKwQay9YA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702669421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fnR64pgj00xG9grPwYFHOKVlCFbwaYrlZk02qWdUZAA=;
	b=P32Og1DmZ1Z/uHGJhunDvtNWzAOc6U+npMq5bLtuC9qSl43CbbT2ftcqvsdATqzzTVXumr
	laWogWSR3N6HyIBg==
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
Subject: Re: [PATCHv4 04/14] cpu/hotplug, x86/acpi: Disable CPU offlining
 for ACPI MADT wakeup
In-Reply-To: <20231205004510.27164-5-kirill.shutemov@linux.intel.com>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
 <20231205004510.27164-5-kirill.shutemov@linux.intel.com>
Date: Fri, 15 Dec 2023 20:43:41 +0100
Message-ID: <87fs03metu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 05 2023 at 03:45, Kirill A. Shutemov wrote:

> ACPI MADT doesn't allow to offline CPU after it got woke up.
>
> Currently hotplug prevented based on the confidential computing

Currently CPU hotplug is prevented...

Other than that:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

