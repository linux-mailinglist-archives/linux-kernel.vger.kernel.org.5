Return-Path: <linux-kernel+bounces-52855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C19B5849D75
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9DA281C60
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE6F2C69E;
	Mon,  5 Feb 2024 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ao+KaV+K"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C3C2C684
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145017; cv=none; b=HeC0gy+cGTvV2/r9bauSmbmVygcR8PMidCULB1NORqNwWOuTyziE2a/uy11B5S6XjiwGpPC0uT/Fu6D5q3ILB2r/C98Att5fZyKYNHBURADsxpKV3X54xrYeRckIQMjcRShaUSQ5HQK0Kt51mnXHG/iM0Gjict3aVQBMoW+NvJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145017; c=relaxed/simple;
	bh=yml1g8lIUP8NOhlaf1UJ6FHxeNTEQqWwTozbd2chOzM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z6FWFzUwf9mWH+1H+gqKbkXNoJ6RLg93eZMvfixGQ+3nb9F1NFLJXHZtTfwOEf4KnMWmamBFGlTCCEd7WoORjXFbeReDvrJrpR9/Zgp7n/onegRD78p6XcP1QukMwK1T6+eQcu3s9RPY1tUbb30neBlFJIhHqeEK9RC3IbSHsAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ao+KaV+K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707145013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=3wWFKFwgxakmvKvguQj6wEaI43mBgwyBm4UjoRgLEUY=;
	b=Ao+KaV+KF1pnbQoNR1x4ZvfaCjtIGQU6oYS62tmeCOwYbaOr26IbBbVIbv1yP8HUZQCZnR
	h+wi5wGt8ipR3GjcK+ZfeF8FcJ91irvlOUHCSCsl7QZ4EIihmHQWJjmoDu617GAFgLnOW0
	pPnfKvTLCw+JfgnKMJqrbw6H4d4Jfxc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-nvK2DcrVMjCHItX-V9VBBA-1; Mon, 05 Feb 2024 09:56:51 -0500
X-MC-Unique: nvK2DcrVMjCHItX-V9VBBA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6801C8432A3;
	Mon,  5 Feb 2024 14:56:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.165])
	by smtp.corp.redhat.com (Postfix) with SMTP id BC7FB3C2E;
	Mon,  5 Feb 2024 14:56:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  5 Feb 2024 15:55:34 +0100 (CET)
Date: Mon, 5 Feb 2024 15:55:32 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tycho Andersen <tycho@tycho.pizza>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pidfd: clone: allow CLONE_THREAD | CLONE_PIDFD together
Message-ID: <20240205145532.GA28823@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

copy_process() just needs to pass PIDFD_THREAD to __pidfd_prepare()
if clone_flags & CLONE_THREAD.

We can also add another CLONE_ flag (or perhaps reuse CLONE_DETACHED)
to enforce PIDFD_THREAD without CLONE_THREAD.

Originally-from: Tycho Andersen <tycho@tycho.pizza>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/fork.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 8d08a2d1b095..cd61ca87d0e6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2311,9 +2311,8 @@ __latent_entropy struct task_struct *copy_process(
 		/*
 		 * - CLONE_DETACHED is blocked so that we can potentially
 		 *   reuse it later for CLONE_PIDFD.
-		 * - CLONE_THREAD is blocked until someone really needs it.
 		 */
-		if (clone_flags & (CLONE_DETACHED | CLONE_THREAD))
+		if (clone_flags & CLONE_DETACHED)
 			return ERR_PTR(-EINVAL);
 	}
 
@@ -2536,8 +2535,10 @@ __latent_entropy struct task_struct *copy_process(
 	 * if the fd table isn't shared).
 	 */
 	if (clone_flags & CLONE_PIDFD) {
+		int flags = (clone_flags & CLONE_THREAD) ? PIDFD_THREAD : 0;
+
 		/* Note that no task has been attached to @pid yet. */
-		retval = __pidfd_prepare(pid, 0, &pidfile);
+		retval = __pidfd_prepare(pid, flags, &pidfile);
 		if (retval < 0)
 			goto bad_fork_free_pid;
 		pidfd = retval;
-- 
2.25.1.362.g51ebf55



