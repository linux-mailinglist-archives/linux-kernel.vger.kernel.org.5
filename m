Return-Path: <linux-kernel+bounces-33142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5DF836521
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4541228E17E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F173D397;
	Mon, 22 Jan 2024 14:09:37 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502393D38D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932577; cv=none; b=esqupLVcLcahZ7Q0DQz1A2FMvX8AeQdth2VbygwCO73/Gnc85nRNpiXZ4OjsBjSvOKXmuMsecTBK3ZfXsoqPJW6Eae828vTixygR5Ht+T9XcUVJNMAlnmUOLq34RmVHruJoshgXhe9OC0ztKG4LWSqWb5hYxflsI6ezZCdqD0JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932577; c=relaxed/simple;
	bh=SAtsYJPDMPLNHQqhKq7UpT8bIcR6I+Eordc5pCOXcCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nyqi7B4ZtgxFhgKzSpqhh3vZIAyS+9euBUstiXJsnoNEEpzcNyr7GmANTd9gtWGeE+BNHShV5QmzWEoQ2OljhCx3jISK4mx/YuVOznZeTHEeRA7wEVIAbxHd1MNyVvDhsJnbG+Q10TFxVS/8c3BdecTdY7m/qgJEEus9b49BZNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 40ME8XUc057761;
	Mon, 22 Jan 2024 23:08:33 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Mon, 22 Jan 2024 23:08:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 40ME8XZ7057758
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 22 Jan 2024 23:08:33 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7dc23b9d-5120-4966-b47b-fcabe270d498@I-love.SAKURA.ne.jp>
Date: Mon, 22 Jan 2024 23:08:29 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: vt: check for atomic context in con_write()
Content-Language: en-US
To: Jiri Slaby <jirislaby@kernel.org>,
        syzbot <syzbot+06fa1063cca8163ea541@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Starke, Daniel" <daniel.starke@siemens.com>,
        Lee Jones <lee@kernel.org>, Fedor Pchelkin <pchelkin@ispras.ru>
Cc: linux-kernel@vger.kernel.org, linux-serial <linux-serial@vger.kernel.org>
References: <00000000000039f237060f354ef7@google.com>
 <83414cb6-df16-4b6d-92e3-d54d22ba26cc@I-love.SAKURA.ne.jp>
 <9cd9d3eb-418f-44cc-afcf-7283d51252d6@I-love.SAKURA.ne.jp>
 <82aa07d4-13ac-4b1d-80cd-0970c71752a5@kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <82aa07d4-13ac-4b1d-80cd-0970c71752a5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/01/22 15:48, Jiri Slaby wrote:
> On 20. 01. 24, 11:34, Tetsuo Handa wrote:
>> syzbot is reporting sleep in atomic context, for gsmld_write() is calling
>> con_write() with spinlock held and IRQs disabled.
> 
> gsm should never be bound to a console in the first place.
> 
> Noone has sent a patch to deny that yet.
> 
> Follow:
> https://lore.kernel.org/all/49453ebd-b321-4f34-a1a5-d828d8881010@kernel.org/
> 
> And feel free to patch that ;).
> 
> thanks,

OK. Here is a deny-listing based filter using device number of sysfs entry.
(We don't want to compare with the function address of con_write().
Thus, this patch is comparing with device major/minor numbers.)

----------
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 4036566febcb..6f9730dce5aa 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3630,6 +3630,10 @@ static int gsmld_open(struct tty_struct *tty)
 	if (tty->ops->write == NULL)
 		return -EINVAL;
 
+	/* Can't be attached to virtual consoles. */
+	if (tty->dev && MAJOR(tty->dev->devt) == 4 && MINOR(tty->dev->devt) < 64)
+		return -EINVAL;
+
 	/* Attach our ldisc data */
 	gsm = gsm_alloc_mux();
 	if (gsm == NULL)
----------

Is it possible to use allow-listing based filtering?
(Attaching on /dev/tty (major=5, minor=0) causes current ssh session
to be closed. Unexpectedly loosing connection might be a problem for
fuzz testing...)

----------
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/tty.h>

int main(int argc, char *argv[]) {
        int ldisc = N_GSM0710;

        return ioctl(open(argv[1], O_RDWR | O_NOCTTY | O_NDELAY), TIOCSETD, &ldisc) == 0;
}
----------


