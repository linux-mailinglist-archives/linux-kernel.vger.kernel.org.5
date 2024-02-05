Return-Path: <linux-kernel+bounces-52798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B8F849CC0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B7828748D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFCD24B50;
	Mon,  5 Feb 2024 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/gSCdSr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8241A2374E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142513; cv=none; b=L/jhz5xJIpfnWayL5BZpw878M1H4eDTi/W2yqIwlnto5Pd1hIaM4laW5cHRgI67fnOi+71y0Gp9dufWCp36aEt+9GPXfUrMZJAIIcAR4euMl3hw7cjWAzdx1CM2gfoBv10q6WJ83oG7mfyoFXE9/bXptaW6LgBo4DG+XUS45fzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142513; c=relaxed/simple;
	bh=iqDeabfWw4JAl1GsXp6xX7i80knJmS9R0n4Vk6rDw10=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FVnFVL/WGooTJUWq/Qt8uKuNKESHajtxCM8fLj9MUsymVEUrJXiQmrl28Ra05Z3VRQUPk4O5QLIlZPQWhNLr7gfm5iT5Wy8I6al6dRemRJ5yZMJJgk1Ki9qcg9vbSQACIfypIoqEZd5Tyb+LhlQGdwnwvYqj4mRIZy6r+w18Wy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/gSCdSr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707142510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=11pxIPHjBBl92wQMC3DFzCqQJYEHlgWDIYJq9X2o8Gc=;
	b=a/gSCdSruePTTeg4NkAWMk0n2XnKuYdqvmFKp4jGl5bXCxvLWduVwxRDKeWpcYIcY3Mnm0
	as1A3/b6lXooSn04G9Il14HOgaNfEBQtuQ53RHKrcb+Jv4e1VodogscGfmIJ1/C/dGxHE/
	dciO8LWdptfKlt/Ui5qu5p6eCbnrzu0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-WEhRXOPpNoGlqpJ5BlKlMw-1; Mon, 05 Feb 2024 09:15:06 -0500
X-MC-Unique: WEhRXOPpNoGlqpJ5BlKlMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50C2EB42B26;
	Mon,  5 Feb 2024 14:15:06 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.165])
	by smtp.corp.redhat.com (Postfix) with SMTP id 1979C2166B31;
	Mon,  5 Feb 2024 14:15:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  5 Feb 2024 15:13:50 +0100 (CET)
Date: Mon, 5 Feb 2024 15:13:48 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org
Subject: [PATCH] pidfd: change do_notify_pidfd() to use
 __wake_up(poll_to_key(EPOLLIN))
Message-ID: <20240205141348.GA16539@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

rather than wake_up_all(). This way do_notify_pidfd() won't wakeup the
POLLHUP-only waiters which wait for pid_task() == NULL.

TODO:
    - as Christian pointed out, this asks for the new wake_up_all_poll()
      helper, it can already have other users.

    - we can probably discriminate the PIDFD_THREAD and non-PIDFD_THREAD
      waiters, but this needs more work. See
      https://lore.kernel.org/all/20240205140848.GA15853@redhat.com/

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



