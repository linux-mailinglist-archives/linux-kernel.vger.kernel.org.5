Return-Path: <linux-kernel+bounces-78139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5254860F65
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7B2286166
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FC96313F;
	Fri, 23 Feb 2024 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SAPlVbfY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vLiRuSlZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0199D629EA
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684369; cv=none; b=auZiu+WA/Km/S206jt+zTWcRGP2F7pqeBKzDxmbMjHXpey28NFHOvvK009kJ8LdDVQsmiy8sR80mUN9/bOM8RSGYEmWSs/LTkyTZmSzDUmf5SXzDAPvXWq4jcvDonj3aGQkynWQ5wF65DoUqgMMcTRYUBz+4YGhEu6iAgU5B+j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684369; c=relaxed/simple;
	bh=scx2slDA6raFbarOjI7wCrLGdncqbOB4vubtWKq6aZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=be8P1UucAwEXNB60M3eCORok0Bxpu3Mcx5glVDkpolkbbUTbE9ffuF8RBeCA1zjCajOufubs5CAhlWfUQy7ziDxpxToeb/rl2L44bfetqWD2ADsu5V5V17axwTHEb6GqRgJZa2PuPiU++j9R5yuxVkw4g2FedVlQcdErvw2eVuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SAPlVbfY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vLiRuSlZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708684366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=scx2slDA6raFbarOjI7wCrLGdncqbOB4vubtWKq6aZU=;
	b=SAPlVbfYJusFcTHUsvYNNSl7IoawH6vWI32ukKpKsp7eoyzC7p1S5rFZaDIfhunhn7ocVL
	AF0fs70iwnESFpcz99WEFvwv6Hq+Ewm30xd96xzvXu3XO0i9BtGo2oKjHI4gS4rBW7Gry6
	LnCN6aQGDU5c53H/Yxoqz1kMYVWIL77egW8s3MWIqqiURmvUYS5jU805chMwuvd66Pc43Y
	SoMaNEzYsCAWgnf0P2PERuWhDbytSOyjbGETHtx1SLo3M7rD5u/RCMGrXtsEqfHy5YWFU3
	zLT2hK6ts4K+aB4tIiWTxGk7usazJGXVpLqX+aWcBBJ69lL3oH/4CzYwc0PPDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708684366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=scx2slDA6raFbarOjI7wCrLGdncqbOB4vubtWKq6aZU=;
	b=vLiRuSlZTUbRNf1jQ/DaF+z0E180UBrDwqKpedbgUVTXLEXpDK8VaIaAbQWMNRB+URJdm2
	WZTFCcxidJXdSmAA==
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
Subject: Re: [PATCHv7 01/16] x86/acpi: Extract ACPI MADT wakeup code into a
 separate file
In-Reply-To: <20240212104448.2589568-2-kirill.shutemov@linux.intel.com>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-2-kirill.shutemov@linux.intel.com>
Date: Fri, 23 Feb 2024 11:32:45 +0100
Message-ID: <87edd3cvxu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 12 2024 at 12:44, Kirill A. Shutemov wrote:
> In order to prepare for the expansion of support for the ACPI MADT
> wakeup method, move the relevant code into a separate file.
>
> Introduce a new configuration option to clearly indicate dependencies
> without the use of ifdefs.
>
> There have been no functional changes.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

