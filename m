Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33E4787029
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241083AbjHXNWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241199AbjHXNWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:22:00 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E6219A5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 06:21:57 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-79239927839so121602139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692883316; x=1693488116;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uBq+bzB7lscqikmSJhAFXBiktCV1gBbXEMWl3afWAOE=;
        b=o5dnZDcGUXqzt+x38Q9THJr6mkJ/ZPbZp2c1dSzm1oq2f84mhbL4T/QUsk6TOkXEwB
         rn4IK71ZT0VgTpC45tbN0UtU//K1rSY4cx6VE0cqNwYCerZcprGlwLyUPlhefayczlH7
         QFwQmc6flCefuHkV3qDJaImAtKhBileWEkADw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692883316; x=1693488116;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBq+bzB7lscqikmSJhAFXBiktCV1gBbXEMWl3afWAOE=;
        b=YlC6aBxUjTr8hNwtnwai5buyw/S13oH9MKqjZkfaaQseOyC9uQQq84Vm78r5gNp7PC
         Hj+kHBAIQhmh5tZac8UM2aZWlJ9LaTofivisIclnRmZ1Z3qxOOWmiEzS/pAwRcTlgQ/K
         kZoJF1mCJjMCF2xF1Sam7RiHIXTKn++Tu9aONPczbsPBBX2hcDrcPQ9rkF/b60z/Cczl
         JyLhbdc/2muvd8H97039eLngHeCbD6vXjsFO4yqkv8OJp5SzMG+85R95U2xwaqWtziHG
         nc1I8e7G17+o9vfCw4RR49P9fwxI5cmQQSU/sJHdqqV5VDtjCwyEeblYWwZOY4fxa2Zj
         syrA==
X-Gm-Message-State: AOJu0YwnUzDhqdGZs6gpMr/Zwm4JBZqykpXz2GHZT/jPeXupOZgR2EGV
        pZ26BAmEO43WvQl/9E0uP5wUNw==
X-Google-Smtp-Source: AGHT+IFjWHnHBpCiFQH1AzAPX4bose/q+fwlgVd4v2eWmDLjFu9ry/Xs4MGnldrAr5VfE4TnbHY8pw==
X-Received: by 2002:a5e:990c:0:b0:786:cd9c:cfa2 with SMTP id t12-20020a5e990c000000b00786cd9ccfa2mr6035587ioj.0.1692883316587;
        Thu, 24 Aug 2023 06:21:56 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id b20-20020a02c994000000b0042b08954dc3sm4371841jap.33.2023.08.24.06.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 06:21:56 -0700 (PDT)
Date:   Thu, 24 Aug 2023 13:21:55 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Z qiang <qiang.zhang1211@gmail.com>, paulmck@kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
Message-ID: <20230824132155.GB3810470@google.com>
References: <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com>
 <5777BD82-2C8D-4BAB-BDD3-C2C003DC57FB@joelfernandes.org>
 <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
 <87ttspct76.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttspct76.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On Thu, Aug 24, 2023 at 12:03:25AM +0200, Thomas Gleixner wrote:
> On Thu, Aug 17 2023 at 16:06, Huacai Chen wrote:
> > On Thu, Aug 17, 2023 at 3:27 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> >> > If  do_update_jiffies_64() cannot be used in NMI context,
> >>
> >> Can you not make the jiffies update conditional on whether it is
> >> called within NMI context?
> 
> Which solves what? If KGDB has a breakpoint in the jiffies lock held
> region then you still dead lock.

Yes, we had already discussed this that jiffies update is not possible from
here. There are too many threads since different patch revisions were being
reviewed in different threads.

> >> I dislike that..
> > Is this acceptable?
> >
> > void rcu_cpu_stall_reset(void)
> > {
> >         unsigned long delta;
> >
> >         delta = nsecs_to_jiffies(ktime_get_ns() - ktime_get_coarse_ns());
> >
> >         WRITE_ONCE(rcu_state.jiffies_stall,
> >                    jiffies + delta + rcu_jiffies_till_stall_check());
> > }
> >
> > This can update jiffies_stall without updating jiffies (but has the
> > same effect).
> 
> Now you traded the potential dead lock on jiffies lock for a potential
> live lock vs. tk_core.seq. Not really an improvement, right?
> 
> The only way you can do the above is something like the incomplete and
> uncompiled below. NMI safe and therefore livelock proof time interfaces
> exist for a reason.

Yes, I had already mentioned exactly this issue here of not using an NMI-safe
interface:
https://lore.kernel.org/all/CAEXW_YT+uw5JodtrqjY0B2xx0J8ukF=FAB9-p5rxgWobSU2P2A@mail.gmail.com/
I like your suggestion of using last_jiffies_update though (which as you
mentioned needs to be explored more).

There are too many threads which makes the discussion hard to follow. Huacai,
it would be great if we can keep the discussions in the same thread (Say for
example by passing options like --in-reply-to to "git send-email" command).

thanks,

 - Joel


> 
> Thanks,
> 
>         tglx
> ---
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -51,6 +51,13 @@ struct tick_sched *tick_get_tick_sched(i
>   */
>  static ktime_t last_jiffies_update;
>  
> +unsigned long tick_estimate_stale_jiffies(void)
> +{
> +	ktime_t delta = ktime_get_mono_fast_ns() - READ_ONCE(last_jiffies_update);
> +
> +	return delta < 0 ? 0 : div_s64(delta, TICK_NSEC);
> +}
> +
>  /*
>   * Must be called with interrupts disabled !
>   */
> 
> 
