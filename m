Return-Path: <linux-kernel+bounces-87879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4C386DA52
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30941C2236C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ACC46433;
	Fri,  1 Mar 2024 03:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Awwt3xow"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266503FE48
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 03:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264639; cv=none; b=Ths0OrAUNs3ogItb0YUTU7YcsW48hiWZARKIu7+6CPN4MUYjkS24kWNEWzzh0gJIRL5Ee2UsxgQu85jdyQzHF9cS+pWrLr38IMuiBrLW79lOD5BwSVCwP88fsjt3g6kdvbSJReS3ye5jImy44t9Yme0fXSb1Qg2WzmEM0CHXyGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264639; c=relaxed/simple;
	bh=eEphOB7L5LxuKhJ2HddSJgTBtydYEUHIHWjr//PIxXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwz50Gjo8Gizp1LNVA7w7/C2KyAhI1fOXx1WDk6FJIIIBqe0YvQC3/OukKLMHVCleG8ZfCGsZNm0DL3cnww1AI2ZrCU5z6KLo42BLYakw3LbkYzZNgyrBOTWwrXZMnyAi9pctnx2qAgtFwAbYKjxCA9VWLU3H3Pe6lML9drB1Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Awwt3xow; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dc9222b337so17359835ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 19:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709264636; x=1709869436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EyHtRFSUNi7GzaOkm9RM19dO1pfKk9FopJLsY9L/wQA=;
        b=Awwt3xowTyXKv+qb/esblFKNHK8IOp4MMBPjUTOH4cwFGkHQWqZ8ZEmGDQtbQ+So7B
         M1JyzoCIpY/gbk9gfRw8e+eRCddb174u5qLyMtVpmKRZ1TFvXk6l76qubpUQqoibG7pJ
         xPtAKoOPya2UEZZzH2sXtKGBeU+LVONVnxVrILilCk9bDUEtD49vWcmXldLdh9/HVdRL
         Mwivr6Z3bBXFMgsFRjwsqj0AaKQj5RDz9N1lTOQk9wuxHqltbX9f6SqG3LtLr08atx0E
         gYDJAh6gdtcWC8kQTuNOcnUD9Yd7IVcNtToBwC073Cc8YosPD9Hk1RgCa6LH0MVXymZb
         c4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709264636; x=1709869436;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EyHtRFSUNi7GzaOkm9RM19dO1pfKk9FopJLsY9L/wQA=;
        b=iaTvN/BPhJ1WFmGR00kS1PeK6GLUx3CxPPo6vq5/KCYWxf8ASh/rBpa3yxVhTXSZe9
         q2ZbnaCsL/dzVWoc057kWqF3pQSOv9Y0RP92JWRbanD6a5sojVnkq2eAs4fsEWwQ6El8
         T2GBJH7HtpBryGTNjEY16HYCpxSvNpDIN4yoLyJ5pVygap8A0750/1qDufyLfIGIeX8h
         H8BMm72dVHSHxaN6SfPPUcodQMJDUKHR9zy00Wceqjra/jgwz20AKkYcuys7Ijxz+C+z
         fdh9MmMoX5Oc92MRZyqNuAMiFi3Q2b5H4wq3Qe9ixq/zY5NbaO/tSSFW8iml/3S+z9sK
         D6Xw==
X-Gm-Message-State: AOJu0Yxtu0M5C4Ou2Pr7WFCDzOzOqwtcOTHdxDp68zWypWfXF5CVMKY8
	U9NjKTdGmkhaD8rSWG90ymw27BFcayB+UetQ9S+gnHaZP3qflTju3Fsk0kt3lZ+kroyZ6r+PpU+
	l
X-Google-Smtp-Source: AGHT+IE6w2EV9wKXEg933F0xDVKvhSt1/g9Zrt+cUbN+4AE6Of7BzLjcS/b5fycmFbdg4k+n8/CaaQ==
X-Received: by 2002:a17:902:9a45:b0:1db:7c5e:f07c with SMTP id x5-20020a1709029a4500b001db7c5ef07cmr453779plv.66.1709264636261;
        Thu, 29 Feb 2024 19:43:56 -0800 (PST)
Received: from [10.84.152.139] ([203.208.167.155])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902e74100b001dca68a8a00sm2268674plf.139.2024.02.29.19.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 19:43:55 -0800 (PST)
Message-ID: <45a41447-fe28-4807-9025-cc5e98f9f406@bytedance.com>
Date: Fri, 1 Mar 2024 11:43:49 +0800
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
Cc: linux-kernel@vger.kernel.org
References: <ZeCo7STWxq+oyN2U@gmail.com>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <ZeCo7STWxq+oyN2U@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Breno, this seems to be a known issue under discussion.

https://lore.kernel.org/lkml/202401301012.2ed95df0-oliver.sang@intel.com/
https://lore.kernel.org/lkml/20240226082349.302363-1-yu.c.chen@intel.com/

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

