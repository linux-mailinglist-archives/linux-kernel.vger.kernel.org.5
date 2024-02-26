Return-Path: <linux-kernel+bounces-82005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B36867D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCE628C5A2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABEE13B2A8;
	Mon, 26 Feb 2024 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HH6RcE0c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE76132C01
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966702; cv=none; b=Cb21wu5Jf/fD3mn1l6UlI8mx3QzzaOsj9o4GjHaPLfG56t9fJbsog1G2tuZb02ShHJC5RsrMMXIh3cumOsoTwJuDop4QGypdetFMxGlHAjeMfC+ry4IEfnjYX8Ejk059/L0JFTW/M/JZNOUri5FLyICW6Tgw00TxPOYn+6bTE78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966702; c=relaxed/simple;
	bh=LqGMQtPIGznoCP9QmWV2gD3wXujgVsqlU0n95FID8CY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rsZWd3DyYF8fGyvhurvZ+TsUQz4ux/xJ8cudQlKQipKRGO8TBrDYmAsZ/LwVGEWWNXY9ZozFaHkrZt55q6Cc8R1IKwuIqxUti86NdPBaUg5B6Hg+BE4KVDRBuwwDZh1NAX/QIcRqlY1gpalhDsbrr64r5pIPzx6OtAIoTAlefzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HH6RcE0c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708966699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=92kRab4HqwTQmO/VgKs5fSqh+D6/YdS7SG+n+Wli5ZI=;
	b=HH6RcE0cjCp3ZP3EDiaqG4BLdVqo72hpOjB5gaFlQWTMn6S29saQs2Jk0B1WO1PP8kswdj
	YnOQfi6gbzuS0VboTxDSdwx8fq10PjKiksqziN3Y/BOD2voMEN3z8esCdbuAGiap7xWPuM
	5E7XzOpbtYxHLfCLdMJEMXkOCEs3qr8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-79WX0-_8NRyaSb_F6N9a1Q-1; Mon, 26 Feb 2024 11:58:15 -0500
X-MC-Unique: 79WX0-_8NRyaSb_F6N9a1Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5C8C83B86C;
	Mon, 26 Feb 2024 16:58:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.85])
	by smtp.corp.redhat.com (Postfix) with SMTP id 49036400D783;
	Mon, 26 Feb 2024 16:58:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 26 Feb 2024 17:56:55 +0100 (CET)
Date: Mon, 26 Feb 2024 17:56:53 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	Peter Collingbourne <pcc@google.com>,
	Wen Yang <wenyang.linux@foxmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] get_signal: don't initialize ksig->info if
 SIGNAL_GROUP_EXIT/group_exec_task
Message-ID: <20240226165653.GA20834@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226165612.GA20787@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

This initialization is incomplete and unnecessary, neither do_group_exit()
nor PF_USER_WORKER need ksig->info.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/signal.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index a69d3069067a..9c6a5ccac328 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2727,12 +2727,15 @@ bool get_signal(struct ksignal *ksig)
 		/* Has this task already been marked for death? */
 		if ((signal->flags & SIGNAL_GROUP_EXIT) ||
 		     signal->group_exec_task) {
-			clear_siginfo(&ksig->info);
-			ksig->info.si_signo = signr = SIGKILL;
+			signr = SIGKILL;
 			sigdelset(&current->pending.signal, SIGKILL);
 			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
-				&sighand->action[SIGKILL - 1]);
+					     &sighand->action[SIGKILL-1]);
 			recalc_sigpending();
+			/*
+			 * implies do_group_exit() or return to PF_USER_WORKER,
+			 * no need to initialize ksig->info/etc.
+			 */
 			goto fatal;
 		}
 
-- 
2.25.1.362.g51ebf55


