Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED24678DF57
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243508AbjH3TU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343977AbjH3RoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:44:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E238F193;
        Wed, 30 Aug 2023 10:44:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693417444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dgT0AIDPZgl26tMkDdsBHDsxRu9I3n2FZzYpBP7cGCg=;
        b=29k7LTWIm9DMq2cvAp585AIxhEGIlsLyKObcUcw/Ftj6Gnb0JxrNeCsKWYPEhC5jBGlluy
        TTN4P7SXPLIYqknzbXC17wdPx7yEzlnl1c+zCuQ4Biy8yx0CyKnXuMqsopo1iELeI3kC/5
        FNZc8mernGKPDlvxSrlRYJ4kAqujsv/INchiysSGWixlqOR91dwiR3ffbzVfVoohifacSV
        srJWRs6jtiHQlM1wlBELCX9We22povOiX2MdiqFM2C/vPavcw9aBiE+kUaPedff10RbcHC
        oaMhY6rgB/tEn65wmX0zlxaM5ZtapDQH5B6CzKO5F9Eb7Az2RBVZI0zQ5En/bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693417444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dgT0AIDPZgl26tMkDdsBHDsxRu9I3n2FZzYpBP7cGCg=;
        b=hTwrnzBqCSxtiJiAB7fbzhJcvQSwOfFyEkhCsz43GY12ZToHHutDY9UB0Sgv+FhnmCgS+P
        0KC25+Gvlqnpa0Bw==
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>,
        Guangwu Zhang <guazhang@redhat.com>,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH V3] lib/group_cpus.c: avoid to acquire cpu hotplug lock
 in group_cpus_evenly
In-Reply-To: <20230818140145.1229805-1-ming.lei@redhat.com>
References: <20230818140145.1229805-1-ming.lei@redhat.com>
Date:   Wed, 30 Aug 2023 19:44:03 +0200
Message-ID: <87edjk5st8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ming!

On Fri, Aug 18 2023 at 22:01, Ming Lei wrote:

> group_cpus_evenly() could be part of storage driver's error handler,
> such as nvme driver, when may happen during CPU hotplug, in which
> storage queue has to drain its pending IOs because all CPUs associated
> with the queue are offline and the queue is becoming inactive. And
> handling IO needs error handler to provide forward progress.
>
> Then dead lock is caused:
>
> 1) inside CPU hotplug handler, CPU hotplug lock is held, and blk-mq's
> handler is waiting for inflight IO
>
> 2) error handler is waiting for CPU hotplug lock
>
> 3) inflight IO can't be completed in blk-mq's CPU hotplug handler because
> error handling can't provide forward progress.
>
> Solve the deadlock by not holding CPU hotplug lock in group_cpus_evenly(),
> in which two stage spreads are taken: 1) the 1st stage is over all present
> CPUs; 2) the end stage is over all other CPUs.

That solves the deadlock, but makes the code racy against a concurrent
hot-add operation which modifies cpu_present_mask. IOW, it introduces a
data race.

The changelog does not explain why this does not matter nor does the
comment.

Thanks,

        tglx


