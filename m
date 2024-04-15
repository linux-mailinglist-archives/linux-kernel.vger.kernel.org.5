Return-Path: <linux-kernel+bounces-145655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A4F8A5909
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517BE2842F2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C7C839E5;
	Mon, 15 Apr 2024 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n1/7fwws"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD81E8289E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 17:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201777; cv=none; b=m/6VyFt2jU3UNgXM8wIrQzFKqOWOxGTn998RxflvkQL5qQxEb35wVAuzCI6DtR8lU1Z1c6Kwms6M2mVXdzw6B8T95rpo+kdvZ+TahiSSNjQQF+5xAROLv4x6L1AQ1UIzBBGUgNHV75qU8JuwJfyb8jqjWbeD4ygqhCt/mHRc6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201777; c=relaxed/simple;
	bh=cVYE2ehOGt9AZu4lK44Xq/DDtOiFLWELDzP2xoxBwKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USS22RqUP7ZHpcT/VycsShzPIHhOOrCYjprYyKUpVXqshtaKlj/XUpDdxORin/bfMbNP1iD7hsr3eP76TYBbt0feI5v8AYJIpnhGMEPcfnEdOyxUhySuGT+ysGn8dRHX5vP6OL+KaINESnP/mSaDL6SQVjpzExH2V3zj4Hsl/58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n1/7fwws; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e2178b2cf2so32238535ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713201775; x=1713806575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LGAaJZA3Ieswr80lcknUKfoXzL8DxCdWx6U4KMKhO8=;
        b=n1/7fwwsz1foICewoRUWdT5xs8fB6NPWFGr0ktjY/VuOuhmhiUJFzqUk7Hh0CxPvax
         E5YisngVBin3djrd6DDhs4QCGQ3QzkFrCWfEDkLyfrJo6Rw1syIkQ4vSTaxW32o1JVNp
         BsyNyTkN7IyXA2SxPVivq380Pagf5FO7bMGXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713201775; x=1713806575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LGAaJZA3Ieswr80lcknUKfoXzL8DxCdWx6U4KMKhO8=;
        b=Obc2Tp9ttxnnuT6bge1Y4RAfUAqCv/1iXwAEst7gWE475Tz6d8e8GpS2QtJyWzC06i
         HiEGCQvZ3F6QmLdfZrXtsJVOenVI4mtsXOXcl9k7jyFUIx+YXQR9IUVEyev4ADhWdmCd
         omhLQjc43xcEjT+On4/CdfEvVTnjSijWloVSjPlYCN6fiteCaHiXeZf32vxMZVHDBtpE
         W+PcWMrH725PoG++s654a2COlNkfGc4sDWV3XHPUMfF+euo/cJRZqgHLsIvyaTZaGOEk
         +AFEVOmmsbsazKG/Ia5Nu2EOgydFKdMX1uHVngOi3eFw1XaTf9qwAOEObi9YyJzRxcom
         2/GA==
X-Forwarded-Encrypted: i=1; AJvYcCUVscx8fyjPTdV01+UR+bOg7fOSAJ5YXKE7Krf4iSQt13jBIT5tdMhINiiLBTVfsxUi0A6Ex9UcC969UqWu9j3X9CRS7Wcrkjf+PZV7
X-Gm-Message-State: AOJu0YwWeZFMpplAaziL622pwvp2x/orhYTDe9szgOQt+ZeEbNPVst3J
	DOCKukKVXRY+t9HY6Cp9AkZv3N3CQ24tsKo6NnwJKFdlKkCFpMB/8OQ4+g91XA==
X-Google-Smtp-Source: AGHT+IGecUmEOfE36Uzb8gHIAKlLpWNf+xF3BoTR88anSiFWvmiZTMlAPARou5mOFCGqDFBXXAVwXQ==
X-Received: by 2002:a17:902:e807:b0:1e4:1eea:a3ae with SMTP id u7-20020a170902e80700b001e41eeaa3aemr13173797plg.5.1713201775022;
        Mon, 15 Apr 2024 10:22:55 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902d50900b001dee4a22c2bsm8144525plg.34.2024.04.15.10.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:22:54 -0700 (PDT)
Date: Mon, 15 Apr 2024 10:22:53 -0700
From: Kees Cook <keescook@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Ross Zwisler <zwisler@google.com>, wklin@google.com,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 1/2] mm/x86: Add wildcard * option as
 memmap=nn*align:name
Message-ID: <202404151017.FC002AA5@keescook>
References: <20240409210254.660888920@goodmis.org>
 <20240409211351.075320273@goodmis.org>
 <202404091521.B63E85D@keescook>
 <20240409191156.5f92a15c@gandalf.local.home>
 <202404091638.2F98764A41@keescook>
 <Zhmgm86tzpanoweB@kernel.org>
 <20240412181940.3e1d99f7@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412181940.3e1d99f7@gandalf.local.home>

On Fri, Apr 12, 2024 at 06:19:40PM -0400, Steven Rostedt wrote:
> On Fri, 12 Apr 2024 23:59:07 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > On Tue, Apr 09, 2024 at 04:41:24PM -0700, Kees Cook wrote:
> > > On Tue, Apr 09, 2024 at 07:11:56PM -0400, Steven Rostedt wrote:  
> > > > On Tue, 9 Apr 2024 15:23:07 -0700
> > > > Kees Cook <keescook@chromium.org> wrote:
> > > >   
> > > > > Do we need to involve e820 at all? I think it might be possible to just
> > > > > have pstore call request_mem_region() very early? Or does KASLR make
> > > > > that unstable?  
> > > > 
> > > > Yeah, would that give the same physical memory each boot, and can we
> > > > guarantee that KASLR will not map the kernel over the previous location?  
> > > 
> > > Hm, no, for physical memory it needs to get excluded very early, which
> > > means e820.  
> > 
> > Whatever memory is reserved in arch/x86/kernel/e820.c, that happens after
> > kaslr, so to begin with, a new memmap parameter should be also added to
> > parse_memmap in arch/x86/boot/compressed/kaslr.c to ensure the same
> > physical address will be available after KASLR.
> 
> But doesn't KASLR only affect virtual memory not physical memory?

KASLR for x86 (and other archs, like arm64) do both physical and virtual
base randomization.

> This just makes sure the physical memory it finds will not be used by the
> system. Then ramoops does the mapping via vmap() I believe, to get a
> virtual address to access the physical address.

I was assuming, since you were in the e820 code, that it was
manipulating that before KASLR chose a location. But if not, yeah, Mike
is right -- you need to make sure this is getting done before
decompress_kernel().

-- 
Kees Cook

