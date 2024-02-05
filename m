Return-Path: <linux-kernel+bounces-52788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B817E849CAB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B782EB21515
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9226624A0F;
	Mon,  5 Feb 2024 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxfE3DA8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC512377D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142336; cv=none; b=gR6GkKH1cM0PyTUwluhbnjZ4eEPUs9SVUcjZtCnHjjwoA9D9+AQBks3dGy5a5Sy6PlNfBa5Vrx04VDpv292z+R8wM71HFbUTZlGddsbFPjz+PYVrLebyqKKIIlfQVjdqQ8alsYjiN/S7UH9aIg2op9NZJJXMWPeBhkaEZ73LMY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142336; c=relaxed/simple;
	bh=Gd3Qd4h4a246Azi/ANHT+FzV2dp0eLicHjFsnJCn974=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YjnPRteoq03CsGvio/X8xJcUrZzNmKSkl8XYLMt+RfqPFg3U39S1zwatH+AM50x8OHplMXt+O2vgyS47kALSrbedlgtjAjLqkWnuNACnL2fpR/85WXmAHBnVhzV7vFdI0LDViVD0YiffLOg/LH5UfkQn89yjrcmIeF0BDV/LXEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IxfE3DA8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707142334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=gjFMaGeg0tSbAHrrpJqixRvm8sviT7v0IDbKr1o51po=;
	b=IxfE3DA8ApvD4CLko1upMfUmYzodQHXCyJsh/ckzcYLdoleikoZP5gnAWrmqiVupCWiIer
	SyW5yObSbOYCZ0ej9BRcfBA7dsRnPwBhVT11pWG+uNpWLmRROCo/CVeNmc1R651t9q7glv
	xFKonp4f2WJ47kDJPOlj2dMQidcWhOI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-DJtLC7HiPYugwAdIqul-fg-1; Mon, 05 Feb 2024 09:12:08 -0500
X-MC-Unique: DJtLC7HiPYugwAdIqul-fg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25427101366D;
	Mon,  5 Feb 2024 14:12:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.165])
	by smtp.corp.redhat.com (Postfix) with SMTP id AB29C492BC6;
	Mon,  5 Feb 2024 14:12:06 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  5 Feb 2024 15:10:52 +0100 (CET)
Date: Mon, 5 Feb 2024 15:10:50 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org
Subject: [PATCH] pidfd: change do_notify_pidfd() to use
 __wake_up(poll_to_key(EPOLLIN))
Message-ID: <20240205141050.GA16278@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

rather than wake_up_all(). This way do_notify_pidfd() won't wakeup the
POLLHUP-only waiters which wait for pid_task() == NULL.

TODO:
    - as Christian pointed out, this asks for the new wake_up_all_poll()
      helper, it can already have other users.

    - we can probably discriminate the PIDFD_THREAD and non-PIDFD_THREAD
      waiters, but this needs more work.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/signal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 9b40109f0c56..c3fac06937e2 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2021,11 +2021,12 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 
 void do_notify_pidfd(struct task_struct *task)
 {
-	struct pid *pid;
+	struct pid *pid = task_pid(task);
 
 	WARN_ON(task->exit_state == 0);
-	pid = task_pid(task);
-	wake_up_all(&pid->wait_pidfd);
+
+	__wake_up(&pid->wait_pidfd, TASK_NORMAL, 0,
+			poll_to_key(EPOLLIN | EPOLLRDNORM));
 }
 
 /*
-- 
2.25.1.362.g51ebf55



