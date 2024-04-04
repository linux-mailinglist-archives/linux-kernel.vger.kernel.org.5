Return-Path: <linux-kernel+bounces-131807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283C0898BFD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C81DBB2B50D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D4812B148;
	Thu,  4 Apr 2024 16:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wDbkKZXL"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1FC71734
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712247529; cv=none; b=XFZh77gS3raLYHNK9+hgv5vyM1cBMheLlfNj0o7c7qUxSlXSyT/wKXo0K+XIhuxyqf3SRm45exvLaXkDFWeX0Gpg2WD5ttAlMIMV/yCTXUBR4nwOzg6X9qnkE+1yV285tCydvxfa5LZ7LwYYiGp5593fhGbSHyqNLOlIMpRcAcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712247529; c=relaxed/simple;
	bh=ni9ef8/m9sbD2y1ei5GZR7E9mc/Du+rMHCoorxfhMe4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pa96d6wtol5Lze6UjkSLXELhpr3LwHBTWIdH5S8eqbaDtFLscaSwGblvIZy4B+yJvPAdER/9N5Zcop7wmZDhm+2XkweHCics+3/MNZ7pKjGD3o0IzwJUeLR3C5rcp8YAbj/bgXaEhSvLJu+hg7srD6bcaaBvsV5DbMqwf7vo4u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wDbkKZXL; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d8dbe37d56so1028741a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 09:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712247527; x=1712852327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iVwR60M09qp3eNkKBsyNij7ZpEjKjJ0flnXDpzKp76o=;
        b=wDbkKZXLfKzxHt33oJWa05hJCPn+K8t8E8VNrofIflKRX7wd2KIUJiB6FxOQnE6CR/
         Bc+eJ4kk5jUwrcSaL5YNLDHMEyppSc1/MRNwe8hv1tNvh4VTvtLu6HYmDXjliYvynwhp
         VyaOQ+l75An+A6+4+D8FbS4wTnPTVUJmlAtA/mis2aVoFUmNTC+BuJKAyAnWn0BOXJzs
         XIKlxGHqKdvOFqL0c4pPpZFBdT5JLISAfMdy/QSNL/Ax8xzFKW+kv9Km61NK/RkTowTV
         fIwr2WiusfOY3hGt4GQY1T9Hqrjuedvu2YhqvpRBIhzjo59BVXTpA6muMrljpgQF85KV
         XR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712247527; x=1712852327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVwR60M09qp3eNkKBsyNij7ZpEjKjJ0flnXDpzKp76o=;
        b=k6wkmPi3JeHW1Zm8hEzD39JoVhw6YtBUn2ysd+01QWuE0M4K9DU7KGQON5HLMl0v3a
         87Qs1jSMcrnJFmjyWqp7QOOBOCCAaym9enQvfgiSdzSMU97RNrHGm8Nl6qCA8Ra0tPFI
         7KGYeglKUKYoCU+f4Bv6on358GrMi3cSHWLAlBe63uJ2arw7TxpoEXyIiZ0TINd58sWj
         j4fk+kAFj915QYwu5WY9XqHT4bi5tclxVkFlY2NJD3pNr9AANE0R5f82oJ+dLP4W7nnP
         H4EztMNa1DqZoAMj3qajvgtqOkCr6H/oT0fcSWGf6EBY1JcjKY8TvynD03ShM/OJrEDk
         WP7A==
X-Forwarded-Encrypted: i=1; AJvYcCVavXDjOzkTNjKZG/+f/FhaYHjGqTjta9pyGlEUnDFNrBMqujLS740fjxXQcyt2h54dwwZ1mKqfVcOF9kqlqj5j8WSn8VXL0OcHQo1n
X-Gm-Message-State: AOJu0YxCkZ/zLR8EmYTYY+F5g34RcO0f05eaVkLd9TCxQWJ8nT47EzqN
	tvPjnboJyzVfAL3y5hSgdV37J57HPY0Wf7II0ophiJUndFFtN7HJWY8ZrUIcFDzKmQWrp1LMJmb
	NiA==
X-Google-Smtp-Source: AGHT+IH4lxIIGygCtPnjXkuaPIjBewuPAVBUw031r3nTYKt3ZePYzHSUJqrxURNuSVSr34EiZC9lyoOsXUQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:9a41:0:b0:5dc:11fe:525f with SMTP id
 e1-20020a639a41000000b005dc11fe525fmr8407pgo.6.1712247527094; Thu, 04 Apr
 2024 09:18:47 -0700 (PDT)
Date: Thu, 4 Apr 2024 09:18:45 -0700
In-Reply-To: <SN6PR02MB41576028614CB7FE9A11EBEBD4362@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240324190503.116160-1-xry111@xry111.site> <SN6PR02MB41576028614CB7FE9A11EBEBD4362@SN6PR02MB4157.namprd02.prod.outlook.com>
Message-ID: <Zg7S5dk3J4Zc82nj@google.com>
Subject: Re: [PATCH v2] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
From: Sean Christopherson <seanjc@google.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Xi Ruoyao <xry111@xry111.site>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 25, 2024, Michael Kelley wrote:
> >  static void setup_pcid(void)
> >  {
> > +	const struct x86_cpu_id *invlpg_miss_match;
> > +
> >  	if (!IS_ENABLED(CONFIG_X86_64))
> >  		return;
> > 
> >  	if (!boot_cpu_has(X86_FEATURE_PCID))
> >  		return;
> > 
> > -	if (x86_match_cpu(invlpg_miss_ids)) {
> > +	invlpg_miss_match = x86_match_cpu(invlpg_miss_ids);
> > +	if (invlpg_miss_match &&
> > +	    invlpg_miss_match->driver_data > boot_cpu_data.microcode) {
> >  		pr_info("Incomplete global flushes, disabling PCID");
> >  		setup_clear_cpu_cap(X86_FEATURE_PCID);
> >  		return;
> 
> As noted in similar places where microcode versions are
> checked, hypervisors often lie to guests about microcode versions.
> For example, see comments in bad_spectre_microcode().  I
> know Hyper-V guests always see the microcode version as
> 0xFFFFFFFF (max u32 value).  So in a Hyper-V guest the above
> code will always leave PCID enabled.

Enumerating broken PCID support to a guest is very arguably a hypervisor bug.
Hypervisors also lie to guest about FMS.  As KVM *user* with affected hardware
(home box), I would want the kernel to assume PCID works if X86_FEATURE_HYPERVISOR
is present.

