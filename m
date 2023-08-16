Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E94977E156
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245065AbjHPMU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245074AbjHPMUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:20:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243F2109
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:20:12 -0700 (PDT)
Date:   Wed, 16 Aug 2023 14:20:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692188410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MaUwkyTxNitYNx61TmEE8oVCLZ3GY9p7YUKFRU3g2qc=;
        b=KuCcd25Yq+ISwHIIW17Pd/ZAsu3HnhhQgsaF2PN9qQxzh2YuHvz2dyKPWYrK4lkQoH31Or
        z5xTnAJWWtt4UQfmYjKOoxTNBFPqXQNSELKrv5u3it5A5Ol7rHrsFEAkUAoCT6Ck6fWhH1
        t8/keBHpD6epC9nkIBfmMW9FXMd+B/02Unv2y0Qp9DADDO4Vtl5trzYdWlbG6Qmu+sL5T5
        k5jPk+ZlX0//15U2VCWdN7RdbK7XL6ClyV0FpJTcejARGKgsNoH6LmjzNo5Y26EBq8WlyP
        uERB0nG4+iHAPr/5f4WQdvWEh2vKlQ3tVIMpgxAwD6GVI7XtCRC6RomkH7CVDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692188410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MaUwkyTxNitYNx61TmEE8oVCLZ3GY9p7YUKFRU3g2qc=;
        b=d22kaDJLiixr810KQ+8/JI3xOV621kQkZWV/260VxR1VYjfmGkS2wNszadau8pIvXPWK2N
        ALtuRv7Y7+VIqrBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Phil Auld <pauld@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, bsegall@google.com,
        boqun.feng@gmail.com, swood@redhat.com, bristot@redhat.com,
        dietmar.eggemann@arm.com, mingo@redhat.com, jstultz@google.com,
        juri.lelli@redhat.com, mgorman@suse.de, rostedt@goodmis.org,
        vschneid@redhat.com, vincent.guittot@linaro.org,
        longman@redhat.com, will@kernel.org
Subject: Re: [PATCH 3/6] sched: Extract __schedule_loop()
Message-ID: <20230816122007.W7OJW3Fx@linutronix.de>
References: <20230815110121.117752409@infradead.org>
 <20230815111430.288063671@infradead.org>
 <20230815223301.GC602899@lorien.usersys.redhat.com>
 <20230816100154.k6cmHUUp@linutronix.de>
 <20230816113945.GA639355@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230816113945.GA639355@lorien.usersys.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-16 07:39:45 [-0400], Phil Auld wrote:
> I do.  Admittedly I'm not an expert in how the wchan unwinding works but
> we have a slightly older version of this patch in our kernel (schedule_loop
> not __schedule_loop). When I added __sched it fixed it.   Maybe there
> is something else but that seemed pretty obvious. 
> 
> 
> /* Attach to any functions which should be ignored in wchan output. */
> #define __sched		__section(".sched.text")
> 
> I can't explain why you are not seeing it.

as peterz pointed out, it is marked __always_inline so the compiler
shouldn't make a separate function out of it.
Could you check with _this_ series? The schedule_loop variant is in RT
and does not have this inline thingy. So it would be good if the issue
you report actually exists in the series that has been posted.

> Cheers,
> Phil

Sebastian
