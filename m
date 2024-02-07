Return-Path: <linux-kernel+bounces-56251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0C084C7EA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A858286C02
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AC92261B;
	Wed,  7 Feb 2024 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T89x4npj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4DC2556D;
	Wed,  7 Feb 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299432; cv=none; b=R0GXSyCyjnfqW6hvIuCSbFI/p9VJW3IHP394iY5iQffyo6xiCM7FXgKvWXa7svKII0HoqbkvOIeVjCsvBL7P8DY1O7p1S9xjn5LbSisDhAT+0NiLvHXYYjQMXNd1g5a19ZX2GWd6hfvwPKuQl3e3/OwlGLzGVAD8c5xFV0n2ng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299432; c=relaxed/simple;
	bh=/tImMrVIVbTZtJyKXd55BPzqmcJN5F5TwsaZMk1n1bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWCbCxktCisUPzYLsm0gg4emJzafYIL8E3mYb6IiM/KlhnDoiUxDhreUrT+u73TlayyIW7CpHIloCgsMUrzgAMRnZedAxJw6gsbWvaIfakfzOqTr+KDplo2M9jSl9GvocYiK/IrgpLUWaD4PzsT96Sc8AkhU8KYlXJ4y9fz6fGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T89x4npj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A560AC433C7;
	Wed,  7 Feb 2024 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707299431;
	bh=/tImMrVIVbTZtJyKXd55BPzqmcJN5F5TwsaZMk1n1bM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T89x4npjbUipJ36uBKlCrNDZs66j7OGP+Pe6APwqCddMPcZmx1JFVVcrkTJRpaRgi
	 WSdoAMf2PLNr6S69Nc8uAukobVxIOUdVOmxt0+LRdx8kX1YIYePSDOIUWf0fzYgmrq
	 DpzHh8ThZDe+9nwpVBD05918kbKQ13RbWpUzhTPaaxr2lXsmBPsraGhAMoOjLqXtt4
	 3NUguH3Ix+B08u9f0tk3WTxJn08Jt+hcfuZlYQnt43Bggul9QJV5mMUsXWYR5i6li2
	 yb7jZvSM0q1j1ZBwhb3IrtMuSMu9iXUmiH2zE7lUnDuhA13r3w6NMsh2+/8lwhu2kD
	 R9Anz7L5yEjPg==
Date: Wed, 7 Feb 2024 10:50:26 +0100
From: Christian Brauner <brauner@kernel.org>
To: Tycho Andersen <tycho@tycho.pizza>, Oleg Nesterov <oleg@redhat.com>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [PATCH v2] pidfd: getfd should always report ESRCH if a task is
 exiting
Message-ID: <20240207-blumen-neulich-f1507e0c5cc0@brauner>
References: <20240206192357.81942-1-tycho@tycho.pizza>
 <20240207-vibrieren-waldarbeiten-30eeade05203@brauner>
 <20240207-daran-fliesen-6039a2e36f39@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240207-daran-fliesen-6039a2e36f39@brauner>

