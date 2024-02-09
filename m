Return-Path: <linux-kernel+bounces-59342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3602384F59F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAE12B266D6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5032F376F7;
	Fri,  9 Feb 2024 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtEB4PyE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A443C463
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484065; cv=none; b=JptyN25OANcvvvzwBtSRw6EUXnsQ8mw3gXH0BvIDFtvnwp/MOaf40E3Nqect1by7BtRdA3CQezBtgknhKkZDTArkW7Mgxn4Q2t/vQ4Vi2nUZlqBj2xsZ/6BYPm2KVwAo2Pmltf1Y8WJIcYDbzWndPoba8Tt9PaYOJE4UcGNWjo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484065; c=relaxed/simple;
	bh=m8jassYfZl6tuikeSEiIX+a4C49CIDjBm1/1K7ahF9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CRhk/+EOvcYVoOpJf6yDCOGG30A2Cjv8g6oWdiY3cHn8exElfAwueZr5e4srFgdonsJuLp9gEMTDdGK0A/vuHLoWCzVB3ZEkQqRzsCetfci8qJK4tjiXV70i7ErkSgfM5ah+A1mOOTqX+C0hNfRKJMhMKFPljadndVEyPzrT5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CtEB4PyE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707484063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=+eBS2N7zPOjGNh6UoPh24dMf610glEZ74qIH328t8qY=;
	b=CtEB4PyEATliCUUSZlP4pTrlIlA50CtwTlYl8OiGdaYS3QjzaeSw36f1gNVtDaI2e4xr/C
	3LYrB08NHfXytgPEHrUIkjXZJujWgbrLyk1dVj4404MIamR4f4G8cBc16y/4RshJCBoSF+
	L9QpCEUpl8uTaPCGA+2S5O3wizWKmQ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-WBcllOQQNVe5MNt3f9wJEA-1; Fri, 09 Feb 2024 08:07:39 -0500
X-MC-Unique: WBcllOQQNVe5MNt3f9wJEA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F54D83B7E5;
	Fri,  9 Feb 2024 13:07:39 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.84])
	by smtp.corp.redhat.com (Postfix) with SMTP id AE141111FF;
	Fri,  9 Feb 2024 13:07:37 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  9 Feb 2024 14:06:23 +0100 (CET)
Date: Fri, 9 Feb 2024 14:06:20 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] signal: add the "int si_code" arg to
 prepare_kill_siginfo()
Message-ID: <20240209130620.GA8039@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

So that do_tkill() can use this helper too. This also simplifies
the next patch.

TODO: perhaps we can kill prepare_kill_siginfo() and change the
callers to use SEND_SIG_NOINFO,  but this needs some changes in
__send_signal_locked() and TP_STORE_SIGINFO().

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/signal.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index c3fac06937e2..a8199fda0d61 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3793,12 +3793,12 @@ COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait_time32, compat_sigset_t __user *, uthese,
 #endif
 #endif
 
-static inline void prepare_kill_siginfo(int sig, struct kernel_siginfo *info)
+static void prepare_kill_siginfo(int sig, struct kernel_siginfo *info, int si_code)
 {
 	clear_siginfo(info);
 	info->si_signo = sig;
 	info->si_errno = 0;
-	info->si_code = SI_USER;
+	info->si_code = si_code;
 	info->si_pid = task_tgid_vnr(current);
 	info->si_uid = from_kuid_munged(current_user_ns(), current_uid());
 }
@@ -3812,7 +3812,7 @@ SYSCALL_DEFINE2(kill, pid_t, pid, int, sig)
 {
 	struct kernel_siginfo info;
 
-	prepare_kill_siginfo(sig, &info);
+	prepare_kill_siginfo(sig, &info, SI_USER);
 
 	return kill_something_info(sig, &info, pid);
 }
@@ -3925,7 +3925,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
 			goto err;
 	} else {
-		prepare_kill_siginfo(sig, &kinfo);
+		prepare_kill_siginfo(sig, &kinfo, SI_USER);
 	}
 
 	/* TODO: respect PIDFD_THREAD */
@@ -3970,12 +3970,7 @@ static int do_tkill(pid_t tgid, pid_t pid, int sig)
 {
 	struct kernel_siginfo info;
 
-	clear_siginfo(&info);
-	info.si_signo = sig;
-	info.si_errno = 0;
-	info.si_code = SI_TKILL;
-	info.si_pid = task_tgid_vnr(current);
-	info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
+	prepare_kill_siginfo(sig, &info, SI_TKILL);
 
 	return do_send_specific(tgid, pid, sig, &info);
 }
-- 
2.25.1.362.g51ebf55



