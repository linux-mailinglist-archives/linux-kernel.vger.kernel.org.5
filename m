Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFEC79963B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 06:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbjIIEbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 00:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbjIIEbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 00:31:31 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5E11FC4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 21:31:26 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34e25ad38cbso9572655ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 21:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694233886; x=1694838686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jq94CIuMJv6Et1Il9g8VDV8VFH4r8Hlwhfq/jJyTJ34=;
        b=osaSxQoaew6rFtBNvW1hEveP866DayosSnPh71qkCcpYPYba1xjDvTZ+HEYT6I4A9Z
         +Z+2tWocXo+ypZ83QiHKREWMfWtTgyPEUmi3ZEjYfq81NXOJq6XaSJ67JpMbJ8okZSyJ
         fDIZeqpUYpagnZGWQ7fwC0+WSBpYKkFRPW2dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694233886; x=1694838686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jq94CIuMJv6Et1Il9g8VDV8VFH4r8Hlwhfq/jJyTJ34=;
        b=pkRovWEqEZXITnNCTzCPZaU/L/IeHfrAkNoRoC/fJTwocNhcXiAp0H9pXbAFwMd0Oh
         SeH6YeXZRVkA/CcFLmRsV2BzFzs/8KrkXfR88cE+OuSW8QFq9Y1IFLO7NmNSAmivvc6z
         ef4BZSbx7HQ5iejuzPiKsvXxiT2wRO9E75X+76ls3Xo5rVy1WQV7ddnNfqXc2ia6RASG
         FPv0z0/di1oxpWQCOGvYNwyVxlXTK63j0cHNIdg0JdKyeuoH+j2vyXrGis8C0askGtM0
         RphzJhUhbVg2Boo+mn3L4CjJuWVyn0G3W+iyPMxAEQ6ij0K+7LR6t+//zjdD71cIJgXk
         cjpA==
X-Gm-Message-State: AOJu0Yy0K3S+bkrUyIp2p6Li8HkTEv+t5lovsS0zErSsNOwCNXHF1Zov
        fi18p7QILgp4R0pjk5QTAUfI0A==
X-Google-Smtp-Source: AGHT+IHBEThR5AoYD2dYCcq0kdnKKq3t3O8tICSv2OoKS2ptkz/FAP9j3nQ+I5R798vdDgKk4cUj2w==
X-Received: by 2002:a05:6e02:1d1e:b0:349:927a:5d85 with SMTP id i30-20020a056e021d1e00b00349927a5d85mr5818792ila.22.1694233886254;
        Fri, 08 Sep 2023 21:31:26 -0700 (PDT)
Received: from localhost (74.120.171.34.bc.googleusercontent.com. [34.171.120.74])
        by smtp.gmail.com with ESMTPSA id fn2-20020a056638640200b0042aec33bc26sm880864jab.18.2023.09.08.21.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 21:31:25 -0700 (PDT)
Date:   Sat, 9 Sep 2023 04:31:25 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 04/10] rcu/nocb: Remove needless full barrier after
 callback advancing
Message-ID: <20230909043125.GA3920383@google.com>
References: <20230908203603.5865-1-frederic@kernel.org>
 <20230908203603.5865-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908203603.5865-5-frederic@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 10:35:57PM +0200, Frederic Weisbecker wrote:
> A full barrier is issued from nocb_gp_wait() upon callbacks advancing
> to order grace period completion with callbacks execution.
> 
> However these two events are already ordered by the
> smp_mb__after_unlock_lock() barrier within the call to
> raw_spin_lock_rcu_node() that is necessary for callbacks advancing to
> happen.
> 
> The following litmus test shows the kind of guarantee that this barrier
> provides:
> 
> 	C smp_mb__after_unlock_lock
> 
> 	{}
> 
> 	// rcu_gp_cleanup()
> 	P0(spinlock_t *rnp_lock, int *gpnum)
> 	{
> 		// Grace period cleanup increase gp sequence number
> 		spin_lock(rnp_lock);
> 		WRITE_ONCE(*gpnum, 1);
> 		spin_unlock(rnp_lock);
> 	}
> 
> 	// nocb_gp_wait()
> 	P1(spinlock_t *rnp_lock, spinlock_t *nocb_lock, int *gpnum, int *cb_ready)
> 	{
> 		int r1;
> 
> 		// Call rcu_advance_cbs() from nocb_gp_wait()
> 		spin_lock(nocb_lock);
> 		spin_lock(rnp_lock);
> 		smp_mb__after_unlock_lock();
> 		r1 = READ_ONCE(*gpnum);
> 		WRITE_ONCE(*cb_ready, 1);
> 		spin_unlock(rnp_lock);
> 		spin_unlock(nocb_lock);
> 	}
> 
> 	// nocb_cb_wait()
> 	P2(spinlock_t *nocb_lock, int *cb_ready, int *cb_executed)
> 	{
> 		int r2;
> 
> 		// rcu_do_batch() -> rcu_segcblist_extract_done_cbs()
> 		spin_lock(nocb_lock);
> 		r2 = READ_ONCE(*cb_ready);
> 		spin_unlock(nocb_lock);
> 
> 		// Actual callback execution
> 		WRITE_ONCE(*cb_executed, 1);

So related to this something in the docs caught my attention under "Callback
Invocation" [1]

<quote>
However, if the callback function communicates to other CPUs, for example,
doing a wakeup, then it is that function's responsibility to maintain
ordering. For example, if the callback function wakes up a task that runs on
some other CPU, proper ordering must in place in both the callback function
and the task being awakened. To see why this is important, consider the top
half of the grace-period cleanup diagram. The callback might be running on a
CPU corresponding to the leftmost leaf rcu_node structure, and awaken a task
that is to run on a CPU corresponding to the rightmost leaf rcu_node
structure, and the grace-period kernel thread might not yet have reached the
rightmost leaf. In this case, the grace period's memory ordering might not
yet have reached that CPU, so again the callback function and the awakened
task must supply proper ordering.
</quote>

I believe this text is for non-nocb but if we apply that to the nocb case,
lets see what happens.

In the litmus, he rcu_advance_cbs() happened on P1, however the callback is
executing on P2. That sounds very similar to the non-nocb world described in
the text where a callback tries to wake something up on a different CPU and
needs to take care of all the ordering.

So unless I'm missing something (quite possible), P2 must see the update to
gpnum as well. However, per your limus test, the only thing P2  does is
acquire the nocb_lock. I don't see how it is guaranteed to see gpnum == 1.
I am curious what happens in your litmus if you read gpnum in a register and
checked for it.

So maybe the memory barriers you are deleting need to be kept in place? Idk.

thanks,

 - Joel

[1] https://docs.kernel.org/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html#callback-invocation

