Return-Path: <linux-kernel+bounces-78137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C9A860F62
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FB22869FE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7951A5DF25;
	Fri, 23 Feb 2024 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AyBAuSQu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5JE1fxmV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F7764CD1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684316; cv=none; b=rUvFrmQougaLlhLSr43Qa8lmdcqDerouJBew/FHGE4BfRo7HvmYOkxcsyQcwcNsA5XJHHcxza1rGAPk+u/7dgIB4dK9+WQtztSs+AC8NV16VF3XrdosZBv54zjyoJp9LvzkvAFgMXNoUMUAR/DukMn9fnsEnCSAls7iUPOnMhKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684316; c=relaxed/simple;
	bh=7q16l4PLAkeFz1ikN1v3yvWfjtunA/lCaAhbC7l8rwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JkgGyQLmCzI0aK3l+yIOoA5eXC5UvffBvZYUvAGJzhKYMvoUavR+igA2eYLzV9dyDglABxaJKkqxE6aZSPJciUfcP5xuU40IZ9d4BPvtUZggER3U0p/x2ziyXFMm59rj+PHrQpBz3AnqmqmHtDBefYiFkmF41WQT5TcjKJn9whw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AyBAuSQu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5JE1fxmV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708684313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7q16l4PLAkeFz1ikN1v3yvWfjtunA/lCaAhbC7l8rwA=;
	b=AyBAuSQuueZQpETiCJOiTooyiUpkTFh1gljVhGKa26m8AbZXz+ClbWeGeysy0ypsiUXzet
	Ll6nbIBClYSjJpACQvIwyIAWTS84Puw82T6tNdb5ONaK8rU49tGiBcuyqblKXuFAg/asxa
	DPsPFgkFOxl4rMM5fJv3vjJSz5+neJ7KqssTAcCqZJSG4bCvNtMfUaTaoHgqPELrJlQBPu
	Sm6ZtqdxDR/JwstEokv/kOGOJDwehY75cV+aHJbiB6yWoHdCBW2MFd8RtLvhEAPHhUCQhW
	GLgbAC/DxuHDjeev1fzufqpWVnz8nO6ctHPvby5FUT/nNnqpdPO9x1tICNZ5vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708684313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7q16l4PLAkeFz1ikN1v3yvWfjtunA/lCaAhbC7l8rwA=;
	b=5JE1fxmVy1ywQuyk8s+y5t3/zZxSo1OI/QYoaHGBo/In4Su/6471Yvukp6dRs7zNCT1+c/
	b1ihqri6iF9wzqAg==
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
Subject: Re: [PATCHv7 02/16] x86/apic: Mark acpi_mp_wake_* variables as
 __ro_after_init
In-Reply-To: <20240212104448.2589568-3-kirill.shutemov@linux.intel.com>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-3-kirill.shutemov@linux.intel.com>
Date: Fri, 23 Feb 2024 11:31:53 +0100
Message-ID: <87h6hzcvza.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 12 2024 at 12:44, Kirill A. Shutemov wrote:
> acpi_mp_wake_mailbox_paddr and acpi_mp_wake_mailbox initialized once
> during ACPI MADT init and never changed.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

