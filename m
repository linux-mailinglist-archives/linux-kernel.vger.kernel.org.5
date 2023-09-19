Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C997A6B98
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjISTfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjISTf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:35:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CCAF0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ya0NjT0hID8cNaHUIIbnzb7CSLwCFD+xdaWNcnIycUY=; b=FdcuBr5TM8FRW/ltzRkEy1H7H9
        mPibmiHL/PsA6Q1i+6uQGZwmh0Z2ugC3FKG5OC+Huv+oWT/wMgS1RjOoEr6AyCT0VUv0q+61OlpN0
        AKSjWnX8OQYFpSXALWWjSVRKrF3olJOa4ChlEbI5oBI/TqS2hdLL2OL7GI2QQ26GMIx9IVc/x5mNL
        7FA8Qrp0ujYigEEwmvmHINTOQ80/3YwNamEFI/dsOQyF2+ohgozO5QkKaVInAzzeS67c7vk7leL2w
        9IqDMlrS55zxFWZ+hiZgpllynPhmVPftQyJ7oJECwHkTENOuYHQUdz92CZDmgvRM4LzEPM9U5m0UH
        phBGdapQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qigV9-00Dqne-15;
        Tue, 19 Sep 2023 19:35:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 58E3A300348; Tue, 19 Sep 2023 21:35:16 +0200 (CEST)
Date:   Tue, 19 Sep 2023 21:35:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        akpm@linux-foundation.org
Subject: Re: Buggy __free(kfree) usage pattern already in tree
Message-ID: <20230919193516.GA20937@noisy.programming.kicks-ass.net>
References: <CACMJSevrJ5KSPAZVheXkNaYj8KQFD8ck55kU_E4vEj4vzR8wnQ@mail.gmail.com>
 <CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com>
 <20230915210851.GA23174@noisy.programming.kicks-ass.net>
 <CAHk-=whvOGL3aNhtps0YksGtzvaob_bvZpbaTcVEqGwNMxB6xg@mail.gmail.com>
 <20230915213231.GB23174@noisy.programming.kicks-ass.net>
 <CAHk-=wi08ZUguV_n88h=bP6X01-tah29RtB0t9TmXtyuEJev-Q@mail.gmail.com>
 <20230915221332.GC23174@noisy.programming.kicks-ass.net>
 <20230919125752.GA39346@noisy.programming.kicks-ass.net>
 <20230919125954.GB39346@noisy.programming.kicks-ass.net>
 <20230919131038.GC39346@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919131038.GC39346@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 03:10:38PM +0200, Peter Zijlstra wrote:

> This isn't exactly nice..
> 
> I tried something like:
> 
> 	scoped_cond_guard (mutex_intr, return -EINTR, &task->signal->cred_guard_mutex) {
> 		...
> 	}
> 
> Which I can make work, but then I also tried to capture my other case:
> 
> 	scoped_cond_guard (rwsem_down_intr, if (task) return -EINTR,
> 			   task ? &task->signal->exec_guard_mutex : NULL)  {
> 
> 		...
> 	}
> 
> But I can't get that to work because of that extra if, the not case
> doesn't fall through and do the body.
> 
> Anyway, I'll poke more..


#define scoped_cond_guard(_name, _label, args...)		\
	for (CLASS(_name, scope)(args),				\
	     *done = NULL; !done; done = (void *)1)		\
		if (!__guard_ptr(_name)(&scope)) goto _label;	\
		else

Allows one to write:

	scoped_cond_guard (rwsem_down_intr, no_lock,
 			   task ? &task->signal->exec_guard_mutex : NULL)  {

		if (0) {
no_lock:
			if (task)
				return -EINTR;
		}

		... block that holds exec_guard_mutex if task ...
	}

Still not exactly pretty, but perhaps better than before...

