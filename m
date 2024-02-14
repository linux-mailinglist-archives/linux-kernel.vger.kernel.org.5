Return-Path: <linux-kernel+bounces-64918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C238544A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88C381C21156
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E874B12B88;
	Wed, 14 Feb 2024 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cY4dZpoJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81994125D8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901693; cv=none; b=RUqEX5gW6yfqVwNFhfqY+oiiQNL7xxlMVLtL+ihGGZay0+Esu8c3dvKqBPmEEEdY3U+OGwe6K9UMNbim1JOkJ25qTzwSuzgdgL2qQqz929+TXdXRTU6l6SNvqdQxC9UcAFjcurY2+h2NAc8zUZNg8U8/d0QV5IdcPcRUP+cCIBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901693; c=relaxed/simple;
	bh=kq/xmzAzKkUX78zjj0NkaRIDOtPMjRiEEzYBBwwezNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGtyQGaJj5gIzjLtSQMZgKUvpRDvo63kOXy/6dML3rcldskWoO0mmSjU+iFCvVTimxatFBChw8jktuFTzoEoQWlw5oYfXs1+wVetCl700CeNv7zjgXWzN1rgjVIDifNxiPEsxN1qATSo4Kp9RmIgk2eeOX+U+PKIWkSYkTbvvlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cY4dZpoJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707901690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=frqZnAYmgYrPXNleQrtqcCNsHybPmVHtjDk3LAxHiiw=;
	b=cY4dZpoJjohzTQCh3UJSs/dz2uDJfAMiut8YOQhEckQMqPqNL4nB7CzNyDxw0LrUo5pTvJ
	+kytnUPeTvRxmAQwMmC2utm7TClNFCcxyW7g94yHKZv0m94K6vfgKs0YBR0bqYZMR90CKj
	kywuKY1xF4U2sc3FbIxfhPWweNItG6s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-kuMuO2gqPHyQs9PaL7UNKQ-1; Wed, 14 Feb 2024 04:08:05 -0500
X-MC-Unique: kuMuO2gqPHyQs9PaL7UNKQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A10B185A785;
	Wed, 14 Feb 2024 09:08:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.0])
	by smtp.corp.redhat.com (Postfix) with SMTP id 7BF6C492BC6;
	Wed, 14 Feb 2024 09:07:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 14 Feb 2024 10:06:46 +0100 (CET)
Date: Wed, 14 Feb 2024 10:06:41 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: coverity-bot <keescook@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: __do_sys_pidfd_send_signal(): UNINIT
Message-ID: <20240214090640.GB14017@redhat.com>
References: <202402131559.B76A34B@keescook>
 <ZcwGua3a9Z8nJXVq@tycho.pizza>
 <20240214090332.GA14017@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214090332.GA14017@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 02/14, Oleg Nesterov wrote:
>
> On 02/13, Tycho Andersen wrote:
> >
> > I think this is a false positive, we have:
>
> Agreed,
>
> > That said, a default case wouldn't hurt, and we should fix the first
> > comment anyways, since now we have extensions.
> >
> > I'm happy to send a patch or maybe it's better for Christian to fix it
> > in-tree.
>
> I leave this to you and Christian, whatever you prefer. But perhaps we
> can simplify these checks? Something like below.

forgot about -EINVAL ...

Oleg.

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3876,10 +3876,6 @@ static struct pid *pidfd_to_pid(const struct file *file)
 	return tgid_pidfd_to_pid(file);
 }
 
-#define PIDFD_SEND_SIGNAL_FLAGS                            \
-	(PIDFD_SIGNAL_THREAD | PIDFD_SIGNAL_THREAD_GROUP | \
-	 PIDFD_SIGNAL_PROCESS_GROUP)
-
 /**
  * sys_pidfd_send_signal - Signal a process through a pidfd
  * @pidfd:  file descriptor of the process
@@ -3903,13 +3899,23 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	kernel_siginfo_t kinfo;
 	enum pid_type type;
 
-	/* Enforce flags be set to 0 until we add an extension. */
-	if (flags & ~PIDFD_SEND_SIGNAL_FLAGS)
-		return -EINVAL;
-
-	/* Ensure that only a single signal scope determining flag is set. */
-	if (hweight32(flags & PIDFD_SEND_SIGNAL_FLAGS) > 1)
+	switch (flags) {
+	case 0:
+		/* but see the PIDFD_THREAD check below */
+		type = PIDTYPE_TGID;
+		break;
+	case PIDFD_SIGNAL_THREAD:
+		type = PIDTYPE_PID;
+		break;
+	case PIDFD_SIGNAL_THREAD_GROUP:
+		type = PIDTYPE_TGID;
+		break;
+	case PIDFD_SIGNAL_PROCESS_GROUP:
+		type = PIDTYPE_PGID;
+		break;
+	default:
 		return -EINVAL;
+	}
 
 	f = fdget(pidfd);
 	if (!f.file)
@@ -3926,24 +3932,8 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	if (!access_pidfd_pidns(pid))
 		goto err;
 
-	switch (flags) {
-	case 0:
-		/* Infer scope from the type of pidfd. */
-		if (f.file->f_flags & PIDFD_THREAD)
-			type = PIDTYPE_PID;
-		else
-			type = PIDTYPE_TGID;
-		break;
-	case PIDFD_SIGNAL_THREAD:
+	if (!flags && (f.file->f_flags & PIDFD_THREAD))
 		type = PIDTYPE_PID;
-		break;
-	case PIDFD_SIGNAL_THREAD_GROUP:
-		type = PIDTYPE_TGID;
-		break;
-	case PIDFD_SIGNAL_PROCESS_GROUP:
-		type = PIDTYPE_PGID;
-		break;
-	}
 
 	if (info) {
 		ret = copy_siginfo_from_user_any(&kinfo, info);


