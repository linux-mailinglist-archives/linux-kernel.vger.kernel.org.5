Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AE57DDDF7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjKAI6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 04:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjKAI6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 04:58:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BB3DE
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 01:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p+Hzf1G4MrQChfuvGHTFD7yyXXUPbhrvdydTfbMgYsY=; b=n8+lcZVbqnccHQSYMIXt6GJgEl
        +M5EwPkhPp1sbxGoAoHY1ozQMT/mCr/QW+D8gQBXxDjV5XIjy9CRE0RQHbPyINAnTGf+5dkr1/f4w
        NojNQ0aIwCp2vMncdvu3mUaqWDdQF35JvDPJadMbffEjvNKArROF3fdDohs4bHZh/+BGcHobNC460
        9ZiQc48j1zkae3tyAOnimJ1lehWpMAIHltbztrbqTI6/9CPkzd4DfixpB9AluKyx+DUFh2Vc5ZIQT
        tgrmBKnM7oq1fmNqYiLRuQ3lr+xOm/SZ39QKgwE/x+nVXuV5M10hbxB/YDBM+v4EfH73ROA4EH71e
        qsFUAFog==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qy733-005bGH-3C;
        Wed, 01 Nov 2023 08:58:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 99E553002AF; Wed,  1 Nov 2023 09:58:01 +0100 (CET)
Date:   Wed, 1 Nov 2023 09:58:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peng Liang <tcx4c70@gmail.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com
Subject: Re: [PATCH] sched/fair: remove 2 early returns
Message-ID: <20231101085801.GI15024@noisy.programming.kicks-ass.net>
References: <20231026123721.957154-1-tcx4c70@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026123721.957154-1-tcx4c70@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 08:37:20PM +0800, Peng Liang wrote:
> After commit 5e963f2bd465 ("sched/fair: Commit to EEVDF"), the 2 early
> returns in entity_tick can be removed safely.

Right, so I still need to go through the whole hrtick thing. I suspect
there's more to clean up / fix.

For exapmle, I don't think hrtick_update() still makes sense.

As to the patch at hand, since slices are now fully controlled through
update_curr() -> update_deadline(), I suspect we can clear out more.

OTOH, we have the problem where rq-clock and wall-time are not running
at the same rate, so hrtick might come in early, so that's something to
look into.

So I don't mind this patch per-se, but I do think there's far more work
to be done here.
