Return-Path: <linux-kernel+bounces-100811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2D8879D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF49DB2337E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37F7143740;
	Tue, 12 Mar 2024 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6bz3RCm"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651A214372D;
	Tue, 12 Mar 2024 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279320; cv=none; b=RzWuFbD7n9jzywGkUo4eUQme4p3Vq1RExhrs74rj7K6rYiJdv50gnmPAIrz57XisXd8L62E/PiMn/WUTwa71Km5Qd8xO0GRorUSsJCRaiHFet0IIRfT0pH5XkVz6yxuHYXtV8tgZZB701m2GcZBTfLRhJCROznk58bv6VO3SbRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279320; c=relaxed/simple;
	bh=unBMgmypSGytBRwERy7qRAyY0BplVbkHHpxL0ehxVpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTwTp2zum5jHb+Lq28Gx5/CAGbeqcfzqQUkg0CxTMLspdTNcLTu6XX/MOC01HU/Rt0mkmxDhWwmQvr5fMqP92RCQimDKqxnipYlPD+rrEpfMWdRvXsOrdW8fWFGIS4ywaHlbu9An+nKrYARnbIP8ph6vXQtcnHk6eainMVZLjYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6bz3RCm; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c19dd9ade5so2921353b6e.3;
        Tue, 12 Mar 2024 14:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710279318; x=1710884118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pxKLcmUIgxDjpGa5a71KILqahWh8nblbQcMEKAkFQhI=;
        b=B6bz3RCmLl6dzN6CgvgGe6EjN6xzpDeBbAk7rmrjp9kR/j1B3SuPDL5dV6naFaIzzZ
         syjWB7SXKq8nrG+qUsqq3AEX8OKyDB62AbmmApvJttt6K81S+6fSi1rDxjeeLBOHBCIZ
         PAtQEj4Usm4f0kfLUMOq1/jk0uDlaIQs+9ZSToMLvEcy3MFH+RszKs1Nrs7nX71zThVF
         FEPpdc4s44Cf+AjiiD+hDCDSPJclyJI3zcJTgKPQR43zoHlAqmrhBwGzjMqpxevN/9p+
         qtRYdEWccHQbuUH2OD/ioT1pQS+vczVAAiJF3q1XMIB5REyeJu3zKYwLTiyEqDZEiGVd
         jh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710279318; x=1710884118;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxKLcmUIgxDjpGa5a71KILqahWh8nblbQcMEKAkFQhI=;
        b=cbr9YSfc/f1jLbUoVWwvkbxVj9IulcGiMeuO1+/Pt38yIoD/JXpGA2oe3OQsOC4R2e
         3PlwcyqbwZYgqPWS8JLCibp+913oQIZ6lU8rciK/jqvB6eF78MDQwaacjUHKWDZ4eiRR
         MvwahuCubY9kiIhR4D6eyTjUptgM25UaNavI8ZdC0Yo3WdiPdXxrcpKyTmb6yUnuW4bD
         0a5hUKlbKM6szVfd3b65cEMPAzPRUTNnYMR7AFMa3cnxXREnrNzCRAWiADgiYiQj/kNo
         sHkniVIljaT4FMUfTeap7YYOtETY7vw7r2wQXYv0nwzrLW5+KI9Zw/A5zlOJ0l8GULzl
         7byg==
X-Forwarded-Encrypted: i=1; AJvYcCWRbrSwQNl3OufM/XAB3ZVRh3rNut6chhYCs795OF7FPuYlw8xixCgaXO82cpba2f6tjlMqBfZT+mOmUVk/UAEDx0VPO9PMHd5wE5Q2ASEE588QjKkqj1H0Ow6UNN/LWrYi
X-Gm-Message-State: AOJu0YyDdliRz2ccHbv45d9DJm2GzyBSom7P6a9O0/bNmjzZ7aOvsWlb
	kxEIVpFHAAfFNcojshsR/Lifu+/nwzkn0dFLigIYYcayOZQr77Fo
X-Google-Smtp-Source: AGHT+IHaxZlVmoQ1qLbFJ4QXBRGClB0SHD7FptaUwWwjOpMrxYar+Fq7eWzLKb/6vzAXJ6L3y1LPYg==
X-Received: by 2002:a05:6871:7411:b0:220:cf76:a9b7 with SMTP id nw17-20020a056871741100b00220cf76a9b7mr10654385oac.44.1710279318347;
        Tue, 12 Mar 2024 14:35:18 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id q6-20020a05620a0c8600b00787f42e6299sm4042468qki.113.2024.03.12.14.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 14:35:17 -0700 (PDT)
Message-ID: <41f07451-8d77-460d-aff8-fadce111a511@gmail.com>
Date: Tue, 12 Mar 2024 14:35:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes for
 v6.9]