On Wed, Feb 07, 2024 at 10:29:51AM +0100, Christian Brauner wrote:
> On Wed, Feb 07, 2024 at 10:15:25AM +0100, Christian Brauner wrote:
> > On Tue, Feb 06, 2024 at 12:23:57PM -0700, Tycho Andersen wrote:
> > > From: Tycho Andersen <tandersen@netflix.com>
> > > 
> > > We can get EBADF from __pidfd_fget() if a task is currently exiting, which
> > > might be confusing. Let's check PF_EXITING, and just report ESRCH if so.
> > > 
> > > I chose PF_EXITING, because it is set in exit_signals(), which is called
> > > before exit_files(). Since ->exit_status is mostly set after exit_files()
> > > in exit_notify(), using that still leaves a window open for the race.
> > > 
> > > Signed-off-by: Tycho Andersen <tandersen@netflix.com>
> > > v2: fix a race in the check by putting the check after __pidfd_fget()
> > >     (thanks Oleg)
> > > ---
> > >  kernel/pid.c                                  | 17 +++++++++-
> > >  .../selftests/pidfd/pidfd_getfd_test.c        | 31 ++++++++++++++++++-
> > >  2 files changed, 46 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/pid.c b/kernel/pid.c
> > > index de0bf2f8d18b..a8cd6296ed6d 100644
> > > --- a/kernel/pid.c
> > > +++ b/kernel/pid.c
> > > @@ -693,8 +693,23 @@ static int pidfd_getfd(struct pid *pid, int fd)
> > >  
> > >  	file = __pidfd_fget(task, fd);
> > >  	put_task_struct(task);
> > > -	if (IS_ERR(file))
> > > +	if (IS_ERR(file)) {
> > > +		/*
> > > +		 * It is possible that the target thread is exiting; it can be
> > > +		 * either:
> > > +		 * 1. before exit_signals(), which gives a real fd
> > > +		 * 2. before exit_files() takes the task_lock() gives a real fd
> > > +		 * 3. after exit_files() releases task_lock(), ->files is NULL;
> > > +		 *    this has PF_EXITING, since it was set in exit_signals(),
> > > +		 *    __pidfd_fget() returns EBADF.
> > > +		 * In case 3 we get EBADF, but that really means ESRCH, since
> > > +		 * the task is currently exiting and has freed its files
> > > +		 * struct, so we fix it up.
> > > +		 */
> > > +		if (task->flags & PF_EXITING && PTR_ERR(file) == -EBADF)
> > > +			return -ESRCH;
> > 
> > Isn't that a potential UAF because we called put_task_struct() above but
> > this is exiting task->flags afterwards?
> 
> s/exiting/accessing/

So this is what I have applied currently where I moved the check into
__pidfd_fget() where it makes more sense imho. But please double check
that I didn't mess anything up:

From 7ab8f833aceb11c78627f4ea5d7e354314efa385 Mon Sep 17 00:00:00 2001
From: Tycho Andersen <tandersen@netflix.com>
Date: Wed, 7 Feb 2024 10:19:29 +0100
Subject: [PATCH 1/2] pidfd: getfd should always report ESRCH if a task is
 exiting

We can get EBADF from pidfd_getfd() if a task is currently exiting,
which might be confusing. Let's check PF_EXITING, and just report ESRCH
if so.

I chose PF_EXITING, because it is set in exit_signals(), which is called
before exit_files(). Since ->exit_status is mostly set after
exit_files() in exit_notify(), using that still leaves a window open for
the race.

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
Link: https://lore.kernel.org/r/20240206192357.81942-1-tycho@tycho.pizza
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/pid.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index de0bf2f8d18b..c1d940fbd314 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -678,7 +678,26 @@ static struct file *__pidfd_fget(struct task_struct *task, int fd)
 
 	up_read(&task->signal->exec_update_lock);
 
-	return file ?: ERR_PTR(-EBADF);
+	if (!file) {
+		/*
+		 * It is possible that the target thread is exiting; it can be
+		 * either:
+		 * 1. before exit_signals(), which gives a real fd
+		 * 2. before exit_files() takes the task_lock() gives a real fd
+		 * 3. after exit_files() releases task_lock(), ->files is NULL;
+		 *    this has PF_EXITING, since it was set in exit_signals(),
+		 *    __pidfd_fget() returns EBADF.
+		 * In case 3 we get EBADF, but that really means ESRCH, since
+		 * the task is currently exiting and has freed its files
+		 * struct, so we fix it up.
+		 */
+		if (task->flags & PF_EXITING)
+			file = ERR_PTR(-ESRCH);
+		else
+			file = ERR_PTR(-EBADF);
+	}
+
+	return file;
 }
 
 static int pidfd_getfd(struct pid *pid, int fd)
-- 
2.43.0

From 43316ed070cd8fb02a51ea9577c5fc1fcf639652 Mon Sep 17 00:00:00 2001
From: Tycho Andersen <tandersen@netflix.com>
Date: Wed, 7 Feb 2024 10:19:44 +0100
Subject: [PATCH 2/2] selftests: add ESRCH tests for pidfd_getfd()

Ensure that pidfd_getfd() reports -ESRCH if the task is already exiting.

Signed-off-by: Tycho Andersen <tandersen@netflix.com>
Link: https://lore.kernel.org/r/20240206192357.81942-1-tycho@tycho.pizza
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/pidfd/pidfd_getfd_test.c        | 31 ++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
index 0930e2411dfb..cd51d547b751 100644
--- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -5,6 +5,7 @@
 #include <fcntl.h>
 #include <limits.h>
 #include <linux/types.h>
+#include <poll.h>
 #include <sched.h>
 #include <signal.h>
 #include <stdio.h>
@@ -129,6 +130,7 @@ FIXTURE(child)
 	 * When it is closed, the child will exit.
 	 */
 	int sk;
+	bool ignore_child_result;
 };
 
 FIXTURE_SETUP(child)
@@ -165,10 +167,14 @@ FIXTURE_SETUP(child)
 
 FIXTURE_TEARDOWN(child)
 {
+	int ret;
+
 	EXPECT_EQ(0, close(self->pidfd));
 	EXPECT_EQ(0, close(self->sk));
 
-	EXPECT_EQ(0, wait_for_pid(self->pid));
+	ret = wait_for_pid(self->pid);
+	if (!self->ignore_child_result)
+		EXPECT_EQ(0, ret);
 }
 
 TEST_F(child, disable_ptrace)
@@ -235,6 +241,29 @@ TEST(flags_set)
 	EXPECT_EQ(errno, EINVAL);
 }
 
+TEST_F(child, no_strange_EBADF)
+{
+	struct pollfd fds;
+
+	self->ignore_child_result = true;
+
+	fds.fd = self->pidfd;
+	fds.events = POLLIN;
+
+	ASSERT_EQ(kill(self->pid, SIGKILL), 0);
+	ASSERT_EQ(poll(&fds, 1, 5000), 1);
+
+	/*
+	 * It used to be that pidfd_getfd() could race with the exiting thread
+	 * between exit_files() and release_task(), and get a non-null task
+	 * with a NULL files struct, and you'd get EBADF, which was slightly
+	 * confusing.
+	 */
+	errno = 0;
+	EXPECT_EQ(sys_pidfd_getfd(self->pidfd, self->remote_fd, 0), -1);
+	EXPECT_EQ(errno, ESRCH);
+}
+
 #if __NR_pidfd_getfd == -1
 int main(void)
 {
-- 
2.43.0


