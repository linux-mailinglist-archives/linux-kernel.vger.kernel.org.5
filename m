Return-Path: <linux-kernel+bounces-56761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D2E84CEC3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25451C265E2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8DB80BEA;
	Wed,  7 Feb 2024 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UiZ2f+6A"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D518063F
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322722; cv=none; b=JcCDT3E1x0zsZmPZVeH6xaSOhitXdbyIy9ioZAji80ax7pmzUHzpc1nU+VX1/EptI22kobmDjEBMbpC5fc1F6as95uSmmbY21r+7NwiDjCld0YH9fkjK6U9Q3low311YcqQ6oEnRWUfVsUiUjn9U5n2AEo+fPJEEn0nvvKzXhYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322722; c=relaxed/simple;
	bh=sVOPThi/QUfRkmH39G9zIkjQB9aCGiSiIwNnPdKz7AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEmIe1Bbnsep6uIcB3/jsI1EHENwUCC3OVOtNTz+grhVxSQWzF3s52007fOrmGVHim4rPExZzgHeWamUR8SY+6yc6Qj3r08gxm81MlW5k6i/1rAkJms8tCrweWYwRnU7TGxzZsfzYzhhXbhcZzcLpv99NPQUWCeLrUfsV9v1pmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UiZ2f+6A; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56077dd7936so1010817a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 08:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707322718; x=1707927518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oFVoWznFM6unJk0TCliav4VmM1lXuzkYTMWn4cMSxPo=;
        b=UiZ2f+6A4WCyIfIAddlguVRoSgj6tOsUUt6rFznxcO4ttPkyGMedEFPJo62YXJNH4Q
         u3cNNM7Q9XKm5+do5gUdDQ5H6x9SpM1EArPeZ15iwSkiDmi2JNrEYFr6zVaS1OAASbHm
         sWMJhou7BXUZUHibiXnKze4PFeXMi74uFvdwaM/QlF7sIZirCRK4jQOnWaKjQ5/AzSy4
         yuMblwBRw+ixbzwKLNhBuHMjyhgJgLbTxo5S/ypoBjRpKny/iW4ahtYZZVmOFq17iA2a
         Qju1ByKFNzs/nA6EJAql5HimOa1QGM7V4V7D9jtQBn0xXxBKUnl1PZNmt80BpdanaSi/
         yWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707322718; x=1707927518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFVoWznFM6unJk0TCliav4VmM1lXuzkYTMWn4cMSxPo=;
        b=HogHJmwiz71iBuyDnRm15YXCdi0mFR/fN6/FCcQYgevMSYqKfp+yXYq9h6uBPgxXWn
         6K9Gy3ULh4dm2BDBeuJTNY6KYPdcNyzxLPCbPzO+ne0olsSlUwLDJjBMkGVL7Ra6yO+J
         faldW4ZG7EGAMlg+jkGjQnTO7FrKKIZizGRV0F9vvP7u35BcRmk/tluZM0Adn/COKutv
         oN+8ONCP5o2/SAJMtdOjTCDRf6dohgs/tDNF0pKhzEY8k7q4zFlr+YmhqPDpDvCm9lKs
         o1LS5wjRBdpBtBZHVJsnb3RpvX5jzZY6A6hwX0oG5gH/LB9ku4LiQbhuVCF+B6zhLvLB
         UDew==
X-Gm-Message-State: AOJu0Yx7LHOHQKE2v80e3Cit6UwXNUVebqfmShtl4vMGz3wxZBMdJqZU
	TF+YCCRJAzmRxexwmj22yKzl6BiEoT2czbaoCDUM7xFVF3WYWuy2jvXQE0HZl+c=
