Return-Path: <linux-kernel+bounces-137689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE15F89E5F8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BE52832F0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239D8158DB3;
	Tue,  9 Apr 2024 23:13:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A683E157476;
	Tue,  9 Apr 2024 23:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712704423; cv=none; b=lUHHnKQkzXLq1Q30NQBDlXqiKIfUF6CX2RdFG50GAxayfsJ+kx0pPkMugrAvy4/9311zwXCfct2S+sdUrRGx6Ye2jMCVkagKl2olmd+U9RRmimo5W9rSE7moxbtNEQTEU95kQoYiJYidacNZAF0CQF+olSsQkCLhLDMQiAKXF9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712704423; c=relaxed/simple;
	bh=CJ+lHDADtVkRMon20/HuemR6BEfZyIXRXbufKIRrBxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFAfPM0bclLL2qH7DdMJoGBwUr+yogJPhJEwZHzHhMmq6tJurCSizbYdz/Y1GOBthI3K/sb0s/0VmSp3hw1mi0ztE63tE1rhPIadkoVpkVOudrGBKB1jJazuh4Xawl/EcVzSEH6P30/4+el1Gb6qS4FB8f/Xz5+IOaFIpoTCDY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C44BC433C7;
	Tue,  9 Apr 2024 23:13:40 +0000 (UTC)
Date: Tue, 9 Apr 2024 19:16:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Kees Cook <keescook@chromium.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra
 <peterz@infradead.org>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "Guenter Roeck" <linux@roeck-us.net>, Ross Zwisler <zwisler@google.com>,
 "wklin@google.com" <wklin@google.com>, Vineeth Remanan Pillai
 <vineeth@bitbyteword.org>, Joel Fernandes <joel@joelfernandes.org>,
 "Suleiman Souhlal" <suleiman@google.com>, Linus Torvalds
 <torvalds@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 0/2] pstore/mm/x86: Add wildcard memmap to map
 pstore consistently
Message-ID: <20240409191615.3e3b01d3@gandalf.local.home>
In-Reply-To: <SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240409210254.660888920@goodmis.org>
	<20240409172358.34ea19f0@gandalf.local.home>
	<202404091519.B7B2221@keescook>
	<SJ1PR11MB608317E066B6B3390F55FCB1FC072@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Apr 2024 22:25:33 +0000
"Luck, Tony" <tony.luck@intel.com> wrote:

> >> I forgot to mention that this makes it trivial for any machine that doesn't
> >> clear memory on soft-reboot, to enable console ramoops (to have access to
> >> the last boot dmesg without needing serial).
> >> 
> >> I tested this on a couple of my test boxes and on QEMU, and it works rather
> >> well.  
> >
> > I've long wanted a "stable for this machine and kernel" memory region
> > like this for pstore. It would make testing much easier.  
> 
> Which systems does this work on? I'd assume that servers (and anything
> else with ECC memory) would nuke contents while resetting ECC to clean
> state.
>

Well I tested it on a couple of chromebooks, a test box and a laptop (as
well as QEMU). I know that ramoops has an ecc option. I'm guessing that
would help here (but I'd have to defer to others to answer that).

-- Steve

