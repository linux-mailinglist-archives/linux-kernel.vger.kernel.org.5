Return-Path: <linux-kernel+bounces-22472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E96829E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CCA7B2176D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7194C61D;
	Wed, 10 Jan 2024 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxkDRf8S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E524C3C8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704902681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x1DSZje46czRQcMPRczBvCQW247SDADA2c7DsKeOHPc=;
	b=IxkDRf8S9Ht9ggMpVJ/UMzCrsaGqoFfP4unqcs+EoRcd0FGz8x+v8Z3uZdbL7bOjkeoMT6
	LwkA2lamP/MwbevvKi/0lw/DiZ9oVHn2hPK/QejbQ37mfwmXS6oRrwuHY+Odow1HOG1hqD
	3UWNYhCD8P9y4De4hkPvYixTuEKDCso=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-Nnfzvt3fMIafSlUxoPodVw-1; Wed,
 10 Jan 2024 11:04:38 -0500
X-MC-Unique: Nnfzvt3fMIafSlUxoPodVw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E5A64380628C;
	Wed, 10 Jan 2024 16:04:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.80])
	by smtp.corp.redhat.com (Postfix) with SMTP id 65D24C15E6A;
	Wed, 10 Jan 2024 16:04:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 10 Jan 2024 17:03:24 +0100 (CET)
Date: Wed, 10 Jan 2024 17:03:20 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: syzbot <syzbot+c6d438f2d77f96cae7c2@syzkaller.appspotmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, luto@kernel.org,
	michael.christie@oracle.com, mst@redhat.com, peterz@infradead.org,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: [syzbot] [kernel?] WARNING in signal_wake_up_state
Message-ID: <20240110160319.GA21002@redhat.com>
References: <000000000000a41b82060e875721@google.com>
 <CAHk-=wgM=MmqrQC-qgXoSehW=itHaqOUiBfN8jRBGAHn1=D0tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgM=MmqrQC-qgXoSehW=itHaqOUiBfN8jRBGAHn1=D0tg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 01/09, Linus Torvalds wrote:
>
> Oleg/Eric, can you make any sense of this?
>
> On Tue, 9 Jan 2024 at 10:18, syzbot
> <syzbot+c6d438f2d77f96cae7c2@syzkaller.appspotmail.com> wrote:
> >
> > The issue was bisected to:
> >
> > commit f9010dbdce911ee1f1af1398a24b1f9f992e0080
>
> Hmm. This smells more like a "that triggers the problem" than a cause.
>
> Because the warning itself is
>
> > WARNING: CPU: 1 PID: 5069 at kernel/signal.c:771 signal_wake_up_state+0xfa/0x120 kernel/signal.c:771
>
> That's
>
>         lockdep_assert_held(&t->sighand->siglock);

I have a fever, possibly I am totally confused, but this commit added

+               /* Don't require de_thread to wait for the vhost_worker */
+               if ((t->flags & (PF_IO_WORKER | PF_USER_WORKER)) != PF_USER_WORKER)
+                       count++;

into zap_other_threads().

So it seems the caller can do unshare_sighand() before vhost thread exits and
actually unshare ->sighand because oldsighand->count > 1.

This is already very wrong (plus it seems this breaks the signal->notify_count
logic). IIRC I even tried to argue with this change... not sure.

And this can explain the warning, this task can start the coredump after exec
and hit vhost_worker with the old sighand != current->sighand.

Oleg.


