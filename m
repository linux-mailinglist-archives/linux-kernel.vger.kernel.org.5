Return-Path: <linux-kernel+bounces-155347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFD08AE932
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A551F237F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E1213B582;
	Tue, 23 Apr 2024 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KEqoyE9x"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C15D13AA36
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713881427; cv=none; b=pC7tjBguhwzq3UrO+QYOR7KH2FTAkH6X/GWHNKjX1h1OioH3I3nw0ZQa05/cD7TaPX6hcCkVHvjaYEWRAKPx9pvr7g4/iw2QM13ijN9X0wPq5YLzYwWAXAAzijYHH8G1kupOskQbSxAyUwnfKiWbfrDrhLnsFa9Hv9jxFiTTIec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713881427; c=relaxed/simple;
	bh=wgr7JFgbltr3CTZ0p8+oUseOnMeXqIP2y7jujSJHRi0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k0+Q9WFpSipxWvHlBL8JdtBxOAFnTrMmE2A6RJyMptlgKFojGEtBBKdlAbzza9WVDHvZ1cE+nWyOYhjdVPcQ9ltFLUsCk7x/G0qhNwRaMV6ceI2IUHZtEo4ppja26AoQXqMFkoltQKEHlWXhFQ1e1UC/mEaOcNTrTS48Wtfh0xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KEqoyE9x; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ceade361so11000813276.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 07:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713881425; x=1714486225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ETCX+XlBCG6FMmeO42AVeK/EJm9XPFCN1wyL6ybIujc=;
        b=KEqoyE9x45mjTtKz4Kr0ZQxR7dfXyOVAgIafIx/HXS4C+1Lkw4JE6yLn7MIyWjtGLU
         daxn13Jq0Q9a4jL4IgzJZpng69uaBw90QJU9oPC909gow2nTE9+GwDF9qw6y+Kq36v0f
         rj7hUP5Q4ielgEtCbavhXwDhedlaKQG08xqiBcXl8uxfE0LBbTPy2OOSMh7ynxlfczZE
         iYt66aJD9xJ5YzgGZRvF/PQIqbdb7zUAZTGaB2l+n/tllX1HZeJ5btpCvsi46jG0Tnx8
         Al6NMit3oshc79huMeGGKQXwBXZVZzugFkiX6ExXnPJl9Tq7XKZd7gHaHgkbg0N7ejDU
         US4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713881425; x=1714486225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ETCX+XlBCG6FMmeO42AVeK/EJm9XPFCN1wyL6ybIujc=;
        b=wb1I1mXXOfzXotFJvdO+GInGSxMy/4wtemWDPbQ6Q6yriKBTN5ap4iwOvM9x9n1F1g
         cogaknLk450aWwdKJ5mqtuFqWiU2myLrM46HKVcIuxQ8/b6dRGPzxdzHLyFLjhm4OEpX
         dnv9Qmz5xeN8gdGXJtu2xZ5OYJoMcYJhwwKNvDKlYC1zc3ihM3INcvkYUH6Zg5boZ4Ib
         Yi+QlhAAiBrmw3LRBvCP7/EAy2OVThDPoDkxJGtdoXZaE/rXYfldd6m079jTXoEIM7sQ
         AvzZQw0s69f5pqlksj1wSnSNiGy6butinnhiKzqWJd89Zv2JgNe7/EEgwZJnCsQILh8w
         5Ldw==
X-Forwarded-Encrypted: i=1; AJvYcCXGEZx+CJzm05j/DGOKr9yBzL0afCuB0BApZSPbMkhiI2rL7+4qUGfbVaoBt16Lvrh6SNClvC29xf279m3JJvKep5In8EIxnexp96eR
X-Gm-Message-State: AOJu0Yz8v/4c7HrcPcCSvJD8m4kSGXhMm56Tu3j/rgMRM7WPuHI6y1Sz
	LTwInXdAVRtViDdDzDnuygxVdX8n/sc87HBwXMgs/+ZiROGHPPXy7weLWf0d+z7DW7KJvzDhAjn
	cdA==
X-Google-Smtp-Source: AGHT+IFDl7XFIOm8A1NmS3vcwpT/MgK3tN/OkPbki64TqjyNIDNoD+ptTocUGrk3ulp5wCxMH2rUOUx0gmM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:4e41:0:b0:de5:53a9:384a with SMTP id
 c62-20020a254e41000000b00de553a9384amr504841ybb.13.1713881425302; Tue, 23 Apr
 2024 07:10:25 -0700 (PDT)
Date: Tue, 23 Apr 2024 07:10:23 -0700
In-Reply-To: <ZiMHu--agdvt4Rl1@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1713559768.git.jpoimboe@kernel.org> <9d3c997264829d0e2b28718222724ae8f9e7d8b4.1713559768.git.jpoimboe@kernel.org>
 <ZiMHu--agdvt4Rl1@google.com>
Message-ID: <ZifBT9N0QivOZ2L_@google.com>
Subject: Re: [PATCH v4 2/5] cpu/speculation: Fix CPU mitigation defaults for !x86
From: Sean Christopherson <seanjc@google.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Nikolay Borisov <nik.borisov@suse.com>, 
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 19, 2024, Sean Christopherson wrote:
> On Fri, Apr 19, 2024, Josh Poimboeuf wrote:
> > CPU speculative execution mitigations were inadvertently disabled on
> > non-x86 arches by the following commit:
> > 
> >  f337a6a21e2f ("x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n")
> > 
> > Fix it by replacing CONFIG_SPECULATION_MITIGATIONS with a new generic
> > CONFIG_CPU_MITIGATIONS option and moving the x86-specific mitigations to
> > a separate menu which depends on CONFIG_CPU_MITIGATIONS.
> 
> Ah drat, I didn't check my mailbox until after Cc'ing Linus my own version[*].
> 
> I don't have a strong preference between the two, though I do think it's worth
> nothing that this will (obvioulsy) allow disabling mitigations at compile time
> on all architectures, which may or may not be desirable.
> 
> [*] https://lore.kernel.org/all/20240420000556.2645001-2-seanjc@google.com

Josh, when you get a chance, can you weigh in on my menu-preserving approach?

I want to get this resolved asap so that we're not scrambing on Friday again :-)

