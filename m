Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FE27BE253
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376972AbjJIORM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjJIORK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:17:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891C78E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 07:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=X9XLTLzSrjwqlzyAfMOTchqR33f305YkvTKHug96aps=; b=Po2zGgj6vvdInxyeMmC/T+GRJu
        Jr6beW/uy4QZltBzprXMtEU6Qggv9kuxP0LrmOM7NoqqAHyVMPQontG3wJU7ntYgfKDH7TTyd3iUm
        xMrqfuXktd5aa4qS9BbiFfIHylIRokPz4mSphzQYdWPQF6rsN+SH/qR+FOQgB8ESLKT1k6h5t71gq
        nQO/DL14OliW2dgJwnwO1RAjYFcA0N95j5LunN0ZKgSc1YXCG3HJPV4R1twalqTshV17QS+8Pqcm2
        KQowCZhTrE8cwp3rFoTqsue7N8hHRgL0NkRLYk+kghNaA/MUDXtAOSxoTAlVZviSLSw1YUQR7X3UK
        hB4LzeBg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qpr4C-00GI43-QX; Mon, 09 Oct 2023 14:17:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65723300454; Mon,  9 Oct 2023 16:17:04 +0200 (CEST)
Date:   Mon, 9 Oct 2023 16:17:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     bsingharora@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] delayacct: convert task->delays to a object
Message-ID: <20231009141704.GE14330@noisy.programming.kicks-ass.net>
References: <cover.1696761522.git.chunguang.xu@shopee.com>
 <531ddc82793a39f4c09316d701a4b1170bcad4ab.1696761522.git.chunguang.xu@shopee.com>
 <20231008105801.GC6320@noisy.programming.kicks-ass.net>
 <5dba07eb-88f0-bf84-494e-b979f32ad44d@gmail.com>
 <20231009084341.GA14330@noisy.programming.kicks-ass.net>
 <a93f13de-a018-2ee4-c7a0-855c3bd04444@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a93f13de-a018-2ee4-c7a0-855c3bd04444@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 06:29:15PM +0800, brookxu wrote:
> 
> 在 2023/10/9 16:43, Peter Zijlstra 写道:
> > On Sun, Oct 08, 2023 at 07:10:01PM +0800, brookxu wrote:
> > 
> > > > > @@ -1331,7 +1332,7 @@ struct task_struct {
> > > > >    	struct page_frag		task_frag;
> > > > >    #ifdef CONFIG_TASK_DELAY_ACCT
> > > > > -	struct task_delay_info		*delays;
> > > > > +	struct task_delay_info		delays;
> > > > >    #endif
> > > > Yeah, no.
> > > Yes, this way will increase about 80 bytes for task_struct, about 0.85% of
> > > size of task_struct, I think this just like sched_statistics, so that can
> > > better support dynamically enable through sysctl.
> > But it's 80 bytes 'nobody' will use. And arguably we should do the same
> > with schedstats, that's default disabled and again, that's per-task
> > storage nobody ever uses.
> > 
> > Per this argument we can grow task_struct indefinitely until it
> > collapses in on itself by the sheer weight of it's information density.
> > Every additional field will be a smaller fraction of the total.
> > 
> > Yes, it makes it all a little more cumbersome, but we should really not
> > burden everybody with the load of some.
> > 
> > Surely there is another solution... ?
> Thanks, agree with you, I try do it in other ways :)

One option is to first flip the static key and then iterate all existing
tasks, allocating the memory structure. New tasks will get it allocated
per the static key, existing tasks will get it allocated per the
iteration and dying tasks we don't care about.

That would be sufficient, no?
