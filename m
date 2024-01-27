Return-Path: <linux-kernel+bounces-41198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF5F83ED43
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458342842C9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 13:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18F325114;
	Sat, 27 Jan 2024 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKMf0YtQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FE764A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706361748; cv=none; b=k5V40ns+fMCa3+L1P6pNg4iNXnbjbTCxCPejvaLu/ApYpoog5ovm9z50XdUtuCXed9AZGhfvHFYJCvw6NLm4vZahOzbTVKxkxDZ1nnZ4OnVLJe9/gRjCxHt6/6CmBlZPhO75ciXcaXaP4w8AplLpUgt5/N1HgE+sLKF1WWSaNng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706361748; c=relaxed/simple;
	bh=Kte6+PlCsiofEdaZqFJNODbByl5H5MlPI+EHaexYAVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGsSw8izfcvypnXJnbl/TaeKX/WnxxXetzBxHT1b2TRRr2N3szTgq/Xscg8nbCL2jJo619mh/5SjcV/YSoZTCH98cQQQvMLKRxHU+xjvIbXmRaVgZcQvQZJzvac0T0GLGDtFzEfUujM8yG50nUGJZMz5Y9U/vCYJYNo+zHPIxSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKMf0YtQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706361745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Lnr97CrSqQs3fRVxc+xLD2K4SR4VLmsyw/Pt+9O36E=;
	b=jKMf0YtQcRjlVRcAtj6xmdYVGii4sFoTaQ5o4moG/Glnbzjc8cLsYcO+TuUO/h/+fg1mvW
	6QpP/1tB63Pc3akrQZN6K1qh227pTHmm2mYQzfRhbF76UGZcgfdmwokCyZ8ndtEMTGKedE
	nxWvrLvGb9twOBOB4NJCWYi4YftWFl4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-RCQvd3yoMeu6rTxG3_6wsQ-1; Sat,
 27 Jan 2024 08:22:22 -0500
X-MC-Unique: RCQvd3yoMeu6rTxG3_6wsQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD9EB383CD79;
	Sat, 27 Jan 2024 13:22:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.41])
	by smtp.corp.redhat.com (Postfix) with SMTP id 3F1B340C9444;
	Sat, 27 Jan 2024 13:22:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 27 Jan 2024 14:21:07 +0100 (CET)
Date: Sat, 27 Jan 2024 14:21:05 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pidfd: don't do_notify_pidfd() if
 !thread_group_empty()
Message-ID: <20240127132105.GA29091@redhat.com>
References: <20240127132043.GA29080@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127132043.GA29080@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

do_notify_pidfd() makes no sense until the whole thread group exits, change
do_notify_parent() to check thread_group_empty().

This avoids the unnecessary do_notify_pidfd() when tsk is not a leader, or
it exits before other threads, or it has a ptraced EXIT_ZOMBIE sub-thread.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/signal.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index c9c57d053ce4..9561a3962ca6 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2050,9 +2050,11 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 
 	WARN_ON_ONCE(!tsk->ptrace &&
 	       (tsk->group_leader != tsk || !thread_group_empty(tsk)));
-
-	/* Wake up all pidfd waiters */
-	do_notify_pidfd(tsk);
+	/*
+	 * tsk is a group leader and has no threads, wake up the pidfd waiters.
+	 */
+	if (thread_group_empty(tsk))
+		do_notify_pidfd(tsk);
 
 	if (sig != SIGCHLD) {
 		/*
-- 
2.25.1.362.g51ebf55



