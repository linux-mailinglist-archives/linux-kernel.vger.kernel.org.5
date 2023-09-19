Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC397A5DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjISJUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjISJUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:20:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4855E6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:20:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695115213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ldQ2resTgl+XWR76QleI1vA9LDmXPHknVyAoVM5J16Q=;
        b=zKvqF6AJDRJav1WOeMVSSgnVPUQjmdBUxkipSVNmHcWOpF+dHPtWodrQzmtwqxK12WkNLQ
        WifsbrLtAUy+Ir2JjC7lKm8qdHBG6vfI3zJe9kxCZD/GD2npA33vtMDXeLTrC3jbAxanV+
        +8fMLDeCvmOscUinKhxrUsh9yoxdmFkjqHWbiYZQ8QeduusDbuzX9POCBp2s3t9troyNok
        vy0I5mNN8vCa8KGylSliW0lHje1YvKOt0AG/vvhiKEMFI68BpQH9xJBdpADL6l+8IrSfEY
        WUQVl1j6/m5mGfH9fFbr+3kP0Apn0zYID/3h8CTH7GNKEV8Lp/4AmwXmTbp/tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695115213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ldQ2resTgl+XWR76QleI1vA9LDmXPHknVyAoVM5J16Q=;
        b=j49uXK3Zvyqd5+dEiO8fHw6KLqBnZKG3CtR7n3vp8DmACKf9VYs6vdi5NiiwoWAip6Y4UG
        G1yTRNCwfzjhy2CA==
To:     Andy Lutomirski <luto@kernel.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, the arch/x86 maintainers <x86@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>, mgorman@suse.de,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jon Grimm <jon.grimm@amd.com>, Bharata B Rao <bharata@amd.com>,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-Reply-To: <39998df7-8882-43ae-8c7e-936c24eb4041@app.fastmail.com>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <39998df7-8882-43ae-8c7e-936c24eb4041@app.fastmail.com>
Date:   Tue, 19 Sep 2023 11:20:13 +0200
Message-ID: <87pm2ewmcy.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18 2023 at 20:21, Andy Lutomirski wrote:
> On Wed, Aug 30, 2023, at 11:49 AM, Ankur Arora wrote:

> Why do we support anything other than full preempt?  I can think of
> two reasons, neither of which I think is very good:
>
> 1. Once upon a time, tracking preempt state was expensive.  But we fixed that.
>
> 2. Folklore suggests that there's a latency vs throughput tradeoff,
>    and serious workloads, for some definition of serious, want
>    throughput, so they should run without full preemption.

It's absolutely not folklore. Run to completion is has well known
benefits as it avoids contention and avoids the overhead of scheduling
for a large amount of scenarios.

We've seen that painfully in PREEMPT_RT before we came up with the
concept of lazy preemption for throughput oriented tasks.

Thanks,

        tglx
