Return-Path: <linux-kernel+bounces-130002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3582C89730D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E102828DCE6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6370C1494A1;
	Wed,  3 Apr 2024 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+PGu/D8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1042F28
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155865; cv=none; b=IrXQ50dc+tOeQYxSR+j6uam2T4r/geGghQNOVL+Ogf4yAvW1Q5Rt/pQNY1BqCJY9tw92JuosHSHs0gavOOxUFL0ESQCflH7mvPe7myPUfn9EqNNyCwhgXUyuHrtBIUc3JOvGtf4Yvsrnoyh50g3Iqq+iL09sw9EhzCl/Dk3adpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155865; c=relaxed/simple;
	bh=92SXfEvrtPp+vOlUAxFGaSiGP4/h7INh9sOZhfYOXOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWVmrjXV4XkKpYYUBqAf/RF/w7EkKEieiKTAncQKEU8IoigsNk189WoTiF9dzHDc1FALaIwcHT3vh2k7cbwpG08HdLgpXAso2d3bQLpAPaiyM2baiAWugRINMjynJ/8U9eXHTmJ8onZ1ajKsiMjUNRK6g+j4YLZr0pZOOCP3raQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+PGu/D8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712155863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=92SXfEvrtPp+vOlUAxFGaSiGP4/h7INh9sOZhfYOXOs=;
	b=X+PGu/D8kf4b96u/jOKK9cp3QaARr7I/Ox2gCcanqizSo9QpDyUcKYyHtPJhU95hHAWTJD
	q0d5qjM375TaKdda87li8MjesSGtHnwC8AHRoCH2/03DgywsSjVQlL6I4Kdkkvj5q2rwbt
	u4Ml0DTtZg0cNnaelIn4WhoGDgf9mbA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-cqVAc2OTMwiuhbvn4k-66Q-1; Wed, 03 Apr 2024 10:50:59 -0400
X-MC-Unique: cqVAc2OTMwiuhbvn4k-66Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1F9B101A521;
	Wed,  3 Apr 2024 14:50:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.49])
	by smtp.corp.redhat.com (Postfix) with SMTP id 4928237FC;
	Wed,  3 Apr 2024 14:50:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  3 Apr 2024 16:49:34 +0200 (CEST)
Date: Wed, 3 Apr 2024 16:49:10 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20240403144910.GB31764@redhat.com>
References: <20240402093302.2416467-1-jolsa@kernel.org>
 <20240402093302.2416467-2-jolsa@kernel.org>
 <20240403100708.233575a8ac2a5bac2192d180@kernel.org>
 <Zg0lvUIB4WdRUGw_@krava>
 <20240403230937.c3bd47ee47c102cd89713ee8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403230937.c3bd47ee47c102cd89713ee8@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Again, I leave this to you and Jiri, but

On 04/03, Masami Hiramatsu wrote:
>
> On Wed, 3 Apr 2024 11:47:41 +0200
> > > set in the user function, what happen if the user function directly
> > > calls this syscall? (maybe it consumes shadow stack?)
> >
> > the process should receive SIGILL if there's no pending uretprobe for
> > the current task, or it will trigger uretprobe if there's one pending
>
> No, that is too aggressive and not safe. Since the syscall is exposed to
> user program, it should return appropriate error code instead of SIGILL.

..

> Since the syscall is always exposed to the user program, it should
> - Do nothing and return an error unless it is properly called.
> - check the prerequisites for operation strictly.

We have sys_munmap(). should it check if the caller is going to unmap
the code region which contains regs->ip and do nothing?

I don't think it should. Userspace should blame itself, SIGSEGV is not
"too aggressive" in this case.

> I concern that new system calls introduce vulnerabilities.

Yes, we need to ensure that sys_uretprobe() can only damage the malicious
caller and nothing else.

Oleg.


