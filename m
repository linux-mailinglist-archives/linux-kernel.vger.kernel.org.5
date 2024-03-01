Return-Path: <linux-kernel+bounces-88429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C51A86E17C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA5B1F22FF2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1465D41C7F;
	Fri,  1 Mar 2024 13:04:18 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E552638FBE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298257; cv=none; b=X567dpHQyONrJmffvPaRUOOCjCnQdJy+OCh6VUYIFu9AN4XMt/jj3CGUxcevVWN8+6W6/VvkKiO6KHTMveWrMjRaHg8BnMwY7P0Dm8BrgdPfmeNFu8KYNKBxOWVDBQYQv+btOQZZSwJZJ4sLXwJRrPiC1Bx8VZH7fYWf7uMTum4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298257; c=relaxed/simple;
	bh=0ndBKkzJP+ZMoxO9U7QYSs+Fbh76QQrdNHEic+5wGnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Imz20Y4uyfGltY1QKE6NHbR5bviX5lv8OAv8dOMLcKBenRX8JIA1ja9DYc61hNVbXUq8helhqilaGopgk+jI49XsM0iljhR2/nR8h3jlJimj9q7u6bK3czWUxsfVyORvXN2jFoNhtqaelqnybm74fn0ixQ2JsUjvl3/zMc1mAYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 421D46Sd054249;
	Fri, 1 Mar 2024 22:04:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Fri, 01 Mar 2024 22:04:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 421D46jq054245
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 1 Mar 2024 22:04:06 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <70bfa1c9-6790-4537-bdc5-5d633c6ea806@I-love.SAKURA.ne.jp>
Date: Fri, 1 Mar 2024 22:04:06 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH for 6.8] tomoyo: fix UAF write bug in tomoyo_write_control()
Content-Language: en-US
To: Sam Sun <samsun1006219@gmail.com>, paul@paul-moore.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: syzkaller@googlegroups.com, takedakn@nttdata.co.jp, jmorris@namei.org,
        serge@hallyn.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAEkJfYNDspuGxYx5kym8Lvp--D36CMDUErg4rxfWFJuPbbji8g@mail.gmail.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAEkJfYNDspuGxYx5kym8Lvp--D36CMDUErg4rxfWFJuPbbji8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Since tomoyo_write_control() updates head->write_buf when write() of long
lines is requested, we need to fetch head->write_buf after head->io_sem is
held. Otherwise, concurrent write() requests can cause use-after-free-write
and double-free problems.

Reported-by: Sam Sun <samsun1006219@gmail.com>
Closes: https://lkml.kernel.org/r/CAEkJfYNDspuGxYx5kym8Lvp--D36CMDUErg4rxfWFJuPbbji8g@mail.gmail.com
Fixes: bd03a3e4c9a9 ("TOMOYO: Add policy namespace support.")
Cc: stable@vger.kernel.org # Linux 3.1+
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
I couldn't reproduce this problem in my environment, but I believe
this does fix a bug. Linus, can you directly apply to linux.git ?
If Linus wants a GIT PULL request, can Paul send this patch via LSM tree
because TOMOYO's git tree is not working?

 security/tomoyo/common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 57ee70ae50f2..ea3140d510ec 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2649,13 +2649,14 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
 {
 	int error = buffer_len;
 	size_t avail_len = buffer_len;
-	char *cp0 = head->write_buf;
+	char *cp0;
 	int idx;
 
 	if (!head->write)
 		return -EINVAL;
 	if (mutex_lock_interruptible(&head->io_sem))
 		return -EINTR;
+	cp0 = head->write_buf;
 	head->read_user_buf_avail = 0;
 	idx = tomoyo_read_lock();
 	/* Read a line and dispatch it to the policy handler. */
-- 
2.34.1



