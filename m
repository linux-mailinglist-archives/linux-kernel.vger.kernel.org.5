Return-Path: <linux-kernel+bounces-31759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2918333A0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95EC31C21285
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 10:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CC8D528;
	Sat, 20 Jan 2024 10:34:34 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507142F2D;
	Sat, 20 Jan 2024 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705746874; cv=none; b=Hqm13JOiPkBTH7IknfihmNOh584GOXNTdy1OvjKWNxU3NTDTwgMvzRUewcE6SCqJ8M38plfg0dDtTv/Ux0D98YqCc/GFXOEizEHr3OusNqQtl0QSZhZjde9DO8nYJZ8+tNOtebPSunJLeZe6nO1vdy6tP4ZQRlmWSrtg3hu/4ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705746874; c=relaxed/simple;
	bh=MhFgpNUMuNHG64flCLc5tUHSf5b5DIG7JaB6eZIoyk4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mYZsqC1pZMtN2pKNJAG/MZ1p0/trGYUDW2JuXBxHzfyg/yoeJwefQWuWhWldMncM+uOR7GRRYkCvpT49G+GnEUnDiJSEo6IikoJe4FCqu2UUJXLU0LJSNoOfCI53UvQfixU0LvziKTYkOD6+erbjgU5OR7fVtbw+EThwk6o/+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 40KAY1hh090240;
	Sat, 20 Jan 2024 19:34:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Sat, 20 Jan 2024 19:34:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 40KAY13L090233
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 20 Jan 2024 19:34:01 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9cd9d3eb-418f-44cc-afcf-7283d51252d6@I-love.SAKURA.ne.jp>
Date: Sat, 20 Jan 2024 19:34:02 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] tty: vt: check for atomic context in con_write()
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: syzbot <syzbot+06fa1063cca8163ea541@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial <linux-serial@vger.kernel.org>
References: <00000000000039f237060f354ef7@google.com>
 <83414cb6-df16-4b6d-92e3-d54d22ba26cc@I-love.SAKURA.ne.jp>
In-Reply-To: <83414cb6-df16-4b6d-92e3-d54d22ba26cc@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

syzbot is reporting sleep in atomic context, for gsmld_write() is calling
con_write() with spinlock held and IRQs disabled.

Since include/linux/tty_ldisc.h says that "struct tty_ldisc_ops"->write
(e.g. gsmld_write()) is allowed to sleep and include/linux/tty_driver.h
says that "struct tty_operations"->write (e.g. con_write()) is not
allowed to sleep, we should handle this problem on the con_write() side.

It seems that "Andrew Morton: console locking merge" in 2.4.10-pre11 added
in_interrupt() check to do_con_write()/con_put_char()/con_flush_chars()
in order to handle exceptional caller.

Since include/linux/preempt.h says that in_atomic() cannot know about held
spinlocks in non-preemptible kernels, but gsmld_write() is calling
con_write() with IRQs disabled, we can add irqs_disabled() check to
do_con_write()/con_flush_chars() in order to handle this case. Though,
I'm not sure whether returning the bytes to write is appropriate behavior
when do_con_write() can't work...

Reported-by: syzbot+06fa1063cca8163ea541@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=06fa1063cca8163ea541
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/tty/vt/vt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 156efda7c80d..0d3d602ae147 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2856,7 +2856,7 @@ static int do_con_write(struct tty_struct *tty, const u8 *buf, int count)
 	struct vt_notifier_param param;
 	bool rescan;
 
-	if (in_interrupt())
+	if (in_interrupt() || irqs_disabled())
 		return count;
 
 	console_lock();
@@ -3314,7 +3314,7 @@ static void con_flush_chars(struct tty_struct *tty)
 {
 	struct vc_data *vc;
 
-	if (in_interrupt())	/* from flush_to_ldisc */
+	if (in_interrupt() || irqs_disabled()) /* from flush_to_ldisc */
 		return;
 
 	/* if we race with con_close(), vt may be null */
-- 
2.18.4