Content-Language: en-US
To: paulmck@kernel.org, Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, mingo@kernel.org,
 tglx@linutronix.de, rcu@vger.kernel.org, joel@joelfernandes.org,
 neeraj.upadhyay@amd.com, urezki@gmail.com, qiang.zhang1211@gmail.com,
 bigeasy@linutronix.de, anna-maria@linutronix.de, chenzhongjin@huawei.com,
 yangjihong1@huawei.com, rostedt@goodmis.org
References: <ZetHwrCb0KXE0xFI@tardis>
 <4274be61-60bd-4e1e-9c16-26e6e5e06f65@gmail.com>
 <ZfDCjBFfyWpTK-I1@pavilion.home>
 <f324cf7f-f5ff-4f19-b6ee-3a47870766b8@paulmck-laptop>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <f324cf7f-f5ff-4f19-b6ee-3a47870766b8@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/12/24 14:15, Paul E. McKenney wrote:
> On Tue, Mar 12, 2024 at 10:01:00PM +0100, Frederic Weisbecker wrote:
>> Le Tue, Mar 12, 2024 at 01:32:03PM -0700, Florian Fainelli a écrit :
>>> Hi Boqun,
>>>
>>> On 3/8/24 09:15, Boqun Feng wrote:
>>>> Hi Linus,
>>>>
>>>> Please pull this for the RCU changes of v6.9:
>>>>
>>>> The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:
>>>>
>>>>     Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>     git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git tags/rcu.next.v6.9
>>>>
>>>> for you to fetch changes up to 3add00be5fe5810d7aa5ec3af8b6a245ef33144b:
>>>>
>>>>     Merge branches 'rcu-doc.2024.02.14a', 'rcu-nocb.2024.02.14a', 'rcu-exp.2024.02.14a', 'rcu-tasks.2024.02.26a' and 'rcu-misc.2024.02.14a' into rcu.2024.02.26a (2024-02-26 17:37:25 -0800)
>>>>
>>>>
>>>> Two merge conflicts were detected by linux-next:
>>>>
>>>> * https://lore.kernel.org/lkml/20240226135745.12ac854d@canb.auug.org.au/
>>>> * https://lore.kernel.org/lkml/20240227125522.2bdbe6be@canb.auug.org.au/
>>>>
>>>> These conflict resolutions from linux-next look good to me, plus I made
>>>> my own resolutions at branch merge/rcu.2024.02.27a for your reference.
>>>>
>>>>
>>>> Some highlights of the changes:
>>>>
>>>> * Eliminates deadlocks involving do_exit() and RCU tasks, by Paul:
>>>>     Instead of SRCU read side critical sections, now a percpu list is used
>>>>     in do_exit() for scaning yet-to-exit tasks.
>>>>
>>>> * Fixes a deadlock due to the dependency between workqueue and RCU
>>>>     expedited grace period, reported by Anna-Maria Behnsen and Thomas
>>>>     Gleixner and fixed by Frederic: Now RCU expedited always uses its own
>>>>     kthread worker instead of a workqueue.
>>>
>>> At least one device in my test farm (ARM 32-bit) has consistently shown a
>>> very long boot, and some others are intermittently affected. This
>>> consistently looks like this on most of my devices:
>>>
>>> [    2.450351] bcmgenet f0480000.ethernet: GENET 5.0 EPHY: 0x0000
>>> [    2.547562] ata1: SATA link down (SStatus 0 SControl 300)
>>> [  162.107264] unimac-mdio unimac-mdio.0: Broadcom UniMAC MDIO bus
>>>
>>> this gets flagged by my boot script as a boot failure since we exceeded the
>>> 30 seconds timeout given to boot a kernel to a prompt.
>>>
>>> It has been somewhat difficult to get a reliable bisection going on, but
>>> what I am sure of is that e5a3878c947ceef7b6ab68fdc093f3848059842c~1 does
>>> not expose the problem for 10 consecutive boots, while I *might* see it at
>>> e5a3878c947ceef7b6ab68fdc093f3848059842c and beyond.
>>>
>>> Any clues what is going on here?
>>
>> I understand it doesn't reliably reproduce. But is there any chance you could
>> test that alone?
>>
>>       0bb11a372fc8 (rcu-tasks: Maintain real-time response in rcu_tasks_postscan())
>>
>> And if it reproduces there try a bisection?
>>
>> git bisect bad 0bb11a372fc8d7006b4d0f42a2882939747bdbff
>> git bisect good 41bccc98fb7931d63d03f326a746ac4d429c1dd3
> 
> Good point!
> 
> Is this kernel built with CONFIG_PREEMPT_RT=y and CONFIG_TASKS_RCU=y?
> Either way, is there also a large number of tasks exiting at this point
> during boot?

Neither options are enabled, and this is still during boot, so there is 
not any user-space tasks being running yet, I cannot think of too many 
reasons why this would fail, and there is no driver on the probe 
deferral list that I can see.
-- 
Florian


