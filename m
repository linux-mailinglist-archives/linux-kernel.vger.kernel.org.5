Return-Path: <linux-kernel+bounces-134699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F16889B5B5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A44283FF0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D6715C9;
	Mon,  8 Apr 2024 01:46:42 +0000 (UTC)
Received: from h3cspam02-ex.h3c.com (smtp.h3c.com [60.191.123.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07034A40;
	Mon,  8 Apr 2024 01:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.191.123.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712540802; cv=none; b=uBhB8j6J8Q2nC5253iC49hMJlP9uyLnArrOQR7RRgXsokP5Fz5uDKwYC2iXJCFw7j8qERr2/c+qKmtVO/1jM67JvIIoCF70NdgWlkv9L7r11tkS7z8kpV+LFKYSm5k2KeYtO94BGZ5vkosFoYlFsA0wDa42KEOZZqxXU2wkWSjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712540802; c=relaxed/simple;
	bh=HyM5zS7f5MYGW6eeBg1qi8l7ZaziJAsjzE+M8sUoukg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKafLDFQj4vBZcce113NKLZeX8vgzZ9wKOBz9/6+bX07/2xQFTsX30fh2yw7zNGzAsM/gGbVQiF9vmWR4OzrEWFFcBXCwZvZ0enmg08WtHN1lcEdPdWiYyMr8pDSLxnbfbENS6Ob8p3DkC5Gx2iHE53zaOIBZNomn7jIhu2Qp7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com; spf=pass smtp.mailfrom=h3c.com; arc=none smtp.client-ip=60.191.123.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h3c.com
Received: from mail.maildlp.com ([172.25.15.154])
	by h3cspam02-ex.h3c.com with ESMTP id 4381jBwW077166;
	Mon, 8 Apr 2024 09:45:11 +0800 (GMT-8)
	(envelope-from liu.yeC@h3c.com)
Received: from DAG6EX02-IMDC.srv.huawei-3com.com (unknown [10.62.14.11])
	by mail.maildlp.com (Postfix) with ESMTP id D6F9D2004BBA;
	Mon,  8 Apr 2024 09:47:16 +0800 (CST)
Received: from localhost.localdomain (10.114.186.34) by
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.27; Mon, 8 Apr 2024 09:45:11 +0800
From: LiuYe <liu.yeC@h3c.com>
To: <andy.shevchenko@gmail.com>
CC: <daniel.thompson@linaro.org>, <dianders@chromium.org>,
        <gregkh@linuxfoundation.org>, <jason.wessel@windriver.com>,
        <jirislaby@kernel.org>, <kgdb-bugreport@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <liu.yec@h3c.com>, LiuYe <liu.yeC@h3c.com>
Subject: Re: Re: [PATCH V8] kdb: Fix the deadlock issue in KDB debugging.
Date: Mon, 8 Apr 2024 09:44:53 +0800
Message-ID: <20240408014453.1431652-1-liu.yeC@h3c.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Zg3WicDB8m9am7dJ@surfacebook.localdomain>
References: <Zg3WicDB8m9am7dJ@surfacebook.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG6EX02-IMDC.srv.huawei-3com.com (10.62.14.11)
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:h3cspam02-ex.h3c.com 4381jBwW077166

>Wed, Apr 03, 2024 at 02:11:09PM +0800, liu.yec@h3c.com kirjoitti:
>> From: LiuYe <liu.yeC@h3c.com>
>> 
>> Currently, if CONFIG_KDB_KEYBOARD is enabled, then kgdboc will
>> attempt to use schedule_work() to provoke a keyboard reset when
>> transitioning out of the debugger and back to normal operation.
>> This can cause deadlock because schedule_work() is not NMI-safe.
>> 
>> The stack trace below shows an example of the problem. In this
>> case the master cpu is not running from NMI but it has parked
>> the slave CPUs using an NMI and the parked CPUs is holding
>> spinlocks needed by schedule_work().
>
>> example:
>>  BUG: spinlock lockup suspected on CPU#0, namex/10450
>>  lock: 0xffff881ffe823980, .magic: dead4ead, .owner: namexx/21888, .owner_cpu: 1
>>  ffff881741d00000 ffff881741c01000 0000000000000000 0000000000000000
>>  ffff881740f58e78 ffff881741cffdd0 ffffffff8147a7fc ffff881740f58f20
>> Call Trace:
>>  [<ffffffff81479e6d>] ? __schedule+0x16d/0xac0
>>  [<ffffffff8147a7fc>] ? schedule+0x3c/0x90
>>  [<ffffffff8147e71a>] ? schedule_hrtimeout_range_clock+0x10a/0x120
>>  [<ffffffff8147d22e>] ? mutex_unlock+0xe/0x10
>>  [<ffffffff811c839b>] ? ep_scan_ready_list+0x1db/0x1e0
>>  [<ffffffff8147e743>] ? schedule_hrtimeout_range+0x13/0x20
>>  [<ffffffff811c864a>] ? ep_poll+0x27a/0x3b0
>>  [<ffffffff8108c540>] ? wake_up_q+0x70/0x70
>>  [<ffffffff811c99a8>] ? SyS_epoll_wait+0xb8/0xd0
>>  [<ffffffff8147f296>] ? entry_SYSCALL_64_fastpath+0x12/0x75
>>  CPU: 0 PID: 10450 Comm: namex Tainted: G           O    4.4.65 #1
>>  Hardware name: Insyde Purley/Type2 - Board Product Name1, BIOS 05.21.51.0036 07/19/2019
>>   0000000000000000 ffff881ffe813c10 ffffffff8124e883 ffff881741c01000
>>   ffff881ffe823980 ffff881ffe813c38 ffffffff810a7f7f ffff881ffe823980
>>   000000007d2b7cd0 0000000000000001 ffff881ffe813c68 ffffffff810a80e0
>>   Call Trace:
>>   <#DB>  [<ffffffff8124e883>] dump_stack+0x85/0xc2
>>   [<ffffffff810a7f7f>] spin_dump+0x7f/0x100
>>   [<ffffffff810a80e0>] do_raw_spin_lock+0xa0/0x150
>>   [<ffffffff8147eb55>] _raw_spin_lock+0x15/0x20
>>   [<ffffffff8108c256>] try_to_wake_up+0x176/0x3d0
>>   [<ffffffff8108c4c5>] wake_up_process+0x15/0x20
>>   [<ffffffff8107b371>] insert_work+0x81/0xc0
>>   [<ffffffff8107b4e5>] __queue_work+0x135/0x390
>>   [<ffffffff8107b786>] queue_work_on+0x46/0x90
>>   [<ffffffff81313d28>] kgdboc_post_exp_handler+0x48/0x70
>>   [<ffffffff810ed488>] kgdb_cpu_enter+0x598/0x610
>>   [<ffffffff810ed6e2>] kgdb_handle_exception+0xf2/0x1f0
>>   [<ffffffff81054e21>] __kgdb_notify+0x71/0xd0
>>   [<ffffffff81054eb5>] kgdb_notify+0x35/0x70
>>   [<ffffffff81082e6a>] notifier_call_chain+0x4a/0x70
>>   [<ffffffff8108304d>] notify_die+0x3d/0x50
>>   [<ffffffff81017219>] do_int3+0x89/0x120
>>   [<ffffffff81480fb4>] int3+0x44/0x80
>
>Ouch.
>Please, read this
>https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages
>and modify the commit message accordingly.

The example is the printout of the kernel lockup detection mechanism, which may be easier to understand. 
If organized according to the format provided in the previous link, should it be arranged as follows?

Example:
BUG: spinlock lockup suspected on CPU#0. owner_cpu: 1
CPU1: Call Trace:
__schedule
schedule
schedule_hrtimeout_range_clock
mutex_unlock
ep_scan_ready_list
schedule_hrtimeout_range
ep_poll
wake_up_q
SyS_epoll_wait
entry_SYSCALL_64_fastpath

CPU0: Call Trace:
dump_stack
spin_dump
do_raw_spin_lock
_raw_spin_lock
try_to_wake_up
wake_up_process
insert_work
__queue_work
queue_work_on
kgdboc_post_exp_handler
kgdb_cpu_enter
kgdb_handle_exception
__kgdb_notify
kgdb_notify
notifier_call_chain
notify_die
do_int3
int3

>> We fix the problem by using irq_work to call schedule_work()
>> instead of calling it directly. This is because we cannot
>> resynchronize the keyboard state from the hardirq context
>> provided by irq_work. This must be done from the task context
>> in order to call the input subsystem.
>> 
>> Therefore, we have to defer the work twice. First, safely
>> switch from the debug trap context (similar to NMI) to the
>> hardirq, and then switch from the hardirq to the system work queue.
>
>> Signed-off-by: LiuYe <liu.yeC@h3c.com>
>> Co-authored-by: Daniel Thompson <daniel.thompson@linaro.org>
>
>Correct tag is Co-developed-by, btw it's written in the same document the link
>to which I provided a few lines above.

Yes, there will be warnings when using the ./scripts/checkpatch.pl script to check.

WARNING: Non-standard signature: Co-authored-by:
#68:
Co-authored-by: Daniel Thompson <daniel.thompson@linaro.org>

total: 0 errors, 1 warnings, 51 lines checked 

I will change it to the following:

Co-developed-by: Daniel Thompson <daniel.thompson@linaro.org>

>
>> --- a/drivers/tty/serial/kgdboc.c
>> +++ b/drivers/tty/serial/kgdboc.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/module.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/serial_core.h>
>> +#include <linux/irq_work.h>
>
>Please, keep it ordered (with visible context this should go at least before
>module.h).

I don't understand why this needs to be placed before module.h. Please explain further, thank you.


