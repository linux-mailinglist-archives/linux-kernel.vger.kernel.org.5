Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17A27E3ABA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbjKGLEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjKGLEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:04:09 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B04DF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 03:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gy5Jbs+NIP1gVGy4GZkq12NQ/3J4vmTL2CTWxDwi8JQ=; b=hWK1itxPmRnBXF1fA2SGNUQ+Wf
        U23JmF6Rlt8qaZPWt9jHRCHcENrXMJIS5+JA9B1iK27D/odvWVscqrljpoh7XQzsJ7hIP4P2luOvI
        yisWhPvzYFXOiBwyvwUQOH50PV9aizBsUdVP4Q6uWYfnG/D2pnZ/rewbiwp6XvxLo5Vm2hrtb3MPC
        IAhZ15qBP1JJVWQXFhhVuVUcnXZsAwBO2lfAIuMr3O9tb3uu0gpTsSTN55DeW6WncN5R9yDsfBiDl
        uEGwBugeMmgh1UeDzs+7XXS2uSokxtSQAGGwMaB+cN0Xx0tgymC3oX/QEwPgdYXyCgI9WWJz/KxPQ
        t+dtSukA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r0Jrk-00BxQk-07;
        Tue, 07 Nov 2023 11:03:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id A8F1630049D; Tue,  7 Nov 2023 12:03:27 +0100 (CET)
Date:   Tue, 7 Nov 2023 12:03:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Barry Song <21cnbao@gmail.com>,
        Benjamin Segall <bsegall@google.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Mike Galbraith <efault@gmx.de>,
        Qais Yousef <qyousef@layalina.io>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Youssef Esmat <youssefesmat@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] sched/eevdf: Sort the rbtree by virtual deadline
Message-ID: <20231107110327.GU8262@noisy.programming.kicks-ass.net>
References: <20231107090510.71322-1-wuyun.abel@bytedance.com>
 <20231107090510.71322-3-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107090510.71322-3-wuyun.abel@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 05:05:08PM +0800, Abel Wu wrote:

> Sort the task timeline by virtual deadline and keep the min_vruntime
> in the augmented tree, so we can avoid doubling the worst case cost
> and make full use of the cached leftmost node to enable O(1) fastpath
> picking in next patch.

Another very good patch, just a note:

> This patch also cleans up the unused max_vruntime() and adjusts pos
> for some functions.

There's this thing about saying 'this patch' in Changelogs, per
definition the Changelog is about 'this patch' so saying it is a bit
redundant.

It even gets mentioned in the Documentation on submitting patches
somewhere.

But what I care about more is this patch doing extra unrelated things,
this should be split out.
