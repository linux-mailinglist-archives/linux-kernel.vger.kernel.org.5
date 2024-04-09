Return-Path: <linux-kernel+bounces-137636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9515689E4DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09DA1C2189E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD2A158A07;
	Tue,  9 Apr 2024 21:21:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9D938DC9;
	Tue,  9 Apr 2024 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712697687; cv=none; b=W97BRZZUDq1iRATssq1sLryU7ITN28Udp9K5WlmWnAfyUg8gRFqewc4FkYXEEldjAVxROvrQf8NJNQV18bX6vw2dTt0FwjYMqAQH/JlCqmOuqdBKSmdZ2vtsAR1j5IdmK6nsRvCSw5cNHMAFztOHQcJ20tSfDMWxHt+hFcQDfR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712697687; c=relaxed/simple;
	bh=eqOTlSxbGZgE/xs+yZM0Bgc6tICu1cceOLKGt81zjRg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rV2A9tRCQ8f+sGg4laFVspAogO1jNf1CX61PZ59QrfxIN/wVJK7H1yD0IOirFCMad/dMqP5CyW3Mp2blaOoFHew09UQjr1hnPArrq8dOtRBbvhccpO9yqJF9zGkycWqwcvpX2H6APhSD/Vn3aKWS2JvcXAzA9j294EQjhOgQ+nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4725C433C7;
	Tue,  9 Apr 2024 21:21:23 +0000 (UTC)
Date: Tue, 9 Apr 2024 17:23:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Lorenzo
 Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Ross
 Zwisler <zwisler@google.com>, wklin@google.com, Vineeth Remanan Pillai
 <vineeth@bitbyteword.org>, Joel Fernandes <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Linus Torvalds
 <torvalds@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 0/2] pstore/mm/x86: Add wildcard memmap to map
 pstore consistently
Message-ID: <20240409172358.34ea19f0@gandalf.local.home>
In-Reply-To: <20240409210254.660888920@goodmis.org>
References: <20240409210254.660888920@goodmis.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Apr 2024 17:02:54 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

>   memmap=12M*4096:oops   ramoops.mem_name=oops

I forgot to mention that this makes it trivial for any machine that doesn't
clear memory on soft-reboot, to enable console ramoops (to have access to
the last boot dmesg without needing serial).

I tested this on a couple of my test boxes and on QEMU, and it works rather
well.

-- Steve

