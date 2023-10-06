Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836D17BB566
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 12:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjJFKja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 06:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjJFKj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 06:39:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DBD83
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 03:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dmvRw+yvwE3hDMa2FlYVDcmMXmrtPK4ScEPNaTZtedY=; b=l/vkp/bywVwAMaTqASXH76xnLT
        rGrEh3C4Lj+xiw24MMQa8JUiZHNowp2T20W6wByepFE6qP5JDjOnzdv6FU+mp2rWLvyGKriDsYIVe
        6BHLAWoYH4C7qOZrldflTDtbj3akjD/vQqKjHvuaGvY3AyYtzq9MZHivMTNyX6cIFEZ869FY3UZTa
        Ua/wDOcO0Ff2Jec74ebCV1QuXJJQA/yTFd4N0t24Zm5D2k63FviQbZ+43Db20sjMMEEbjgfJwWk5R
        NOJf1Zp7qtxsBk3rl+a8PbTdTme9LLs4koaSRYZmzMr6bLE4RdsvF7laUk2XHw07e0zJd9ebDcpIV
        TPUXE4tg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qoiEV-00EpAw-1Z; Fri, 06 Oct 2023 10:38:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B205D300392; Fri,  6 Oct 2023 12:38:58 +0200 (CEST)
Date:   Fri, 6 Oct 2023 12:38:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/3] sched/nohz: Remove weird error handling from
 find_new_ilb()
Message-ID: <20231006103858.GB36277@noisy.programming.kicks-ass.net>
References: <20231006102518.2452758-1-mingo@kernel.org>
 <20231006102518.2452758-4-mingo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006102518.2452758-4-mingo@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 12:25:18PM +0200, Ingo Molnar wrote:
> find_new_ilb() returns nr_cpu_ids on failure - which is a weird
> choice in itself: not only is it a global variable, it is
> a +1 out of bounds CPU index...

FWIW this is what all the cpumask bitops return when they've exhausted
the mask. Eg. no bits left set etc..
