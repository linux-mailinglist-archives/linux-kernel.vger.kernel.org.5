Return-Path: <linux-kernel+bounces-78123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E97860F33
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 149AE2835EE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282F25CDF5;
	Fri, 23 Feb 2024 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IKYZ2AI4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rUaZd31h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DA95D493
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684004; cv=none; b=pDy6sbbAlu3hISZ7nNkCigqKJGyBxJu1xBPTsI444g07XQKbbAyO2m04S4b2wlCYkf/npkrbcDrvaZhnR+eX6fbH/1enKPNObumxJ/tlkgXU60Gm9rH0XXMrZvODp+GHVUOvAKb5Cclsy6U7D7c4w1tX3QrJBLPej+I1R4/u1DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684004; c=relaxed/simple;
	bh=Gj+c+z0QQUx5LZDDvpBGXmu7oB3+rGMorguEN/YL7Wk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZJZQHnKFPQphxLuRpitKewluc2+V0IuSwwbgeyApzXa34vpdxdCYJATpygGHC34erSeeGu6g0I9qraapVNw62T00KmY5+OlF6T7RVqZ/OZs98dou5B5cpKxjE4F7ReLrNn3wwCM8Paqv1fI9SAP+gat66UuTtiWdWKhJTFNtv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IKYZ2AI4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rUaZd31h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708684001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gj+c+z0QQUx5LZDDvpBGXmu7oB3+rGMorguEN/YL7Wk=;
	b=IKYZ2AI4bvKLy/sS5aIpSZ8CRBJ/Jfmo6Ol8+942g7pqPZIBzVOhKmgHw+CGuqf2E7Lzo4
	zgmkkqe8bnmI+s04OV5U6Wz3UvVq2BJ7v2bWlMtRxMLEBSGwXauh6C4Y/oSHe7HZ6cdZim
	Hixfjs+7Zl4tGPcODF7UMnRjbkJ1RqnICoMniYA2d4iVLAxuBdAHbNn1y6MH5WZae69ql8
	L2Ww4a3DeOOgdtHBc+Re0+dPOhNljA1FZlMelOYZdczVa+B700oxbXCnUPaUTnXM51Yab6
	PfN0wIKGvC6nPfAWgAl0Xe52jeukQrdntphGe2YL6xjt0DuGOae5Ycp41mV66Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708684001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gj+c+z0QQUx5LZDDvpBGXmu7oB3+rGMorguEN/YL7Wk=;
	b=rUaZd31hVYdpyiWcibb+qKArRGWOQggoYnF9LYPkfghbBc+YFSS1n0Qc3uviJD1OloQhjj
	28b9Uksre55OI+CQ==
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
Subject: Re: [PATCHv7 14/16] x86/smp: Add smp_ops.stop_this_cpu() callback
In-Reply-To: <20240212104448.2589568-15-kirill.shutemov@linux.intel.com>
References: <20240212104448.2589568-1-kirill.shutemov@linux.intel.com>
 <20240212104448.2589568-15-kirill.shutemov@linux.intel.com>
Date: Fri, 23 Feb 2024 11:26:40 +0100
Message-ID: <87sf1jcw7z.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 12 2024 at 12:44, Kirill A. Shutemov wrote:

> If the helper is defined, it is called instead of halt() to stop the CPU
> at the end of stop_this_cpu() and on crash CPU shutdown.
>
> ACPI MADT will use it to hand over the CPU to BIOS in order to be able
> to wake it up again after kexec.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

