Return-Path: <linux-kernel+bounces-153664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9D88AD15A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9651C1F2300C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB9F153579;
	Mon, 22 Apr 2024 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RI/wXfnh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C64615218D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801438; cv=none; b=MJ585zdn0L9l/766W86IXXMK8puBRb6Ktoz+tQCSk5oueafUbbc0EjE+0Ge7ep2VsW0PTopAWAa30FdG8+p7mf8LOmK2xLKa9E/CkGgtFTdfpZxRv33il18mf0bTzuK1pkv81kepuQ7p/eyY5m7MiHSIU5vTwC8BAbcvc1o05Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801438; c=relaxed/simple;
	bh=vOTtrQjeC7XaM50trnCEYdVH4ZodHQJt5bpJ/0mXWe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYm/4TktrTYqu+z7zgV73UJokJEFeQGVfr1B+zUfkJWK3TZLLWc6Z4aRGusjI8j1iGEr5XRgILNEEkbCKvQtqqw/r/M46ErzZJFAak+WI4aZCCFneRodGMxSDrJATnnGF3hz8CVlfGTDijpvDjIxWOJgzhsbwx0ZzOrFiT73/MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RI/wXfnh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713801436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Re0lafXu7wQslD0LP+mb5k+NPK2CcD7U/L0lGd24osU=;
	b=RI/wXfnhK1dG8qonzwv4rNbv89+9T118yoG6Jd42xPfQvz3K3itS67rYuIdJdGl+xyOd1C
	ZdeNXT1scGjHqVDW8RHfcgB9hojH0BYcot5Q0Rxe5Cfro/cZXmvgD+/Ww/tV4tFQ83cHxR
	8BIkngBB96qTDqSgcZmxDKsHfQuWlD0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-oFXsibcKO8e3VSnl-i3laA-1; Mon, 22 Apr 2024 11:57:11 -0400
X-MC-Unique: oFXsibcKO8e3VSnl-i3laA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05B1E104B502;
	Mon, 22 Apr 2024 15:57:11 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.205])
	by smtp.corp.redhat.com (Postfix) with SMTP id 954FD200E290;
	Mon, 22 Apr 2024 15:57:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 22 Apr 2024 17:55:45 +0200 (CEST)
Date: Mon, 22 Apr 2024 17:55:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCHv3 bpf-next 2/7] uprobe: Add uretprobe syscall to speed up
 return probe
Message-ID: <20240422155540.GA32422@redhat.com>
References: <20240421194206.1010934-1-jolsa@kernel.org>
 <20240421194206.1010934-3-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421194206.1010934-3-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 04/21, Jiri Olsa wrote:
>
>  arch/x86/kernel/uprobes.c | 115 ++++++++++++++++++++++++++++++++++++++
>  include/linux/uprobes.h   |   3 +
>  kernel/events/uprobes.c   |  24 +++++---
>  3 files changed, 135 insertions(+), 7 deletions(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


