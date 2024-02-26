Return-Path: <linux-kernel+bounces-82004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05040867D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4D028CD70
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C32132C00;
	Mon, 26 Feb 2024 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QZGBjvNL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CFE13248D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966698; cv=none; b=eyTEae28ndNGLzsKvEG9KxCXxBWbyrzzKwgoUZi1bnO/x13sQ9PU/q8dTTAi5FViQa7C2xb1ZKDhIPam8YdiTvnNCYMNsT+XCyr4OUirfncOHaPaciw2brrq6lTMEYEKyFnRV05l87X33ucqRObl7hTgIJUUI6oGNHvpzAhrNC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966698; c=relaxed/simple;
	bh=2vDMhs+lIZRQu6b8sDiWxOkdaX4P1Hf96dBkO5y7DyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jC3l+XUtrDL6ckHWs8tP5N8tovR41NzEDTVwY5DzSi7M1emjTNCMfowFIwyYrPCKmVKElJNCueIZ1tPPKjglTxrva3xSv7vU3H5ygt2u6JjZVZWYpOIovppKzehEdYq8xmamqX9pX5ShrJj9NnoJuKA9qnv6vu6H9ID0i7eRdFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QZGBjvNL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708966696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=PgAcgLR0G7aO1N7QedETGwVIPeEZLgrQUsFrIQ40RNU=;
	b=QZGBjvNLyZ2btKqyWOuMpyFdtwfxHF0w4ljOgzygHxlu8sRuzBIw3anC5Gxl7FMKZfJghg
	/LaXn+86BESOdVkSyikem8eJWuw1kQ5ChRd57yXyZ/nrNw0MXnSpLqF7y78b7nSa867bmW
	dvYrhtjJlpQBQUvhS1nf+exkP2VSOu8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-AZ3hfYUIM5mHV2UatOoXvQ-1; Mon, 26 Feb 2024 11:58:12 -0500
X-MC-Unique: AZ3hfYUIM5mHV2UatOoXvQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14E5883B876;
	Mon, 26 Feb 2024 16:58:12 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.85])
	by smtp.corp.redhat.com (Postfix) with SMTP id 826BB2026D0A;
	Mon, 26 Feb 2024 16:58:10 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 26 Feb 2024 17:56:52 +0100 (CET)
Date: Mon, 26 Feb 2024 17:56:50 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	Peter Collingbourne <pcc@google.com>,
	Wen Yang <wenyang.linux@foxmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] get_signal: hide_si_addr_tag_bits: fix the usage of
 uninitialized ksig
Message-ID: <20240226165650.GA20829@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

ksig->ka and ksig->info are not initialized if get_signal() returns 0 or
if the caller is PF_USER_WORKER.

Check signr != 0 before SA_EXPOSE_TAGBITS and move the "out" label down.

The latter means that ksig->sig won't be initialized if a PF_USER_WORKER
thread gets a fatal signal but this is fine, PF_USER_WORKER's don't use
ksig. And there is nothing new, in this case ksig->ka and ksig-info are
not initialized anyway. Add a comment.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/signal.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 09a6dd07cf6b..a69d3069067a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2881,8 +2881,9 @@ bool get_signal(struct ksignal *ksig)
 
 		/*
 		 * PF_USER_WORKER threads will catch and exit on fatal signals
-		 * themselves. They have cleanup that must be performed, so
-		 * we cannot call do_exit() on their behalf.
+		 * themselves. They have cleanup that must be performed, so we
+		 * cannot call do_exit() on their behalf. Note that ksig won't
+		 * be properly initialized, PF_USER_WORKER's shouldn't use it.
 		 */
 		if (current->flags & PF_USER_WORKER)
 			goto out;
@@ -2894,12 +2895,12 @@ bool get_signal(struct ksignal *ksig)
 		/* NOTREACHED */
 	}
 	spin_unlock_irq(&sighand->siglock);
-out:
+
 	ksig->sig = signr;
 
-	if (!(ksig->ka.sa.sa_flags & SA_EXPOSE_TAGBITS))
+	if (signr && !(ksig->ka.sa.sa_flags & SA_EXPOSE_TAGBITS))
 		hide_si_addr_tag_bits(ksig);
-
+out:
 	return signr > 0;
 }
 
-- 
2.25.1.362.g51ebf55