X-Google-Smtp-Source: AGHT+IEXzCHelVrZoKpz8miuL5NYQhg6Xaazxr2bpeUpHXi36Ko5Fim7WNH1whauwBHamOsBE0CEmw==
X-Received: by 2002:a17:907:9116:b0:a38:3af4:a70a with SMTP id p22-20020a170907911600b00a383af4a70amr3125078ejq.60.1707322718368;
        Wed, 07 Feb 2024 08:18:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUcTMKqqqLN7bzUOlV9EasExfOoRNHlobbgeoEPy82pUtythwF4HBihHdNQbvMVYIu3crzrKLcjeaTG8KiApPuAZjJITFf/xY0bm39DoF5qEUEl+8ZIWFjaAAgNA+7Mbc4gCrZqj/nhDb8DsbP3i+fdjydIZS8Sqpq0bG233Eas+H/ILkzk70GGBZ27hXTo2ry1HMCCkdG/a+SF3E1pAzB0QfRQVLNZx26Hqg/XxKisK+QH66YgKEsjtoAFc+98ZB4jcvAYBmDRHqOwaQe6idzy9x+HlU6BkZf0cK2DTVWRvD3lPbPQjp42jC9567LjsGzEUu9wmf2CCXa9oGVMBoy5yqV2hlyRrp11zFXx4ixoyjdtI4KjEDy9zJpZWMMdW2u9S2a5Z78QuNTmr7wCiSrsDUhcLggSSy8=
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id oz14-20020a170906cd0e00b00a38620c3b3dsm902526ejb.198.2024.02.07.08.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:18:38 -0800 (PST)
Date: Wed, 7 Feb 2024 17:18:36 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>, Uros Bizjak <ubizjak@gmail.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH printk v4 00/14] fix console flushing
Message-ID: <ZcOtXKtHuVUTQNRN@alley>
References: <20240207134103.1357162-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207134103.1357162-1-john.ogness@linutronix.de>

On Wed 2024-02-07 14:46:49, John Ogness wrote:
> Hi,
> 
> While testing various flushing scenarios, I stumbled on a few
> issues that cause console flushing to fail. While at LPC2023 in
> Richmond, I sat down with Petr Mladek and we reviewed the
> v2 [0] series. This series is the result of that offline
> discussion. v3 is here [1].
> 
> This series addresses the following issues:
> 
> 1. The prb_next_seq() optimization caused inconsistent return
>    values. Fix prb_next_seq() to the originally intended
>    behavior but keep an optimization.
> 
> 2. pr_flush() might not wait until the most recently stored
>    printk() message if non-finalized records precede it. Fix
>    pr_flush() to wait for all records to print that are at
>    least reserved at the time of the call.
> 
> 3. In panic, the panic messages will not print if non-finalized
>    records precede them. Add a special condition so that
>    readers on the panic CPU will drop records that are not in
>    a consistent state.
> 
> 4. It is possible (and easy to reproduce) a scenario where the
>    console on the panic CPU hands over to a waiter of a stopped
>    CPU. Do not use the handover feature in panic.
> 
> 5. If messages are being dropped during panic, non-panic CPUs
>    are silenced. But by then it is already too late and most
>    likely the panic messages have been dropped. Change the
>    non-panic CPU silencing logic to _immediately_ silence
>    non-panic CPUs during panic. This also leads to clean panic
>    output when many CPUs are blasting the kernel log.
> 
> 6. If a panic occurs in a context where printk() calls defer
>    printing (NMI or printk_safe section), the printing of the
>    final panic messages rely on irq_work. If that mechanism is
>    not available, the final panic messages are not seen (even
>    though they are finalized in the ringbuffer). Add one last
>    explicit flush after all printk() calls are finished to
>    ensure all available messages in the kernel log are printed.
> 
> 7. When dumping the stacktrace from panic(), do not use the
>    printk_cpu_sync because it can deadlock if another CPU holds
>    and is unable to release the printk_cpu_sync.
> 
> This series also performs some minor cleanups to remove open
> coded checks about the panic context and improve documentation
> language regarding data-less records.
> 
> Because of multiple refactoring done in recent history, it
> would be helpful to provide the LTS maintainers with the proper
> backported patches. I am happy to do this.

The series seems to be ready linux-next from my POV. I am going
to push it there so that it gets as much testing before
the merge window as possible.

Best Regards,
Petr

