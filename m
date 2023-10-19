Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A277CFBF5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345951AbjJSOEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345955AbjJSOEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:04:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BB0137
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:04:21 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697724259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9sylslccbMMxhr+4WYuX+xxyCsTGJttNaGXQjdnGWVY=;
        b=P6+2Jyjsr//dOzGgr2yBO38ZwA15OnTYib4hMVIwxZsYCYcn/h+IDEVMdug2q5wVxaay65
        lBxByEjPUhM1LYK99zeEwyc42hV4PE8KfsoSsaLDHsathk+ZsUQh1bnYrR4LNirQECVAHz
        VrPOICHBVHKBFeaT1yEEE6FPrvMctyXCFgKWlT+jQxijCCPmk8TNvuNFk2VxWPmrq3y+q2
        F9ZLjpjdznXvQs4MRZxveb7zKszWvo23gfwABBKdLsfrCPnLdCl/MT3zMU6/g82G4uDA7B
        zIECKRbz8lpE8Ug4xGn5nXemfaRtJdCijhc7e/ZBC4xvPOXc+CF9L+WE7+UPVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697724259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9sylslccbMMxhr+4WYuX+xxyCsTGJttNaGXQjdnGWVY=;
        b=3LIFUFCyhF9DaVgGKqW6r/u2COn6L1287L4NgfTF9upA6nooy3yJiHcgofRHOmVyGKC8eh
        zilWm0/ayBH4UqDg==
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v8 00/25] timer: Move from a push remote at enqueue to a
 pull at expiry model
In-Reply-To: <1891aa6c-037f-46a1-9584-17aaa63e4e74@arm.com>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
 <1891aa6c-037f-46a1-9584-17aaa63e4e74@arm.com>
Date:   Thu, 19 Oct 2023 16:04:19 +0200
Message-ID: <87fs26909o.fsf@somnus>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

Lukasz Luba <lukasz.luba@arm.com> writes:

[...]

>
> I have tested this on my 2 Arm boards with mainline kernel
> and almost-mainline. On both platforms it looks stable.
> The results w/ your patchset looks better.
>

Thanks for testing!

[...]

> The performance looks good. Only one test 'Speedometer'
> has some interesting lower score.

Is it required to look into this more detailed or is the regression in a
acceptable range for you?

>
> Fill free to add:
>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>

Thanks,

	Anna-Maria

