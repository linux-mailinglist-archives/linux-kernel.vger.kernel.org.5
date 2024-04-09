Return-Path: <linux-kernel+bounces-137686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F03389E5EA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01101F23C45
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE1D158DB3;
	Tue,  9 Apr 2024 23:09:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDEC158DBF;
	Tue,  9 Apr 2024 23:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712704164; cv=none; b=FPkkuv67qnd/CdteoUa/g+PjU82RTI6o+j1ROZNrXwy+6YesuCeFt8HruJM07uohzJsYbYHfLLzFFeo/3yBOi3mx/lcrKm1KOUYVM8/fCUo91duRK9V7gvw8zfc+G2ZNGiSCZ7yDDRDHg6+8GJpYEzH07e3WTXUWlfHWdEucRwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712704164; c=relaxed/simple;
	bh=9fQdU5nAO7R939RxH7SSdOIQ3j5lyXRYukuzfa+NXNE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=blyn0vpdpCIWQkgS5qyUmw08s72EvbubneMG8yfoZBRmzxVvARjmtgF3e0P4iTC1uhHOdVtAOof5zFObN/6XZNcXHoJP6bRCitccTJCMqrSpbJvtI7KwwJ+EfYQRPWzHLykT9JAjexQFB1YHWfGpzrtn+mm96UlczuKO/69Ge2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4227CC433C7;
	Tue,  9 Apr 2024 23:09:21 +0000 (UTC)
Date: Tue, 9 Apr 2024 19:11:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Tony Luck
 <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Ross
 Zwisler <zwisler@google.com>, wklin@google.com, Vineeth Remanan Pillai
 <vineeth@bitbyteword.org>, Joel Fernandes <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Linus Torvalds
 <torvalds@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 1/2] mm/x86: Add wildcard * option as
 memmap=nn*align:name
Message-ID: <20240409191156.5f92a15c@gandalf.local.home>
In-Reply-To: <202404091521.B63E85D@keescook>
References: <20240409210254.660888920@goodmis.org>
	<20240409211351.075320273@goodmis.org>
	<202404091521.B63E85D@keescook>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Apr 2024 15:23:07 -0700
Kees Cook <keescook@chromium.org> wrote:

> Do we need to involve e820 at all? I think it might be possible to just
> have pstore call request_mem_region() very early? Or does KASLR make
> that unstable?

Yeah, would that give the same physical memory each boot, and can we
guarantee that KASLR will not map the kernel over the previous location?

-- Steve

