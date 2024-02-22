Return-Path: <linux-kernel+bounces-77194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3241A860203
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AADD7B2CF38
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372DC548E4;
	Thu, 22 Feb 2024 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SPxMkg3Z"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABB814B817
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627414; cv=none; b=ke+jZYTcUU6VrAi1KVTgNqe+nFDlL3LxCSaiqjgugiqp7kmj1FJO1WA+o0ZSvKo0KsKGM3c3tk4rjRaNcFyTG9lVoO3aBFQ6ls6LSN2O76plGUaJ6DmzWwXvF5mLq3G2WhZ4hVvuQasA/hOIoRwPhbPdLE5nZ2k5CIbH33zGc4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627414; c=relaxed/simple;
	bh=8NLzBUI9VMl4Y6yjlgAyBN2B5MIctTr3P4tBWjtWL8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ON5mGw7kWzI9/msFOlOO5z/edMDciKLnO6CCGS7eB0Q+JruGAdaVa1uhShyH9/97tUcXq+yYV0SPQbRJKYArHOanok9xPeB7AnzCXoWD69dCp3q/aFdizednAheVMi60rITjgWcGjbYN3S8gEugPIMP+N0hYrBuC2KffVbhCuIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SPxMkg3Z; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc05887ee9so1439276.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708627412; x=1709232212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vtwP2XS9ou6pEJ1RLzQIqe0uI1z5AHU3SBLD09pMwP4=;
        b=SPxMkg3ZoRu6qf/ymMZFaetJEW9dHNeMKbOs3wPiz3VcPCBdaaptQkiyrmR54E2iin
         qJcKlHp8bbRbV54cs5boido6xR59E6gYiVZJ5sNkffJiAgPNfvWqX/uojtAoZwMfhvU6
         MoauX0DRcutXG6Js4GXhcVsvbrttXICAtS4LGlrir3/eKGHz4gm8sfeoVZZGYGTzI6Vm
         A5/xvaTEV5GB0uEmjL7D6v0L2az3cR7tAZzy9z0hGtbcK77dEdYORHnqzFTM9bqVbG0/
         ENBVZDMTfkfZLO9kPrezglCfgQwojY0lvVbNx/hw2BayV38rd2A0oJAqwKlCtb+yjM3u
         YPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708627412; x=1709232212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vtwP2XS9ou6pEJ1RLzQIqe0uI1z5AHU3SBLD09pMwP4=;
        b=pU97jzxiSisOlBiKf+6nqqNLTRXaZcb4fFJdkEAIj/ymcDfE6YmkKlUvINDC7VJTNS
         duWO0jdaOLQe4aPDvmie90VTZFvx+Y1f61MmLsgVNhzFbYX9s6d7YZvJ4Tgz8CjRaq4x
         cjgcJ1slTTAUBPJBz9Jk52ayeaoJYLLZJ/Lg4er1YRyxt339SryC9caIO74tRP8ATKp3
         6M0noXKhAIhFEZXEMqsQ3b5E5w1j3Kv5GZyAbroXIhFBgst/ppzFVgs0POTqnIQRFQOm
         BrpcVteiCg6RnAFTvVbXkK1aSJ7yhTtPzNYhzBQpZrvgg1yCFrZT8Qk/FeAu6b2CQfoD
         PH0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtUdAwQcxhRKKPujbx91qrXAn+qDeiA49G8LA0AEHPhFBtnaBDxY/G7R0xAeCi3GFgFn1eR597Wgiy3hwcWvbmsH23xOtYCvdkSk9w
X-Gm-Message-State: AOJu0Yy4F7E4BwnaQ4+Ob34zIKWFUyK+WoHJJ6XSaPYhVnrdsS9Nvteb
	op5bRBswBxUMXxbj89x0A9pdBLZNPnvtW1xacnOfOyVqZEq1HyhgLJkmvjPhQlMz0yZGRsuojs7
	7FVsMKtrhwxZm8hr2Hg==
X-Google-Smtp-Source: AGHT+IG0Dpc0HqUIEH2QaxU8zdGkOicjs62MCVp5oWNs1mYFM729U+8fzSFZDybDPzCTW48XhDCgyw3UZZzaymK9
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:1245:b0:dbe:30cd:8fcb with
 SMTP id t5-20020a056902124500b00dbe30cd8fcbmr219ybu.0.1708627411906; Thu, 22
 Feb 2024 10:43:31 -0800 (PST)
Date: Thu, 22 Feb 2024 18:43:30 +0000
In-Reply-To: <88cb9996-0e9b-49ec-bc94-f816a5b64870@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126080644.1714297-1-yosryahmed@google.com>
 <20240126080644.1714297-2-yosryahmed@google.com> <88cb9996-0e9b-49ec-bc94-f816a5b64870@intel.com>
Message-ID: <ZdeVwiaPvUVQRiWJ@google.com>
Subject: Re: [PATCH 2/2] x86/mm: clarify "prev" usage in switch_mm_irqs_off()
From: Yosry Ahmed <yosryahmed@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 22, 2024 at 08:48:17AM -0800, Dave Hansen wrote:
> On 1/26/24 00:06, Yosry Ahmed wrote:
> > +/*
> > + * The "prev" argument passed by the caller does not always match CR3. For
> > + * example, the scheduler passes in active_mm when switching from lazy TLB mode
> > + * to normal mode, but switch_mm_irqs_off() can be called from x86 code without
> > + * updating active_mm. Use cpu_tlbstate.loaded_mm instead.
> > + */
> > +void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
> >  			struct task_struct *tsk)
> 
> One nit here: It's not obvious that "unused" is 'the "prev" argument'.
> 
> Would something like this be more clear?
> 
> /*
>  * This optimizes when not actually switching mm's.  Some architectures
>  * use the 'unused' argument for this optimization, but x86 must use
>  * 'cpu_tlbstate.loaded_mm' instead because it does not always keep
>  * ->active_mm up to date.
>  */

Yes, this is more clear, thanks! However, Andrew already merged that
patch into mm-stable, so it cannot be amended. I can send a separate
patch to rewrite the comment tho if you'd like, WDYT?

> 
> Also, I think it might be useful to have the rule that arch/x86 code
> _always_ calls switch_mm_irqs_off() with the first argument (the
> newly-named 'unused') set to NULL.  I think there's only one site:

Agreed. I can also send a separate patch for this. Thanks!

> 
> > void switch_mm(struct mm_struct *prev, struct mm_struct *next,
> >                struct task_struct *tsk)
> > {
> >         unsigned long flags;
> > 
> >         local_irq_save(flags);
> >         switch_mm_irqs_off(prev, next, tsk);
> >         local_irq_restore(flags);
> > }
> 

