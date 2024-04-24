Return-Path: <linux-kernel+bounces-157240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CCF8B0EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75351F22C15
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151A815FA81;
	Wed, 24 Apr 2024 15:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g7FIz2ep"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABFD1422AF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973722; cv=none; b=j6niHqBH+OIz9jXJ9aYGLxiug5T+QUpPP+hUykMaVtD5fPWSPGUN+sR9r5Q/Mfuhur69BpZ9f/1GcngZZfbai2vgutFIroENstYOxoALwwuoVz+GpzAiGuFJR4uL84BOOAMhVajx7UI0xoGuEeerNnL/zorqx3cTXyUq6UxCGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973722; c=relaxed/simple;
	bh=jqg5Fo1Agh7hM51ijesv5YFvMRtp1lD4hn9D9KkpZjc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lUFW8oetMPyidpNlZtKIRaGzvd0C+R2xeCbCiOPc+Bokdb1m0t09CEKpGoC7CaI057KsxqPzT/fV2oIi6M3G3OyUrq6gS03B527Q+HCwMp6CohfYmByBnlpa9KJfwJcQCpPxDqgZydw19xmwPArQ/AZQggStkP3wq8CCN6KHI2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g7FIz2ep; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de465caa098so15695276.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713973720; x=1714578520; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l+gT/b/2VDLIr0gptxkhB+Y4JKNs3jUP0dyl/dPQGpc=;
        b=g7FIz2epnGefg/HNRaAVmGAKLuDkMzpCiX0GEbhKi+fTwigqixUF7GN4JR5GFZA6t4
         nZZX6Nw/6SSbndBhrrEbqoLDFdJRg9yjshyoycZQfKIGUoNBA21wOcE3VlH9u2CnroeF
         xVOZb6DHvpOur0IHNrKBJ75srxCuQa7KHMRqsf9bVXl4zTfGKdbM+4YsBGK2rXE0uyOu
         ZhHzFmWbo0Dwi7epEpjWRWOh8nXEALlGNxgJYPcmcJdQNv0/UPoiJMBC58JUhIr270Z1
         /cPpi5QZbLcD11YBItssVyDKAjveZlyI3LRzhKqsmidHseJ/zK3x3jHmqLtlM/Esj5En
         wH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713973720; x=1714578520;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+gT/b/2VDLIr0gptxkhB+Y4JKNs3jUP0dyl/dPQGpc=;
        b=SNiq97wzDTGgZZftpNEI+8geZSF93xgIOPpczjMz64xDFEu5FzOkAR1GdGXDh2y7f4
         dURIrXG5ik2uwdnsbdkkG5bUCDysXK5+xVenS2iQW4XgwspDZxCPVzun6Sks5YUn+yon
         ebW/7unrNKs7SazQwWDbmi283uwVElEWy2xnXwUDex4Q76nsErFBWFzOs0nes2VIbyLd
         AdnQfd8Yk48ceA1wJ9wyfR4s3hwZwNhm7pmQ0Qto88mguXhbn1GUkWQTf67d0XU+Nq0u
         gyI+S/XGStXD9jVrScxAyxfr2foj7S+pu249L+EynkDGgu8SZXE6NtV/teLfYlDqdWhZ
         1MJw==
X-Forwarded-Encrypted: i=1; AJvYcCUrXh5Eb8U6NMQxjTGqD+stNuu+FweEAs6YK8+vY+4b5TnR+KrbSws5RVInIgyChxUQsRMSFlThufgNQ8iWPMJMLbdilJzfMkdb93aV
X-Gm-Message-State: AOJu0Yy85xDlsWjTjNXC0xvTcw/3Vb+qtMaQ4EkS5YzBw1KeaiNNd8Tq
	aBD0jdel6QADhaBg9iEG27hP5xCRftnVOa6YR7csEbEgXaW4ZZbxSJtNFSSmb0bm7TPLzrH7adN
	Hpg==
X-Google-Smtp-Source: AGHT+IExKySrR1s4Ud9PAy+cb98YYBcHMOgLDrDHHa34Z9UBMvLwK3yc+0vePOolgaxCWUfghuyi/UN0AAY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:154f:b0:de5:5be3:709f with SMTP id
 r15-20020a056902154f00b00de55be3709fmr258695ybu.6.1713973720058; Wed, 24 Apr
 2024 08:48:40 -0700 (PDT)
Date: Wed, 24 Apr 2024 08:48:38 -0700
In-Reply-To: <20240424134248.GCZikMWA8EvlhGEYC7@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240420000556.2645001-1-seanjc@google.com> <20240420000556.2645001-3-seanjc@google.com>
 <20240424053940.3ypivvztvv35dpu7@treble> <20240424134248.GCZikMWA8EvlhGEYC7@fat_crate.local>
Message-ID: <Zikp1sPVzoYVt00X@google.com>
Subject: Re: [PATCH v2 2/2] cpu: Ignore "mitigations" kernel parameter if CPU_MITIGATIONS=n
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Michael Ellerman <mpe@ellerman.id.au>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Will Deacon <will@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 24, 2024, Borislav Petkov wrote:
> On Tue, Apr 23, 2024 at 10:39:40PM -0700, Josh Poimboeuf wrote:
> > On Fri, Apr 19, 2024 at 05:05:55PM -0700, Sean Christopherson wrote:
> > > +#ifdef CONFIG_CPU_MITIGATIONS
> > >  extern bool cpu_mitigations_off(void);
> > >  extern bool cpu_mitigations_auto_nosmt(void);
> > > +#else
> > > +static inline bool cpu_mitigations_off(void)
> > > +{
> > > +	return false;
> > > +}
> > 
> > This should probably return true?

/facepalm

Glad you were paying attention, as I was clearly not.  I double checked that
flipping that to true does indeed force off mitigations.

> Right, I'll fix it up while applying and send them linuswards this
> weekend so that 6.9 releases fixed.

Thanks!

