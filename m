Return-Path: <linux-kernel+bounces-108405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1842B880A17
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158751C2215B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3574411717;
	Wed, 20 Mar 2024 03:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYwkd9zr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D64F101EC;
	Wed, 20 Mar 2024 03:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710904644; cv=none; b=TzrNzQbRs86Cmk5lFzdfYVIhd3tyPoz3+WZE2UFu4ae1mBrEQ243c/XyXX9wSg5VmTXdI3Af9mY/hplFC2sS1EnXJwLxhuX9OKv2SfMsNNOBTtm0h5yr6WPxP+ceWGLCQKscS46hDEb8hBglB422NddbgSvVfW0oHb4tfDULDkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710904644; c=relaxed/simple;
	bh=FHEe1pX8Lh1a2rackEtx2e+ZX13Jt6G1A6UdQ/Ju+3g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Oyehk7uCsDq8KwBh2K9dx70fjDSQAgOIDPuafbmydo8IK1oqnZrDnhz5mwDGSjhB70tgNmDTirvOOF1mktBcA7QQ95hAVHLeg8oPXrwEhJbTiCcK64L+xDMS/VjIaqU+JWGuqvSG1xUBsoRL9T6RJRhW4TnDI+752dZvXp8Ra/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYwkd9zr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57857C433F1;
	Wed, 20 Mar 2024 03:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710904642;
	bh=FHEe1pX8Lh1a2rackEtx2e+ZX13Jt6G1A6UdQ/Ju+3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AYwkd9zrRDoLsoiO+ozA12ei/PoImRASKbJ1GHi0THgDhXHEmpD0R+NT2mB1h9otg
	 9IUJABMpdYLtAMHoB75EgGVRQar/Uk01T9z0qWK7CLPHE8zLy5kVQrfgtTFNNgTK0b
	 Xi1W3CSTtcxuOyWKd95eqXdizb0O/UJds6F8azMGlmcGK/EN2g4dntbSkGjGdI1rDa
	 lF7fcGlfwkpHZkSof0rG4M+ZgpUiaBDaqEUMAuqSeOdovVOL0hsaSKzIVTe7+OFNs0
	 z19wuQmZwt1jHzL8H3cTh1xz3yVtlm++6MZxf4NGqtpCLatq9DvdiF+3ZcZ+XDdVl1
	 K5Dz/5ZuzFajg==
Date: Wed, 20 Mar 2024 12:17:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, bpf@vger.kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, oleg@redhat.com, jolsa@kernel.org
Subject: Re: [PATCH v2 0/3] uprobes: two common case speed ups
Message-Id: <20240320121717.eda8ecd602d8d153925e2236@kernel.org>
In-Reply-To: <CAEf4BzaFfQeD8TY7pXEyX4h5UeAg0HZpx8psJF=Z6GJmr3VF5w@mail.gmail.com>
References: <20240318181728.2795838-1-andrii@kernel.org>
	<20240319132057.78e60d15e4fd07dbef3b14a9@kernel.org>
	<CAEf4BzaFfQeD8TY7pXEyX4h5UeAg0HZpx8psJF=Z6GJmr3VF5w@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 19 Mar 2024 09:19:19 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Mon, Mar 18, 2024 at 9:21 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi,
> >
> > On Mon, 18 Mar 2024 11:17:25 -0700
> > Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > > This patch set implements two speed ups for uprobe/uretprobe runtime execution
> > > path for some common scenarios: BPF-only uprobes (patches #1 and #2) and
> > > system-wide (non-PID-specific) uprobes (patch #3). Please see individual
> > > patches for details.
> >
> > This series looks good to me. Let me pick it on probes/for-next.
> 
> Great, at least I guessed the Git repo right, if not the branch.
> Thanks for pulling it in! I assume some other uprobe-related follow up
> patches should be based on probes/for-next as well, right?

Yes, I'll pick those on linux-trace tree's probes/* branchs
(if there is an urgent patch, it will go through probes/fixes)

Thank you! 

> 
> >
> > Thanks!
> >
> > >
> > > v1->v2:
> > >   - rebased onto trace/core branch of tracing tree, hopefully I guessed right;
> > >   - simplified user_cpu_buffer usage further (Oleg Nesterov);
> > >   - simplified patch #3, just moved speculative check outside of lock (Oleg);
> > >   - added Reviewed-by from Jiri Olsa.
> > >
> > > Andrii Nakryiko (3):
> > >   uprobes: encapsulate preparation of uprobe args buffer
> > >   uprobes: prepare uprobe args buffer lazily
> > >   uprobes: add speculative lockless system-wide uprobe filter check
> > >
> > >  kernel/trace/trace_uprobe.c | 103 +++++++++++++++++++++---------------
> > >  1 file changed, 59 insertions(+), 44 deletions(-)
> > >
> > > --
> > > 2.43.0
> > >
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

