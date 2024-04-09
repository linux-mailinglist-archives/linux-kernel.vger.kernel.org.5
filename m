Return-Path: <linux-kernel+bounces-137704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200F289E634
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433FF1C21508
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3990F158DD2;
	Tue,  9 Apr 2024 23:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hqexQfx3"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40635158D6F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706088; cv=none; b=OxgWYYVgGrYuk3UYkfyGHUs3rLvwPIHSCQIEoFrx/GLUVgBFyTnHmP0cflkJTc8lCA7nOOgBjHRlpkzdBuH+e1eMa7r/r8DvxMZWhf73BJF49X02AExB39JBaImFw7WyPY6/stvExKu5xKxAF4RPw1TXmgXi8VkMHptBbcfUcwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706088; c=relaxed/simple;
	bh=PNy0mBQjw8E74b5RpE2uI+eSralfxKJ9opohJxEN5zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AR1DLcAJBR0rjIw/iOx3lEYAgc48lt4GhE1ZzJmRjrHIYKhYUuBI9AB6oQbnWUfkXEELmwbYK88G1FHDeTZhy2yj+Kat+gpij5pFQdNFN2uIC2/4BrpArGYsEYQI69JdISfu40lkwWOv+UdEtTgc6L1czkDxuCKU96nDZ3pgrnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hqexQfx3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e419d203bdso19137825ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 16:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712706085; x=1713310885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=az80y3cRpLeKTQubgh3fpGGNWsXUAJ+YmKoEHWsOqi0=;
        b=hqexQfx3TXWIybb0PG+TlGC4BL56oWeQxCwLNoaRJrD358ZJ+3Dg+rn3/l2g0wGHT3
         VaJ2nI6OucpsafkPcxU9dQb912NbDVISiC6YWdcvhFwsHK4mRXWuVPXv/0fnjxklBUEh
         z/Xn5agxzzBNh29ohDarnfTFTm/D4/25nUGwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712706085; x=1713310885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=az80y3cRpLeKTQubgh3fpGGNWsXUAJ+YmKoEHWsOqi0=;
        b=JuyRAE5In3lQXQ4Ix+gb5DyjUWvQ6C0eatMIkBKsar9JxHkap/NvvRpkO+rzzn2vEJ
         LcPZef0Tr8pyKcl+P/yJMu07451WO0+TuIYabJuHru69kVWPPJLm+paMDCHM8QI9sKK/
         J+01B6NSaBUMdPk4ABn/oFvlynhmpkr1CLfg3o9hsqZvUGk3vOMvpfjOdhybybSeTr2o
         L25cu4u1MMRe7r/FP8StmC7GQHk1fBT+JYgbI8ppLO3L+vrgoJIEqwxtQd9z0d4Nuz4F
         Ciyq/TyEUMDpZ+2A/FoA48PFiH7/ASBjx/ngTT6hThvL2YvNKWcLEmvv/35uudjIRJg7
         5wwg==
X-Gm-Message-State: AOJu0YzElpE4cVMW/6dsi5VoqZDv4qs8l2GTW/brqPaw7kmfg7PBZRtK
	qjgDSVyqEXiA/L+WSsLGfAjz853cwqsntcrNmmI0tIwQiIpVOw6kFKDKxZvJ/g==
X-Google-Smtp-Source: AGHT+IHGg8Oq0FNDCNnUG12+MIKam5JOLm5lHVx4R8foCcBX//m7saHYLKuLVznN3ilAFFW+PI4EXA==
X-Received: by 2002:a17:903:98d:b0:1e1:214:1b7d with SMTP id mb13-20020a170903098d00b001e102141b7dmr1718191plb.61.1712706085513;
        Tue, 09 Apr 2024 16:41:25 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090301c600b001e43a00ee07sm4255351plh.211.2024.04.09.16.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 16:41:25 -0700 (PDT)
Date: Tue, 9 Apr 2024 16:41:24 -0700
From: Kees Cook <keescook@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
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
Message-ID: <202404091638.2F98764A41@keescook>
References: <20240409210254.660888920@goodmis.org>
 <20240409211351.075320273@goodmis.org>
 <202404091521.B63E85D@keescook>
 <20240409191156.5f92a15c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409191156.5f92a15c@gandalf.local.home>

On Tue, Apr 09, 2024 at 07:11:56PM -0400, Steven Rostedt wrote:
> On Tue, 9 Apr 2024 15:23:07 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> > Do we need to involve e820 at all? I think it might be possible to just
> > have pstore call request_mem_region() very early? Or does KASLR make
> > that unstable?
> 
> Yeah, would that give the same physical memory each boot, and can we
> guarantee that KASLR will not map the kernel over the previous location?

Hm, no, for physical memory it needs to get excluded very early, which
means e820. So, yeah, your proposal makes sense. I'm not super excited
about this be x86-only though. What does arm64 for for memmap?

-- 
Kees Cook

