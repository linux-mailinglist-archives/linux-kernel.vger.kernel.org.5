Return-Path: <linux-kernel+bounces-121434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B3C88E7DA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2883A1F35ABA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB971148834;
	Wed, 27 Mar 2024 14:26:21 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110C214882E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549581; cv=none; b=AbDhN6jUz8w+K8hC6kRUVksN10UhiyIhSqlgU6rdD2n27obm2TZKZ5bsqNbLcb7TWtbt7zp8mZ3Z368txgs/waatxGEZ11+iZ+UDAbktrYyf+xLT7hdE0T91I0ztBwY+kQhwE26v/cMKLX9lnF4aiHM/AtRgXnCHiloEE6OxO3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549581; c=relaxed/simple;
	bh=tc99LQ8/bN2jng+sFvmWcqITHA+NqPWXNfa4bVPy7O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7Za8SjLDb4xwD6DN8NJWRS6lEtZewTiAB+8gSAm2+dUi4yVczB6wyY1QEz5wwAQhUCYb5C4D9nGXtqD41PiaGFQNiytBHUpBOJSaR2BT5UuhQuy4IAqSBBekkAoX5kjiR5l4/eOkA4urLys+c7tX3rTkoz9SVRBpyH85+7xsW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42REPEUa015043;
	Wed, 27 Mar 2024 23:25:14 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Wed, 27 Mar 2024 23:25:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42REPEED015040
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 27 Mar 2024 23:25:14 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <895193c7-1339-45b3-99fa-6fc804040a3c@I-love.SAKURA.ne.jp>
Date: Wed, 27 Mar 2024 23:25:14 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] possible deadlock in console_flush_all (2)
Content-Language: en-US
To: John Ogness <john.ogness@linutronix.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc: syzbot <syzbot+f78380e4eae53c64125c@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <000000000000e40a2906072e9567@google.com>
 <ab273ae2-80ec-45da-910a-e74298c71d50@I-love.SAKURA.ne.jp>
 <CAADnVQLmLMt2bF9aAB26dtBCvy2oUFt+AAKDRgTTrc7Xk_zxJQ@mail.gmail.com>
 <596aad11-ee69-4ef1-b945-7b67a9fb22d7@I-love.SAKURA.ne.jp>
 <CAADnVQL6Q3k0+-5X3Xjov7W_xESxkmVXcsCxQRWitQvhTBsf7A@mail.gmail.com>
 <dd264bf7-821b-4cf4-802b-60ae3c7b83bd@I-love.SAKURA.ne.jp>
 <CAADnVQJt+aP=Zo4edCu4iQEmdQjiruR1pJn0qyZZboNym+zd0w@mail.gmail.com>
 <87o7b0szno.fsf@jogness.linutronix.de>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <87o7b0szno.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/03/27 20:05, John Ogness wrote:
> The printk rework (which is not yet fully mainline) will correctly
> handle this context.
> 
> As to the patch [0] you suggested, it would be more appropriate to
> perform deferred_enter/_exit *within* the locked critical section. But
> we really only want these whack-a-mole workarounds for cases that can
> occur in a non-bug situation. IMHO this is not such a case and falls
> into the category of "known problem, the rework will handle it".
> 
> John Ogness
> 
> [0] https://syzkaller.appspot.com/text?tag=Patch&x=121c92fe180000
> 

Since the cause of current flood of lockdep reports is already explained
in https://syzkaller.appspot.com/bug?extid=c4f4d25859c2e5859988 , we don't
need [0] for now. But it is unfortunate that the message which explains
what went wrong cannot be reported due to reporting console_lock dependency.
Therefore, I intend [0] as a workaround for a bug situation. We can revert [0]
after the printk rework completed.


