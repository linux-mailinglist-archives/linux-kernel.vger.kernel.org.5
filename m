Return-Path: <linux-kernel+bounces-152240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60998ABB44
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 654ACB217D9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483DB2941F;
	Sat, 20 Apr 2024 11:12:56 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84678DDD9;
	Sat, 20 Apr 2024 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713611575; cv=none; b=QI+PPjI200WE0ge0BBaD0NkQ2K+L1V48VmyG+UyN+IbraYsomoBUnSsmE6ixgNuwJNcbJiXmuv+I6cERThqh+74ny3n3tuTCeAbEnzRUI5/tUeeWFLYfbHvBaRHz+SFSJqBbqyoJSHq07HaLmLK5tYQrkRng3gtTpAVmBGSjORU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713611575; c=relaxed/simple;
	bh=zWl1BQf481DzJyk/natZZmOl4ZV7BIUTnSgzALdmI6U=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=YujOuJQgik2FilFcBJjhNOSAvGj1GDRh09kU8PSqBAhQHpSP5pXb/XiCVEcC7iR6TvKJ5HBmEUzsh7QSbEVvwWwYNPX7QG6Lda/NTCsh70UWHqrM4/X3E6UA2uSJeYOCdMjl+/d8kRL4qVeCPLkeG5xsRatlsf4KgkHS8tVSDk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 43KBCWj2079237;
	Sat, 20 Apr 2024 20:12:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Sat, 20 Apr 2024 20:12:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 43KBCWif079233
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 20 Apr 2024 20:12:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e696e720-0cd3-4505-8469-a94815b39467@I-love.SAKURA.ne.jp>
Date: Sat, 20 Apr 2024 20:12:32 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andrew Morton
 <akpm@linux-foundation.org>,
        "Starke, Daniel" <daniel.starke@siemens.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v2] tty: n_gsm: restrict tty devices to attach
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

syzbot is reporting sleep in atomic context, for gsmld_write() is calling
con_write() with spinlock held and IRQs disabled.

Since n_gsm is designed to be used for serial port [1], reject attaching to
virtual consoles and PTY devices, by checking tty's device major/minor
numbers at gsmld_open().

Starke, Daniel commented

  Our application of this protocol is only with specific modems to enable
  circuit switched operation (handling calls, selecting/querying networks,
  etc.) while doing packet switched communication (i.e. IP traffic over
  PPP). The protocol was developed for such use cases.

at [2], but it seems that nobody can define allow list for device numbers
where this protocol should accept. Therefore, this patch defines deny list
for device numbers.

Greg Kroah-Hartman is not happy with use of hard-coded magic numbers [3],
but I don't think we want to update include/uapi/linux/major.h and add
include/uapi/linux/minor.h just for fixing this bug.

Link: https://www.kernel.org/doc/html/v6.8/driver-api/tty/n_gsm.html [1]
Link: https://lkml.kernel.org/r/DB9PR10MB588170E923A6ED8B3D6D9613E0CBA@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM [2]
Link: https://lkml.kernel.org/r/2024020615-stir-dragster-aeb6@gregkh [3]
Reported-by: syzbot <syzbot+dbac96d8e73b61aa559c@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=dbac96d8e73b61aa559c
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Adding LSM ML to CC list in order to ask for comments if Greg again
complained that we don't want to add sanity check on the kernel side.
I agree that we should fix fuzzers if fuzzers are writing random data
to /dev/mem or /dev/kmem . But for example
https://lkml.kernel.org/r/CAADnVQJQvcZOA_BbFxPqNyRbMdKTBSMnf=cKvW7NJ8LxxP54sA@mail.gmail.com
demonstrates that developers try to fix bugs on the kernel side rather
than tell fuzzers not to do artificial things.

 drivers/tty/n_gsm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 4036566febcb..14581483af78 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3623,6 +3623,7 @@ static void gsmld_close(struct tty_struct *tty)
 static int gsmld_open(struct tty_struct *tty)
 {
 	struct gsm_mux *gsm;
+	int major;
 
 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
@@ -3630,6 +3631,17 @@ static int gsmld_open(struct tty_struct *tty)
 	if (tty->ops->write == NULL)
 		return -EINVAL;
 
+	major = tty->driver->major;
+	/* Reject Virtual consoles */
+	if (major == 4 && tty->driver->minor_start == 1)
+		return -EINVAL;
+	/* Reject Unix98 PTY masters/slaves */
+	if (major >= 128 && major <= 143)
+		return -EINVAL;
+	/* Reject BSD PTY masters/slaves */
+	if (major >= 2 && major <= 3)
+		return -EINVAL;
+
 	/* Attach our ldisc data */
 	gsm = gsm_alloc_mux();
 	if (gsm == NULL)
-- 
2.18.4

