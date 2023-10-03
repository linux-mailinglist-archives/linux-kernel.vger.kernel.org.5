Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0A37B6EB2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbjJCQhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjJCQhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:37:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A98291
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=P3cPei9YxX4qgpcsLzLws2Uh1NkAJw3l53FNhfAPm/8=; b=bf8OCuafodVOeSW48BMuiQYFDE
        cJ1v6aN5hXAVbNDu5ySUbfm26cmVWalT4DThd5NU9R/cm/C1mJysh7OUPwgRuyUWAm6IgLBQq5wR6
        xwbXFonfwdc3kDZ5PcPq039awCeYjCfV9J8ZOi5QKBpJ4vKVYCctce/Rt0oIZeN/+VYPdBEdM3ptO
        +hRmNZDZWTqMYAgrdGw3zpcsTrWztrvlViU7T2m8H5aonMQJdGGGdxbikGUX9JcefTkkltRGPwJfP
        3gjW4FmDYsbFk6kPz7eujXNErzchinjtWbHullW/teAtymZ+pw6TbsSeN5okuAvIP4y7CTC5k982S
        E0VfuSow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qniOe-00G17x-1u; Tue, 03 Oct 2023 16:37:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B146B300348; Tue,  3 Oct 2023 18:37:19 +0200 (CEST)
Date:   Tue, 3 Oct 2023 18:37:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     Ingo Molnar <mingo@kernel.org>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v4] sched/rt: move back to RT_GROUP_SCHED and rename it
 child
Message-ID: <20231003163719.GG1539@noisy.programming.kicks-ass.net>
References: <20230803050317.2240948-1-yajun.deng@linux.dev>
 <ZRvkM1lxsTrHb2Ox@gmail.com>
 <93aa2ee6-3ee4-0129-7160-d3684ba67f56@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93aa2ee6-3ee4-0129-7160-d3684ba67f56@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 10:55:50PM +0800, Yajun Deng wrote:

> @Peter, I think I split up this patch into 2 separate patches:
> 
>          sched/rt: Introduce for_each_sched_rt_entity_back() & use it

Why ?? Having that macro makes no sense what so ever. You can't use it,
unless you set up the back pointers first. It is not a self contained
piece of functionality.

>         sched/rt: Move sched_rt_entity::back to under the
> CONFIG_RT_GROUP_SCHED block

This one sure.
