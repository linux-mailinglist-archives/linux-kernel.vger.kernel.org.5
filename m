Return-Path: <linux-kernel+bounces-30542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A1683200E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF861F28BA5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1A02E633;
	Thu, 18 Jan 2024 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oS2696lf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rwkb7Rkt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CFA2E40C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607687; cv=none; b=WdoqJ1ZXqucgrrUdn9yCSgJydkcsTNN7njmVCXKNwiWdlbUt5htgsp8EJKAehnsawpz5KxpqtNmT2QV0BGIJn0euPd/wMduvzO85aKzJsJGRo5tjH7WrbkISerplvjLA10Bnt86lZlno9FS9F/8HMkVQp5EQ7QgoChch7u7hkWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607687; c=relaxed/simple;
	bh=o2RBJWUk5u6Z+cVADfGN1CMe6R98eLGX8cv9D9sxVLA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NNTbh+3s5obdQd/dMOeIuxJRomredDqisSlF8orzYGGyN58S1cJuLoJ3+k9HoUcoJ/LXIRZApSNhvB6YWx9/OGz4MIxzuj6ubYRJEH4eERnYYrW+BNfMBK/vXmC2AWDFgRnaVGC9k6VjIDF/S28Dc+abNS3M+4e2LeMqoi6Du8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oS2696lf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rwkb7Rkt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705607684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HGMe/CfTJUGDM7yuEH/5jnstGrLape2b5UIKODPCsA=;
	b=oS2696lfos7HlRbjOOt/lU5YACb4ptBkSdZD7Qg3Eag9LdXVMXL5QJ9YopoVqzpBNmqftP
	jY2IaiJlUjTzhNwJ+I/zcRYAGdpdojMnElvnNLmFe6FFgEDlicM8j6Qp8WQyRHZQOlNU6f
	ylQoq9Ej9xhr3rVp5gadSPnzjvEI1Rz5lZGtjbEZlI0Lkgp2c+Il8/vV1Ne4Hkv8tWxUj+
	EsEzbbxU8U1iQtfpDbHnuTUGzwkFEbqzHN1U6UdqL9l9uLZc+0YNaJJ9Fn9ifincIOu4QQ
	CMcJ716IRDTsCrgeekB7SCSVN1MJEzpMZJiAtY8fK9q+Ca91xXngDguNf+Sq2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705607684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HGMe/CfTJUGDM7yuEH/5jnstGrLape2b5UIKODPCsA=;
	b=Rwkb7RktpERo6eUhVLq2oXVHo+ZKnjP2E7Mx19dgY1THHk8Pox6t/t4Dp4EEWCKhX40GTJ
	ygL8VUNGPnUaGSCQ==
To: Dave Hansen <dave.hansen@intel.com>, Andrei Vagin <avagin@gmail.com>
Cc: Andrei Vagin <avagin@google.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>
Subject: Re: [PATCH] x86/fpu: verify xstate buffer size according with
 requested features
In-Reply-To: <54bcb902-0fab-4a53-8b8e-85b6e4484b03@intel.com>
References: <20240116234901.3238852-1-avagin@google.com>
 <30cd0be4-705f-4d63-bdad-fc57301e7eda@intel.com>
 <CANaxB-xu+zG=5_EAe4zapC5a_x4CkkDovmVX7LjiLk+E7kU75g@mail.gmail.com>
 <b3e5456a-7113-4868-b8ce-020421e898ba@intel.com>
 <CANaxB-zQYC8=7frWGU2pRTDJrkVu0iR8QZCmUxSzGmBG-_b1cg@mail.gmail.com>
 <54bcb902-0fab-4a53-8b8e-85b6e4484b03@intel.com>
Date: Thu, 18 Jan 2024 20:54:43 +0100
Message-ID: <87cytyfmd8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 18 2024 at 10:27, Dave Hansen wrote:
> If we have nice, reliable fault handling and then decide that we've got
> XRSTOR's running amok reading random memory all over the place that need
> a nicer error message, then we can add that code to predict the future.
> If our "predict the future" code goes wrong, then we lose an error
> message -- not a big deal.

After staring more at it, it's arguable to pass fpstate->user_size to
fault_in_readable() and ignore fx_sw->xstate_size completely.

That's a guaranteed to be reliable size which prevents endless loops
because arguably that's the maximum size which can be touched by XRSTOR,
no?

Thanks,

        tglx

