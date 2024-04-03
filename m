Return-Path: <linux-kernel+bounces-129896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E91C8971CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1623A1F233A3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40807148FE4;
	Wed,  3 Apr 2024 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSFdrCeD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BAB14830F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152725; cv=none; b=RHRbIptK4J7x4MqEyO3rMxAUJEHQsMYZpoZDqLvu7A5GE4nx+ekVxekHyKeMuKqOma078UH0bbJQkfDACbvpxv+rpC/rLFGlC0jQFX4NwmenrdfHJwqlEOY/umRX7ZZvL+W50m0eKNA1426uy6oOK8VlLnWRH81kJspSh8hgACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152725; c=relaxed/simple;
	bh=SJSDM1jLJy1+bnkJOfwF5OrMRSMvyL4/cFh8OpRtlao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvRXVgE3rVU6H6f53kSo84qOgMILqv+4zMQyxbsywgBaZCsoX3zGbJf8ZkPeZswtSREZGbeSSuzvxpFZhM5RDwNBDs84LYf+I9V3pqZGerRc7FMERyngtFuzOCvmp25s4r/VR6/F0P9qyaVS9VeodMXbwFhBLTxU6o51A5tTW1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSFdrCeD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712152722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SJSDM1jLJy1+bnkJOfwF5OrMRSMvyL4/cFh8OpRtlao=;
	b=gSFdrCeDPZkb+DS0M20A6QSsp6gR+nA9j5i4RtPDEhVieBHlmybdv3ORmELLTPebgQkPsA
	QU2Ixan901/eklDwxv1wDuwbwWwbDiZLKvLvri6IHStnLP2q2L2xzxS+wrM28FwgCsHUMA
	ErkPAPkNpSCN27uuuaZMOlLhSjsUnyo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-814WLSUpN9-gkiUa8lOX-g-1; Wed, 03 Apr 2024 09:58:40 -0400
X-MC-Unique: 814WLSUpN9-gkiUa8lOX-g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77AF8879844;
	Wed,  3 Apr 2024 13:58:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.49])
	by smtp.corp.redhat.com (Postfix) with SMTP id 07B5B40C6CB5;
	Wed,  3 Apr 2024 13:58:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  3 Apr 2024 15:57:15 +0200 (CEST)
Date: Wed, 3 Apr 2024 15:56:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return
 probe
Message-ID: <20240403135650.GA31764@redhat.com>
References: <20240402093302.2416467-1-jolsa@kernel.org>
 <20240402093302.2416467-2-jolsa@kernel.org>
 <20240403100708.233575a8ac2a5bac2192d180@kernel.org>
 <Zg0lvUIB4WdRUGw_@krava>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg0lvUIB4WdRUGw_@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

I leave this to you and Masami, but...

On 04/03, Jiri Olsa wrote:
>
> On Wed, Apr 03, 2024 at 10:07:08AM +0900, Masami Hiramatsu wrote:
> >
> > This is interesting approach. But I doubt we need to add additional
> > syscall just for this purpose. Can't we use another syscall or ioctl?
>
> so the plan is to optimize entry uprobe in a similar way and given
> the syscall is not a scarce resource I wanted to add another syscall
> for that one as well
>
> tbh I'm not sure sure which syscall or ioctl to reuse for this, it's
> possible to do that, the trampoline will just have to save one or
> more additional registers, but adding new syscall seems cleaner to me

Agreed.

> > Also, we should run syzkaller on this syscall. And if uretprobe is
>
> right, I'll check on syzkaller

I don't understand this concern...

> > set in the user function, what happen if the user function directly
> > calls this syscall? (maybe it consumes shadow stack?)
>
> the process should receive SIGILL if there's no pending uretprobe for
> the current task,

Yes,

> or it will trigger uretprobe if there's one pending

.. and corrupt the caller. So what?

> but we could limit the syscall to be executed just from the trampoline,
> that should prevent all the user space use cases, I'll do that in next
> version and add more tests for that

Yes, we can... well, ignoring the race with mremap() from another thread.

But why should we care?

Userspace should not call sys_uretprobe(). Likewise, it should not call
sys_restart_syscall(). Likewise, it should not jump to xol_area.

Of course, userspace (especially syzkaller) _can_ do this. So what?

I think the only thing we need to ensure is that the "malicious" task
which calls sys_uretprobe() can only harm itself, nothing more.

No?

Oleg.


