Return-Path: <linux-kernel+bounces-87880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B103386DA57
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A75B233AF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E952546433;
	Fri,  1 Mar 2024 03:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="E+VU+tN0"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935C616FF42
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 03:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264836; cv=none; b=VDHBWoOW8ZJZenGaDVlDajf9b8CSIgrmnFnuqI3lJ/xlURbDXFv/sNo8P3SGGkrWdRvZP7PGr3v9Bc5aBRR2d3HSvnui9ewoyh3JAwSZ7xTZzrvGxlt6HQjAd0zHqpJF8q32vwJGAS6izFr8nb6/X/7TdNhEoaD3EaikIM30jjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264836; c=relaxed/simple;
	bh=5lI8qA8Sd9zWuBqqV8KDmYpslmVSQLcRzhgA/iqHo/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvBsPE9YSn/iMLrSHDDMY1nu2ThcJGy3J7D9FWseQMlQvczsQAj0UZRYEFhp6WSoryonXUGpPSDC4PzosKspI5+idoMdwge2z2jWYXB6aeSJ5dKMXcH/qbBbJ5TTu0RvoF8jWfRTXdJDpkTJojKw3f/k0fJ++PYt0NDmldfyuWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=E+VU+tN0; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3657dbe2008so8201465ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 19:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709264833; x=1709869633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VkcaSuD/e18p8NNnt1Mz3M/RrO78CTrFgbKnRB/hUAw=;
        b=E+VU+tN0X0fJbfyNsuauKei4D5nrJMVf73ExV/93thDRx6G3eiiYPe01FjY4v1Ymir
         084s4cSiwi63j0nKJ5Q4EAcIpVQPL72MqqbBvO2exzi/811uhXhAUXsp02eryvXTSquk
         KlkwGMRAHlf1P6vDN56EZvtmwL0vEB6FBdbvXc+/MvyJoulTv4TBwjjwhx9NK3zeVLhb
         xIJsYO7Pgd2MdDIRAmWwJBcNv8SgX31qKOo8UxJlSuPpvWWDhX+koZJT0fM0d8RZraEh
         C4avPUK3uUkPg4gIxSPrcUBxNuZVwIC/B0RaHmlMtMvR52EXFLgdd18T/bDDnhEl7Bdz
         qmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709264833; x=1709869633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkcaSuD/e18p8NNnt1Mz3M/RrO78CTrFgbKnRB/hUAw=;
        b=XoGdPfqlT2QNPpcc65iZGJVOz7VbUVR7i7/OvUK0WDUMzG896ecog4el9lFISSegE5
         WjPmj3aqsoRY4vPS1YL8DCKBxVWFI8PZgcFfb6EoT0PdAhBn3R87nCD2qs18O+5o42K1
         zu4Ou0rVEkP4Z8DmHWe6tO3GDdgGJle2Egm1HgBL78aJGQM1HlZkTxFtCenScnkn9UI4
         b5BlDMRaAoD40feb8hQamVlHadP5/XQtCcpjuH8ZWKGcJkN9bAerCd5WTsfEBf/UDrsL
         p9+Pv/gNPTNSYQ4+fdTjrnkwvYEqnohVO8G+7pTPwTG2VflzL6DZfKTx2kSnECR5J+mv
         X11w==
X-Gm-Message-State: AOJu0YxN4qymkER3bMFDFagnP0pcYbjBgaDVFJ3q1FbectshcijC+Bqs
	VFsmHzybQYJDpo0geZHHchEDarjpJ2dI4cEzKhkEuREmUnQ36ecNYj/92cfNLn0=
X-Google-Smtp-Source: AGHT+IFvMq/bsFR3H0xjucX1QbOwr27zR7FRdT2v87Vf0/GobD4dmIf733kDH6b3gmK1s4yV89LGeQ==
X-Received: by 2002:a05:6e02:1807:b0:365:69a:86b2 with SMTP id a7-20020a056e02180700b00365069a86b2mr844972ilv.17.1709264833447;
        Thu, 29 Feb 2024 19:47:13 -0800 (PST)
Received: from [10.84.152.139] ([203.208.167.155])
        by smtp.gmail.com with ESMTPSA id z17-20020a170903019100b001db4433ef95sm2297074plg.152.2024.02.29.19.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 19:47:13 -0800 (PST)
Message-ID: <123ebd58-9ca1-4a12-bdb7-c35d0c48c93c@bytedance.com>
Date: Fri, 1 Mar 2024 11:47:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: general protection fault, probably for non-canonical address in
 pick_next_task_fair()
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, peterz@infradead.org, bp@alien8.de,
 tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
 Oliver Sang <oliver.sang@intel.com>
References: <ZeCo7STWxq+oyN2U@gmail.com>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <ZeCo7STWxq+oyN2U@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

(+ Chen Yu, Oliver Sang)

On 2/29/24 11:55 PM, Breno Leitao Wrote:
> I've been running some stress test using stress-ng with a kernel with some
> debug options enabled, such as KASAN and friends (See the config below).
> 
> I saw it in rc4 and the decode instructions are a bit off (as it is here
> also - search for mavabs in dmesg below and you will find something as `(bad)`,
> so I though it was a machine issue. But now I see it again, and I am sharing
> for awareness.
> 
> This is happening in upstream kernel against the following commit
> d206a76d7d2726 ("Linux 6.8-rc6")
> 
> This is the exercpt that shows before the crash:
> 
> 	general protection fault, probably for non-canonical address 0xdffffc0000000014: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN
> 	KASAN: null-ptr-deref in range [0x00000000000000a0-0x00000000000000a7]
> 
> This is the stack that is getting it
> 
> 	? __die_body (arch/x86/kernel/dumpstack.c:421)
> 	? die_addr (arch/x86/kernel/dumpstack.c:460)
> 	? exc_general_protection (arch/x86/kernel/traps.c:? arch/x86/kernel/traps.c:643)
> 	? asm_exc_general_protection (arch/x86/include/asm/idtentry.h:564)
> 	? pick_next_task_fair (kernel/sched/sched.h:1453 kernel/sched/fair.c:8435)
> 	? pick_next_task_fair (kernel/sched/fair.c:5463 kernel/sched/fair.c:8434)
> 	? update_rq_clock_task (kernel/sched/core.c:?)
> 	__schedule (kernel/sched/core.c:6022 kernel/sched/core.c:6545 kernel/sched/core.c:6691)
> 	schedule (kernel/sched/core.c:6803 kernel/sched/core.c:6817)
> 	syscall_exit_to_user_mode (kernel/entry/common.c:98 include/linux/entry-common.h:328 kernel/entry/common.c:201 kernel/entry/common.c:212)
> 	do_syscall_64 (arch/x86/entry/common.c:102)
> 	? irqentry_exit_to_user_mode (kernel/entry/common.c:228)
> 	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
> 
> Full dmesg: https://paste.mozilla.org/RiLnt4QO#
> Configs: https://paste.mozilla.org/XJ9wbdRp
> 

