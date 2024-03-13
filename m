Return-Path: <linux-kernel+bounces-102165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F7A87AEF7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C541F2AF70
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F257D19381B;
	Wed, 13 Mar 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpiTG4A6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D14B15018E;
	Wed, 13 Mar 2024 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349383; cv=none; b=iOSou/P619JHbm9nUG5aLmyCT1qZ7pLa4w0LM5uem36Evg+ehUeKMe8uSqvL90zRPDVkOstEhIy6iinBU5e2zLo2wIHGK8ueBZJ/Jevl537ySKhQIo1onbTCESjfN0NN6JmL3NMGgFzZFWEged60JGC08j95AIKx0FPl8sUWj0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349383; c=relaxed/simple;
	bh=yNYrhUZhrrcOmJeNzgfCI2uOaV3TNjr5wBZmtoW+uNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PB7mV/Dm/ElR83ZHxkDRul+AUbTFW0Dv/118POhuSzYhF+tApdCJRRc4eJjeqxFj49ElHITY146y3eEBt3+T+lEGkqxdUTOjeCxT8p3MYnxX6SL4UExtAytLDMwtkxzIUUIhPs8BzZHPOgOunf4pawfcmkNvCgcfU8vQrSkngLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpiTG4A6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203F8C43390;
	Wed, 13 Mar 2024 17:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349383;
	bh=yNYrhUZhrrcOmJeNzgfCI2uOaV3TNjr5wBZmtoW+uNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hpiTG4A65DvqLo7szU3AKy03REYzMPXD79wrXFK+UNle4m0/4TVfiSSCdYKRUJOZc
	 9K3AfFL/+6alvp67UpZ9gWiBbZy3bTWUNVcJJeL1DXQs8Y98OsFEhHgyyjpYzWtYQ8
	 M/r60igLaAyDQklQm54sSbwoA3BS6zHn7lGbzLfJkHbxqeKsiUTReG2m8OOESsYhDv
	 sW8xoE1AOl4NRb8tWPFoK/voBCrlha6OdTxSVVp+L+HDizz1S0H2Fg1uy3iq3tsB63
	 gIj6RR4uCup7LCP+e6Q1tX0f3kJGJqfUoXrlzT+6sEYzVnsJLOY8MwDbhnN2MafIha
	 q6NpobaW+3n5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 44/51] exit: wait_task_zombie: kill the no longer necessary spin_lock_irq(siglock)
Date: Wed, 13 Mar 2024 13:02:05 -0400
Message-ID: <20240313170212.616443-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit c1be35a16b2f1fe21f4f26f9de030ad6eaaf6a25 ]

After the recent changes nobody use siglock to read the values protected
by stats_lock, we can kill spin_lock_irq(&current->sighand->siglock) and
update the comment.

With this patch only __exit_signal() and thread_group_start_cputime() take
stats_lock under siglock.

Link: https://lkml.kernel.org/r/20240123153359.GA21866@redhat.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/exit.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index b2a005acb6cda..7a8a67aed9cac 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1107,17 +1107,14 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
 		 * and nobody can change them.
 		 *
 		 * psig->stats_lock also protects us from our sub-threads
-		 * which can reap other children at the same time. Until
-		 * we change k_getrusage()-like users to rely on this lock
-		 * we have to take ->siglock as well.
+		 * which can reap other children at the same time.
 		 *
 		 * We use thread_group_cputime_adjusted() to get times for
 		 * the thread group, which consolidates times for all threads
 		 * in the group including the group leader.
 		 */
 		thread_group_cputime_adjusted(p, &tgutime, &tgstime);
-		spin_lock_irq(&current->sighand->siglock);
-		write_seqlock(&psig->stats_lock);
+		write_seqlock_irq(&psig->stats_lock);
 		psig->cutime += tgutime + sig->cutime;
 		psig->cstime += tgstime + sig->cstime;
 		psig->cgtime += task_gtime(p) + sig->gtime + sig->cgtime;
@@ -1140,8 +1137,7 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
 			psig->cmaxrss = maxrss;
 		task_io_accounting_add(&psig->ioac, &p->ioac);
 		task_io_accounting_add(&psig->ioac, &sig->ioac);
-		write_sequnlock(&psig->stats_lock);
-		spin_unlock_irq(&current->sighand->siglock);
+		write_sequnlock_irq(&psig->stats_lock);
 	}
 
 	if (wo->wo_rusage)
-- 
2.43.0


