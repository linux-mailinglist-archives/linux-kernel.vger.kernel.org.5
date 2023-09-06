Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D17C793742
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbjIFIjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjIFIjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:39:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC10E47;
        Wed,  6 Sep 2023 01:39:50 -0700 (PDT)
Date:   Wed, 6 Sep 2023 10:39:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693989588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eFmqC5u50JG2Uz7+UhHXczfuq95iqOFCqYRyS0Rau4g=;
        b=S0LHXA3JMiaUEwB8uG04Q81ozEhO8ik8P2a34nNdw8CXx01ELAeh1+ltrOIYFyZo1t+8DS
        dVWZk9+IXIjZTG4S4Q3N8ECLtOEeFMaGQTkXP9m691jI53Y7KySxUSbnCGB69d1LSygJrm
        XEW0rHUPtdzMhyrN1xhvsltYDqGYOHc5mbmpKi7lBXuCuU39szSOfEr6RAG5y/uFle10/v
        uPllq0BkIX9+qAPqnun60k0v+bpHG7E2t1krt4QjfLaA47h+Xu3LzaopVHTv9G5J/NLyUv
        +hI23jDAmMZt2//cWC2l3UyszMyXCls0IGc55F5ZaD2BhZcjiedxm9yZZhojzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693989588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eFmqC5u50JG2Uz7+UhHXczfuq95iqOFCqYRyS0Rau4g=;
        b=G86I6RydyQAC2rrDCCBj6+x/pHC/5Yfx5aojMJmby041WNER9RVbJ3jOxmdZMQ1JzGKYDw
        La9UfyeTeKsBZNBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
        "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
        "linyunsheng@huawei.com" <linyunsheng@huawei.com>
Subject: Re: RE: [EXT] Re: [PATCH net v1] octeontx2-pf: Fix page pool cache
 index corruption.
Message-ID: <20230906083943.BsCvyHew@linutronix.de>
References: <20230906033926.3663659-1-rkannoth@marvell.com>
 <20230906080831.k5HXMqlN@linutronix.de>
 <MWHPR1801MB191826BCB156AB7ADA1F6AF3D3EFA@MWHPR1801MB1918.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MWHPR1801MB191826BCB156AB7ADA1F6AF3D3EFA@MWHPR1801MB1918.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-06 08:24:53 [+0000], Ratheesh Kannoth wrote:
> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Subject: [EXT] Re: [PATCH net v1] octeontx2-pf: Fix page pool cache index
> > corruption.
> > 
> > > +	napi_schedule(wrk->napi);
> > 
> > This will delay NAPI until "some random point in the future" for instance if an
> > interrupt on _this_ CPU fires. You only set the softirq state and never enforce
> > it here. This works as intended if invoked from an IRQ but this here a worker/
> > process context.
> ACK.  Do we need to be so precise here ? Anyway we are short of rx buffers and want to schedule NAPI after some time 
> (in delayed workqueue) to recheck on rx buffers.  Softirq state will be checked even on timer interrupt returns, right ?.  I was thinking 
> Case - what will happen if workqueue never got a chance to run if system is stressed with interrupts. 

As of this patch, the timer will wake the worker and worker will
schedule NAPI. (The timer CPU and the worker CPU can be different.)
If nothing else happens the CPU, which run the worker, will go idle.
With NO_HZ enabled you should see warning that the CPU is going idle
with pending softirqs.
I prefer to be precise what is going on so there are no surprises.

If the CPU is stressed with interrupts then it is probably busy enough
and not running the worker to ask for memory (which it did not have
earlier) is probably the smallest problem.

I'm not against the worker (with the extra steps) but I prefer to have
napi schedule done properly.

> > You can either put local_bh_disable()/enable() around napi_schedule() or
> > use it from a timer callback and skip the worker.
> Switching to  a timer callback makes sense. 

oki.

> -Ratheesh

Sebastian
