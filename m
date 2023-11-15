Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19137E7035
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344617AbjKIR1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344772AbjKIR0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:26:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4516D3A84
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:26:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779C1C433C9;
        Thu,  9 Nov 2023 17:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699550800;
        bh=lti2Wrh+iNhUfzIPZRfVEsdGQcCQjicJrc6BhY3EdBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Du93MwM6A4yzmEjYWUhTBfW6L1iVoOF+OQp09nBdR2VTndmQSvCBzDyospLfbtp4y
         vSPp9wFK62CkMelOCD3JSgNe7WUkZ3PfHVdpQC202YcH8eBeUkcY/M/xrkspVUVWPr
         crK5r9LDiNrQu9ad/bc4MrftMSia3MjEheWFPLqE8lN/FcX8pUEWxRIFpJMPZrMKWy
         omLLup/+VZTMVK8Xpgpoxw7rIw+iOFYE9Vy3v216jXbOiceppqb5WIAzo9pUF00gMa
         8cxzMWdY7ZPhZH6ufq6HV0CIoyVACGkenBG72gBiLPsZxe8u/kMSU/BXp96WfzJl0V
         R+iq8dC9P7B0w==
Date:   Thu, 9 Nov 2023 09:26:37 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@ACULAB.COM,
        richard@nod.at, mjguzik@gmail.com, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org
Subject: Re: [RFC PATCH 07/86] Revert "livepatch,sched: Add livepatch task
 switching to cond_resched()"
Message-ID: <20231109172637.ayue3jexgdxd53tu@treble>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-8-ankur.a.arora@oracle.com>
 <20231107181609.7e9e9dcc@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231107181609.7e9e9dcc@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 06:16:09PM -0500, Steven Rostedt wrote:
> On Tue,  7 Nov 2023 13:56:53 -0800
> Ankur Arora <ankur.a.arora@oracle.com> wrote:
> 
> > This reverts commit e3ff7c609f39671d1aaff4fb4a8594e14f3e03f8.
> > 
> > Note that removing this commit reintroduces "live patches failing to
> > complete within a reasonable amount of time due to CPU-bound kthreads."
> > 
> > Unfortunately this fix depends quite critically on PREEMPT_DYNAMIC and
> > existence of cond_resched() so this will need an alternate fix.

We definitely don't want to introduce a regression, something will need
to be figured out before removing cond_resched().

We could hook into preempt_schedule_irq(), but that wouldn't work for
non-ORC.

Another option would be to hook into schedule().  Then livepatch could
set TIF_NEED_RESCHED on remaining unpatched tasks.  But again if they go
through the preemption path then we have the same problem for non-ORC.

Worst case we'll need to sprinkle cond_livepatch() everywhere :-/

-- 
Josh
