Return-Path: <linux-kernel+bounces-64913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB327854495
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A63288709
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFBBAD4B;
	Wed, 14 Feb 2024 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZrgCXMeM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E411D13FEF
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901507; cv=none; b=dpL2pjuFoj7VZt7MRnopT3e7zBzyi5g2x+mFM091qQB6wXvJgw9j+rJCgWO0Kv6Z7mDGIcPSRdLTte32fVSNC0KoR4cUaxbyx3Kcwr4f9VX3k60B8/uQ1JKYA+lOqgQ66mknrRdKmF3xycUO3QJfrIG1WNF49QS1hN3CynRIP1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901507; c=relaxed/simple;
	bh=U1ZDBd7fTKy88hgKtIZUFJ1jWPAT0hPVgBoYs7PcoQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSvsknD9S4F6F2KILLiZpZxXAoZd+8g9Ae0cVe6mFGxuiDrkYVSEBdGK8adQL7lO2pCh6sq2aeUWKe+23uhz/qEKfYBkPVQFsqs2bU4SywNuuId+phH3MSr5sAmLbcnodpTguSejzVX7Ajiyv0fiThlUt5OI2KbG0oYnBvci6jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZrgCXMeM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707901504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8I13Yy1ZnXR0MIiHLrduxDxiApb0ZcnLJeAvn/Kr8OY=;
	b=ZrgCXMeMYy27+Ahc18BlZwMSyEozy4mG6f2Cd4psmDB+evaqqIgpiICsPcbP7WNHjm8NFK
	AGsdAedXGxbpnJDsGYweJZ/TZMy44asqu5FyYuOE1BuNYsFUpKa0ipOV1PEqQGNh7eHYK8
	YqhrpJDz+uNZec0rzLUYcYoVMNpkDlk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-UJ9Vona5M6m-jafFVF2hvQ-1; Wed,
 14 Feb 2024 04:04:57 -0500
X-MC-Unique: UJ9Vona5M6m-jafFVF2hvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B7063CBDF64;
	Wed, 14 Feb 2024 09:04:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.0])
	by smtp.corp.redhat.com (Postfix) with SMTP id C8DC1C185C0;
	Wed, 14 Feb 2024 09:04:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 14 Feb 2024 10:03:39 +0100 (CET)
Date: Wed, 14 Feb 2024 10:03:33 +0100
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
Message-ID: <20240214090332.GA14017@redhat.com>
References: <202402131559.B76A34B@keescook>
 <ZcwGua3a9Z8nJXVq@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcwGua3a9Z8nJXVq@tycho.pizza>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 02/13, Tycho Andersen wrote:
>
> I think this is a false positive, we have:

Agreed,

> That said, a default case wouldn't hurt, and we should fix the first
> comment anyways, since now we have extensions.
>
> I'm happy to send a patch or maybe it's better for Christian to fix it
> in-tree.

I leave this to you and Christian, whatever you prefer. But perhaps we
can simplify these checks? Something like below.

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
@@ -3903,13 +3899,21 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 	kernel_siginfo_t kinfo;
 	enum pid_type type;
 
-	/* Enforce flags be set to 0 until we add an extension. */
-	if (flags & ~PIDFD_SEND_SIGNAL_FLAGS)
-		return -EINVAL;
-
-	/* Ensure that only a single signal scope determining flag is set. */
-	if (hweight32(flags & PIDFD_SEND_SIGNAL_FLAGS) > 1)
-		return -EINVAL;
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
+	}
 
 	f = fdget(pidfd);
 	if (!f.file)
@@ -3926,24 +3930,8 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
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


