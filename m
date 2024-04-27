Return-Path: <linux-kernel+bounces-160916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B66DF8B4481
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 08:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FBB1B21FDC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 06:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67B440867;
	Sat, 27 Apr 2024 06:21:25 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BE53BBF8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 06:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714198885; cv=none; b=YO54zI0BzcFbMaNccf5HE8o4bKm2MKE5eEDLpGGQxpWdD7cU7WjbbPTxp7mmE+Fbj/1J6VeI3fZPbiPDkq0P8EfswFaZKfSuxhALKE/xv0hAEPC696qSb7BdV6EOcbK6eVyClP6cOHmmzyUJkqenS9srqthVwjOfKzDVBTVDgj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714198885; c=relaxed/simple;
	bh=JDI+ZA6I+kxLaEJ2s5WI2dMjv1azKtCwSboymX2Ru3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDNzIJXNCFi25fwj8MuLud3qwnYECsBAdR9hRyA1h1B/GeSHq2RM2mh5mHpLDgQQ1Q+dtnUcUn2Kg5dqubKxwM1+Gl5BtrHrwx51VgAaieZpWdFyblnIFwBySqVt2XMsJ+XAFJ/wWs9SyO5toSj9Tsof2yloHZyKIvgOx1qUAQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 43R6KcTC094738;
	Sat, 27 Apr 2024 15:20:38 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Sat, 27 Apr 2024 15:20:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 43R6Kb76094734
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Apr 2024 15:20:37 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <18a58415-4aa9-4cba-97d2-b70384407313@I-love.SAKURA.ne.jp>
Date: Sat, 27 Apr 2024 15:20:37 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jiri Slaby <jirislaby@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <e1fe6a44-3021-62ad-690a-69146e39e1ac@I-love.SAKURA.ne.jp>
 <20230424004431.GG3390869@ZenIV>
 <8e21256a-736e-4c2d-1ff4-723775bcac46@I-love.SAKURA.ne.jp>
 <2fca7932-5030-32c3-dd61-48dd78e58e11@I-love.SAKURA.ne.jp>
 <20230425160344.GS3390869@ZenIV>
 <1b405689-ea0a-6696-6709-d372ce72d68c@I-love.SAKURA.ne.jp>
 <5cebade5-0aa9-506c-c817-7bcf098eba89@I-love.SAKURA.ne.jp>
 <c95c62ba-4f47-b499-623b-05627a81c601@I-love.SAKURA.ne.jp>
 <2023053005-alongside-unvisited-d9af@gregkh>
 <8edbd558-a05f-c775-4d0c-09367e688682@I-love.SAKURA.ne.jp>
 <2023053048-saved-undated-9adf@gregkh>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <2023053048-saved-undated-9adf@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

syzbot is reporting data race between __tty_hangup() and __fput(), for
filp->f_op readers are not holding tty->files_lock.

Dmitry Vyukov mentioned that this race has possibility of NULL pointer
dereference, for tty_fops implements e.g. splice_read callback whereas
hung_up_tty_fops does not.

  CPU0                                  CPU1
  ----                                  ----
  do_splice_to() {
                                        __tty_hangup() {
    // f_op->splice_read was generic_file_splice_read
    if (unlikely(!in->f_op->splice_read))
      return warn_unsupported(in, "read");
                                          filp->f_op = &hung_up_tty_fops;
    // f_op->splice_read is now NULL
    return in->f_op->splice_read(in, ppos, pipe, len, flags);
                                        }
  }

If we care about only NULL pointer dereference, implementing missing
callbacks to hung_up_tty_fops is fine. But if we also care about KCSAN
reports, we will need to wrap all filp->f_op usages which are reachable
via tty_fops callbacks using data_race().

Such wrapping is overkill as a fix for tty_io code. Therefore, instead of
implementing missing callbacks, stop updating filp->f_op and remove
hung_up_tty_fops. Then, changes will be limited to within tty_io code.

tty_open() is doing "filp->f_op = &tty_fops;".
__tty_hangup() is doing "filp->f_op = &hung_up_tty_fops;".
tty_hung_up_p() is doing "filp->f_op == &hung_up_tty_fops", and
most functions are checking tty_hung_up_p().

Since tty_open() allocates "struct tty_file_private" for each
"struct file", we can remember whether __tty_hangup() was called
by adding a flag to "struct tty_file_private".

Below is detail of where/what to change.

Regarding __tty_hangup(), replace "filp->f_op = &hung_up_tty_fops;" with
setting the above-mentioned flag.

Regarding tty_hungup_p(), replace "filp->f_op == &hung_up_tty_fops" with
"filp->f_op == &tty_fops" and check the above-mentioned flag.

