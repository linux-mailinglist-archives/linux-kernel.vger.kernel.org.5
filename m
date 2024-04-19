Return-Path: <linux-kernel+bounces-151545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DAD8AB04E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E90281110
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FE812F5AF;
	Fri, 19 Apr 2024 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zmV0+CyB"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B42585C62
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535564; cv=none; b=TNNRL8HjSSH+ppt++VO7Bu+kDJWEgcM6ONWSZsqJHSHRH3zzifHqLl9RlPE81jYzsHknByTLBtCrpxQsSEZqdivoxen/BFgQPwQYesKRwzI5N5i2kgReF72e4n/eqCz9pkbBtbOzyJwL9xHutJWmqJkfh+ogfniYVGH8tAjuY4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535564; c=relaxed/simple;
	bh=nFGu38xiqRmTsAmgiVPoArTv2FW3yfqKeN+PsXjaSvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n14ETLa+4Tq5xXMu0E8PEgMNrT8PNKO/aoWU9AOaJJcqrhlQUEajdt0uRSj5fmY2kj23oTL33KCt9w8sU19kw1JNC/ai1y+QqqBc7tcQTAXpmxCll7LfAu2fGEekV8nDHgMGWQzWBm9yui097pZmBWxNDt1tRKUxxQvq/08QWP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zmV0+CyB; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e2a1619cfcso21347075ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713535562; x=1714140362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7m+OFN3f7RK1NWDGOjcIbMxbJWaEeT5t2cMPNC651Yw=;
        b=zmV0+CyBsrXn1cD5SV3geIH/GBP+MnqXtEjx6Jw+Qles5D5l6AuoZeFDOj2luTuJxj
         Jpf2nlN1t7Lm9TcEzCBWQ6bQgJvXyH63Xj/kmwYtbbtZA+wFFEmHuZE2UziSspRmiyoa
         4Yv+X5RcPpKQUQK1AtfhudkkYnT2Jdx2eDQwGZwuIpHSaPNQ6OREwEJFocL0pIu9ZrNB
         82YgEYAnvdrJq3t89Ij4rNO0RfIhaCMjUDd47LPPF8W9/3sGFMJxLpKfkbsUHREK3Ibu
         hgks8V3XOju3ErunjqC0AjCyi9sAY+9p8pmw249UA9iKWjQesuLjUos9fhKJE8FGJWxA
         ciHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535562; x=1714140362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7m+OFN3f7RK1NWDGOjcIbMxbJWaEeT5t2cMPNC651Yw=;
        b=lhjDkYTo3gnalOKPIL08CYgEqaXfKpsGHdSkadOowtytpTcGKqJE3OY+4pk35bd76Z
         GdDt2esa3T8OgYsApBPrBK8C8tHHHf/wUtlNTi72bGRStilQicVQlxMW+XGGpcm11VEP
         PMQ0YWQNXIEuX0odZjWlOttou7HAtSkeOXZEEkQtigKnsZEokoNXVSOyh5axh6Cl01wc
         /aS/O6qVuuLDXeqr2TT/gXbV4N7pgthWkfb0NIMu1Jr5fVi8jMuXLW16DIUmWj7mNf2b
         16hXw1ZFrHJsoxnnqwV36NdmFCwUiJ/7TAYUMv6lHcpRyfLGGlFJZ9VtfoHvLDpwo/Oh
         A2dw==
X-Forwarded-Encrypted: i=1; AJvYcCWPQMZwJegvxKUWp8lRjFqBOMplL/RRUi2g09YCawtsHQUGHfYhCW+/1QrITdgLemDmRjnr0QizIzf/5s7CRFUaKo4CZZ2sTI1YE1yo
X-Gm-Message-State: AOJu0Yx+KRWL/Q6XELnMUWgyD8z4vIr1aEfX2e2dhIKQHQnVLd1YPS64
	hXkKqiNNah1qUh8bjcfXd8lEOlHB6eyDM5vIF9KAHmY0G1wBTgqJJDURlxunChjGSt9DLjbfoBp
	9mA==
X-Google-Smtp-Source: AGHT+IFVr0e57cGhUmbwZXAzUZi28t0zaJY3a/EePbJv+HQcnlGd85ionAxsgZB2Zmftzq48Qq8oRL7k/7k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2352:b0:1e5:e61c:35af with SMTP id
 c18-20020a170903235200b001e5e61c35afmr243172plh.1.1713535561835; Fri, 19 Apr
 2024 07:06:01 -0700 (PDT)
Date: Fri, 19 Apr 2024 07:06:00 -0700
In-Reply-To: <20240419140321.GF3148@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409175108.1512861-1-seanjc@google.com> <20240409175108.1512861-2-seanjc@google.com>
 <20240413115324.53303a68@canb.auug.org.au> <87edb9d33r.fsf@mail.lhotse>
 <87bk6dd2l4.fsf@mail.lhotse> <CAMuHMdWD+UKZAkiUQUJOeRkOoyT4cH1o8=Gu465=K-Ub7O4y9A@mail.gmail.com>
 <Zh06O35yKIF2vNdE@google.com> <20240419140321.GF3148@willie-the-truck>
Message-ID: <ZiJ6SDcbTBQjrG3r@google.com>
Subject: Re: [PATCH 1/3] x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n
From: Sean Christopherson <seanjc@google.com>
To: Will Deacon <will@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Jonathan Corbet <corbet@lwn.net>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 19, 2024, Will Deacon wrote:
> On Mon, Apr 15, 2024 at 07:31:23AM -0700, Sean Christopherson wrote:
> > On Mon, Apr 15, 2024, Geert Uytterhoeven wrote:
> > Oof.  I completely missed that "cpu_mitigations" wasn't x86-only.  I can't think
> > of better solution than an on-by-default generic Kconfig, though can't that it
> > more simply be:
> > 
> > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> > index 2b8fd6bb7da0..5930cb56ee29 100644
> > --- a/drivers/base/Kconfig
> > +++ b/drivers/base/Kconfig
> > @@ -191,6 +191,9 @@ config GENERIC_CPU_AUTOPROBE
> >  config GENERIC_CPU_VULNERABILITIES
> >         bool
> >  
> > +config SPECULATION_MITIGATIONS
> > +       def_bool !X86
> > +
> >  config SOC_BUS
> >         bool
> >         select GLOB
> 
> I can't see this in -next yet. Do you plan to post it as a proper patch
> to collect acks etc?

Sorry, I neglected to Cc everyone.

https://lore.kernel.org/all/20240417001507.2264512-2-seanjc@google.com

