Return-Path: <linux-kernel+bounces-96456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82462875C6D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13233B22111
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2252C19E;
	Fri,  8 Mar 2024 02:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqZbjDY4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235BA28E2B;
	Fri,  8 Mar 2024 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709865949; cv=none; b=PkEIYf1LWt5PQF/T9p8dRzN91KWBpTO0bdMnmNGq10t+d80ENzYeFCm4pW/D3ZyTulV/MsTaAzeJlehAV+hB4wBdEdg+QGEVcj34We5swI5jUazxYfliCgdYkvnFwMB4dRojaWbZWLgFZTXCcgOuGXDLuEoreuNJf6XDMp4C2WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709865949; c=relaxed/simple;
	bh=2SdxiaeGtNw8ZL8rSHb9UwvioaglRELLWCMNjA9ewV8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=spxcsuYgJTU5wzRwOBPuv212w95T8Dxnr7cX3CuFHvOM7KCOSzuBL3YcOlXoT7yQS0kGXJXsxTGmZ/zEycx0hq6dV92p0AHx/6Qcl9MeClKzF2jLuMhYbMbFkDGeJ7ygCB+cPKRbRlQlGdzzXf1USw8LM6Rsf1y7nwz3j3DNuKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqZbjDY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC47C433F1;
	Fri,  8 Mar 2024 02:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709865948;
	bh=2SdxiaeGtNw8ZL8rSHb9UwvioaglRELLWCMNjA9ewV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cqZbjDY4L7g5r6xj3Eoen0G8x5DbPRSTtonwnjXVjBhS0JesrWx71+ldQQeIEWcH1
	 9GKZ40B4eFBe0f/O8TpV7mfb+HQ9EhumjAeyxruS40/02cgWENxZ7QpllwtfplaOHD
	 oNUawLcKb9IIGR+cssMht0PyWcojdHfk2D9yT1qM3Hl8aF79pBAp+zBEjhTYNWRrFY
	 ij5CZaVVWZBhtZILlajIXVstuhpEPdeseyWJ9PtuhnvhqyLTHvYOHVuHisu486IC/h
	 aNGjWovVze51DeWNCrT2SR3PIDbrfm/5lNu5IgkX2S+6aewRL1iGrUD1r/p2ep2AIg
	 vxqePhFkBxH4A==
Date: Fri, 8 Mar 2024 11:45:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Calvin Owens <jcalvinowens@gmail.com>, Song Liu <song@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Mike Rapoport
 <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexei
 Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Naveen N Rao
 <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, David S Miller <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, bpf@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/4] Make bpf_jit and kprobes work with
 CONFIG_MODULES=n
Message-Id: <20240308114542.6eafe78de8969ba33affd41d@kernel.org>
In-Reply-To: <ZejhcP_r5QJZcS6j@bombadil.infradead.org>
References: <cover.1709676663.git.jcalvinowens@gmail.com>
	<ZejhcP_r5QJZcS6j@bombadil.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Wed, 6 Mar 2024 13:34:40 -0800
Luis Chamberlain <mcgrof@kernel.org> wrote:

> On Wed, Mar 06, 2024 at 12:05:07PM -0800, Calvin Owens wrote:
> > Hello all,
> > 
> > This patchset makes it possible to use bpftrace with kprobes on kernels
> > built without loadable module support.
> 
> This is a step in the right direction for another reason: clearly the
> module_alloc() is not about modules, and we have special reasons for it
> now beyond modules. The effort to share a generalize a huge page for
> these things is also another reason for some of this but that is more
> long term.

Indeed. If it works without CONFIG_MODULES, it may be exec_alloc() or
something like that. Anyway, thanks for great job on this item!

> 
> I'm all for minor changes here so to avoid regressions but it seems a
> rename is in order -- if we're going to all this might as well do it
> now. And for that I'd just like to ask you paint the bikeshed with
> Song Liu as he's been the one slowly making way to help us get there
> with the "module: replace module_layout with module_memory",
> and Mike Rapoport as he's had some follow up attempts [0]. As I see it,
> the EXECMEM stuff would be what we use instead then. Mike kept the
> module_alloc() and the execmem was just a wrapper but your move of the
> arch stuff makes sense as well and I think would complement his series
> nicely.

yeah, it is better to work with Mike.

Thank you,

> 
> If you're gonna split code up to move to another place, it'd be nice
> if you can add copyright headers as was done with the kernel/module.c
> split into kernel/module/*.c
> 
> Can we start with some small basic stuff we can all agree on?
> 
> [0] https://lwn.net/Articles/944857/
> 
>   Luis


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