Regarding tty_open(), just remove "filp->f_op = &tty_fops;" because
"struct tty_file_private" was already released by tty_del_file() from
tty_release() when control reaches this line.

Regarding tty_{read,write,poll,ioctl,compat_ioctl}(), respectively embed
hung_up_tty_{read,write,poll,ioctl,compat_ioctl}() right before
tty_paranoia_check().

Regarding tty_fasync(), embed hung_up_tty_fasync() right before tty_lock()
in tty_fasync() rather than tty_paranoia_check() in __tty_fasync(), for
tty_hung_up_p() is checked right after tty_lock() returned.

Since tty_read() is called via file->f_op->read_iter() from
call_read_iter() from generic_file_splice_read(), no change is needed for
tty_fops->splice_read.

Since tty_write() is called via file->f_op->write_iter() from
call_write_iter() from do_iter_readv_writev() from do_iter_write() from
vfs_iter_write() from iter_file_splice_write(), no change is needed for
tty_fops->splice_write.

Since both tty_fops and hung_up_tty_fops point to the same callback for
llseek/release, no change is needed for tty_fops->{llseek,release}.

Finally, remove hung_up_tty_fops and mark callbacks used by
hung_up_tty_fops as "inline".

Reported-by: syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=b7c3ba8cdc2f6cf83c21
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
Changes in v3:
  Accept some of comments from Greg Kroah-Hartman
  at https://lkml.kernel.org/r/2023053048-saved-undated-9adf@gregkh .

    > That sounds like a bug in KCSAN, let's not add loads of infrastructure
    > just because we have bad tools.
    Not a bug in KCSAN. KCSAN is reporting that current code has race window
    for NULL pointer dereference. This patch closes the race window.

    > Again, document it, and also perhaps, not use KCSAN?  :)
    data_race() is already explained. Not using KCSAN is not a solution.

    > It happens on open() which yes, is not performance critical, but you are
    > now requiring it where before this was not required.  Which isn't always
    > so obvious, right?     
    Updated to do explicit initialization.

    > Which we can fix.  So let's fix that and then not worry about these
    > false-positives with KCSAN as it's obviously wrong.  That would make for
    > a much smaller and simpler and easier-to-maintain-over-time change.
    I disagree. We will surely forget to add corresponding dummy callback to
    hung_up_tty_fops when a new callback is added to "struct file_operations".
    Not changing filp->f_op after once published is the safer approach.

    > How will you know this in 5 years when you see this new field?
    > Documentation matters.
    Added comment.

Changes in v2:
  Mark callbacks used by hung_up_tty_fops as "inline" in order to fix
  -Wunused-function warning when CONFIG_COMPAT=n, reported by
  Nathan Chancellor <nathan@kernel.org> and Arnd Bergmann <arnd@kernel.org>.

 drivers/tty/tty_io.c | 48 ++++++++++++++++++++++----------------------
 include/linux/tty.h  |  1 +
 2 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 407b0d87b7c1..88b0e3221195 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -187,6 +187,7 @@ int tty_alloc_file(struct file *file)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->hung = false;
 	file->private_data = priv;
 
 	return 0;
@@ -420,35 +421,35 @@ struct tty_driver *tty_find_polling_driver(char *name, int *line)
 EXPORT_SYMBOL_GPL(tty_find_polling_driver);
 #endif
 
-static ssize_t hung_up_tty_read(struct kiocb *iocb, struct iov_iter *to)
+static inline ssize_t hung_up_tty_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	return 0;
 }
 
-static ssize_t hung_up_tty_write(struct kiocb *iocb, struct iov_iter *from)
+static inline ssize_t hung_up_tty_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	return -EIO;
 }
 
 /* No kernel lock held - none needed ;) */
-static __poll_t hung_up_tty_poll(struct file *filp, poll_table *wait)
+static inline __poll_t hung_up_tty_poll(struct file *filp, poll_table *wait)
 {
 	return EPOLLIN | EPOLLOUT | EPOLLERR | EPOLLHUP | EPOLLRDNORM | EPOLLWRNORM;
 }
 
-static long hung_up_tty_ioctl(struct file *file, unsigned int cmd,
+static inline long hung_up_tty_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg)
 {
 	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
 }
 
