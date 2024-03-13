Return-Path: <linux-kernel+bounces-102008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B2587AD89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66851F24067
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2984D14CAD4;
	Wed, 13 Mar 2024 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7TY/Ia2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC6D64CEF;
	Wed, 13 Mar 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348221; cv=none; b=NE+lHSxefdICLwsgvWNnx12z6ET0HxUQSLEcX7eeTHOBSqqeG/4oTLSLy5pZnmP94AFgeIj1cLYMw5V6VihSoBSf4OAhc+oD8QkWIkXKbtz87+pgaps1w7kS3mwa35MasG9niZcOTwp22CC2jeODeP9S7bYtCFcb8ZTB0Y2YSxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348221; c=relaxed/simple;
	bh=WAUj8o87Jtl9FY8pDymI7DWVAEqnJiixd48oKquu4iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeyYb92Hyq0eW9gsdfE3xx0sQBIIRwFS/aIH4Q+1WNpL/bVTqK8yYC/y10y5GsXLFDWO07hVZP1HOtk0eLgoOUiWq3Jh/2QQXT+GinBTITL61qRB5DMcPc77EqlqRb9+OlLOfHGLY/NwQH4qpSsYPScny3NiKyiyxXlGOIe9BSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7TY/Ia2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1D7C433C7;
	Wed, 13 Mar 2024 16:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348221;
	bh=WAUj8o87Jtl9FY8pDymI7DWVAEqnJiixd48oKquu4iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o7TY/Ia2kdis+532dlECAIEuQdXX6Oj/lZoreuoVRvGf0a9AhK0ra/IR3EMdewWHe
	 msy4j4uXbo2mCzFS0USbOury7NGEu6AYwWrO3Pi1CM7W2TBDPU7BKyJ6vgjJYQeFLX
	 vyDovPuRQji7/4DhbqzpUcDJlxztGR5qDSa5O711JsnwXEkTaVMjnOpAf/jukj5pcm
	 RlOOxe1djo70tVsWox/2JvVkaWMEup04LxJF/C+uwOyWedYoYPYq/fp7p2WqrRaTFJ
	 aPmp5vGTOsdmJId5ia6WDKnRgs6LdQBpdgUxxGXbYv4udrYCK2dXTodxPhfGgyNtmc
	 njiet83lDu1zQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 67/76] exit: wait_task_zombie: kill the no longer necessary spin_lock_irq(siglock)
Date: Wed, 13 Mar 2024 12:42:14 -0400
Message-ID: <20240313164223.615640-68-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
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
index e982111c489a9..85baaa31b2997 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1120,17 +1120,14 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
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
@@ -1153,8 +1150,7 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
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


