Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168327B587F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbjJBQNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238451AbjJBQNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:13:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A29D1B2
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:13:44 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696263222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G0T9PfbNrXniK4beiYc72WRU4MBB7zDa0iGJLKfN7z4=;
        b=ZVI9+b/ealErgG3IPoHGhdg/NotJntiVmAyqJoOXEwIT9QlX2f11mnlB6opiJi9h8X6Yqw
        9A2GPN0JzuPyrB/8rI/AmLr84W/+aEzDWX+G16pWN9D52snTtppv7arH68AZF2H8S0Nwul
        QZKS7psBoGrnJxXdhG1BD2IdmY07M9q1nxrWNUiHDk9IxNy/lRyIV0l2oIL2XtAP9NKB9/
        n9gqPyXHDzyoGRGSl5Kq2oo1BMrrxWZWBSzUa/31Kf/6CG4HQ6xssIcsbtYRt55JtHWVVT
        ErJRc1M0CQD81JNKHWKhoBuhdYuaUrPLI6cgsuJizikioMZ41dM7pW1nqDIvIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696263222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G0T9PfbNrXniK4beiYc72WRU4MBB7zDa0iGJLKfN7z4=;
        b=lbtyF4Govw8zdoYv4rO5n/Q5OTVPYbrIuIDdf+yCKvUyn8j255Gr09m8Vh1IRWPq6fVXNU
        uVgutD1q5M4WIXAA==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-Reply-To: <20231002101514.44b9c812@gandalf.local.home>
References: <87ttrngmq0.ffs@tglx> <87jzshhexi.ffs@tglx>
 <20231002101514.44b9c812@gandalf.local.home>
Date:   Mon, 02 Oct 2023 18:13:41 +0200
Message-ID: <87jzs5c896.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02 2023 at 10:15, Steven Rostedt wrote:
> On Sat, 23 Sep 2023 03:11:05 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> Though definitely I'm putting a permanent NAK in place for any attempts
>> to duct tape the preempt=NONE model any further by sprinkling more
>> cond*() and whatever warts around.
>
> Well, until we have this fix in, we will still need to sprinkle those
> around when they are triggering watchdog timeouts. I just had to add one
> recently due to a timeout report :-(

cond_resched() sure. But not new flavours of it, like the
[dis]allow_resched() which sparked this discussion.

>> -	TRACE_FLAG_NEED_RESCHED		= 0x04,
>> +	TRACE_FLAG_NEED_RESCHED		= 0x02,
>> +	TRACE_FLAG_NEED_RESCHED_LAZY	= 0x04,
>
> Is LAZY only used for PREEMPT_NONE? Or do we use it for CONFIG_PREEMPT?
> Because, NEED_RESCHED is known, and moving that to bit 2 will break user
> space. Having LAZY replace the IRQS_NOSUPPORT will cause the least
> "breakage".

Either way works for me.

Thanks,

        tglx

