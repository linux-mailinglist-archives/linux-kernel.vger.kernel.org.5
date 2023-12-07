Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D31808A6E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443391AbjLGOY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443217AbjLGOYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:24:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C217730CD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:22:51 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701958968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5+meghr10Q4OSRh4RQyuEX2dDpm4A+Y90YMyl1NdRhU=;
        b=LIwByYLR+IKdR2U8iDshLjY1VnSSTv98bN5M/b7KlkEqe9nKvHrUML3xvobbzDKXXIemKk
        PV6LvSrTLwPPEVPPb8NjDqImj0cP9vH/C38qXipPwq2IKom66S06Mw4k0IWpfePGJoYB7h
        05BgtphOFZea2/8Pxlk1drUTiGzczuxU53sUsKIjERPcSrdc7KxkVZoQ5oZ1/O6XjfWTK6
        20ZCrKVGxFEM/jVYugxqijVPhv6qU/U4zE4ZubiOhFRdxTODyadHUmSDUmTa4FTW+NzB2Z
        J7jFjDOrby8PFumn9R9T3baFP1k5vsemmRRSr4MgNfXJ+fviJT3Rbi8gNMGHPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701958968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5+meghr10Q4OSRh4RQyuEX2dDpm4A+Y90YMyl1NdRhU=;
        b=X3kwmPofSRkNcOuT2sHFcEzLxyYQttefkBTMoLoFW2xmRh0MbL3p6eOOyHS0leUqUtDx1M
        urgD2/ovNFmHegBg==
To:     Ankur Arora <ankur.a.arora@oracle.com>, paulmck@kernel.org
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, linux-mm@kvack.org, x86@kernel.org,
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
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 48/86] rcu: handle quiescent states for PREEMPT_RCU=n
In-Reply-To: <87zfymn6h9.fsf@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-49-ankur.a.arora@oracle.com>
 <2027da00-273d-41cf-b9e7-460776181083@paulmck-laptop>
 <87v89lzu5a.ffs@tglx>
 <209f0e89-7ebd-4759-9883-21d842d0d26c@paulmck-laptop>
 <87zfymn6h9.fsf@oracle.com>
Date:   Thu, 07 Dec 2023 15:22:48 +0100
Message-ID: <87jzpqt7lz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06 2023 at 17:31, Ankur Arora wrote:
> If we end up needing this, is it valid to just optimistically check if
> a quiescent state needs to be registered (see below)?
> Though this version exposes rcu_data.rcu_urgent_qs outside RCU but maybe
> we can encapsulate that in linux/rcupdate.h.

>  #ifdef CONFIG_PREEMPTION
>  #define preempt_enable() \
>  do { \
>  	barrier(); \
>  	if (unlikely(preempt_count_dec_and_test())) \
>  		__preempt_schedule(); \
> +	else if (unlikely(raw_cpu_read(rcu_data.rcu_urgent_qs))) \
> +		rcu_all_qs_check();

It's still bloat and we can debate this once we come to the conclusion
that the simple forced reschedule is not sufficient. Until then debating
this is just an academic exercise.

Thanks,

        tglx