-static long hung_up_tty_compat_ioctl(struct file *file,
+static inline long hung_up_tty_compat_ioctl(struct file *file,
 				     unsigned int cmd, unsigned long arg)
 {
 	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
 }
 
-static int hung_up_tty_fasync(int fd, struct file *file, int on)
+static inline int hung_up_tty_fasync(int fd, struct file *file, int on)
 {
 	return -ENOTTY;
 }
@@ -490,17 +491,6 @@ static const struct file_operations console_fops = {
 	.fasync		= tty_fasync,
 };
 
-static const struct file_operations hung_up_tty_fops = {
-	.llseek		= no_llseek,
-	.read_iter	= hung_up_tty_read,
-	.write_iter	= hung_up_tty_write,
-	.poll		= hung_up_tty_poll,
-	.unlocked_ioctl	= hung_up_tty_ioctl,
-	.compat_ioctl	= hung_up_tty_compat_ioctl,
-	.release	= tty_release,
-	.fasync		= hung_up_tty_fasync,
-};
-
 static DEFINE_SPINLOCK(redirect_lock);
 static struct file *redirect;
 
@@ -618,7 +608,8 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
 			continue;
 		closecount++;
 		__tty_fasync(-1, filp, 0);	/* can't block */
-		filp->f_op = &hung_up_tty_fops;
+		/* Accept race with tty_hung_up_p() test. */
+		data_race(priv->hung = true);
 	}
 	spin_unlock(&tty->files_lock);
 
@@ -742,7 +733,9 @@ void tty_vhangup_session(struct tty_struct *tty)
  */
 int tty_hung_up_p(struct file *filp)
 {
-	return (filp && filp->f_op == &hung_up_tty_fops);
+	return filp && filp->f_op == &tty_fops &&
+		/* Accept race with __tty_hangup(). */
+		data_race(((struct tty_file_private *) filp->private_data)->hung);
 }
 EXPORT_SYMBOL(tty_hung_up_p);
 
@@ -921,6 +914,8 @@ static ssize_t tty_read(struct kiocb *iocb, struct iov_iter *to)
 	struct tty_ldisc *ld;
 	ssize_t ret;
 
+	if (tty_hung_up_p(file))
+		return hung_up_tty_read(iocb, to);
 	if (tty_paranoia_check(tty, inode, "tty_read"))
 		return -EIO;
 	if (!tty || tty_io_error(tty))
@@ -1080,6 +1075,8 @@ static ssize_t file_tty_write(struct file *file, struct kiocb *iocb, struct iov_
 	struct tty_ldisc *ld;
 	ssize_t ret;
 
+	if (tty_hung_up_p(file))
+		return hung_up_tty_write(iocb, from);
 	if (tty_paranoia_check(tty, file_inode(file), "tty_write"))
 		return -EIO;
 	if (!tty || !tty->ops->write ||	tty_io_error(tty))
@@ -2166,11 +2163,6 @@ static int tty_open(struct inode *inode, struct file *filp)
 			return retval;
 
 		schedule();
-		/*
-		 * Need to reset f_op in case a hangup happened.
-		 */
-		if (tty_hung_up_p(filp))
-			filp->f_op = &tty_fops;
 		goto retry_open;
 	}
 	clear_bit(TTY_HUPPED, &tty->flags);
@@ -2204,6 +2196,8 @@ static __poll_t tty_poll(struct file *filp, poll_table *wait)
 	struct tty_ldisc *ld;
 	__poll_t ret = 0;
 
+	if (tty_hung_up_p(filp))
+		return hung_up_tty_poll(filp, wait);
 	if (tty_paranoia_check(tty, file_inode(filp), "tty_poll"))
 		return 0;
 
@@ -2256,6 +2250,8 @@ static int tty_fasync(int fd, struct file *filp, int on)
 	struct tty_struct *tty = file_tty(filp);
 	int retval = -ENOTTY;
 
+	if (tty_hung_up_p(filp))
+		return hung_up_tty_fasync(fd, filp, on);
 	tty_lock(tty);
 	if (!tty_hung_up_p(filp))
 		retval = __tty_fasync(fd, filp, on);
@@ -2684,6 +2680,8 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	int retval;
 	struct tty_ldisc *ld;
 
+	if (tty_hung_up_p(file))
+		return hung_up_tty_ioctl(file, cmd, arg);
 	if (tty_paranoia_check(tty, file_inode(file), "tty_ioctl"))
 		return -EINVAL;
 
@@ -2969,6 +2967,8 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
 		return tty_ioctl(file, cmd, arg);
 	}
 
+	if (tty_hung_up_p(file))
+		return hung_up_tty_compat_ioctl(file, cmd, arg);
 	if (tty_paranoia_check(tty, file_inode(file), "tty_ioctl"))
 		return -EINVAL;
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 2b2e6f0a54d6..4bf958efd6be 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -254,6 +254,7 @@ struct tty_file_private {
 	struct tty_struct *tty;
 	struct file *file;
 	struct list_head list;
+	bool hung; /* Whether __tty_hangup() was called or not. */
 };
 
 /**
-- 
2.18.4


