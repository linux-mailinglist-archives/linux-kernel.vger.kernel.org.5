Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701397F3CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343640AbjKVDxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235057AbjKVDxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:53:17 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114B01BB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:53:11 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b709048d8eso5657183b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 19:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700625190; x=1701229990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wrkLx22tIx216Wpz1EvdCXBMKjcp6yxP+hh4ys4sAc=;
        b=LCCLO0cTtd+5Q/BADcTL/qmfv6Ny8G0SSV+nEbiFXKn60fGAKmWyCLg3YibYfpV+pq
         UEEzBze/xQ4DidlxPozC9euE51NDir19Fe8tYn7hgWT+id7KeB4e6Mkki8UNexwuqoqB
         6b/k90S7uKf20HBy269rfc5JRbbHIWD8ptsr24/jOLjFjDxbNJhfNonEFfC/cFwuMUHq
         G9wAA9e15l4AsPBVMsouhtT80F73R2VhPTE93/zb2OYe2uV/fJ5u7QjffL2fRAek/T65
         zdhxoLd4SxDYzlJ6dnaHP67tDd6pz3XyRdKS4PtJDZ9Us+eN6T4+FyeuqQUl+j1F0C18
         ubog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700625190; x=1701229990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wrkLx22tIx216Wpz1EvdCXBMKjcp6yxP+hh4ys4sAc=;
        b=mWa2h0z82h3RhtITIRD0SSoLtHlnVjL/T/Pll2SpbxAX9BkUn1tT2qW3DGfdbjtwvF
         RsfJRczwC9ZycTH8wzCFvlwVMpxoIFk2fahUMR7xrNdCt0krnxnm2CwVjjW739r4OlPg
         l04rnI3GXFbgKgABOhcnWC55JNN3kq8qzLsFeYAmV4m4a7hqQCjNO/W3oIFESxhBwyLQ
         lgPDf6YvgPeeV0/67474ZuJZzvR/gLiOi6oUyw3F1r+/SbmaZeJsl+wMJPFjSG491BhZ
         0d8lzkvCsUrseOSgI34yZOnIb84B6WzNeP/EqFP64PNxLx7MjSa0x99e4NQwLBAtHlwq
         KA3w==
X-Gm-Message-State: AOJu0YzbJWr9f9DrhRZSVyOv8GsVoWu9e4mIaFdYo46JkR68hZSOr7/X
        jYOvfDsz5Gxp1PVB6SY/FNcZuQ==
X-Google-Smtp-Source: AGHT+IFva+yTpA5FzpkpdLIpJ5EEWPMDsNiWm4Lq7NA7XjuAmdyqgQOWLDCDDTRO0tthS4Jfog7O8w==
X-Received: by 2002:a05:6a20:7d89:b0:189:2e8f:d357 with SMTP id v9-20020a056a207d8900b001892e8fd357mr1344983pzj.49.1700625190553;
        Tue, 21 Nov 2023 19:53:10 -0800 (PST)
Received: from localhost.localdomain ([203.208.189.6])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d48300b001c61bde04a7sm8569676plg.276.2023.11.21.19.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 19:53:10 -0800 (PST)
From:   lizhe.67@bytedance.com
To:     dianders@chromium.org
Cc:     akpm@linux-foundation.org, kernelfans@gmail.com,
        lecopzer.chen@mediatek.com, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, lizhe.67@bytedance.com, pmladek@suse.com
Subject: Re: [RFC] softlockup: serialized softlockup's log
Date:   Wed, 22 Nov 2023 11:53:04 +0800
Message-Id: <20231122035304.57483-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <CAD=FV=XhqDxmk=yTdujwtFyF23NZ13LORH0GMS5_iTAEVva_rA@mail.gmail.com>
References: <CAD=FV=XhqDxmk=yTdujwtFyF23NZ13LORH0GMS5_iTAEVva_rA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 13:45:21 <dianders@chromium.org> wrote:
>>
>> From: Li Zhe <lizhe.67@bytedance.com>
>>
>> If multiple CPUs trigger softlockup at the same time, the softlockup's
>> logs will appear staggeredly in dmesg, which will affect the viewing of
>> the logs for developer. Since the code path for outputting softlockup logs
>> is not a kernel hotspot and the performance requirements for the code
>> are not strict, locks are used to serialize the softlockup log output
>> to improve the readability of the logs.
>>
>> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
>> ---
>>  kernel/watchdog.c | 3 +++
>>  1 file changed, 3 insertions(+)
>
>This seems reasonable to me. It might be interesting to talk about in
>your commit message how this interacts with the various options. From
>code inspection, I believe:

Thanks for your advice. I will send a V2 patch to optimize my commit
message.

>* If `softlockup_all_cpu_backtrace` then this is a no-op since other
>CPUs will be prevented from running the printing code while one is
>already printing.

Yes your are right. If `softlockup_all_cpu_backtrace` is set, interleaving
problem is gone. And we don't need to worry about interleaving problem
in function trigger_allbutcpu_cpu_backtrace() because it has already
serialized the logs.

>* I'm not 100% sure what happens if `softlockup_panic` is set and I
>haven't sat down to test this myself. Will one CPUs panic message
>interleave the other CPUs traces. I guess in the end both CPUs will
>call panic()? Maybe you could experiment and describe the behavior in
>your commit message?

I did experiments and checked the implementation of the panic function.
I have not reproduced interleaving problem with this patch. The panic
function internally serializes the panic's logs by using variable
'panic_cpu'. Besides, function panic() will stop other cpu before outputing
logs, so I think the interleaving problem between softlockup logs from
cpu A and the panic logs from softlockup cpu B does not exist.

>> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
>> index 5cd6d4e26915..8324ac194d0a 100644
>> --- a/kernel/watchdog.c
>> +++ b/kernel/watchdog.c
>> @@ -448,6 +448,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>>         struct pt_regs *regs = get_irq_regs();
>>         int duration;
>>         int softlockup_all_cpu_backtrace = sysctl_softlockup_all_cpu_backtrace;
>> +       static DEFINE_SPINLOCK(watchdog_timer_lock);
>
>I'd be tempted to define this outside the scope of this function. I
>need to dig more, but I'm pretty sure I've seen cases where a soft
>lockup could trigger while I was trying to print traces for a
>hardlockup, so it might be useful to grab the same spinlock in both
>places...

I've tried several times, but unfortunately I haven't been able to
reproduce the problem you mentioned. My concern is that if the lock
is shared, there will be potential deadlock issues because hardlockup
exploits nmi.
